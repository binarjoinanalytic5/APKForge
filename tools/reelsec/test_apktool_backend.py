#!/usr/bin/env python3
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

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


    def test_standalone_decode_command(self):
        env = {"tools": {"apktool": {
            "status": "USABLE", "backend": "java-classpath",
            "path": "/usr/bin/java", "version": "2.7.0-dirty",
            "classpath": "/root/apktool/*:/root/java/*"
        }}}
        selection = select_apktool_backend(env)
        from apktool_backend import decode_command
        command = decode_command(selection, "/tmp/original.apk", "/tmp/decoded")
        self.assertEqual(command[:4], ["/usr/bin/java", "-cp", "/root/apktool/*:/root/java/*"])
        self.assertEqual(command[4], "brut.apktool.Main")
        self.assertEqual(command[5], "d")
        self.assertEqual(command[-2:], ["-o", "/tmp/decoded"])

    def test_reject_nonusable_backend(self):
        with self.assertRaises(ApktoolBackendError):
            select_apktool_backend({"tools": {"apktool": {"status": "BROKEN"}}})


if __name__ == "__main__":
    unittest.main(verbosity=2)
