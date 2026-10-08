#!/usr/bin/env python3
"""Safety-by-design tests.

The 2026-10-07 incident (DESTRUCTIVE BASELINE UNINSTALL under a bare env
flag) must be structurally impossible after these tests:

* blanket env flags are violations, never authorizations
* deny is the in-code default for every destructive operation
* authorization requires exact package/user/device match + time bounds
* FACTORY_RESET is never executable even when authorized
* every attempt (executed or blocked) produces an audit record
* the platform refuses to run any campaign while a blanket flag is set
"""
import importlib.util
import json
import tempfile
import time
import unittest
from pathlib import Path

import collectors as col
import orchestrator as orch
import safety_gate as sg

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("reelsec", HERE / "reelsec.py")
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


def _auth_doc(td, **over):
    doc = {
        "schema_version": sg.SCHEMA_AUTH,
        "operation": "UNINSTALL",
        "package": "com.test.pkg",
        "user": 0,
        "device_serial": "s1",
        "issued_at_epoch": time.time() - 10,
        "expires_at_epoch": time.time() + 600,
        "authorized_by": "operator",
        "reason": "test",
    }
    doc.update(over)
    p = Path(td) / "auth.json"
    p.write_text(json.dumps(doc), encoding="utf-8")
    return str(p)


def _device_runner(package_present=True):
    calls = []
    state = {"present": package_present}

    def runner(cmd, timeout=60):
        calls.append([str(c) for c in cmd])
        joined = " ".join(str(c) for c in cmd)
        if "getprop" in joined:
            return 0, "samsung/x/y:13"
        if "pm list users" in joined:
            return 0, "Users:\n\tUserInfo{0:Owner:13}"
        if "pm path" in joined:
            return (0, "package:/data/app/base.apk") if state["present"] else (0, "")
        if "ps -A" in joined:
            return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
        if "pm uninstall" in joined:
            runner.uninstalled = True
            state["present"] = False  # device state changes, as on a real device
            return 0, "Success"
        if "pm clear" in joined:
            return 0, "Success"
        return 1, ""
    runner.calls = calls
    runner.uninstalled = False
    return runner


class PolicyTests(unittest.TestCase):
    def test_deny_is_the_in_code_default(self):
        for op in sg.DESTRUCTIVE_OPERATIONS:
            self.assertEqual(sg.DEFAULT_POLICY[op], "DENY")

    def test_legacy_flag_is_a_violation_not_an_authorization(self):
        v = sg.inspect_environment({"REELSEC_ALLOW_TEST_DEVICE_UNINSTALL": "1"})
        self.assertEqual(len(v), 1)
        self.assertEqual(v[0]["violation"],
                         "destructive uninstall permission enabled")
        self.assertEqual(sg.inspect_environment({}), [])

    def test_factory_reset_is_never_executable(self):
        with tempfile.TemporaryDirectory() as td:
            auth = _auth_doc(td, operation="FACTORY_RESET")
            with self.assertRaises(sg.SafetyBlock) as ctx:
                sg.execute_destructive(_device_runner(), "/adb", "s1",
                                       "FACTORY_RESET", "com.test.pkg",
                                       authorization_path=auth)
        self.assertIn("never executable", str(ctx.exception))


class GateChainTests(unittest.TestCase):
    def test_no_authorization_means_no_operation(self):
        runner = _device_runner()
        with self.assertRaises(sg.SafetyBlock):
            sg.execute_destructive(runner, "/adb", "s1", "UNINSTALL",
                                   "com.test.pkg")
        self.assertFalse(runner.uninstalled)
        self.assertEqual([c for c in runner.calls if "uninstall" in " ".join(c)],
                         [])

    def test_package_user_device_must_match_exactly(self):
        runner = _device_runner()
        with tempfile.TemporaryDirectory() as td:
            for bad in ({"package": "com.other.pkg"}, {"user": 95},
                        {"device_serial": "s2"}):
                auth = _auth_doc(td, **bad)
                with self.assertRaises(sg.SafetyBlock):
                    sg.execute_destructive(runner, "/adb", "s1", "UNINSTALL",
                                           "com.test.pkg", user=0,
                                           authorization_path=auth)
        self.assertFalse(runner.uninstalled)

    def test_expired_authorization_is_refused(self):
        runner = _device_runner()
        with tempfile.TemporaryDirectory() as td:
            auth = _auth_doc(td, issued_at_epoch=time.time() - 7200,
                             expires_at_epoch=time.time() - 3600)
            with self.assertRaises(sg.SafetyBlock) as ctx:
                sg.execute_destructive(runner, "/adb", "s1", "UNINSTALL",
                                       "com.test.pkg",
                                       authorization_path=auth)
        self.assertIn("expired", str(ctx.exception))
        self.assertFalse(runner.uninstalled)

    def test_authorized_uninstall_runs_with_snapshot_and_audit(self):
        runner = _device_runner()
        with tempfile.TemporaryDirectory() as td:
            auth = _auth_doc(td)
            audit_path = Path(td) / "SAFETY-AUDIT.jsonl"
            rec = sg.execute_destructive(runner, "/adb", "s1", "UNINSTALL",
                                         "com.test.pkg",
                                         authorization_path=auth,
                                         audit_path=audit_path)
            self.assertEqual(rec["result"], "EXECUTED_VERIFIED")
            self.assertTrue(rec["authorized"])
            self.assertIsNotNone(rec["pre_snapshot"])
            self.assertTrue(audit_path.is_file())
            line = json.loads(audit_path.read_text().strip())
            self.assertEqual(line["operation"], "UNINSTALL")
            self.assertEqual(line["result"], "EXECUTED_VERIFIED")

    def test_blocked_attempts_are_audited_too(self):
        runner = _device_runner()
        with tempfile.TemporaryDirectory() as td:
            audit_path = Path(td) / "SAFETY-AUDIT.jsonl"
            with self.assertRaises(sg.SafetyBlock):
                sg.execute_destructive(runner, "/adb", "s1", "UNINSTALL",
                                       "com.test.pkg", audit_path=audit_path)
            line = json.loads(audit_path.read_text().strip())
            self.assertEqual(line["result"], "BLOCKED")
            self.assertIn("no authorization", line["block_reason"])

    def test_absent_package_refuses_destructive_noop(self):
        runner = _device_runner(package_present=False)
        with tempfile.TemporaryDirectory() as td:
            auth = _auth_doc(td)
            with self.assertRaises(sg.SafetyBlock) as ctx:
                sg.execute_destructive(runner, "/adb", "s1", "UNINSTALL",
                                       "com.test.pkg",
                                       authorization_path=auth)
        self.assertIn("not present", str(ctx.exception))
        self.assertFalse(runner.uninstalled)


class DoctorTests(unittest.TestCase):
    def test_doctor_blocks_on_blanket_destructive_flag(self):
        doc = orch.doctor(env={"REELSEC_ALLOW_TEST_DEVICE_UNINSTALL": "1"})
        self.assertEqual(doc["safety"], "BLOCKED")
        self.assertEqual(doc["reason"],
                         "destructive uninstall permission enabled")

    def test_doctor_ok_on_clean_env(self):
        doc = orch.doctor(env={})
        self.assertEqual(doc["safety"], "OK")
        self.assertIsNone(doc["reason"])


class PlatformSafetyTests(unittest.TestCase):
    def test_platform_refuses_to_run_campaign_while_flag_set(self):
        """The exact incident scenario: no campaign, no package touched."""
        runner = _device_runner()
        with tempfile.TemporaryDirectory() as td:
            result = orch.run_platform(
                __file__, td, runner=runner,
                env={"REELSEC_ALLOW_TEST_DEVICE_UNINSTALL": "1"},
                publish=False)
            self.assertEqual(result["status"], "SAFETY_BLOCKED")
            self.assertFalse(runner.uninstalled)
            # no campaign subprocess was ever invoked
            self.assertEqual([c for c in runner.calls
                              if "campaign" in " ".join(c)], [])
            cd = Path(result["campaign_dir"])
            report = (cd / "FINAL-REPORT.md").read_text()
            self.assertIn("SAFETY: BLOCKED", report)
            self.assertIn("No package was modified.", report)
            self.assertIn("No runtime campaign executed.", report)
            verdict = json.loads((cd / "FINAL-VERDICT.json").read_text())
            self.assertEqual(verdict["final_verdict"], "SAFETY_BLOCKED")


class BaselineSafetyTests(unittest.TestCase):
    def test_baseline_round_blocked_by_blanket_flag(self):
        # Hermetic: env is injected; the operator host legitimately exports
        # REELSEC_* vars and tests must never depend on them.
        with tempfile.TemporaryDirectory() as td:
            doc = MODULE.run_baseline_runtime(
                td, __file__, {"tools": {}},
                env={"REELSEC_ALLOW_TEST_DEVICE_UNINSTALL": "1",
                     "REELSEC_TEST_PACKAGE": "com.test.pkg"})
        self.assertEqual(doc["status"], "SAFETY_BLOCKED")
        self.assertIn("authorization document", doc["reason"])

    def test_baseline_round_requires_auth_document_not_flag(self):
        with tempfile.TemporaryDirectory() as td:
            doc = MODULE.run_baseline_runtime(td, __file__, {"tools": {}},
                                              env={})
        # without permissions/tools it must not run, and must say exactly why
        self.assertIn(doc["status"], ("BASELINE_NOT_RUN", "SAFETY_BLOCKED"))
        self.assertTrue(doc.get("reason"))


class CollectorTests(unittest.TestCase):
    def test_every_collector_produces_uniform_envelope(self):
        with tempfile.TemporaryDirectory() as td:
            (Path(td) / "RUNTIME-HEALTH.json").write_text(json.dumps(
                {"startup": "CRASH", "crash_class": "NATIVE_CRASH"}))
            ctx = {"runner": _device_runner(), "adb": "/adb", "serial": "s1",
                   "package": "com.test.pkg", "campaign_dir": td}
            summary = col.run_collectors(ctx)
            self.assertEqual(len(summary), len(col.COLLECTOR_SEQUENCE))
            for entry in summary:
                doc = json.loads(
                    (Path(td) / ("%s.json" % entry["collector"])).read_text())
                self.assertEqual(doc["collector"], entry["collector"])
                self.assertEqual(doc["schema_version"], col.SCHEMA)
                self.assertIn(doc["status"], ("OK", "FAILED", "SKIPPED"))
                self.assertIn("data", doc)
                self.assertIn("errors", doc)

    def test_failing_collector_never_aborts_the_platform(self):
        class Boom:
            name = "BOOM"

            @classmethod
            def collect(cls, ctx):
                raise RuntimeError("collector exploded")
        with tempfile.TemporaryDirectory() as td:
            ctx = {"runner": _device_runner(), "adb": None, "serial": None,
                   "package": None, "campaign_dir": td}
            summary = col.run_collectors(ctx, sequence=(Boom,))
        self.assertEqual(summary[0]["status"], "FAILED")
        self.assertIn("collector exception", summary[0]["errors"][0])

    def test_device_collectors_skip_without_device(self):
        with tempfile.TemporaryDirectory() as td:
            ctx = {"runner": _device_runner(), "adb": None, "serial": None,
                   "package": "com.test.pkg", "campaign_dir": td}
            doc = col.DeviceSnapshotCollector.collect(ctx)
        self.assertEqual(doc["status"], "SKIPPED")


class AggregationTests(unittest.TestCase):
    def test_aggregate_hashes_files_and_derives_verdict(self):
        with tempfile.TemporaryDirectory() as td:
            (Path(td) / "RUNTIME-HEALTH.json").write_text(json.dumps(
                {"startup": "CRASH", "crash_class": "NATIVE_CRASH"}))
            ctx = {"runner": _device_runner(), "adb": None, "serial": None,
                   "package": None, "campaign_dir": td}
            col.run_collectors(ctx, sequence=(col.EvidenceCollector,))
            manifest, verdict = orch.aggregate(td)
            self.assertGreater(manifest["file_count"], 0)
            self.assertTrue(all(len(f["sha256"]) == 64
                                for f in manifest["files"]))
            self.assertEqual(verdict["final_verdict"],
                             "BLOCKED_BY_ARTIFACT_CRASH")
            self.assertEqual(verdict["reason"], "NATIVE_CRASH")
            self.assertEqual(
                verdict["scientific_status"]["SCREENSHOT_BLOCKING"],
                "NOT_PROVEN")


class GitPublishTests(unittest.TestCase):
    def test_publish_commits_and_pushes_and_reports_sha(self):
        calls = []

        def git_runner(cmd, timeout=300):
            calls.append([str(c) for c in cmd])
            if "rev-parse" in cmd:
                return 0, "abc123def456\n"
            return 0, "ok"
        with tempfile.TemporaryDirectory() as td:
            cd = Path(td) / "analysis" / "campaigns" / "x"
            cd.mkdir(parents=True)
            (cd / "A.json").write_text("{}")
            res = orch.git_publish_campaign(td, cd, runner=git_runner)
        self.assertEqual(res["status"], "PUBLISHED")
        self.assertEqual(res["commit"], "abc123def456")
        joined = [" ".join(c) for c in calls]
        self.assertTrue(any("push origin main" in j for j in joined))
        self.assertFalse(any("--force" in j for j in joined))

    def test_push_failure_is_reported_not_hidden(self):
        def git_runner(cmd, timeout=300):
            if "push" in cmd:
                return 1, "remote: Internal Server Error"
            if "rev-parse" in cmd:
                return 0, "abc123\n"
            return 0, "ok"
        with tempfile.TemporaryDirectory() as td:
            cd = Path(td) / "analysis" / "campaigns" / "x"
            cd.mkdir(parents=True)
            (cd / "A.json").write_text("{}")
            res = orch.git_publish_campaign(td, cd, runner=git_runner)
        self.assertEqual(res["status"], "PUSH_FAILED")
        self.assertEqual(res["commit"], "abc123")
        self.assertFalse(res["pushed"])


class FinalVerdictAggregationTests(unittest.TestCase):
    """End-to-end requirements 3+12+17: the aggregation reads the new
    comparison documents first; a completed COMMON_CAUSE_BOTH_CRASH
    investigation is a VALID campaign, never a destructive-baseline
    recommendation, and FINAL == RUNTIME == COMMON-CAUSE."""

    def _both_crash_campaign(self, td):
        cd = Path(td)
        (cd / "SAFETY-GATE.json").write_text(json.dumps({"safety": "OK"}))
        (cd / "RUNTIME-HEALTH.json").write_text(json.dumps(
            {"startup": "CRASH", "crash_class": "NATIVE_CRASH"}))
        (cd / "WORKING-CONTROL.json").write_text(json.dumps(
            {"status": "CONTROL_CRASHED", "package": "com.x"}))
        (cd / "COMMON-CAUSE-COMPARISON.json").write_text(json.dumps(
            {"status": "COMMON_CAUSE_BOTH_CRASH",
             "attribution": {"instrumentation_regression":
                             "NOT_ESTABLISHED"}}))
        (cd / "RUNTIME-VERDICT.json").write_text(json.dumps(
            {"ORIGINAL_RUNTIME": "CRASH", "INSTRUMENTED_RUNTIME": "CRASH",
             "REGRESSION_STATUS": "NOT_ESTABLISHED",
             "RUNTIME_STATUS": "COMMON_CAUSE_BOTH_CRASH",
             "NEXT_ACTION": "Investigate the common cause; no destructive "
                            "operation is required or permitted."}))
        return cd

    def test_both_crash_is_valid_not_proven_campaign(self):
        with tempfile.TemporaryDirectory() as td:
            cd = self._both_crash_campaign(td)
            manifest, verdict = orch.aggregate(str(cd),
                                               campaign_status="COMPLETED")
        self.assertEqual(verdict["final_verdict"], "NOT_PROVEN")
        self.assertEqual(verdict["campaign_status"], "COMPLETED")
        rt = verdict["runtime"]
        self.assertEqual(rt["RUNTIME_STATUS"], "COMMON_CAUSE_BOTH_CRASH")
        self.assertEqual(rt["REGRESSION_STATUS"], "NOT_ESTABLISHED")
        self.assertEqual(rt["ORIGINAL_RUNTIME"], "CRASH")
        self.assertEqual(rt["WORKING_CONTROL"], "CONTROL_CRASHED")
        self.assertEqual(
            verdict["scientific_status"]["SCREENSHOT_BLOCKING"], "NOT_PROVEN")
        self.assertNotIn("REELSEC_ALLOW_TEST_DEVICE_UNINSTALL",
                         rt["NEXT_ACTION"])
        self.assertNotIn("gated baseline", rt["NEXT_ACTION"])
        states = [t["to"] for t in verdict["campaign_state_transitions"]]
        self.assertIn("COMMON_CAUSE_BOTH_CRASH", states)
        self.assertEqual(verdict["campaign_state"], "CAUSAL_CHAIN_INCOMPLETE")

    def test_legacy_destructive_next_action_is_never_surfaced(self):
        # A stale RUNTIME-VERDICT produced by the legacy logic must be
        # sanitized by the aggregator (defense in depth).
        with tempfile.TemporaryDirectory() as td:
            cd = Path(td)
            (cd / "SAFETY-GATE.json").write_text(json.dumps({"safety": "OK"}))
            (cd / "RUNTIME-HEALTH.json").write_text(json.dumps(
                {"startup": "CRASH", "crash_class": "NATIVE_CRASH"}))
            (cd / "RUNTIME-VERDICT.json").write_text(json.dumps(
                {"ORIGINAL_RUNTIME": "NOT_RUN",
                 "REGRESSION_STATUS": "NOT_COMPARABLE",
                 "NEXT_ACTION": "Artifact crash without baseline comparison: "
                                "run the gated baseline round "
                                "(REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1) to "
                                "attribute the failure."}))
            manifest, verdict = orch.aggregate(str(cd))
        na = verdict["runtime"]["NEXT_ACTION"]
        self.assertNotIn("REELSEC_ALLOW_TEST_DEVICE_UNINSTALL", na)
        self.assertNotIn("gated baseline", na)
        self.assertIn("working-control", na)

    def test_original_runtime_recovered_from_working_control(self):
        with tempfile.TemporaryDirectory() as td:
            cd = self._both_crash_campaign(td)
            # stale RUNTIME-VERDICT claims NOT_RUN — aggregation must fix it
            (cd / "RUNTIME-VERDICT.json").write_text(json.dumps(
                {"ORIGINAL_RUNTIME": "NOT_RUN",
                 "REGRESSION_STATUS": "NOT_COMPARABLE"}))
            manifest, verdict = orch.aggregate(str(cd))
        self.assertEqual(verdict["runtime"]["ORIGINAL_RUNTIME"], "CRASH")
        self.assertEqual(verdict["runtime"]["REGRESSION_STATUS"],
                         "NOT_ESTABLISHED")


class TimelineTruthAggregationTests(unittest.TestCase):
    """Campaign 2026-10-07T23-43-38 (field-verified timeline): the original
    ran healthy in its baseline window; a STALE crash-buffer tombstone from
    an earlier session fabricated ORIGINAL_RUNTIME=CRASH, producing a false
    BOTH_CRASH. The aggregation must correct the verdict from the recorded
    evidence WITHOUT rewriting any evidence document."""

    def _legacy_campaign(self, td):
        cd = Path(td)
        stale_health = {
            "startup": "CRASH", "process_observed": True,
            "process_alive_at_exit": True, "pids": [15683],
            "crash_class": "NATIVE_CRASH",
            "classification": {
                "crash_class": "NATIVE_CRASH",
                "evidence_source": "adb:logcat -b crash (tombstone echo)",
                "exit_reason_code": None, "pid": 30953},
            "evidence": {
                "exit_info_new_entries": [],
                "tombstone": {"pid": 30953, "fatal_signal": "SIGABRT",
                              "package_associated": True}}}
        (cd / "SAFETY-GATE.json").write_text(json.dumps({"safety": "OK"}))
        (cd / "WORKING-CONTROL.json").write_text(json.dumps(
            {"schema_version": "working-control-1",
             "status": "CONTROL_NOT_INSTALLED",
             "reason": "pm path reports no installed package"}))
        (cd / "BASELINE-RUNTIME.json").write_text(json.dumps(
            {"status": "BASELINE_ASSESSED", "health": stale_health}))
        (cd / "ADB-DEPLOY.json").write_text(json.dumps(
            {"status": "INSTALLED", "install_mode": "UPDATE"}))
        # device campaigns store RUNTIME-HEALTH in a collector envelope
        (cd / "RUNTIME-HEALTH.json").write_text(json.dumps(
            {"schema_version": "collector-envelope-1",
             "collector": "RUNTIME-HEALTH", "status": "COLLECTED",
             "data": {"startup": "CRASH", "crash_class": "NATIVE_CRASH",
                      "crash_cause": "NATIVE_LIBRARY:libc.so"}}))
        (cd / "CRASH-COMPARISON.json").write_text(json.dumps(
            {"status": "BOTH_CRASH"}))
        (cd / "RUNTIME-VERDICT.json").write_text(json.dumps(
            {"ORIGINAL_RUNTIME": "CRASH", "INSTRUMENTED_RUNTIME": "CRASH",
             "REGRESSION_STATUS": "BASELINE_RUNTIME_FAILURE",
             "RUNTIME_STATUS": "BLOCKED_BY_ARTIFACT_CRASH",
             "RUNTIME_PROOF_STATUS": "BLOCKED_BY_ARTIFACT_CRASH",
             "CRASH_CLASS": "NATIVE_CRASH",
             "NEXT_ACTION": "Original-side runtime failure: the unmodified "
                            "original also crashes on this device/build"}))
        return cd

    def test_legacy_false_both_crash_is_corrected_documents_untouched(self):
        with tempfile.TemporaryDirectory() as td:
            cd = self._legacy_campaign(td)
            manifest, verdict = orch.aggregate(str(cd),
                                               campaign_status="COMPLETED")
            rt = verdict["runtime"]
            self.assertEqual(verdict["final_verdict"],
                             "BLOCKED_BY_ARTIFACT_CRASH")
            self.assertEqual(rt["ORIGINAL_RUNTIME"], "PASS")
            self.assertEqual(rt["REGRESSION_STATUS"],
                             "INSTRUMENTATION_REGRESSION_CONFIRMED")
            self.assertNotIn("also crashes", rt["NEXT_ACTION"])
            self.assertIn("regression confirmed", rt["NEXT_ACTION"].lower())
            self.assertIsNotNone(rt["STARTUP_AUDIT"])
            states = [t["to"]
                      for t in verdict["campaign_state_transitions"]]
            self.assertIn("ORIGINAL_HEALTHY", states)
            self.assertIn("INSTRUMENTED_INSTALLED", states)
            self.assertIn("INSTRUMENTED_CRASHED", states)
            self.assertIn("INSTRUMENTATION_ONLY_CRASH", states)
            # evidence documents are NEVER rewritten by the correction
            doc = json.loads((cd / "BASELINE-RUNTIME.json").read_text())
            self.assertEqual(doc["health"]["startup"], "CRASH")
            verdict_doc = json.loads((cd / "RUNTIME-VERDICT.json").read_text())
            self.assertEqual(verdict_doc["ORIGINAL_RUNTIME"], "CRASH")

    def test_genuine_both_crash_campaign_is_not_corrected(self):
        # same shape, but the original-side crash is session-bound: the
        # aggregator must leave the BOTH_CRASH conclusion intact.
        with tempfile.TemporaryDirectory() as td:
            cd = self._legacy_campaign(td)
            doc = json.loads((cd / "BASELINE-RUNTIME.json").read_text())
            doc["health"]["crash_session_binding"] = {
                "bound": True, "method": "BUFFER_DIFF"}
            (cd / "BASELINE-RUNTIME.json").write_text(json.dumps(doc))
            (cd / "COMMON-CAUSE-COMPARISON.json").write_text(json.dumps(
                {"status": "COMMON_CAUSE_BOTH_CRASH"}))
            (cd / "WORKING-CONTROL.json").write_text(json.dumps(
                {"status": "CONTROL_CRASHED",
                 "health": {"startup": "CRASH",
                            "crash_session_binding": {"bound": True}}}))
            manifest, verdict = orch.aggregate(str(cd))
            rt = verdict["runtime"]
            self.assertEqual(rt["ORIGINAL_RUNTIME"], "CRASH")
            self.assertEqual(rt["REGRESSION_STATUS"], "NOT_ESTABLISHED")
            self.assertEqual(rt["COMMON_CAUSE_COMPARISON"],
                             "COMMON_CAUSE_BOTH_CRASH")


class CampaignExitMappingTests(unittest.TestCase):
    """End-to-end requirement 13 at the platform layer."""

    def _platform(self, td, rc):
        def runner(cmd, timeout=5400):
            if "campaign" in " ".join(str(c) for c in cmd):
                return rc, "simulated campaign output"
            return 0, ""
        return orch.run_platform(__file__, td, runner=runner, env={},
                                 publish=False)

    def test_valid_investigation_maps_to_completed(self):
        with tempfile.TemporaryDirectory() as td:
            result = self._platform(td, 0)
        self.assertEqual(result["campaign_status"], "COMPLETED")

    def test_scientific_incomplete_maps_explicitly(self):
        with tempfile.TemporaryDirectory() as td:
            result = self._platform(td, 3)
        self.assertEqual(result["campaign_status"], "SCIENTIFIC_INCOMPLETE")

    def test_infrastructure_failure_maps_explicitly(self):
        with tempfile.TemporaryDirectory() as td:
            result = self._platform(td, 2)
        self.assertEqual(result["campaign_status"], "INFRASTRUCTURE_FAILURE")


class PublisherClassificationTests(unittest.TestCase):
    """End-to-end requirement 14: PUSH_FAILED is a PUBLISH_FAILURE
    (infrastructure only) and never alters scientific/runtime verdicts."""

    def test_push_failed_is_classified_and_verdict_untouched(self):
        def runner(cmd, timeout=5400):
            return 0, ""

        def git_runner(cmd, timeout=300):
            if "push" in cmd:
                return 1, "remote: 403 Forbidden"
            if "rev-parse" in cmd:
                return 0, "abc123\n"
            return 0, "ok"
        with tempfile.TemporaryDirectory() as td:
            result = orch.run_platform(__file__, td, runner=runner,
                                       git_runner=git_runner, env={},
                                       publish=True)
        pub = result["publish"]
        self.assertEqual(pub["status"], "PUSH_FAILED")
        self.assertIn("PUBLISH_FAILURE", pub["classification"])
        self.assertIn("unaffected", pub["classification"])
        # scientific verdicts are computed before publishing and unchanged
        self.assertEqual(result["verdict"]["final_verdict"], "NOT_PROVEN")
        self.assertEqual(
            result["verdict"]["scientific_status"]["SCREENSHOT_BLOCKING"],
            "NOT_PROVEN")


if __name__ == "__main__":
    unittest.main()
