#!/usr/bin/env python3
"""End-to-end isolation matrix against a faked device.

Runs run_isolation_matrix with scripted per-arm health (A healthy,
B healthy, C SIGABRT crash) and proves the wiring: per-arm documents
with the required fields, the TELEMETRY_PROBE_CANDIDATE decision,
install -r only, and zero destructive commands. The narrowing suites
rerun the same harness over A/B1/B2 with valid-ZIP artifacts and a
fake zipalign to prove alignment separation and byte-level anatomy.
"""
import importlib.util
import io
import json
import os
import struct
import tempfile
import unittest
import zipfile
from pathlib import Path
from unittest import mock
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

import orchestrator as orch
from isolation import IsolationError
from test_runtime_health import EXIT_INFO_NATIVE, TOMBSTONE_LOG

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("reelsec", HERE / "reelsec.py")
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)

AW_SMALI = (
    ".class public Lcom/SecShell/SecShell/AW;\n"
    ".method protected attachBaseContext(Landroid/content/Context;)V\n"
    "    .locals 6\n"
    "    const-string v0, \"SecShell\"\n"
    "    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n"
    "    return-void\n"
    ".end method\n"
)

EXIT_INFO = EXIT_INFO_NATIVE.replace(
    "com.newleaf.app.android.victor", "com.x")
CRASH_LOG = TOMBSTONE_LOG.replace(
    "com.newleaf.app.android.victor", "com.x")
CERT = "AA:BB:CC:DD"


class MatrixHarness(unittest.TestCase):
    """Fake-device matrix runner with scripted arm health."""

    def setUp(self):
        self.td = tempfile.TemporaryDirectory()
        self.out = Path(self.td.name)
        self.cmd_log = []
        self.state = {"installed": False, "installed_bytes": b"",
                      "installs": 0, "exit_calls": 0}
        # decoded fixture: manifest + SecShell anchor
        decoded = self.out / "decoded"
        smali = (decoded / "smali" / "com" / "SecShell" / "SecShell"
                 / "AW.smali")
        smali.parent.mkdir(parents=True)
        smali.write_text(AW_SMALI, encoding="utf-8")
        (decoded / "AndroidManifest.xml").write_text(
            '<manifest versionCode="4200" package="com.x"/>\n',
            encoding="utf-8")
        self.decoded = decoded
        self.smali = smali
        self.original = self.out / "original.apk"
        self.original.write_bytes(b"fake-original-apk")
        (self.out / "test.p12").write_bytes(b"fake-keystore")

    def tearDown(self):
        self.td.cleanup()

    # -- fakes ------------------------------------------------------
    def _fake_run(self, cmd, cwd=None, timeout=60):
        words = [str(c) for c in cmd]
        joined = " ".join(words)
        self.cmd_log.append(joined)
        if words[0] == "/apktool":
            out = Path(words[words.index("-o") + 1])
            out.write_bytes(self._apktool_output_bytes(out))
            return 0, "built"
        if words[0] == "/zipalign":
            return self._fake_zipalign(words)
        if words[0] == "/apksigner":
            if "--print-certs" in words:
                return 0, ("Signer #1 certificate SHA-256 digest: %s\n"
                           % CERT)
            return 0, "fake-apksigner 0.9\n"
        if len(words) > 1 and words[1] == "pkcs12":
            if "-nodes" in words:
                return 0, ("Bag Attributes\n"
                           "    friendlyName: reelsec-test\n"
                           "-----BEGIN CERTIFICATE-----\nMIIB\n"
                           "-----END CERTIFICATE-----\n")
            return 0, ""
        if len(words) > 1 and words[1] == "x509":
            return 0, "sha256 Fingerprint=AA:BB:CC:DD\n"
        if words[:2] == ["/adb", "-s"] and words[3] == "get-state":
            return 0, "device"
        if "install" in words:
            apk = Path(words[-1])
            self.state["installed"] = True
            self.state["installed_bytes"] = apk.read_bytes()
            self.state["installs"] += 1
            return 0, "Success"
        if "pull" in words:
            Path(words[-1]).write_bytes(self.state["installed_bytes"])
            return 0, "pulled"
        if words[4:6] == ["pm", "path"]:
            if self.state["installed"]:
                return 0, "package:/data/app/~~x/com.x/base.apk\n"
            return 0, ""
        if words[4:6] == ["dumpsys", "package"]:
            return 0, "versionCode=4200 versionName=1\n"
        if "exit-info" in joined:
            self.state["exit_calls"] += 1
            if self._should_report_crash():
                return 0, EXIT_INFO
            return 0, ""
        if "monkey" in joined:
            return 0, "Events injected: 1"
        if joined.endswith("ps -A"):
            pid = 1000 + self.state["installs"]
            return 0, ("USER PID PPID VSZ RSS WCHAN ADDR S NAME\n"
                       "u0_a1 %d 500 1 1 0 0 S com.x\n" % pid)
        if "logcat" in joined:
            if self._should_log_crash():
                return 0, CRASH_LOG
            return 0, ""
        return 1, "unexpected: %s" % joined

    def _crash_arm(self):
        return None

    def _should_report_crash(self):
        # Baseline-first semantics: the first exit-info query of an
        # assessment snapshots pre-launch state (empty); only later
        # queries may report the crash.
        crash_arm = self._crash_arm()
        return bool(crash_arm
                    and self.state["installs"] == crash_arm
                    and self.state["exit_calls"] % 2 == 0)

    def _should_log_crash(self):
        crash_arm = self._crash_arm()
        return bool(crash_arm
                    and self.state["installs"] == crash_arm)

    def _apktool_output_bytes(self, out):
        return b"built:" + out.name.encode()

    def _fake_zipalign(self, words):
        return 1, "unexpected: %s" % " ".join(words)

    def _zipalign_path(self):
        return None

    def _fake_checked(self, cmd, timeout=300):
        words = [str(c) for c in cmd]
        self.cmd_log.append(" ".join(words))
        if "sign" in words:
            unsigned = Path(words[-1])
            signed = Path(words[words.index("--out") + 1])
            signed.write_bytes(unsigned.read_bytes() + b"-signed")
            return ""
        if "--print-certs" in words:
            return ("Signer #1 certificate SHA-256 digest: %s\n" % CERT)
        if "verify" in words:
            return ""
        raise AssertionError("unexpected checked: %s" % (words,))

    def _patches(self, env_extra=None):
        env = {"REELSEC_TEST_PACKAGE": "com.x",
               "REELSEC_TEST_KEYSTORE_PASSWORD": "pw",
               "REELSEC_TEST_KEY_PASSWORD": "pw",
               "REELSEC_ISOLATION_MATRIX": "ABC",
               "REELSEC_HEALTH_WINDOW_MS": "2000"}
        env.update(env_extra or {})
        return [
            mock.patch.dict(os.environ, env, clear=False),
            mock.patch.object(MODULE, "run", self._fake_run),
            mock.patch.object(MODULE, "_default_runner", self._fake_run),
            mock.patch.object(MODULE, "run_checked", self._fake_checked),
            mock.patch.object(
                MODULE, "resolve_test_device",
                lambda adb, serial=None: {"serial": "s1",
                                          "resolution": "explicit",
                                          "online_devices": ["s1"]}),
            mock.patch.object(
                MODULE, "plan_test_keystore",
                lambda env, repo_root=None: {
                    "action": "BOOTSTRAP",
                    "keystore": str(self.out / "test.p12"),
                    "alias": "reelsec-test"}),
            mock.patch.object(
                MODULE, "bootstrap_test_keystore",
                lambda *a, **k: {"keystore": str(self.out / "test.p12"),
                                 "alias": "reelsec-test",
                                 "bootstrapped": True, "reused": False,
                                 "backend": "openssl-pkcs12"}),
            mock.patch("time.sleep"),
        ]

    def _run_matrix(self, env_extra=None):
        patches = self._patches(env_extra)
        for patch in patches:
            patch.start()
        try:
            capabilities = {"tools": {
                "adb": {"path": "/adb"},
                "apksigner": {"path": "/apksigner"},
                "openssl": {"path": "/openssl"},
                "zipalign": {"path": self._zipalign_path()}}}
            return MODULE.run_isolation_matrix(
                self.out, self.original, capabilities,
                {"status": "READY", "root": str(self.decoded)},
                {"status": "READY", "target": str(self.smali)},
                {"backend": "cli", "path": "/apktool",
                 "status": "SELECTED"})
        finally:
            for patch in patches:
                patch.stop()

    def _arm_doc(self, letter):
        return json.loads(
            (self.out / ("ISOLATION-ARM-%s.json" % letter)).read_text(
                encoding="utf-8"))


class IsolationMatrixTests(MatrixHarness):
    def _crash_arm(self):
        return 3

    def test_full_matrix_isolates_probe(self):
        result = self._run_matrix()
        decision = result["decision"]
        self.assertEqual(decision["status"],
                         "TELEMETRY_PROBE_CANDIDATE")
        self.assertEqual(decision["arm_states"],
                         {"A": "HEALTHY", "B": "HEALTHY",
                          "B1": "NOT_RUN", "B2": "NOT_RUN",
                          "C": "CRASHED"})
        self.assertEqual(decision["planned_arms"], ["A", "B", "C"])
        self.assertEqual(
            json.loads((self.out / "ISOLATION-DECISION.json").read_text(
                encoding="utf-8"))["status"],
            "TELEMETRY_PROBE_CANDIDATE")

    def test_arm_records_carry_required_fields(self):
        self._run_matrix()
        for letter, startup in (("A", "PASS"), ("B", "PASS"),
                                ("C", "CRASH")):
            doc = self._arm_doc(letter)
            record = doc["record"]
            self.assertRegex(record["artifact_sha256"], r"^[0-9a-f]{64}$")
            self.assertEqual(record["certificate_sha256"], "aabbccdd")
            self.assertTrue(record["install"]["success"])
            self.assertEqual(
                record["post_install_identity"]["identity"], "MATCH")
            self.assertEqual(record["startup"], startup)
            self.assertEqual(len(record["pids"]), 1)
            self.assertIsNotNone(record["session_bound"])
            self.assertTrue(
                (self.out / ("ISOLATION-ARM-%s-HEALTH.json" % letter)
                 ).is_file())
        crash = self._arm_doc("C")["record"]["crash"]
        self.assertEqual(crash["fatal_signal"], "SIGABRT")
        self.assertTrue(crash["fault_library"])
        self.assertTrue(crash["fault_pc"])

    def test_arm_b_has_zero_mutations_arm_c_has_probe(self):
        self._run_matrix()
        manifest_b = self._arm_doc("B")["manifest"]
        self.assertEqual(manifest_b["mutations"], [])
        self.assertIs(manifest_b["GADGET_PRESENT"], False)
        self.assertIs(manifest_b["PROBE_PRESENT"], False)
        manifest_c = self._arm_doc("C")["manifest"]
        self.assertEqual(len(manifest_c["mutations"]), 1)
        self.assertEqual(manifest_c["mutations"][0]["type"],
                         "LOG_I_PROBE")
        self.assertIs(manifest_c["GADGET_PRESENT"], False)

    def test_install_r_only_never_destructive(self):
        self._run_matrix()
        installs = [c for c in self.cmd_log if " install " in c]
        self.assertEqual(len(installs), 3)
        for cmd in installs:
            self.assertIn(" -r ", cmd)
        for cmd in self.cmd_log:
            self.assertNotIn("uninstall", cmd)
            self.assertNotIn("clear-data", cmd)
            self.assertNotIn("pm clear", cmd)

    def test_subset_degrades_to_inconclusive(self):
        result = self._run_matrix({"REELSEC_ISOLATION_MATRIX": "AB"})
        self.assertEqual(result["decision"]["status"], "INCONCLUSIVE")
        self.assertEqual(result["decision"]["reason"],
                         "INCONCLUSIVE_SCOPE_PARTIAL")
        self.assertFalse((self.out / "ISOLATION-ARM-C.json").exists())

    def test_gadget_refused_before_any_arm(self):
        with self.assertRaises(IsolationError):
            self._run_matrix({"REELSEC_USE_GADGET": "1"})
        self.assertFalse((self.out / "ISOLATION-ARM-A.json").exists())
        self.assertFalse(
            any(" install " in c for c in self.cmd_log))


class IsolationAggregateTests(unittest.TestCase):
    def test_final_verdict_driven_by_decision(self):
        with tempfile.TemporaryDirectory() as tmp:
            cd = Path(tmp)
            (cd / "ISOLATION-DECISION.json").write_text(json.dumps({
                "status": "TELEMETRY_PROBE_CANDIDATE",
                "reason": "PROBE_DELTA_ISOLATED",
                "detail": "arms A and B healthy, arm C crashed",
                "regression": "SUSPECTED_NOT_PROVEN",
                "candidates": ["LOG_I_PROBE telemetry probe"],
                "excluded": ["apktool rebuild"],
                "arm_states": {"A": "HEALTHY", "B": "HEALTHY",
                               "C": "CRASHED"},
                "next_action": "Minimize the probe and re-run.",
            }), encoding="utf-8")
            verdict = orch._final_verdict_logic(cd)
        self.assertEqual(verdict["final_verdict"], "NOT_PROVEN")
        runtime = verdict["runtime"]
        self.assertEqual(runtime["RUNTIME_STATUS"],
                         "TELEMETRY_PROBE_CANDIDATE")
        self.assertEqual(runtime["REGRESSION_STATUS"],
                         "SUSPECTED_NOT_PROVEN")
        self.assertIn("Minimize the probe", runtime["NEXT_ACTION"])


if __name__ == "__main__":
    unittest.main(verbosity=2)


def _narrowing_zip_bytes(tag):
    buf = io.BytesIO()
    with zipfile.ZipFile(buf, "w") as archive:
        archive.writestr("AndroidManifest.xml", b"<manifest/>" + tag)
        archive.writestr("classes.dex", b"dex-bytes" + tag)
        archive.writestr("lib/arm64-v8a/libSecShell.so", b"so-bytes",
                         compress_type=zipfile.ZIP_STORED)
        archive.writestr("META-INF/MANIFEST.MF", b"manifest-mf" + tag)
    return buf.getvalue()


class NarrowingHarness(MatrixHarness):
    """AB1B2 narrowing with valid-ZIP artifacts and a fake zipalign."""

    _CRASH_INSTALLS = frozenset()
    _break_b1_zip = False

    def setUp(self):
        super().setUp()
        # Arm A must inventory: the original is a valid ZIP that the
        # rebuild visibly differs from.
        self.original.write_bytes(_narrowing_zip_bytes(b"-orig"))

    def _zipalign_path(self):
        return "/zipalign"

    def _apktool_output_bytes(self, out):
        if out.name.startswith("isolation-B1") and self._break_b1_zip:
            return b"not-a-zip-at-all"
        return _narrowing_zip_bytes(b"-rebuilt")

    def _fake_zipalign(self, words):
        if "-c" in words:
            target = Path(words[-1])
            try:
                with zipfile.ZipFile(target, "r"):
                    pass
            except (zipfile.BadZipFile, OSError):
                return 1, "bad zip"
            return 0, "Verification successful"
        src, dst = Path(words[-2]), Path(words[-1])
        with zipfile.ZipFile(src, "r") as zin:
            items = [(info.filename, zin.read(info.filename),
                      info.compress_type) for info in zin.infolist()]
        with zipfile.ZipFile(dst, "w") as zout:
            for name, data, ctype in items:
                info = zipfile.ZipInfo(name)
                info.compress_type = ctype
                # Padding shifts offsets and sizes the way alignment
                # does while keeping .so entries STORED. The extra
                # field must stay a well-formed tag/size/value record
                # or the ZIP reader rejects the whole archive.
                info.extra = struct.pack("<HH16s", 0xCAFE, 16,
                                         b"ALIGN-PADDED-BIN")
                zout.writestr(info, data)
        return 0, "aligned"

    def _should_report_crash(self):
        if self.state["installs"] not in self._CRASH_INSTALLS:
            return False
        seen = self.state.setdefault("exit_seen", set())
        if self.state["installs"] in seen:
            return True
        seen.add(self.state["installs"])
        return False

    def _should_log_crash(self):
        return self.state["installs"] in self._CRASH_INSTALLS

    def _run_narrowing(self):
        return self._run_matrix({"REELSEC_ISOLATION_MATRIX": "AB1B2"})

    def _diff_doc(self):
        return json.loads(
            (self.out / "ISOLATION-ARTIFACT-DIFF.json").read_text(
                encoding="utf-8"))


class IsolationNarrowingTests(NarrowingHarness):
    def test_b1_skips_zipalign_b2_runs_it(self):
        result = self._run_narrowing()
        zipalign_cmds = [c for c in self.cmd_log
                         if c.startswith("/zipalign ")]
        self.assertTrue(zipalign_cmds)
        for cmd in zipalign_cmds:
            self.assertNotIn("B1", cmd)
        self.assertTrue(any("B2" in c for c in zipalign_cmds))
        manifest_b1 = self._arm_doc("B1")["manifest"]
        manifest_b2 = self._arm_doc("B2")["manifest"]
        self.assertIs(manifest_b1["alignment_applied"], False)
        self.assertIs(manifest_b2["alignment_applied"], True)
        for manifest in (manifest_b1, manifest_b2):
            self.assertEqual(manifest["mutations"], [])
            self.assertIs(manifest["PROBE_PRESENT"], False)
            self.assertIs(manifest["GADGET_PRESENT"], False)
        installs = [c for c in self.cmd_log if " install " in c]
        self.assertEqual(len(installs), 3)
        for cmd in self.cmd_log:
            self.assertNotIn("uninstall", cmd)
            self.assertNotIn("pm clear", cmd)
        self.assertEqual(result["decision"]["status"],
                         "NO_CRASH_REPRODUCED")

    def test_narrowing_diff_covers_arm_pairs(self):
        self._run_narrowing()
        diff = self._diff_doc()
        self.assertEqual(diff["schema_version"],
                         "isolation-artifact-diff-1")
        self.assertEqual(diff["planned_arms"], ["A", "B1", "B2"])
        for pair in ("A→B1", "A→B2", "B1→B2"):
            self.assertIn(pair, diff["pairs"])
        rebuild = diff["pairs"]["A→B1"]
        self.assertEqual(rebuild["verdict"], "CONTENT_CHANGED")
        self.assertTrue(rebuild["narrowing_queue"])
        # Alignment moves bytes without changing content: the
        # relocation fingerprint, with native code queued first.
        b1b2 = diff["pairs"]["B1→B2"]
        self.assertEqual(b1b2["verdict"], "LAYOUT_ONLY")
        self.assertEqual(b1b2["content_change_count"], 0)
        self.assertTrue(b1b2["layout_change_count"] > 0)
        self.assertIn("NATIVE_LIBS", b1b2["narrowing_queue"])
        self.assertEqual(diff["gaps"], [])
        self.assertEqual(set(diff["inventories"]), {"A", "B1", "B2"})


class IsolationNarrowingCrashTests(NarrowingHarness):
    _CRASH_INSTALLS = frozenset((2, 3))

    def test_rebuild_alone_suffices(self):
        result = self._run_narrowing()
        decision = result["decision"]
        self.assertEqual(decision["status"], "REBUILD_SUFFICES")
        self.assertEqual(decision["reason"], "UNALIGNED_REBUILD_CRASHES")
        self.assertEqual(decision["arm_states"]["B1"], "CRASHED")
        self.assertTrue(decision["crash_signatures_equal"])
        self.assertIn("apktool rebuild",
                      " ".join(decision["candidates"]))
        self.assertIn("LOG_I_PROBE telemetry probe",
                      decision["excluded"])
        self.assertIn("Frida Gadget", decision["excluded"])


class IsolationAlignmentCandidateTests(NarrowingHarness):
    _CRASH_INSTALLS = frozenset((3,))

    def test_aligned_only_crash_points_at_alignment(self):
        result = self._run_narrowing()
        decision = result["decision"]
        self.assertEqual(decision["status"], "ALIGNMENT_CANDIDATE")
        self.assertEqual(decision["reason"], "ALIGNED_REBUILD_CRASHES")
        self.assertEqual(decision["arm_states"]["B1"], "HEALTHY")
        self.assertEqual(decision["arm_states"]["B2"], "CRASHED")


class IsolationOrderAnomalyTests(NarrowingHarness):
    _CRASH_INSTALLS = frozenset((2,))

    def test_b1_crash_b2_healthy_stays_inconclusive(self):
        result = self._run_narrowing()
        decision = result["decision"]
        self.assertEqual(decision["status"], "INCONCLUSIVE")
        self.assertEqual(decision["reason"],
                         "ALIGNMENT_ORDER_ANOMALY")


class IsolationBrokenB1Tests(NarrowingHarness):
    _break_b1_zip = True

    def test_invalid_unaligned_rebuild_blocks_arm(self):
        result = self._run_narrowing()
        record = self._arm_doc("B1")["record"]
        self.assertEqual(record["status"], "BLOCKED_INSTALL")
        self.assertIn("not a valid ZIP", record["reason"])
        self.assertEqual(result["decision"]["status"], "INCONCLUSIVE")
        self.assertEqual(result["decision"]["reason"],
                         "INCONCLUSIVE_B1_MISSING")
        gaps = self._diff_doc()["gaps"]
        self.assertTrue(any(g.get("pair") == "A→B1" for g in gaps))
        self.assertIn("A→B2", self._diff_doc()["pairs"])
