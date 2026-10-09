"""Maturin Android-API fix: detect, classify, retry isolated, adopt.

Covers: API-level detection (valid/invalid sources), precise
classification (never RUST_MISSING), build-env fingerprinting, the
native_android_api_level strategy (run once, refuse repeats, adopt
on success), fresh-error analysis, and Android wheel verdicts.
"""
import importlib.util
import json
import os
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from adaptive import compat as C  # noqa: E402
from adaptive import recovery as R  # noqa: E402
from adaptive import strategy as S  # noqa: E402

ENGINE = Path(__file__).resolve().parent / "apkforge.py"


@pytest.fixture()
def engine():
    spec = importlib.util.spec_from_file_location("apkforge_api",
                                                  ENGINE)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


@pytest.fixture()
def ctx(engine, tmp_path, monkeypatch):
    monkeypatch.setattr(engine, "GOV", tmp_path / "gov")
    monkeypatch.setattr(engine, "LOGS", tmp_path / "logs")
    return engine.Ctx("api-run", tmp_path / "run.log",
                      json_only=True)


ANDROID_FAIL = (
    "Collecting pkgx\n"
    "  Preparing metadata (pyproject.toml): started\n"
    "  maturin failed\n"
    "  Caused by: Failed to determine Android API level. Please "
    "set the ANDROID_API_LEVEL environment variable.\n"
    "  Failed to build `pydantic-core`\n"
    "  ERROR: Could not build wheels for pydantic-core\n")

HEADER_FAIL = (
    "Collecting pkgx\n"
    "  Building wheel for pkgx (setup.py): started\n"
    "  foo.c:1:10: fatal error: foo.h: No such file or directory\n"
    "  error: command 'cc' failed with exit status 1\n"
    "  Failed to build `pkgx`\n")


def _tools(env_hash="e" * 12):
    return {"tools": {}, "hash": "t" * 16, "env_hash": env_hash}


def _ladder_fp():
    return {"termux": False, "libc": "gnu", "arch_machine": "x86_64",
            "python_version": "3.13.0", "os": "linux",
            "fingerprint_hash": "e" * 12}


def _android_fp():
    return {"termux": True, "libc": "bionic",
            "arch_machine": "aarch64", "os": "Linux",
            "python_version": "3.14.6"}


# -- A. detection ------------------------------------------------------

def test_detect_prefers_valid_env_over_device():
    found = S.detect_android_api_level(
        env={"ANDROID_API_LEVEL": "34"},
        getprop_fn=lambda: "33\n")
    assert found["ok"] is True
    assert found["level"] == 34
    assert found["source"] == "env:ANDROID_API_LEVEL"
    assert found["device_api_level"] == 33


def test_detect_getprop_then_build_prop(tmp_path):
    found = S.detect_android_api_level(
        env={}, getprop_fn=lambda: " 33\n")
    assert (found["ok"], found["level"]) == (True, 33)
    assert found["source"] == "getprop:ro.build.version.sdk"
    prop = tmp_path / "build.prop"
    prop.write_text("ro.build.version.sdk=29\n",
                    encoding="utf-8")
    found = S.detect_android_api_level(
        env={}, getprop_fn=lambda: None,
        build_prop_path=str(prop))
    assert (found["ok"], found["level"]) == (True, 29)
    assert found["source"].startswith("file:")


# -- B. invalid values rejected -----------------------------------------

def test_detect_rejects_invalid_values(tmp_path):
    for bad in ("", "  ", "abc", "33.5", "999", "0", "-1"):
        found = S.detect_android_api_level(
            env={"ANDROID_API_LEVEL": bad},
            getprop_fn=lambda: None,
            build_prop_path=str(tmp_path / "missing"))
        assert found["ok"] is False, bad
        assert found["level"] is None
    assert "getprop" in found["reason"]
    assert "invalid" in S.detect_android_api_level(
        env={"ANDROID_API_LEVEL": "abc"},
        getprop_fn=lambda: None,
        build_prop_path=str(tmp_path / "missing"))["reason"]


# -- D. precise classification ------------------------------------------

def test_android_cause_never_rust_missing():
    classified = R.classify_failure(ANDROID_FAIL)
    assert classified["category"] == "ANDROID_API_LEVEL_MISSING"
    assert classified["package"] == "pydantic-core"
    assert "API level" in classified["root_cause"]
    assert S.extract_signals(ANDROID_FAIL) == []


# -- E. new strategy ordered first ---------------------------------------

def test_api_strategy_ordered_first():
    cands = S.order_candidates(
        {"category": "ANDROID_API_LEVEL_MISSING",
         "package": "pydantic-core"},
        {"termux": True, "provision_ok": False, "offline": False,
         "direct": set(), "alternate_pythons": [], "signals": []})
    ids = [item["id"] for item in cands]
    assert ids[0] == "native_android_api_level"
    assert "native" in ids


# -- fingerprint identity ------------------------------------------------

def test_build_env_fingerprint_identity(tmp_path):
    kw = {"step": "DEPENDENCIES", "strategy": "native",
          "package": None, "version": None,
          "python_version": "3.13.0", "arch": "x",
          "platform": "p", "command": "pip install -r req",
          "requirements_text": "a\n", "toolchain_fp": _tools()}
    base = S.attempt_fingerprint(**kw)
    same = S.attempt_fingerprint(**kw, run_id="r2")
    assert base["attempt_id"] == same["attempt_id"]
    lv33 = S.attempt_fingerprint(
        **kw, build_env={"ANDROID_API_LEVEL": "33"})
    lv34 = S.attempt_fingerprint(
        **kw, build_env={"ANDROID_API_LEVEL": "34"})
    assert len({base["attempt_id"], lv33["attempt_id"],
                lv34["attempt_id"]}) == 3
    legacy = dict(base)
    del legacy["build_env_hash"]
    del legacy["build_env"]
    legacy.update({"category": "X", "result": "failed"})
    path = tmp_path / "ledger.jsonl"
    path.write_text(json.dumps(legacy) + "\n", encoding="utf-8")
    assert S.identical_attempt(path, same) is not None
    assert S.identical_attempt(path, lv33) is None


# -- run() honors env -----------------------------------------------------

def test_run_honors_custom_env(engine, ctx):
    env = dict(os.environ)
    env["APKFORGE_PROBE_VAR"] = "42"
    code, out = engine.run(
        [sys.executable, "-c", "import os; print('v=' + str("
         "os.environ.get('APKFORGE_PROBE_VAR')))"], ctx,
        timeout=60, env=env)
    assert code == 0
    assert "v=42" in out


# -- C+G. pip receives the level; success adopts --------------------------

def test_android_api_strategy_adopted(engine, ctx, tmp_path,
                                      monkeypatch):
    monkeypatch.setenv("ANDROID_API_LEVEL", "34")
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    monkeypatch.setattr(engine._strategy, "probe_toolchain",
                        lambda *argv, **kw: {"tools": {},
                                             "hash": "h"})
    seen = {}

    def fake_run(argv, *rest, **kw):
        if "install" in argv and (kw.get("env") or {}).get(
                "ANDROID_API_LEVEL"):
            seen["api"] = kw["env"]["ANDROID_API_LEVEL"]
            return (0, "ok")
        if "install" in argv:
            return (1, ANDROID_FAIL)
        if "-c" in argv:
            return (0, "import-ok")
        return (0, "")

    monkeypatch.setattr(engine, "run", fake_run)
    result = engine.pip_install_with_recovery(
        ctx, "/nonexistent/python", req, _ladder_fp(),
        {"platform": "linux-x86_64", "compiler_c": True,
         "compiler_rust": True}, ledger, "e" * 12,
        offline=False)
    assert seen.get("api") == "34"
    assert result["venv"].startswith(
        str(tmp_path / "gov" / "venv-candidates"))
    assert result["python"] != "/nonexistent/python"
    kinds = {(entry.get("strategy"), entry.get("result"))
             for entry in ledger.entries()}
    assert ("native", "failed") in kinds
    assert ("native_android_api_level (isolated)", "ok") in kinds


# -- F. identical repeat refused ------------------------------------------

def test_android_api_strategy_refused_when_identical(
        engine, ctx, tmp_path, monkeypatch):
    monkeypatch.setenv("ANDROID_API_LEVEL", "34")
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    monkeypatch.setattr(engine._strategy, "probe_toolchain",
                        lambda *argv, **kw: {"tools": {},
                                             "hash": "h"})

    def fake_run(argv, *rest, **kw):
        if "install" in argv:
            return (1, ANDROID_FAIL)
        if "-c" in argv:
            return (0, "import-ok")
        return (0, "")

    monkeypatch.setattr(engine, "run", fake_run)
    monkeypatch.setattr(engine, "_resolve_version_pick",
                        lambda *argv, **kw: None)
    monkeypatch.setattr(engine._runtime, "select_runtime",
                        lambda *argv, **kw: None)
    monkeypatch.setattr(engine, "_python_for_wheels",
                        lambda *argv, **kw: None)
    with pytest.raises(engine.RecoveryExhausted) as caught:
        engine.pip_install_with_recovery(
            ctx, "/nonexistent/python", req, _ladder_fp(),
            {"platform": "linux-x86_64", "compiler_c": True,
             "compiler_rust": True}, ledger, "e" * 12,
            offline=False)
    info = caught.value.info
    assert info["category"] == "ANDROID_API_LEVEL_MISSING"
    rows = [entry for entry in ledger.entries()
            if entry.get("strategy")
            == "native_android_api_level (isolated)"
            and entry.get("result") == "failed"]
    assert len(rows) == 1
    assert "native_android_api_level (isolated)" in info[
        "skipped_identical"]
    assert any("android api level 34 already failed "
               "identically" in need
               for need in info["needs_you"])


# -- H. fresh error analyzed, old cause dropped ----------------------------

def test_fresh_error_after_api_fix_analyzed(
        engine, ctx, tmp_path, monkeypatch):
    monkeypatch.setenv("ANDROID_API_LEVEL", "34")
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    bare = {"tools": {
        name: {"ok": False, "version": None, "path": None}
        for name in ("rustc", "cargo", "cc", "clang", "gcc")},
        "hash": "h"}
    monkeypatch.setattr(engine._strategy, "probe_toolchain",
                        lambda *argv, **kw: bare)

    def fake_run(argv, *rest, **kw):
        if "install" in argv and (kw.get("env") or {}).get(
                "ANDROID_API_LEVEL"):
            return (1, HEADER_FAIL)
        if "install" in argv:
            return (1, ANDROID_FAIL)
        if "-c" in argv:
            return (0, "import-ok")
        return (0, "")

    monkeypatch.setattr(engine, "run", fake_run)
    monkeypatch.setattr(engine, "_provision_toolchains",
                        lambda *argv, **kw: False)
    monkeypatch.setattr(engine, "_resolve_version_pick",
                        lambda *argv, **kw: None)
    monkeypatch.setattr(engine._runtime, "select_runtime",
                        lambda *argv, **kw: None)
    monkeypatch.setattr(engine, "_python_for_wheels",
                        lambda *argv, **kw: None)
    with pytest.raises(engine.RecoveryExhausted) as caught:
        engine.pip_install_with_recovery(
            ctx, "/nonexistent/python", req, _ladder_fp(),
            {"platform": "linux-x86_64", "compiler_c": True,
             "compiler_rust": True}, ledger, "e" * 12,
            offline=False)
    info = caught.value.info
    assert info["category"] == "COMPILER_MISSING"
    rows = [entry for entry in ledger.entries()
            if entry.get("strategy")
            == "native_android_api_level (isolated)"]
    assert len(rows) == 1
    assert rows[0]["category"] == "COMPILER_MISSING"


# -- Android wheel verdicts --------------------------------------------------

def test_linux_wheels_rejected_on_android():
    fp = _android_fp()
    many = C.parse_wheel_filename(
        "pydantic_core-2.6.0-cp314-cp314-"
        "manylinux_2_17_aarch64.whl")
    assert C.wheel_matches(many, "cp314", (3, 14), fp) is False


def test_android_tagged_wheel_accepted():
    fp = _android_fp()
    wheel = C.parse_wheel_filename(
        "pydantic_core-2.6.0-cp314-cp314-android_33_aarch64.whl")
    assert C.wheel_matches(wheel, "cp314", (3, 14), fp) is True


def test_assess_notes_linux_rejection_and_records_source():
    fp = _android_fp()
    release = {"version": "2.6.0", "requires_python": ">=3.8",
               "files": [
                   {"filename": "pydantic_core-2.6.0-cp314-"
                    "cp314-manylinux_2_17_aarch64.whl",
                    "yanked": False, "sha256": "abc"},
                   {"filename": "pydantic_core-2.6.0.tar.gz",
                    "yanked": False, "sha256": None}]}
    verdict = C.assess_package(
        {"name": "pydantic-core", "spec": ""}, fp,
        lambda name, version=None: release)
    assert verdict["status"] == "NEEDS_BUILD"
    assert verdict["source"] == "pypi"
    assert verdict["external_android_wheels"] == []
    assert any("rejected on android" in note
               for note in verdict["notes"])


def test_external_allowlist_empty_by_default(monkeypatch):
    assert C.ANDROID_WHEEL_SOURCES == ()
    assert C.android_wheel_candidates(
        "pydantic-core", "2.6.0", "cp314", "aarch64") == []
    http = [{"name": "x", "index_url": "http://example.invalid/",
             "packages": ["pydantic-core"]}]
    assert C.android_wheel_candidates(
        "pydantic-core", "2.6.0", "cp314", "aarch64",
        sources=http) == []


def test_external_allowlist_verifies_tags(monkeypatch):
    html = (
        '<a href="pydantic_core-2.6.0-cp314-cp314-android_33_'
        'aarch64.whl#sha256=deadbeef">w</a>'
        '<a href="pydantic_core-2.6.0-cp314-cp314-manylinux_2_17_'
        'aarch64.whl">w</a>')

    class FakeResp:
        def __enter__(self):
            return self

        def __exit__(self, *exc):
            return False

        def read(self):
            return html.encode("utf-8")

    monkeypatch.setattr(C.urllib.request, "urlopen",
                        lambda req, timeout=20: FakeResp())
    sources = [{"name": "demo", "index_url":
                "https://example.invalid/simple",
                "packages": ["pydantic-core"]}]
    found = C.android_wheel_candidates(
        "pydantic-core", "2.6.0", "cp314", "aarch64",
        sources=sources)
    assert found == [{"filename": "pydantic_core-2.6.0-cp314-"
                      "cp314-android_33_aarch64.whl",
                      "sha256": "deadbeef", "source": "demo"}]
    assert C.android_wheel_candidates(
        "other", "1.0", "cp314", "aarch64",
        sources=sources) == []
