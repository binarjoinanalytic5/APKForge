"""Runtime manifest loading + validation (stdlib validation).

The validator below is the runtime twin of the contract-test
validator: it mirrors docs/plugin.schema.json (required keys, name
pattern, sdk const, runtime ranges) and fails closed. Manifest
*parsing* needs PyYAML (a backend runtime dependency); validation
itself is dependency-free.
"""
import re

import yaml

NAME_PATTERN = re.compile(r"^[a-z0-9][a-z0-9-]{1,62}$")
VERSION_PATTERN = re.compile(
    r"^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)"
    r"(-[0-9A-Za-z.-]+)?(\+[0-9A-Za-z.-]+)?$")
REQUIRED_KEYS = ("name", "version", "sdk_version", "tool", "runtime",
                 "license")
RUNTIME_RANGES = {"timeout_s": (1, 3600), "memory_mb": (64, 16384),
                  "cpu": (0.1, 8.0)}


class ManifestError(ValueError):
    pass


def load_manifest(path):
    """Parse a plugin.yaml file; raise ManifestError when unusable."""
    try:
        with open(path, encoding="utf-8") as handle:
            manifest = yaml.safe_load(handle)
    except Exception as exc:
        raise ManifestError("cannot parse %s: %s" % (path, exc))
    if not isinstance(manifest, dict):
        raise ManifestError("%s: manifest must be a mapping" % path)
    return manifest


def validate_manifest(manifest):
    """Return a list of violations ([] means valid)."""
    errors = []
    if not isinstance(manifest, dict):
        return ["$: manifest must be a mapping"]
    for key in REQUIRED_KEYS:
        if key not in manifest:
            errors.append("$: missing %r" % key)
    name = manifest.get("name", "")
    if not isinstance(name, str) or not NAME_PATTERN.search(name):
        errors.append("$.name: bad plugin name %r" % (name,))
    version = manifest.get("version", "")
    if not isinstance(version, str) or \
            not VERSION_PATTERN.search(version):
        errors.append("$.version: bad version %r" % (version,))
    if manifest.get("sdk_version") != "1.0.0":
        errors.append("$.sdk_version: must be '1.0.0'")
    tool = manifest.get("tool")
    if not isinstance(tool, dict) or not tool.get("name") or \
            not tool.get("version"):
        errors.append("$.tool: needs name + version")
    runtime = manifest.get("runtime")
    if not isinstance(runtime, dict):
        errors.append("$.runtime: must be a mapping")
        return errors
    command = runtime.get("command")
    if not isinstance(command, list) or not command or not all(
            isinstance(item, str) and item for item in command):
        errors.append("$.runtime.command: needs a non-empty string list")
    for key, (low, high) in RUNTIME_RANGES.items():
        value = runtime.get(key)
        if isinstance(value, bool) or \
                not isinstance(value, (int, float)):
            errors.append("$.runtime.%s: must be a number" % key)
        elif not low <= value <= high:
            errors.append("$.runtime.%s: out of range %s..%s"
                          % (key, low, high))
    if runtime.get("network") not in ("none", "loopback", "full"):
        errors.append("$.runtime.network: must be none|loopback|full")
    if not manifest.get("license"):
        errors.append("$.license: required")
    return errors


def check_manifest(manifest):
    """Raise ManifestError listing every violation (fail-closed)."""
    errors = validate_manifest(manifest)
    if errors:
        raise ManifestError("; ".join(errors))
    return manifest
