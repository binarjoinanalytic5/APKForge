"""Urgent recovery-logic fix: probe-first verdicts, no repeat attempts.

Regression cover for the Termux run where `pip attempt [native]`
executed twice and a present rustc was still reported RUST_MISSING.
"""
import importlib.util
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
    spec = importlib.util.spec_from_file_location("apkforge_fix",
                                                  ENGINE)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


@pytest.fixture()
def ctx(engine, tmp_path, monkeypatch):
    monkeypatch.setattr(engine, "GOV", tmp_path / "gov")
    monkeypatch.setattr(engine, "LOGS", tmp_path / "logs")
    return engine.Ctx("fix-run", tmp_path / "run.log",
                      json_only=True)


RUST_FAIL = (
    "Collecting pkgx\n"
    "  Building wheel for pydantic-core (pyproject.toml): started\n"
    "  error: cargo build failed with exit status 101\n"
    "  Failed to build `pydantic-core`\n"
    "  ERROR: Could not build wheels for pydantic-core\n")


def _rust_probe():
    return {"tools": {
        "rustc": {"ok": True, "version": "1.99.0",
                  "path": "/x/rustc"},
        "cargo": {"ok": True, "version": "1.99.0",
                  "path": "/y/cargo"},
        "cc": {"ok": True, "version": "clang 1",
               "path": "/z/cc"}},
        "hash": "abc123"}


def _tools(env_hash="e" * 12):
    return {"tools": {"rustc": "1.99.0"}, "hash": "t" * 16,
            "env_hash": env_hash}


def _ladder_fp():
    return {"termux": False, "libc": "gnu", "arch_machine": "x86_64",
            "python_version": "3.13.0", "os": "linux",
            "fingerprint_hash": "e" * 12}


def test_log_rust_missing_refined_when_toolchain_present():
    classified = R.classify_failure(RUST_FAIL)
    assert classified["category"] == "RUST_MISSING"
    assert classified["package"] == "pydantic-core"
    assert S.extract_signals(RUST_FAIL) == []
    refined, note = S.refine_category(
        classified["category"], _rust_probe(), [])
    assert refined == "RUST_BUILD_FAILURE"
    assert "1.99.0" in note


def test_rust_missing_kept_when_toolchain_absent():
    probe = {"tools": {
        "rustc": {"ok": False, "version": None, "path": None},
        "cargo": {"ok": False, "version": None, "path": None}},
        "hash": "x"}
    refined, note = S.refine_category("RUST_MISSING", probe, [])
    assert (refined, note) == ("RUST_MISSING", "")


def test_c_and_backend_refinement():
    probe = _rust_probe()
    refined, _ = S.refine_category("COMPILER_MISSING", probe, [])
    assert refined == "C_BUILD_FAILURE"
    refined, _ = S.refine_category("BUILD_TOOL_MISSING", probe, [])
    assert refined == "BUILD_BACKEND_FAILURE"
    bare = {"tools": {}, "hash": "x"}
    refined, note = S.refine_category("BUILD_TOOL_MISSING", bare,
                                      [])
    assert (refined, note) == ("BUILD_TOOL_MISSING", "")


def test_memory_lifecycle():
    assert S.memory_status({}, "h")["status"] == "NONE"
    assert S.memory_status({"category": "X"}, "h")["status"] == \
        "STALE"
    assert S.memory_status({"toolchain_fp": "old"}, "new")[
        "status"] == "STALE"
    current = S.memory_status({"toolchain_fp": "same"}, "same")
    assert current["status"] == "ACTIVE"


def test_probe_shape():
    probe = S.probe_toolchain()
    assert probe["hash"]
    assert set(probe["tools"]["rustc"]) >= {"path", "version",
                                            "ok"}


def test_fingerprint_target_not_diagnosis():
    tools = _tools()
    first = S.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.13.0", "x86_64",
        "linux-x86_64", "pip install -r req", "pkgx>=1\n",
        tools, run_id="r1")
    second = S.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.13.0", "x86_64",
        "linux-x86_64", "pip install -r req", "pkgx>=1\n",
        tools, run_id="r2")
    assert first["attempt_id"] == second["attempt_id"]
    other = S.attempt_fingerprint(
        "DEPENDENCIES", "version:p==1", "p", "1", "3.13.0",
        "x86_64", "linux-x86_64", "pip install -r req",
        "pkgx>=1\n", tools, run_id="r1")
    assert other["attempt_id"] != first["attempt_id"]


def test_version_broadcast_without_version_ok():
    cands = S.order_candidates(
        {"category": "RUST_BUILD_FAILURE",
         "package": "pydantic-core"},
        {"termux": False, "provision_ok": False, "offline": False,
         "direct": set(), "alternate_pythons": [], "signals": []})
    assert [item["id"] for item in cands] == ["native", "version"]


def test_explain_run_and_refuse():
    row = S.attempt_fingerprint(
        "DEPENDENCIES", "native", None, None, "3.13.0", "x86_64",
        "linux-x86_64", "pip install -r req", "pkgx>=1\n",
        _tools(), run_id="r1")
    run = S.explain(row, "run", "recorded failure")
    assert run[0].startswith("WHY")
    assert "native" in run[0]
    assert any("differs from" in line for line in run)
    refuse = S.explain(row, "refuse")
    assert any("REFUSE" in line for line in refuse)
    assert any("identical" in line for line in refuse)


def test_native_languages():
    assert C.native_languages("pydantic-core") == {"rust"}
    assert C.native_languages("uvicorn[standard]") == set()
    assert C.native_languages("numpy; python_version>'3'") == {"c"}
    assert C.native_languages(None) == set()


def test_exhaustion_state(engine):
    assert "RECOVERY_AVAILABLE" in engine.STATES
    assert engine.exhaustion_state({"needs_you": ["x"]}) == \
        "RECOVERY_AVAILABLE"
    assert engine.exhaustion_state({"required": "y"}) == \
        "RECOVERY_AVAILABLE"
    assert engine.exhaustion_state({}) == "BLOCKED"


def test_alternatives_prescribe_wheels_not_rust_install(engine):
    hints = engine._recovery_alternatives(
        "RUST_BUILD_FAILURE", "pydantic-core", {}, {})
    joined = " ".join(hints)
    assert "pkg install rust" not in joined
    assert "wheel" in joined


def test_ladder_never_repeats_identical_native(
        engine, ctx, tmp_path, monkeypatch):
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    monkeypatch.setattr(engine._strategy, "probe_toolchain",
                        lambda *argv, **kw: _rust_probe())
    monkeypatch.setattr(engine, "run",
                        lambda *argv, **kw: (1, RUST_FAIL))
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
    assert info["category"] == "RUST_BUILD_FAILURE"
    native_failed = [entry for entry in ledger.entries()
                     if entry.get("strategy") == "native"
                     and entry.get("result") == "failed"]
    assert len(native_failed) == 1
    assert "native" in info["skipped_identical"]
    nodes = [node for node in info["nodes"]
             if node["node"] == "native"
             and node["status"] == "failed"]
    assert len(nodes) == 1
    assert nodes[0]["reason"] == "RUST_BUILD_FAILURE"


def test_ladder_runs_version_strategy(engine, ctx, tmp_path,
                                      monkeypatch):
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    monkeypatch.setattr(engine._strategy, "probe_toolchain",
                        lambda *argv, **kw: _rust_probe())

    def fake_run(argv, *rest, **kw):
        if "install" in argv and "-c" in argv:
            return (0, "ok")
        if "install" in argv:
            return (1, RUST_FAIL)
        return (0, "")

    monkeypatch.setattr(engine, "run", fake_run)
    monkeypatch.setattr(engine, "_resolve_version_pick",
                        lambda *argv, **kw: {"version": "2.0.0",
                                             "status": "WHEEL_OK"})
    result = engine.pip_install_with_recovery(
        ctx, "/nonexistent/python", req, _ladder_fp(),
        {"platform": "linux-x86_64", "compiler_c": True,
         "compiler_rust": True}, ledger, "e" * 12,
        offline=False)
    assert result["python"] == "/nonexistent/python"
    assert "exe" not in result
    kinds = {(entry.get("strategy"), entry.get("result"))
             for entry in ledger.entries()}
    assert ("native", "failed") in kinds
    assert ("version:pydantic-core==2.0.0", "ok") in kinds
    resolved = tmp_path / "gov" / "generated" / \
        "resolved-requirements.txt"
    assert "pydantic-core==2.0.0" in resolved.read_text(
        encoding="utf-8")
