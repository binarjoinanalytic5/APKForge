#!/usr/bin/env python3
"""Byte-level artifact anatomy for the isolation matrix.

Health records alone can say *that* arms B1/B2 crash while A runs
healthy, but they cannot say *what bytes changed* between the arms.
This module inventories each arm's APK as a ZIP (entry names, sizes,
compression methods, CRCs, offsets) plus whole-file digests and the
APK Signing Block span, then diffs pairs of arms (A→B1, A→B2,
B1→B2) so the next narrowing step can name the exact changed
files/sections instead of blaming "repackaging" as a whole.

APK sections (by entry-name classification, verified against the real
manifest/resource table only by name):
* MANIFEST — AndroidManifest.xml
* DEX — classes*.dex
* NATIVE_LIBS — lib/<abi>/*.so
* RESOURCES — resources.arsc, res/**, assets/**
* META_INF — META-INF/** (signing churn lives here)
* OTHER — everything else (kotlin/**, META-INF-adjacent files, etc.)

Signing churn is expected on every re-sign (META-INF digests and the
APK Signing Block rewrite wholesale), so it is separated from content
changes: META_INF and SIGNING_BLOCK differences are reported under
`signing_churn` and never promoted as content candidates. Offset-only
relocation (an entry whose bytes are identical but moved) is layout
churn: listed for inspection, excluded from content counts, and queued
only when relocation is the WHOLE story (the alignment fingerprint).
Verdicts: IDENTICAL, CONTENT_CHANGED, SIGNING_CHURN_ONLY, LAYOUT_ONLY.
The diff verdict is descriptive, never causal — it feeds the narrowing
queue, not the decision.
"""
import hashlib
import os
import struct
import zipfile


class ArtifactDiffError(RuntimeError):
    pass


SCHEMA_INVENTORY = "artifact-inventory-1"
SCHEMA_DIFF = "artifact-diff-1"

# APK Signing Block magic: "APK Sig Block 42" (16 bytes, little-endian
# footer: size-of-block + magic + size-of-block).
_SIGNING_MAGIC = b"APK Sig Block 42"

SECTION_MANIFEST = "MANIFEST"
SECTION_DEX = "DEX"
SECTION_NATIVE_LIBS = "NATIVE_LIBS"
SECTION_RESOURCES = "RESOURCES"
SECTION_META_INF = "META_INF"
SECTION_OTHER = "OTHER"
SECTIONS = (SECTION_MANIFEST, SECTION_DEX, SECTION_NATIVE_LIBS,
            SECTION_RESOURCES, SECTION_META_INF, SECTION_OTHER)

_SIGNING_CHURN_SECTIONS = (SECTION_META_INF,)


def classify_entry(name):
    """Classify a ZIP entry name into an APK section."""
    lowered = (name or "").lower()
    if lowered == "androidmanifest.xml":
        return SECTION_MANIFEST
    if lowered.startswith("meta-inf/"):
        return SECTION_META_INF
    if lowered.endswith(".dex") and "/" not in lowered:
        return SECTION_DEX
    if lowered.startswith("lib/") and lowered.endswith(".so"):
        return SECTION_NATIVE_LIBS
    if lowered == "resources.arsc" or lowered.startswith("res/") \
            or lowered.startswith("assets/"):
        return SECTION_RESOURCES
    return SECTION_OTHER


def sha256_file(path):
    """SHA-256 hex digest of a file (streamed)."""
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for chunk in iter(lambda: handle.read(65536), b""):
            digest.update(chunk)
    return digest.hexdigest()


def locate_signing_block(path):
    """Locate the APK Signing Block span {offset, size} (or None).

    Follows the APK signature scheme v2 layout: EOCD → central
    directory offset → the signing block sits immediately before the
    central directory; its footer carries the magic. Files without a
    valid footer return None instead of raising — unsigned test
    fixtures are legitimate inputs.
    """
    size = os.path.getsize(path)
    with open(path, "rb") as handle:
        tail = handle.read() if size <= 70000 else None
        if tail is None:
            handle.seek(max(0, size - 70000))
            tail = handle.read()
        eocd_pos = tail.rfind(b"PK\x05\x06")
        if eocd_pos < 0:
            return None
        eocd = tail[eocd_pos:eocd_pos + 22]
        if len(eocd) < 22:
            return None
        (_sig, _disk, _cd_disk, _disk_records, _total_records,
         _cd_size, cd_offset, _comment_len) = struct.unpack(
            "<IHHHHIIH", eocd)
        base = (size - len(tail)) + eocd_pos
        if cd_offset >= size or cd_offset < 32:
            return None
        handle.seek(cd_offset - 24)
        footer = handle.read(24)
        if len(footer) < 24:
            return None
        (inner_size, magic) = struct.unpack("<Q16s", footer)
        if magic != _SIGNING_MAGIC:
            return None
        block_size = inner_size + 8
        start = cd_offset - block_size
        if start < 0:
            return None
        handle.seek(start)
        head = handle.read(8)
        if len(head) < 8 or struct.unpack("<Q", head)[0] != inner_size:
            return None
        return {"offset": start, "size": block_size}


def inventory_artifact(path):
    """Inventory one APK: digests, ZIP entries, signing-block span.

    Returns the ARTIFACT-INVENTORY document. `path` must exist and be a
    valid ZIP; anything else raises ArtifactDiffError (fail-closed: no
    anatomy is better than invented anatomy).
    """
    if not path or not os.path.isfile(path):
        raise ArtifactDiffError(
            "artifact %r is missing; refusing to invent anatomy" % (path,))
    try:
        archive = zipfile.ZipFile(path, "r")
    except zipfile.BadZipFile as exc:
        raise ArtifactDiffError(
            "artifact %r is not a valid ZIP: %s" % (path, exc))
    entries = {}
    sections = {section: {"entries": 0, "compressed_bytes": 0,
                          "uncompressed_bytes": 0}
                for section in SECTIONS}
    with archive:
        for info in archive.infolist():
            section = classify_entry(info.filename)
            entries[info.filename] = {
                "compress_type": info.compress_type,
                "compress_size": info.compress_size,
                "file_size": info.file_size,
                "crc32": "%08x" % (info.CRC & 0xFFFFFFFF),
                "header_offset": info.header_offset,
                "section": section,
            }
            bucket = sections[section]
            bucket["entries"] += 1
            bucket["compressed_bytes"] += info.compress_size
            bucket["uncompressed_bytes"] += info.file_size
    return {
        "schema_version": SCHEMA_INVENTORY,
        "path": os.path.basename(path),
        "file_bytes": os.path.getsize(path),
        "sha256": sha256_file(path),
        "signing_block": locate_signing_block(path),
        "entry_count": len(entries),
        "sections": sections,
        "entries": entries,
    }


def _entry_change(name, old, new):
    changes = []
    if old is None:
        return {"name": name, "change": "ADDED", "section": new["section"],
                "details": "present only in the second arm"}
    if new is None:
        return {"name": name, "change": "REMOVED",
                "section": old["section"],
                "details": "present only in the first arm"}
    if old["crc32"] != new["crc32"] \
            or old["file_size"] != new["file_size"]:
        changes.append("content differs (crc %s→%s, size %d→%d)"
                       % (old["crc32"], new["crc32"],
                          old["file_size"], new["file_size"]))
    if old["compress_type"] != new["compress_type"]:
        changes.append("compression %s→%s"
                       % (old["compress_type"], new["compress_type"]))
    elif old["compress_size"] != new["compress_size"]:
        changes.append("compressed size %d→%d"
                       % (old["compress_size"], new["compress_size"]))
    if old["header_offset"] != new["header_offset"]:
        changes.append("offset %d→%d"
                       % (old["header_offset"], new["header_offset"]))
    if not changes:
        return None
    # Offset-only churn still relocates bytes; flag whether content moved.
    kinds = ["OFFSET_ONLY"] if changes == [
        "offset %d→%d" % (old["header_offset"], new["header_offset"])] \
        else ["ENTRY_CHANGED"]
    return {"name": name, "change": kinds[0], "section": new["section"],
            "details": "; ".join(changes)}


def diff_inventories(first, second, *, pair):
    """Diff two ARTIFACT-INVENTORY documents (descriptive, not causal).

    Returns the ARTIFACT-DIFF document for `pair` (e.g. "A→B1"):
    entry-level changes, per-section summaries, signing churn
    (META-INF + signing block) separated from content changes, and a
    narrowing queue naming the sections that actually changed.
    Identical files short-circuit to IDENTICAL.
    """
    for label, inventory in (("first", first), ("second", second)):
        if not isinstance(inventory, dict) \
                or inventory.get("schema_version") != SCHEMA_INVENTORY \
                or not isinstance(inventory.get("entries"), dict):
            raise ArtifactDiffError(
                "%s inventory is not an ARTIFACT-INVENTORY document"
                % label)
    old_entries = first["entries"]
    new_entries = second["entries"]
    changed = []
    for name in sorted(set(old_entries) | set(new_entries)):
        record = _entry_change(name, old_entries.get(name),
                               new_entries.get(name))
        if record is not None:
            changed.append(record)
    first_block = first.get("signing_block")
    second_block = second.get("signing_block")
    block_changed = first_block != second_block
    real_changes = [record for record in changed
                    if record["change"] != "OFFSET_ONLY"
                    and record["section"] not in _SIGNING_CHURN_SECTIONS]
    churn_entry_changes = [
        record for record in changed
        if record["section"] in _SIGNING_CHURN_SECTIONS
        and record["change"] != "OFFSET_ONLY"]
    layout_changes = [record for record in changed
                      if record["change"] == "OFFSET_ONLY"]
    section_summary = {}
    for section in SECTIONS:
        section_changes = [record for record in changed
                           if record["section"] == section]
        kinds = {}
        for record in section_changes:
            kinds[record["change"]] = kinds.get(record["change"], 0) + 1
        section_summary[section] = {
            "changed_entries": len(section_changes),
            "kinds": kinds,
            "names": sorted(record["name"]
                            for record in section_changes)[:50],
        }
    identical = (first.get("sha256") == second.get("sha256")
                 and not changed and not block_changed)
    if identical:
        verdict = "IDENTICAL"
    elif real_changes:
        verdict = "CONTENT_CHANGED"
    elif churn_entry_changes or block_changed:
        # Layout cascades under a re-sign (entries shifting behind a
        # rewritten META-INF) are churn fallout, not content leads.
        verdict = "SIGNING_CHURN_ONLY"
    elif layout_changes:
        verdict = "LAYOUT_ONLY"
    else:
        # Bytes differ outside the inventoried entries (central
        # directory extras, comments): changed, but unlocated.
        verdict = "CONTENT_CHANGED"
    # Narrowing queue: sections with real content change, ordered by
    # blast radius (native code and manifest first); signing churn is
    # expected on every re-sign and never queues as a candidate.
    # Offset-only relocation queues only under LAYOUT_ONLY, where it
    # is the whole story (the alignment fingerprint), never as churn
    # fallout and never for META-INF.
    priority = (SECTION_NATIVE_LIBS, SECTION_DEX, SECTION_MANIFEST,
                SECTION_RESOURCES, SECTION_OTHER)
    queue = [section for section in priority
             if any(record["section"] == section
                    for record in real_changes)]
    if verdict == "LAYOUT_ONLY":
        queue = [section for section in priority
                 if any(record["section"] == section
                        for record in layout_changes)]
    return {
        "schema_version": SCHEMA_DIFF,
        "pair": pair,
        "first_sha256": first.get("sha256"),
        "second_sha256": second.get("sha256"),
        "verdict": verdict,
        "changed_entries": changed,
        "changed_entry_count": len(changed),
        "content_change_count": len(real_changes),
        "layout_change_count": len(layout_changes),
        "section_summary": section_summary,
        "signing_churn": {
            "meta_inf_changes": churn_entry_changes,
            "signing_block_changed": block_changed,
            "first_signing_block": first_block,
            "second_signing_block": second_block,
            "note": ("META-INF and signing-block churn is expected on "
                     "every re-sign and is not a content candidate"),
        },
        "narrowing_queue": queue,
        "note": ("descriptive anatomy only: names what bytes changed "
                 "between the arms; causal claims come from the "
                 "isolation decision, never from this diff"),
    }


def diff_pairs(inventories, pairs):
    """Diff several arm pairs; returns {pair: ARTIFACT-DIFF document}."""
    documents = {}
    for pair in pairs:
        try:
            first_arm, second_arm = pair.split("→")
        except ValueError:
            raise ArtifactDiffError(
                "pair %r must read FIRST→SECOND" % (pair,))
        if first_arm not in inventories:
            raise ArtifactDiffError(
                "pair %r: arm %s has no inventory" % (pair, first_arm))
        if second_arm not in inventories:
            raise ArtifactDiffError(
                "pair %r: arm %s has no inventory" % (pair, second_arm))
        documents[pair] = diff_inventories(inventories[first_arm],
                                           inventories[second_arm],
                                           pair=pair)
    return documents
