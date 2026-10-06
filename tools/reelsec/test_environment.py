#!/usr/bin/env python3
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from environment import _probe, write_capability_matrix


class EnvironmentResolverTests(unittest.TestCase):
    def test_missing_tool(self):
        result = _probe("demo", [None])
        self.assertEqual(result["status"], "MISSING")

    def test_usable_tool(self):
        with tempfile.TemporaryDirectory() as td:
            tool = Path(td) / "demo"
            tool.write_text("#!/bin/sh\nprintf 'demo 1.2.3\\n'\n", encoding="utf-8")
            tool.chmod(0o755)
            result = _probe("demo", [str(tool)])
            self.assertEqual(result["status"], "USABLE")

    def test_broken_tool(self):
        with tempfile.TemporaryDirectory() as td:
            tool = Path(td) / "demo"
            tool.write_text("#!/bin/sh\nexit 7\n", encoding="utf-8")
            tool.chmod(0o755)
            result = _probe("demo", [str(tool)])
            self.assertEqual(result["status"], "BROKEN")

    def test_matrix_does_not_install(self):
        with patch("environment._tool", return_value=None):
            with tempfile.TemporaryDirectory() as td:
                result = write_capability_matrix(td, Path.cwd())
                self.assertTrue(result["policy"]["resolver_does_not_install"])
                self.assertTrue((Path(td) / "CAPABILITY-MATRIX.json").is_file())
                self.assertTrue((Path(td) / "CAPABILITY-MATRIX.md").is_file())


if __name__ == "__main__":
    unittest.main(verbosity=2)
