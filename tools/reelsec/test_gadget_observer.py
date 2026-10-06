import tempfile
import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from gadget_observer import (
    GadgetObserverError,
    observation_record,
    validate_target_observation,
    validate_vtable_dispatch,
    plan_gadget_observation,
)


class GadgetObserverTests(unittest.TestCase):
    def test_plan_binds_artifact_and_is_observation_only(self):
        with tempfile.TemporaryDirectory() as tmp:
            apk = Path(tmp) / "instrumented.apk"
            apk.write_bytes(b"apk")
            plan = plan_gadget_observation(
                apk, "com.example.test", target_offset="0x27a510"
            )
            self.assertEqual(plan["status"], "READY")
            self.assertEqual(plan["mode"], "OBSERVATION_ONLY")
            self.assertTrue(plan["requires_gadget"])
            self.assertFalse(plan["mutates_original_apk"])
            self.assertFalse(plan["causal_proof"])

    def test_observation_does_not_upgrade_to_causal_proof(self):
        with tempfile.TemporaryDirectory() as tmp:
            apk = Path(tmp) / "instrumented.apk"
            apk.write_bytes(b"apk")
            plan = plan_gadget_observation(apk, "com.example.test")
            result = observation_record(plan, {"target_hit": True})
            self.assertEqual(result["proof_class"], "OBSERVED")
            self.assertFalse(result["causal_proof"])

    def test_target_observation_requires_matching_module_and_offset(self):
        event = {"target_executed": True, "module": "libsaasCorePlayer.so", "offset": "0x27a510"}
        result = validate_target_observation(event, "libsaasCorePlayer.so", "0x27a510")
        self.assertTrue(result["runtime_observed"])
        self.assertEqual(result["proof_class"], "TARGET_EXECUTION_OBSERVED")
        self.assertFalse(result["causal_proof"])

    def test_vtable_dispatch_requires_all_three_fields(self):
        expected = {"vtable": "0x717e60", "slot": "0x108", "target": "0x27a510"}
        result = validate_vtable_dispatch(expected, expected)
        self.assertTrue(result["dispatch_relationship_observed"])
        self.assertEqual(result["proof_class"], "VTABLE_DISPATCH_OBSERVED")
        self.assertFalse(result["causal_proof"])

        incomplete = dict(expected)
        incomplete["slot"] = "0x110"
        result = validate_vtable_dispatch(incomplete, expected)
        self.assertFalse(result["dispatch_relationship_observed"])

    def test_missing_artifact_rejected(self):
        with self.assertRaises(GadgetObserverError):
            plan_gadget_observation("/missing.apk", "com.example.test")


if __name__ == "__main__":
    unittest.main(verbosity=2)
