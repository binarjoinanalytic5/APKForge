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


def validate_target_observation(event, expected_module, expected_offset):
    """Validate an observation without claiming causality."""
    if not isinstance(event, dict):
        raise GadgetObserverError("observation event must be an object")
    module = event.get("module")
    offset = event.get("offset")
    executed = bool(event.get("target_executed"))
    result = {
        "target_executed": executed,
        "module_match": module == expected_module,
        "offset_match": offset == expected_offset,
        "runtime_observed": False,
        "causal_proof": False,
        "proof_class": "OBSERVED",
    }
    result["runtime_observed"] = (
        executed and result["module_match"] and result["offset_match"]
    )
    if result["runtime_observed"]:
        result["proof_class"] = "TARGET_EXECUTION_OBSERVED"
    return result


def validate_vtable_dispatch(event, expected):
    """Validate the observed vtable/slot/target tuple without inferring causality."""
    if not isinstance(event, dict) or not isinstance(expected, dict):
        raise GadgetObserverError("event and expected relationship must be objects")
    checks = {
        "vtable_match": event.get("vtable") == expected.get("vtable"),
        "slot_match": event.get("slot") == expected.get("slot"),
        "target_match": event.get("target") == expected.get("target"),
    }
    checks["dispatch_relationship_observed"] = all(checks.values())
    checks["causal_proof"] = False
    checks["proof_class"] = (
        "VTABLE_DISPATCH_OBSERVED"
        if checks["dispatch_relationship_observed"]
        else "OBSERVED"
    )
    return checks
