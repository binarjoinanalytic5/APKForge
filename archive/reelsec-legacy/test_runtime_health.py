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
import hashlib
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


def _simulated_crash_artifact(label, sha, apk=None, abort_captured=False,
                              process_seen=True):
    """Build a crash-artifact-1 record from the device fixtures."""
    log = SIGABRT_BASE_APK_LOG.replace(
        "com.newleaf.app.android.victor", "com.x")
    tomb = rh.parse_tombstone_logcat(log)
    if abort_captured:
        tomb["abort_message"] = "Abort message: 'simulated check failed'"
    entries = rh.parse_exit_info(
        EXIT_INFO_NATIVE.replace("com.newleaf.app.android.victor", "com.x"))
    return rh.build_crash_artifact(
        "com.x", label, entries, tomb,
        installed_path="/data/app/~~x/com.x/base.apk",
        artifact_apk=str(apk) if apk else None,
        artifact_sha256=sha,
        session={
            "started_at_epoch": 100.0, "observe_s": 2, "launch_returncode": 0,
            "first_process_seen_epoch": 100.4 if process_seen else None,
            "last_process_seen_epoch": 100.9 if process_seen else None,
            "observed_process_lifetime_ms": 500 if process_seen else 0,
            "process_alive_at_exit": False,
        })


class CrashComparisonTests(unittest.TestCase):
    """Original vs instrumented crash comparison: independent sides,
    explicit BOTH_CRASH, never attributed to instrumentation by default."""

    def test_both_crash_explicit_status_and_attribution_guard(self):
        with tempfile.TemporaryDirectory() as td:
            apk = _craft_apk_with_offset(Path(td) / "a.apk")
            ins = _simulated_crash_artifact("instrumented", "f" * 64, apk)
            orig = _simulated_crash_artifact("original", "e" * 64, apk)
        cmp = rh.build_crash_comparison(ins, orig)
        self.assertEqual(cmp["status"], "BOTH_CRASH")
        self.assertEqual(cmp["schema_version"], "crash-comparison-1")
        self.assertEqual(cmp["attribution"]["instrumentation_regression"],
                         "NOT_ESTABLISHED")
        self.assertIn("MUST NOT be attributed to instrumentation",
                      cmp["attribution"]["guard"])
        q = cmp["questions"]
        self.assertTrue(q["both_sigabrt"])
        self.assertTrue(q["fatal_signals"]["match"])
        self.assertTrue(q["fault_location"]["match"])
        self.assertEqual(q["fault_location"]["instrumented"],
                         "base.apk+00031e10")
        self.assertFalse(q["abort_message"]["captured_either"])
        self.assertTrue(
            any("MUST NOT be labeled anti-tamper" in n
                for n in cmp["integrity_notes"]))
        # per-side bindings stay independent (never merged)
        self.assertEqual(cmp["instrumented"]["artifact_sha256"], "f" * 64)
        self.assertEqual(cmp["original"]["artifact_sha256"], "e" * 64)
        self.assertEqual(cmp["instrumented"]["uids"], [10285, 9510285])
        self.assertEqual(cmp["instrumented"]["users"], [0, 95])
        self.assertEqual(ins["crash_instances"][0]["package"], "com.x")
        self.assertEqual(cmp["source_documents"]["instrumented"],
                         "CRASH-ARTIFACT.json")
        self.assertEqual(cmp["source_documents"]["original"],
                         "BASELINE-CRASH-ARTIFACT.json")

    def test_instrumented_only_crash_is_candidate_not_proven(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        cmp = rh.build_crash_comparison(ins, None)
        self.assertEqual(cmp["status"], "INSTRUMENTED_ONLY_CRASH")
        self.assertEqual(cmp["attribution"]["instrumentation_regression"],
                         "SUSPECTED_NOT_PROVEN")
        self.assertIsNone(cmp["original"])

    def test_original_only_crash_not_caused_by_instrumentation(self):
        orig = _simulated_crash_artifact("original", "e" * 64)
        cmp = rh.build_crash_comparison(None, orig)
        self.assertEqual(cmp["status"], "ORIGINAL_ONLY_CRASH")
        self.assertIn("not caused by instrumentation",
                      cmp["attribution"]["guard"])
        self.assertIsNone(cmp["instrumented"])

    def test_no_crash_evidence_returns_none(self):
        self.assertIsNone(rh.build_crash_comparison(None, None))

    def test_offsets_resolved_independently_per_artifact(self):
        """Same pc may map into DIFFERENT entries of two different builds;
        resolution is per-artifact and identity is never assumed."""
        with tempfile.TemporaryDirectory() as td:
            apk_a = _craft_apk_with_offset(Path(td) / "a.apk")
            apk_b = _craft_apk_with_offset(
                Path(td) / "b.apk", name="lib/arm64-v8a/libother.so")
            ins = _simulated_crash_artifact("instrumented", "f" * 64, apk_a)
            orig = _simulated_crash_artifact("original", "e" * 64, apk_b)
        cmp = rh.build_crash_comparison(ins, orig)
        off = cmp["questions"]["apk_offset_resolution"]
        self.assertEqual(off["instrumented"]["entry"], PACKED_ENTRY)
        self.assertEqual(off["original"]["entry"],
                         "lib/arm64-v8a/libother.so")
        self.assertFalse(off["resolved_identically"])
        # same pc string, but independently resolved files
        self.assertTrue(cmp["questions"]["fault_location"]["match"])

    def test_abort_message_captured_on_one_side_only(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        orig = _simulated_crash_artifact("original", "e" * 64,
                                         abort_captured=True)
        cmp = rh.build_crash_comparison(ins, orig)
        am = cmp["questions"]["abort_message"]
        self.assertFalse(am["instrumented_captured"])
        self.assertTrue(am["original_captured"])
        self.assertTrue(am["captured_either"])
        # labeling guard only applies when NO side captured a message
        self.assertFalse(
            any("MUST NOT be labeled anti-tamper" in n
                for n in cmp["integrity_notes"]))

    def test_startup_stage_compared_not_assumed(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64,
                                        process_seen=True)
        orig = _simulated_crash_artifact("original", "e" * 64,
                                         process_seen=False)
        cmp = rh.build_crash_comparison(ins, orig)
        stage = cmp["questions"]["startup_stage"]
        self.assertEqual(stage["instrumented"],
                         "CRASHED_AFTER_PROCESS_OBSERVED")
        self.assertEqual(stage["original"],
                         "CRASHED_BEFORE_PROCESS_OBSERVED")
        self.assertFalse(stage["match"])


class _ProbeHarness(unittest.TestCase):
    """Integration: write_runtime_probe with a faked device."""

    def setUp(self):
        self.td = tempfile.TemporaryDirectory()
        self.out = Path(self.td.name)
        self.root = self.out / "decoded"
        self.root.mkdir()
        self.frida_calls = []
        self.cmd_log = []
        os.environ.pop("REELSEC_USE_GADGET", None)
        os.environ["REELSEC_HEALTH_WINDOW_MS"] = "2000"
        # Platform contract: runtime may assess the package only when the
        # sign/deploy documents of THIS campaign prove the full chain.
        self._stage_binding(status="INSTALLED")

    def _stage_binding(self, status="INSTALLED", identity="MATCH",
                       sha="aa" * 32, cert="bb" * 32, package="com.x"):
        (self.out / "SIGN-VERIFY.json").write_text(json.dumps({
            "status": "SIGNED_VERIFIED",
            "signed_path": str(self.out / "instrumented-signed.apk"),
            "signed_sha256": sha,
            "certificate_sha256": cert,
        }), encoding="utf-8")
        (self.out / "ADB-DEPLOY.json").write_text(json.dumps({
            "status": status,
            "package": package,
            "artifact": str(self.out / "instrumented-signed.apk"),
            "artifact_sha256": sha,
            "certificate_sha256": cert,
            "post_install_identity": {"identity": identity}
            if identity is not None else None,
        }), encoding="utf-8")

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
            self.cmd_log.append(joined)
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
        self._stage_binding(status="INSTALLED", identity="MATCH",
                            sha="f" * 64, cert="c" * 64)
        (self.out / "ADB-DEPLOY.json").write_text(json.dumps(dict(
            json.loads((self.out / "ADB-DEPLOY.json").read_text()),
            artifact=str(apk))), encoding="utf-8")
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

    def test_probe_writes_crash_comparison_when_both_sides_crash(self):
        """Campaign path: baseline artifact already on disk + instrumented
        crash => CRASH-COMPARISON.json explicitly reports BOTH_CRASH and the
        verdict surfaces it."""
        apk = _craft_apk_with_offset(self.out / "instrumented-signed.apk")
        self._stage_binding(status="INSTALLED", identity="MATCH",
                            sha="f" * 64, cert="c" * 64)
        (self.out / "ADB-DEPLOY.json").write_text(json.dumps(dict(
            json.loads((self.out / "ADB-DEPLOY.json").read_text()),
            artifact=str(apk))), encoding="utf-8")
        (self.out / "BASELINE-CRASH-ARTIFACT.json").write_text(
            json.dumps(_simulated_crash_artifact("original", "e" * 64,
                                                 apk)),
            encoding="utf-8")
        exit_info = EXIT_INFO_NATIVE.replace(
            "com.newleaf.app.android.victor", "com.x")
        log = SIGABRT_BASE_APK_LOG.replace(
            "com.newleaf.app.android.victor", "com.x")
        result = self._run_probe(self._runner(exit_post=exit_info,
                                              crash_log=log))
        self.assertEqual(result["status"], "RUNTIME_ARTIFACT_CRASH")
        cmp_doc = json.loads((self.out / "CRASH-COMPARISON.json").read_text())
        self.assertEqual(cmp_doc["status"], "BOTH_CRASH")
        self.assertTrue(cmp_doc["questions"]["both_sigabrt"])
        self.assertEqual(cmp_doc["source_documents"]["instrumented"],
                         "CRASH-ARTIFACT.json")
        self.assertEqual(cmp_doc["source_documents"]["original"],
                         "BASELINE-CRASH-ARTIFACT.json")
        verdict = json.loads((self.out / "RUNTIME-VERDICT.json").read_text())
        self.assertEqual(verdict["CRASH_COMPARISON"], "BOTH_CRASH")

    def test_probe_refuses_foreign_leftover_without_binding(self):
        """A present but unbound package is never launched or assessed."""
        (self.out / "ADB-DEPLOY.json").unlink()
        (self.out / "SIGN-VERIFY.json").unlink()
        result = self._run_probe(self._runner())
        self.assertEqual(result["status"], "SIGN_BLOCKED")
        health = json.loads(
            (self.out / "RUNTIME-HEALTH.json").read_text(encoding="utf-8"))
        self.assertEqual(health["status"], "BLOCKED")
        self.assertIsNone(health["startup"])
        self.assertFalse(health["runtime_probe_allowed"])
        self.assertEqual(self.frida_calls, [])
        self.assertFalse(any("monkey" in c for c in self.cmd_log))
        self.assertFalse(any("force-stop" in c for c in self.cmd_log))

    def test_probe_refuses_when_deploy_did_not_install(self):
        """Sign-verified but not deployed: DEPLOY_BLOCKED, nothing runs."""
        self._stage_binding(status="BLOCKED_OR_FAILED")
        (self.out / "ADB-DEPLOY.json").write_text(json.dumps(dict(
            json.loads((self.out / "ADB-DEPLOY.json").read_text()),
            error="deploy not ready")), encoding="utf-8")
        result = self._run_probe(self._runner())
        self.assertEqual(result["status"], "DEPLOY_BLOCKED")
        self.assertIn("deploy not ready", result["reason"])
        health = json.loads(
            (self.out / "RUNTIME-HEALTH.json").read_text(encoding="utf-8"))
        self.assertEqual(health["status"], "BLOCKED")
        self.assertEqual(self.frida_calls, [])
        self.assertFalse(any("monkey" in c for c in self.cmd_log))

    def test_probe_refuses_on_identity_mismatch(self):
        """INSTALLED with a non-MATCH identity record: not our artifact."""
        self._stage_binding(status="INSTALLED", identity="MISMATCH")
        result = self._run_probe(self._runner())
        self.assertEqual(result["status"], "DEPLOY_BLOCKED")
        health = json.loads(
            (self.out / "RUNTIME-HEALTH.json").read_text(encoding="utf-8"))
        self.assertEqual(health["status"], "BLOCKED")
        self.assertEqual(self.frida_calls, [])


class BaselineRoundTests(unittest.TestCase):
    """The baseline (original) round must run NON-destructively: a replace
    install without any uninstall; a gated uninstall happens ONLY via an
    explicit hash-bound authorization document when the installed build has
    an incompatible signature — never automatically."""

    EXIT_INFO = EXIT_INFO_NATIVE.replace(
        "com.newleaf.app.android.victor", "com.test.pkg")
    LOG = SIGABRT_BASE_APK_LOG.replace(
        "com.newleaf.app.android.victor", "com.test.pkg")

    def _run_baseline(self, out, env, install_outputs):
        """Run the baseline round against a fake device.

        `install_outputs` is the list of (rc, output) returned by successive
        'adb install' attempts. Returns (doc, gate_cmds, all_cmds)."""
        state = {"exit_calls": 0, "installs": 0, "present": True}
        gate_cmds, all_cmds = [], []

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

        def fake_run(cmd, timeout=60):
            joined = " ".join(str(c) for c in cmd)
            all_cmds.append(joined)
            if "install" in joined:
                idx = min(state["installs"], len(install_outputs) - 1)
                state["installs"] += 1
                rc, out = install_outputs[idx]
                if rc == 0:
                    state["present"] = True
                return rc, out
            if "exit-info" in joined:
                state["exit_calls"] += 1
                return 0, self.EXIT_INFO if state["exit_calls"] > 1 else ""
            if "monkey" in joined:
                return 0, "Events injected: 1"
            if joined.endswith("ps -A"):
                return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
            if "logcat" in joined:
                return 0, self.LOG
            if "pm path" in joined:
                return 0, "package:/data/app/x/base.apk"
            return 1, ""

        caps = {"tools": {"adb": {"path": "/adb"},
                          "apksigner": {"path": "/apksigner"}}}
        with mock.patch.dict(os.environ, {
                 "REELSEC_TEST_KEYSTORE_PASSWORD": "test-keystore-pw",
                 "REELSEC_TEST_KEY_PASSWORD": "test-keystore-pw"},
                 clear=False), \
             mock.patch.object(MODULE, "resolve_test_device",
                               lambda adb, serial=None: {"serial": "s1"}), \
             mock.patch.object(MODULE, "run_checked",
                               lambda cmd, timeout=120: ""), \
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
            doc = MODULE.run_baseline_runtime(out, __file__, caps, env=env)
        return doc, gate_cmds, all_cmds

    def test_baseline_runs_non_destructively_without_any_authorization(self):
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            _craft_apk_with_offset(out / "original-testsigned.apk")
            # NO REELSEC_DESTRUCTIVE_AUTH: the round must still run
            env = {"REELSEC_TEST_PACKAGE": "com.test.pkg",
                   "REELSEC_TEST_KEYSTORE": str(out / "ks")}
            doc, gate_cmds, all_cmds = self._run_baseline(
                out, env, [(0, "Success")])
            self.assertEqual(doc["status"], "BASELINE_ASSESSED")
            self.assertEqual(doc["install"]["mode"],
                             "NON_DESTRUCTIVE_INSTALL_R")
            self.assertFalse(doc["install"]["uninstall_attempted"])
            self.assertEqual(doc["health"]["startup"], "CRASH")
            # ZERO destructive commands anywhere: no uninstall, no clear
            for c in gate_cmds + all_cmds:
                self.assertNotIn("uninstall", c)
                self.assertNotIn("pm clear", c)
            self.assertFalse((out / "SAFETY-AUDIT.jsonl").exists())
            # original-side evidence + independent comparison still produced
            art = json.loads(
                (out / "BASELINE-CRASH-ARTIFACT.json").read_text())
            self.assertEqual(art["artifact"]["label"], "original")
            self.assertEqual(art["artifact"]["artifact_type"], "ORIGINAL_APK")
            self.assertEqual(art["fatal_signal"], "SIGABRT")
            self.assertEqual(art["apk_offset_resolution"]["status"],
                             "RESOLVED")
            self.assertEqual(art["apk_offset_resolution"]["entry"],
                             PACKED_ENTRY)
            cmp_doc = json.loads(
                (out / "CRASH-COMPARISON.json").read_text())
            self.assertEqual(cmp_doc["status"], "ORIGINAL_ONLY_CRASH")
            self.assertIn("not caused by instrumentation",
                          cmp_doc["attribution"]["guard"])
            # the original is intentionally left installed (non-destructive)
            self.assertEqual(doc["post_round"]["action"],
                             "NONE_NON_DESTRUCTIVE")

    def test_incompatible_installed_build_blocks_without_authorization(self):
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            _craft_apk_with_offset(out / "original-testsigned.apk")
            env = {"REELSEC_TEST_PACKAGE": "com.test.pkg",
                   "REELSEC_TEST_KEYSTORE": str(out / "ks")}
            doc, gate_cmds, all_cmds = self._run_baseline(
                out, env,
                [(1, "Failure [INSTALL_FAILED_UPDATE_INCOMPATIBLE]")])
            self.assertEqual(doc["status"],
                             "BASELINE_BLOCKED_INCOMPATIBLE_INSTALL")
            self.assertIn("deny-by-default", doc["reason"])
            # nothing destructive was attempted, nothing was assessed
            for c in gate_cmds + all_cmds:
                self.assertNotIn("uninstall", c)
                self.assertNotIn("pm clear", c)
            self.assertFalse((out / "BASELINE-CRASH-ARTIFACT.json").exists())
            self.assertFalse(any("monkey" in c for c in all_cmds))

    def test_incompatible_build_falls_back_to_gated_uninstall_with_auth(self):
        import safety_gate as sg
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            _craft_apk_with_offset(out / "original-testsigned.apk")
            auth = {
                "schema_version": sg.SCHEMA_AUTH,
                "operation": "UNINSTALL",
                "package": "com.test.pkg",
                "user": 0,
                "device_serial": "s1",
                "issued_at_epoch": time.time() - 10,
                "expires_at_epoch": time.time() + 600,
                "authorized_by": "operator",
                "reason": "incompatible-signature baseline fallback test",
            }
            auth_path = out / "auth.json"
            auth_path.write_text(json.dumps(auth), encoding="utf-8")
            env = {"REELSEC_TEST_PACKAGE": "com.test.pkg",
                   "REELSEC_TEST_KEYSTORE": str(out / "ks"),
                   "REELSEC_DESTRUCTIVE_AUTH": str(auth_path)}
            doc, gate_cmds, all_cmds = self._run_baseline(
                out, env,
                [(1, "Failure [INSTALL_FAILED_UPDATE_INCOMPATIBLE]"),
                 (0, "Success")])
            self.assertEqual(doc["status"], "BASELINE_ASSESSED")
            self.assertEqual(doc["install"]["mode"],
                             "GATED_UNINSTALL_THEN_INSTALL")
            self.assertEqual(doc["gated_uninstall"]["status"],
                             "EXECUTED_VERIFIED")
            self.assertIn("EXECUTED_VERIFIED",
                          (out / "SAFETY-AUDIT.jsonl").read_text())
            # the ONLY destructive command went through the gate runner,
            # never through the assessment runner
            self.assertTrue(any("pm uninstall" in c for c in gate_cmds))
            for c in all_cmds:
                self.assertNotIn("uninstall", c)
                self.assertNotIn("pm clear", c)


DUMPSYS_PACKAGE_FIXTURE = """Packages:
  Package [com.test.pkg] (a1b2c3d):
    userId=10285
    codePath=/data/app/~~abc==/com.test.pkg-xyz==
    versionName=4.2.00
    versionCode=4200 minSdk=24 targetSdk=34
    primaryCpuAbi=arm64-v8a
    signatures=PackageSignatures{f1e2d3c4 version:3, signatures:%s, past signatures:42424242}
    User 0: ceDataInode=0 installed=true hidden=false stopped=false
    User 95: ceDataInode=0 installed=true hidden=false stopped=false
""" % ("ab" * 64)

EXPECTED_CERT_SHA = __import__("hashlib").sha256(
    bytes.fromhex("ab" * 64)).hexdigest()


def _control_runner(state, exit_info="", crash_log="", present=True,
                    apk_sha=None):
    def fake(cmd, timeout=60):
        joined = " ".join(str(c) for c in cmd)
        state["cmds"].append(joined)
        if "pm path" in joined:
            if not present:
                return 1, ""
            return 0, "package:/data/app/~~abc==/com.test.pkg-xyz==/base.apk"
        if "dumpsys package" in joined:
            return 0, DUMPSYS_PACKAGE_FIXTURE
        if "sha256sum" in joined:
            return 0, "%s  /data/app/~~abc==/com.test.pkg-xyz==/base.apk" % (
                apk_sha or "c" * 64)
        if "exit-info" in joined:
            state["exit_calls"] += 1
            return 0, exit_info if state["exit_calls"] > 1 else ""
        if "monkey" in joined:
            return 0, "Events injected: 1"
        if joined.endswith("ps -A"):
            return 0, "USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
        if "logcat" in joined:
            return 0, crash_log
        return 1, ""
    return fake


class WorkingControlTests(unittest.TestCase):
    """Working control = the CURRENTLY INSTALLED package observed in place.
    Read-only fingerprint + bounded observed launch; NEVER install,
    uninstall, clear-data, re-install, or bypass."""

    EXIT_INFO = EXIT_INFO_NATIVE.replace(
        "com.newleaf.app.android.victor", "com.test.pkg")
    LOG = SIGABRT_BASE_APK_LOG.replace(
        "com.newleaf.app.android.victor", "com.test.pkg")

    def _collect(self, present=True, crash=False, apk_sha=None,
                 local_ref=None):
        state = {"cmds": [], "exit_calls": 0}
        runner = _control_runner(
            state,
            exit_info=self.EXIT_INFO if crash else "",
            crash_log=self.LOG if crash else "",
            present=present, apk_sha=apk_sha)
        with mock.patch("time.sleep"):
            doc = rh.collect_working_control(
                runner, "/adb", "s1", "com.test.pkg", observe_s=0.05,
                local_reference_apk=local_ref)
        return doc, state["cmds"]

    def test_healthy_control_full_fingerprint_zero_destructive_commands(self):
        doc, cmds = self._collect(present=True, crash=False)
        self.assertEqual(doc["status"], "CONTROL_ASSESSED")
        ident = doc["identity"]
        self.assertEqual(ident["version_name"], "4.2.00")
        self.assertEqual(ident["version_code"], "4200")
        self.assertEqual(ident["uid"], "10285")
        self.assertEqual(ident["code_path"],
                         "/data/app/~~abc==/com.test.pkg-xyz==")
        self.assertEqual(ident["primary_cpu_abi"], "arm64-v8a")
        self.assertEqual(ident["users_installed"], [0, 95])
        self.assertEqual(ident["apk_sha256"], "c" * 64)
        self.assertEqual(ident["signing_certificate_sha256"],
                         EXPECTED_CERT_SHA)
        # exactly one observational launch and ZERO state-changing commands
        self.assertEqual(sum(1 for c in cmds if "monkey" in c), 1)
        for c in cmds:
            self.assertNotIn("install", c)
            self.assertNotIn("uninstall", c)
            self.assertNotIn("pm clear", c)

    def test_not_installed_control_launches_and_touches_nothing(self):
        doc, cmds = self._collect(present=False)
        self.assertEqual(doc["status"], "CONTROL_NOT_INSTALLED")
        self.assertIn("nothing was modified", doc["reason"])
        for c in cmds:
            self.assertNotIn("monkey", c)
            self.assertNotIn("install", c)
            self.assertNotIn("uninstall", c)
            self.assertNotIn("pm clear", c)

    def test_crashed_control_collects_fault_and_abort_absence(self):
        doc, _ = self._collect(present=True, crash=True)
        self.assertEqual(doc["status"], "CONTROL_CRASHED")
        art = doc["crash_artifact"]
        self.assertEqual(art["fatal_signal"], "SIGABRT")
        self.assertEqual(art["fault_location"]["library"], "base.apk")
        self.assertEqual(art["fault_location"]["pc"], "00031e10")
        self.assertIsNone(art["abort_message"])
        # no local reference provided => offset honestly UNRESOLVED
        self.assertEqual(art["apk_offset_resolution"]["status"], "UNRESOLVED")

    def test_offset_resolved_only_when_local_reference_is_hash_bound(self):
        with tempfile.TemporaryDirectory() as td:
            apk = _craft_apk_with_offset(Path(td) / "original.apk")
            import hashlib
            real_sha = hashlib.sha256(apk.read_bytes()).hexdigest()
            doc, _ = self._collect(present=True, crash=True,
                                   apk_sha=real_sha, local_ref=str(apk))
            self.assertTrue(
                doc["identity"]["local_reference"]["matches_installed"])
            res = doc["crash_artifact"]["apk_offset_resolution"]
            self.assertEqual(res["status"], "RESOLVED")
            self.assertEqual(res["entry"], PACKED_ENTRY)
            # a NON-matching hash must never resolve offsets
            doc2, _ = self._collect(present=True, crash=True,
                                    apk_sha="c" * 64, local_ref=str(apk))
            self.assertFalse(
                doc2["identity"]["local_reference"]["matches_installed"])
            self.assertEqual(
                doc2["crash_artifact"]["apk_offset_resolution"]["status"],
                "UNRESOLVED")


class WorkingControlRoundTests(unittest.TestCase):
    """run_working_control_round wiring: refusal reasons, document writes,
    and the common-cause comparison refresh."""

    EXIT_INFO = EXIT_INFO_NATIVE.replace(
        "com.newleaf.app.android.victor", "com.test.pkg")
    LOG = SIGABRT_BASE_APK_LOG.replace(
        "com.newleaf.app.android.victor", "com.test.pkg")

    def test_requires_test_package_identity(self):
        with tempfile.TemporaryDirectory() as td:
            doc = MODULE.run_working_control_round(td, {"tools": {}}, env={})
        self.assertEqual(doc["status"], "CONTROL_NOT_RUN")
        self.assertIn("REELSEC_TEST_PACKAGE", doc["reason"])

    def test_blanket_destructive_flag_blocks_the_round(self):
        with tempfile.TemporaryDirectory() as td:
            doc = MODULE.run_working_control_round(
                td, {"tools": {}},
                env={"REELSEC_ALLOW_TEST_DEVICE_UNINSTALL": "1",
                     "REELSEC_TEST_PACKAGE": "com.test.pkg"})
        self.assertEqual(doc["status"], "SAFETY_BLOCKED")

    def test_round_writes_control_and_common_cause_documents(self):
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            # instrumented side already on disk from the probe round
            (out / "CRASH-ARTIFACT.json").write_text(json.dumps(
                _simulated_crash_artifact("instrumented", "f" * 64)),
                encoding="utf-8")
            state = {"cmds": [], "exit_calls": 0}
            runner = _control_runner(state, exit_info=self.EXIT_INFO,
                                     crash_log=self.LOG, present=True)
            env = {"REELSEC_TEST_PACKAGE": "com.test.pkg"}
            caps = {"tools": {"adb": {"path": "/adb"}}}
            with mock.patch.object(MODULE, "resolve_test_device",
                                   lambda adb, serial=None: {"serial": "s1"}), \
                 mock.patch.object(MODULE, "run", runner), \
                 mock.patch.object(rh, "_poll_process",
                                   lambda *a, **k: {
                                       "pids": [], "observed": False,
                                       "alive_ms": 0, "alive_at_exit": False,
                                       "poll_attempts": 1,
                                       "first_seen_epoch": None,
                                       "last_seen_epoch": None}):
                doc = MODULE.run_working_control_round(out, caps, env=env)
            self.assertEqual(doc["status"], "CONTROL_CRASHED")
            wc = json.loads((out / "WORKING-CONTROL.json").read_text())
            self.assertEqual(wc["identity"]["version_name"], "4.2.00")
            cmp_doc = json.loads(
                (out / "COMMON-CAUSE-COMPARISON.json").read_text())
            self.assertEqual(cmp_doc["status"], "COMMON_CAUSE_BOTH_CRASH")
            self.assertIn("MUST NOT be attributed to instrumentation",
                          cmp_doc["attribution"]["guard"])
            # the whole round issued zero state-changing commands
            for c in state["cmds"]:
                self.assertNotIn("install", c)
                self.assertNotIn("uninstall", c)
                self.assertNotIn("pm clear", c)


class CommonCauseComparisonTests(unittest.TestCase):
    """common-cause-comparison-1: installed control vs instrumented, sides
    never merged, verdict never upgraded."""

    def _control(self, status, apk_sha="e" * 64):
        return {
            "schema_version": "working-control-1",
            "status": status,
            "package": "com.x",
            "installed_path": "/data/app/~~x/com.x/base.apk",
            "identity": {"apk_sha256": apk_sha,
                         "signing_certificate_sha256": "d" * 64,
                         "version_name": "4.2.00", "version_code": "4200",
                         "uid": "10285", "users_installed": [0, 95],
                         "code_path": "/data/app/~~x/com.x",
                         "primary_cpu_abi": "arm64-v8a"},
            "process": {"pids": [14210], "observed": True, "alive_ms": 900},
            "crash_artifact": (
                _simulated_crash_artifact("working_control", apk_sha)
                if status == "CONTROL_CRASHED" else None),
        }

    def test_both_crash_common_cause_not_instrumentation(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_CRASHED"), ins)
        self.assertEqual(cmp["status"], "COMMON_CAUSE_BOTH_CRASH")
        self.assertEqual(cmp["attribution"]["instrumentation_regression"],
                         "NOT_ESTABLISHED")
        self.assertIn("MUST NOT be attributed to instrumentation",
                      cmp["attribution"]["guard"])
        q = cmp["questions"]
        self.assertTrue(q["both_sigabrt"])
        self.assertTrue(q["fault_location"]["match"])
        self.assertEqual(q["fault_location"]["working_control"],
                         "base.apk+00031e10")
        self.assertFalse(q["abort_message"]["captured_either"])
        # per-side bindings stay independent — both sides use the SAME
        # unified schema field names (end-to-end requirement 6)
        self.assertEqual(cmp["working_control"]["artifact_sha256"], "e" * 64)
        self.assertEqual(cmp["instrumented"]["artifact_sha256"], "f" * 64)
        for field in rh.UNIFIED_SIDE_FIELDS:
            self.assertIn(field, cmp["working_control"])
            self.assertIn(field, cmp["instrumented"])

    def test_control_healthy_instrumented_crash_is_candidate_not_proven(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_ASSESSED"), ins)
        self.assertEqual(cmp["status"],
                         "CONTROL_HEALTHY_INSTRUMENTED_CRASH")
        self.assertEqual(cmp["attribution"]["instrumentation_regression"],
                         "SUSPECTED_NOT_PROVEN")

    def test_control_only_crash_not_caused_by_instrumentation(self):
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_CRASHED"), None)
        self.assertEqual(cmp["status"], "CONTROL_ONLY_CRASH")
        self.assertIn("not caused by instrumentation",
                      cmp["attribution"]["guard"])

    def test_control_healthy_without_instrumented_evidence(self):
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_ASSESSED"), None)
        self.assertEqual(cmp["status"],
                         "CONTROL_HEALTHY_NO_INSTRUMENTED_EVIDENCE")

    def test_instrumented_only_is_incomplete_not_a_claim(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        cmp = rh.build_common_cause_comparison(None, ins)
        self.assertEqual(cmp["status"], "COMMON_CAUSE_INCOMPLETE")
        self.assertIn("no common-cause claim may be made",
                      cmp["attribution"]["guard"])

    def test_no_evidence_returns_none(self):
        self.assertIsNone(rh.build_common_cause_comparison(None, None))

    def test_comparison_never_upgrades_screenshot_blocking(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_CRASHED"), ins)
        self.assertTrue(
            any("MUST NOT upgrade SCREENSHOT_BLOCKING" in n
                for n in cmp["integrity_notes"]))
        self.assertTrue(
            any("MUST NOT be labeled anti-tamper" in n
                for n in cmp["integrity_notes"]))


class WorkingControlVerdictTests(unittest.TestCase):
    """Platform wiring: skip logic + verdict surfaces the new documents."""

    def test_baseline_skipped_only_when_control_verified(self):
        verified = {"status": "CONTROL_ASSESSED", "identity": {
            "original_verification": {"verified": True,
                                      "installed_sha256": "e" * 64,
                                      "reference_sha256": "e" * 64}}}
        crashed = {"status": "CONTROL_CRASHED", "identity": {
            "original_verification": {"verified": True,
                                      "installed_sha256": "e" * 64,
                                      "reference_sha256": "e" * 64}}}
        self.assertIsNotNone(MODULE._baseline_skip_reason(verified))
        self.assertIsNotNone(MODULE._baseline_skip_reason(crashed))
        self.assertIn("VERIFIED", MODULE._baseline_skip_reason(verified))

    def test_baseline_runs_when_control_unverified(self):
        """An observed-but-unverified control is NOT a baseline: the
        install-based baseline round must run to establish the original
        side (2026-10-08T15-11-17 incident)."""
        unverified = {"status": "CONTROL_ASSESSED", "identity": {
            "original_verification": {"verified": False,
                                      "installed_sha256": "f" * 64,
                                      "reference_sha256": "e" * 64}}}
        self.assertIsNone(MODULE._baseline_skip_reason(unverified))
        self.assertIsNone(MODULE._baseline_skip_reason(
            {"status": "CONTROL_ASSESSED"}))
        self.assertIsNone(MODULE._baseline_skip_reason(
            {"status": "CONTROL_CRASHED"}))
        self.assertIsNone(MODULE._baseline_skip_reason(
            {"status": "CONTROL_NOT_INSTALLED"}))
        self.assertIsNone(MODULE._baseline_skip_reason(None))


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


class CampaignStateMachineTests(unittest.TestCase):
    """End-to-end requirement 4: one explicit state machine, every
    transition with a reason."""

    def test_safety_blocked_is_terminal(self):
        sm = rh.campaign_state_machine(
            safety={"safety": "BLOCKED", "reason": "blanket flag"})
        self.assertEqual(sm["state"], "SAFETY_BLOCKED")
        self.assertEqual(len(sm["transitions"]), 1)
        self.assertTrue(sm["transitions"][0]["reason"])

    def test_no_device(self):
        sm = rh.campaign_state_machine(device_ok=False)
        self.assertEqual(sm["state"], "NO_DEVICE")

    def test_both_crash_common_cause_path(self):
        sm = rh.campaign_state_machine(
            safety={"safety": "OK"}, device_ok=True,
            working_control={"status": "CONTROL_CRASHED"},
            instrumented_health={"startup": "CRASH",
                                 "crash_class": "NATIVE_CRASH"},
            common_cause={"status": "COMMON_CAUSE_BOTH_CRASH"})
        states = [t["to"] for t in sm["transitions"]]
        self.assertIn("DEVICE_READY", states)
        self.assertIn("CONTROL_CRASHED", states)
        self.assertIn("INSTRUMENTED_CRASHED", states)
        self.assertIn("COMMON_CAUSE_BOTH_CRASH", states)
        self.assertTrue(all(t["reason"] for t in sm["transitions"]))

    def test_instrumentation_only_crash_path(self):
        sm = rh.campaign_state_machine(
            working_control={"status": "CONTROL_ASSESSED"},
            instrumented_health={"startup": "CRASH"},
            common_cause={"status": "CONTROL_HEALTHY_INSTRUMENTED_CRASH"})
        self.assertIn("INSTRUMENTATION_ONLY_CRASH",
                      [t["to"] for t in sm["transitions"]])

    def test_original_only_crash_path(self):
        sm = rh.campaign_state_machine(
            working_control={"status": "CONTROL_CRASHED"},
            common_cause={"status": "CONTROL_ONLY_CRASH"})
        self.assertIn("ORIGINAL_ONLY_CRASH",
                      [t["to"] for t in sm["transitions"]])

    def test_proven_requires_full_chain(self):
        sm = rh.campaign_state_machine(
            instrumented_health={"startup": "PASS"},
            evidence={"causal_proof": True})
        self.assertEqual(sm["state"], "PROVEN")

    def test_incomplete_chain_is_explicit(self):
        sm = rh.campaign_state_machine(
            instrumented_health={"startup": "PASS"},
            evidence={"causal_proof": False, "missing": ["L4"]})
        self.assertEqual(sm["state"], "CAUSAL_CHAIN_INCOMPLETE")


class CrashInstanceSynthesisTests(unittest.TestCase):
    """End-to-end requirement 8: tombstone evidence never collapses to
    crash_instances=[] and incomplete parsing never upgrades a verdict."""

    def _tombstone(self, pid=14210):
        return {"fatal_signal": "SIGABRT", "package_associated": True,
                "pid": pid, "thread_name": "com.x",
                "fatal_lines": ["F/libc: Fatal signal 6 (SIGABRT), code -1"],
                "package_matched_lines": ["pid: %d, tid: %d, name: com.x"
                                          % (pid, pid)],
                "backtrace_frames": [], "abort_message": None}

    def test_tombstone_only_builds_structured_instance(self):
        art = rh.build_crash_artifact("com.x", "instrumented", [],
                                      self._tombstone())
        self.assertEqual(len(art["crash_instances"]), 1)
        inst = art["crash_instances"][0]
        self.assertEqual(inst["source"], "LOGCAT_TOMBSTONE_ECHO")
        self.assertEqual(inst["pid"], 14210)
        self.assertIsNone(inst["uid"])   # never fabricated
        self.assertIsNone(inst["user"])
        self.assertEqual(art["grouping"]["instances_completeness"],
                         "EVIDENCE_PRESENT_BUT_INSTANCE_INCOMPLETE")
        self.assertTrue(any("MUST NOT upgrade" in n
                            for n in art["integrity_notes"]))
        # raw evidence preserved
        self.assertTrue(art["evidence_lines"]["fatal_lines"])

    def test_exit_info_instances_are_complete(self):
        entries = [{"package": "com.x", "uid": 10285, "pid": 111,
                    "timestamp": "t", "reason_code": 6, "status": 0}]
        art = rh.build_crash_artifact("com.x", "instrumented", entries, {})
        self.assertEqual(art["grouping"]["instances_completeness"],
                         "EXIT_INFO_COMPLETE")
        self.assertEqual(art["crash_instances"][0]["source"],
                         "APPLICATION_EXIT_INFO")

    def test_no_evidence_no_instances(self):
        art = rh.build_crash_artifact("com.x", "instrumented", [], {})
        self.assertEqual(art["crash_instances"], [])
        self.assertEqual(art["grouping"]["instances_completeness"],
                         "NO_CRASH_INSTANCE_EVIDENCE")


class OffsetShaBindingTests(unittest.TestCase):
    """End-to-end requirement 9: offsets resolve ONLY against the local
    artifact byte-identical to the installed APK."""

    def _tombstone_with_apk_frame(self):
        return {"fatal_signal": "SIGABRT", "package_associated": True,
                "pid": 1, "fatal_lines": ["x"], "package_matched_lines": [],
                "backtrace_frames": [{
                    "pc": "%x" % TARGET_OFFSET, "library": "base.apk",
                    "library_path": "/data/app/~~x/com.x/base.apk",
                    "symbol": None}],
                "abort_message": None}

    def test_sha_mismatch_forces_unresolved(self):
        with tempfile.TemporaryDirectory() as td:
            apk = _craft_apk_with_offset(Path(td) / "a.apk")
            art = rh.build_crash_artifact(
                "com.x", "instrumented", [], self._tombstone_with_apk_frame(),
                artifact_apk=str(apk), artifact_sha256="f" * 64,
                identity={"apk_sha256": "a" * 64})
        res = art["apk_offset_resolution"]
        self.assertEqual(res["status"], "UNRESOLVED")
        self.assertIn("different artifacts", res["reason"])

    def test_sha_match_resolves(self):
        with tempfile.TemporaryDirectory() as td:
            apk = _craft_apk_with_offset(Path(td) / "a.apk")
            art = rh.build_crash_artifact(
                "com.x", "instrumented", [], self._tombstone_with_apk_frame(),
                artifact_apk=str(apk), artifact_sha256="f" * 64,
                identity={"apk_sha256": "f" * 64})
        res = art["apk_offset_resolution"]
        self.assertEqual(res["status"], "RESOLVED")
        self.assertEqual(res["entry"], PACKED_ENTRY)


class VerdictAggregationTests(unittest.TestCase):
    """End-to-end requirement 3+7: the verdict consumes the new
    comparison documents first and never recommends a destructive
    baseline."""

    def test_both_crash_verdict_fields(self):
        v = rh.runtime_verdict(
            None, {"startup": "CRASH", "crash_class": "NATIVE_CRASH"},
            working_control={"status": "CONTROL_CRASHED"},
            common_cause={"status": "COMMON_CAUSE_BOTH_CRASH"})
        self.assertEqual(v["ORIGINAL_RUNTIME"], "CRASH")
        self.assertEqual(v["REGRESSION_STATUS"], "NOT_ESTABLISHED")
        self.assertEqual(v["RUNTIME_STATUS"], "COMMON_CAUSE_BOTH_CRASH")
        self.assertEqual(v["CAMPAIGN_STATE"], "CAUSAL_CHAIN_INCOMPLETE")
        self.assertNotIn("REELSEC_ALLOW_TEST_DEVICE_UNINSTALL",
                         v["NEXT_ACTION"])
        self.assertNotIn("gated baseline", v["NEXT_ACTION"])
        self.assertIn("NOT_ESTABLISHED", v["NEXT_ACTION"])

    def test_crash_without_comparison_next_action_is_working_control(self):
        v = rh.runtime_verdict(
            None, {"startup": "CRASH", "crash_class": "NATIVE_CRASH"})
        self.assertNotIn("REELSEC_ALLOW_TEST_DEVICE_UNINSTALL",
                         v["NEXT_ACTION"])
        self.assertNotIn("gated baseline", v["NEXT_ACTION"])
        self.assertIn("working-control", v["NEXT_ACTION"])

    def test_control_healthy_instrumented_crash_is_suspected(self):
        v = rh.runtime_verdict(
            None, {"startup": "CRASH"},
            working_control={"status": "CONTROL_ASSESSED"},
            common_cause={"status": "CONTROL_HEALTHY_INSTRUMENTED_CRASH"})
        self.assertEqual(v["ORIGINAL_RUNTIME"], "PASS")
        self.assertEqual(v["REGRESSION_STATUS"], "SUSPECTED_NOT_PROVEN")
        self.assertIn("CANDIDATE", v["NEXT_ACTION"])

    def test_control_only_crash_not_instrumentation(self):
        v = rh.runtime_verdict(
            None, {"startup": "PASS"},
            working_control={"status": "CONTROL_CRASHED"},
            common_cause={"status": "CONTROL_ONLY_CRASH"})
        self.assertEqual(v["ORIGINAL_RUNTIME"], "CRASH")
        self.assertIn("not", v["NEXT_ACTION"].lower())


class ExitClassificationTests(unittest.TestCase):
    """End-to-end requirement 13: exit codes split infrastructure /
    scientific-incomplete / valid-completed-investigation."""

    def test_completed_is_zero(self):
        with tempfile.TemporaryDirectory() as td:
            code, cls = MODULE.classify_campaign_exit(td, "COMPLETED")
        self.assertEqual(code, 0)

    def test_no_device_is_infrastructure(self):
        with tempfile.TemporaryDirectory() as td:
            (Path(td) / "RUNTIME-PROBE.json").write_text(json.dumps(
                {"status": "NO_ONLINE_ANDROID_DEVICE"}))
            code, cls = MODULE.classify_campaign_exit(
                td, "COMPLETED_WITH_ISSUES")
        self.assertEqual(code, 2)
        self.assertIn("INFRASTRUCTURE", cls)

    def test_both_crash_with_comparison_is_valid_investigation(self):
        with tempfile.TemporaryDirectory() as td:
            (Path(td) / "RUNTIME-HEALTH.json").write_text(
                json.dumps({"startup": "CRASH"}))
            (Path(td) / "COMMON-CAUSE-COMPARISON.json").write_text(
                json.dumps({"status": "COMMON_CAUSE_BOTH_CRASH"}))
            (Path(td) / "EVIDENCE-REPORT.json").write_text("{}")
            code, cls = MODULE.classify_campaign_exit(
                td, "COMPLETED_WITH_ISSUES")
        self.assertEqual(code, 0)
        self.assertIn("VALID_INVESTIGATION", cls)

    def test_crash_without_comparison_is_scientific_incomplete(self):
        with tempfile.TemporaryDirectory() as td:
            (Path(td) / "RUNTIME-HEALTH.json").write_text(
                json.dumps({"startup": "CRASH"}))
            code, cls = MODULE.classify_campaign_exit(
                td, "COMPLETED_WITH_ISSUES")
        self.assertEqual(code, 3)
        self.assertIn("SCIENTIFIC_INCOMPLETE", cls)

    def test_healthy_with_evidence_is_valid(self):
        with tempfile.TemporaryDirectory() as td:
            (Path(td) / "RUNTIME-HEALTH.json").write_text(
                json.dumps({"startup": "PASS"}))
            (Path(td) / "EVIDENCE-REPORT.json").write_text("{}")
            code, cls = MODULE.classify_campaign_exit(
                td, "COMPLETED_WITH_ISSUES")
        self.assertEqual(code, 0)


# ---------------------------------------------------------------------------
# Timeline-truth mandate (campaign 2026-10-07T23-43-38 correction):
# crash-buffer tombstones from EARLIER sessions must never be attributed to
# the current session; CONTROL_NOT_INSTALLED never means "original never
# ran"; ORIGINAL_RUNTIME=CRASH requires crash evidence bound to the
# original's process after its launch.
# ---------------------------------------------------------------------------

STALE_TOMBSTONE_LOG = """10-07 21:31:14.550 30953 30953 F libc    : Fatal signal 6 (SIGABRT), code -1 (SI_QUEUE) in tid 30953 (.android.victor), pid 30953 (.android.victor)
10-07 21:31:14.700 30999 30999 F DEBUG   : pid: 30953, tid: 30953, name: .android.victor  >>> com.x <<<
10-07 21:31:14.702 30999 30999 F DEBUG   :       #00 pc 00000000000537d4  /apex/com.android.runtime/lib64/bionic/libc.so (abort+168)
"""


def _timeline_runner(exit_post="", ps_line=None, crash_pre="", crash_log="",
                     pre_crash_rc=0):
    """Fake device runner with faithful crash-buffer semantics: the FIRST
    logcat crash read is the pre-launch snapshot; the second read returns
    the buffer including anything appended during the session."""
    state = {"exit_calls": 0, "logcat_calls": 0}

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
            state["logcat_calls"] += 1
            if state["logcat_calls"] == 1:
                return pre_crash_rc, crash_pre
            return 0, crash_log
        return 1, ""
    return runner


def _assess_with(runner, package="com.x", label="original"):
    with mock.patch("time.sleep"):
        return rh.assess_startup(runner, "/adb", "s1", package, label=label,
                                 observe_s=1, interval=0)


def _legacy_stale_health(pid_observed=15683, tomb_pid=30953, alive=True):
    """Health document shaped exactly like the recorded (pre-fix) baseline
    round of campaign 2026-10-07T23-43-38."""
    return {
        "startup": "CRASH",
        "process_observed": True,
        "process_alive_at_exit": alive,
        "pids": [pid_observed],
        "crash_class": "NATIVE_CRASH",
        "classification": {
            "crash_class": "NATIVE_CRASH",
            "evidence_source": "adb:logcat -b crash (tombstone echo)",
            "exit_reason_code": None, "pid": tomb_pid},
        "evidence": {
            "exit_info_new_entries": [],
            "tombstone": {"pid": tomb_pid, "fatal_signal": "SIGABRT",
                          "package_associated": True}},
    }


class SessionBoundCrashAttributionTests(unittest.TestCase):
    """The 23-43-38 misattribution: a stale crash-buffer tombstone (pid
    30953, hours old) classified a HEALTHY original session (pid 15683
    alive at window exit, zero new exit-info) as CRASH."""

    def test_stale_tombstone_never_crashes_a_healthy_session(self):
        h = _assess_with(_timeline_runner(
            ps_line="u0_a113 15683 500 1 1 0 0 S com.x",
            crash_pre=STALE_TOMBSTONE_LOG, crash_log=STALE_TOMBSTONE_LOG))
        self.assertEqual(h["startup"], "PASS")
        self.assertEqual(h["crash_class"], rh.HEALTHY)
        self.assertTrue(h["runtime_probe_allowed"])
        self.assertIsNone(h["crash_artifact"])
        self.assertFalse(h["crash_session_binding"]["bound"])
        self.assertEqual(h["crash_session_binding"]["method"], "BUFFER_DIFF")
        # the stale evidence is PRESERVED (never deleted), just excluded
        self.assertEqual(h["evidence"]["tombstone"]["pid"], 30953)
        self.assertIn("stale", h["crash_session_binding"]["reason"])

    def test_new_tombstone_after_launch_is_session_bound_crash(self):
        h = _assess_with(_timeline_runner(
            crash_pre="", crash_log=SIGABRT_BASE_APK_LOG.replace(
                "com.newleaf.app.android.victor", "com.x")))
        self.assertEqual(h["startup"], "CRASH")
        self.assertEqual(h["crash_class"], rh.NATIVE_CRASH)
        self.assertIsNotNone(h["crash_artifact"])
        self.assertTrue(h["crash_session_binding"]["bound"])
        self.assertEqual(h["crash_session_binding"]["method"], "BUFFER_DIFF")

    def test_pid_match_binds_when_pre_snapshot_unavailable(self):
        h = _assess_with(_timeline_runner(
            ps_line="u0_a113 14210 500 1 1 0 0 S com.x",
            crash_log=SIGABRT_BASE_APK_LOG.replace(
                "com.newleaf.app.android.victor", "com.x"),
            pre_crash_rc=1))
        self.assertEqual(h["startup"], "CRASH")
        self.assertEqual(h["crash_session_binding"]["method"], "PID_MATCH")

    def test_pid_mismatch_with_alive_process_excluded_when_pre_unavailable(
            self):
        h = _assess_with(_timeline_runner(
            ps_line="u0_a113 999 500 1 1 0 0 S com.x",
            crash_log=SIGABRT_BASE_APK_LOG.replace(
                "com.newleaf.app.android.victor", "com.x"),
            pre_crash_rc=1))
        self.assertEqual(h["startup"], "PASS")
        self.assertFalse(h["crash_session_binding"]["bound"])
        self.assertEqual(h["evidence"]["tombstone"]["pid"], 14210)


class StartupAuditTests(unittest.TestCase):
    """Post-hoc audit of RECORDED documents: corrects stale-tombstone
    fabrications for the verdict layer without rewriting evidence."""

    def test_audit_overrides_stale_recorded_crash(self):
        a = rh.audit_startup_classification(_legacy_stale_health())
        self.assertEqual(a["recorded_startup"], "CRASH")
        self.assertEqual(a["audited_startup"], "PASS")
        self.assertIn("STALE_TOMBSTONE_ATTRIBUTION", a["contradictions"])

    def test_audit_never_overrides_exitinfo_crash(self):
        h = _legacy_stale_health(tomb_pid=15683)
        h["classification"]["exit_reason_code"] = 5
        h["evidence"]["exit_info_new_entries"] = [
            {"pid": 15683, "reason_code": 5}]
        a = rh.audit_startup_classification(h)
        self.assertEqual(a["audited_startup"], "CRASH")
        self.assertEqual(a["contradictions"], [])

    def test_audit_never_overrides_session_bound_crash(self):
        h = _legacy_stale_health(tomb_pid=15683)
        h["crash_session_binding"] = {"bound": True, "method": "BUFFER_DIFF"}
        a = rh.audit_startup_classification(h)
        self.assertEqual(a["audited_startup"], "CRASH")
        self.assertEqual(a["contradictions"], [])

    def test_audit_keeps_crash_when_process_died_in_window(self):
        a = rh.audit_startup_classification(_legacy_stale_health(alive=False))
        self.assertEqual(a["audited_startup"], "CRASH")
        self.assertEqual(a["contradictions"], [])

    def test_control_not_installed_never_means_never_ran(self):
        side, _ = rh.audited_original_side(
            {"status": rh.CONTROL_NOT_INSTALLED},
            baseline_health={"startup": "PASS"})
        self.assertEqual(side, "PASS")
        side, note = rh.audited_original_side(
            {"status": rh.CONTROL_NOT_INSTALLED})
        self.assertIsNone(side)
        self.assertIn("never run in this campaign", note)

    def test_control_crashed_record_is_audited(self):
        side, note = rh.audited_original_side(
            {"status": rh.CONTROL_CRASHED,
             "health": _legacy_stale_health(pid_observed=10332)})
        self.assertEqual(side, "PASS")
        self.assertIn("session-bound audit", note)


class TimelineStateMachineTests(unittest.TestCase):
    """The state machine must express the REAL device timeline:
    ORIGINAL_HEALTHY -> INSTRUMENTED_INSTALLED -> INSTRUMENTED_CRASH."""

    def test_original_healthy_instrumented_installed_instrumented_crash(self):
        res = rh.campaign_state_machine(
            working_control={"status": rh.CONTROL_NOT_INSTALLED},
            baseline_health={"startup": "PASS"},
            deploy_status="INSTALLED",
            instrumented_health={"startup": "CRASH",
                                 "crash_class": rh.NATIVE_CRASH},
            common_cause={"status": "COMMON_CAUSE_INCOMPLETE"})
        states = [t["to"] for t in res["transitions"]]
        self.assertEqual(
            states,
            ["CONTROL_NOT_INSTALLED", "ORIGINAL_HEALTHY",
             "INSTRUMENTED_INSTALLED", "INSTRUMENTED_CRASHED",
             "INSTRUMENTATION_ONLY_CRASH", "CAUSAL_CHAIN_INCOMPLETE"])
        for s in states:
            self.assertIn(s, rh.CAMPAIGN_STATES)

    def test_legacy_stale_documents_are_audited_not_trusted(self):
        res = rh.campaign_state_machine(
            working_control={"status": rh.CONTROL_NOT_INSTALLED},
            baseline_health=_legacy_stale_health(),
            deploy_status="INSTALLED",
            instrumented_health={"startup": "CRASH",
                                 "crash_class": rh.NATIVE_CRASH},
            crash_comparison={"status": "BOTH_CRASH"})
        states = [t["to"] for t in res["transitions"]]
        self.assertIn("ORIGINAL_HEALTHY", states)
        self.assertIn("INSTRUMENTED_INSTALLED", states)
        self.assertIn("INSTRUMENTATION_ONLY_CRASH", states)
        self.assertNotIn("COMMON_CAUSE_BOTH_CRASH", states)
        reason = next(t["reason"] for t in res["transitions"]
                      if t["to"] == "ORIGINAL_HEALTHY")
        self.assertIn("audit", reason)

    def test_genuine_original_crash_still_reaches_common_cause(self):
        genuine = {"startup": "CRASH", "crash_class": rh.NATIVE_CRASH,
                   "crash_session_binding": {"bound": True,
                                             "method": "BUFFER_DIFF"}}
        res = rh.campaign_state_machine(
            working_control={"status": rh.CONTROL_NOT_INSTALLED},
            baseline_health=genuine,
            deploy_status="INSTALLED",
            instrumented_health={"startup": "CRASH",
                                 "crash_class": rh.NATIVE_CRASH},
            crash_comparison={"status": "BOTH_CRASH"})
        states = [t["to"] for t in res["transitions"]]
        self.assertIn("ORIGINAL_CRASHED", states)
        self.assertIn("COMMON_CAUSE_BOTH_CRASH", states)


class TimelineVerdictTests(unittest.TestCase):
    """Runtime verdict must reflect the real timeline, with annotations."""

    def test_audited_baseline_flips_false_both_crash_to_regression(self):
        ins = {"startup": "CRASH", "crash_class": rh.NATIVE_CRASH,
               "crash_cause": "NATIVE_LIBRARY:libc.so",
               "runtime_probe_allowed": False}
        v = rh.runtime_verdict(
            _legacy_stale_health(), ins,
            working_control={"status": rh.CONTROL_NOT_INSTALLED},
            common_cause={"status": "COMMON_CAUSE_INCOMPLETE"},
            crash_comparison={"status": "BOTH_CRASH"},
            deploy_status="INSTALLED")
        self.assertEqual(v["ORIGINAL_RUNTIME"], "PASS")
        self.assertEqual(v["ORIGINAL_RUNTIME_SOURCE"], "BASELINE_ROUND")
        self.assertEqual(v["REGRESSION_STATUS"], rh.REGRESSION_CONFIRMED)
        self.assertEqual(v["RUNTIME_STATUS"], "BLOCKED_BY_ARTIFACT_CRASH")
        self.assertIn("regression confirmed", v["NEXT_ACTION"].lower())
        self.assertIsNotNone(v["STARTUP_AUDIT"])
        self.assertTrue(v["INSTRUMENTED_INSTALLED"])

    def test_both_crash_common_cause_downgraded_when_control_crash_stale(
            self):
        wc = {"status": rh.CONTROL_CRASHED,
              "health": _legacy_stale_health(pid_observed=10332)}
        ins = {"startup": "CRASH", "crash_class": rh.NATIVE_CRASH,
               "runtime_probe_allowed": False}
        v = rh.runtime_verdict(
            None, ins, working_control=wc,
            common_cause={"status": "COMMON_CAUSE_BOTH_CRASH"},
            crash_comparison={"status": "BOTH_CRASH"})
        self.assertEqual(v["ORIGINAL_RUNTIME"], "PASS")
        self.assertEqual(v["COMMON_CAUSE_COMPARISON"],
                         "CONTROL_HEALTHY_INSTRUMENTED_CRASH")
        self.assertEqual(v["COMMON_CAUSE_COMPARISON_RECORDED"],
                         "COMMON_CAUSE_BOTH_CRASH")
        self.assertEqual(v["REGRESSION_STATUS"], "SUSPECTED_NOT_PROVEN")
        self.assertIn("CANDIDATE", v["NEXT_ACTION"])

    def test_genuine_both_crash_still_not_established(self):
        genuine = {"startup": "CRASH",
                   "crash_session_binding": {"bound": True}}
        wc = {"status": rh.CONTROL_CRASHED, "health": genuine}
        ins = {"startup": "CRASH", "runtime_probe_allowed": False}
        v = rh.runtime_verdict(
            None, ins, working_control=wc,
            common_cause={"status": "COMMON_CAUSE_BOTH_CRASH"})
        self.assertEqual(v["ORIGINAL_RUNTIME"], "CRASH")
        self.assertEqual(v["COMMON_CAUSE_COMPARISON"],
                         "COMMON_CAUSE_BOTH_CRASH")
        self.assertEqual(v["REGRESSION_STATUS"], "NOT_ESTABLISHED")

    def test_baseline_pass_instrumented_crash_is_regression_without_audit(
            self):
        v = rh.runtime_verdict(
            {"startup": "PASS"}, {"startup": "CRASH",
                                 "runtime_probe_allowed": False},
            working_control={"status": rh.CONTROL_NOT_INSTALLED},
            deploy_status="INSTALLED")
        self.assertEqual(v["ORIGINAL_RUNTIME"], "PASS")
        self.assertEqual(v["REGRESSION_STATUS"], rh.REGRESSION_CONFIRMED)
        self.assertIsNone(v["STARTUP_AUDIT"])


class BlockedByTests(unittest.TestCase):
    def test_sign_block_names_sign_not_package(self):
        v = rh.runtime_verdict(
            None, None,
            runtime_probe={"status": "PACKAGE_NOT_INSTALLED"},
            deploy={"status": "NOT_DEPLOYED",
                    "reason": "sign stage did not verify an artifact"},
            sign={"status": "BLOCKED_OR_FAILED",
                  "error": "apksigner or REELSEC_TEST_KEYSTORE unavailable"})
        self.assertEqual(v["RUNTIME_PROOF_STATUS"], "PACKAGE_NOT_INSTALLED")
        self.assertEqual(v["BLOCKED_BY"]["stage"], "SIGN")
        self.assertIn("REELSEC_TEST_KEYSTORE", v["BLOCKED_BY"]["reason"])
        self.assertIn("SIGN", v["NEXT_ACTION"])
        self.assertIn("no device-side debugging", v["NEXT_ACTION"].lower())

    def test_deploy_block_names_deploy(self):
        v = rh.runtime_verdict(
            None, None,
            runtime_probe={"status": "PACKAGE_NOT_INSTALLED"},
            deploy={"status": "BLOCKED_OR_FAILED",
                    "error": "install compatibility gate (SIGNATURE_MISMATCH)"},
            sign={"status": "SIGNED_VERIFIED"})
        self.assertEqual(v["BLOCKED_BY"]["stage"], "DEPLOY")
        self.assertIn("SIGNATURE_MISMATCH", v["BLOCKED_BY"]["reason"])
        self.assertIn("DEPLOY", v["NEXT_ACTION"])

    def test_genuine_package_absence_has_no_blocked_by(self):
        v = rh.runtime_verdict(
            None, None,
            runtime_probe={"status": "PACKAGE_NOT_INSTALLED"},
            deploy={"status": "INSTALLED"},
            sign={"status": "SIGNED_VERIFIED"})
        self.assertEqual(v["RUNTIME_PROOF_STATUS"], "PACKAGE_NOT_INSTALLED")
        self.assertIsNone(v["BLOCKED_BY"])

    def test_missing_documents_keep_legacy_behavior(self):
        v = rh.runtime_verdict(None, None,
                               runtime_probe={"status": "NOT_RUN"})
        self.assertEqual(v["RUNTIME_PROOF_STATUS"], "NOT_RUN")
        self.assertIsNone(v["BLOCKED_BY"])
        self.assertIn("probe is permitted", v["NEXT_ACTION"])


class InstrumentedRuntimeGateTests(unittest.TestCase):
    def _docs(self, sign_status="SIGNED_VERIFIED",
              deploy_status="INSTALLED", identity="MATCH",
              sha="aa" * 32, cert="bb" * 32, package="com.x",
              deploy_package="com.x", deploy_sha=None, deploy_cert=None):
        sign = {"status": sign_status, "signed_sha256": sha,
                "certificate_sha256": cert}
        deploy = {"status": deploy_status, "package": deploy_package,
                  "artifact_sha256": deploy_sha or sha,
                  "certificate_sha256": deploy_cert or cert}
        if identity is not None:
            deploy["post_install_identity"] = {"identity": identity}
        return sign, deploy

    def test_full_chain_allowed(self):
        sign, deploy = self._docs()
        gate = rh.instrumented_runtime_gate(
            package="com.x", deploy=deploy, sign=sign)
        self.assertTrue(gate["allowed"])
        self.assertEqual(gate["code"], "ALLOWED")

    def test_sign_failure_blocks(self):
        sign, deploy = self._docs(sign_status="BLOCKED_OR_FAILED")
        gate = rh.instrumented_runtime_gate(
            package="com.x", deploy=deploy, sign=sign)
        self.assertFalse(gate["allowed"])
        self.assertEqual(gate["code"], "SIGN_BLOCKED")

    def test_missing_sign_blocks(self):
        _sign, deploy = self._docs()
        gate = rh.instrumented_runtime_gate(
            package="com.x", deploy=deploy, sign=None)
        self.assertFalse(gate["allowed"])
        self.assertEqual(gate["code"], "SIGN_BLOCKED")

    def test_deploy_not_installed_blocks(self):
        sign, deploy = self._docs(deploy_status="NOT_DEPLOYED")
        deploy["reason"] = "sign stage did not verify an artifact"
        gate = rh.instrumented_runtime_gate(
            package="com.x", deploy=deploy, sign=sign)
        self.assertFalse(gate["allowed"])
        self.assertEqual(gate["code"], "DEPLOY_BLOCKED")
        self.assertIn("did not verify", gate["reason"])

    def test_identity_mismatch_blocks(self):
        sign, deploy = self._docs(identity="MISMATCH")
        gate = rh.instrumented_runtime_gate(
            package="com.x", deploy=deploy, sign=sign)
        self.assertFalse(gate["allowed"])
        self.assertEqual(gate["code"], "DEPLOY_BLOCKED")

    def test_legacy_deploy_without_identity_record_allowed(self):
        sign, deploy = self._docs(identity=None)
        gate = rh.instrumented_runtime_gate(
            package="com.x", deploy=deploy, sign=sign)
        self.assertTrue(gate["allowed"])

    def test_sha_inconsistency_blocks(self):
        sign, deploy = self._docs(deploy_sha="cc" * 32)
        gate = rh.instrumented_runtime_gate(
            package="com.x", deploy=deploy, sign=sign)
        self.assertFalse(gate["allowed"])
        self.assertIn("SHA-256", gate["reason"])

    def test_certificate_inconsistency_blocks(self):
        sign, deploy = self._docs(deploy_cert="cc" * 32)
        gate = rh.instrumented_runtime_gate(
            package="com.x", deploy=deploy, sign=sign)
        self.assertFalse(gate["allowed"])
        self.assertIn("certificate", gate["reason"])

    def test_package_mismatch_blocks(self):
        sign, deploy = self._docs(deploy_package="com.other")
        gate = rh.instrumented_runtime_gate(
            package="com.x", deploy=deploy, sign=sign)
        self.assertFalse(gate["allowed"])
        self.assertIn("com.other", gate["reason"])


class DeployBindingVerdictTests(unittest.TestCase):
    def test_sign_blocked_proof_names_sign_and_denies_install(self):
        v = rh.runtime_verdict(
            {"startup": "PASS"}, None,
            runtime_probe={"status": "SIGN_BLOCKED"},
            deploy={"status": "NOT_DEPLOYED",
                    "reason": "sign stage did not verify an artifact"},
            sign={"status": "BLOCKED_OR_FAILED",
                  "error": "signing preflight not ready "
                           "(pkcs12_password_valid)"})
        self.assertEqual(v["RUNTIME_STATUS"], "SIGN_BLOCKED")
        self.assertEqual(v["RUNTIME_PROOF_STATUS"], "SIGN_BLOCKED")
        self.assertEqual(v["BLOCKED_BY"]["stage"], "SIGN")
        self.assertFalse(v["INSTRUMENTED_INSTALLED"])
        self.assertEqual(v["INSTRUMENTED_RUNTIME"], "NOT_RUN")

    def test_deploy_blocked_proof_names_deploy(self):
        v = rh.runtime_verdict(
            {"startup": "PASS"}, None,
            runtime_probe={"status": "DEPLOY_BLOCKED"},
            deploy={"status": "BLOCKED_OR_FAILED",
                    "error": "install compatibility gate "
                             "(SIGNATURE_MISMATCH)"},
            sign={"status": "SIGNED_VERIFIED"})
        self.assertEqual(v["RUNTIME_STATUS"], "DEPLOY_BLOCKED")
        self.assertEqual(v["BLOCKED_BY"]["stage"], "DEPLOY")
        self.assertIn("SIGNATURE_MISMATCH", v["BLOCKED_BY"]["reason"])
        self.assertFalse(v["INSTRUMENTED_INSTALLED"])

    def test_full_chain_marks_installed(self):
        v = rh.runtime_verdict(
            {"startup": "PASS"},
            {"startup": "PASS", "runtime_probe_allowed": True},
            runtime_probe={"status": "RUNTIME_TARGET_NOT_OBSERVED"},
            deploy={"status": "INSTALLED",
                    "post_install_identity": {"identity": "MATCH"}},
            sign={"status": "SIGNED_VERIFIED"})
        self.assertTrue(v["INSTRUMENTED_INSTALLED"])

    def test_mismatch_identity_denies_install(self):
        v = rh.runtime_verdict(
            {"startup": "PASS"},
            {"startup": "PASS", "runtime_probe_allowed": True},
            runtime_probe={"status": "RUNTIME_TARGET_NOT_OBSERVED"},
            deploy={"status": "INSTALLED",
                    "post_install_identity": {"identity": "MISMATCH"}},
            sign={"status": "SIGNED_VERIFIED"})
        self.assertFalse(v["INSTRUMENTED_INSTALLED"])

    def test_unverified_sign_denies_install_despite_match(self):
        v = rh.runtime_verdict(
            {"startup": "PASS"},
            {"startup": "PASS", "runtime_probe_allowed": True},
            runtime_probe={"status": "RUNTIME_TARGET_NOT_OBSERVED"},
            deploy={"status": "INSTALLED",
                    "post_install_identity": {"identity": "MATCH"}},
            sign={"status": "BLOCKED_OR_FAILED"})
        self.assertFalse(v["INSTRUMENTED_INSTALLED"])

    def test_legacy_status_only_install_keeps_meaning(self):
        v = rh.runtime_verdict(None, None,
                               runtime_probe={"status": "NOT_RUN"},
                               deploy_status="INSTALLED")
        self.assertTrue(v["INSTRUMENTED_INSTALLED"])


class ControlIdentityTests(unittest.TestCase):
    """An observed-but-unverified control is never a valid baseline."""

    def _control(self, status, verified=None):
        doc = {
            "schema_version": "working-control-1",
            "status": status,
            "package": "com.x",
            "installed_path": "/data/app/~~x/com.x/base.apk",
            "identity": {"apk_sha256": "e" * 64},
            "process": {"pids": [14210], "observed": True,
                        "alive_ms": 900},
            "health": {"startup":
                       "CRASH" if status == "CONTROL_CRASHED" else "PASS"},
            "crash_artifact": (
                _simulated_crash_artifact("working_control", "e" * 64)
                if status == "CONTROL_CRASHED" else None),
        }
        if verified is not None:
            doc["identity"]["original_verification"] = {
                "verified": verified,
                "installed_sha256": "e" * 64,
                "reference_sha256": ("e" if verified else "f") * 64}
        return doc

    def test_verified_helper_tristate(self):
        self.assertTrue(rh.control_identity_verified(
            self._control("CONTROL_ASSESSED", True)))
        self.assertFalse(rh.control_identity_verified(
            self._control("CONTROL_ASSESSED", False)))
        self.assertIsNone(rh.control_identity_verified(
            self._control("CONTROL_ASSESSED")))
        self.assertIsNone(rh.control_identity_verified(None))

    def test_unverified_control_crash_never_control_healthy(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_ASSESSED", False), ins)
        self.assertEqual(
            cmp["status"], "CONTROL_UNVERIFIED_INSTRUMENTED_CRASH")
        self.assertNotIn("CONTROL_HEALTHY", cmp["status"])
        self.assertEqual(cmp["attribution"]["instrumentation_regression"],
                         "NOT_ESTABLISHED")
        self.assertIn("no valid", cmp["attribution"]["guard"].lower())
        self.assertIn("baseline", cmp["attribution"]["guard"].lower())

    def test_unverified_both_crash_makes_no_common_claim(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_CRASHED", False), ins)
        self.assertEqual(cmp["status"], "CONTROL_UNVERIFIED_BOTH_CRASH")
        self.assertEqual(cmp["attribution"]["instrumentation_regression"],
                         "NOT_ESTABLISHED")

    def test_unverified_only_crashes(self):
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_CRASHED", False), None)
        self.assertEqual(cmp["status"], "CONTROL_UNVERIFIED_ONLY_CRASH")
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_ASSESSED", False), None)
        self.assertEqual(
            cmp["status"],
            "CONTROL_UNVERIFIED_NO_INSTRUMENTED_EVIDENCE")

    def test_verified_control_keeps_healthy_with_matrix_pointer(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_ASSESSED", True), ins)
        self.assertEqual(cmp["status"],
                         "CONTROL_HEALTHY_INSTRUMENTED_CRASH")
        self.assertEqual(cmp["attribution"]["instrumentation_regression"],
                         "SUSPECTED_NOT_PROVEN")
        self.assertIn("undifferentiated", cmp["attribution"]["guard"])
        self.assertIn("isolate", cmp["attribution"]["guard"])

    def test_legacy_unrecorded_identity_keeps_behavior(self):
        ins = _simulated_crash_artifact("instrumented", "f" * 64)
        cmp = rh.build_common_cause_comparison(
            self._control("CONTROL_ASSESSED"), ins)
        self.assertEqual(cmp["status"],
                         "CONTROL_HEALTHY_INSTRUMENTED_CRASH")


class UnverifiedVerdictTests(unittest.TestCase):
    """Verdict surfaces the unverified state; nothing is attributed."""

    def _docs(self):
        control = {
            "status": "CONTROL_ASSESSED", "package": "com.x",
            "identity": {"apk_sha256": "f" * 64, "original_verification": {
                "verified": False, "installed_sha256": "f" * 64,
                "reference_sha256": "e" * 64}},
            "health": {"startup": "PASS"},
            "process": {"pids": [1], "observed": True, "alive_ms": 5}}
        crashed = {"startup": "CRASH", "crash_class": rh.NATIVE_CRASH,
                   "crash_cause": "NATIVE_LIBRARY:libc.so",
                   "crash_session_binding": {"bound": True,
                                             "method": "BUFFER_DIFF"}}
        return control, crashed

    def test_unverified_status_flows_to_runtime_status(self):
        control, crashed = self._docs()
        v = rh.runtime_verdict(
            None, crashed,
            runtime_probe={"status": "RUNTIME_ARTIFACT_CRASH"},
            working_control=control,
            common_cause={
                "status": "CONTROL_UNVERIFIED_INSTRUMENTED_CRASH"},
            deploy_status="INSTALLED")
        self.assertEqual(v["RUNTIME_STATUS"],
                         "CONTROL_UNVERIFIED_INSTRUMENTED_CRASH")
        self.assertEqual(v["REGRESSION_STATUS"], "NOT_ESTABLISHED")
        self.assertEqual(v["ORIGINAL_RUNTIME"], "IDENTITY_UNVERIFIED")
        self.assertIn("NOT established", v["NEXT_ACTION"])
        self.assertIn("isolate", v["NEXT_ACTION"])
        self.assertNotIn("CANDIDATE cause", v["NEXT_ACTION"])

    def test_verified_healthy_names_no_generic_instrumentation(self):
        control, crashed = self._docs()
        control["identity"]["original_verification"]["verified"] = True
        control["identity"]["original_verification"][
            "reference_sha256"] = "f" * 64
        v = rh.runtime_verdict(
            None, crashed,
            runtime_probe={"status": "RUNTIME_ARTIFACT_CRASH"},
            working_control=control,
            common_cause={"status":
                          "CONTROL_HEALTHY_INSTRUMENTED_CRASH"},
            deploy_status="INSTALLED")
        self.assertEqual(v["RUNTIME_STATUS"],
                         "CONTROL_HEALTHY_INSTRUMENTED_CRASH")
        self.assertEqual(v["REGRESSION_STATUS"], "SUSPECTED_NOT_PROVEN")
        self.assertIn("undifferentiated", v["NEXT_ACTION"])
        self.assertIn("isolate", v["NEXT_ACTION"])
        self.assertNotIn("instrumentation is a CANDIDATE",
                         v["NEXT_ACTION"])

    def test_state_machine_marks_unverified_incomplete(self):
        _control, crashed = self._docs()
        state = rh.campaign_state_machine(
            working_control=_control,
            instrumented_health=crashed,
            common_cause={"status":
                          "CONTROL_UNVERIFIED_INSTRUMENTED_CRASH"})
        moves = [t for t in state["transitions"]
                 if t["to"] == "COMPARISON_INCOMPLETE"]
        self.assertTrue(moves)
        self.assertIn("unverified", moves[0]["reason"])


if __name__ == "__main__":
    unittest.main()
