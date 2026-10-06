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
