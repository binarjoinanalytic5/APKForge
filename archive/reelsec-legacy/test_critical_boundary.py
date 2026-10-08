#!/usr/bin/env python3
"""Regression tests for ReelSec ARM64 critical-function boundary extraction."""

import importlib.util
import tempfile
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[2]
SPEC = importlib.util.spec_from_file_location("reelsec", ROOT / "tools/reelsec" / "reelsec.py")
reelsec = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(reelsec)


class CriticalBoundaryTests(unittest.TestCase):
    def test_stops_at_ret_with_objdump_spacing(self):
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            (out / "CRITICAL-FUNCTION-0x27A510.txt").write_text(
                "27a510: stp x29, x30, [sp, #-0x20]!\n"
                "27a514: mov x29, sp\n"
                "27a538: ldp x29, x30, [sp], #0x20\n"
                "27a540: d65f03c0     ret\n"
                "27a544: bl __stack_chk_fail@plt\n",
                encoding="utf-8",
            )
            reelsec.write_critical_behavior(out, 0x27A510)
            # The extracted body (bounded at the first RET) is published in
            # CRITICAL-FUNCTION-BODY.txt; the behavior report summarizes it.
            body = (out / "CRITICAL-FUNCTION-BODY.txt").read_text(encoding="utf-8")
            self.assertIn("27a540: d65f03c0     ret", body)
            self.assertNotIn("27a544", body)
            self.assertNotIn("__stack_chk_fail", body)

    def test_vtable_object_proof_accepts_objdump_tabs(self):
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            (out / "ActiveDecoder-constructor.txt").write_text(
                "278450: 97f99de0     \tbl\t0xdfbd0 <_ZN13ActiveDecoderC2Ev@plt>\n"
                "278454: f00024e8     \tadrp\tx8, 0x717000 <_ZTVN6Cicada12avAESEncryptE+0x730>\n"
                "278458: 91394108     \tadd\tx8, x8, #0xe50\n"
                "27846c: 91004109     \tadd\tx9, x8, #0x10\n"
                "27847c: f9000269     \tstr\tx9, [x19]\n",
                encoding="utf-8",
            )
            self.assertTrue(reelsec.write_vtable_object_proof(out))
            proof = (out / "VTABLE-OBJECT-PROOF.md").read_text(encoding="utf-8")
            self.assertIn("RESULT: PROVEN_OBJECT_VPTR_TO_0x717E60", proof)

    def test_rejects_non_ret_terminated_body(self):
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            (out / "CRITICAL-FUNCTION-0x27A510.txt").write_text(
                "27a510: stp x29, x30, [sp, #-0x20]!\n"
                "27a514: mov x29, sp\n",
                encoding="utf-8",
            )
            with self.assertRaises(RuntimeError):
                reelsec.write_critical_behavior(out, 0x27A510)

    def test_autonomous_dataflow_proves_direct_target_slot(self):
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            (out / "full-disassembly.txt").write_text(
                "1000 <ctor>:\n"
                "1000: ret\n"
                "2000 <caller>:\n"
                "2000: adrp x8, 0x717000\n"
                "2004: add x8, x8, #0xe60\n"
                "2008: ldr x8, [x8, #0x108]\n"
                "200c: blr x8\n"
                "2010: ret\n",
                encoding="utf-8",
            )
            (out / "ActiveDecoder-constructor.txt").write_text(
                "1000 <ctor>:\n1000: ret\n", encoding="utf-8"
            )
            result = reelsec.write_autonomous_dataflow(out, object(), "objdump")
            self.assertEqual(result["proven"], 1)
            report = (out / "AUTONOMOUS-DATAFLOW.md").read_text(encoding="utf-8")
            self.assertIn("PROVEN_TARGET_VTABLE_DATAFLOW_FOUND", report)

    def test_autonomous_dataflow_does_not_promote_x19_alone(self):
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            (out / "full-disassembly.txt").write_text(
                "2000 <caller>:\n"
                "2000: ldr x8, [x19]\n"
                "2004: ldr x8, [x8, #0x108]\n"
                "2008: blr x8\n"
                "200c: ret\n",
                encoding="utf-8",
            )
            (out / "ActiveDecoder-constructor.txt").write_text(
                "1000 <ctor>:\n1000: ret\n", encoding="utf-8"
            )
            result = reelsec.write_autonomous_dataflow(out, object(), "objdump")
            self.assertEqual(result["proven"], 0)
            self.assertEqual(result["cxx_unresolved"], 1)


if __name__ == "__main__":
    unittest.main()
