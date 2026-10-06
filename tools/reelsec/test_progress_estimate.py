#!/usr/bin/env python3
import importlib.util
import tempfile
import unittest
import zipfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("reelsec", HERE / "reelsec.py")
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class ProgressEstimateTests(unittest.TestCase):
    def test_baksmali_progress_uses_decoded_class_ratio(self):
        with tempfile.TemporaryDirectory() as td:
            root = Path(td)
            apk = root / "original.apk"
            decoded = root / "decoded"
            decoded.mkdir()
            smali = decoded / "smali" / "x"
            smali.mkdir(parents=True)

            dex = bytearray(0x64)
            dex[:3] = b"dex"
            dex[0x60:0x64] = (100).to_bytes(4, "little")
            with zipfile.ZipFile(apk, "w") as zf:
                zf.writestr("classes.dex", bytes(dex))

            for i in range(50):
                (smali / ("C%d.smali" % i)).write_text(".class public C%d\n" % i)

            log = root / "apktool.log"
            log.write_text("I: Baksmaling classes.dex...\n", encoding="utf-8")

            probe = MODULE._apktool_progress(
                log, decoded, apk, total_classes=100, elapsed=10
            )

            self.assertEqual(probe["phase"], "BAKSMALI")
            self.assertEqual(probe["percent"], 59.0)
            self.assertEqual(probe["detail"], "baksmali 50/100 classes")
            self.assertIsNotNone(probe["eta_seconds"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
