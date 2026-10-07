#!/usr/bin/env python3
import importlib.util
import json
import tempfile
import unittest
from pathlib import Path
from unittest import mock

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("reelsec", HERE / "reelsec.py")
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class RuntimeProbeTests(unittest.TestCase):
    def test_adb_parser_accepts_spaces_not_only_tabs(self):
        output = """List of devices attached
192.168.8.8:42025      device product:c2qsqw model:SM_N986U device:c2q transport_id:1
RANDOM unauthorized
offline-device        offline
"""
        records = MODULE.parse_adb_devices(output)
        self.assertEqual(len(records), 1)
        self.assertEqual(records[0]["serial"], "192.168.8.8:42025")
        self.assertEqual(records[0]["state"], "device")
        self.assertEqual(records[0]["attributes"]["model"], "SM_N986U")
        self.assertEqual(records[0]["attributes"]["transport_id"], "1")

    def test_frida_failure_classifies_jailed_android_as_gadget_required(self):
        output = """     ____
Connected to SM N986U (id=192.168.8.8:42025)
Spawning `com.newleaf.app.android.victor`...
Failed to spawn: need Gadget to attach on jailed Android; its default location is: /root/.cache/frida/gadget-android-arm64.so
"""
        status, reason = MODULE.classify_frida_failure(output)
        self.assertEqual(status, "FRIDA_GADGET_REQUIRED")
        self.assertIn("jailed device", reason)

    def test_runtime_client_resolution_prefers_preflight_paths(self):
        with tempfile.TemporaryDirectory() as td:
            base = Path(td)
            adb = base / "adb"
            frida = base / "frida"
            adb.write_text("#!/bin/sh\n", encoding="utf-8")
            frida.write_text("#!/bin/sh\n", encoding="utf-8")

            resolved = MODULE.resolve_runtime_clients({
                "tooling": {
                    "adb_after": str(adb),
                    "frida_after_proot": str(frida),
                }
            })

            self.assertEqual(resolved[0], str(adb))
            self.assertEqual(resolved[1], "preflight.adb_after")
            self.assertEqual(resolved[2], str(frida))
            self.assertEqual(resolved[3], "preflight.frida_after_proot")


class RuntimeLifecycleTests(unittest.TestCase):
    """Staged lifecycle derivation: reason codes A-G per failure layer."""

    def setUp(self):
        import runtime_probe as rp
        self.rp = rp

    def _ev(self, *events):
        return [dict(e) for e in events]

    def test_package_absent_yields_package_not_installed(self):
        rp = self.rp
        pkg_stage = rp.make_stage("PACKAGE_PRESENT", rp.FAIL,
                                  reason_code=rp.PACKAGE_NOT_INSTALLED)
        out = rp.derive_lifecycle([], frida_rc=None, package_stage=pkg_stage)
        self.assertEqual(out["reason_code"], rp.PACKAGE_NOT_INSTALLED)

    def test_process_absent_yields_reason_B(self):
        rp = self.rp
        pkg_stage = rp.make_stage("PACKAGE_PRESENT", rp.PASS)
        proc_stage = rp.make_stage("PROCESS_OBSERVED", rp.FAIL,
                                   reason_code=rp.TARGET_PROCESS_NOT_OBSERVED, pids=[])
        launch = rp.make_stage("APP_LAUNCH_ATTEMPTED", rp.PASS)
        out = rp.derive_lifecycle([], frida_rc=None, process_stage=proc_stage,
                                  package_stage=pkg_stage, launch=launch)
        self.assertEqual(out["reason_code"], rp.TARGET_PROCESS_NOT_OBSERVED)
        self.assertFalse(out["lifecycle"]["process_observed"])

    def test_module_absent_yields_reason_C(self):
        rp = self.rp
        events = self._ev({"event": "PROBE_ATTACHED", "pid": 1234},
                          {"event": "MODULE_WAIT_STARTED"})
        out = rp.derive_lifecycle(events, frida_rc=124)
        self.assertEqual(out["reason_code"], rp.TARGET_MODULE_NOT_OBSERVED)
        self.assertTrue(out["lifecycle"]["probe_attached"])
        self.assertFalse(out["lifecycle"]["module_observed"])

    def test_module_observed_is_recorded(self):
        rp = self.rp
        events = self._ev({"event": "PROBE_ATTACHED", "pid": 1234},
                          {"event": "MODULE_WAIT_STARTED"},
                          {"event": "MODULE_OBSERVED", "module": "libsaasCorePlayer.so",
                           "base": "0x7000000000"})
        out = rp.derive_lifecycle(events, frida_rc=124)
        self.assertTrue(out["lifecycle"]["module_observed"])
        self.assertEqual(out["lifecycle"]["module"], "libsaasCorePlayer.so")
        # attached + module but window killed before target ran -> G
        self.assertEqual(out["reason_code"], rp.PROBE_TIMEOUT_AFTER_VALID_ATTACH)

    def test_probe_attach_failure_yields_reason_D(self):
        rp = self.rp
        out = rp.derive_lifecycle([], frida_rc=1)
        self.assertEqual(out["reason_code"], rp.PROBE_ATTACH_FAILED)
        self.assertFalse(out["lifecycle"]["probe_attached"])

    def test_attached_target_not_executed_yields_reason_E(self):
        rp = self.rp
        events = self._ev(
            {"event": "PROBE_ATTACHED", "pid": 1234},
            {"event": "MODULE_OBSERVED", "module": "libsaasCorePlayer.so"},
            {"event": "TARGET_RESOLUTION", "hook": "INSTALLED"},
            {"event": "TIMEOUT_WINDOW_COMPLETE", "target_seen": False})
        out = rp.derive_lifecycle(events, frida_rc=0)
        self.assertEqual(out["reason_code"], rp.TARGET_NOT_EXECUTED_BEFORE_TIMEOUT)
        self.assertTrue(out["lifecycle"]["target_resolution"])
        self.assertFalse(out["lifecycle"]["target_observed"])

    def test_target_observed_yields_reason_F(self):
        rp = self.rp
        events = self._ev(
            {"event": "PROBE_ATTACHED", "pid": 1234},
            {"event": "MODULE_OBSERVED", "module": "libsaasCorePlayer.so"},
            {"event": "TARGET_RESOLUTION", "hook": "INSTALLED"},
            {"event": "TARGET_FUNCTION_ENTER", "target_vptr_match": True,
             "target_slot_match": True})
        out = rp.derive_lifecycle(events, frida_rc=0)
        self.assertEqual(out["reason_code"], rp.TARGET_OBSERVED)
        self.assertEqual(out["lifecycle"]["runtime_matches"], 1)
        self.assertTrue(out["lifecycle"]["target_observed"])

    def test_partial_predicate_match_is_not_target_observed(self):
        rp = self.rp
        events = self._ev(
            {"event": "PROBE_ATTACHED"},
            {"event": "MODULE_OBSERVED", "module": "m"},
            {"event": "TARGET_RESOLUTION"},
            {"event": "TARGET_FUNCTION_ENTER", "target_vptr_match": True,
             "target_slot_match": False},
            {"event": "TIMEOUT_WINDOW_COMPLETE"})
        out = rp.derive_lifecycle(events, frida_rc=0)
        self.assertEqual(out["reason_code"], rp.TARGET_NOT_EXECUTED_BEFORE_TIMEOUT)
        self.assertEqual(out["lifecycle"]["runtime_matches"], 0)

    def test_launch_failure_is_not_masked_by_frida_exit(self):
        rp = self.rp
        launch = rp.make_stage("APP_LAUNCH_ATTEMPTED", rp.FAIL,
                               reason_code=rp.APP_NOT_STARTED)
        out = rp.derive_lifecycle([], frida_rc=1, launch=launch)
        self.assertEqual(out["reason_code"], rp.APP_NOT_STARTED)

    def test_adb_offline_yields_adb_reason(self):
        rp = self.rp
        adb_stage = rp.make_stage("ADB_CONNECTED", rp.FAIL,
                                  reason_code=rp.ADB_NO_ONLINE_DEVICE)
        out = rp.derive_lifecycle([], frida_rc=None, adb_stage=adb_stage)
        self.assertEqual(out["reason_code"], rp.ADB_NO_ONLINE_DEVICE)

    def test_probe_js_uses_only_existing_apis(self):
        js = self.rp.build_probe_js("libsaasCorePlayer.so", "com.pkg", window_ms=5000)
        self.assertNotIn("attachModuleObserver", js)
        for needed in ("PROBE_ATTACHED", "MODULE_WAIT_STARTED", "MODULE_OBSERVED",
                       "TARGET_RESOLUTION", "TARGET_FUNCTION_ENTER",
                       "TIMEOUT_WINDOW_COMPLETE", "findModuleByName"):
            self.assertIn(needed, js)

    def test_parse_probe_events_handles_frida_send_envelope(self):
        out = ('{"type":"send","payload":{"event":"PROBE_ATTACHED","pid":7}}\n'
               'not json\n'
               '{"event":"MODULE_OBSERVED","module":"m"}\n')
        events = self.rp.parse_probe_events(out)
        self.assertEqual([e["event"] for e in events],
                         ["PROBE_ATTACHED", "MODULE_OBSERVED"])
        self.assertEqual(events[0]["pid"], 7)

    def test_observe_process_with_fake_runner(self):
        rp = self.rp
        calls = []

        def fake_runner(cmd, timeout=20):
            calls.append(cmd)
            if len(calls) < 2:
                return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
            return 0, ("USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
                       "u0_a1 12345 500 100 100 0 0 S com.newleaf.app.android.victor\n")
        observed, pids, stage = rp.observe_process(
            fake_runner, "/adb", "s1", "com.newleaf.app.android.victor",
            attempts=3, interval=0)
        self.assertTrue(observed)
        self.assertEqual(pids, [12345])
        self.assertEqual(stage["status"], rp.PASS)

    def test_crash_log_detects_fatal_signal_for_package(self):
        rp = self.rp

        def fake_runner(cmd, timeout=30):
            if "logcat" in cmd:
                return 0, (
                    "10-07 20:00:01.000  1234  1234 F libc: Fatal signal 11 (SIGSEGV), "
                    "code 1 (SEGV_MAPERR), fault addr 0x27a510 in tid 1234 "
                    "(newleaf.app.and), pid 1234 (ewleaf.app.android.victor)\n"
                    "10-07 20:00:01.100  2000  2000 F DEBUG: pid: 1234, tid: 1234, "
                    "name: com.newleaf.app.android.victor\n")
            return 0, ""
        ev = rp.check_crash_log(fake_runner, "/adb", "s1",
                                "com.newleaf.app.android.victor")
        self.assertTrue(ev["detected"])
        self.assertEqual(ev["fatal_signal"], "SIGSEGV")
        self.assertTrue(ev["package_matched_lines"])

    def test_crash_log_clean_buffer_is_not_detected(self):
        rp = self.rp

        def fake_runner(cmd, timeout=30):
            return 0, "10-07 20:00:01.000 1269 1619 I ActivityManager: routine line\n"
        ev = rp.check_crash_log(fake_runner, "/adb", "s1", "com.x")
        self.assertFalse(ev["detected"])
        self.assertIsNone(ev["fatal_signal"])

    def test_process_absent_with_crash_keeps_reason_B_and_records_evidence(self):
        rp = self.rp

        def fake_runner(cmd, timeout=30):
            if "logcat" in cmd:
                return 0, ("F libc: Fatal signal 6 (SIGABRT) in tid 999 "
                           "(x), pid 999 (com.x)\n")
            return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
        observed, pids, stage = rp.observe_process(
            fake_runner, "/adb", "s1", "com.x", attempts=2, interval=0)
        self.assertFalse(observed)
        self.assertEqual(stage["reason_code"], rp.TARGET_PROCESS_NOT_OBSERVED)
        self.assertTrue(stage["crash_evidence"]["detected"])
        self.assertEqual(stage["crash_evidence"]["fatal_signal"], "SIGABRT")
        out = rp.derive_lifecycle([], frida_rc=None, process_stage=stage)
        self.assertEqual(out["reason_code"], rp.TARGET_PROCESS_NOT_OBSERVED)
        self.assertTrue(out["lifecycle"]["crash_detected"])
        self.assertEqual(out["lifecycle"]["crash_signal"], "SIGABRT")

    def test_check_package_present_absent(self):
        rp = self.rp

        def fake_runner(cmd, timeout=20):
            return 0, ""
        present, stage = rp.check_package_present(
            fake_runner, "/adb", "s1", "com.x")
        self.assertFalse(present)
        self.assertEqual(stage["reason_code"], rp.PACKAGE_NOT_INSTALLED)

    def test_write_runtime_probe_records_stages_when_environment_unavailable(self):
        """End-to-end: real function, no adb/frida in this sandbox."""
        import os
        with tempfile.TemporaryDirectory() as td:
            out = Path(td) / "campaign"
            out.mkdir()
            root = Path(td) / "decoded"
            root.mkdir()
            (root / "AndroidManifest.xml").write_text(
                '<manifest package="com.example.app"><application/></manifest>',
                encoding="utf-8")
            for key in ("REELSEC_USE_GADGET", "REELSEC_FRIDA_GADGET"):
                os.environ.pop(key, None)
            with mock.patch.object(MODULE, "write_runtime_toolchain_preflight",
                                   return_value={"status": "BLOCKED", "tooling": {}}):
                result = MODULE.write_runtime_probe(out, root, None)
            self.assertEqual(result["status"], "RUNTIME_ENVIRONMENT_UNAVAILABLE")
            self.assertEqual(result["reason_code"], "ADB_UNAVAILABLE")
            self.assertFalse(result["execution_attempted"])
            self.assertTrue(result["stages"])
            written = json.loads((out / "RUNTIME-PROBE.json").read_text())
            self.assertEqual(written["reason_code"], "ADB_UNAVAILABLE")
            self.assertIn("stages", written)
            # the generated probe script must not use the removed API
            js = (out / "reelsec-runtime-probe.js").read_text()
            self.assertNotIn("attachModuleObserver", js)


if __name__ == "__main__":
    unittest.main()
