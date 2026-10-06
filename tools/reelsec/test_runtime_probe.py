#!/usr/bin/env python3
import importlib.util
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("reelsec", HERE / "reelsec.py")
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class RuntimeProbeTests(unittest.TestCase):
    def test_adb_parser_accepts_spaces_not_only_tabs(self):
        output = """List of devices attached
192.168.8.8:42025      device product:c2qsqw model:SM_N986U device:c2q transport_id:1
RANDOM unauthorized
offline-device        offline
"""
        records = MODULE.parse_adb_devices(output)
        self.assertEqual(len(records), 1)
        self.assertEqual(records[0]["serial"], "192.168.8.8:42025")
        self.assertEqual(records[0]["state"], "device")
        self.assertEqual(records[0]["attributes"]["model"], "SM_N986U")
        self.assertEqual(records[0]["attributes"]["transport_id"], "1")

    def test_frida_failure_classifies_jailed_android_as_gadget_required(self):
        output = """     ____
Connected to SM N986U (id=192.168.8.8:42025)
Spawning `com.newleaf.app.android.victor`...
Failed to spawn: need Gadget to attach on jailed Android; its default location is: /root/.cache/frida/gadget-android-arm64.so
"""
        status, reason = MODULE.classify_frida_failure(output)
        self.assertEqual(status, "FRIDA_GADGET_REQUIRED")
        self.assertIn("jailed device", reason)

    def test_runtime_client_resolution_prefers_preflight_paths(self):
        with tempfile.TemporaryDirectory() as td:
            base = Path(td)
            adb = base / "adb"
            frida = base / "frida"
            adb.write_text("#!/bin/sh\n", encoding="utf-8")
            frida.write_text("#!/bin/sh\n", encoding="utf-8")

            resolved = MODULE.resolve_runtime_clients({
                "tooling": {
                    "adb_after": str(adb),
                    "frida_after_proot": str(frida),
                }
            })

            self.assertEqual(resolved[0], str(adb))
            self.assertEqual(resolved[1], "preflight.adb_after")
            self.assertEqual(resolved[2], str(frida))
            self.assertEqual(resolved[3], "preflight.frida_after_proot")


if __name__ == "__main__":
    unittest.main()
