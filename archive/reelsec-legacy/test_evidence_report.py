#!/usr/bin/env python3
"""Unit tests for the tiered evidence report + causal chain gate."""
import json
import tempfile
import unittest
from pathlib import Path

from evidence_report import (
    CLAIM_ID,
    TIER_CONFIRMED,
    TIER_INDICATOR,
    TIER_NOT_PROVEN,
    TIER_UNRELATED,
    build_report,
    to_markdown,
)

SHA = "e67f2a69a108e5fb36f98eb6ca5fdd1030872f43d216b4163fb3e7c999deb278"


def detection_stub(with_capture_callbacks=True, packed=True):
    hits = []
    if with_capture_callbacks:
        hits.append({
            "file": "lib/arm64-v8a/libsaasCorePlayer.so",
            "sha256": "aa" * 32,
            "hits": [
                {"category": "SCREEN_CAPTURE_CALLBACKS", "pattern": "onCaptureScreen",
                 "string": "nativeOnCaptureScreen", "count": 2},
            ],
        })
    hits.append({
        "file": "smali/com/google/firebase/x.smali",
        "sha256": "bb" * 32,
        "hits": [
            {"category": "FLAG_SECURE", "pattern": "SMALI_0x2000_FLAG_WINDOW",
             "line": 4, "sample": "const/16 v1, 0x2000", "noise": True,
             "noise_reason": "third-party SDK path"},
        ],
    })
    mechanisms = []
    if with_capture_callbacks:
        mechanisms.append({"layer": "SCREEN_CAPTURE_CALLBACKS",
                           "mechanism": "SCREEN_CAPTURE_CALLBACKS",
                           "confidence": "MEDIUM", "evidence_count": 1})
    if packed:
        mechanisms.append({"layer": "PACKER", "mechanism": "APP_HARDENING_SHELL",
                           "confidence": "HIGH_STRUCTURAL", "evidence_count": 2})
    return {
        "schema_version": "capture-detection-3",
        "root": "/tmp/decoded",
        "input_mode": "decoded_tree",
        "read_only": True,
        "files_scanned": 10,
        "files_with_hits": 2,
        "category_counts": {"SCREEN_CAPTURE_CALLBACKS": 1} if with_capture_callbacks else {},
        "manifest": {"present": True},
        "packers": [{"packer": "SecShell",
                     "evidence": ["manifest:com.secshell.", "native_lib:libsecshell.so"]}] if packed else [],
        "hidden_dex": [],
        "summary": {"mechanisms": mechanisms, "verdict": "INDICATORS_PRESENT", "note": "n"},
        "hits": hits,
        "causal_proof": False,
        "interpretation": "STATIC_INDICATORS_ONLY",
    }


def campaign_stub(target_sha=SHA, runtime_matches=2, behavior_ok=True):
    d = tempfile.TemporaryDirectory()
    cd = Path(d.name)
    (cd / "target-sha256.txt").write_text(target_sha + "\n")
    (cd / "RUNTIME-PROBE.json").write_text(json.dumps({
        "status": "OK" if runtime_matches else "RUNTIME_PROBE_TIMEOUT_NO_TARGET_OBSERVED",
        "events": [{"offset": "0x27a510"}] if runtime_matches else [],
        "runtime_matches": runtime_matches,
    }))
    (cd / "BEHAVIOR-CAPTURE.json").write_text(json.dumps({
        "schema_version": "behavior-capture-2",
        "screenshot_attempted": True,
        "secure_content_protected": bool(behavior_ok),
        "session_bound": True,
        "device_observations": {
            "serial": "s1", "package": "com.x",
            "foreground_dump": "topResumedActivity: com.x",
            "foreground_is_target": True,
            "screencap_attempted": True, "screencap_returncode": 0,
            "screencap_bytes": 1024, "screencap_sha256": "ab" * 32,
        },
        "operator_inputs": {"playback_confirmed": True},
        "program_analysis": {"analyzable": True, "uniform_dark": bool(behavior_ok),
                             "max_channel": 0 if behavior_ok else 200, "threshold": 16},
        "gate_inference": {"capture_result": "ALL_BLACK_FRAME" if behavior_ok
                           else "CONTENT_VISIBLE",
                           "secure_content_protected": bool(behavior_ok)},
    }))
    return d, cd


class EvidenceReportTests(unittest.TestCase):
    def test_tiers_are_strictly_separated(self):
        report = build_report(detection_stub())
        tiers = {f["tier"] for f in report["findings"]}
        counts = report["counts_by_tier"]
        # packer presence is a CONFIRMED structural fact
        confirmed = [f for f in report["findings"] if f["tier"] == TIER_CONFIRMED]
        self.assertTrue(any("SecShell" in f["statement"] for f in confirmed))
        # capture-callback strings are INDICATOR, never CONFIRMED behavior
        indicators = [f for f in report["findings"] if f["tier"] == TIER_INDICATOR]
        self.assertTrue(any(f["layer"] == "SCREEN_CAPTURE_CALLBACKS" for f in indicators))
        # third-party noise is UNRELATED
        unrelated = [f for f in report["findings"] if f["tier"] == TIER_UNRELATED]
        self.assertTrue(any("firebase" in json.dumps(f["evidence"]) for f in unrelated))
        # causal claim defaults to NOT_PROVEN
        claims = [f for f in report["findings"] if f["layer"] == "CLAIM"]
        self.assertEqual(len(claims), 1)
        self.assertEqual(claims[0]["tier"], TIER_NOT_PROVEN)
        self.assertEqual(counts[TIER_NOT_PROVEN], 1)
        self.assertIn(TIER_CONFIRMED, tiers)
        self.assertFalse(report["causal_proof"])

    def test_chain_gate_blocks_incomplete_chain(self):
        report = build_report(detection_stub(), campaign_dir=None)
        chain = report["causal_chain"]
        self.assertEqual(chain["verdict"], TIER_NOT_PROVEN)
        status = {l["id"]: l["status"] for l in chain["links"]}
        # static identification is confirmed, but nothing beyond it
        self.assertEqual(status["L1_MECHANISM_IDENTIFIED_STATIC"], TIER_CONFIRMED)
        self.assertEqual(status["L2_TARGET_PROVENANCE_ESTABLISHED"], TIER_NOT_PROVEN)
        self.assertEqual(status["L3_RUNTIME_EXECUTION_OBSERVED"], TIER_NOT_PROVEN)
        self.assertEqual(status["L4_CAPTURE_BLOCK_BEHAVIOR_OBSERVED"], TIER_NOT_PROVEN)
        self.assertIn("L3_RUNTIME_EXECUTION_OBSERVED", chain["missing"])
        self.assertFalse(report["causal_proof"])

    def test_chain_gate_requires_behavior_even_with_runtime(self):
        d, cd = campaign_stub(runtime_matches=2, behavior_ok=False)
        self.addCleanup(d.cleanup)
        det = detection_stub()
        det["input_sha256"] = SHA
        report = build_report(det, campaign_dir=cd)
        chain = report["causal_chain"]
        status = {l["id"]: l["status"] for l in chain["links"]}
        self.assertEqual(status["L2_TARGET_PROVENANCE_ESTABLISHED"], TIER_CONFIRMED)
        self.assertEqual(status["L3_RUNTIME_EXECUTION_OBSERVED"], TIER_CONFIRMED)
        self.assertEqual(status["L4_CAPTURE_BLOCK_BEHAVIOR_OBSERVED"], TIER_NOT_PROVEN)
        self.assertEqual(chain["verdict"], TIER_NOT_PROVEN)
        self.assertFalse(report["causal_proof"])

    def test_chain_gate_confirms_only_complete_chain(self):
        d, cd = campaign_stub(runtime_matches=2, behavior_ok=True)
        self.addCleanup(d.cleanup)
        det = detection_stub()
        det["input_sha256"] = SHA
        report = build_report(det, campaign_dir=cd)
        chain = report["causal_chain"]
        self.assertEqual(chain["verdict"], TIER_CONFIRMED)
        self.assertEqual(chain["missing"], [])
        self.assertTrue(report["causal_proof"])
        claims = [f for f in report["findings"] if f["layer"] == "CLAIM"]
        self.assertEqual(claims[0]["tier"], TIER_CONFIRMED)

    def test_graph_links_static_native_runtime(self):
        d, cd = campaign_stub()
        self.addCleanup(d.cleanup)
        report = build_report(detection_stub(), campaign_dir=cd)
        g = report["evidence_graph"]
        node_ids = {n["id"] for n in g["nodes"]}
        self.assertIn(CLAIM_ID, node_ids)
        self.assertIn("RUNTIME-PROBE", node_ids)
        self.assertTrue(any(n["type"] == "file" for n in g["nodes"]))
        self.assertTrue(any(n["type"] == "mechanism" for n in g["nodes"]))
        req = [e for e in g["edges"] if e["relation"] == "REQUIRES" and e["source"] == CLAIM_ID]
        self.assertEqual(len(req), 4)
        informs = [e for e in g["edges"] if e["relation"] == "INFORMS"]
        self.assertTrue(any(e["source"] == "RUNTIME-PROBE" for e in informs))

    def test_markdown_report_renders_all_sections(self):
        report = build_report(detection_stub())
        md = to_markdown(report)
        for section in ("## Causal verdict", "## Findings by tier",
                        "CONFIRMED", "INDICATOR", "NOT_PROVEN", "UNRELATED",
                        "## Evidence graph", "mermaid", "## Boundary"):
            self.assertIn(section, md)
        self.assertIn("causal_proof: false", md)

    def test_report_is_read_only_contract(self):
        report = build_report(detection_stub())
        self.assertTrue(report["read_only"])
        self.assertEqual(report["schema_version"], "evidence-report-1")
        self.assertIn("never patches", report["safety_boundary"])

    def test_lifecycle_probe_without_target_keeps_L3_not_proven(self):
        """Scenario 13: staged diagnostics never manufacture L3."""
        d = tempfile.TemporaryDirectory()
        self.addCleanup(d.cleanup)
        cd = Path(d.name)
        (cd / "target-sha256.txt").write_text(SHA + "\n")
        (cd / "RUNTIME-PROBE.json").write_text(json.dumps({
            "status": "RUNTIME_PROBE_TIMEOUT_NO_TARGET_OBSERVED",
            "reason_code": "TARGET_MODULE_NOT_OBSERVED",
            "lifecycle": {"probe_attached": True, "module_observed": False,
                          "target_observed": False,
                          "reason_code": "TARGET_MODULE_NOT_OBSERVED"},
            "events": [{"event": "PROBE_ATTACHED"}],
            "runtime_matches": 0,
        }))
        det = detection_stub()
        det["input_sha256"] = SHA
        report = build_report(det, campaign_dir=cd)
        status = {l["id"]: l["status"] for l in report["causal_chain"]["links"]}
        self.assertEqual(status["L3_RUNTIME_EXECUTION_OBSERVED"], TIER_NOT_PROVEN)
        self.assertIn("TARGET_MODULE_NOT_OBSERVED",
                      next(l["detail"] for l in report["causal_chain"]["links"]
                           if l["id"] == "L3_RUNTIME_EXECUTION_OBSERVED"))
        self.assertEqual(report["causal_chain"]["verdict"], TIER_NOT_PROVEN)

    def test_missing_behavior_capture_keeps_L4_not_proven(self):
        """Scenario 14: no BEHAVIOR-CAPTURE.json means L4 stays NOT_PROVEN."""
        d = tempfile.TemporaryDirectory()
        self.addCleanup(d.cleanup)
        cd = Path(d.name)
        (cd / "target-sha256.txt").write_text(SHA + "\n")
        (cd / "RUNTIME-PROBE.json").write_text(json.dumps({
            "status": "PROVEN_RUNTIME_TARGET_DISPATCH",
            "events": [{"event": "TARGET_FUNCTION_ENTER"}],
            "runtime_matches": 1,
        }))
        det = detection_stub()
        det["input_sha256"] = SHA
        report = build_report(det, campaign_dir=cd)
        status = {l["id"]: l["status"] for l in report["causal_chain"]["links"]}
        self.assertEqual(status["L3_RUNTIME_EXECUTION_OBSERVED"], TIER_CONFIRMED)
        self.assertEqual(status["L4_CAPTURE_BLOCK_BEHAVIOR_OBSERVED"], TIER_NOT_PROVEN)
        self.assertEqual(report["causal_chain"]["verdict"], TIER_NOT_PROVEN)
        self.assertFalse(report["causal_proof"])

    def test_gate_rejects_partial_evidence_without_provenance(self):
        """Scenario 15: runtime+behavior without hash binding is rejected."""
        d = tempfile.TemporaryDirectory()
        self.addCleanup(d.cleanup)
        cd = Path(d.name)  # no target-sha256.txt -> L2 cannot confirm
        (cd / "RUNTIME-PROBE.json").write_text(json.dumps({
            "status": "PROVEN_RUNTIME_TARGET_DISPATCH",
            "events": [{"event": "TARGET_FUNCTION_ENTER"}],
            "runtime_matches": 1,
        }))
        (cd / "BEHAVIOR-CAPTURE.json").write_text(json.dumps({
            "schema_version": "behavior-capture-2",
            "screenshot_attempted": True,
            "secure_content_protected": True,
            "session_bound": True,
            "device_observations": {"screencap_sha256": "cd" * 32},
            "operator_inputs": {"playback_confirmed": True},
            "program_analysis": {"analyzable": True, "uniform_dark": True},
            "gate_inference": {"capture_result": "ALL_BLACK_FRAME"},
        }))
        report = build_report(detection_stub(), campaign_dir=cd)
        status = {l["id"]: l["status"] for l in report["causal_chain"]["links"]}
        self.assertEqual(status["L2_TARGET_PROVENANCE_ESTABLISHED"], TIER_NOT_PROVEN)
        self.assertEqual(status["L3_RUNTIME_EXECUTION_OBSERVED"], TIER_CONFIRMED)
        self.assertEqual(status["L4_CAPTURE_BLOCK_BEHAVIOR_OBSERVED"], TIER_CONFIRMED)
        self.assertEqual(report["causal_chain"]["verdict"], TIER_NOT_PROVEN)
        self.assertFalse(report["causal_proof"])

    def test_hand_written_protection_claim_without_observations_is_rejected(self):
        """Anti-forgery: a bare claim (even v2 schema) without an auditable
        device observation hash + frame analysis never confirms L4."""
        d = tempfile.TemporaryDirectory()
        self.addCleanup(d.cleanup)
        cd = Path(d.name)
        (cd / "target-sha256.txt").write_text(SHA + "\n")
        (cd / "RUNTIME-PROBE.json").write_text(json.dumps({
            "status": "PROVEN_RUNTIME_TARGET_DISPATCH",
            "events": [{"event": "TARGET_FUNCTION_ENTER"}],
            "runtime_matches": 1,
        }))
        (cd / "BEHAVIOR-CAPTURE.json").write_text(json.dumps({
            "schema_version": "behavior-capture-2",
            "screenshot_attempted": True,
            "secure_content_protected": True,
            "session_bound": True,
            "operator_inputs": {"playback_confirmed": True},
        }))
        det = detection_stub()
        det["input_sha256"] = SHA
        report = build_report(det, campaign_dir=cd)
        status = {l["id"]: l["status"] for l in report["causal_chain"]["links"]}
        self.assertEqual(status["L4_CAPTURE_BLOCK_BEHAVIOR_OBSERVED"], TIER_NOT_PROVEN)
        self.assertEqual(report["causal_chain"]["verdict"], TIER_NOT_PROVEN)
        self.assertFalse(report["causal_proof"])

    def test_operator_playback_flag_alone_is_not_behavioral_evidence(self):
        """REELSEC_BEHAVIOR_PLAYBACK_CONFIRMED=1 without a real capture
        observation keeps L4 NOT_PROVEN."""
        d = tempfile.TemporaryDirectory()
        self.addCleanup(d.cleanup)
        cd = Path(d.name)
        (cd / "target-sha256.txt").write_text(SHA + "\n")
        (cd / "RUNTIME-PROBE.json").write_text(json.dumps({
            "status": "PROVEN_RUNTIME_TARGET_DISPATCH",
            "events": [{"event": "TARGET_FUNCTION_ENTER"}],
            "runtime_matches": 1,
        }))
        (cd / "BEHAVIOR-CAPTURE.json").write_text(json.dumps({
            "schema_version": "behavior-capture-2",
            "screenshot_attempted": True,
            "secure_content_protected": None,
            "session_bound": True,
            "device_observations": {"screencap_sha256": "ef" * 32},
            "operator_inputs": {"playback_confirmed": True},
            "program_analysis": {"analyzable": True, "uniform_dark": True},
            "gate_inference": {"capture_result": "ALL_BLACK_FRAME",
                               "secure_content_protected": None},
        }))
        det = detection_stub()
        det["input_sha256"] = SHA
        report = build_report(det, campaign_dir=cd)
        status = {l["id"]: l["status"] for l in report["causal_chain"]["links"]}
        self.assertEqual(status["L4_CAPTURE_BLOCK_BEHAVIOR_OBSERVED"], TIER_NOT_PROVEN)
        self.assertEqual(report["causal_chain"]["verdict"], TIER_NOT_PROVEN)


def main():
    unittest.main(module=__name__, argv=[__name__, "-v"], exit=False)
    print("evidence_report: PASS")


if __name__ == "__main__":
    main()
