#!/usr/bin/env python3
"""Tests for the runtime health gate: artifact crash classification,
baseline comparison, and evidence-gate blocking.

Regression matrix (mandate 2026-10-07, requirement 11):
  1. original OK / instrumented OK            -> BOTH_START_OK
  2. original OK / instrumented native crash  -> INSTRUMENTATION_REGRESSION_CONFIRMED
  3. original OK / instrumented exception     -> regression + JAVA_EXCEPTION
  4. original native crashes                  -> BASELINE_RUNTIME_FAILURE
  5. process never starts                     -> PROCESS_NOT_OBSERVED (not timeout)
  6. process starts then dies                 -> crash class from ApplicationExitInfo
  7. module never loads                       -> TARGET_MODULE_NOT_OBSERVED
  8. probe attach fails                       -> PROBE_ATTACH_FAILED
  9. target never executes                    -> TARGET_NOT_EXECUTED_BEFORE_TIMEOUT
 10. target executes successfully             -> TARGET_OBSERVED
None may degenerate into a misleading RUNTIME_PROBE_TIMEOUT.
"""
import importlib.util
import json
import os
import tempfile
import time
import unittest
from pathlib import Path
from unittest import mock

import runtime_health as rh
import runtime_probe as rp

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("reelsec", HERE / "reelsec.py")
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)

EXIT_INFO_NATIVE = """ACTIVITY MANAGER EXIT INFO (dumpsys activity exit-info)
Package [com.newleaf.app.android.victor]
  UID: 10285
  PID: 14210
  Timestamp: 2026-10-07 19:40:11
  pss=51234kB rss=98304kB
  reason=5 (APP CRASH(NATIVE))
  status=6
  importance=top
  trace=/data/tombstones/tombstone_03

Package [com.newleaf.app.android.victor]
  UID: 9510285
  PID: 15001
  Timestamp: 2026-10-07 19:41:02
  reason=4 (APP CRASH(EXCEPTION))
  status=0
  importance=top
  trace=null
"""

TOMBSTONE_LOG = """10-07 19:40:11.001 14210 14210 F libc    : Fatal signal 6 (SIGABRT), code -1 (SI_QUEUE) in tid 14210 (ewleaf.app.and), pid 14210 (ewleaf.app.android.victor)
10-07 19:40:11.200 14300 14300 F DEBUG   : pid: 14210, tid: 14210, name: com.newleaf.app.android.victor  >>> com.newleaf.app.android.victor <<<
10-07 19:40:11.201 14300 14300 F DEBUG   : Abort message: 'fortify check failed'
10-07 19:40:11.202 14300 14300 F DEBUG   :       #00 pc 000000000027a510  /data/app/~~abc==/com.newleaf.app.android.victor-xyz==/lib/arm64/libsaasCorePlayer.so (Java_com_x+40)
10-07 19:40:11.202 14300 14300 F DEBUG   :       #01 pc 0000000000045120  /apex/com.android.runtime/lib64/bionic/libc.so (abort+160)
"""


class ExitInfoParserTests(unittest.TestCase):
    def test_parses_reason_status_user_and_trace(self):
        entries = rh.parse_exit_info(EXIT_INFO_NATIVE)
        self.assertEqual(len(entries), 2)
        first = entries[0]
        self.assertEqual(first["package"], "com.newleaf.app.android.victor")
        self.assertEqual(first["reason_code"], 5)
        self.assertEqual(first["reason_name"], "APP CRASH(NATIVE)")
        self.assertEqual(first["status"], 6)
        self.assertEqual(first["pid"], 14210)
        self.assertEqual(first["user"], 0)
        self.assertEqual(first["trace"], "/data/tombstones/tombstone_03")
        second = entries[1]
        self.assertEqual(second["reason_code"], 4)
        self.assertEqual(second["user"], 95)  # uid 9510285 -> user 95
        self.assertEqual(second["trace"], "null")

    def test_stale_entries_never_trigger_the_gate(self):
        pre = rh.parse_exit_info(EXIT_INFO_NATIVE)
        post = rh.parse_exit_info(EXIT_INFO_NATIVE)  # identical snapshot
        self.assertEqual(rh.new_exit_entries(pre, post), [])
        extra = EXIT_INFO_NATIVE + """
Package [com.newleaf.app.android.victor]
  UID: 10285
  PID: 16000
  Timestamp: 2026-10-07 20:00:00
  reason=5 (APP CRASH(NATIVE))
  status=11
"""
        post2 = rh.parse_exit_info(extra)
        fresh = rh.new_exit_entries(pre, post2)
        self.assertEqual(len(fresh), 1)
        self.assertEqual(fresh[0]["pid"], 16000)


class TombstoneParserTests(unittest.TestCase):
    def test_extracts_frames_abort_and_association(self):
        t = rh.parse_tombstone_logcat(TOMBSTONE_LOG, "com.newleaf.app.android.victor")
        self.assertEqual(t["fatal_signal"], "SIGABRT")
        self.assertTrue(t["package_associated"])
        self.assertEqual(t["abort_message"], "fortify check failed")
        self.assertEqual(t["pid"], 14210)
        libs = [f["library"] for f in t["backtrace_frames"]]
        self.assertEqual(libs[0], "libsaasCorePlayer.so")
        self.assertIn("libc.so", libs)
        self.assertEqual(t["backtrace_frames"][0]["pc"], "000000000027a510")

    def test_clean_buffer_yields_nothing(self):
        t = rh.parse_tombstone_logcat("10-07 20:00:00 1 1 I x: routine\n", "com.x")
        self.assertIsNone(t["fatal_signal"])
        self.assertEqual(t["backtrace_frames"], [])
        self.assertFalse(t["package_associated"])


class ClassifierTests(unittest.TestCase):
    def _entry(self, code, pid=100, status=0):
        return {"package": "com.x", "uid": 10100, "user": 0, "pid": pid,
                "timestamp": "t", "reason_code": code, "reason_name": None,
                "status": status, "trace": None}

    def test_native_crash_from_exit_info(self):
        c = rh.classify_crash("com.x", [self._entry(5, status=6)], None, True)
        self.assertEqual(c["crash_class"], rh.NATIVE_CRASH)
        self.assertEqual(c["confidence"], rh.CONF_HIGH)
        self.assertEqual(c["user"], 0)
        self.assertIn("exit-info", c["evidence_source"])

    def test_java_exception_anr_killed_startup(self):
        self.assertEqual(rh.classify_crash("com.x", [self._entry(4)], None, True)["crash_class"],
                         rh.JAVA_EXCEPTION)
        self.assertEqual(rh.classify_crash("com.x", [self._entry(6)], None, True)["crash_class"],
                         rh.ANR)
        self.assertEqual(rh.classify_crash("com.x", [self._entry(2)], None, True)["crash_class"],
                         rh.PROCESS_KILLED)
        self.assertEqual(rh.classify_crash("com.x", [self._entry(7)], None, True)["crash_class"],
                         rh.STARTUP_FAILURE)

    def test_logcat_only_native_crash_is_medium_confidence(self):
        t = rh.parse_tombstone_logcat(TOMBSTONE_LOG, "com.newleaf.app.android.victor")
        c = rh.classify_crash("com.newleaf.app.android.victor", [], t, False)
        self.assertEqual(c["crash_class"], rh.NATIVE_CRASH)
        self.assertEqual(c["confidence"], rh.CONF_MEDIUM)

    def test_no_evidence_paths(self):
        c = rh.classify_crash("com.x", [], None, False)
        self.assertEqual(c["crash_class"], rh.PROCESS_NOT_OBSERVED)
        c = rh.classify_crash("com.x", [], None, True, pids=[5])
        self.assertEqual(c["crash_class"], rh.HEALTHY)
        c = rh.classify_crash("com.x", [], None, False, package_present=False)
        self.assertEqual(c["crash_class"], rh.PACKAGE_NOT_PRESENT)


class CauseIdentificationTests(unittest.TestCase):
    def test_fault_library_from_backtrace_is_high_confidence(self):
        t = rh.parse_tombstone_logcat(TOMBSTONE_LOG, "com.newleaf.app.android.victor")
        c = rh.classify_crash("com.newleaf.app.android.victor", [], t, False)
        cause = rh.identify_crash_cause(c, tombstone=t)
        self.assertEqual(cause["cause"], "NATIVE_LIBRARY:libsaasCorePlayer.so")
        self.assertEqual(cause["fault_library"], "libsaasCorePlayer.so")
        self.assertEqual(cause["confidence"], rh.CONF_HIGH)

    def test_unknown_cause_is_never_invented(self):
        cause = rh.identify_crash_cause({"crash_class": rh.PROCESS_KILLED})
        self.assertEqual(cause["cause"], rh.CAUSE_UNKNOWN)
        self.assertIsNone(cause["fault_library"])
        self.assertTrue(cause["searched_sources"])


def _assess(runner, package="com.x", label="instrumented"):
    with mock.patch("time.sleep"):
        return rh.assess_startup(runner, "/adb", "s1", package, label=label,
                                 observe_s=1, interval=0)


class AssessStartupTests(unittest.TestCase):
    def _runner(self, exit_post="", ps_line=None, crash_log=""):
        state = {"exit_calls": 0}

        def runner(cmd, timeout=30):
            joined = " ".join(str(c) for c in cmd)
            if "exit-info" in joined:
                state["exit_calls"] += 1
                return 0, exit_post if state["exit_calls"] > 1 else ""
            if "monkey" in joined:
                return 0, "Events injected: 1"
            if joined.endswith("ps -A"):
                if ps_line:
                    return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n" + ps_line
                return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
            if "logcat" in joined:
                return 0, crash_log
            return 1, ""
        return runner

    def test_native_crash_blocks_runtime_probe(self):
        h = _assess(self._runner(exit_post=EXIT_INFO_NATIVE, crash_log=TOMBSTONE_LOG))
        self.assertEqual(h["startup"], "CRASH")
        self.assertEqual(h["crash_class"], rh.NATIVE_CRASH)
        self.assertEqual(h["crash_cause"], "NATIVE_LIBRARY:libsaasCorePlayer.so")
        self.assertEqual(h["exit_status"], 6)
        self.assertFalse(h["runtime_probe_allowed"])
        self.assertEqual(h["artifact_type"], "INSTRUMENTED_TEST_ARTIFACT")

    def test_healthy_startup_allows_runtime_probe(self):
        h = _assess(self._runner(
            ps_line="u0_a1 999 500 1 1 0 0 S com.x"))
        self.assertEqual(h["startup"], "PASS")
        self.assertEqual(h["crash_class"], rh.HEALTHY)
        self.assertTrue(h["runtime_probe_allowed"])

    def test_process_never_starts_without_crash_entries(self):
        h = _assess(self._runner())
        self.assertEqual(h["startup"], "NOT_STARTED")
        self.assertEqual(h["crash_class"], rh.PROCESS_NOT_OBSERVED)
        self.assertFalse(h["runtime_probe_allowed"])

    def test_stale_exit_info_does_not_block(self):
        # Same entries before and after launch => no NEW crash => healthy.
        h = _assess(self._runner(
            exit_post=EXIT_INFO_NATIVE,
            ps_line="u0_a1 999 500 1 1 0 0 S com.x"))
        # pre snapshot equals post snapshot (runner returns exit_post only on
        # 2nd call; pre is empty) -> entries are "new"; emulate stale by
        # pre-seeding:
        pre = rh.parse_exit_info(EXIT_INFO_NATIVE)
        with mock.patch("time.sleep"):
            h2 = rh.assess_startup(
                self._runner(exit_post=EXIT_INFO_NATIVE,
                             ps_line="u0_a1 999 500 1 1 0 0 S com.x"),
                "/adb", "s1", "com.x", observe_s=1, interval=0,
                pre_entries=pre)
        self.assertEqual(h2["startup"], "PASS")
        self.assertTrue(h2["runtime_probe_allowed"])


SIGABRT_BASE_APK_LOG = """10-07 21:40:11.001 14210 14210 F libc    : Fatal signal 6 (SIGABRT), code -1 (SI_QUEUE), fault addr 0x0000000000003733 in tid 14210 (ewleaf.app.and), pid 14210 (ewleaf.app.android.victor)
10-07 21:40:11.200 14300 14300 F DEBUG   : pid: 14210, tid: 14210, name: com.newleaf.app.android.victor  >>> com.newleaf.app.android.victor <<<
10-07 21:40:11.202 14300 14300 F DEBUG   :       #00 pc 00031e10  /data/app/~~abc==/com.newleaf.app.android.victor-xyz==/base.apk
"""

TARGET_OFFSET = 0x31E10
PACKED_ENTRY = "lib/arm64-v8a/libpacked.so"


def _craft_apk_with_offset(path, target=TARGET_OFFSET, name=PACKED_ENTRY):
    """Build an APK whose STORED entry provably contains `target`."""
    import zipfile
    apk = Path(path)
    pad_size = target - 200
    with zipfile.ZipFile(apk, "w") as zf:
        pad = zipfile.ZipInfo("pad.bin")
        pad.compress_type = zipfile.ZIP_STORED
        zf.writestr(pad, b"\x00" * pad_size)
        lib = zipfile.ZipInfo(name)
        lib.compress_type = zipfile.ZIP_STORED
        zf.writestr(lib, b"\x7fELF" + b"S" * 8192)
    return apk


def _stored_data_start(apk, entry_name):
    import zipfile
    with zipfile.ZipFile(apk) as zf, open(apk, "rb") as fh:
        for info in zf.infolist():
            if info.filename != entry_name:
                continue
            fh.seek(info.header_offset)
            hdr = fh.read(30)
            name_len = int.from_bytes(hdr[26:28], "little")
            extra_len = int.from_bytes(hdr[28:30], "little")
            return info.header_offset + 30 + name_len + extra_len
    return None


class CrashArtifactTests(unittest.TestCase):
    def _artifact_zip(self, td):
        import zipfile
        apk = Path(td) / "artifact.apk"
        with zipfile.ZipFile(apk, "w") as zf:
            zf.writestr("AndroidManifest.xml", b"\x03\x00\x08\x00axml")
            info = zipfile.ZipInfo("lib/arm64-v8a/libpacked.so")
            info.compress_type = zipfile.ZIP_STORED
            zf.writestr(info, b"\x7fELF" + b"P" * 4096)
        return apk

    def _data_start(self, apk, entry_name):
        import zipfile
        with zipfile.ZipFile(apk) as zf, open(apk, "rb") as fh:
            for info in zf.infolist():
                if info.filename != entry_name:
                    continue
                fh.seek(info.header_offset)
                hdr = fh.read(30)
                name_len = int.from_bytes(hdr[26:28], "little")
                extra_len = int.from_bytes(hdr[28:30], "little")
                return info.header_offset + 30 + name_len + extra_len
        return None

    def test_frame_regex_parses_base_apk_fault(self):
        t = rh.parse_tombstone_logcat(SIGABRT_BASE_APK_LOG,
                                      "com.newleaf.app.android.victor")
        self.assertEqual(t["fatal_signal"], "SIGABRT")
        self.assertEqual(t["fault_addr"], "0x0000000000003733")
        self.assertEqual(t["backtrace_frames"][0]["library"], "base.apk")
        self.assertEqual(t["backtrace_frames"][0]["pc"], "00031e10")
        self.assertTrue(t["package_associated"])

    def test_symbol_annotation_still_captured_for_so_frames(self):
        t = rh.parse_tombstone_logcat(TOMBSTONE_LOG,
                                      "com.newleaf.app.android.victor")
        self.assertEqual(t["backtrace_frames"][0]["library"],
                         "libsaasCorePlayer.so")
        self.assertEqual(t["backtrace_frames"][0]["symbol"], "Java_com_x+40")

    def test_missing_abort_message_forbids_anti_tamper_labeling(self):
        t = rh.parse_tombstone_logcat(SIGABRT_BASE_APK_LOG,
                                      "com.newleaf.app.android.victor")
        art = rh.build_crash_artifact(
            "com.newleaf.app.android.victor", "instrumented", [], t)
        self.assertIsNone(art["abort_message"])
        self.assertFalse(art["abort_message_present"])
        self.assertTrue(any("MUST NOT be labeled anti-tamper" in n
                            for n in art["integrity_notes"]))

    def test_abort_message_extracted_when_present(self):
        t = rh.parse_tombstone_logcat(TOMBSTONE_LOG,
                                      "com.newleaf.app.android.victor")
        art = rh.build_crash_artifact("com.x", "instrumented", [], t)
        self.assertEqual(art["abort_message"], "fortify check failed")
        self.assertTrue(art["abort_message_present"])

    def test_crash_instances_grouped_per_uid_and_user(self):
        entries = rh.parse_exit_info(EXIT_INFO_NATIVE)
        t = rh.parse_tombstone_logcat(SIGABRT_BASE_APK_LOG,
                                      "com.newleaf.app.android.victor")
        art = rh.build_crash_artifact("com.newleaf.app.android.victor",
                                      "instrumented", entries, t)
        self.assertEqual(art["grouping"]["instance_count"], 2)
        self.assertEqual(art["grouping"]["uids"], [10285, 9510285])
        self.assertEqual(art["grouping"]["users"], [0, 95])
        self.assertTrue(any("must not be merged" in n
                            for n in art["integrity_notes"]))

    def test_apk_offset_resolves_to_stored_entry(self):
        with tempfile.TemporaryDirectory() as td:
            apk = self._artifact_zip(td)
            start = self._data_start(apk, "lib/arm64-v8a/libpacked.so")
            res = rh.resolve_apk_offset(apk, start + 5)
            self.assertEqual(res["status"], "RESOLVED")
            self.assertEqual(res["entry"], "lib/arm64-v8a/libpacked.so")
            self.assertEqual(res["offset_within_entry"], hex(5))
            # offset outside any stored entry stays unresolved (never invented)
            res2 = rh.resolve_apk_offset(apk, 4)
            self.assertEqual(res2["status"], "UNRESOLVED")
            res3 = rh.resolve_apk_offset(None, start + 5)
            self.assertEqual(res3["status"], "UNRESOLVED")

    def test_crash_artifact_binds_apk_offset_from_base_apk_frame(self):
        with tempfile.TemporaryDirectory() as td:
            apk = self._artifact_zip(td)
            start = self._data_start(apk, "lib/arm64-v8a/libpacked.so")
            # craft a frame whose pc offset lands inside the stored entry
            log = SIGABRT_BASE_APK_LOG.replace(
                "#00 pc 00031e10", "#00 pc %08x" % (start + 16))
            t = rh.parse_tombstone_logcat(
                log, "com.newleaf.app.android.victor")
            art = rh.build_crash_artifact(
                "com.newleaf.app.android.victor", "instrumented", [], t,
                artifact_apk=str(apk))
            self.assertEqual(art["fault_location"]["library"], "base.apk")
            self.assertEqual(art["apk_offset_resolution"]["status"], "RESOLVED")
            self.assertEqual(art["apk_offset_resolution"]["entry"],
                             "lib/arm64-v8a/libpacked.so")
            self.assertEqual(art["apk_offset_resolution"]["offset_within_entry"],
                             hex(16))

    def test_assess_startup_attaches_bound_crash_artifact(self):
        def runner(cmd, timeout=30):
            state = getattr(runner, "_exit_calls", 0)
            joined = " ".join(str(c) for c in cmd)
            if "exit-info" in joined:
                runner._exit_calls = state + 1
                return 0, EXIT_INFO_NATIVE if state >= 1 else ""
            if "monkey" in joined:
                return 0, "Events injected: 1"
            if joined.endswith("ps -A"):
                return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
            if "logcat" in joined:
                return 0, SIGABRT_BASE_APK_LOG
            if "pm path" in joined:
                return 0, "package:/data/app/~~x/com.newleaf.app.android.victor/base.apk"
            return 1, ""
        with mock.patch("time.sleep"):
            h = rh.assess_startup(runner, "/adb", "s1",
                                  "com.newleaf.app.android.victor",
                                  observe_s=1, interval=0)
        self.assertEqual(h["startup"], "CRASH")
        art = h["crash_artifact"]
        self.assertEqual(art["schema_version"], "crash-artifact-1")
        self.assertEqual(art["artifact"]["label"], "instrumented")
        self.assertEqual(
            art["artifact"]["installed_path"],
            "/data/app/~~x/com.newleaf.app.android.victor/base.apk")
        self.assertEqual(art["grouping"]["users"], [0, 95])
        self.assertIn("session", art)
        self.assertIsNotNone(h["installed_apk_path"])
        self.assertIn("started_at_epoch", h["session_timing"])

    def test_healthy_startup_has_no_crash_artifact(self):
        def runner(cmd, timeout=30):
            joined = " ".join(str(c) for c in cmd)
            if "exit-info" in joined:
                return 0, ""
            if joined.endswith("ps -A"):
                return 0, ("USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
                           "u0_a1 999 500 1 1 0 0 S com.x")
            if "pm path" in joined:
                return 0, "package:/data/app/x/base.apk"
            return 0, ""
        with mock.patch("time.sleep"):
            h = rh.assess_startup(runner, "/adb", "s1", "com.x",
                                  observe_s=1, interval=0)
        self.assertEqual(h["startup"], "PASS")
        self.assertIsNone(h["crash_artifact"])


class ComparisonTests(unittest.TestCase):
    def _h(self, startup, cls=None):
        return {"startup": startup, "crash_class": cls, "crash_cause": None,
                "exit_reason": None, "process_alive_ms": 0}

    def test_regression_confirmed(self):
        c = rh.compare_artifacts(self._h("PASS"), self._h("CRASH", rh.NATIVE_CRASH))
        self.assertEqual(c["regression_status"], rh.REGRESSION_CONFIRMED)

    def test_both_crash_is_baseline_failure_not_reelsec(self):
        c = rh.compare_artifacts(self._h("CRASH", rh.NATIVE_CRASH),
                                 self._h("CRASH", rh.NATIVE_CRASH))
        self.assertEqual(c["regression_status"], rh.BASELINE_RUNTIME_FAILURE)
        self.assertIn("NOT attributed", c["attribution_note"])

    def test_both_ok_and_not_comparable(self):
        self.assertEqual(
            rh.compare_artifacts(self._h("PASS"), self._h("PASS"))["regression_status"],
            rh.BOTH_START_OK)
        self.assertEqual(
            rh.compare_artifacts(None, self._h("CRASH"))["regression_status"],
            rh.NOT_COMPARABLE)


class VerdictTests(unittest.TestCase):
    def test_verdict_fields_and_specific_next_action(self):
        ih = {"startup": "CRASH", "crash_class": rh.NATIVE_CRASH,
              "crash_cause": rh.CAUSE_UNKNOWN, "crash_cause_confidence": rh.CONF_NONE,
              "runtime_probe_allowed": False}
        v = rh.runtime_verdict({"startup": "PASS"}, ih)
        self.assertEqual(v["ORIGINAL_RUNTIME"], "PASS")
        self.assertEqual(v["INSTRUMENTED_RUNTIME"], "CRASH")
        self.assertEqual(v["CRASH_CLASS"], rh.NATIVE_CRASH)
        self.assertEqual(v["REGRESSION_STATUS"], rh.REGRESSION_CONFIRMED)
        self.assertEqual(v["RUNTIME_PROOF_STATUS"], "NOT_RUN")
        self.assertFalse(v["runtime_probe_allowed"])
        self.assertIn("INSTRUMENTATION-IMPACT.json", v["NEXT_ACTION"])

    def test_blocked_probe_status_maps_from_artifact_crash(self):
        v = rh.runtime_verdict(None, {"startup": "CRASH", "crash_class": rh.JAVA_EXCEPTION},
                               runtime_probe={"status": "RUNTIME_ARTIFACT_CRASH"})
        self.assertEqual(v["RUNTIME_PROOF_STATUS"], "BLOCKED_BY_ARTIFACT_CRASH")


class RegressionMatrixTests(unittest.TestCase):
    """The 10 mandated scenarios must never degenerate into a misleading
    RUNTIME_PROBE_TIMEOUT."""

    def test_scenarios_5_to_10_map_to_distinct_reason_codes(self):
        pkg = rp.make_stage("PACKAGE_PRESENT", rp.PASS)
        launch_ok = rp.make_stage("APP_LAUNCH_ATTEMPTED", rp.PASS)
        proc_ok = rp.make_stage("PROCESS_OBSERVED", rp.PASS, pids=[7])
        proc_fail = rp.make_stage("PROCESS_OBSERVED", rp.FAIL,
                                  reason_code=rp.TARGET_PROCESS_NOT_OBSERVED)
        # 5: process never starts
        self.assertEqual(
            rp.derive_lifecycle([], frida_rc=None, package_stage=pkg,
                                launch=launch_ok, process_stage=proc_fail)["reason_code"],
            rp.TARGET_PROCESS_NOT_OBSERVED)
        attached = [{"event": "PROBE_ATTACHED", "pid": 7}]
        # 7: module never loads
        self.assertEqual(
            rp.derive_lifecycle(attached, frida_rc=124, package_stage=pkg,
                                launch=launch_ok, process_stage=proc_ok)["reason_code"],
            rp.TARGET_MODULE_NOT_OBSERVED)
        # 8: probe attach fails
        self.assertEqual(
            rp.derive_lifecycle([], frida_rc=1, package_stage=pkg,
                                launch=launch_ok, process_stage=proc_ok)["reason_code"],
            rp.PROBE_ATTACH_FAILED)
        # 9: target never executes (window completed normally)
        ev = attached + [{"event": "MODULE_OBSERVED", "module": "m.so"},
                         {"event": "TARGET_RESOLUTION"},
                         {"event": "TIMEOUT_WINDOW_COMPLETE"}]
        self.assertEqual(
            rp.derive_lifecycle(ev, frida_rc=124, package_stage=pkg,
                                launch=launch_ok, process_stage=proc_ok)["reason_code"],
            rp.TARGET_NOT_EXECUTED_BEFORE_TIMEOUT)
        # 10: target executes
        ev_ok = ev + [{"event": "TARGET_FUNCTION_ENTER",
                       "target_vptr_match": True, "target_slot_match": True}]
        self.assertEqual(
            rp.derive_lifecycle(ev_ok, frida_rc=0, package_stage=pkg,
                                launch=launch_ok, process_stage=proc_ok)["reason_code"],
            rp.TARGET_OBSERVED)

    def test_artifact_crash_is_never_a_probe_timeout(self):
        # scenarios 2/3/6: crash gate fires before frida; status must be
        # RUNTIME_ARTIFACT_CRASH, never RUNTIME_PROBE_TIMEOUT_*.
        ih = {"startup": "CRASH", "crash_class": rh.NATIVE_CRASH,
              "crash_cause": rh.CAUSE_UNKNOWN, "crash_cause_confidence": rh.CONF_NONE,
              "runtime_probe_allowed": False}
        v = rh.runtime_verdict(None, ih, runtime_probe={"status": "RUNTIME_ARTIFACT_CRASH"})
        self.assertEqual(v["RUNTIME_PROOF_STATUS"], "BLOCKED_BY_ARTIFACT_CRASH")
        self.assertNotIn("TIMEOUT", v["RUNTIME_PROOF_STATUS"])


class _ProbeHarness(unittest.TestCase):
    """Integration: write_runtime_probe with a faked device."""

    def setUp(self):
        self.td = tempfile.TemporaryDirectory()
        self.out = Path(self.td.name)
        self.root = self.out / "decoded"
        self.root.mkdir()
        self.frida_calls = []
        os.environ.pop("REELSEC_USE_GADGET", None)
        os.environ["REELSEC_HEALTH_WINDOW_MS"] = "2000"

    def tearDown(self):
        os.environ.pop("REELSEC_HEALTH_WINDOW_MS", None)
        self.td.cleanup()

    def _patches(self, runner, preflight_ok=True):
        adb = self.out / "adb"
        frida = self.out / "frida"
        adb.write_text("#!/bin/sh\n")
        frida.write_text("#!/bin/sh\n")
        return [
            mock.patch.object(MODULE, "write_runtime_toolchain_preflight",
                              lambda out: {"status": "READY", "tooling": {
                                  "adb_after": str(adb),
                                  "frida_after_proot": str(frida)}}),
            mock.patch.object(MODULE, "resolve_test_device",
                              lambda adb, serial=None: {
                                  "serial": "s1", "resolution": "explicit",
                                  "online_devices": ["s1"]}),
            mock.patch.object(MODULE, "_find_package_name",
                              lambda root: ("com.x", "manifest")),
            mock.patch.object(MODULE, "run", runner),
        ]

    def _run_probe(self, runner):
        patches = self._patches(runner)
        for p in patches:
            p.start()
        try:
            with mock.patch("time.sleep"):
                return MODULE.write_runtime_probe(self.out, self.root, None)
        finally:
            for p in patches:
                p.stop()

    def _runner(self, exit_post="", ps_line=None, crash_log="",
                frida_output=""):
        state = {"exit_calls": 0}

        def runner(cmd, timeout=60):
            self_cmd = [str(c) for c in cmd]
            joined = " ".join(self_cmd)
            if self_cmd and Path(self_cmd[0]).name == "frida":
                self.frida_calls.append(self_cmd)
                return 0, frida_output
            if "exit-info" in joined:
                state["exit_calls"] += 1
                return 0, exit_post if state["exit_calls"] > 1 else ""
            if "monkey" in joined or "force-stop" in joined:
                return 0, "Events injected: 1"
            if joined.endswith("ps -A"):
                if ps_line:
                    return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n" + ps_line
                return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
            if "logcat" in joined:
                return 0, crash_log
            if "pm path" in joined:
                return 0, "package:/data/app/~~x/com.x/base.apk"
            return 1, ""
        return runner

    def test_scenario_2_instrumented_native_crash_blocks_probe(self):
        result = self._run_probe(self._runner(
            exit_post=EXIT_INFO_NATIVE.replace(
                "com.newleaf.app.android.victor", "com.x"),
            crash_log=TOMBSTONE_LOG.replace(
                "com.newleaf.app.android.victor", "com.x")))
        self.assertEqual(result["status"], "RUNTIME_ARTIFACT_CRASH")
        self.assertEqual(result["reason_code"], rh.REASON_CODE_ARTIFACT_CRASH)
        self.assertFalse(result["runtime_probe_allowed"])
        self.assertEqual(self.frida_calls, [])  # frida never runs after a crash
        self.assertIsNone(result["frida_exit"])
        health = json.loads((self.out / "RUNTIME-HEALTH.json").read_text())
        self.assertEqual(health["startup"], "CRASH")
        self.assertEqual(health["crash_class"], rh.NATIVE_CRASH)
        crash_art = json.loads((self.out / "CRASH-ARTIFACT.json").read_text())
        self.assertEqual(crash_art["schema_version"], "crash-artifact-1")
        self.assertEqual(crash_art["artifact"]["label"], "instrumented")
        verdict = json.loads((self.out / "RUNTIME-VERDICT.json").read_text())
        self.assertEqual(verdict["INSTRUMENTED_RUNTIME"], "CRASH")
        self.assertEqual(verdict["RUNTIME_PROOF_STATUS"], "BLOCKED_BY_ARTIFACT_CRASH")
        stage_names = [s["stage"] for s in result["stages"]]
        self.assertIn("PROCESS_HEALTH_GATE", stage_names)

    def test_scenario_1_healthy_artifact_proceeds_to_probe(self):
        probe_out = json.dumps({"event": "PROBE_ATTACHED", "pid": 999})
        result = self._run_probe(self._runner(
            ps_line="u0_a1 999 500 1 1 0 0 S com.x", frida_output=probe_out))
        self.assertTrue(result["runtime_probe_allowed"])
        self.assertNotEqual(result["status"], "RUNTIME_ARTIFACT_CRASH")
        self.assertEqual(len(self.frida_calls), 1)
        self.assertIn("-f", self.frida_calls[0])  # spawn mode after health gate

    def test_device_scenario_sigabrt_base_apk_0x31e10_resolved(self):
        """End-to-end simulation of the observed device crash: SIGABRT ~1s
        after start, fault at base.apk + 0x31e10, mixed-user exit-info. The
        campaign path must write CRASH-ARTIFACT.json with UID/PID/APK-path
        bindings and the offset resolved into the artifact's STORED entry."""
        apk = _craft_apk_with_offset(self.out / "instrumented-signed.apk")
        (self.out / "ADB-DEPLOY.json").write_text(json.dumps({
            "artifact": str(apk), "artifact_sha256": "f" * 64}),
            encoding="utf-8")
        exit_info = EXIT_INFO_NATIVE.replace(
            "com.newleaf.app.android.victor", "com.x")
        log = SIGABRT_BASE_APK_LOG.replace(
            "com.newleaf.app.android.victor", "com.x")
        result = self._run_probe(self._runner(exit_post=exit_info,
                                              crash_log=log))
        self.assertEqual(result["status"], "RUNTIME_ARTIFACT_CRASH")
        self.assertEqual(self.frida_calls, [])
        art = json.loads((self.out / "CRASH-ARTIFACT.json").read_text())
        self.assertEqual(art["schema_version"], "crash-artifact-1")
        self.assertEqual(art["fatal_signal"], "SIGABRT")
        self.assertEqual(art["fault_location"]["library"], "base.apk")
        self.assertEqual(art["fault_location"]["pc"], "00031e10")
        res = art["apk_offset_resolution"]
        self.assertEqual(res["status"], "RESOLVED")
        self.assertEqual(res["entry"], PACKED_ENTRY)
        start = _stored_data_start(apk, PACKED_ENTRY)
        self.assertEqual(int(res["offset_within_entry"], 16),
                         TARGET_OFFSET - start)
        inst = art["crash_instances"]
        self.assertEqual(inst[0]["pid"], 14210)
        self.assertEqual(inst[0]["uid"], 10285)
        self.assertEqual(art["grouping"]["users"], [0, 95])
        self.assertEqual(art["artifact"]["installed_path"],
                         "/data/app/~~x/com.x/base.apk")
        self.assertEqual(art["artifact"]["artifact_sha256"], "f" * 64)
        self.assertEqual(art["artifact"]["label"], "instrumented")
        self.assertIsNone(art["abort_message"])
        self.assertTrue(any("MUST NOT be labeled anti-tamper" in n
                            for n in art["integrity_notes"]))
        self.assertIn("started_at_epoch", art["session"])


class BaselineCrashArtifactTests(unittest.TestCase):
    """BASELINE-CRASH-ARTIFACT.json must be produced by the gated baseline
    round — every destructive step through safety_gate, and the assessment
    runner itself never sees a destructive command."""

    def test_baseline_round_writes_artifact_through_gate(self):
        import safety_gate as sg
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            signed = out / "original-testsigned.apk"
            _craft_apk_with_offset(signed)
            auth = {
                "schema_version": sg.SCHEMA_AUTH,
                "operation": "UNINSTALL",
                "package": "com.test.pkg",
                "user": 0,
                "device_serial": "s1",
                "issued_at_epoch": time.time() - 10,
                "expires_at_epoch": time.time() + 600,
                "authorized_by": "operator",
                "reason": "baseline round test",
            }
            auth_path = out / "auth.json"
            auth_path.write_text(json.dumps(auth), encoding="utf-8")

            state = {"present": True, "exit_calls": 0}
            gate_cmds = []
            assess_cmds = []

            def fake_default_runner(cmd, timeout=120):
                joined = " ".join(str(c) for c in cmd)
                gate_cmds.append(joined)
                if "getprop" in joined:
                    return 0, "samsung/x/y:13"
                if "pm list users" in joined:
                    return 0, "Users:\n\tUserInfo{0:Owner:13}"
                if "pm path" in joined:
                    return (0, "package:/data/app/x/base.apk") \
                        if state["present"] else (0, "")
                if "ps -A" in joined:
                    return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
                if "pm uninstall" in joined:
                    state["present"] = False
                    return 0, "Success"
                return 1, ""

            def fake_run_checked(cmd, timeout=120):
                if "install" in " ".join(str(c) for c in cmd):
                    state["present"] = True
                return ""

            exit_info = EXIT_INFO_NATIVE.replace(
                "com.newleaf.app.android.victor", "com.test.pkg")
            log = SIGABRT_BASE_APK_LOG.replace(
                "com.newleaf.app.android.victor", "com.test.pkg")

            def fake_run(cmd, timeout=60):
                joined = " ".join(str(c) for c in cmd)
                assess_cmds.append(joined)
                if "exit-info" in joined:
                    state["exit_calls"] += 1
                    return 0, exit_info if state["exit_calls"] > 1 else ""
                if "monkey" in joined:
                    return 0, "Events injected: 1"
                if joined.endswith("ps -A"):
                    return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
                if "logcat" in joined:
                    return 0, log
                if "pm path" in joined:
                    return 0, "package:/data/app/x/base.apk"
                return 1, ""

            env = {"REELSEC_TEST_PACKAGE": "com.test.pkg",
                   "REELSEC_TEST_KEYSTORE": str(out / "ks"),
                   "REELSEC_DESTRUCTIVE_AUTH": str(auth_path)}
            caps = {"tools": {"adb": {"path": "/adb"},
                              "apksigner": {"path": "/apksigner"}}}
            with mock.patch.dict(os.environ, {
                     "REELSEC_TEST_KEYSTORE_PASSWORD": "test-keystore-pw",
                     "REELSEC_TEST_KEY_PASSWORD": "test-keystore-pw"},
                     clear=False), \
                 mock.patch.object(MODULE, "resolve_test_device",
                                   lambda adb, serial=None: {"serial": "s1"}), \
                 mock.patch.object(MODULE, "run_checked", fake_run_checked), \
                 mock.patch.object(MODULE, "_default_runner",
                                   fake_default_runner), \
                 mock.patch.object(MODULE, "run", fake_run), \
                 mock.patch.object(rh, "_poll_process",
                                   lambda *a, **k: {
                                       "pids": [], "observed": False,
                                       "alive_ms": 0, "alive_at_exit": False,
                                       "poll_attempts": 1,
                                       "first_seen_epoch": None,
                                       "last_seen_epoch": None}):
                doc = MODULE.run_baseline_runtime(out, __file__, caps,
                                                  env=env)
            self.assertEqual(doc["status"], "BASELINE_ASSESSED")
            self.assertEqual(doc["health"]["startup"], "CRASH")
            art = json.loads(
                (out / "BASELINE-CRASH-ARTIFACT.json").read_text())
            self.assertEqual(art["artifact"]["label"], "original")
            self.assertEqual(art["artifact"]["artifact_type"], "ORIGINAL_APK")
            self.assertEqual(art["fatal_signal"], "SIGABRT")
            self.assertEqual(art["apk_offset_resolution"]["status"],
                             "RESOLVED")
            self.assertEqual(art["apk_offset_resolution"]["entry"],
                             PACKED_ENTRY)
            # every destructive command went through the gate and was audited
            audit = (out / "SAFETY-AUDIT.jsonl").read_text()
            self.assertIn("EXECUTED_VERIFIED", audit)
            self.assertTrue(any("pm uninstall" in c for c in gate_cmds))
            # the assessment runner (non-gated path) never saw destruction
            for c in assess_cmds:
                self.assertNotIn("uninstall", c)
                self.assertNotIn("pm clear", c)


class EvidenceGateTests(unittest.TestCase):
    def _detection(self):
        return {"schema_version": "capture-detection-3", "summary": {}}

    def _campaign(self, td, health_startup="CRASH", crash_class="NATIVE_CRASH",
                  probe_status="RUNTIME_ARTIFACT_CRASH", events=None,
                  matches=0):
        cd = Path(td)
        (cd / "RUNTIME-HEALTH.json").write_text(json.dumps({
            "startup": health_startup, "crash_class": crash_class,
            "crash_cause": "NATIVE_LIBRARY:libx.so"}))
        (cd / "RUNTIME-PROBE.json").write_text(json.dumps({
            "status": probe_status, "events": events or [],
            "runtime_matches": matches, "reason_code": "RUNTIME_ARTIFACT_CRASH"}))
        return str(cd)

    def test_crash_blocks_l3_even_with_forged_matching_events(self):
        import evidence_report as er
        forged = [{"event": "TARGET_FUNCTION_ENTER", "target_vptr_match": True,
                   "target_slot_match": True}]
        with tempfile.TemporaryDirectory() as td:
            cd = self._campaign(td, events=forged, matches=1)
            report = er.build_report(self._detection(), campaign_dir=cd)
        self.assertEqual(report["runtime_validity"], "BLOCKED_BY_ARTIFACT_CRASH")
        self.assertEqual(report["runtime_validity_reason"], "NATIVE_CRASH")
        chain = report["causal_chain"]
        self.assertEqual(chain["verdict"], "NOT_PROVEN")
        l3 = [l for l in chain["links"] if l["id"].startswith("L3")][0]
        self.assertEqual(l3["status"], "NOT_PROVEN")
        self.assertIn("BLOCKED_BY_ARTIFACT_CRASH", l3["detail"])
        self.assertFalse(report["causal_proof"])

    def test_healthy_campaign_is_not_blocked(self):
        import evidence_report as er
        with tempfile.TemporaryDirectory() as td:
            cd = self._campaign(td, health_startup="PASS", crash_class="HEALTHY",
                                probe_status="RUNTIME_TARGET_NOT_OBSERVED")
            report = er.build_report(self._detection(), campaign_dir=cd)
        self.assertEqual(report["runtime_validity"], "NOT_BLOCKED")


class InstrumentationImpactTests(unittest.TestCase):
    def test_linkage_rules(self):
        changes = [{"change_id": "X-1", "type": "SMALI_INSTRUMENTATION",
                    "artifact_path": "smali/com/x/Loader.smali"},
                   {"change_id": "G-1", "type": "GADGET",
                    "artifact_path": "lib/arm64-v8a/libfrida-gadget.so"}]
        with tempfile.TemporaryDirectory() as td:
            d = MODULE.write_instrumentation_impact(
                td, changes, crash_cause="NATIVE_LIBRARY:libfrida-gadget.so",
                crash_library="libfrida-gadget.so")
            self.assertEqual(d["crash_linkage"],
                             "POSSIBLY_LINKED_TO_INJECTED:libfrida-gadget.so")
            d = MODULE.write_instrumentation_impact(
                td, changes, crash_cause="NATIVE_LIBRARY:libsaasCorePlayer.so",
                crash_library="libsaasCorePlayer.so")
            self.assertEqual(
                d["crash_linkage"],
                "FAULT_LIBRARY_NOT_INJECTED_BY_REELSEC:libsaasCorePlayer.so")
            d = MODULE.write_instrumentation_impact(
                td, changes, crash_cause=rh.CAUSE_UNKNOWN, crash_library=None)
            self.assertEqual(d["crash_linkage"], "UNRESOLVED_CAUSE_NO_ATTRIBUTION")


class BaselineGatingTests(unittest.TestCase):
    def test_legacy_flag_is_now_a_safety_block_not_a_permission(self):
        # Redesigned contract (2026-10-07 incident): the blanket env flag is
        # a violation that blocks the baseline round; it never authorizes it.
        with tempfile.TemporaryDirectory() as td:
            doc = MODULE.run_baseline_runtime(
                td, __file__, {"tools": {}},
                env={"REELSEC_ALLOW_TEST_DEVICE_UNINSTALL": "1",
                     "REELSEC_TEST_PACKAGE": "com.test.pkg"})
        self.assertEqual(doc["status"], "SAFETY_BLOCKED")
        self.assertIn("authorization document", doc["reason"])

    def test_clean_env_without_test_package_states_specific_reason(self):
        # Precedence contract: a missing TEST PACKAGE identity outranks
        # missing tooling — without an identified target package the round
        # refuses to touch any package, and the reason must name the missing
        # package contract. Hermetic: env is injected, never inherited from
        # the host (the operator shell legitimately exports these vars).
        with tempfile.TemporaryDirectory() as td:
            doc = MODULE.run_baseline_runtime(td, __file__, {"tools": {}},
                                              env={})
        self.assertEqual(doc["status"], "BASELINE_NOT_RUN")
        self.assertIn("REELSEC_TEST_PACKAGE", doc["reason"])

    def test_baseline_disabled_flag_is_respected(self):
        with tempfile.TemporaryDirectory() as td:
            with mock.patch.dict(os.environ, {"REELSEC_BASELINE_RUNTIME": "0"}):
                doc = MODULE.run_baseline_runtime(td, __file__, {"tools": {}})
            self.assertEqual(doc["status"], "BASELINE_NOT_RUN")
            self.assertEqual(doc["reason"], "REELSEC_BASELINE_RUNTIME=0")


if __name__ == "__main__":
    unittest.main()
