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


if __name__ == "__main__":
    unittest.main(verbosity=2)
