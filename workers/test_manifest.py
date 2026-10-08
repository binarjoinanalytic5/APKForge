"""Manifest validation tests (runtime twin of the contract gate)."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import pytest

from manifest import (ManifestError, check_manifest, load_manifest,
                      validate_manifest)


def _good():
    return {"name": "probe-tool", "version": "1.2.3",
            "sdk_version": "1.0.0", "license": "Apache-2.0",
            "tool": {"name": "t", "version": "9"},
            "runtime": {"command": ["run"], "timeout_s": 60,
                        "memory_mb": 256, "cpu": 1.0,
                        "network": "none"}}


def test_valid_manifest_passes():
    assert validate_manifest(_good()) == []
    assert check_manifest(_good())["name"] == "probe-tool"


def test_violations_listed():
    assert validate_manifest({})  # all required keys missing
    assert validate_manifest("nope") == \
        ["$: manifest must be a mapping"]
    bad = _good()
    bad["name"] = "Bad Name!"
    assert validate_manifest(bad)
    bad = _good()
    bad["version"] = "1.x"
    assert validate_manifest(bad)
    bad = _good()
    bad["sdk_version"] = "2.0.0"
    assert validate_manifest(bad)
    bad = _good()
    bad["runtime"] = dict(bad["runtime"], timeout_s=99999)
    assert validate_manifest(bad)
    bad = _good()
    bad["runtime"] = dict(bad["runtime"], network="sometimes")
    assert validate_manifest(bad)
    bad = _good()
    del bad["tool"]
    assert validate_manifest(bad)
    with pytest.raises(ManifestError):
        check_manifest({})


def test_load_manifest_roundtrip(tmp_path):
    path = tmp_path / "plugin.yaml"
    path.write_text("name: x1\nversion: 1.0.0\nsdk_version: 1.0.0\n"
                    "license: MIT\ntool: {name: t, version: 1}\n"
                    "runtime: {command: [r], timeout_s: 5,\n"
                    "  memory_mb: 64, cpu: 0.5, network: none}\n")
    manifest = load_manifest(path)
    assert validate_manifest(manifest) == []
    broken = tmp_path / "bad.yaml"
    broken.write_text("[unclosed")
    with pytest.raises(ManifestError):
        load_manifest(broken)
    scalar = tmp_path / "s.yaml"
    scalar.write_text("just a string\n")
    with pytest.raises(ManifestError):
        load_manifest(scalar)
