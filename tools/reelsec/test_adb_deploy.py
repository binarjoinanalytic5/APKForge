import subprocess
import tempfile
import unittest
from pathlib import Path
from unittest import mock
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from adb_deploy import (
    AdbDeployError,
    adb_command,
    install_command,
    resolve_test_device,
    is_signature_mismatch_error,
    diagnose_install_failure,
)


class AdbDeployTests(unittest.TestCase):
    def test_explicit_serial_is_required(self):
        with self.assertRaises(AdbDeployError):
            adb_command("/usr/bin/adb", "", "get-state")

    def test_install_uses_signed_artifact(self):
        with tempfile.TemporaryDirectory() as tmp:
            apk = Path(tmp) / "instrumented-signed.apk"
            apk.write_bytes(b"signed")
            cmd = install_command("/usr/bin/adb", "SERIAL", apk)
            self.assertEqual(cmd[:4], ["/usr/bin/adb", "-s", "SERIAL", "install"])
            self.assertIn(str(apk.resolve()), cmd)

    def test_missing_artifact_rejected(self):
        with self.assertRaises(AdbDeployError):
            install_command("/usr/bin/adb", "SERIAL", "/missing.apk")


    def test_signature_mismatch_is_classified(self):
        self.assertTrue(
            is_signature_mismatch_error(
                "Failure [INSTALL_FAILED_UPDATE_INCOMPATIBLE: Existing package signatures do not match]"
            )
        )
        self.assertFalse(
            is_signature_mismatch_error(
                "Failure [INSTALL_FAILED_VERSION_DOWNGRADE]"
            )
        )


    def _completed(self, output, returncode=0):
        return subprocess.CompletedProcess(
            ["/usr/bin/adb", "devices", "-l"],
            returncode,
            stdout=output,
        )

    def test_explicit_serial_is_preserved_when_online(self):
        output = (
            "List of devices attached\n"
            "192.168.8.8:32897\tdevice product:c2qsqw model:SM_N986U device:c2q\n"
            "emulator-5554\tdevice product:sdk_gphone model:Pixel\n"
        )
        with mock.patch("adb_deploy.subprocess.run", return_value=self._completed(output)):
            result = resolve_test_device("/usr/bin/adb", "192.168.8.8:32897")
        self.assertEqual(result["serial"], "192.168.8.8:32897")
        self.assertEqual(result["resolution"], "EXPLICIT_MATCH")
        self.assertEqual(
            result["online_devices"],
            ["192.168.8.8:32897", "emulator-5554"],
        )

    def test_stale_serial_rebinds_only_to_single_online_device(self):
        output = (
            "List of devices attached\n"
            "192.168.8.8:32897\tdevice product:c2qsqw model:SM_N986U device:c2q\n"
            "192.168.8.8:39927\toffline\n"
        )
        with mock.patch("adb_deploy.subprocess.run", return_value=self._completed(output)):
            result = resolve_test_device("/usr/bin/adb", "192.168.8.8:39927")
        self.assertEqual(result["serial"], "192.168.8.8:32897")
        self.assertEqual(
            result["resolution"],
            "AUTO_REBOUND_SINGLE_ONLINE_DEVICE",
        )
        self.assertEqual(result["requested_serial"], "192.168.8.8:39927")

    def test_stale_serial_is_rejected_with_multiple_online_devices(self):
        output = (
            "List of devices attached\n"
            "192.168.8.8:32897\tdevice product:c2qsqw model:SM_N986U device:c2q\n"
            "emulator-5554\tdevice product:sdk_gphone model:Pixel\n"
        )
        with mock.patch("adb_deploy.subprocess.run", return_value=self._completed(output)):
            with self.assertRaises(AdbDeployError):
                resolve_test_device("/usr/bin/adb", "192.168.8.8:39927")

    def test_auto_requires_exactly_one_online_device(self):
        output = (
            "List of devices attached\n"
            "192.168.8.8:32897\tdevice product:c2qsqw model:SM_N986U device:c2q\n"
        )
        with mock.patch("adb_deploy.subprocess.run", return_value=self._completed(output)):
            result = resolve_test_device("/usr/bin/adb", "auto")
        self.assertEqual(result["serial"], "192.168.8.8:32897")
        self.assertEqual(result["resolution"], "AUTO_SINGLE_ONLINE_DEVICE")

    def test_auto_rejects_no_online_devices(self):
        output = (
            "List of devices attached\n"
            "192.168.8.8:32897\toffline\n"
        )
        with mock.patch("adb_deploy.subprocess.run", return_value=self._completed(output)):
            with self.assertRaises(AdbDeployError):
                resolve_test_device("/usr/bin/adb", "auto")


class InstallDiagnosticsTests(unittest.TestCase):
    def test_native_lib_extraction_failure_is_classified(self):
        diag = diagnose_install_failure(
            "adb: failed to install x.apk: Failure [INSTALL_FAILED_INVALID_APK: "
            "INSTALL_FAILED_INVALID_APK: Failed to extract native libraries, res=-2]")
        self.assertEqual(diag["reason_code"], "NATIVE_LIB_EXTRACTION_FAILED")
        self.assertIn("alignment", diag["hint"])

    def test_signature_mismatch_is_classified(self):
        diag = diagnose_install_failure(
            "Failure [INSTALL_FAILED_UPDATE_INCOMPATIBLE: signatures do not match]")
        self.assertEqual(diag["reason_code"], "SIGNATURE_MISMATCH")

    def test_unknown_failure_is_unclassified_not_guessed(self):
        diag = diagnose_install_failure("something entirely unknown happened")
        self.assertEqual(diag["reason_code"], "INSTALL_FAILED_UNCLASSIFIED")
        self.assertEqual(diag["matches"], [])

    def test_preflight_detects_compressed_native_libs(self):
        import io
        import zipfile
        from adb_deploy import artifact_preflight_checks
        with tempfile.TemporaryDirectory() as td:
            apk = Path(td) / "instrumented.apk"
            buf = io.BytesIO()
            with zipfile.ZipFile(buf, "w") as zf:
                zf.writestr("classes.dex", b"dex\n035\x00fake")
                zf.writestr("lib/arm64-v8a/libgood.so", b"\x7fELFstored",
                            compress_type=zipfile.ZIP_STORED)
                zf.writestr("lib/arm64-v8a/libbad.so", b"\x7fELFcompressed" * 40,
                            compress_type=zipfile.ZIP_DEFLATED)
            apk.write_bytes(buf.getvalue())
            report = artifact_preflight_checks(apk)
            self.assertEqual(report["status"], "PREFLIGHT_FAILED")
            check = report["checks"]["native_libs_uncompressed"]
            self.assertEqual(check["status"], "FAIL")
            self.assertIn("lib/arm64-v8a/libbad.so", check["compressed_entries"])
            self.assertEqual(report["checks"]["abi_directories"]["abis"], ["arm64-v8a"])

    def test_preflight_passes_with_stored_libs_and_abi_match(self):
        import io
        import zipfile
        from adb_deploy import artifact_preflight_checks
        with tempfile.TemporaryDirectory() as td:
            apk = Path(td) / "instrumented.apk"
            buf = io.BytesIO()
            with zipfile.ZipFile(buf, "w") as zf:
                zf.writestr("classes.dex", b"dex\n035\x00fake")
                zf.writestr("lib/arm64-v8a/libgood.so", b"\x7fELFstored",
                            compress_type=zipfile.ZIP_STORED)
            apk.write_bytes(buf.getvalue())

            def fake_runner(cmd, timeout=120):
                if "getprop" in cmd:
                    return 0, "arm64-v8a,armeabi-v7a\n"
                return 1, ""
            report = artifact_preflight_checks(
                apk, runner=fake_runner, adb="/usr/bin/adb", serial="192.168.8.8:1")
            self.assertEqual(report["status"], "PASS")
            self.assertTrue(report["checks"]["abi_compatibility"]["compatible"])

    def test_preflight_rejects_unaligned_artifact(self):
        # Deploy-side half of the first no-gadget failure: an unaligned APK
        # fails `zipalign -c` on hosts where the binary exists, so preflight
        # must report PREFLIGHT_FAILED instead of letting a bad artifact
        # reach `adb install`.
        import io
        import zipfile
        from adb_deploy import artifact_preflight_checks
        with tempfile.TemporaryDirectory() as td:
            apk = Path(td) / "instrumented.apk"
            buf = io.BytesIO()
            with zipfile.ZipFile(buf, "w") as zf:
                zf.writestr("classes.dex", b"dex\n035\x00fake")
                zf.writestr("lib/arm64-v8a/libgood.so", b"\x7fELFstored",
                            compress_type=zipfile.ZIP_STORED)
            apk.write_bytes(buf.getvalue())

            def fake_runner(cmd, timeout=120):
                if "getprop" in cmd:
                    return 0, "arm64-v8a,armeabi-v7a\n"
                return 1, "unaligned"

            report = artifact_preflight_checks(
                apk, runner=fake_runner, zipalign="/usr/bin/zipalign",
                adb="/usr/bin/adb", serial="192.168.8.8:1")
            self.assertEqual(report["status"], "PREFLIGHT_FAILED")
            self.assertEqual(
                report["checks"]["zipalign_page_alignment"]["status"], "FAIL")

    def test_verify_installed_package_success(self):
        from adb_deploy import verify_installed_package

        def fake_runner(cmd, timeout=120):
            if "pm" in cmd:
                return 0, "package:/data/app/~~x/com.newleaf.app.android.victor-y/base.apk\n"
            return 0, "    versionCode=4200 minSdk=24 targetSdk=34\n"
        result = verify_installed_package(
            "/usr/bin/adb", "192.168.8.8:1", "com.newleaf.app.android.victor",
            runner=fake_runner)
        self.assertEqual(result["status"], "VERIFIED_INSTALLED")
        self.assertTrue(result["present"])
        self.assertEqual(result["version_code"], "4200")

    def test_verify_installed_package_absent(self):
        from adb_deploy import verify_installed_package

        def fake_runner(cmd, timeout=120):
            return 0, ""
        result = verify_installed_package(
            "/usr/bin/adb", "192.168.8.8:1", "com.x", runner=fake_runner)
        self.assertEqual(result["status"], "NOT_PRESENT_AFTER_INSTALL")
        self.assertFalse(result["present"])


class ArtifactIntegrityGateTests(unittest.TestCase):
    def _make_apk(self, td, signed=True, libs=("lib/arm64-v8a/liba.so",),
                  manifest=True):
        import zipfile
        apk = Path(td) / "artifact.apk"
        with zipfile.ZipFile(apk, "w") as zf:
            for lib in libs:
                info = zipfile.ZipInfo(lib)
                info.compress_type = zipfile.ZIP_STORED
                zf.writestr(info, b"\x7fELF")
            if signed:
                zf.writestr("META-INF/REELSEC.RSA", b"sig")
            if manifest:
                zf.writestr("AndroidManifest.xml", b"\x03\x00\x08\x00axml")
            zf.writestr("classes.dex", b"dex")
        return apk

    def test_healthy_artifact_passes(self):
        from adb_deploy import artifact_integrity_gate
        with tempfile.TemporaryDirectory() as td:
            apk = self._make_apk(td)
            gate = artifact_integrity_gate(
                apk, runner=lambda cmd, timeout=120: (0, ""),
                expected_so={"liba.so"})
        self.assertEqual(gate["status"], "PASS")
        self.assertEqual(gate["checks"]["signing_present"]["status"], "PASS")
        self.assertEqual(gate["checks"]["expected_native_libs"]["status"], "PASS")

    def test_missing_expected_so_fails_gate(self):
        from adb_deploy import artifact_integrity_gate
        with tempfile.TemporaryDirectory() as td:
            apk = self._make_apk(td)
            gate = artifact_integrity_gate(
                apk, runner=lambda cmd, timeout=120: (0, ""),
                expected_so={"liba.so", "libsaasCorePlayer.so"})
        self.assertEqual(gate["status"], "INTEGRITY_FAILED")
        self.assertEqual(
            gate["checks"]["expected_native_libs"]["missing"],
            ["libsaasCorePlayer.so"])

    def test_unsigned_artifact_fails_gate(self):
        from adb_deploy import artifact_integrity_gate
        with tempfile.TemporaryDirectory() as td:
            apk = self._make_apk(td, signed=False)
            gate = artifact_integrity_gate(apk,
                                           runner=lambda cmd, timeout=120: (0, ""))
        self.assertEqual(gate["status"], "INTEGRITY_FAILED")
        self.assertEqual(gate["checks"]["signing_present"]["status"], "FAIL")

    def test_missing_artifact_reported(self):
        from adb_deploy import artifact_integrity_gate
        gate = artifact_integrity_gate("/nonexistent/x.apk")
        self.assertEqual(gate["status"], "ARTIFACT_MISSING")

    # --- Regression: "not installed" vs "installed identity mismatch" ---

    def test_not_installed_is_not_an_integrity_failure(self):
        """The gate runs BEFORE install: a fresh-install device (package
        absent — the exact state that blocked the 2026-10-07 platform trial)
        must NOT fail the gate."""
        from adb_deploy import artifact_integrity_gate
        with tempfile.TemporaryDirectory() as td:
            apk = self._make_apk(td)

            def runner(cmd, timeout=120):
                return 0, ""  # pm path: absent; dumpsys: empty
            gate = artifact_integrity_gate(
                apk, runner=runner, adb="/adb", serial="s1",
                package="com.test.pkg")
        self.assertEqual(gate["checks"]["installed_identity"]["status"],
                         "NOT_INSTALLED")
        self.assertEqual(gate["status"], "PASS")

    def test_installed_identity_passes_when_present(self):
        from adb_deploy import artifact_integrity_gate
        with tempfile.TemporaryDirectory() as td:
            apk = self._make_apk(td)

            def runner(cmd, timeout=120):
                joined = " ".join(str(c) for c in cmd)
                if "pm" in joined and "path" in joined:
                    return 0, "package:/data/app/~~x/com.test.pkg/base.apk\n"
                return 0, "    versionCode=4200 minSdk=24\n"
            gate = artifact_integrity_gate(
                apk, runner=runner, adb="/adb", serial="s1",
                package="com.test.pkg")
        self.assertEqual(gate["checks"]["installed_identity"]["status"], "PASS")
        self.assertEqual(gate["checks"]["installed_identity"]["version_code"],
                         "4200")
        self.assertEqual(gate["status"], "PASS")

    def test_package_identity_unverified_when_decoder_has_no_result(self):
        """A decoder that cannot read the manifest (e.g. apktool-rebuilt
        AXML) yields UNVERIFIED — recorded, non-blocking. Identity is proven
        at install + post-install verification, never assumed."""
        from adb_deploy import artifact_integrity_gate
        with tempfile.TemporaryDirectory() as td:
            apk = self._make_apk(td, libs=("lib/arm64-v8a/liba.so",))
            gate = artifact_integrity_gate(
                apk, runner=lambda cmd, timeout=120: (0, ""),
                package="com.test.pkg", manifest_decoder=lambda data: None)
        self.assertEqual(gate["checks"]["package_identity"]["status"],
                         "UNVERIFIED")
        self.assertEqual(gate["status"], "PASS")

    def test_package_identity_unverified_on_decoder_exception(self):
        from adb_deploy import artifact_integrity_gate

        def bad_decoder(data):
            raise ValueError("axml pool layout not recognized")
        with tempfile.TemporaryDirectory() as td:
            apk = self._make_apk(td)
            gate = artifact_integrity_gate(
                apk, runner=lambda cmd, timeout=120: (0, ""),
                package="com.test.pkg", manifest_decoder=bad_decoder)
        self.assertEqual(gate["checks"]["package_identity"]["status"],
                         "UNVERIFIED")
        self.assertIn("decoder error",
                      gate["checks"]["package_identity"]["reason"])
        self.assertEqual(gate["status"], "PASS")

    def test_package_identity_fails_only_on_proven_mismatch(self):
        from adb_deploy import artifact_integrity_gate
        with tempfile.TemporaryDirectory() as td:
            apk = self._make_apk(td)
            gate = artifact_integrity_gate(
                apk, runner=lambda cmd, timeout=120: (0, ""),
                package="com.test.pkg",
                manifest_decoder=lambda data: "com.other.pkg")
        self.assertEqual(gate["checks"]["package_identity"]["status"], "FAIL")
        self.assertEqual(gate["checks"]["package_identity"]["decoded_package"],
                         "com.other.pkg")
        self.assertEqual(gate["status"], "INTEGRITY_FAILED")

    def test_matching_package_identity_passes(self):
        from adb_deploy import artifact_integrity_gate
        with tempfile.TemporaryDirectory() as td:
            apk = self._make_apk(td)
            gate = artifact_integrity_gate(
                apk, runner=lambda cmd, timeout=120: (0, ""),
                package="com.test.pkg",
                manifest_decoder=lambda data: "com.test.pkg")
        self.assertEqual(gate["checks"]["package_identity"]["status"], "PASS")
        self.assertEqual(gate["status"], "PASS")


class DeployGateTests(unittest.TestCase):
    def test_readiness_ready(self):
        from adb_deploy import deploy_readiness
        with tempfile.TemporaryDirectory() as tmp:
            apk = Path(tmp) / "s.apk"
            apk.write_bytes(b"signed")
            ks = Path(tmp) / "test.p12"
            ks.write_bytes(b"ks")
            report = deploy_readiness(
                sign_status="SIGNED_VERIFIED", artifact_path=str(apk),
                artifact_sha256="a" * 64, certificate_sha256="b" * 64,
                apksigner_path="/usr/bin/apksigner",
                keystore_path=str(ks), test_package="com.x")
            self.assertTrue(report["ready"])
            self.assertEqual(report["status"], "READY")
            self.assertEqual(report["failed"], [])

    def test_readiness_blocks_missing_facts(self):
        from adb_deploy import deploy_readiness
        report = deploy_readiness(
            sign_status="BLOCKED_OR_FAILED", artifact_path="/no/apk",
            artifact_sha256=None, certificate_sha256=None,
            apksigner_path=None, keystore_path="/no/ks",
            test_package=None)
        self.assertFalse(report["ready"])
        self.assertEqual(report["status"], "NOT_READY")
        for name in ("signed_verified", "artifact_present",
                     "certificate_recorded", "apksigner_available",
                     "keystore_present", "test_package_resolved"):
            self.assertIn(name, report["failed"])

    def _device(self, installed=True, installed_cert="aa",
                installed_version="4200", pull_ok=True, certs_ok=True):
        adb, serial = "/adb", "S1"
        calls = []

        def fake(cmd, timeout=120):
            calls.append(cmd)
            if cmd[:2] == [adb, "-s"] and cmd[3] == "shell":
                rest = cmd[4:]
                if rest[:2] == ["pm", "path"]:
                    if installed:
                        return 0, "package:/data/app/x/base.apk\n"
                    return 0, ""
                if rest[:2] == ["dumpsys", "package"]:
                    return 0, "versionCode=%s versionName=1\n" % installed_version
            if cmd[:2] == [adb, "-s"] and cmd[3] == "pull":
                if not pull_ok:
                    return 1, "pull failed"
                Path(cmd[-1]).write_bytes(b"installed-apk")
                return 0, "pulled"
            if "--print-certs" in cmd:
                if not certs_ok:
                    return 1, "verify failed"
                return 0, ("Signer #1 certificate SHA-256 digest: %s\n"
                           % installed_cert)
            return 1, "unexpected: %s" % (cmd,)
        return adb, serial, fake, calls

    def test_compatibility_fresh_install(self):
        from adb_deploy import check_install_compatibility
        adb, serial, fake, calls = self._device(installed=False)
        with tempfile.TemporaryDirectory() as tmp:
            record = check_install_compatibility(
                adb=adb, serial=serial, package="com.x",
                artifact_cert_sha256="aa", apksigner="/usr/bin/apksigner",
                runner=fake, tmp_dir=tmp)
        self.assertTrue(record["compatible"])
        self.assertEqual(record["mode"], "FRESH_INSTALL")
        self.assertFalse(any("pull" in c for c in calls))

    def test_compatibility_signature_match(self):
        from adb_deploy import check_install_compatibility
        adb, serial, fake, _ = self._device(installed_cert="AA:BB")
        with tempfile.TemporaryDirectory() as tmp:
            record = check_install_compatibility(
                adb=adb, serial=serial, package="com.x",
                artifact_cert_sha256="aabb", artifact_version_code=4200,
                apksigner="/usr/bin/apksigner", runner=fake, tmp_dir=tmp)
            leftovers = list(Path(tmp).iterdir())
        self.assertTrue(record["compatible"])
        self.assertEqual(record["mode"], "REPLACE_INSTALL")
        self.assertEqual(record["reason_code"], "SIGNATURE_MATCH")
        self.assertEqual(leftovers, [])

    def test_compatibility_signature_mismatch(self):
        from adb_deploy import check_install_compatibility
        adb, serial, fake, _ = self._device(installed_cert="BB:CC")
        with tempfile.TemporaryDirectory() as tmp:
            record = check_install_compatibility(
                adb=adb, serial=serial, package="com.x",
                artifact_cert_sha256="aabb",
                apksigner="/usr/bin/apksigner", runner=fake, tmp_dir=tmp)
            leftovers = list(Path(tmp).iterdir())
        self.assertFalse(record["compatible"])
        self.assertEqual(record["reason_code"], "SIGNATURE_MISMATCH")
        self.assertIn("authorization", record["reason"].lower())
        self.assertEqual(leftovers, [])

    def test_compatibility_downgrade(self):
        from adb_deploy import check_install_compatibility
        adb, serial, fake, _ = self._device(installed_cert="AA:BB",
                                            installed_version="4200")
        with tempfile.TemporaryDirectory() as tmp:
            record = check_install_compatibility(
                adb=adb, serial=serial, package="com.x",
                artifact_cert_sha256="aabb", artifact_version_code=4100,
                apksigner="/usr/bin/apksigner", runner=fake, tmp_dir=tmp)
        self.assertFalse(record["compatible"])
        self.assertEqual(record["reason_code"], "VERSION_DOWNGRADE")

    def test_compatibility_unverified_on_pull_failure(self):
        from adb_deploy import check_install_compatibility
        adb, serial, fake, _ = self._device(pull_ok=False)
        with tempfile.TemporaryDirectory() as tmp:
            record = check_install_compatibility(
                adb=adb, serial=serial, package="com.x",
                artifact_cert_sha256="aabb",
                apksigner="/usr/bin/apksigner", runner=fake, tmp_dir=tmp)
        self.assertFalse(record["compatible"])
        self.assertEqual(record["reason_code"], "COMPATIBILITY_UNVERIFIED")

    def test_post_install_identity_match(self):
        from adb_deploy import verify_installed_artifact_identity
        adb, serial, fake, _ = self._device(installed_cert="AA:BB")
        with tempfile.TemporaryDirectory() as tmp:
            record = verify_installed_artifact_identity(
                adb=adb, serial=serial, package="com.x",
                expected_cert_sha256="aabb",
                apksigner="/usr/bin/apksigner", runner=fake, tmp_dir=tmp)
        self.assertEqual(record["identity"], "MATCH")

    def test_post_install_identity_mismatch(self):
        from adb_deploy import verify_installed_artifact_identity
        adb, serial, fake, _ = self._device(installed_cert="CC:DD")
        with tempfile.TemporaryDirectory() as tmp:
            record = verify_installed_artifact_identity(
                adb=adb, serial=serial, package="com.x",
                expected_cert_sha256="aabb",
                apksigner="/usr/bin/apksigner", runner=fake, tmp_dir=tmp)
        self.assertEqual(record["identity"], "MISMATCH")
        self.assertIn("runtime blocked", record["reason"].lower())


if __name__ == "__main__":
    unittest.main(verbosity=2)
