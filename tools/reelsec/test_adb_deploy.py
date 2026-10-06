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


if __name__ == "__main__":
    unittest.main(verbosity=2)
