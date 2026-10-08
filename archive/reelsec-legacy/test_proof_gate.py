import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from proof_gate import (
    BLOCKED,
    OBSERVED,
    PROVEN_ON_INSTRUMENTED_BUILD,
    PROVEN_RUNTIME_ORIGINAL,
    PROVEN_STATIC,
    UNPROVEN,
    build_evidence_ledger,
    classify_target_evidence,
    correlate_behavioral_event,
    finalize_instrumented_proof,
    screenshot_blocking_claim_allowed,
)


class ProofGateTests(unittest.TestCase):
    def test_static_never_becomes_runtime(self):
        provenance = {"target_relation": "WITHIN_ANALYSIS_ROOT"}
        self.assertEqual(classify_target_evidence(provenance), UNPROVEN)

    def test_original_runtime_requires_execution(self):
        provenance = {"target_relation": "WITHIN_ANALYSIS_ROOT"}
        self.assertEqual(
            classify_target_evidence(
                provenance, "ORIGINAL_EXECUTION_PROVEN", target_executed=True
            ),
            PROVEN_RUNTIME_ORIGINAL,
        )
        self.assertNotEqual(
            classify_target_evidence(
                provenance, "ORIGINAL_EXECUTION_PROVEN", target_executed=False
            ),
            PROVEN_RUNTIME_ORIGINAL,
        )

    def test_instrumented_is_separate_state(self):
        provenance = {"target_relation": "WITHIN_ANALYSIS_ROOT"}
        self.assertEqual(
            classify_target_evidence(
                provenance, "INSTRUMENTED_EXECUTION_PROVEN", target_executed=True
            ),
            PROVEN_ON_INSTRUMENTED_BUILD,
        )

    def test_outside_root_is_blocked_without_runtime(self):
        self.assertEqual(
            classify_target_evidence({"target_relation": "OUTSIDE_ANALYSIS_ROOT"}),
            BLOCKED,
        )

    def test_screenshot_claim_requires_full_chain(self):
        kwargs = dict(
            screenshot_event=True,
            relevant_path=True,
            target_executed=True,
            behavioral_effect=True,
            timing_correlated=True,
            alternatives_considered=True,
            runtime_proof=True,
        )
        self.assertTrue(screenshot_blocking_claim_allowed(**kwargs))
        kwargs["runtime_proof"] = False
        self.assertFalse(screenshot_blocking_claim_allowed(**kwargs))

    def test_final_classifier_requires_behavioral_correlation(self):
        provenance = {"target_relation": "WITHIN_ANALYSIS_ROOT"}
        target = {"runtime_observed": True}
        dispatch = {"dispatch_relationship_observed": True}

        result = finalize_instrumented_proof(
            provenance, target, dispatch, {"correlated": False}
        )
        self.assertEqual(result["state"], OBSERVED)
        self.assertFalse(result["causal_proof"])

        result = finalize_instrumented_proof(
            provenance, target, dispatch, {"correlated": True}
        )
        self.assertEqual(result["state"], PROVEN_ON_INSTRUMENTED_BUILD)
        self.assertFalse(result["causal_proof"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
