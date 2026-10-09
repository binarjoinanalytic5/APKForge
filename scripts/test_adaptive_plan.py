"""Adaptive plan + checkpoint tests (pure, tmp state)."""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from adaptive import checkpoint as CP  # noqa: E402
from adaptive import plan as P  # noqa: E402

FP = {"arch_machine": "aarch64", "fingerprint_hash": "abc123"}
PROFILE = {"platform": "android-termux",
           "package_manager": "pkg"}
ROWS = [
    {"tool": "python3", "role": "REQUIRED",
     "status": "AVAILABLE", "detected": "3.14.6",
     "path": "/usr/bin/python3", "method": "", "source": ""},
    {"tool": "node", "role": "REQUIRED", "status": "MISSING",
     "detected": "-", "path": None,
     "method": "pkg install nodejs", "source": "pkg"},
    {"tool": "docker", "role": "PHASE_DEPENDENT",
     "status": "NOT_APPLICABLE", "detected": "-",
     "path": None, "method": "", "source": ""},
]
PREFLIGHT = {
    "packages": [
        {"package": "fastapi", "status": "WHEEL_OK",
         "build": [], "requested": ""},
        {"package": "pydantic-core", "status": "NEEDS_BUILD",
         "build": ["rust"], "requested": "", "version": "2.33"},
    ],
    "blockers": ["pydantic-core: no compatible wheel; needs rust"],
    "warnings": [],
}


def test_build_plan_actions():
    plan = P.build_plan(FP, PROFILE, ROWS, PREFLIGHT,
                        {"venv_exists": False,
                         "env_exists": True, "db_exists": False},
                        {"install_tools": False,
                         "skip_build": False, "offline": False})
    actions = {(step["id"], step["action"]) for step in
               plan["steps"]}
    assert ("TOOLS:python3", "REUSE") in actions
    assert ("TOOLS:node", "PROVISION") in actions
    assert ("TOOLS:docker", "SKIP") in actions
    assert ("RUNTIME", "CREATE") in actions
    assert ("CONFIG", "VERIFY") in actions
    assert ("DATABASE", "CREATE") in actions
    assert any(step["id"] == "DEPENDENCIES:rust"
               for step in plan["steps"])
    assert plan["may_fail"] == PREFLIGHT["blockers"]


def test_render_plan_human_readable():
    plan = P.build_plan(FP, PROFILE, ROWS, PREFLIGHT, {},
                        {"offline": True})
    text = P.render_plan(plan)
    assert "BOOTSTRAP PLAN" in text
    assert "REUSE" in text and "PROVISION" in text
    assert "may fail (preflight)" in text
    assert "offline" in text


def test_checkpoint_save_skip_invalidate(tmp_path):
    gov = tmp_path / ".governance"
    assert CP.should_skip(gov, "TOOLS", "h1",
                          lambda: True) is False
    CP.save_stage(gov, "TOOLS", "3 tools", "h1", "APKFORGE-R1")
    assert CP.should_skip(gov, "TOOLS", "h1",
                          lambda: True) is True
    assert CP.should_skip(gov, "TOOLS", "h1",
                          lambda: False) is False
    assert CP.should_skip(gov, "TOOLS", "changed",
                          lambda: True) is False
    assert CP.should_skip(gov, "OTHER", "h1",
                          lambda: True) is False
    assert CP.completed_stages(gov) == ["TOOLS"]
    (gov / "bootstrap-state.json").write_text("corrupt",
                                              encoding="utf-8")
    assert CP.should_skip(gov, "TOOLS", "h1",
                          lambda: True) is False
    assert CP.load(gov) is None
