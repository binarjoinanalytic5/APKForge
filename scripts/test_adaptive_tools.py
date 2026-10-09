"""Adaptive tools tests (hermetic; fake binaries in tmp PATH)."""
import os
import stat
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from adaptive import tools as T  # noqa: E402


def _spec(tool, kind="required", want="any", minimum=None,
          **extra):
    spec = {"tool": tool, "kind": kind, "want": want,
            "detect": [tool, "--version"], "min": minimum,
            "method": "test", "source": "test"}
    spec.update(extra)
    return spec


def _fake_bin(tmp_path, name, output, code=0):
    path = tmp_path / name
    path.write_text("#!/bin/sh\necho '%s'\nexit %d\n"
                    % (output, code), encoding="utf-8")
    path.chmod(path.stat().st_mode | stat.S_IEXEC)
    return str(path)


def test_parse_version_parity():
    assert T.parse_version("v20.20.2") == (20, 20, 2)
    assert T.parse_version("Python 3.13.1") == (3, 13, 1)
    assert T.parse_version("openjdk 11.0.9") == (11, 0, 9)
    assert T.parse_version("no digits here") is None
    assert T.parse_version("") is None


def test_probe_python_and_missing():
    probed = T.probe(_spec("python3"))
    assert probed["path"] == sys.executable
    assert probed["detected"] == tuple(sys.version_info[:3])
    missing = T.probe(_spec("definitely-not-a-tool-xyz"))
    assert missing["path"] is None
    assert missing["detected"] is None


def test_classify_matrix():
    spec = _spec("x", minimum=(2, 0))
    assert T.classify(spec, {"path": None}) == "MISSING"
    assert T.classify(
        spec, {"path": "/b/x", "detected": None,
               "returncode": 1}) == "BROKEN"
    assert T.classify(
        spec, {"path": "/b/x", "detected": (1, 9),
               "returncode": 0}) == "OUTDATED"
    assert T.classify(
        spec, {"path": "/b/x", "detected": (2, 0),
               "returncode": 0}) == "AVAILABLE"
    assert T.classify(
        _spec("d", needs_libc="glibc"),
        {"path": "/b/d", "detected": (1, 0), "returncode": 0},
        libc="bionic") == "INCOMPATIBLE"
    assert T.classify(
        _spec("d", not_on=("android-termux",)),
        {"path": "/b/d", "detected": (1, 0), "returncode": 0},
        platform_name="android-termux") == "NOT_APPLICABLE"


def test_inventory_probes_each_tool_exactly_once(
        tmp_path, monkeypatch):
    _fake_bin(tmp_path, "tool-a", "tool-a 1.2.3")
    _fake_bin(tmp_path, "tool-b", "tool-b 4.5.6")
    monkeypatch.setenv("PATH",
                       str(tmp_path) + os.pathsep +
                       os.environ.get("PATH", ""))
    calls = []
    real_run = T._run_version

    def counting(argv, timeout=10):
        calls.append(tuple(argv))
        return real_run(argv, timeout=timeout)

    monkeypatch.setattr(T, "_run_version", counting)
    specs = [_spec("tool-a"), _spec("tool-b"),
             _spec("tool-missing-xyz")]
    rows = T.inventory(specs)
    assert [row["tool"] for row in rows] == [
        "tool-a", "tool-b", "tool-missing-xyz"]
    assert [row["status"] for row in rows] == [
        "AVAILABLE", "AVAILABLE", "MISSING"]
    assert rows[0]["detected"] == "1.2.3"
    assert len(calls) == 2  # one subprocess per present tool
    summary = T.summarize(rows)
    assert summary["required_missing"] == ["tool-missing-xyz"]
