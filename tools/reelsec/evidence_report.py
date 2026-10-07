#!/usr/bin/env python3
"""Professional tiered evidence report + evidence graph for ReelSec findings.

Consumes a capture-detection report (capture-detection-2/3) and, optionally, a
campaign report directory (RUNTIME-PROBE.json, INPUT-PROVENANCE.json,
target-sha256.txt, ADB-DEPLOY.json) and produces:

- EVIDENCE-REPORT.json — machine-readable findings, evidence graph, chain gate
- EVIDENCE-REPORT.md   — human-readable tiered report

Evidence tiers (strict):
- CONFIRMED   : structural/byte-level facts verified directly from the
                artifact (file exists, hash, string present, entry present,
                manifest declares X). Presence only — never behavior.
- INDICATOR   : fact present and security-relevant by inference, but execution
                or intent is not established (strings, symbols, heuristics).
- NOT_PROVEN  : causal/behavioral claims (e.g. "the app blocks screenshots")
                without a completed proof chain. Always the default tier for
                causal claims.
- UNRELATED   : hits classified as third-party/noise context.

Causal chain gate for the claim "screenshot/recording protection is active":
    L1 MECHANISM_IDENTIFIED_STATIC
    L2 TARGET_PROVENANCE_ESTABLISHED
    L3 RUNTIME_EXECUTION_OBSERVED (tied to the exact artifact)
    L4 CAPTURE_BLOCK_BEHAVIOR_OBSERVED (bounded behavioral observation)
The claim is CONFIRMED only when every link is CONFIRMED. Anything less is
NOT_PROVEN with the missing links enumerated. This module is read-only.
"""
import argparse, json, time
from pathlib import Path

SCHEMA = "evidence-report-1"

TIER_CONFIRMED = "CONFIRMED"
TIER_INDICATOR = "INDICATOR"
TIER_NOT_PROVEN = "NOT_PROVEN"
TIER_UNRELATED = "UNRELATED"
TIERS = (TIER_CONFIRMED, TIER_INDICATOR, TIER_NOT_PROVEN, TIER_UNRELATED)

CLAIM_ID = "CLAIM-SCREENSHOT-PROTECTION-ACTIVE"

CATEGORY_LABELS = {
    "FLAG_SECURE": "managed-code window FLAG_SECURE usage",
    "MEDIA_PROJECTION": "MediaProjection / virtual display APIs",
    "SCREEN_CAPTURE_CALLBACKS": "screen-capture callback surface",
    "SURFACE_SECURITY": "secure surface APIs",
    "DRM_PROTECTION": "DRM subsystem strings",
    "DRM_SECURITY_LEVEL": "DRM security-level strings",
    "PROTECTED_CONTENT": "protected-content buffer usage",
    "NATIVE_CAPTURE": "capture-related native strings",
    "NATIVE_SYMBOLS": "capture-related exported native symbols",
    "TAMPER_RESISTANCE": "anti-instrumentation strings",
}


def _read_json(path):
    try:
        return json.loads(Path(path).read_text(encoding="utf-8", errors="replace"))
    except (OSError, ValueError):
        return None


def _campaign_facts(campaign_dir):
    facts = {"campaign_dir": None, "runtime_probe": None, "provenance": None,
             "target_sha256": None, "adb_deploy": None, "behavior_capture": None}
    if not campaign_dir:
        return facts
    cd = Path(campaign_dir)
    if not cd.is_dir():
        return facts
    facts["campaign_dir"] = str(cd)
    facts["runtime_probe"] = _read_json(cd / "RUNTIME-PROBE.json")
    prov = _read_json(cd / "INPUT-PROVENANCE.json")
    if prov:
        facts["provenance"] = prov
    sha_file = cd / "target-sha256.txt"
    if sha_file.exists():
        try:
            facts["target_sha256"] = sha_file.read_text().strip().split()[0].lower()
        except (OSError, IndexError):
            pass
    if not facts["target_sha256"] and isinstance(prov, dict):
        for key in ("input_sha256", "sha256", "apk_sha256"):
            if prov.get(key):
                facts["target_sha256"] = str(prov[key]).lower()
                break
    facts["adb_deploy"] = _read_json(cd / "ADB-DEPLOY.json")
    facts["behavior_capture"] = _read_json(cd / "BEHAVIOR-CAPTURE.json")
    return facts


def build_findings(detection, facts):
    """Derive strictly tiered findings from a detection report."""
    findings = []
    fid = [0]

    def add(tier, layer, statement, basis, evidence=None, why_not_higher=None):
        fid[0] += 1
        f = {
            "id": "F%03d" % fid[0],
            "tier": tier,
            "layer": layer,
            "statement": statement,
            "basis": basis,
            "evidence": evidence or [],
        }
        if why_not_higher:
            f["why_not_higher"] = why_not_higher
        findings.append(f)
        return f["id"]

    # --- CONFIRMED structural facts -------------------------------------
    for p in detection.get("packers", []):
        add(TIER_CONFIRMED, "PACKER",
            "App-hardening shell '%s' is present in the analyzed artifact." % p["packer"],
            "STRUCTURAL_MATCH: manifest/lib/asset signatures",
            evidence=p.get("evidence", []))
    for d in detection.get("hidden_dex", [])[:10]:
        add(TIER_CONFIRMED, "PACKER",
            "Packed/hidden DEX payload present at '%s' (offset %d)." % (d["file"], d.get("offset", 0)),
            "BYTE_LEVEL: DEX magic observed inside container entry",
            evidence=["%s@%d" % (d["file"], d.get("offset", 0))],
            why_not_higher="payload contents are encrypted; static extraction is out of scope")
    if detection.get("input_sha256"):
        add(TIER_CONFIRMED, "PROVENANCE",
            "Analyzed container hash recorded: %s" % detection["input_sha256"],
            "BYTE_LEVEL: SHA-256 of the exact input file",
            evidence=[detection["input_sha256"]])
    if facts.get("target_sha256"):
        add(TIER_CONFIRMED, "PROVENANCE",
            "Campaign target APK hash on record: %s" % facts["target_sha256"],
            "RECORD: campaign provenance file",
            evidence=[facts["target_sha256"]])

    # --- Category-level findings: relevant vs noise ----------------------
    per_category = {}
    per_category_noise = {}
    for item in detection.get("hits", []):
        for h in item.get("hits", []):
            cat = h.get("category")
            if not cat:
                continue
            bucket = per_category_noise if h.get("noise") else per_category
            rec = bucket.setdefault(cat, {"count": 0, "files": [], "samples": [], "families": {}})
            rec["count"] += 1
            if item["file"] not in rec["files"] and len(rec["files"]) < 8:
                rec["files"].append(item["file"])
            sample = h.get("string") or h.get("sample") or ""
            if sample and len(rec["samples"]) < 5 and sample not in rec["samples"]:
                rec["samples"].append(sample[:160])
            if h.get("family"):
                rec["families"][h["family"]] = rec["families"].get(h["family"], 0) + 1

    heuristic_hits = [
        (item["file"], h)
        for item in detection.get("hits", [])
        for h in item.get("hits", [])
        if h.get("pattern") == "SMALI_0x2000_FLAG_WINDOW" and not h.get("noise")
    ]
    if heuristic_hits:
        add(TIER_INDICATOR, "JAVA_UI",
            "Managed-code FLAG_SECURE usage pattern detected in %d location(s)." % len(heuristic_hits),
            "STATIC_HEURISTIC: 0x2000 constant + flag-application call window",
            evidence=["%s:%s" % (f, h.get("line")) for f, h in heuristic_hits[:8]],
            why_not_higher="static pattern; runtime window state not observed")

    for cat in sorted(per_category):
        rec = per_category[cat]
        label = CATEGORY_LABELS.get(cat, cat)
        tier = TIER_INDICATOR
        why = "presence confirmed; security behavior not observed at runtime"
        if cat == "NATIVE_SYMBOLS":
            why = "exported symbol presence confirmed; invocation not observed"
        add(tier, cat,
            "%s: %d relevant indicator hit(s) across %d file(s)." % (label, rec["count"], len(rec["files"])),
            "STATIC_PATTERN_MATCH",
            evidence=["files: " + ", ".join(rec["files"][:5])] + ["sample: " + s for s in rec["samples"][:3]],
            why_not_higher=why)
    for cat in sorted(per_category_noise):
        rec = per_category_noise[cat]
        add(TIER_UNRELATED, cat,
            "%s: %d hit(s) inside third-party SDK paths (classified unrelated)." % (
                CATEGORY_LABELS.get(cat, cat), rec["count"]),
            "NOISE_CLASSIFICATION: third-party SDK context",
            evidence=["files: " + ", ".join(rec["files"][:5])])

    # --- Causal claim: always NOT_PROVEN unless the chain completes ------
    chain = build_causal_chain(detection, facts, findings)
    claim_tier = TIER_CONFIRMED if chain["verdict"] == "CONFIRMED" else TIER_NOT_PROVEN
    add(claim_tier, "CLAIM",
        "Causal claim: the application actively blocks screenshots/screen-recording.",
        "CAUSAL_CHAIN_GATE",
        evidence=["link:%s=%s" % (l["id"], l["status"]) for l in chain["links"]],
        why_not_higher=None if claim_tier == TIER_CONFIRMED else
        "chain incomplete: " + ", ".join(l["id"] for l in chain["links"] if l["status"] != TIER_CONFIRMED))
    return findings, chain


def build_causal_chain(detection, facts, findings):
    """The four-link gate. The claim is CONFIRMED only if every link is."""
    links = []

    # L1 — mechanism identified statically
    relevant = [m for m in detection.get("summary", {}).get("mechanisms", [])
                if m.get("layer") != "PACKER"]
    strong_l1 = any(
        f["tier"] == TIER_INDICATOR and f["layer"] in
        ("JAVA_UI", "SCREEN_CAPTURE_CALLBACKS", "NATIVE_SYMBOLS")
        for f in findings
    )
    if strong_l1:
        # "Identified" is a CONFIRMED statement about static discovery, not
        # about behavior; execution and behavior remain L3/L4.
        l1 = (TIER_CONFIRMED, "capture-specific static mechanism identified (callbacks/symbols/FLAG_SECURE pattern)")
    elif relevant:
        l1 = (TIER_INDICATOR, "protection-related indicators present but not capture-specific")
    else:
        l1 = (TIER_NOT_PROVEN, "no capture-relevant static mechanism identified")
    links.append({"id": "L1_MECHANISM_IDENTIFIED_STATIC", "status": l1[0], "detail": l1[1]})

    # L2 — provenance: analyzed bytes are the exact target APK
    target_sha = facts.get("target_sha256")
    input_sha = detection.get("input_sha256")
    if target_sha and input_sha and target_sha == input_sha:
        l2 = (TIER_CONFIRMED, "analyzed container hash equals recorded target APK hash")
    elif target_sha:
        l2 = (TIER_INDICATOR, "target hash on record; analyzed tree derived from it (tree scan, no container hash comparison)")
    elif input_sha:
        l2 = (TIER_INDICATOR, "container hash recorded; no independent target record supplied")
    else:
        l2 = (TIER_NOT_PROVEN, "no artifact hash binding available")
    links.append({"id": "L2_TARGET_PROVENANCE_ESTABLISHED", "status": l2[0], "detail": l2[1]})

    # L3 — runtime execution observed, tied to the artifact
    probe = facts.get("runtime_probe") or {}
    events = probe.get("events") or []
    runtime_matches = probe.get("runtime_matches", 0)
    probe_reason = probe.get("reason_code") or (probe.get("lifecycle") or {}).get("reason_code")
    if events and runtime_matches > 0:
        l3 = (TIER_CONFIRMED, "runtime probe observed %d matching event(s)" % runtime_matches)
    elif probe:
        l3 = (TIER_NOT_PROVEN,
              "runtime probe observed no matching target events (status=%s reason_code=%s)" %
              (probe.get("status", "unknown"), probe_reason or "UNKNOWN"))
    else:
        l3 = (TIER_NOT_PROVEN, "no runtime probe evidence supplied")
    links.append({"id": "L3_RUNTIME_EXECUTION_OBSERVED", "status": l3[0], "detail": l3[1]})

    # L4 — capture-block behavior observed
    beh = facts.get("behavior_capture")
    if (isinstance(beh, dict) and beh.get("screenshot_attempted")
            and beh.get("secure_content_protected") is True
            and beh.get("session_bound")):
        l4 = (TIER_CONFIRMED, "bounded behavioral observation recorded a blocked capture")
    else:
        l4 = (TIER_NOT_PROVEN, "no bounded behavioral capture-block observation recorded")
    links.append({"id": "L4_CAPTURE_BLOCK_BEHAVIOR_OBSERVED", "status": l4[0], "detail": l4[1]})

    verdict = TIER_CONFIRMED if all(l["status"] == TIER_CONFIRMED for l in links) else TIER_NOT_PROVEN
    return {
        "claim": CLAIM_ID,
        "claim_statement": "The application actively blocks screenshots/screen-recording of protected content.",
        "links": links,
        "missing": [l["id"] for l in links if l["status"] != TIER_CONFIRMED],
        "verdict": verdict,
        "rule": "ALL_LINKS_MUST_BE_CONFIRMED",
    }


def build_graph(detection, facts, findings, chain):
    nodes = []
    edges = []
    seen_files = set()

    nodes.append({"id": "ARTIFACT-ROOT", "type": "artifact",
                  "label": detection.get("root", "?"),
                  "sha256": detection.get("input_sha256")})
    if facts.get("target_sha256"):
        nodes.append({"id": "ARTIFACT-TARGET-APK", "type": "artifact",
                      "label": "target APK", "sha256": facts["target_sha256"]})
        edges.append({"source": "ARTIFACT-ROOT", "relation": "DERIVED_FROM", "target": "ARTIFACT-TARGET-APK"})

    for item in detection.get("hits", []):
        relevant = [h for h in item["hits"] if not h.get("noise")]
        if not relevant or len(seen_files) >= 15:
            continue
        seen_files.add(item["file"])
        nid = "FILE-%02d" % len(seen_files)
        nodes.append({"id": nid, "type": "file", "label": item["file"], "sha256": item.get("sha256")})
        edges.append({"source": nid, "relation": "PART_OF", "target": "ARTIFACT-ROOT"})

    mech_ids = {}
    for i, m in enumerate(detection.get("summary", {}).get("mechanisms", []), 1):
        mid = "MECH-%02d" % i
        mech_ids[m["mechanism"]] = mid
        nodes.append({"id": mid, "type": "mechanism", "label": m["mechanism"],
                      "layer": m["layer"], "confidence": m["confidence"]})
        edges.append({"source": mid, "relation": "DETECTED_IN", "target": "ARTIFACT-ROOT"})

    layer_to_mech = {}
    for m in detection.get("summary", {}).get("mechanisms", []):
        layer_to_mech.setdefault(m["layer"], []).append(mech_ids[m["mechanism"]])
    for f in findings:
        nodes.append({"id": f["id"], "type": "finding", "label": f["statement"][:120], "tier": f["tier"]})
        if f["layer"] in layer_to_mech:
            for mid in layer_to_mech[f["layer"]][:1]:
                edges.append({"source": f["id"], "relation": "SUPPORTS", "target": mid})
        else:
            edges.append({"source": f["id"], "relation": "OBSERVED_IN", "target": "ARTIFACT-ROOT"})

    nodes.append({"id": CLAIM_ID, "type": "claim", "label": chain["claim_statement"],
                  "verdict": chain["verdict"]})
    for link in chain["links"]:
        lid = "LINK-" + link["id"]
        nodes.append({"id": lid, "type": "chain_link", "label": link["id"], "status": link["status"]})
        edges.append({"source": CLAIM_ID, "relation": "REQUIRES", "target": lid})
    # connect runtime evidence into L3 when present
    if facts.get("runtime_probe") is not None:
        nodes.append({"id": "RUNTIME-PROBE", "type": "runtime_evidence",
                      "label": "RUNTIME-PROBE.json",
                      "status": (facts.get("runtime_probe") or {}).get("status")})
        edges.append({"source": "RUNTIME-PROBE", "relation": "INFORMS", "target": "LINK-L3_RUNTIME_EXECUTION_OBSERVED"})
    return {"nodes": nodes, "edges": edges}


def counts_by_tier(findings):
    out = {t: 0 for t in TIERS}
    for f in findings:
        out[f["tier"]] += 1
    return out


def build_report(detection, campaign_dir=None):
    facts = _campaign_facts(campaign_dir)
    findings, chain = build_findings(detection, facts)
    graph = build_graph(detection, facts, findings, chain)
    return {
        "schema_version": SCHEMA,
        "generated_at_epoch": time.time(),
        "read_only": True,
        "provenance": {
            "detection_schema": detection.get("schema_version"),
            "analysis_root": detection.get("root"),
            "input_mode": detection.get("input_mode"),
            "input_sha256": detection.get("input_sha256"),
            "target_sha256": facts.get("target_sha256"),
            "campaign_dir": facts.get("campaign_dir"),
        },
        "detection_summary": detection.get("summary", {}),
        "findings": findings,
        "counts_by_tier": counts_by_tier(findings),
        "causal_chain": chain,
        "evidence_graph": graph,
        "causal_proof": chain["verdict"] == TIER_CONFIRMED,
        "interpretation": "TIERED_EVIDENCE_STATIC_PLUS_OPTIONAL_RUNTIME",
        "safety_boundary": ("This report classifies evidence only. It never patches, disables, "
                            "injects, signs, or bypasses any protection mechanism."),
    }


def to_markdown(report):
    chain = report["causal_chain"]
    lines = [
        "# ReelSec Evidence Report",
        "",
        "## Causal verdict",
        "",
        "**Claim:** %s" % chain["claim_statement"],
        "",
        "**Verdict: %s** (rule: %s)" % (chain["verdict"], chain["rule"]),
        "",
        "| Link | Status | Detail |",
        "|---|---|---|",
    ]
    for l in chain["links"]:
        lines.append("| %s | %s | %s |" % (l["id"], l["status"], l["detail"]))
    if chain["missing"]:
        lines += ["", "Missing for confirmation: " + ", ".join(chain["missing"])]
    lines += ["", "## Findings by tier", ""]
    for tier in TIERS:
        tf = [f for f in report["findings"] if f["tier"] == tier]
        lines += ["### %s (%d)" % (tier, len(tf)), ""]
        for f in tf:
            lines.append("- **%s** [%s] %s" % (f["id"], f["layer"], f["statement"]))
            lines.append("  - basis: %s" % f["basis"])
            if f.get("why_not_higher"):
                lines.append("  - why not higher: %s" % f["why_not_higher"])
            for e in f.get("evidence", [])[:4]:
                lines.append("  - evidence: %s" % e)
        if not tf:
            lines.append("- (none)")
        lines.append("")
    lines += ["## Evidence graph", "",
              "Nodes: %d, edges: %d" % (len(report["evidence_graph"]["nodes"]),
                                         len(report["evidence_graph"]["edges"])), "",
              "```mermaid", "flowchart LR"]
    for e in report["evidence_graph"]["edges"][:60]:
        lines.append('  %s -->|%s| %s' % (e["source"], e["relation"], e["target"]))
    lines += ["```", "",
              "## Boundary", "",
              report["safety_boundary"], "",
              "causal_proof: %s" % str(report["causal_proof"]).lower(), ""]
    return "\n".join(lines)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--detection", required=True, help="CAPTURE-DETECTION.json path")
    ap.add_argument("--campaign", help="campaign report directory (RUNTIME-PROBE.json etc.)")
    ap.add_argument("-o", "--output", help="EVIDENCE-REPORT.json path")
    ap.add_argument("-m", "--markdown", help="EVIDENCE-REPORT.md path")
    a = ap.parse_args()
    detection = json.loads(Path(a.detection).read_text(encoding="utf-8"))
    report = build_report(detection, campaign_dir=a.campaign)
    text = json.dumps(report, indent=2, sort_keys=True, ensure_ascii=False) + "\n"
    if a.output:
        Path(a.output).write_text(text, encoding="utf-8")
    else:
        print(text)
    if a.markdown:
        Path(a.markdown).write_text(to_markdown(report), encoding="utf-8")


if __name__ == "__main__":
    main()
