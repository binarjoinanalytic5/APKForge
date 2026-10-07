import json
import tempfile
import unittest
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(Path(__file__).resolve().parent))

from gadget_embed import embed_frida_gadget


class GadgetEmbedTests(unittest.TestCase):
    def test_embed_isolated_gadget_and_manifest(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "tree"
            target = root / "smali" / "Application.smali"
            target.parent.mkdir(parents=True)
            original_smali = (
                ".class public LApplication;\n"
                ".method public onCreate()V\n"
                "    .locals 1\n"
                "    const-string v0, \"SecShell\"\n"
                "    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n"
                "    return-void\n"
                ".end method\n"
            )
            target.write_text(original_smali, encoding="utf-8")
            (root / "INSTRUMENTED-COPY-MANIFEST.json").write_text(
                json.dumps({"status":"MUTATED","mutations":[]}) + "\n", encoding="utf-8"
            )
            gadget = Path(tmp) / "libfrida-gadget.so"
            gadget.write_bytes(b"fake-gadget")
            manifest = embed_frida_gadget(root, target, gadget)
            self.assertTrue((root / "lib" / "arm64-v8a" / "libfrida-gadget.so").is_file())
            config_path = root / "lib" / "arm64-v8a" / "libfrida-gadget.config.so"
            self.assertTrue(config_path.is_file())
            config = json.loads(config_path.read_text(encoding="utf-8"))
            self.assertEqual(config["interaction"]["address"], "127.0.0.1")
            self.assertEqual(config["interaction"]["port"], 27042)
            text = target.read_text(encoding="utf-8")
            self.assertIn('loadLibrary(Ljava/lang/String;)V', text)
            self.assertIn('.locals 3', text)
            self.assertIn('const-string v1, "frida-gadget"', text)
            self.assertIn('const-string v1, "ReelSec-Gadget-Load"', text)
            self.assertIn('const-string v2, "loaded"', text)
            self.assertIn('invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I', text)
            self.assertIn("ReelSec-Gadget-Load", text)
            self.assertTrue(any(m["type"] == "FRIDA_GADGET_EMBED" for m in manifest["mutations"]))
            self.assertNotEqual(text, original_smali)


if __name__ == "__main__":
    unittest.main()
