"""Runtime resolver tests: discovery, selection, mirrors, records."""
import json
import os
import stat
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from adaptive import runtime as T  # noqa: E402


def _stub_python(directory, name, version):
    exe = Path(directory) / name
    exe.write_text(
        "#!/bin/sh\n"
        'if [ "$1" = "--version" ]; then echo "Python %s"; exit 0; fi\n'
        'if [ "$1" = "-m" ] && [ "$2" = "pip" ]; then '
        'echo "pip 26.0 from x (python %s)"; exit 0; fi\n'
        'if [ "$1" = "-m" ] && [ "$2" = "ensurepip" ]; then '
        'echo "ensurepip ok"; exit 0; fi\n'
        "exit 1\n" % (version, version), encoding="utf-8")
    exe.chmod(exe.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP
              | stat.S_IXOTH)
    return str(exe)


def test_find_pythons_discovers_and_sorts(tmp_path, monkeypatch):
    bindir = tmp_path / "bin"
    bindir.mkdir()
    _stub_python(bindir, "python3.11", "3.11.9")
    _stub_python(bindir, "python3.12", "3.12.4")
    monkeypatch.setenv("PATH", str(bindir) + os.pathsep + "SELF-CHECK-SECURITY-TOKEN-REDACTED--PotentialSecretsLeakage--IfThisIsNotASecretPleaseIgnore",
                     prepend=os.pathsep)
    found = T.find_pythons()
    versions = [item["version"] for item in found
                if str(bindir) in item["exe"]]
    assert versions == [(3, 12), (3, 11)]


def test_find_pythons_skips_running_version(tmp_path, monkeypatch):
    bindir = tmp_path / "bin"
    bindir.mkdir()
    current = "%d.%d" % T.CURRENT
    _stub_python(bindir, "python%s" % current,
                 current + ".0")
    monkeypatch.setenv("PATH", str(bindir), prepend=os.pathsep)
    found = T.find_pythons()
    assert all(str(bindir) not in item["exe"] for item in found)


def test_verify_python_ok_and_broken(tmp_path):
    bindir = tmp_path / "bin"
    bindir.mkdir()
    exe = _stub_python(bindir, "python3.12", "3.12.4")
    assert T.verify_python(exe)["ok"] is True
    assert T.verify_python(str(bindir / "missing"))["ok"] is False


def test_select_runtime_requires_strictly_better():
    reqs = [{"name": "pydantic-core"}]

    def assess(req, trial):
        minor = int(trial["python_version"].split(".")[1])
        return {"status": "WHEEL_OK" if minor <= 12
                else "NEEDS_BUILD"}

    fp = {"python_version": "3.14.6"}
    cands = [{"exe": "/x/python3.12", "version": (3, 12)},
             {"exe": "/x/python3.11", "version": (3, 11)}]
    real_verify = T.verify_python
    T.verify_python = lambda exe: {"ok": True}
    try:
        best = T.select_runtime(cands, 0.0, reqs, fp, assess)
        assert best["exe"] == "/x/python3.12"
        assert best["coverage"] == 1.0
        assert T.select_runtime(cands, 1.0, reqs, fp,
                                assess) is None
    finally:
        T.verify_python = real_verify


def test_venv_for_and_record_roundtrip(tmp_path):
    assert T.venv_for(tmp_path, None).name == ".venv"
    assert T.venv_for(tmp_path, (3, 12)).name == ".venv-py312"
    gov = tmp_path / "gov"
    first = {"python": "/x", "version": "3.14.6", "venv": ".venv"}
    second = {"python": "/y", "version": "3.12.0",
              "venv": ".venv-py312"}
    T.record_runtime(gov, first)
    payload = T.record_runtime(gov, second)
    assert payload["current"] == second
    assert payload["previous"] == first
    assert T.read_runtime(gov)["current"] == second


def test_mirror_choice_and_apply(tmp_path):
    prefix = tmp_path / "prefix"
    group = prefix / "etc" / "termux" / "mirrors" / "main"
    group.mkdir(parents=True)
    (group / "a").write_text("https://a.example/apt/termux-main\n")
    (group / "b").write_text("deb https://b.example/x stable main\n")
    sources = prefix / "etc" / "apt" / "sources.list"
    sources.parent.mkdir(parents=True, exist_ok=True)
    sources.write_text(
        "deb https://a.example/apt/termux-main stable main\n")
    assert T.current_base(prefix) == \
        "https://a.example/apt/termux-main"
    assert T.choose_mirror(prefix, []) == \
        "https://a.example/apt/termux-main"
    assert T.choose_mirror(
        prefix, ["https://a.example/apt/termux-main"]) == \
        "https://b.example/x"
    ok, _ = T.apply_mirror(prefix, "https://b.example/x")
    assert ok is True
    assert "https://b.example/x" in sources.read_text()
    assert (prefix / "etc" / "apt" /
            "sources.list.apkforge-bak").is_file()


def test_mirror_signals_and_provision_names():
    assert T.mirror_failed_signals(
        "Err:1 https://m stable InRelease\n  Failed to fetch 404")
    assert not T.mirror_failed_signals("all good")
    assert T.provision_names((3, 12), True) == ["python3.12"]
    assert "python3.12-venv" in T.provision_names((3, 12), False)
