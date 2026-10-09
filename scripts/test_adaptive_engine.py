"""Integration tests: the 2.0.0 engine consumes the adaptive units."""
import hashlib
import importlib.util
import json
from pathlib import Path

import pytest

ENGINE = Path(__file__).resolve().parent / "apkforge.py"


@pytest.fixture()
def engine():
    spec = importlib.util.spec_from_file_location("apkforge_e2e", ENGINE)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


@pytest.fixture()
def ctx(engine, tmp_path, monkeypatch):
    monkeypatch.setattr(engine, "GOV", tmp_path / "gov")
    monkeypatch.setattr(engine, "LOGS", tmp_path / "logs")
    return engine.Ctx("test-run", tmp_path / "run.log", json_only=True)


def test_engine_version_and_adaptive_wiring(engine):
    import adaptive
    assert engine.ENGINE_VERSION == "2.0.0"
    assert adaptive.ENGINE_VERSION == engine.ENGINE_VERSION
    for legacy in ("INIT", "ENVIRONMENT_CHECK", "TOOLS_READY",
                   "RUNTIME_READY", "DATABASE_READY", "BUILD_READY",
                   "SERVICES_READY", "HEALTHY", "READY", "FAILED"):
        assert legacy in engine.STATES
    for adaptive in ("TOOLS_INVENTORIED", "COMPATIBILITY_RESOLVED",
                     "PLAN_CREATED", "RECOVERING",
                     "GIT_RECOVERY_REQUIRED", "BLOCKED",
                     "ADMIN_SETUP_REQUIRED"):
        assert adaptive in engine.STATES


def test_tool_matrix_roles_preserved(engine):
    kinds = {spec["tool"]: spec["kind"] for spec in engine.TOOL_MATRIX}
    assert kinds["python3"] == "required"
    assert kinds["node"] == "required"
    assert kinds["docker"] == "not-needed-phase1"
    assert engine._spec_of("pip")["want"] != ""
    with pytest.raises(RuntimeError):
        engine._spec_of("nope")


def test_detect_tools_single_inventory(engine, ctx):
    fp = {"termux": False, "libc": "gnu"}
    rows = engine.detect_tools(ctx, fp)
    assert [row["tool"] for row in rows] == [
        spec["tool"] for spec in engine.TOOL_MATRIX]
    for row in rows:
        assert set(row) >= {"tool", "kind", "role", "status",
                            "adaptive_status", "required_version",
                            "detected_version", "path",
                            "installation_method", "source"}
    by_name = {row["tool"]: row for row in rows}
    assert by_name["python3"]["adaptive_status"] == "AVAILABLE"
    assert by_name["node"]["role"] == "REQUIRED"
    assert by_name["git"]["kind"] == "optional"
    assert by_name["git"]["role"] == "OPTIONAL"
    assert by_name["docker"]["role"] == "PHASE_DEPENDENT"
    assert by_name["docker"]["kind"] == "not-needed-phase1"


def test_extras_failure_and_alternatives(engine):
    assert engine._is_extras_failure("uvloop")
    assert engine._is_extras_failure("httptools")
    assert not engine._is_extras_failure("fastapi")
    assert not engine._is_extras_failure(None)
    termux = engine._recovery_alternatives(
        "RUST_MISSING", "pydantic-core", {}, {"termux": True})
    assert any("pkg install rust" in hint for hint in termux)
    plain = engine._recovery_alternatives(
        "RUST_MISSING", "pydantic-core", {}, {"termux": False})
    assert any("system manager" in hint for hint in plain)
    assert "pkg" in engine.TOOLCHAIN_PKGS
    assert "clang" in engine.TOOLCHAIN_PKGS["pkg"]["c"]


def test_exhausted_carries_diagnostic(engine):
    info = {"step": "DEPENDENCIES", "category": "RUST_MISSING"}
    with pytest.raises(engine.RecoveryExhausted) as caught:
        raise engine.RecoveryExhausted(info)
    assert caught.value.info["category"] == "RUST_MISSING"


def test_validate_venv_rejects_missing(engine, ctx, tmp_path):
    ok, reason = engine.validate_venv(ctx, tmp_path / "nope")
    assert ok is False
    assert "no interpreter" in reason


def test_minimal_requirements_local_only(engine, ctx, tmp_path,
                                         monkeypatch):
    monkeypatch.setattr(engine, "GOV", tmp_path / ".governance")
    req = tmp_path / "requirements.txt"
    req.write_text("uvicorn[standard]>=0.29\nfastapi>=0.100\n",
                   encoding="utf-8")
    target = engine._write_minimal_requirements(ctx, req)
    assert target is not None
    assert target.parent == tmp_path / ".governance"
    assert "uvicorn>=0.29" in target.read_text(encoding="utf-8")


def test_verify_build_saved_freshness(engine, tmp_path, monkeypatch):
    monkeypatch.setattr(engine, "ROOT", tmp_path)
    monkeypatch.setattr(engine, "GOV", tmp_path / ".governance")
    (tmp_path / "frontend" / "dist").mkdir(parents=True)
    (tmp_path / "frontend" / "dist" / "index.html").write_text(
        "x", encoding="utf-8")
    lock = tmp_path / "frontend" / "package-lock.json"
    lock.write_text("{}", encoding="utf-8")
    digest = hashlib.sha256(b"{}").hexdigest()
    (tmp_path / ".governance").mkdir()
    (tmp_path / ".governance" / "npm.json").write_text(
        json.dumps({"lock": digest}), encoding="utf-8")
    assert engine.verify_build_saved() is True
    (tmp_path / ".governance" / "npm.json").write_text(
        json.dumps({"lock": "stale"}), encoding="utf-8")
    assert engine.verify_build_saved() is False


def test_preflight_runs_on_real_requirements(engine, ctx):
    fp = {"termux": False, "libc": "gnu", "arch_machine": "x86_64",
          "python_version": "3.13.0", "os": "linux",
          "fingerprint_hash": "t" * 12}
    profile = {"platform": "linux-x86_64", "pip_ok": True,
               "compiler_c": True, "compiler_rust": False}
    flex = engine._compat.preflight(
        engine.ROOT / "backend" / "requirements.txt", fp, profile)
    assert set(flex) >= {"packages", "blockers", "warnings"}
    assert {item["package"] for item in flex["packages"]} >= {
        "fastapi", "uvicorn", "pydantic"}


def test_banner_renders_adaptive_format(engine, ctx, capsys):
    report = {"env_summary": "linux / x86_64 (abc)",
              "tools_detail": [
                  {"tool": "python3", "adaptive_status": "AVAILABLE",
                   "detected_version": "3.13.0", "role": "REQUIRED"},
                  {"tool": "git", "adaptive_status": "NOT_APPLICABLE",
                   "role": "NOT_APPLICABLE"}],
              "runtime": "ok",
              "health": [{"name": "api.health", "ok": True}],
              "recovery": []}
    engine.print_banner(ctx, report, {"api_url": "a", "web_url": "w"},
                        True)
    out = capsys.readouterr().out
    assert "APKFORGE BOOTSTRAP" in out
    assert "Run ID: test-run" in out
    assert "Engine: 2.0.0" in out
    assert "Status: READY" in out
    assert "HEALTH       OK" in out


def test_plan_consumes_mapped_engine_rows(engine, ctx):
    fp = {"termux": False, "libc": "gnu", "os": "linux",
          "os_id": "ubuntu", "arch_machine": "x86_64",
          "python_version": "3.13.0", "fingerprint_hash": "a" * 12}
    legacy = engine.detect_tools(ctx, fp)
    rows = engine._adaptive_rows(legacy)
    assert set(rows[0]) >= {"tool", "status", "role", "detected",
                            "source"}
    profile = engine._env.capability_profile(fp, rows)
    flex = {"packages": [], "blockers": [], "warnings": [],
            "offline": False}
    plan = engine._plan.build_plan(
        fp, profile, rows, flex,
        {"venv_exists": False, "venv_valid": False,
         "env_exists": False, "db_exists": False},
        {"install_tools": False, "skip_build": True,
         "offline": False})
    assert "BOOTSTRAP PLAN" in engine._plan.render_plan(plan)


def test_gitcare_status_command_shapes(engine, tmp_path, capsys,
                                       monkeypatch):
    import argparse
    import subprocess
    repo = tmp_path / "repo"
    (repo / "scripts").mkdir(parents=True)
    (repo / "scripts" / "apkforge.py").write_text("x")
    (repo / "backend").mkdir()
    (repo / "backend" / "app.py").write_text("x")
    (repo / "frontend" / "src").mkdir(parents=True)
    (repo / "frontend" / "src" / "main.ts").write_text("x")
    subprocess.run(["git", "init", "-q"], cwd=repo, check=True)
    subprocess.run(["git", "add", "-A"], cwd=repo, check=True)
    subprocess.run(["git", "-c", "user.email=t@t", "-c",
                    "user.name=t", "commit", "-qm", "init"],
                   cwd=repo, check=True)
    monkeypatch.setattr(engine, "ROOT", repo)
    monkeypatch.setattr(engine, "LOGS", tmp_path / "logs")
    args = argparse.Namespace(command_args=["status"], json=False)
    assert engine.cmd_gitcare(args) == 0
    out = capsys.readouterr().out
    assert "verdict: OK" in out
    assert "index" in out


def _ladder_fp():
    return {"termux": False, "libc": "gnu", "arch_machine": "x86_64",
            "python_version": "3.13.0", "os": "linux",
            "fingerprint_hash": "e" * 12}


def test_ladder_skips_recorded_strategy(engine, ctx, tmp_path,
                                        monkeypatch):
    monkeypatch.setattr(engine, "LOGS", tmp_path / "logs")
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    retry_key = "%s|%s|%s" % ("e" * 12, "c", "R")
    sig = engine._recovery.failure_signature(
        "DEPENDENCIES", "-", None, "native", retry_key)
    ledger.record("DEPENDENCIES", sig, "native", "pip install",
                  retry_key, "failed", "boom")
    calls = []
    monkeypatch.setattr(
        engine, "run",
        lambda *argv, **kw: calls.append(argv) or (1, "boom"))
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    with pytest.raises(engine.RecoveryExhausted) as caught:
        engine.pip_install_with_recovery(
            ctx, "/nonexistent/python", req, _ladder_fp(),
            {"platform": "linux-x86_64", "compiler_c": True,
             "compiler_rust": False}, ledger, "e" * 12,
            offline=False)
    assert calls == []
    info = caught.value.info
    assert info["tried"] == [{"strategy": "native",
                              "result": "failed"}]
    assert "already failed identically" in info["root_cause"]
    assert str(tmp_path / "ledger.jsonl") in info["ledger"]


def test_ladder_exhausts_unknown_failure(engine, ctx, tmp_path,
                                         monkeypatch):
    monkeypatch.setattr(engine, "LOGS", tmp_path / "logs")
    ledger = engine._recovery.Ledger(tmp_path / "ledger.jsonl")
    monkeypatch.setattr(engine, "run",
                        lambda *argv, **kw: (1, "boom"))
    req = tmp_path / "req.txt"
    req.write_text("pkgx>=1\n", encoding="utf-8")
    with pytest.raises(engine.RecoveryExhausted) as caught:
        engine.pip_install_with_recovery(
            ctx, "/nonexistent/python", req, _ladder_fp(),
            {"platform": "linux-x86_64", "compiler_c": True,
             "compiler_rust": False}, ledger, "e" * 12,
            offline=False)
    info = caught.value.info
    assert info["tried"] == [{"strategy": "native",
                              "result": "failed"}]
    assert info["category"] == "UNKNOWN"
    assert ledger.attempted(
        "DEPENDENCIES",
        engine._recovery.failure_signature(
            "DEPENDENCIES", "-", None, "native",
            "%s|%s|%s" % ("e" * 12, "c", "R")), "native")


def test_open_browser_prefers_termux_opener(engine, ctx,
                                            monkeypatch):
    monkeypatch.setattr(
        engine.shutil, "which",
        lambda name: "/x/termux-open-url"
        if name == "termux-open-url" else None)

    class Done:
        returncode = 0
        stdout = ""

    ran = []
    monkeypatch.setattr(
        engine.subprocess, "run",
        lambda *argv, **kw: ran.append(argv[0]) or Done())
    used = []
    monkeypatch.setattr(engine.webbrowser, "open",
                        lambda *argv, **kw: used.append(argv))
    assert engine.open_browser(ctx, "http://example/") is True
    assert ran == [["termux-open-url", "http://example/"]]
    assert used == []


def test_open_browser_falls_back_to_webbrowser(engine, ctx,
                                               tmp_path,
                                               monkeypatch):
    monkeypatch.setattr(engine.shutil, "which",
                        lambda name: None)
    monkeypatch.setattr(engine.webbrowser, "open",
                        lambda *argv, **kw: False)
    assert engine.open_browser(ctx, "http://example/") is False
    assert "open manually" in (
        tmp_path / "run.log").read_text(encoding="utf-8")
