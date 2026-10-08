import hashlib
import json
import tempfile
import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from instrumented_copy import (
    InstrumentedCopyError,
    apply_text_probe,
    finalize_no_gadget_manifest,
    find_gadget_artifacts,
    prepare_instrumented_copy,
    resolve_instrumentation_mode,
)


AW_SMALI = (
    ".class public Lcom/SecShell/SecShell/AW;\n"
    ".method protected attachBaseContext(Landroid/content/Context;)V\n"
    "    .locals 6\n"
    "    const-string v0, \"SecShell\"\n"
    "    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n"
    "    return-void\n"
    ".end method\n"
)


def _fixture_source(base):
    source = base / "decoded"
    target = source / "smali" / "com" / "SecShell" / "SecShell" / "AW.smali"
    target.parent.mkdir(parents=True)
    target.write_text(AW_SMALI, encoding="utf-8")
    (source / "AndroidManifest.xml").write_text("<manifest/>\n", encoding="utf-8")
    return source, target.relative_to(source)


def _tree_hash(root):
    digest = hashlib.sha256()
    for path in sorted(root.rglob("*")):
        if path.is_file():
            digest.update(str(path.relative_to(root)).encode("utf-8"))
            digest.update(path.read_bytes())
    return digest.hexdigest()


class NoGadgetModeTests(unittest.TestCase):
    def test_mode_defaults_to_standard(self):
        self.assertEqual(resolve_instrumentation_mode({}), "standard")

    def test_mode_accepts_no_gadget_case_insensitive(self):
        self.assertEqual(
            resolve_instrumentation_mode({"REELSEC_INSTRUMENT_MODE": "  No-Gadget "}),
            "no-gadget",
        )

    def test_mode_rejects_unknown_value(self):
        with self.assertRaises(InstrumentedCopyError):
            resolve_instrumentation_mode({"REELSEC_INSTRUMENT_MODE": "no-frida"})

    def test_probe_only_tree_passes_and_keeps_probe(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source, relative_target = _fixture_source(base)
            work = base / "instrumented"
            prepare_instrumented_copy(source, work)
            apply_text_probe(work, work / relative_target)
            self.assertEqual(find_gadget_artifacts(work), [])
            manifest = finalize_no_gadget_manifest(work)
            self.assertEqual(manifest["instrumentation_mode"], "no-gadget")
            self.assertEqual(manifest["experiment"], "INSTRUMENTED_NO_GADGET")
            self.assertIs(manifest["GADGET_PRESENT"], False)
            self.assertIs(manifest["GADGET_SOURCE_ABSENT"], True)
            self.assertIs(manifest["original_apk_untouched"], True)
            self.assertIs(manifest["gadget_enabled"], False)
            self.assertEqual(manifest["causal_attribution"], "REQUIRES_TEMPORAL_COMPARISON")
            types = [m["type"] for m in manifest["mutations"]]
            self.assertIn("LOG_I_PROBE", types)
            self.assertNotIn("FRIDA_GADGET_EMBED", types)
            persisted = json.loads(
                (work / "INSTRUMENTED-COPY-MANIFEST.json").read_text(encoding="utf-8")
            )
            self.assertIs(persisted["GADGET_PRESENT"], False)

    def test_finalize_refuses_gadget_library(self):
        with tempfile.TemporaryDirectory() as tmp:
            work = Path(tmp) / "instrumented"
            lib = work / "lib" / "arm64-v8a"
            lib.mkdir(parents=True)
            (lib / "libfrida-gadget.so").write_bytes(b"fake-gadget")
            (work / "INSTRUMENTED-COPY-MANIFEST.json").write_text(
                json.dumps({"status": "MUTATED", "mutations": []}), encoding="utf-8"
            )
            with self.assertRaises(InstrumentedCopyError):
                finalize_no_gadget_manifest(work)

    def test_finalize_refuses_gadget_config(self):
        with tempfile.TemporaryDirectory() as tmp:
            work = Path(tmp) / "instrumented"
            lib = work / "lib" / "arm64-v8a"
            lib.mkdir(parents=True)
            (lib / "libfrida-gadget.config.so").write_text("{}", encoding="utf-8")
            (work / "INSTRUMENTED-COPY-MANIFEST.json").write_text(
                json.dumps({"status": "MUTATED", "mutations": []}), encoding="utf-8"
            )
            with self.assertRaises(InstrumentedCopyError):
                finalize_no_gadget_manifest(work)

    def test_finalize_refuses_recorded_embed_mutation(self):
        with tempfile.TemporaryDirectory() as tmp:
            work = Path(tmp) / "instrumented"
            work.mkdir()
            (work / "INSTRUMENTED-COPY-MANIFEST.json").write_text(
                json.dumps({
                    "status": "MUTATED",
                    "mutations": [{"type": "FRIDA_GADGET_EMBED"}],
                }),
                encoding="utf-8",
            )
            with self.assertRaises(InstrumentedCopyError):
                finalize_no_gadget_manifest(work)

    def test_finalize_refuses_smali_load_marker(self):
        with tempfile.TemporaryDirectory() as tmp:
            work = Path(tmp) / "instrumented"
            target = work / "smali" / "AW.smali"
            target.parent.mkdir(parents=True)
            target.write_text(
                AW_SMALI + '    const-string v8, "frida-gadget"\n', encoding="utf-8"
            )
            (work / "INSTRUMENTED-COPY-MANIFEST.json").write_text(
                json.dumps({"status": "MUTATED", "mutations": []}), encoding="utf-8"
            )
            with self.assertRaises(InstrumentedCopyError):
                finalize_no_gadget_manifest(work)

    def test_original_source_untouched(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source, relative_target = _fixture_source(base)
            before = _tree_hash(source)
            work = base / "instrumented"
            prepare_instrumented_copy(source, work)
            apply_text_probe(work, work / relative_target)
            finalize_no_gadget_manifest(work)
            self.assertEqual(_tree_hash(source), before)

    def test_requested_gadget_is_recorded_as_refused(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source, relative_target = _fixture_source(base)
            work = base / "instrumented"
            prepare_instrumented_copy(source, work)
            apply_text_probe(work, work / relative_target)
            manifest = finalize_no_gadget_manifest(
                work,
                gadget_requested=True,
                gadget_source_ignored="/tmp/reelsec-gadget/frida-gadget.so",
            )
            self.assertIs(manifest["gadget_refused_by_no_gadget_mode"], True)
            self.assertEqual(
                manifest["gadget_source_ignored"],
                "/tmp/reelsec-gadget/frida-gadget.so",
            )
            self.assertIs(manifest["GADGET_PRESENT"], False)


if __name__ == "__main__":
    unittest.main(verbosity=2)
