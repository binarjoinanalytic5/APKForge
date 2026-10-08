import json
import struct
import tempfile
import unittest
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(Path(__file__).resolve().parent))

from gadget_embed import embed_frida_gadget


class GadgetEmbedTests(unittest.TestCase):
    def test_native_library_packaging_marks_so_as_uncompressed(self):
        with tempfile.TemporaryDirectory() as tmp:
            work = Path(tmp)
            (work / "apktool.yml").write_text(
                "doNotCompress:\n- arsc\n- jpg\n- png\n", encoding="utf-8"
            )
            # Use the existing minimal fixture helper to exercise the embed path.
            target = work / "AW.smali"
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(
                ".class public LAW;\n.method public static run()V\n"
                "    .locals 1\n"
                "    const-string v0, \"x\"\n"
                "    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n"
                ".end method\n",
                encoding="utf-8",
            )
            (work / "INSTRUMENTED-COPY-MANIFEST.json").write_text(
                '{"schema_version":1}\n', encoding="utf-8"
            )
            gadget = work / "gadget.so"
            gadget.write_bytes(
                b"\x7fELF" + bytes([2,1]) + b"\x00"*12 + (183).to_bytes(2,"little") + b"\x00"*46
            )
            embed_frida_gadget(work, target, gadget)
            self.assertIn("- so", (work / "apktool.yml").read_text(encoding="utf-8"))

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
            header = bytearray(64)
            header[:4] = b"\x7fELF"
            header[4] = 2
            header[5] = 1
            struct.pack_into("<H", header, 18, 183)
            gadget.write_bytes(header + b"test-gadget")
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
