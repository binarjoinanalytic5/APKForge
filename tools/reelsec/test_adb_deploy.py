import tempfile
import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from adb_deploy import AdbDeployError, adb_command, install_command


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


if __name__ == "__main__":
    unittest.main(verbosity=2)
