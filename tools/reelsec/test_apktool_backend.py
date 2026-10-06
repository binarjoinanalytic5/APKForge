#!/usr/bin/env python3
import unittest

from apktool_backend import ApktoolBackendError, select_apktool_backend


class ApktoolBackendTests(unittest.TestCase):
    def test_select_cli_backend(self):
        env = {"tools": {"apktool": {
            "status": "USABLE", "backend": "cli",
            "path": "/usr/bin/apktool", "version": "2.7.0"
        }}}
        result = select_apktool_backend(env)
        self.assertEqual(result["status"], "SELECTED")
        self.assertEqual(result["backend"], "cli")

    def test_select_standalone_backend(self):
        env = {"tools": {"apktool": {
            "status": "USABLE", "backend": "java-classpath",
            "path": "/usr/bin/java", "version": "2.7.0-dirty"
        }}}
        result = select_apktool_backend(env)
        self.assertEqual(result["name"], "apktool-standalone")
        self.assertEqual(result["backend"], "java-classpath")

    def test_reject_nonusable_backend(self):
        with self.assertRaises(ApktoolBackendError):
            select_apktool_backend({"tools": {"apktool": {"status": "BROKEN"}}})


if __name__ == "__main__":
    unittest.main(verbosity=2)
