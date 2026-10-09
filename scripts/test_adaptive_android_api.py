"""Maturin Android-API fix: detect, classify, retry isolated, adopt.

Covers: API-level detection (valid/invalid sources), precise
classification (never RUST_MISSING), build-env fingerprinting, the
native_android_api_level strategy (run once, refuse repeats, adopt
on success), fresh-error analysis, and Android wheel verdicts.
"""
import hashlib
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
    assert ids[:2] == ["android_prebuilt_wheel",
                       "native_android_api_level"]
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
        if "-c" in argv and "layer1" in argv[-1]:
            layer = (kw.get("env") or {}).get(
                "ANDROID_API_LEVEL", "")
            return (0, json.dumps(
                {"layer1": layer, "layer2": layer,
                 "want": (kw.get("env") or {}).get(
                     "APKF_WANT_API", "")}))
        if "install" in argv and argv[0] == "/nonexistent/python":
            return (1, ANDROID_FAIL)
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
        if "-c" in argv and "layer1" in argv[-1]:
            layer = (kw.get("env") or {}).get(
                "ANDROID_API_LEVEL", "")
            return (0, json.dumps(
                {"layer1": layer, "layer2": layer,
                 "want": (kw.get("env") or {}).get(
                     "APKF_WANT_API", "")}))
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
    monkeypatch.setattr(
        engine, "_redetect_compilers",
        lambda profile: profile.update({"compiler_c": True,
                                        "compiler_rust": True}))
    with pytest.raises(engine.RecoveryExhausted) as caught:
        engine.pip_install_with_recovery(
            ctx, "/nonexistent/python", req, _ladder_fp(),
            {"platform": "linux-x86_64", "compiler_c": True,
             "compiler_rust": True}, ledger, "e" * 12,
            offline=False)
    info = caught.value.info
    assert info["category"] == "ENV_PROPAGATION_FAILURE"
    rows = [entry for entry in ledger.entries()
            if entry.get("strategy")
            == "native_android_api_level (isolated)"
            and entry.get("result") == "failed"]
    assert len(rows) == 1
    assert "native_android_api_level (isolated)" in info[
        "skipped_identical"]
    assert any("android api level 34: already failed "
               "identically" in need
               for need in info["needs_you"])
    assert any("cannot stage maturin" in need
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
        if "-c" in argv and "layer1" in argv[-1]:
            layer = (kw.get("env") or {}).get(
                "ANDROID_API_LEVEL", "")
            return (0, json.dumps(
                {"layer1": layer, "layer2": layer,
                 "want": (kw.get("env") or {}).get(
                     "APKF_WANT_API", "")}))
        if "install" in argv and argv[0] == "/nonexistent/python":
            return (1, ANDROID_FAIL)
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


# -- legacy memory restoration (Test A) -----------------------------------

def _legacy_row(tools, command, req_text, log_path):
    row = S.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.13.0", "x86_64",
        "linux-x86_64", command, req_text, tools,
        run_id="old-run")
    del row["build_env_hash"]
    del row["build_env"]
    row.update({"category": "RUST_BUILD_FAILURE",
                "result": "failed", "log": str(log_path),
                "detail": ANDROID_FAIL[-500:],
                "ts": "2026-10-09T01:02:19Z"})
    return row


def test_restore_reclassifies_legacy_log(tmp_path):
    log = tmp_path / "pip-old-native.log"
    log.write_text(ANDROID_FAIL, encoding="utf-8")
    ledger = tmp_path / "ledger.jsonl"
    ledger.write_text(json.dumps(_legacy_row(
        _tools(), "pip install -r req", "pkgx>=1\n", log))
        + "\n", encoding="utf-8")
    restored = S.restore_failure_context(ledger)
    assert restored["category"] == "ANDROID_API_LEVEL_MISSING"
    assert restored["diagnosed_package"] == "pydantic-core"
    assert restored["target_package"] is None
    assert restored["reclassified"] is True
    assert restored["evidence_source"] == "log"
    assert "RUST_BUILD_FAILURE" in restored["reclassify_note"]


def test_restore_falls_back_to_detail(tmp_path):
    ledger = tmp_path / "ledger.jsonl"
    ledger.write_text(json.dumps(_legacy_row(
        _tools(), "pip install -r req", "pkgx>=1\n",
        tmp_path / "gone.log")) + "\n", encoding="utf-8")
    restored = S.restore_failure_context(ledger)
    assert restored["category"] == "ANDROID_API_LEVEL_MISSING"
    assert restored["diagnosed_package"] == "pydantic-core"
    assert restored["evidence_source"] == "detail"


def test_restore_keeps_stored_without_evidence(tmp_path):
    row = _legacy_row(_tools(), "pip install -r req",
                      "pkgx>=1\n", tmp_path / "gone.log")
    row["detail"] = "boom"
    ledger = tmp_path / "ledger.jsonl"
    ledger.write_text(json.dumps(row) + "\n", encoding="utf-8")
    restored = S.restore_failure_context(ledger)
    assert restored["category"] == "RUST_BUILD_FAILURE"
    assert restored["diagnosed_package"] is None
    assert restored["reclassified"] is False


def test_reclassify_note_recorded_once(tmp_path):
    ledger = tmp_path / "ledger.jsonl"
    ledger.write_text("", encoding="utf-8")
    assert S.record_reclassification(
        ledger, "abc", "RUST_BUILD_FAILURE",
        "ANDROID_API_LEVEL_MISSING", "pydantic-core") is True
    assert S.record_reclassification(
        ledger, "abc", "RUST_BUILD_FAILURE",
        "ANDROID_API_LEVEL_MISSING", "pydantic-core") is False
    rows = [json.loads(line) for line in ledger.read_text(
        encoding="utf-8").splitlines()]
    assert len(rows) == 1
    assert rows[0]["kind"] == "reclassify"
    assert S.last_failure(ledger) == {}


def test_last_failure_carries_diagnosis(tmp_path):
    row = S.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.13.0", "x86_64",
        "linux-x86_64", "pip install -r req", "pkgx>=1\n",
        _tools(), run_id="r1")
    row.update({"category": "X", "result": "failed",
                "diagnosed_package": "pydantic-core",
                "detail": "d", "log": "", "ts": ""})
    ledger = tmp_path / "ledger.jsonl"
    ledger.write_text(json.dumps(row) + "\n", encoding="utf-8")
    memory = S.last_failure(ledger)
    assert memory["diagnosed_package"] == "pydantic-core"
    assert memory["detail"] == "d"


# -- literal user-log replay (Tests B, C, F, G, H) --------------------------

def test_legacy_memory_recovers_without_exhaustion(
        engine, ctx, tmp_path, monkeypatch):
    """The dd1dc33 run, replayed: legacy native row with
    RUST_BUILD_FAILURE and no target package must execute the
    android repair, never exhaust immediately."""
    monkeypatch.setenv("ANDROID_API_LEVEL", "34")
    log = tmp_path / "pip-old-native.log"
    log.write_text(ANDROID_FAIL, encoding="utf-8")
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    tools = engine._strategy.toolchain_fingerprint()
    tools["env_hash"] = "e" * 12
    row = engine._strategy.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.13.0", "x86_64",
        "linux-x86_64", "pip install -r %s" % req, "pkgx>=1\n",
        tools, run_id="old-run")
    del row["build_env_hash"]
    del row["build_env"]
    row.update({"category": "RUST_BUILD_FAILURE",
                "result": "failed", "log": str(log),
                "detail": ANDROID_FAIL[-500:],
                "ts": "2026-10-09T01:02:19Z"})
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    ledger.record_row(row)
    seen = {}

    def fake_run(argv, *rest, **kw):
        if "-c" in argv and "layer1" in argv[-1]:
            layer = (kw.get("env") or {}).get(
                "ANDROID_API_LEVEL", "")
            return (0, json.dumps(
                {"layer1": layer, "layer2": layer,
                 "want": (kw.get("env") or {}).get(
                     "APKF_WANT_API", "")}))
        if "install" in argv and argv[0] == "/nonexistent/python":
            return (1, ANDROID_FAIL)
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
    monkeypatch.setattr(engine, "_resolve_version_pick",
                        lambda *argv, **kw: None)
    monkeypatch.setattr(engine._runtime, "select_runtime",
                        lambda *argv, **kw: None)
    monkeypatch.setattr(engine, "_python_for_wheels",
                        lambda *argv, **kw: None)
    result = engine.pip_install_with_recovery(
        ctx, "/nonexistent/python", req, _ladder_fp(),
        {"platform": "linux-x86_64", "compiler_c": True,
         "compiler_rust": True}, ledger, "e" * 12,
        offline=False)
    assert result["python"] != "/nonexistent/python"
    assert "exe" in result
    assert seen.get("api") == "34"
    rows = [entry for entry in ledger.entries()
            if entry.get("kind") != "reclassify"]
    by_fp = {}
    for entry in rows:
        by_fp.setdefault(entry.get("attempt_id"), []).append(
            entry)
    assert all(len(group) == 1 for group in by_fp.values())
    kinds = {(entry.get("strategy"), entry.get("result"))
             for entry in rows}
    assert ("native", "failed") in kinds
    assert ("native_android_api_level (isolated)", "ok") in kinds
    notes = [entry for entry in ledger.entries()
             if entry.get("kind") == "reclassify"]
    assert len(notes) == 1
    assert notes[0]["new_category"] == \
        "ANDROID_API_LEVEL_MISSING"


# -- prebuilt wheel adoption (Test G, wheel path) ----------------------------

def test_android_wheel_strategy_adopted(engine, ctx, tmp_path,
                                        monkeypatch):
    fp = {"termux": True, "libc": "bionic",
          "arch_machine": "aarch64", "python_version": "3.14.6",
          "os": "linux", "fingerprint_hash": "e" * 12}
    log = tmp_path / "pip-old-native.log"
    log.write_text(ANDROID_FAIL, encoding="utf-8")
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    tools = engine._strategy.toolchain_fingerprint()
    tools["env_hash"] = "e" * 12
    row = engine._strategy.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.14.6",
        "aarch64", "android-termux",
        "pip install -r %s" % req, "pkgx>=1\n", tools,
        run_id="old-run")
    del row["build_env_hash"]
    del row["build_env"]
    row.update({"category": "RUST_BUILD_FAILURE",
                "result": "failed", "log": str(log),
                "detail": ANDROID_FAIL[-500:],
                "ts": "2026-10-09T01:02:19Z"})
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    ledger.record_row(row)
    wheel_bytes = b"fake-wheel-bytes"
    sha = hashlib.sha256(wheel_bytes).hexdigest()
    asset = "pydantic_core-2.49.0-cp314-cp314-android_24_" \
        "arm64_v8a.whl"
    monkeypatch.setattr(
        engine._strategy, "detect_android_api_level",
        lambda *argv, **kw: {"ok": True, "level": 29,
                             "source": "getprop",
                             "device_api_level": 29,
                             "device_source": "getprop",
                             "reason": "device api detected"})
    monkeypatch.setattr(
        engine._compat, "fetch_github_releases",
        lambda *argv, **kw: [{"tag": "v2.49.0", "assets": [{
            "name": asset, "url": "https://github.com/Eutalix/"
            "android-pydantic-core/releases/download/v2.49.0/"
            + asset, "digest": "sha256:" + sha, "size": 18}]}])
    monkeypatch.setattr(engine._compat, "_http_bytes",
                        lambda url, timeout=30: wheel_bytes)
    monkeypatch.setattr(engine._compat, "pydantic_for_core",
                        lambda *argv, **kw: "2.12.0")
    monkeypatch.setattr(engine, "_package_in_graph",
                        lambda *argv, **kw: True)
    seen = {}

    def fake_run(argv, *rest, **kw):
        if "install" in argv:
            return (0, "ok")
        if "check" in argv:
            seen["check"] = True
            return (0, "")
        if "show" in argv:
            return (0, "Name: pydantic-core\nVersion: 2.49.0\n")
        if "-c" in argv and "layer1" in argv[-1]:
            layer = (kw.get("env") or {}).get(
                "ANDROID_API_LEVEL", "")
            return (0, json.dumps(
                {"layer1": layer, "layer2": layer,
                 "want": (kw.get("env") or {}).get(
                     "APKF_WANT_API", "")}))
        if "-c" in argv and "__version__" in argv[-1]:
            return (0, "2.49.0")
        if "-c" in argv:
            return (0, "import-ok")
        return (0, "")

    monkeypatch.setattr(engine, "run", fake_run)
    result = engine.pip_install_with_recovery(
        ctx, "/nonexistent/python", req, fp,
        {"platform": "android-termux", "compiler_c": True,
         "compiler_rust": True}, ledger, "e" * 12,
        offline=False)
    assert result["python"] != "/nonexistent/python"
    assert result["venv"].startswith(
        str(tmp_path / "gov" / "venv-candidates"))
    assert seen.get("check") is True
    kinds = {(entry.get("strategy"), entry.get("result"))
             for entry in ledger.entries()}
    assert ("android_prebuilt_wheel (isolated)", "ok") in kinds
    wheel_rows = [entry for entry in ledger.entries()
                  if entry.get("wheel_provenance")]
    assert len(wheel_rows) == 1
    assert wheel_rows[0]["wheel_provenance"]["sha256"] == sha
    assert wheel_rows[0]["wheel_provenance"]["version"] == \
        "2.49.0"
    assert (tmp_path / "gov" / "wheel-cache" / asset).is_file()


# -- wheel selection safety (Test E) ------------------------------------------

WHEEL_BASE = "pydantic_core-2.49.0-cp314-cp314-android_24_" \
    "arm64_v8a.whl"


def _wheel_asset(name, digest="sha256:" + "a" * 64):
    return {"name": name,
            "url": "https://github.com/Eutalix/android-pydantic-"
            "core/releases/download/v2.49.0/" + name,
            "digest": digest, "size": 10}


def _wheel_releases(*assets):
    return [{"tag": "v2.49.0", "assets": list(assets)}]


def test_wheel_rejects_arch_mismatch():
    name = WHEEL_BASE.replace("arm64_v8a", "x86_64")
    cand, reason = C.resolve_android_wheel(
        "", "cp314", "aarch64", 29,
        releases=_wheel_releases(_wheel_asset(name)))
    assert cand is None
    assert "arch" in reason


def test_wheel_rejects_abi_mismatch():
    name = WHEEL_BASE.replace("cp314-cp314", "cp313-cp313")
    cand, reason = C.resolve_android_wheel(
        "", "cp314", "aarch64", 29,
        releases=_wheel_releases(_wheel_asset(name)))
    assert cand is None
    assert "abi" in reason


def test_wheel_rejects_non_android_tag():
    name = "pydantic_core-2.49.0-cp314-cp314-manylinux_2_17_" \
        "aarch64.whl"
    cand, reason = C.resolve_android_wheel(
        "", "cp314", "aarch64", 29,
        releases=_wheel_releases(_wheel_asset(name)))
    assert cand is None
    assert "android platform tag" in reason


def test_wheel_rejects_missing_digest():
    cand, reason = C.resolve_android_wheel(
        "", "cp314", "aarch64", 29, fetcher=lambda url: b"",
        releases=_wheel_releases(
            _wheel_asset(WHEEL_BASE, digest="")))
    assert cand is None
    assert "sha256" in reason


def test_wheel_rejects_foreign_url():
    asset = _wheel_asset(WHEEL_BASE)
    asset["url"] = "https://evil.example/files/" + WHEEL_BASE
    cand, reason = C.resolve_android_wheel(
        "", "cp314", "aarch64", 29,
        releases=_wheel_releases(asset))
    assert cand is None
    assert "outside" in reason


def test_wheel_rejects_version_violation():
    cand, reason = C.resolve_android_wheel(
        "==2.40.0", "cp314", "aarch64", 29,
        releases=_wheel_releases(_wheel_asset(WHEEL_BASE)))
    assert cand is None
    assert "violates" in reason


def test_wheel_rejects_api_above_device():
    cand, reason = C.resolve_android_wheel(
        "", "cp314", "aarch64", 23,
        releases=_wheel_releases(_wheel_asset(WHEEL_BASE)))
    assert cand is None
    assert "device 23" in reason


def test_wheel_accepts_checksum_file_fallback():
    sha = "b" * 64
    sums = "%s  %s\n" % (sha, WHEEL_BASE)
    release = _wheel_releases(
        _wheel_asset(WHEEL_BASE, digest=""),
        {"name": "SHA256SUMS.txt",
         "url": "https://github.com/Eutalix/android-pydantic-"
         "core/releases/download/v2.49.0/SHA256SUMS.txt",
         "digest": "", "size": 90})
    cand, reason = C.resolve_android_wheel(
        "", "cp314", "aarch64", 29,
        fetcher=lambda url: sums.encode("utf-8"),
        releases=release)
    assert reason == "ok"
    assert cand["sha256"] == sha


def test_fetch_verified_rejects_mismatch(tmp_path):
    dest = tmp_path / "w.whl"
    path, reason = C.fetch_verified_wheel(
        "https://example.invalid/w.whl", "c" * 64, dest,
        fetcher=lambda url: b"other-bytes")
    assert path is None
    assert "mismatch" in reason
    assert not dest.is_file()


def test_fetch_verified_reuses_cache(tmp_path):
    dest = tmp_path / "w.whl"
    dest.write_bytes(b"good-bytes")
    sha = hashlib.sha256(b"good-bytes").hexdigest()

    def explode(url):
        raise AssertionError("network must not run")

    path, reason = C.fetch_verified_wheel(
        "https://example.invalid/w.whl", sha, dest,
        fetcher=explode)
    assert path == str(dest)
    assert "reused" in reason


# -- build-env fingerprint components ------------------------------------------

def test_fingerprint_changes_with_every_input():
    kw = {"step": "DEPENDENCIES", "strategy": "native",
          "package": None, "version": None,
          "python_version": "3.13.0", "arch": "x86_64",
          "platform": "p", "command": "pip install -r req",
          "requirements_text": "a\n",
          "toolchain_fp": _tools()}
    base = S.attempt_fingerprint(**kw)["attempt_id"]
    variants = [
        {"strategy": "other"}, {"package": "p"},
        {"version": "1"}, {"python_version": "3.12.0"},
        {"arch": "aarch64"}, {"platform": "q"},
        {"command": "pip install -r other"},
        {"requirements_text": "b\n"},
        {"toolchain_fp": _tools("f" * 12)},
        {"build_env": {"ANDROID_API_LEVEL": "33"}}]
    for variant in variants:
        changed = dict(kw)
        changed.update(variant)
        assert S.attempt_fingerprint(
            **changed)["attempt_id"] != base, variant


# -- runtime package availability ------------------------------------------------

def test_apt_availability(engine, ctx, monkeypatch):
    monkeypatch.setattr(engine.shutil, "which",
                        lambda name: "/usr/bin/apt-cache")
    monkeypatch.setattr(
        engine, "run",
        lambda argv, *rest, **kw: (
            0, "python3.12:\n  Candidate: 3.12.0\n"))
    assert engine._apt_pkg_available(ctx, "python3.12") is True
    monkeypatch.setattr(
        engine, "run",
        lambda argv, *rest, **kw: (
            0, "N: Unable to locate\n  Candidate: (none)\n"))
    assert engine._apt_pkg_available(ctx, "nope") is False
    monkeypatch.setattr(engine.shutil, "which",
                        lambda name: None)
    assert engine._apt_pkg_available(ctx, "x") is None


# -- pydantic-core constraint discovery --------------------------------------------

def test_pydantic_core_constraint_from_pypi(engine, tmp_path,
                                            monkeypatch):
    req = tmp_path / "req.txt"
    req.write_text("pydantic>=2.6\n", encoding="utf-8")
    monkeypatch.setattr(engine._compat, "pypi_versions",
                        lambda *argv, **kw: ["2.14.0", "2.6.0"])
    monkeypatch.setattr(
        engine._compat, "pypi_release",
        lambda *argv, **kw: {"version": "2.14.0",
                             "requires_dist": [
                                 "pydantic-core==2.41.0",
                                 "typing-extensions>=4.6.1"]})
    assert engine._pydantic_core_constraint(
        req, tmp_path / "cache") == "==2.41.0"

# -- subprocess environment proof ------------------------------------------

def test_android_api_reaches_maturin(engine, ctx):
    """Two-layer proof with a REAL child process: the candidate env
    reaches the child (pip layer) and the grandchild (PEP 517
    backend layer, where maturin runs)."""
    ok, observed = engine.verify_build_env(
        sys.executable, {"ANDROID_API_LEVEL": "33"}, ctx)
    assert ok is True
    assert observed["layer1"] == "33"
    assert observed["layer2"] == "33"
    assert observed["want"] == "33"


def test_verify_fails_without_api(engine, ctx):
    ok, _ = engine.verify_build_env(sys.executable, {}, ctx)
    assert ok is False


def test_run_merges_environment(engine):
    code, out = engine.run(
        [sys.executable, "-c",
         "import os; print('PATH_OK' if os.environ.get('PATH')"
         " else 'PATH_LOST'); print('X=' + os.environ.get("
         "'APKF_TEST_X', ''))"],
        None, timeout=60, env={"APKF_TEST_X": "1"})
    assert code == 0
    assert "PATH_OK" in out
    assert "X=1" in out


# -- propagation + ndk classification ---------------------------------------

def test_env_propagation_classification():
    assert R.classify_failure(
        ANDROID_FAIL, {"env_had_api": True})["category"] == \
        "ENV_PROPAGATION_FAILURE"
    assert R.classify_failure(ANDROID_FAIL)["category"] == \
        "ANDROID_API_LEVEL_MISSING"


def test_ndk_classification():
    log = ("Collecting pkgx\n  error: could not find ndk "
           "under $ANDROID_HOME\n")
    assert R.classify_failure(log)["category"] == \
        "ANDROID_NDK_MISSING"


def test_find_package_rejects_installable():
    log = ("Collecting installable==1.0\n"
           "  Failed to build `installable`\n"
           "  error: something broke\n")
    assert R.classify_failure(log)["package"] is None


# -- no-isolation ordering ----------------------------------------------------

def _termux_caps():
    return {"termux": True, "provision_ok": False,
            "offline": False, "direct": set(),
            "alternate_pythons": [], "signals": []}


def test_no_isolation_ordered_for_env_propagation():
    cands = S.order_candidates(
        {"category": "ENV_PROPAGATION_FAILURE",
         "package": "pydantic-core"}, _termux_caps())
    ids = [item["id"] for item in cands]
    assert ids[:3] == ["android_prebuilt_wheel",
                       "native_android_api_no_isolation",
                       "native_android_api_level"]


def test_no_isolation_after_api_for_plain_missing():
    cands = S.order_candidates(
        {"category": "ANDROID_API_LEVEL_MISSING",
         "package": "pydantic-core"}, _termux_caps())
    ids = [item["id"] for item in cands]
    assert ids[:3] == ["android_prebuilt_wheel",
                       "native_android_api_level",
                       "native_android_api_no_isolation"]


def test_wheel_runtime_excludes_wheel():
    cands = S.order_candidates(
        {"category": "WHEEL_RUNTIME_INCOMPATIBLE",
         "package": "pydantic-core"}, _termux_caps())
    ids = [item["id"] for item in cands]
    assert "android_prebuilt_wheel" not in ids
    assert ids[:2] == ["native_android_api_level",
                       "native_android_api_no_isolation"]


# -- execution diff kinds ------------------------------------------------------

def test_execution_diff_kind():
    base = S.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.13.0",
        "x86_64", "p", "cmd", "req\n", _tools(),
        run_id="r")

    def changed(**kw):
        row = dict(base)
        row.update(kw)
        return row

    assert S.execution_diff_kind(base, dict(base)) == "identical"
    assert S.execution_diff_kind(
        changed(strategy="other"), base) == "changed-strategy"
    assert S.execution_diff_kind(
        changed(package="x"), base) == "changed-target"
    assert S.execution_diff_kind(
        changed(python="3.12"), base) == "changed-runtime"
    assert S.execution_diff_kind(
        changed(toolchain_fp="zzz"), base) == "changed-toolchain"
    assert S.execution_diff_kind(
        changed(command_hash="zzz"), base) == "changed-command"
    assert S.execution_diff_kind(
        changed(requirements_hash="zzz"),
        base) == "changed-requirements"
    assert S.execution_diff_kind(
        changed(build_env_hash="zzz"), base) == "changed-build-env"


# -- dependency graph + wheel constraints ---------------------------------------

def test_pydantic_for_core(monkeypatch):
    monkeypatch.setattr(
        C, "pypi_versions",
        lambda *argv, **kw: ["2.14.0", "2.12.0", "2.11.0"])

    def fake_release(name, version=None, **kw):
        pins = {"2.14.0": "==2.50.0", "2.12.0": "==2.49.0",
                "2.11.0": "==2.41.3"}
        return {"version": version,
                "requires_dist": ["pydantic-core%s"
                                  % pins[version]]}

    monkeypatch.setattr(C, "pypi_release", fake_release)
    assert C.pydantic_for_core("2.49.0") == "2.12.0"
    assert C.pydantic_for_core("9.9.9") is None


def test_package_in_graph(engine, tmp_path, monkeypatch):
    req = tmp_path / "req.txt"
    req.write_text("pydantic>=2.6\n", encoding="utf-8")
    monkeypatch.setattr(engine._compat, "pypi_versions",
                        lambda *argv, **kw: ["2.12.0"])
    monkeypatch.setattr(
        engine._compat, "pypi_release",
        lambda *argv, **kw: {"version": "2.12.0",
                             "requires_dist": [
                                 "pydantic-core==2.49.0"]})
    assert engine._package_in_graph(
        "pydantic", req, tmp_path) is True
    assert engine._package_in_graph(
        "pydantic-core", req, tmp_path) is True
    assert engine._package_in_graph(
        "installable", req, tmp_path) is False
    assert engine._package_in_graph("", req, tmp_path) is False


def test_wheel_constraints_pin_real_packages(engine, ctx, tmp_path,
                                             monkeypatch):
    req = tmp_path / "req.txt"
    req.write_text("pydantic>=2.6\n", encoding="utf-8")
    monkeypatch.setattr(engine._compat, "pydantic_for_core",
                        lambda *argv, **kw: "2.12.0")
    monkeypatch.setattr(engine, "_package_in_graph",
                        lambda *argv, **kw: True)
    path, _ = engine._wheel_constraints(
        "2.49.0", req, tmp_path / "cache")
    content = Path(path).read_text(encoding="utf-8")
    assert "pydantic-core==2.49.0" in content
    assert "pydantic==2.12.0" in content
    assert "installable" not in content
    monkeypatch.setattr(engine._compat, "pydantic_for_core",
                        lambda *argv, **kw: None)
    missing, why = engine._wheel_constraints(
        "9.9.9", req, tmp_path / "cache")
    assert missing is None
    assert "no pydantic release" in why


# -- fake-package refusal --------------------------------------------------------

def test_no_fake_installable_literal():
    for name in ("apkforge.py", "adaptive/compat.py",
                 "adaptive/strategy.py", "adaptive/recovery.py",
                 "adaptive/runtime.py", "adaptive/env.py"):
        source = (ROOT / "scripts" / name).read_text(
            encoding="utf-8")
        assert "installable==1.0" not in source, name


def test_no_fake_installable_package_strategy(engine, ctx, tmp_path,
                                              monkeypatch):
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    tools = engine._strategy.toolchain_fingerprint()
    tools["env_hash"] = "e" * 12
    row = engine._strategy.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.13.0",
        "x86_64", "linux-x86_64", "pip install -r %s" % req,
        "pkgx>=1\n", tools, run_id="old-run")
    row.update({"category": "RUST_BUILD_FAILURE",
                "result": "failed", "log": "",
                "diagnosed_package": "installable", "detail": "",
                "ts": "2026-10-09T01:02:19Z"})
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    ledger.record_row(row)
    monkeypatch.setattr(engine, "run",
                        lambda *argv, **kw: (1, "boom"))
    monkeypatch.setattr(engine, "_resolve_version_pick",
                        lambda *argv, **kw: {"version": "1.0",
                                             "status": "WHEEL_OK"})
    monkeypatch.setattr(engine, "_package_in_graph",
                        lambda *argv, **kw: False)
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
    assert not [entry for entry in ledger.entries()
                if (entry.get("strategy") or "").startswith(
                    "version:installable")]
    assert any("not part of this project's dependency graph"
               in need for need in info["needs_you"])


# -- per-package states ------------------------------------------------------------

def test_package_tracker_states():
    tracker = S.PackageTracker()
    assert tracker.native_blocked(
        "pydantic-core", "be1") is False
    tracker.note_native_failed("pydantic-core", "be1")
    assert tracker.native_blocked(
        "pydantic-core", "be1") is True
    assert tracker.native_blocked(
        "pydantic-core", "be2") is False
    assert tracker.native_blocked("watchfiles", "be1") is False
    tracker.recovered("pydantic-core",
                      "android_prebuilt_wheel (isolated)",
                      "a1", "log1")
    assert tracker.summary()[
        "pydantic-core"]["status"] == "RECOVERED"
    assert tracker.native_blocked(
        "pydantic-core", "be1") is True
    tracker.blocked("watchfiles", "native", "a2", "log2")
    assert tracker.summary()[
        "watchfiles"]["status"] == "BLOCKED"


def test_order_targets_next_package():
    cands = S.order_candidates(
        {"category": "RUST_BUILD_FAILURE",
         "package": "watchfiles"}, _termux_caps())
    by_id = {item["id"]: item for item in cands}
    assert by_id["version"]["params"]["package"] == "watchfiles"
    assert "native" in by_id


# -- contextual restore ---------------------------------------------------------------

def test_restore_keeps_contextual_categories(tmp_path):
    row = S.attempt_fingerprint(
        "DEPENDENCIES", "native_android_api_level (isolated)",
        None, None, "3.13.0", "x86_64", "linux-x86_64",
        "pip install -r req", "pkgx>=1\n", _tools(),
        run_id="r1")
    row.update({"category": "ENV_PROPAGATION_FAILURE",
                "result": "failed", "log": "",
                "diagnosed_package": "pydantic-core",
                "detail": ANDROID_FAIL[-500:], "ts": ""})
    ledger = tmp_path / "ledger.jsonl"
    ledger.write_text(json.dumps(row) + "\n", encoding="utf-8")
    restored = S.restore_failure_context(ledger)
    assert restored["category"] == "ENV_PROPAGATION_FAILURE"
    assert restored["diagnosed_package"] == "pydantic-core"
    assert restored["reclassified"] is False


# -- recovery report ---------------------------------------------------------------------

def test_recovery_report_written(engine, ctx, tmp_path):
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    row = S.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.13.0",
        "x86_64", "p", "cmd", "req\n", _tools(),
        run_id="api-run")
    row.update({"category": "X", "result": "failed", "log": "",
                "diagnosed_package": "pkgx",
                "detail": "token=ghp_SECRET123", "ts": ""})
    ledger.record_row(row)
    path = engine._write_recovery_report(
        ctx, ledger, "exhausted",
        {"category": "X", "package": "pkgx",
         "root_cause": "r", "tried": [],
         "next_action": "n"},
        {"os": "linux", "arch_machine": "x86_64",
         "termux": False, "python_version": "3.13.0"},
        {"platform": "p"})
    text = Path(path).read_text(encoding="utf-8")
    assert "ghp_SECRET123" not in text
    data = json.loads(text)
    for key in ("environment", "toolchain", "attempts",
                "candidate_fingerprints",
                "successful_candidates", "failed_candidates",
                "reclassified_failures", "provisioned_tools",
                "verified_artifacts", "package_states",
                "current_blocker", "next_action"):
        assert key in data, key
    assert data["package_states"]["pkgx"]["status"] == "BLOCKED"
    assert data["current_blocker"]["category"] == "X"


# -- no-isolation adoption -------------------------------------------------------------------

def test_no_isolation_strategy_adopted(engine, ctx, tmp_path,
                                       monkeypatch):
    monkeypatch.setenv("ANDROID_API_LEVEL", "34")
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    tools = engine._strategy.toolchain_fingerprint()
    tools["env_hash"] = "e" * 12
    row = engine._strategy.attempt_fingerprint(
        "DEPENDENCIES", "native_android_api_level (isolated)",
        None, None, "3.13.0", "x86_64", "linux-x86_64",
        "pip install -r %s" % req, "pkgx>=1\n", tools,
        run_id="old-run")
    row.update({"category": "ENV_PROPAGATION_FAILURE",
                "result": "failed", "log": "",
                "diagnosed_package": "pydantic-core",
                "detail": "",
                "ts": "2026-10-09T01:02:19Z"})
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    ledger.record_row(row)
    monkeypatch.setattr(
        engine, "_redetect_compilers",
        lambda profile: profile.update({"compiler_c": True,
                                        "compiler_rust": True}))
    seen = {}

    def fake_run(argv, *rest, **kw):
        if "-c" in argv and "layer1" in argv[-1]:
            layer = (kw.get("env") or {}).get(
                "ANDROID_API_LEVEL", "")
            return (0, json.dumps(
                {"layer1": layer, "layer2": layer,
                 "want": (kw.get("env") or {}).get(
                     "APKF_WANT_API", "")}))
        if "install" in argv:
            if "--no-build-isolation" in argv:
                seen["noiso"] = True
            if (kw.get("env") or {}).get("ANDROID_API_LEVEL"):
                return (0, "ok")
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
    result = engine.pip_install_with_recovery(
        ctx, "/nonexistent/python", req, _ladder_fp(),
        {"platform": "linux-x86_64", "compiler_c": True,
         "compiler_rust": True}, ledger, "e" * 12,
        offline=False)
    assert seen.get("noiso") is True
    assert result["python"] != "/nonexistent/python"
    rows = [entry for entry in ledger.entries()
            if entry.get("strategy")
            == "native_android_api_no_isolation (isolated)"]
    assert len(rows) == 1
    assert rows[0]["result"] == "ok"
    assert rows[0]["build_env"]["build_isolation"] == "false"
    assert rows[0]["build_env"]["ANDROID_API_LEVEL"] == "34"


# -- wheel preservation (verified wheel is not replaced) --------------------------------------

def test_verified_android_wheel_is_not_replaced(
        engine, ctx, tmp_path, monkeypatch):
    fp = {"termux": True, "libc": "bionic",
          "arch_machine": "aarch64",
          "python_version": "3.14.6", "os": "linux",
          "fingerprint_hash": "e" * 12}
    log = tmp_path / "pip-old-native.log"
    log.write_text(ANDROID_FAIL, encoding="utf-8")
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    tools = engine._strategy.toolchain_fingerprint()
    tools["env_hash"] = "e" * 12
    row = engine._strategy.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.14.6",
        "aarch64", "android-termux",
        "pip install -r %s" % req, "pkgx>=1\n", tools,
        run_id="old-run")
    del row["build_env_hash"]
    del row["build_env"]
    row.update({"category": "RUST_BUILD_FAILURE",
                "result": "failed", "log": str(log),
                "detail": ANDROID_FAIL[-500:],
                "ts": "2026-10-09T01:02:19Z"})
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    ledger.record_row(row)
    wheel_bytes = b"fake-wheel-bytes"
    sha = hashlib.sha256(wheel_bytes).hexdigest()
    asset = "pydantic_core-2.49.0-cp314-cp314-android_24_" \
        "arm64_v8a.whl"
    monkeypatch.setattr(
        engine._strategy, "detect_android_api_level",
        lambda *argv, **kw: {"ok": True, "level": 29,
                             "source": "getprop",
                             "device_api_level": 29,
                             "device_source": "getprop",
                             "reason": "device api detected"})
    monkeypatch.setattr(
        engine._compat, "fetch_github_releases",
        lambda *argv, **kw: [{"tag": "v2.49.0", "assets": [{
            "name": asset, "url": "https://github.com/Eutalix/"
            "android-pydantic-core/releases/download/v2.49.0/"
            + asset, "digest": "sha256:" + sha, "size": 18}]}])
    monkeypatch.setattr(engine._compat, "_http_bytes",
                        lambda url, timeout=30: wheel_bytes)
    monkeypatch.setattr(engine._compat, "pydantic_for_core",
                        lambda *argv, **kw: "2.12.0")
    monkeypatch.setattr(engine, "_package_in_graph",
                        lambda *argv, **kw: True)
    installs = []
    seen = {}

    def fake_run(argv, *rest, **kw):
        if "install" in argv:
            installs.append(list(argv))
            return (0, "ok")
        if "check" in argv:
            seen["check"] = True
            return (0, "")
        if "show" in argv:
            seen["show"] = True
            return (0, "Name: pydantic-core\nVersion: 2.49.0\n")
        if "-c" in argv and "layer1" in argv[-1]:
            layer = (kw.get("env") or {}).get(
                "ANDROID_API_LEVEL", "")
            return (0, json.dumps(
                {"layer1": layer, "layer2": layer,
                 "want": (kw.get("env") or {}).get(
                     "APKF_WANT_API", "")}))
        if "-c" in argv and "__version__" in argv[-1]:
            seen["ver"] = True
            return (0, "2.49.0")
        if "-c" in argv:
            return (0, "import-ok")
        return (0, "")

    monkeypatch.setattr(engine, "run", fake_run)
    result = engine.pip_install_with_recovery(
        ctx, "/nonexistent/python", req, fp,
        {"platform": "android-termux", "compiler_c": True,
         "compiler_rust": True}, ledger, "e" * 12,
        offline=False)
    assert result["python"] != "/nonexistent/python"
    full = [argv for argv in installs if "-r" in argv]
    assert len(full) == 1
    assert "-c" in full[0]
    cpath = full[0][full[0].index("-c") + 1]
    content = Path(cpath).read_text(encoding="utf-8")
    assert "pydantic-core==2.49.0" in content
    assert "pydantic==2.12.0" in content
    assert "installable" not in content
    assert seen.get("show") is True
    assert seen.get("ver") is True
    assert seen.get("check") is True
