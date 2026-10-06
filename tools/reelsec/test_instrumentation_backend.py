import tempfile
import unittest
from pathlib import Path

import sys
sys.path.insert(0, str(Path(__file__).resolve().parent))

from instrumentation_backend import (
    INSTRUMENTATION_BLOCKED,
    INSTRUMENTATION_READY,
    build_observation_command,
    build_termux_preflight,
    plan_secshell_injection,
)


class InstrumentationBackendTests(unittest.TestCase):
    def test_secshell_anchor_plan_is_non_mutating(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            target = root / "smali" / "com" / "SecShell" / "SecShell" / "AW.smali"
            target.parent.mkdir(parents=True)
            target.write_text(
                ".class public Lcom/SecShell/SecShell/AW;\n"
                ".method protected attachBaseContext(Landroid/content/Context;)V\n"
                "    .locals 6\n"
                "    const-string v0, \"SecShell\"\n"
                "    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n"
                "    return-void\n"
                ".end method\n",
                encoding="utf-8",
            )
            result = plan_secshell_injection(root)
            self.assertEqual(result["status"], INSTRUMENTATION_READY)
            self.assertEqual(result["target"], str(target.resolve()))
            self.assertEqual(result["discovery"], "STRUCTURAL_CONTENT")
            self.assertIn("Ljava/lang/System;->loadLibrary", result["loadlibrary_anchor"])
            self.assertFalse(result["runtime_proof"])

    def test_structural_discovery_does_not_require_aw_filename(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            target = root / "smali_classes2" / "x" / "ObfuscatedApplication.smali"
            target.parent.mkdir(parents=True)
            target.write_text(
                ".class public Lx/ObfuscatedApplication;\n"
                ".super Landroid/app/Application;\n"
                ".method protected attachBaseContext(Landroid/content/Context;)V\n"
                "    .locals 2\n"
                "    const-string v0, \"SecShell\"\n"
                "    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n"
                "    return-void\n"
                ".end method\n",
                encoding="utf-8",
            )
            result = plan_secshell_injection(root)
            self.assertEqual(result["status"], INSTRUMENTATION_READY)
            self.assertEqual(result["target"], str(target.resolve()))
            self.assertEqual(result["discovery"], "STRUCTURAL_CONTENT")

    def test_missing_anchor_is_blocked(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            target = root / "AW.smali"
            target.write_text(".class public LAW;\n", encoding="utf-8")
            result = plan_secshell_injection(root)
            self.assertEqual(result["status"], INSTRUMENTATION_BLOCKED)

    def test_termux_preflight_does_not_mutate_original(self):
        result = build_termux_preflight({
            "tools": {
                "adb": {"status": "USABLE"},
                "frida": {"status": "BLOCKED", "classification": "FRIDA_GADGET_REQUIRED"},
            }
        })
        self.assertTrue(result["requires_gadget"])
        self.assertFalse(result["mutates_original_apk"])

    def test_observation_command(self):
        result = build_observation_command("/usr/bin/adb", "com.example.app", "serial")
        self.assertEqual(result["command"][-3:], ["logcat", "-v", "threadtime"])
        self.assertTrue(result["observation_only"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
