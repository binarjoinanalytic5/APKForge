import os
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

sys.path.insert(0, str(Path(__file__).resolve().parent))

from sign_verify import SignVerifyError, artifact_identity, sign_command, verify_command


class SignVerifyTests(unittest.TestCase):
    def test_sign_command_isolated(self):
        with mock.patch.dict(
            os.environ,
            {
                "REELSEC_TEST_KEYSTORE_PASSWORD": "store-secret",
                "REELSEC_TEST_KEY_PASSWORD": "key-secret",
            },
            clear=False,
        ):
            cmd = sign_command("/usr/bin/apksigner", "/tmp/u.apk", "/tmp/s.apk", "/tmp/test.jks", "test")
        self.assertEqual(cmd[0:2], ["/usr/bin/apksigner", "sign"])
        self.assertIn("/tmp/u.apk", cmd)
        self.assertIn("/tmp/s.apk", cmd)
        self.assertIn("--ks-pass", cmd)
        self.assertIn("env:REELSEC_TEST_KEYSTORE_PASSWORD", cmd)
        self.assertIn("--key-pass", cmd)
        self.assertIn("env:REELSEC_TEST_KEY_PASSWORD", cmd)
        self.assertNotIn("store-secret", cmd)
        self.assertNotIn("key-secret", cmd)

    def test_sign_command_requires_password_environment(self):
        with mock.patch.dict(
            os.environ,
            {
                "REELSEC_TEST_KEYSTORE_PASSWORD": "",
                "REELSEC_TEST_KEY_PASSWORD": "",
            },
            clear=False,
        ):
            with self.assertRaises(SignVerifyError):
                sign_command("/usr/bin/apksigner", "/tmp/u.apk", "/tmp/s.apk", "/tmp/test.jks", "test")

    def test_verify_command(self):
        self.assertEqual(
            verify_command("/usr/bin/apksigner", "/tmp/s.apk"),
            ["/usr/bin/apksigner", "verify", "--verbose", "/tmp/s.apk"],
        )

    def test_identity_requires_separate_artifacts(self):
        with tempfile.TemporaryDirectory() as tmp:
            u = Path(tmp) / "u.apk"
            s = Path(tmp) / "s.apk"
            u.write_bytes(b"unsigned")
            s.write_bytes(b"signed")
            result = artifact_identity(u, s)
            self.assertFalse(result["original_mutation"])
            self.assertNotEqual(result["unsigned_sha256"], result["signed_sha256"])

    def test_identity_rejects_same_path(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "a.apk"
            p.write_bytes(b"x")
            with self.assertRaises(SignVerifyError):
                artifact_identity(p, p)


if __name__ == "__main__":
    unittest.main(verbosity=2)
