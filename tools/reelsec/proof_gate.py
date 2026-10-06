#!/usr/bin/env python3
"""Conservative evidence classification for ReelSec artifacts."""

PROVEN_STATIC = "PROVEN_STATIC"
PROVEN_RUNTIME_ORIGINAL = "PROVEN_RUNTIME_ORIGINAL"
PROVEN_ON_INSTRUMENTED_BUILD = "PROVEN_ON_INSTRUMENTED_BUILD"
OBSERVED = "OBSERVED"
SUPPORTED = "SUPPORTED"
LIKELY = "LIKELY"
UNPROVEN = "UNPROVEN"
BLOCKED = "BLOCKED"
FAILED = "FAILED"


def classify_target_evidence(provenance, runtime_status=None, target_executed=False, static_evidence_proven=False):
    """Never promote static provenance to runtime proof."""
    if not provenance or provenance.get("target_relation") != "WITHIN_ANALYSIS_ROOT":
        return BLOCKED if runtime_status in (None, "BLOCKED") else UNPROVEN

    if runtime_status == "ORIGINAL_EXECUTION_PROVEN" and target_executed:
        return PROVEN_RUNTIME_ORIGINAL

    if runtime_status == "INSTRUMENTED_EXECUTION_PROVEN" and target_executed:
        return PROVEN_ON_INSTRUMENTED_BUILD

    if target_executed:
        return OBSERVED

    if static_evidence_proven:
        return PROVEN_STATIC
    return UNPROVEN


def screenshot_blocking_claim_allowed(*, screenshot_event, relevant_path,
                                      target_executed, behavioral_effect,
                                      timing_correlated, alternatives_considered,
                                      runtime_proof=False):
    """Require the full causal chain before permitting a blocking claim."""
    return all((
        screenshot_event,
        relevant_path,
        target_executed,
        behavioral_effect,
        timing_correlated,
        alternatives_considered,
        runtime_proof,
    ))


def build_instrumented_runtime_proof(provenance, target_observation, dispatch_observation):
    """Return a proof state only when artifact provenance and both runtime observations agree."""
    if not provenance or provenance.get("target_relation") != "WITHIN_ANALYSIS_ROOT":
        return {"state": BLOCKED, "causal_proof": False}
    target_ok = target_observation.get("runtime_observed") is True
    dispatch_ok = dispatch_observation.get("dispatch_relationship_observed") is True
    if target_ok and dispatch_ok:
        return {
            "state": PROVEN_ON_INSTRUMENTED_BUILD,
            "causal_proof": False,
            "requirements": {
                "artifact_provenance": True,
                "target_execution": True,
                "vtable_dispatch": True,
                "behavioral_correlation": False,
            },
        }
    return {"state": UNPROVEN, "causal_proof": False}


def correlate_behavioral_event(target_event, behavior_event, window_ms=1000):
    """Correlate two observed events by monotonic timestamps only.
    Correlation is not itself proof of causality.
    """
    if not isinstance(target_event, dict) or not isinstance(behavior_event, dict):
        return {"correlated": False, "causal_proof": False, "reason": "invalid_event"}
    t = target_event.get("timestamp_ms")
    b = behavior_event.get("timestamp_ms")
    if not isinstance(t, (int, float)) or not isinstance(b, (int, float)):
        return {"correlated": False, "causal_proof": False, "reason": "missing_timestamp"}
    delta = abs(b - t)
    correlated = delta <= window_ms
    return {
        "correlated": correlated,
        "delta_ms": delta,
        "window_ms": window_ms,
        "causal_proof": False,
        "reason": "within_window" if correlated else "outside_window",
    }
