#!/usr/bin/env python3
"""Guarded Frida Gadget observation planning for instrumented ReelSec artifacts."""
import hashlib
import json
from pathlib import Path


class GadgetObserverError(RuntimeError):
    pass


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def plan_gadget_observation(
    artifact_path,
    package_name,
    target_offset=None,
    module_name="libsaasCorePlayer.so",
):
    artifact = Path(artifact_path).resolve()
    if not artifact.is_file():
        raise GadgetObserverError("instrumented artifact is missing")
    if not package_name:
        raise GadgetObserverError("package name is required")
    return {
        "schema_version": 1,
        "status": "READY",
        "mode": "OBSERVATION_ONLY",
        "artifact": {
            "path": str(artifact),
            "sha256": sha256_file(artifact),
        },
        "package": package_name,
        "module": module_name,
        "target_offset": target_offset,
        "requires_gadget": True,
        "mutates_original_apk": False,
        "causal_proof": False,
        "proof_class": "OBSERVED_ONLY",
    }


def observation_record(plan, event=None):
    if plan.get("status") != "READY":
        raise GadgetObserverError("observation plan is not ready")
    record = dict(plan)
    record["event"] = event or {}
    record["proof_class"] = "OBSERVED"
    record["causal_proof"] = False
    return record


def write_plan(path, plan):
    p = Path(path).resolve()
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(plan, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return p
