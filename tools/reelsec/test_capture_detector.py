#!/usr/bin/env python3
"""Unit tests for the read-only capture protection detector (schema v3).

These are unittest.TestCase classes so `python -m unittest discover` (the CI
runner) actually executes them, with a main() shim for direct execution.
"""
import io
import struct
import tempfile
import unittest
import zipfile
from pathlib import Path

from capture_detector import elf_dynamic_symbols, classify_symbols, run, to_markdown


def build_elf64_with_symbols(names):
    """Minimal ELF64 fixture with a .dynsym containing the given names."""
    dynstr = b"\x00" + b"".join(n.encode() + b"\x00" for n in names)
    name_offsets = []
    off = 1
    for n in names:
        name_offsets.append(off)
        off += len(n) + 1
    dynsym = b"\x00" * 24  # null symbol
    for no in name_offsets:
        st_info = (1 << 4) | 2  # STB_GLOBAL, STT_FUNC
        dynsym += struct.pack("<IBBHQQ", no, st_info, 0, 1, 0x1000, 0x10)
    ehsize = 64
    dynstr_off = ehsize
    dynsym_off = dynstr_off + len(dynstr)
    dynsym_off = (dynsym_off + 7) & ~7
    shoff = dynsym_off + len(dynsym)
    shoff = (shoff + 7) & ~7
    hdr = bytearray(64)
    hdr[0:4] = b"\x7fELF"
    hdr[4] = 2  # ELFCLASS64
    hdr[5] = 1  # ELFDATA2LSB
    hdr[6] = 1  # EV_CURRENT
    struct.pack_into("<HHIQQQIHHHHHH", hdr, 16,
                     3, 0xB7, 1, 0, 0, shoff, 0, ehsize, 0, 0, 64, 3, 0)
    shdrs = b"\x00" * 64  # null section
    # .dynsym: name=0 type=11 flags=2 addr=0 offset size link=2 info=1 align=8 entsize=24
    shdrs += struct.pack("<IIQQQQIIQQ", 0, 11, 2, 0, dynsym_off, len(dynsym), 2, 1, 8, 24)
    # .dynstr: type=3
    shdrs += struct.pack("<IIQQQQIIQQ", 0, 3, 2, 0, dynstr_off, len(dynstr), 0, 0, 1, 0)
    pad1 = b"\x00" * (dynsym_off - dynstr_off - len(dynstr))
    pad2 = b"\x00" * (shoff - dynsym_off - len(dynsym))
    return bytes(hdr) + dynstr + pad1 + dynsym + pad2 + shdrs


FLAG_SMALI = "\n".join([
    ".method public onCreate(Landroid/os/Bundle;)V",
    "    invoke-virtual {p0}, Lcom/x/PlayerActivity;->getWindow()Landroid/view/Window;",
    "    move-result-object v0",
    "    const/16 v1, 0x2000",
    "    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V",
    "    return-void",
    ".end method",
])


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
        root = self._tree({"AndroidManifest.xml": "<manifest/>", "a.smali": FLAG_SMALI})
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

    def test_third_party_noise_is_flagged_unrelated(self):
        root = self._tree({
            "AndroidManifest.xml": "<manifest/>",
            "smali/com/google/firebase/x.smali": FLAG_SMALI,
            "smali/com/app/own/y.smali": FLAG_SMALI,
        })
        out = run(root)
        fb = next(i for i in out["hits"] if "firebase" in i["file"])
        own = next(i for i in out["hits"] if "com/app/own" in i["file"])
        self.assertTrue(all(h.get("noise") for h in fb["hits"]))
        self.assertTrue(any(not h.get("noise") for h in own["hits"]))
        self.assertGreaterEqual(out["noise_hits"], 1)
        # noise hits are excluded from category counts
        flag_hits = [h for i in out["hits"] for h in i["hits"]
                     if h["category"] == "FLAG_SECURE" and not h.get("noise")]
        self.assertEqual(out["category_counts"]["FLAG_SECURE"], len(flag_hits))

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

    def test_elf_dynsym_extraction_and_classification(self):
        data = build_elf64_with_symbols([
            "Java_com_x_Player_nativeOnCaptureScreen",
            "av_free",
        ])
        syms = elf_dynamic_symbols(data)
        names = {s["name"] for s in syms}
        self.assertIn("Java_com_x_Player_nativeOnCaptureScreen", names)
        self.assertIn("av_free", names)
        hits = classify_symbols(syms)
        self.assertTrue(any(h["string"] == "Java_com_x_Player_nativeOnCaptureScreen"
                            and h["category"] == "NATIVE_SYMBOLS" for h in hits))
        self.assertFalse(any(h["string"] == "av_free" for h in hits))

    def test_apk_container_mode(self):
        d = tempfile.TemporaryDirectory()
        self.addCleanup(d.cleanup)
        apk = Path(d.name) / "test.apk"
        manifest_blob = (
            b"\x03\x00\x08\x00" +
            "com.SecShell.SecShell.AW".encode("utf-16-le") + b"\x00\x00"
        )
        player = b"\x7fELF\x02\x01\x01\x00" + b"Widevine session\x00" + b"screencap\x00"
        packed = b"\x00" * 16 + b"dex\n035\x00" + b"\x00" * 32
        normal_dex = b"dex\n035\x00" + b"\x00" * 32
        buf = io.BytesIO()
        with zipfile.ZipFile(buf, "w") as zf:
            zf.writestr("AndroidManifest.xml", manifest_blob)
            zf.writestr("lib/arm64-v8a/libSecShell.so", b"\x7fELF\x02\x01\x01\x00stub")
            zf.writestr("lib/arm64-v8a/libplayer.so", player)
            zf.writestr("assets/payload.dat", packed)
            zf.writestr("classes.dex", normal_dex)
        apk.write_bytes(buf.getvalue())
        out = run(apk)
        self.assertEqual(out["input_mode"], "apk_container")
        self.assertTrue(out["input_sha256"])
        self.assertEqual(out["schema_version"], "capture-detection-3")
        self.assertIn("SecShell", {p["packer"] for p in out["packers"]})
        ev = out["packers"][0]["evidence"]
        self.assertTrue(any(e.startswith("binary_manifest:") for e in ev))
        self.assertTrue(any(e.startswith("native_lib:") for e in ev))
        hd = {h["file"] for h in out["hidden_dex"]}
        self.assertIn("assets/payload.dat", hd)
        self.assertNotIn("classes.dex", hd)
        cats = out["category_counts"]
        self.assertIn("DRM_PROTECTION", cats)
        self.assertIn("NATIVE_CAPTURE", cats)

    def test_report_contract_is_read_only(self):
        root = self._tree({"AndroidManifest.xml": "<manifest/>"})
        out = run(root)
        for key in (
            "schema_version", "files_scanned", "files_with_hits", "category_counts",
            "hits", "causal_proof", "interpretation", "read_only", "evidence_policy",
        ):
            self.assertIn(key, out)
        self.assertEqual(out["schema_version"], "capture-detection-3")
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
