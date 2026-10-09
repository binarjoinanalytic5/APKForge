"""Adaptive env tests (hermetic: no network, injected fakes)."""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from adaptive import env as E  # noqa: E402

TERMUX_ENV = {"PREFIX": "/data/data/com.termux/files/usr",
              "HOME": "/data/data/com.termux/files/home",
              "PATH": "/data/data/com.termux/files/usr/bin",
              "SHELL": "/data/data/com.termux/files/usr/bin/bash"}
LINUX_ENV = {"HOME": "/home/user", "PATH": "/usr/bin:/bin",
             "SHELL": "/bin/bash"}


def test_termux_detection():
    assert E.is_termux(TERMUX_ENV) is True
    assert E.is_termux(LINUX_ENV) is False
    info = E.detect_termux(TERMUX_ENV)
    assert info["termux"] is True
    assert info["prefix"].endswith("usr")
    assert E.detect_termux(LINUX_ENV) == {"termux": False}


def test_distro_termux_never_desktop_linux():
    distro = E.detect_distro(TERMUX_ENV)
    assert distro["id"] == "android-termux"
    assert E.detect_distro(
        LINUX_ENV, os_release_path="/nonexistent").get("id")


def test_parse_os_release():
    values = E.parse_os_release('ID=ubuntu\nVERSION_ID="24.04"\n'
                                'PRETTY_NAME="Ubuntu 24.04"\n')
    assert values["ID"] == "ubuntu"
    assert values["VERSION_ID"] == "24.04"
    assert E.parse_os_release("") == {}


def test_fingerprint_shape_and_stable_hash(tmp_path):
    first = E.fingerprint(tmp_path, env=LINUX_ENV, probe=False)
    second = E.fingerprint(tmp_path, env=LINUX_ENV, probe=False)
    for key in ("os", "os_id", "arch", "libc", "termux",
                "python_version", "managers", "permissions",
                "containers", "network", "fingerprint_hash",
                "ram_mb", "disk"):
        assert key in first, key
    assert first["termux"] is False
    assert first["network"]["reachable"] is None  # no probing
    assert first["fingerprint_hash"] == \
        second["fingerprint_hash"]
    assert len(first["fingerprint_hash"]) == 16
    termux_fp = E.fingerprint(tmp_path, env=TERMUX_ENV,
                              probe=False)
    assert termux_fp["termux"] is True
    assert termux_fp["os_id"] == "android-termux"
    assert termux_fp["fingerprint_hash"] != \
        first["fingerprint_hash"]


def test_capability_profile_mapping(tmp_path):
    fp = E.fingerprint(tmp_path, env=TERMUX_ENV, probe=False)
    profile = E.capability_profile(
        fp, [{"tool": "node", "status": "AVAILABLE",
              "detected": "26.4.0"}])
    assert profile["platform"] == "android-termux"
    assert profile["node"] == "26.4.0"
    assert profile["java"] is None
    assert isinstance(profile["compiler_c"], bool)
    fp2 = E.fingerprint(tmp_path, env=LINUX_ENV, probe=False)
    assert E.capability_profile(fp2)["platform"] in (
        "linux", "macos", "windows", "other")
