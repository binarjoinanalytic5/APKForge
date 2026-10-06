#!/usr/bin/env python3
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from reelsec import build_input_provenance


class ProvenanceTests(unittest.TestCase):
    def test_target_inside_analysis_root(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "decoded"
            root.mkdir()
            target = root / "lib" / "arm64-v8a" / "libsaasCorePlayer.so"
            target.parent.mkdir(parents=True)
            target.write_bytes(b"ELF")
            result = build_input_provenance("/tmp/original.apk", "abc", root, target)
            self.assertEqual(result["target_relation"], "WITHIN_ANALYSIS_ROOT")
            self.assertFalse(result["causality_proven"])

    def test_target_outside_analysis_root(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "decoded"
            other = Path(tmp) / "repo"
            root.mkdir()
            other.mkdir()
            target = other / "libsaasCorePlayer.so"
            target.write_bytes(b"ELF")
            result = build_input_provenance("/tmp/original.apk", "abc", root, target)
            self.assertEqual(result["target_relation"], "OUTSIDE_ANALYSIS_ROOT")


if __name__ == "__main__":
    unittest.main(verbosity=2)
