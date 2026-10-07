import tempfile
import unittest
from pathlib import Path

from optional_adapters import run


class OptionalAdaptersTests(unittest.TestCase):
    def test_unknown_adapter_is_rejected(self):
        with tempfile.TemporaryDirectory() as td:
            with self.assertRaises(ValueError):
                run(td, requested="does-not-exist")

    def test_schema_is_read_only(self):
        with tempfile.TemporaryDirectory() as td:
            result = run(td, requested="mobsf,objection")
            self.assertEqual(result["schema_version"], "reelsec-optional-adapters-1")
            self.assertTrue(result["read_only"])
            self.assertFalse(result["causal_proof"])
            self.assertIn("mobsf", result["results"])
            self.assertIn("objection", result["results"])
            # results are keyed exactly by the requested adapter names
            self.assertEqual(sorted(result["results"]), ["mobsf", "objection"])
            self.assertEqual(result["requested"], ["mobsf", "objection"])


if __name__ == "__main__":
    unittest.main()
