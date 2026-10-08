import tempfile
import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from instrumented_copy import (
    InstrumentedCopyError,
    apply_text_probe,
    prepare_instrumented_copy,
)


class InstrumentedCopyTests(unittest.TestCase):
    def test_copy_and_mutate_without_touching_source(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "decoded"
            target = source / "smali" / "com" / "SecShell" / "SecShell" / "AW.smali"
            target.parent.mkdir(parents=True)
            original = (
                ".class public Lcom/SecShell/SecShell/AW;\n"
                ".method public attachBaseContext(Landroid/content/Context;)V\n"
                "    .registers 2\n"
                "    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n"
                "    return-void\n"
                ".end method\n"
            )
            target.write_text(original, encoding="utf-8")
            (source / "AndroidManifest.xml").write_text("<manifest/>\n", encoding="utf-8")
            work = base / "instrumented"

            manifest = prepare_instrumented_copy(source, work)
            self.assertEqual(manifest["status"], "COPIED")
            apply_text_probe(work, work / target.relative_to(source) )
            self.assertEqual(target.read_text(encoding="utf-8"), original)
            self.assertIn("ReelSec-Instrumentation", (work / target.relative_to(source)).read_text(encoding="utf-8"))

    def test_probe_reserves_registers_in_containing_method_only(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            work = base / "instrumented"
            target = work / "smali" / "com" / "SecShell" / "SecShell" / "AW.smali"
            target.parent.mkdir(parents=True)
            target.write_text(
                ".class public Lcom/SecShell/SecShell/AW;\n"
                ".method public first()V\n"
                "    .locals 2\n"
                "    return-void\n"
                ".end method\n"
                ".method protected attachBaseContext(Landroid/content/Context;)V\n"
                "    .locals 6\n"
                "    const-string v0, \"SecShell\"\n"
                "    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n"
                "    return-void\n"
                ".end method\n",
                encoding="utf-8",
            )
            (work / "AndroidManifest.xml").write_text("<manifest/>\n", encoding="utf-8")
            manifest = {
                "status": "COPIED",
                "mutations": [],
            }
            (work / "INSTRUMENTED-COPY-MANIFEST.json").write_text(
                __import__("json").dumps(manifest),
                encoding="utf-8",
            )
            result = apply_text_probe(work, target)
            updated = target.read_text(encoding="utf-8")
            self.assertEqual(result["status"], "MUTATED")
            self.assertIn(".method public first()V\n    .locals 2", updated)
            self.assertIn(".method protected attachBaseContext(Landroid/content/Context;)V\n    .locals 8", updated)
            self.assertIn('const-string v6, "ReelSec-Instrumentation"', updated)
            self.assertIn('const-string v7, "SecShell loadLibrary reached"', updated)
    def test_refuses_existing_work_tree(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "decoded"
            source.mkdir()
            work = base / "instrumented"
            work.mkdir()
            with self.assertRaises(InstrumentedCopyError):
                prepare_instrumented_copy(source, work)

    def test_refuses_target_outside_work_tree(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "decoded"
            source.mkdir()
            work = base / "instrumented"
            prepare_instrumented_copy(source, work)
            external = base / "AW.smali"
            external.write_text("x", encoding="utf-8")
            with self.assertRaises(InstrumentedCopyError):
                apply_text_probe(work, external)


if __name__ == "__main__":
    unittest.main(verbosity=2)
