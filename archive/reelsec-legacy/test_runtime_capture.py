import tempfile
import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from runtime_capture import RuntimeCaptureError, adb_command, bind_artifact


class RuntimeCaptureTests(unittest.TestCase):
    def test_command_requires_explicit_device(self):
        with self.assertRaises(RuntimeCaptureError):
            adb_command("/usr/bin/adb", "", "get-state")

    def test_bind_artifact_marks_observed_not_proven(self):
        with tempfile.TemporaryDirectory() as tmp:
            artifact = Path(tmp) / "signed.apk"
            artifact.write_bytes(b"signed-artifact")
            snapshot = {"schema_version": 1, "device_serial": "SERIAL"}
            result = bind_artifact(snapshot, artifact)
            self.assertEqual(result["evidence_class"], "OBSERVED")
            self.assertFalse(result["causal_proof"])
            self.assertEqual(result["artifact"]["path"], str(artifact.resolve()))

    def test_missing_artifact_rejected(self):
        with self.assertRaises(RuntimeCaptureError):
            bind_artifact({}, "/missing.apk")


if __name__ == "__main__":
    unittest.main(verbosity=2)
