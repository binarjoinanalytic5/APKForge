"""Update domain logic: versions, channels, manifests, verification.

Stdlib only. Version comparison is numeric per component — never
lexicographic — so 1.10.0 is correctly newer than 1.9.0.
"""
import hashlib
import hmac
import json
import re

CHANNELS = ("STABLE", "BETA", "DEV")
CHANNEL_RANK = {"STABLE": 0, "BETA": 1, "DEV": 2}
RELEASE_TYPES = ("PATCH", "MINOR", "MAJOR", "SECURITY", "HOTFIX")
RELEASE_STATUS = ("draft", "validated", "published", "unpublished")
ARTIFACT_KINDS = ("bundle", "git")

SEMVER = re.compile(
    r"^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)"
    r"(?:[-+][0-9A-Za-z.-]+)?$")
HEX64 = re.compile(r"^[0-9a-fA-F]{64}$")


class UpdateError(ValueError):
    pass


def parse_version(text):
    """Return (major, minor, patch) or raise UpdateError."""
    if not isinstance(text, str):
        raise UpdateError("version must be a string, got %r" % (text,))
    match = SEMVER.search(text.strip())
    if not match:
        raise UpdateError("invalid version %r (want X.Y.Z)" % (text,))
    return tuple(int(part) for part in match.groups())


def compare_versions(left, right):
    """Return -1/0/1 comparing parsed semver tuples (numeric)."""
    parsed_left = parse_version(left)
    parsed_right = parse_version(right)
    if parsed_left < parsed_right:
        return -1
    if parsed_left > parsed_right:
        return 1
    return 0


def version_code(text):
    """Monotonic integer code: major*10000 + minor*100 + patch."""
    major, minor, patch = parse_version(text)
    return major * 10000 + minor * 100 + patch


def channel_allows(system_channel, release_channel):
    """STABLE sees STABLE only; BETA adds BETA; DEV sees everything."""
    try:
        return CHANNEL_RANK[system_channel] >= \
            CHANNEL_RANK[release_channel]
    except KeyError:
        return False


def evaluate(current, latest, minimum=None, mandatory=False):
    """Decide NO_UPDATE / UPDATE_AVAILABLE / MANDATORY_UPDATE.

    current < minimum            → MANDATORY_UPDATE (floor breach)
    current < latest             → MANDATORY_UPDATE if the release is
                                   flagged mandatory, else UPDATE_AVAILABLE
    otherwise                    → NO_UPDATE (equal or newer)
    """
    if minimum is not None and \
            compare_versions(current, minimum) < 0:
        return "MANDATORY_UPDATE"
    comparison = compare_versions(current, latest)
    if comparison < 0:
        return "MANDATORY_UPDATE" if mandatory else "UPDATE_AVAILABLE"
    return "NO_UPDATE"


MANIFEST_FIELDS = {
    "latest_version": "semver",
    "version_code": "code",
    "minimum_supported_version": "semver",
    "release_type": "rtype",
    "channel": "channel",
    "mandatory": "bool",
    "security_update": "bool",
    "release_date": "str",
    "artifact_kind": "kind",
}


def validate_manifest(manifest):
    """Validate a remote update manifest; return it normalized.

    Raises UpdateError listing every problem (fail closed). Bundle
    artifacts additionally require download_url + checksum + signature;
    git artifacts require artifact_ref instead.
    """
    problems = []
    if not isinstance(manifest, dict):
        raise UpdateError("manifest must be an object")
    for field, kind in MANIFEST_FIELDS.items():
        value = manifest.get(field)
        if kind == "semver":
            try:
                parse_version(value)
            except UpdateError:
                problems.append("%s: bad version %r" % (field, value))
        elif kind == "code":
            if not isinstance(value, int) or value < 0:
                problems.append("%s: bad version_code %r"
                                % (field, value))
        elif kind == "rtype":
            if value not in RELEASE_TYPES:
                problems.append("%s: want one of %s" % (field,
                                                        RELEASE_TYPES))
        elif kind == "channel":
            if value not in CHANNELS:
                problems.append("%s: want one of %s" % (field, CHANNELS))
        elif kind == "bool":
            if not isinstance(value, bool):
                problems.append("%s: want true/false" % field)
        elif kind == "str":
            if not isinstance(value, str) or not value:
                problems.append("%s: required string" % field)
        elif kind == "kind":
            if value not in ARTIFACT_KINDS:
                problems.append("%s: want bundle|git" % field)
    try:
        if version_code(manifest.get("latest_version", "")) != \
                manifest.get("version_code"):
            problems.append("version_code does not match latest_version")
    except UpdateError:
        pass  # already reported above
    kind = manifest.get("artifact_kind")
    if kind == "bundle":
        url = manifest.get("download_url", "")
        if not isinstance(url, str) or \
                not re.search(r"^(https|file)://", url):
            problems.append("download_url: want https:// or file://")
        for field in ("checksum", "signature"):
            value = manifest.get(field, "")
            if not isinstance(value, str) or not HEX64.search(value):
                problems.append("%s: want 64 hex chars" % field)
        size = manifest.get("size_bytes", 0)
        if not isinstance(size, int) or size < 0:
            problems.append("size_bytes: want a non-negative integer")
    elif kind == "git":
        ref = manifest.get("artifact_ref", "")
        if not isinstance(ref, str) or not ref:
            problems.append("artifact_ref: required for git releases")
    notes = manifest.get("release_notes", [])
    if not isinstance(notes, list) or not all(
            isinstance(item, str) for item in notes):
        problems.append("release_notes: want a string array")
    if problems:
        raise UpdateError("; ".join(problems))
    normalized = dict(manifest)
    normalized.setdefault("release_notes", [])
    normalized.setdefault("size_bytes", 0)
    return normalized


def sha256_bytes(data):
    return hashlib.sha256(data).hexdigest()


def sha256_file(path):
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for chunk in iter(lambda: handle.read(65536), b""):
            digest.update(chunk)
    return digest.hexdigest()


def verify_checksum(path, expected):
    """True iff the file's SHA-256 matches (constant-time compare)."""
    if not isinstance(expected, str) or not HEX64.search(expected):
        return False
    try:
        actual = sha256_file(path)
    except OSError:
        return False
    return hmac.compare_digest(actual.lower(), expected.lower())


def canonical_json(obj):
    return json.dumps(obj, sort_keys=True, separators=(",", ":"),
                      ensure_ascii=False).encode("utf-8")


def sign_bytes(data, key):
    """HMAC-SHA256 signature (hex). Key = shared update secret.

    Phase 1 uses a symmetric update key (self-hosted distribution);
    asymmetric/cosign verification is the documented Phase-2 step.
    """
    if not key:
        raise UpdateError("no update key configured")
    return hmac.new(key.encode("utf-8"), bytes(data),
                    hashlib.sha256).hexdigest()


def verify_signature(data, signature, key):
    if not key or not isinstance(signature, str) or \
            not HEX64.search(signature):
        return False
    try:
        expected = sign_bytes(data, key)
    except UpdateError:
        return False
    return hmac.compare_digest(expected, signature.lower())


def manifest_signature_payload(manifest):
    """Canonical bytes covered by a manifest signature."""
    payload = {key: value for key, value in manifest.items()
               if key not in ("manifest_signature",)}
    return canonical_json(payload)
