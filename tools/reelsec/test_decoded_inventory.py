#!/usr/bin/env python3
import tempfile
import unittest
from pathlib import Path

import sys
sys.path.insert(0, str(Path(__file__).resolve().parent))

from reelsec import (
    _decoded_manifest_version_code,
    inventory_decoded_apk,
    resolve_test_package,
)


class DecodedInventoryTests(unittest.TestCase):
    def test_ready_inventory(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "decoded"
            (root / "smali" / "com" / "example").mkdir(parents=True)
            (root / "lib" / "arm64-v8a").mkdir(parents=True)
            (root / "AndroidManifest.xml").write_text("<manifest/>", encoding="utf-8")
            (root / "smali" / "com" / "example" / "Main.smali").write_text(".class public Lcom/example/Main;\n", encoding="utf-8")
            (root / "lib" / "arm64-v8a" / "libx.so").write_bytes(b"ELF")
            result = inventory_decoded_apk(root)
            self.assertEqual(result["status"], "READY")
            self.assertEqual(result["smali_file_count"], 1)
            self.assertEqual(result["native_library_count"], 1)
            self.assertEqual(result["dex_count"], 0)
            self.assertTrue((root.parent / "DECODED-INPUT-INVENTORY.json").is_file())

    def test_multidex_smali_root(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "decoded"
            (root / "smali_classes2").mkdir(parents=True)
            (root / "AndroidManifest.xml").write_text("<manifest/>", encoding="utf-8")
            (root / "smali_classes2" / "A.smali").write_text(".class public LA;\n", encoding="utf-8")
            result = inventory_decoded_apk(root)
            self.assertEqual(result["status"], "READY")
            self.assertEqual(result["smali_file_count"], 1)


class ResolveTestPackageTests(unittest.TestCase):
    def test_explicit_env_wins(self):
        result = resolve_test_package({"REELSEC_TEST_PACKAGE": "com.explicit"})
        self.assertEqual(result["package"], "com.explicit")
        self.assertEqual(result["source"], "EXPLICIT_ENV")

    def test_decoded_manifest_fallback(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "decoded"
            root.mkdir()
            (root / "AndroidManifest.xml").write_text(
                '<manifest package="com.from.manifest" '
                'android:versionCode="4200" />\n', encoding="utf-8")
            result = resolve_test_package({}, decoded_root=root)
            self.assertEqual(result["package"], "com.from.manifest")
            self.assertEqual(result["source"], "DECODED_MANIFEST")

    def test_unresolved_package_records_reason(self):
        result = resolve_test_package({}, decoded_root="/no/such/root")
        self.assertIsNone(result["package"])
        self.assertIn("refusing to touch any package", result["reason"])

    def test_decoded_manifest_version_code(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "decoded"
            root.mkdir()
            (root / "AndroidManifest.xml").write_text(
                '<manifest android:versionCode="4200" />\n', encoding="utf-8")
            self.assertEqual(_decoded_manifest_version_code(root), 4200)
            self.assertIsNone(_decoded_manifest_version_code("/no/such/root"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
