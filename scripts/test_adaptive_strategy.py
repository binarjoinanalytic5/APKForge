"""Strategy engine tests: changed attempts allowed, repeats blocked."""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from adaptive import recovery as R  # noqa: E402
from adaptive import strategy as S  # noqa: E402


def _tools(env_hash="e" * 12):
    return {"tools": {"rustc": "1.99.0", "cc": "clang 19"},
            "hash": "t" * 16, "env_hash": env_hash}


def _fp(**over):
    base = {"step": "DEPENDENCIES", "strategy": "native",
            "package": "pydantic-core", "version": None,
            "python": "3.14.6", "arch": "aarch64",
            "platform": "android-termux",
            "command": "pip install -r backend/requirements.txt",
            "requirements_text": "pydantic>=2.6\n",
            "toolchain_fp": _tools(), "run_id": "r1"}
    base.update(over)
    row = S.attempt_fingerprint(
        base["step"], base["strategy"], base["package"],
        base["version"], base["python"], base["arch"],
        base["platform"], base["command"],
        base["requirements_text"], base["toolchain_fp"],
        run_id=base["run_id"])
    return row


def _write(tmp_path, *rows):
    path = tmp_path / "ledger.jsonl"
    with open(path, "a", encoding="utf-8") as handle:
        for row in rows:
            handle.write(json.dumps(row) + "\n")
    return path


def test_attempt_id_stable_for_identical_inputs():
    assert _fp()["attempt_id"] == _fp()["attempt_id"]


def test_changed_toolchain_reopens_attempt():
    before = _fp()
    tools = _tools()
    tools["tools"] = {"rustc": "1.98.1", "cc": "clang 19"}
    tools["hash"] = "o" * 16
    after = _fp(toolchain_fp=tools)
    assert before["attempt_id"] != after["attempt_id"]


def test_changed_python_or_requirements_reopen():
    assert _fp()["attempt_id"] != _fp(python="3.12.0")["attempt_id"]
    assert _fp()["attempt_id"] != _fp(
        requirements_text="pydantic==2.9\n")["attempt_id"]
    assert _fp()["attempt_id"] != _fp(
        strategy="version:pydantic-core==2.9")["attempt_id"]


def test_identical_attempt_matches_full_row(tmp_path):
    row = _fp()
    row.update({"category": "RUST_MISSING", "result": "failed"})
    path = _write(tmp_path, row)
    assert S.identical_attempt(path, _fp()) is not None
    assert S.identical_attempt(path, _fp(python="3.12.0")) is None


def test_failure_memory_prefers_newest_attempt(tmp_path):
    first = _fp(strategy="native")
    first.update({"category": "WHEEL_UNAVAILABLE",
                  "result": "failed"})
    second = _fp(strategy="version:pydantic-core==2.9")
    second.update({"category": "RUST_MISSING", "result": "failed"})
    path = _write(tmp_path, first, second)
    memory = S.last_failure(path)
    assert memory["package"] == "pydantic-core"
    assert memory["category"] == "RUST_MISSING"
    assert memory["strategy"] == "version:pydantic-core==2.9"


def test_failure_memory_reads_legacy_rows(tmp_path):
    ledger = R.Ledger(tmp_path / "ledger.jsonl")
    ledger.record("DEPENDENCIES", "sig", "native", "pip install",
                  "e" * 12, "failed",
                  "ERROR: No matching distribution found for "
                  "pydantic-core")
    memory = S.last_failure(tmp_path / "ledger.jsonl")
    assert memory["package"] == "pydantic-core"
    assert memory["category"] == "WHEEL_UNAVAILABLE"


def test_flaky_network_bounded_to_three(tmp_path):
    path = tmp_path / "ledger.jsonl"
    row = _fp()
    assert S.flaky_retry_allowed(path, row, "NETWORK_FAILURE")
    assert not S.flaky_retry_allowed(path, row, "RUST_MISSING")
    for _ in range(3):
        logged = dict(row)
        logged.update({"category": "NETWORK_FAILURE",
                       "result": "failed"})
        _write(tmp_path, logged)
    assert not S.flaky_retry_allowed(path, row, "NETWORK_FAILURE")


def test_signals_pick_missing_inputs():
    log = ("/bin/sh: 1: pkg-config: not found\n"
           "fatal error: Python.h: No such file\n"
           "error: linker `cc` not found\n")
    signals = S.extract_signals(log)
    kinds = {(item["kind"], item["target"]) for item in signals}
    assert ("missing-command", "pkg-config") in kinds
    assert ("missing-header", "Python.h") in kinds
    assert ("missing-linker", "cc") in kinds
    assert S.sysdeps_for_signals(signals, termux=True) == [
        "pkg-config", "clang", "python"]


def test_order_prefers_changed_strategies():
    rust = S.order_candidates(
        {"category": "RUST_MISSING", "package": "pydantic-core"},
        {"termux": True, "provision_ok": True, "offline": False,
         "direct": {"pydantic"}, "alternate_pythons": [],
         "signals": []})
    ids = [item["id"] for item in rust]
    assert ids[0] == "android_prebuilt_wheel"
    assert "toolchain" in ids
    assert "native" in ids
    assert "minimal" not in ids  # required package: never dropped

    net = S.order_candidates(
        {"category": "NETWORK_FAILURE", "package": None},
        {"termux": True, "provision_ok": True, "offline": False,
         "direct": set(), "alternate_pythons": [],
         "signals": []})
    assert [item["id"] for item in net][0] == "retry"

    pyincompat = S.order_candidates(
        {"category": "PYTHON_INCOMPATIBILITY",
         "package": "pydantic-core"},
        {"termux": True, "provision_ok": True, "offline": False,
         "direct": {"pydantic"}, "alternate_pythons": [{"exe": "x"}],
         "signals": []})
    assert [item["id"] for item in pyincompat] == [
        "version", "runtime", "native"]

    extra = S.order_candidates(
        {"category": "WHEEL_UNAVAILABLE", "package": "uvloop"},
        {"termux": True, "provision_ok": False, "offline": False,
         "direct": {"uvicorn"}, "alternate_pythons": [],
         "signals": []})
    assert "minimal" in [item["id"] for item in extra]


def test_droppable_only_for_non_direct():
    assert S.droppable("uvloop", {"uvicorn"})
    assert not S.droppable("pydantic-core", {"pydantic"})
    assert not S.droppable("pydantic-core", {"pydantic-core"})
    assert not S.droppable(None, set())


def test_blocked_ideas_name_unlocks():
    ideas = S.blocked_ideas(
        {"category": "WHEEL_UNAVAILABLE",
         "package": "pydantic-core"},
        {"termux": True, "provision_ok": True, "offline": False,
         "alternate_pythons": [], "version_ok": False})
    assert any("pydantic-core" in idea for idea in ideas)
    assert any("python3.12" in idea for idea in ideas)
