"""Update + notification domain tests (stdlib core, no HTTP)."""
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))

from app.core.notify import (NotifyError, deliverable, is_critical,  # noqa: E402
                             is_expired, validate)
from app.core.updates import (UpdateError, channel_allows,  # noqa: E402
                              compare_versions, evaluate, parse_version,
                              sha256_bytes, sign_bytes, validate_manifest,
                              verify_checksum, verify_signature,
                              version_code)


def test_parse_and_compare_numeric_not_lexicographic():
    assert parse_version("1.10.0") == (1, 10, 0)
    assert compare_versions("1.10.0", "1.9.0") == 1
    assert compare_versions("1.9.0", "1.10.0") == -1
    assert compare_versions("2.0.0", "2.0.0") == 0
    assert compare_versions("1.4.2", "1.5.0") == -1
    for bad in ("", "1.2", "v1.2.3", "1.2.x", None, 123):
        with pytest.raises(UpdateError):
            parse_version(bad)


def test_version_code_monotonic():
    assert version_code("1.0.0") == 10000
    assert version_code("1.5.0") == 10500
    codes = [version_code(v) for v in
             ("1.9.0", "1.10.0", "1.10.1", "2.0.0")]
    assert codes == sorted(codes)


def test_channel_policy():
    assert channel_allows("STABLE", "STABLE") is True
    assert channel_allows("STABLE", "BETA") is False
    assert channel_allows("STABLE", "DEV") is False
    assert channel_allows("BETA", "STABLE") is True
    assert channel_allows("BETA", "DEV") is False
    assert channel_allows("DEV", "STABLE") is True
    assert channel_allows("DEV", "BETA") is True
    assert channel_allows("DEV", "DEV") is True
    assert channel_allows("STABLE", "NOPE") is False


def test_evaluate_matrix():
    assert evaluate("1.5.0", "1.5.0") == "NO_UPDATE"
    assert evaluate("1.6.0", "1.5.0") == "NO_UPDATE"
    assert evaluate("1.4.2", "1.5.0") == "UPDATE_AVAILABLE"
    assert evaluate("1.4.2", "1.5.0", mandatory=True) == \
        "MANDATORY_UPDATE"
    assert evaluate("1.2.0", "1.5.0", minimum="1.3.0") == \
        "MANDATORY_UPDATE"
    assert evaluate("1.3.0", "1.5.0", minimum="1.3.0") == \
        "UPDATE_AVAILABLE"


def _manifest(**over):
    base = {"latest_version": "1.5.0", "version_code": 10500,
            "minimum_supported_version": "1.3.0",
            "release_type": "MINOR", "channel": "STABLE",
            "mandatory": False, "security_update": False,
            "release_date": "2026-10-08", "artifact_kind": "bundle",
            "download_url": "https://example.test/b.apkforge",
            "checksum": "a" * 64, "signature": "b" * 64,
            "size_bytes": 10, "release_notes": ["faster"]}
    base.update(over)
    return base


def test_manifest_valid_and_normalized():
    out = validate_manifest(_manifest())
    assert out["latest_version"] == "1.5.0"
    git = _manifest(artifact_kind="git", artifact_ref="abc123")
    del git["download_url"]
    del git["checksum"]
    del git["signature"]
    assert validate_manifest(git)["artifact_ref"] == "abc123"


def test_manifest_rejects_everything_bad():
    with pytest.raises(UpdateError):
        validate_manifest("nope")
    bad = _manifest()
    del bad["latest_version"]
    with pytest.raises(UpdateError):
        validate_manifest(bad)
    with pytest.raises(UpdateError):
        validate_manifest(_manifest(latest_version="1.5"))
    with pytest.raises(UpdateError):
        validate_manifest(_manifest(version_code=999))
    with pytest.raises(UpdateError):
        validate_manifest(_manifest(channel="GAMMA"))
    with pytest.raises(UpdateError):
        validate_manifest(_manifest(release_type="MEGA"))
    with pytest.raises(UpdateError):
        validate_manifest(_manifest(mandatory="yes"))
    no_sig = _manifest()
    del no_sig["signature"]
    with pytest.raises(UpdateError):
        validate_manifest(no_sig)
    with pytest.raises(UpdateError):
        validate_manifest(_manifest(checksum="xyz"))
    with pytest.raises(UpdateError):
        validate_manifest(_manifest(
            download_url="ftp://example.test/x"))
    with pytest.raises(UpdateError):
        validate_manifest(_manifest(release_notes="not-a-list"))
    git = _manifest(artifact_kind="git")
    with pytest.raises(UpdateError):
        validate_manifest(git)


def test_checksum_and_signature(tmp_path):
    target = tmp_path / "artifact.bin"
    target.write_bytes(b"0123456789abcdef")
    digest = sha256_bytes(b"0123456789abcdef")
    assert verify_checksum(target, digest) is True
    assert verify_checksum(target, "0" * 64) is False
    assert verify_checksum(target, "not-hex") is False
    assert verify_checksum(tmp_path / "missing", digest) is False
    key = "update-key-for-tests-1234567890"
    sig = sign_bytes(b"0123456789abcdef", key)
    assert len(sig) == 64
    assert verify_signature(b"0123456789abcdef", sig, key) is True
    assert verify_signature(b"tampered........", sig, key) is False
    assert verify_signature(b"0123456789abcdef", sig, "wrong") is False
    assert verify_signature(b"0123456789abcdef", "zz", key) is False
    assert verify_signature(b"0123456789abcdef", sig, "") is False
    with pytest.raises(UpdateError):
        sign_bytes(b"x", "")


def test_notify_domain():
    assert validate("UPDATE_AVAILABLE") == 2
    assert validate("MANDATORY_UPDATE", "critical") == 3
    with pytest.raises(NotifyError):
        validate("SPAM")
    with pytest.raises(NotifyError):
        validate("UPDATE_AVAILABLE", "urgent")
    assert is_critical("MANDATORY_UPDATE", "info") is True
    assert is_critical("SECURITY_UPDATE", "critical") is True
    assert is_critical("SECURITY_UPDATE", "info") is False
    muted = {"system_updates": False, "security_alerts": False}
    assert deliverable("UPDATE_AVAILABLE", "info", muted) is False
    assert deliverable("MANDATORY_UPDATE", "info", muted) is True
    assert deliverable("SECURITY_UPDATE", "critical", muted) is True
    assert deliverable("SECURITY_UPDATE", "info", muted) is False
    assert is_expired("2020-01-01T00:00:00Z",
                      "2026-01-01T00:00:00Z") is True
    assert is_expired("2027-01-01T00:00:00Z",
                      "2026-01-01T00:00:00Z") is False
    assert is_expired(None, "2026-01-01T00:00:00Z") is False
