#!/usr/bin/env python3
import importlib.util
import stat
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("reelsec", HERE / "reelsec.py")
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class CampaignOrchestrationTests(unittest.TestCase):
    def _fake_apktool(self, root):
        tool = root / "fake-apktool"
        tool.write_text(
            "#!/usr/bin/env python3\n"
            "import pathlib,sys\n"
            "args=sys.argv\n"
            "out=pathlib.Path(args[args.index('-o')+1])\n"
            "out.mkdir(parents=True, exist_ok=False)\n"
            "(out/'AndroidManifest.xml').write_text('<manifest package="example.test"/>')\n"
            "(out/'smali').mkdir()\n",
            encoding="utf-8",
        )
        tool.chmod(tool.stat().st_mode | stat.S_IXUSR)
        return tool

    def test_decode_does_not_precreate_apktool_output(self):
        with tempfile.TemporaryDirectory() as td:
            root = Path(td)
            apk = root / "original.apk"
            apk.write_bytes(b"fake-apk")
            tool = self._fake_apktool(root)
            output = root / "decoded"

            result = MODULE.run_apktool_decode(
                {"backend": "cli", "path": str(tool)},
                apk,
                output,
                timeout=10,
            )

            self.assertEqual(result["status"], "DECODED")
            self.assertTrue((output / "AndroidManifest.xml").is_file())
            self.assertTrue((output / "smali").is_dir())
            self.assertTrue((output / "reelsec-apktool.log").is_file())

    def test_decode_recovers_with_no_resources_after_full_decode_failure(self):
        with tempfile.TemporaryDirectory() as td:
            root = Path(td)
            apk = root / "original.apk"
            apk.write_bytes(b"fake-apk")
            tool = root / "fake-apktool-recovery"
            tool.write_text(
                "#!/usr/bin/env python3\n"
                "import pathlib,sys\n"
                "args=sys.argv\n"
                "if '-r' not in args:\n"
                "    raise SystemExit(9)\n"
                "out=pathlib.Path(args[args.index('-o')+1])\n"
                "out.mkdir(parents=True, exist_ok=False)\n"
                "(out/'AndroidManifest.xml').write_text('<manifest package=\\"example.test\\"/>')\n"
                "(out/'smali').mkdir()\n"
                "(out/'smali'/'Example.smali').write_text('.class public LExample;')\n",
                encoding="utf-8",
            )
            tool.chmod(tool.stat().st_mode | stat.S_IXUSR)
            output = root / "decoded"

            result = MODULE.run_apktool_decode(
                {"backend": "cli", "path": str(tool)},
                apk,
                output,
                timeout=10,
            )

            self.assertEqual(result["status"], "DECODED_NO_RES")
            self.assertEqual(result["mode"], "APKTOOL_NO_RES")
            self.assertTrue(result["instrumentable_smali"])
            recovery = root / "decoded-no-res"
            self.assertTrue((recovery / "AndroidManifest.xml").is_file())
            self.assertTrue((recovery / "smali" / "Example.smali").is_file())

    def test_decode_no_res_is_accepted_as_campaign_analysis_root(self):
        inventory = {
            "status": "READY",
            "root": "/tmp/reelsec-no-res",
            "decode_mode": "APKTOOL_NO_RES",
            "resources_decoded": False,
        }
        self.assertIn(inventory["status"], ("READY", "READY_NATIVE_ONLY"))
        self.assertEqual(inventory["decode_mode"], "APKTOOL_NO_RES")

    def test_decode_refuses_nonempty_existing_output(self):
        with tempfile.TemporaryDirectory() as td:
            root = Path(td)
            apk = root / "original.apk"
            apk.write_bytes(b"fake-apk")
            tool = self._fake_apktool(root)
            output = root / "decoded"
            output.mkdir()
            sentinel = output / "sentinel.txt"
            sentinel.write_text("preserve", encoding="utf-8")

            result = MODULE.run_apktool_decode(
                {"backend": "cli", "path": str(tool)},
                apk,
                output,
                timeout=10,
            )

            self.assertEqual(result["status"], "FAILED_OUTPUT_EXISTS")
            self.assertEqual(sentinel.read_text(encoding="utf-8"), "preserve")


if __name__ == "__main__":
    unittest.main(verbosity=2)
