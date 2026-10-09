"""Stage checkpoints: resume from the last verified state.

Checkpoints live in .governance/bootstrap-state.json alongside the
legacy {run_id, state, history} payload (which is preserved). A
stage is skipped only when: recorded ok + fingerprint unchanged +
light verification passes. Anything else re-runs the stage.
"""
from __future__ import annotations

import json
import time
from pathlib import Path

STATE_FILE = "bootstrap-state.json"


def _now():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())


def state_path(gov):
    return Path(gov) / STATE_FILE


def load(gov):
    """Read checkpoint state (None when missing/corrupt)."""
    path = state_path(gov)
    if not path.is_file():
        return None
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return None
    return data if isinstance(data, dict) else None


def save_stage(gov, stage_id, detail, fingerprint_hash,
               run_id):
    """Record one verified stage, preserving legacy keys."""
    gov = Path(gov)
    gov.mkdir(parents=True, exist_ok=True)
    data = load(gov) or {}
    stages = data.get("stages")
    if not isinstance(stages, dict):
        stages = {}
    stages[stage_id] = {"ok": True, "run_id": run_id,
                        "ts": _now(), "detail": detail}
    data["stages"] = stages
    data["fingerprint_hash"] = fingerprint_hash
    state_path(gov).write_text(json.dumps(data, indent=2),
                               encoding="utf-8")
    return data


def should_skip(gov, stage_id, fingerprint_hash, verify):
    """True only if checkpoint ok + env unchanged + verify passes."""
    data = load(gov)
    if not data or data.get("fingerprint_hash") != \
            fingerprint_hash:
        return False
    entry = (data.get("stages") or {}).get(stage_id)
    if not entry or not entry.get("ok"):
        return False
    try:
        return bool(verify())
    except Exception:
        return False


def completed_stages(gov):
    data = load(gov) or {}
    return sorted(stage for stage, entry
                  in (data.get("stages") or {}).items()
                  if entry.get("ok"))
