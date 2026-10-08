#!/usr/bin/env python3
"""Tests for the A/B/C differential-isolation matrix (pure logic).

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


if __name__ == "__main__":
    unittest.main(verbosity=2)
