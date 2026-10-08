#!/usr/bin/env python3
"""Tests for byte-level artifact anatomy (artifact_diff).

Inventories must describe real ZIP bytes (entries, sections, digests,
signing-block span); diffs must separate content changes from signing
churn and queue only changed sections for narrowing. Missing or
invalid inputs raise — anatomy is never invented.
"""
import hashlib
import struct
import tempfile
import unittest
import zipfile
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from artifact_diff import (
    ArtifactDiffError,
    classify_entry,
    diff_inventories,
    diff_pairs,
    inventory_artifact,
    locate_signing_block,
)


def _write_zip(path, entries):
    with zipfile.ZipFile(path, "w") as archive:
        for name, data, ctype in entries:
            archive.writestr(name, data, compress_type=ctype)
    return str(path)


STORED = zipfile.ZIP_STORED
DEFLATED = zipfile.ZIP_DEFLATED

BASE_ENTRIES = (
    ("AndroidManifest.xml", b"<manifest/>", DEFLATED),
    ("classes.dex", b"dex-bytes", DEFLATED),
    ("lib/arm64-v8a/libx.so", b"so-bytes", STORED),
    ("resources.arsc", b"res", DEFLATED),
    ("res/values/strings.xml", b"<s/>", DEFLATED),
    ("META-INF/MANIFEST.MF", b"mf", DEFLATED),
    ("kotlin/collections.kt", b"kt", DEFLATED),
)


class ClassifyTests(unittest.TestCase):
    def test_sections(self):
        cases = {
            "AndroidManifest.xml": "MANIFEST",
            "classes.dex": "DEX",
            "classes2.dex": "DEX",
            "lib/arm64-v8a/a.so": "NATIVE_LIBS",
            "resources.arsc": "RESOURCES",
            "res/layout/x.xml": "RESOURCES",
            "assets/y.bin": "RESOURCES",
            "META-INF/CERT.RSA": "META_INF",
            "kotlin/x": "OTHER",
            "dex/classes.dex": "OTHER",
        }
        for name, section in cases.items():
            self.assertEqual(classify_entry(name), section, name)


class InventoryTests(unittest.TestCase):
    def setUp(self):
        self.td = tempfile.TemporaryDirectory()
        self.root = Path(self.td.name)

    def tearDown(self):
        self.td.cleanup()

    def test_inventory_describes_zip(self):
        path = _write_zip(self.root / "a.apk", BASE_ENTRIES)
        inventory = inventory_artifact(path)
        self.assertEqual(inventory["schema_version"],
                         "artifact-inventory-1")
        self.assertEqual(inventory["entry_count"], len(BASE_ENTRIES))
        self.assertEqual(inventory["sha256"],
                         hashlib.sha256(
                             Path(path).read_bytes()).hexdigest())
        sections = inventory["sections"]
        self.assertEqual(sections["MANIFEST"]["entries"], 1)
        self.assertEqual(sections["DEX"]["entries"], 1)
        self.assertEqual(sections["NATIVE_LIBS"]["entries"], 1)
        self.assertEqual(sections["RESOURCES"]["entries"], 2)
        self.assertEqual(sections["META_INF"]["entries"], 1)
        self.assertEqual(sections["OTHER"]["entries"], 1)
        entry = inventory["entries"]["lib/arm64-v8a/libx.so"]
        self.assertEqual(entry["compress_type"], STORED)
        self.assertRegex(entry["crc32"], r"^[0-9a-f]{8}$")
        self.assertEqual(entry["section"], "NATIVE_LIBS")
        self.assertIsNone(inventory["signing_block"])

    def test_missing_and_bad_inputs_raise(self):
        with self.assertRaises(ArtifactDiffError):
            inventory_artifact(str(self.root / "nope.apk"))
        bad = self.root / "bad.apk"
        bad.write_bytes(b"not-a-zip")
        with self.assertRaises(ArtifactDiffError):
            inventory_artifact(str(bad))

    def test_signing_block_located(self):
        magic = b"APK Sig Block 42"
        inner = 32
        block = (struct.pack("<Q", inner) + b"\0" * (inner - 24)
                 + struct.pack("<Q16s", inner, magic))
        body = b"Z" * 64 + block
        cd_offset = len(body)
        eocd = (b"PK\x05\x06"
                + struct.pack("<HHHHIIH", 0, 0, 0, 0, 0, cd_offset, 0))
        path = self.root / "signed.apk"
        path.write_bytes(body + eocd)
        span = locate_signing_block(str(path))
        self.assertEqual(span, {"offset": 64, "size": inner + 8})

    def test_signing_block_absent_returns_none(self):
        path = _write_zip(self.root / "plain.apk", BASE_ENTRIES)
        self.assertIsNone(locate_signing_block(path))
        garbage = self.root / "garbage.apk"
        garbage.write_bytes(b"\0" * 100)
        self.assertIsNone(locate_signing_block(str(garbage)))


class DiffTests(unittest.TestCase):
    def setUp(self):
        self.td = tempfile.TemporaryDirectory()
        self.root = Path(self.td.name)

    def tearDown(self):
        self.td.cleanup()

    def _inventory(self, name, entries):
        return inventory_artifact(
            _write_zip(self.root / name, entries))

    def test_identical_short_circuits(self):
        first = self._inventory("a.apk", BASE_ENTRIES)
        second = self._inventory("b.apk", BASE_ENTRIES)
        # Same content, same order: identical bytes.
        if first["sha256"] != second["sha256"]:
            self.skipTest("zip writer nondeterminism")
        doc = diff_inventories(first, second, pair="A→B1")
        self.assertEqual(doc["verdict"], "IDENTICAL")
        self.assertEqual(doc["changed_entry_count"], 0)
        self.assertEqual(doc["narrowing_queue"], [])

    def test_content_change_queues_sections(self):
        first = self._inventory("a.apk", BASE_ENTRIES)
        changed = [list(row) for row in BASE_ENTRIES]
        changed[1][1] = b"dex-CHANGED"
        second = self._inventory("b.apk", [tuple(row) for row in changed])
        doc = diff_inventories(first, second, pair="A→B1")
        self.assertEqual(doc["verdict"], "CONTENT_CHANGED")
        kinds = [record["change"] for record in doc["changed_entries"]]
        self.assertEqual(kinds.count("ENTRY_CHANGED"), 1)
        # Followers shift behind the resized entry: layout fallout.
        self.assertEqual(kinds.count("OFFSET_ONLY"),
                         len(kinds) - 1)
        change = [record for record in doc["changed_entries"]
                  if record["change"] == "ENTRY_CHANGED"][0]
        self.assertEqual(change["name"], "classes.dex")
        self.assertIn("crc", change["details"])
        self.assertEqual(doc["content_change_count"], 1)
        self.assertEqual(doc["narrowing_queue"], ["DEX"])

    def test_meta_inf_only_is_signing_churn(self):
        first = self._inventory("a.apk", BASE_ENTRIES)
        changed = [list(row) for row in BASE_ENTRIES]
        changed[5][1] = b"mf-resigned"
        second = self._inventory("b.apk", [tuple(row) for row in changed])
        doc = diff_inventories(first, second, pair="A→B1")
        self.assertEqual(doc["verdict"], "SIGNING_CHURN_ONLY")
        self.assertEqual(doc["content_change_count"], 0)
        self.assertEqual(doc["narrowing_queue"], [])
        churn = doc["signing_churn"]
        self.assertEqual(len(churn["meta_inf_changes"]), 1)
        self.assertFalse(churn["signing_block_changed"])
        # The entry behind the rewritten META-INF shifts: churn
        # fallout stays out of the verdict and the queue.
        self.assertEqual(doc["changed_entry_count"], 2)
        self.assertEqual(doc["layout_change_count"], 1)

    def test_added_and_removed_entries(self):
        first = self._inventory("a.apk", BASE_ENTRIES)
        trimmed = tuple(row for row in BASE_ENTRIES
                        if row[0] != "kotlin/collections.kt")
        added = trimmed + (("lib/x.so", b"new", STORED),)
        doc = diff_inventories(
            first, self._inventory("b.apk", added), pair="A→B1")
        kinds = {record["name"]: record["change"]
                 for record in doc["changed_entries"]}
        self.assertEqual(kinds["kotlin/collections.kt"], "REMOVED")
        self.assertEqual(kinds["lib/x.so"], "ADDED")
        self.assertEqual(doc["verdict"], "CONTENT_CHANGED")

    def test_reordered_entries_flag_offset_only(self):
        first = self._inventory("a.apk", BASE_ENTRIES)
        second = self._inventory("b.apk", tuple(reversed(BASE_ENTRIES)))
        doc = diff_inventories(first, second, pair="A→B1")
        self.assertEqual(doc["verdict"], "LAYOUT_ONLY")
        self.assertTrue(doc["changed_entries"])
        for record in doc["changed_entries"]:
            self.assertEqual(record["change"], "OFFSET_ONLY")
            self.assertIn("offset", record["details"])
        self.assertEqual(doc["content_change_count"], 0)
        self.assertEqual(doc["narrowing_queue"],
                         ["NATIVE_LIBS", "DEX", "MANIFEST", "RESOURCES",
                          "OTHER"])

    def test_compression_change_flagged(self):
        first = self._inventory("a.apk", BASE_ENTRIES)
        changed = [list(row) for row in BASE_ENTRIES]
        changed[2][2] = DEFLATED
        second = self._inventory("b.apk", [tuple(row) for row in changed])
        doc = diff_inventories(first, second, pair="A→B1")
        change = [record for record in doc["changed_entries"]
                  if record["name"] == "lib/arm64-v8a/libx.so"][0]
        self.assertEqual(change["change"], "ENTRY_CHANGED")
        self.assertIn("compression", change["details"])

    def test_signing_block_change_flagged(self):
        first = self._inventory("a.apk", BASE_ENTRIES)
        second = dict(first)
        second["entries"] = dict(first["entries"])
        second["signing_block"] = {"offset": 10, "size": 40}
        doc = diff_inventories(first, second, pair="A→B1")
        self.assertTrue(doc["signing_churn"]["signing_block_changed"])

    def test_invalid_inventories_rejected(self):
        good = self._inventory("a.apk", BASE_ENTRIES)
        with self.assertRaises(ArtifactDiffError):
            diff_inventories({}, good, pair="A→B1")
        with self.assertRaises(ArtifactDiffError):
            diff_inventories(good, {"schema_version": "x"}, pair="A→B1")

    def test_diff_pairs(self):
        inv_a = self._inventory("a.apk", BASE_ENTRIES)
        inv_b = self._inventory("b.apk", BASE_ENTRIES)
        docs = diff_pairs({"A": inv_a, "B1": inv_b}, ["A→B1"])
        self.assertIn("A→B1", docs)
        self.assertEqual(docs["A→B1"]["pair"], "A→B1")
        with self.assertRaises(ArtifactDiffError):
            diff_pairs({"A": inv_a}, ["A→B1"])
        with self.assertRaises(ArtifactDiffError):
            diff_pairs({"A": inv_a, "B1": inv_b}, ["A-B1"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
