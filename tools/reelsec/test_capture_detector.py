#!/usr/bin/env python3
"""Unit tests for the read-only capture protection detector (schema v2).

These are unittest.TestCase classes so `python -m unittest discover` (the CI
runner) actually executes them, with a main() shim for direct execution.
"""
import tempfile
import unittest
from pathlib import Path

from capture_detector import run, to_markdown


class CaptureDetectorTests(unittest.TestCase):
    def _tree(self, files):
        d = tempfile.TemporaryDirectory()
        self.addCleanup(d.cleanup)
        root = Path(d.name)
        for rel, content in files.items():
            p = root / rel
            p.parent.mkdir(parents=True, exist_ok=True)
            if isinstance(content, bytes):
                p.write_bytes(content)
            else:
                p.write_text(content, encoding="utf-8")
        return root

    def test_smali_flag_secure_heuristic_positive(self):
        smali = "\n".join([
            ".method public onCreate(Landroid/os/Bundle;)V",
            "    .locals 2",
            "    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V",
            "    invoke-virtual {p0}, Lcom/x/PlayerActivity;->getWindow()Landroid/view/Window;",
            "    move-result-object v0",
            "    const/16 v1, 0x2000",
            "    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V",
            "    return-void",
            ".end method",
        ])
        root = self._tree({"AndroidManifest.xml": "<manifest/>", "a.smali": smali})
        out = run(root)
        cats = out["category_counts"]
        self.assertIn("FLAG_SECURE", cats)
        heuristic = [
            h for item in out["hits"] for h in item["hits"]
            if h.get("pattern") == "SMALI_0x2000_FLAG_WINDOW"
        ]
        self.assertEqual(len(heuristic), 1)
        self.assertEqual(heuristic[0]["evidence"], "HEURISTIC_WINDOW_MATCH")
        self.assertEqual(out["summary"]["verdict"], "JAVA_LAYER_PROTECTION_INDICATED")

    def test_bare_0x2000_constant_is_not_flag_secure(self):
        smali = "\n".join([
            "    const/16 v15, 0x2000",
            "    invoke-static {v15}, Lcom/google/firebase/Buffer;->alloc(I)V",
        ])
        root = self._tree({"AndroidManifest.xml": "<manifest/>", "a.smali": smali})
        out = run(root)
        self.assertNotIn("FLAG_SECURE", out["category_counts"])
        self.assertEqual(out["summary"]["verdict"], "NONE_FOUND")

    def test_flag_use_outside_window_is_not_flag_secure(self):
        filler = ["    nop"] * 40
        smali = "\n".join(
            ["    const/16 v1, 0x2000"] + filler +
            ["    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V"]
        )
        root = self._tree({"AndroidManifest.xml": "<manifest/>", "a.smali": smali})
        out = run(root)
        self.assertNotIn("FLAG_SECURE", out["category_counts"])

    def test_packer_detection_secshell(self):
        manifest = (
            '<manifest xmlns:android="http://schemas.android.com/apk/res/android">'
            '<application android:name="com.SecShell.SecShell.AW" '
            'android:appComponentFactory="com.SecShell.SecShell.AP"/></manifest>'
        )
        root = self._tree({
            "AndroidManifest.xml": manifest,
            "lib/arm64-v8a/libSecShell.so": b"\x7fELF\x02\x01\x01\x00fake",
        })
        out = run(root)
        packers = {p["packer"] for p in out["packers"]}
        self.assertIn("SecShell", packers)
        self.assertEqual(out["summary"]["verdict"], "PACKED_STATIC_ANALYSIS_LIMITED")
        layers = {m["layer"] for m in out["summary"]["mechanisms"]}
        self.assertIn("PACKER", layers)

    def test_hidden_dex_payload_detected(self):
        payload = b"\x00" * 16 + b"dex\n035\x00" + b"\x00" * 64
        root = self._tree({
            "AndroidManifest.xml": "<manifest/>",
            "assets/payload/data.bin": payload,
        })
        out = run(root)
        self.assertEqual(len(out["hidden_dex"]), 1)
        self.assertEqual(out["hidden_dex"][0]["file"], "assets/payload/data.bin")
        self.assertEqual(out["hidden_dex"][0]["offset"], 16)

    def test_native_string_classification(self):
        so = b"\x7fELF" + b"\x00" * 8
        so += b"Widevine DRM session\x00"
        so += b"GRALLOC_USAGE_PROTECTED\x00"
        so += b"/system/bin/screencap\x00"
        so += b"HW_SECURE_ALL\x00"
        root = self._tree({"AndroidManifest.xml": "<manifest/>", "lib/arm64-v8a/libplayer.so": so})
        out = run(root)
        cats = out["category_counts"]
        self.assertIn("DRM_PROTECTION", cats)
        self.assertIn("PROTECTED_CONTENT", cats)
        self.assertIn("NATIVE_CAPTURE", cats)
        self.assertIn("DRM_SECURITY_LEVEL", cats)
        layers = {m["layer"] for m in out["summary"]["mechanisms"]}
        self.assertIn("DRM", layers)

    def test_report_contract_is_read_only(self):
        root = self._tree({"AndroidManifest.xml": "<manifest/>"})
        out = run(root)
        for key in (
            "schema_version", "files_scanned", "files_with_hits", "category_counts",
            "hits", "causal_proof", "interpretation", "read_only",
        ):
            self.assertIn(key, out)
        self.assertEqual(out["schema_version"], "capture-detection-2")
        self.assertFalse(out["causal_proof"])
        self.assertTrue(out["read_only"])
        self.assertEqual(out["interpretation"], "STATIC_INDICATORS_ONLY")
        md = to_markdown(out)
        self.assertIn(out["summary"]["verdict"], md)


def main():
    unittest.main(module=__name__, argv=[__name__, "-v"], exit=False)
    print("capture_detector: PASS")


if __name__ == "__main__":
    main()
