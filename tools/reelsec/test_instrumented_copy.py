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
                "invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n"
            )
            target.write_text(original, encoding="utf-8")
            (source / "AndroidManifest.xml").write_text("<manifest/>\n", encoding="utf-8")
            work = base / "instrumented"

            manifest = prepare_instrumented_copy(source, work)
            self.assertEqual(manifest["status"], "COPIED")
            apply_text_probe(work, work / target.relative_to(source) )
            self.assertEqual(target.read_text(encoding="utf-8"), original)
            self.assertIn("ReelSec-Instrumentation", (work / target.relative_to(source)).read_text(encoding="utf-8"))

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
