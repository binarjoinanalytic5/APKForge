#!/usr/bin/env python3
"""Tests for the A/B/B1/B2/C differential-isolation matrix (pure logic).

Arm A (test-signed original) vs arm B (rebuild + re-sign, zero mutations)
vs arm C (rebuild + LOG_I_PROBE, no Gadget): the decision rules must name
only separated deltas, and missing arms must degrade to INCONCLUSIVE —
never a guess.
"""
import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from isolation import (
    IsolationError,
    build_arm_record,
    crash_signature,
    decide_isolation,
    plan_matrix,
)


def _health(startup, signal=None, library=None, pc=None, pids=None):
    health = {"startup": startup, "pids": pids or [100],
              "process_alive_ms": 500,
              "crash_session_binding": {"bound": bool(signal),
                                        "method": "BUFFER_DIFF"}}
    if signal:
        health["crash_artifact"] = {
            "fatal_signal": signal,
            "fault_location": {"library": library, "pc": pc},
            "abort_message_present": False}
    return health


def _record(arm, status, signal="SIGABRT", library="libc.so",
            pc="000537d4"):
    install = {"success": status != "BLOCKED_INSTALL",
               "stage": "install", "mode": "INSTALL_R",
               "output_tail": "Success" if status != "BLOCKED_INSTALL"
               else "INSTALL_FAILED_X"}
    identity = {"identity": "MATCH" if status in (
        "HEALTHY", "CRASHED", "BLOCKED_ASSESS")
        else "MISMATCH" if status == "BLOCKED_IDENTITY"
        else "UNVERIFIED"}
    assess = None
    if status == "HEALTHY":
        assess = _health("PASS")
    elif status == "CRASHED":
        assess = _health("CRASH", signal, library, pc)
    elif status == "BLOCKED_ASSESS":
        assess = _health(None)
    return build_arm_record(
        arm=arm, artifact_sha256="a" * 64,
        certificate_sha256="b" * 64, install=install,
        identity=identity, assess=assess)


class PlanMatrixTests(unittest.TestCase):
    def test_default_runs_abc(self):
        plan = plan_matrix({})
        self.assertEqual(plan["arms"], ["A", "B", "C"])

    def test_subset_and_dedup(self):
        plan = plan_matrix({"REELSEC_ISOLATION_MATRIX": "cbac"})
        self.assertEqual(plan["arms"], ["C", "B", "A"])

    def test_unknown_arm_refused(self):
        with self.assertRaises(IsolationError):
            plan_matrix({"REELSEC_ISOLATION_MATRIX": "ABD"})

    def test_gadget_refused(self):
        with self.assertRaises(IsolationError):
            plan_matrix({"REELSEC_USE_GADGET": "1"})
        with self.assertRaises(IsolationError):
            plan_matrix({"REELSEC_USE_GADGET": "yes",
                         "REELSEC_ISOLATION_MATRIX": "A"})


class ArmRecordTests(unittest.TestCase):
    def test_healthy_record(self):
        record = _record("A", "HEALTHY")
        self.assertEqual(record["status"], "HEALTHY")
        self.assertEqual(record["pids"], [100])
        self.assertEqual(record["artifact_sha256"], "a" * 64)
        self.assertEqual(record["certificate_sha256"], "b" * 64)
        self.assertTrue(record["install"]["success"])
        self.assertEqual(record["startup"], "PASS")

    def test_crashed_record_carries_signature(self):
        record = _record("C", "CRASHED")
        self.assertEqual(record["status"], "CRASHED")
        self.assertEqual(record["crash"]["fatal_signal"], "SIGABRT")
        self.assertEqual(record["crash"]["fault_library"], "libc.so")
        self.assertEqual(record["crash"]["fault_pc"], "000537d4")
        self.assertEqual(crash_signature(record),
                         "SIGABRT|libc.so|000537d4")

    def test_install_failure_blocks(self):
        record = _record("B", "BLOCKED_INSTALL")
        self.assertEqual(record["status"], "BLOCKED_INSTALL")
        self.assertIsNone(record["startup"])

    def test_identity_mismatch_blocks(self):
        record = _record("B", "BLOCKED_IDENTITY")
        self.assertEqual(record["status"], "BLOCKED_IDENTITY")
        self.assertIsNone(record["startup"])

    def test_missing_startup_blocks_assess(self):
        record = _record("B", "BLOCKED_ASSESS")
        self.assertEqual(record["status"], "BLOCKED_ASSESS")

    def test_malformed_inputs_rejected(self):
        with self.assertRaises(IsolationError):
            build_arm_record(arm="D", artifact_sha256="a",
                             certificate_sha256="b",
                             install={"success": True}, identity={},
                             assess=None)
        with self.assertRaises(IsolationError):
            build_arm_record(arm="A", artifact_sha256="a",
                             certificate_sha256="b",
                             install={}, identity={}, assess=None)
        with self.assertRaises(IsolationError):
            build_arm_record(arm="A", artifact_sha256=None,
                             certificate_sha256="b",
                             install={"success": True},
                             identity={"identity": "MATCH"},
                             assess=_health("PASS"))

    def test_signature_none_without_crash(self):
        self.assertIsNone(crash_signature(_record("A", "HEALTHY")))
        self.assertIsNone(crash_signature(None))


class DecideIsolationTests(unittest.TestCase):
    def test_original_crash_excludes_reelsec(self):
        decision = decide_isolation({
            "A": _record("A", "CRASHED"),
            "B": _record("B", "CRASHED"),
            "C": _record("C", "CRASHED")})
        self.assertEqual(decision["status"], "NOT_REELSEC_CAUSE")
        self.assertEqual(decision["regression"], "NOT_ESTABLISHED")
        self.assertEqual(decision["candidates"], [])
        self.assertIn("LOG_I_PROBE telemetry probe",
                      decision["excluded"])
        self.assertTrue(decision["crash_signatures_equal"])

    def test_original_crash_flags_healthy_rebuild_anomaly(self):
        decision = decide_isolation({
            "A": _record("A", "CRASHED"),
            "B": _record("B", "HEALTHY")})
        self.assertEqual(decision["status"], "NOT_REELSEC_CAUSE")
        self.assertIn("anomaly", decision["detail"])

    def test_repackaging_candidate(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B": _record("B", "CRASHED"),
            "C": _record("C", "CRASHED")})
        self.assertEqual(decision["status"],
                         "REPACKAGING_SIGNING_CANDIDATE")
        self.assertEqual(decision["regression"], "SUSPECTED_NOT_PROVEN")
        self.assertIn("apktool rebuild + zipalign",
                      decision["candidates"])
        self.assertIn("LOG_I_PROBE telemetry probe",
                      decision["excluded"])
        self.assertNotIn("instrumentation", " ".join(
            decision["candidates"]).lower())

    def test_probe_candidate(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B": _record("B", "HEALTHY"),
            "C": _record("C", "CRASHED")})
        self.assertEqual(decision["status"], "TELEMETRY_PROBE_CANDIDATE")
        self.assertEqual(decision["regression"], "SUSPECTED_NOT_PROVEN")
        self.assertIn("LOG_I_PROBE", " ".join(decision["candidates"]))
        self.assertIn("apktool rebuild", decision["excluded"])

    def test_no_crash_reproduced(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B": _record("B", "HEALTHY"),
            "C": _record("C", "HEALTHY")})
        self.assertEqual(decision["status"], "NO_CRASH_REPRODUCED")
        self.assertEqual(decision["regression"], "NOT_ESTABLISHED")
        self.assertEqual(decision["candidates"], [])

    def test_missing_baseline_inconclusive(self):
        decision = decide_isolation({
            "B": _record("B", "CRASHED"),
            "C": _record("C", "CRASHED")})
        self.assertEqual(decision["status"], "INCONCLUSIVE")
        self.assertEqual(decision["reason"], "INCONCLUSIVE_NO_BASELINE")

    def test_blocked_baseline_inconclusive(self):
        decision = decide_isolation({
            "A": _record("A", "BLOCKED_INSTALL"),
            "B": _record("B", "HEALTHY"),
            "C": _record("C", "CRASHED")})
        self.assertEqual(decision["status"], "INCONCLUSIVE")

    def test_missing_b_inconclusive(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "C": _record("C", "CRASHED")})
        self.assertEqual(decision["status"], "INCONCLUSIVE")
        self.assertEqual(decision["reason"], "INCONCLUSIVE_B_MISSING")

    def test_missing_c_inconclusive(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B": _record("B", "HEALTHY")})
        self.assertEqual(decision["status"], "INCONCLUSIVE")
        self.assertEqual(decision["reason"], "INCONCLUSIVE_C_MISSING")

    def test_differing_signatures_noted(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B": _record("B", "CRASHED", pc="00000001"),
            "C": _record("C", "CRASHED", pc="00000002")})
        self.assertEqual(decision["status"],
                         "REPACKAGING_SIGNING_CANDIDATE")
        self.assertFalse(decision["crash_signatures_equal"])
        self.assertIn("DIFFERING", decision["detail"])

    def test_empty_and_unknown_rejected(self):
        with self.assertRaises(IsolationError):
            decide_isolation({})
        with self.assertRaises(IsolationError):
            decide_isolation({"D": _record("A", "HEALTHY")})


class PlanNarrowingTests(unittest.TestCase):
    def test_ab1b2_scope(self):
        plan = plan_matrix({"REELSEC_ISOLATION_MATRIX": "AB1B2"})
        self.assertEqual(plan["arms"], ["A", "B1", "B2"])

    def test_narrowing_order_and_dedup(self):
        plan = plan_matrix({"REELSEC_ISOLATION_MATRIX": "B2B1B2A"})
        self.assertEqual(plan["arms"], ["B2", "B1", "A"])

    def test_bare_digit_refused(self):
        with self.assertRaises(IsolationError):
            plan_matrix({"REELSEC_ISOLATION_MATRIX": "AB12"})

    def test_b_and_narrowing_mix(self):
        plan = plan_matrix({"REELSEC_ISOLATION_MATRIX": "ABB1"})
        self.assertEqual(plan["arms"], ["A", "B", "B1"])


class DecideNarrowingTests(unittest.TestCase):
    def test_unaligned_rebuild_crash_suffices(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B1": _record("B1", "CRASHED"),
            "B2": _record("B2", "CRASHED")},
            planned=["A", "B1", "B2"])
        self.assertEqual(decision["status"], "REBUILD_SUFFICES")
        self.assertEqual(decision["reason"], "UNALIGNED_REBUILD_CRASHES")
        self.assertEqual(decision["regression"], "SUSPECTED_NOT_PROVEN")
        self.assertIn("apktool rebuild",
                      " ".join(decision["candidates"]))
        self.assertIn("LOG_I_PROBE telemetry probe",
                      decision["excluded"])
        self.assertIn("Frida Gadget", decision["excluded"])
        self.assertTrue(decision["crash_signatures_equal"])

    def test_b1_crash_claims_without_b2(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B1": _record("B1", "CRASHED")},
            planned=["A", "B1"])
        self.assertEqual(decision["status"], "REBUILD_SUFFICES")

    def test_aligned_only_crash_points_at_alignment(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B1": _record("B1", "HEALTHY"),
            "B2": _record("B2", "CRASHED")},
            planned=["A", "B1", "B2"])
        self.assertEqual(decision["status"], "ALIGNMENT_CANDIDATE")
        self.assertEqual(decision["reason"], "ALIGNED_REBUILD_CRASHES")
        self.assertIn("zipalign", " ".join(decision["candidates"]))
        self.assertIn("LOG_I_PROBE telemetry probe",
                      decision["excluded"])

    def test_b1_crash_b2_healthy_is_anomaly(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B1": _record("B1", "CRASHED"),
            "B2": _record("B2", "HEALTHY")},
            planned=["A", "B1", "B2"])
        self.assertEqual(decision["status"], "INCONCLUSIVE")
        self.assertEqual(decision["reason"],
                         "ALIGNMENT_ORDER_ANOMALY")

    def test_missing_b2_inconclusive(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B1": _record("B1", "HEALTHY")},
            planned=["A", "B1", "B2"])
        self.assertEqual(decision["status"], "INCONCLUSIVE")
        self.assertEqual(decision["reason"], "INCONCLUSIVE_B2_MISSING")

    def test_missing_b1_inconclusive(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B2": _record("B2", "HEALTHY")},
            planned=["A", "B1", "B2"])
        self.assertEqual(decision["status"], "INCONCLUSIVE")
        self.assertEqual(decision["reason"], "INCONCLUSIVE_B1_MISSING")

    def test_b2_substitutes_b(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B2": _record("B2", "CRASHED")},
            planned=["A", "B2"])
        self.assertEqual(decision["status"],
                         "REPACKAGING_SIGNING_CANDIDATE")
        self.assertIn("arm B2", decision["detail"])

    def test_b2_substitutes_b_for_probe_rule(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B2": _record("B2", "HEALTHY"),
            "C": _record("C", "CRASHED")},
            planned=["A", "B2", "C"])
        self.assertEqual(decision["status"],
                         "TELEMETRY_PROBE_CANDIDATE")

    def test_narrowing_all_healthy_reproduces_nothing(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B1": _record("B1", "HEALTHY"),
            "B2": _record("B2", "HEALTHY")},
            planned=["A", "B1", "B2"])
        self.assertEqual(decision["status"], "NO_CRASH_REPRODUCED")

    def test_partial_scope_all_healthy_stays_inconclusive(self):
        decision = decide_isolation({
            "A": _record("A", "HEALTHY"),
            "B1": _record("B1", "HEALTHY")},
            planned=["A", "B1"])
        self.assertEqual(decision["status"], "INCONCLUSIVE")
        self.assertEqual(decision["reason"],
                         "INCONCLUSIVE_SCOPE_PARTIAL")

    def test_unknown_planned_arm_rejected(self):
        with self.assertRaises(IsolationError):
            decide_isolation({"A": _record("A", "HEALTHY")},
                             planned=["A", "D"])

    def test_narrowing_arm_records(self):
        for arm in ("B1", "B2"):
            record = _record(arm, "HEALTHY")
            self.assertEqual(record["status"], "HEALTHY")
            self.assertIn("zero mutations", record["description"])
        with self.assertRaises(IsolationError):
            build_arm_record(arm="B3", artifact_sha256="a",
                             certificate_sha256="b",
                             install={"success": True}, identity={},
                             assess=None)


if __name__ == "__main__":
    unittest.main(verbosity=2)
