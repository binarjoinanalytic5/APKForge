"""ReelSec Autonomous Evidence Platform orchestrator.

Turns ReelSec from a campaign script into an autonomous platform:

    doctor (safety gate) -> campaign orchestrator -> collectors
        -> evidence aggregator -> git publisher -> FINAL REPORT

Safety first: if the environment carries a blanket destructive permission
(the 2026-10-07 incident), the platform emits exactly:

    SAFETY: BLOCKED
    REASON: destructive uninstall permission enabled
    No package was modified.
    No runtime campaign executed.

and runs nothing. The tool must know when to stop.
"""

import json
import os
import subprocess
import sys
import time
from pathlib import Path

import collectors as collectors_mod
import safety_gate

SCHEMA_VERDICT = "final-verdict-1"
SCHEMA_MANIFEST = "campaign-manifest-1"
HERE = Path(__file__).resolve().parent


def _read_json(path):
    try:
        return json.loads(Path(path).read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return None


def _default_runner(cmd, timeout=5400):
    proc = subprocess.run(cmd, text=True, stdout=subprocess.PIPE,
                          stderr=subprocess.STDOUT, timeout=timeout,
                          check=False)
    return proc.returncode, (proc.stdout or "")


def _default_git_runner(cmd, timeout=300):
    env = dict(os.environ)
    env.setdefault("GIT_AUTHOR_NAME", "ReelSec Agent")
    env.setdefault("GIT_AUTHOR_EMAIL", "binarjoinanalytic5@gmail.com")
    env.setdefault("GIT_COMMITTER_NAME", "ReelSec Agent")
    env.setdefault("GIT_COMMITTER_EMAIL", "binarjoinanalytic5@gmail.com")
    proc = subprocess.run(cmd, text=True, stdout=subprocess.PIPE,
                          stderr=subprocess.STDOUT, timeout=timeout,
                          check=False, env=env)
    return proc.returncode, (proc.stdout or "")


# ---------------------------------------------------------------- doctor

def doctor(env=None, adb=None, serial=None, runner=None):
    """Safety + capability report. Never touches the device destructively."""
    env = env if env is not None else os.environ
    violations = safety_gate.inspect_environment(env)
    doc = {
        "schema_version": "doctor-1",
        "checked_at_epoch": time.time(),
        "safety": "BLOCKED" if violations else "OK",
        "reason": (violations[0]["violation"] if violations else None),
        "violations": violations,
        "destructive_policy": safety_gate.DEFAULT_POLICY,
        "authorization_document": env.get("REELSEC_DESTRUCTIVE_AUTH"),
        "device": {"adb": adb, "serial": serial, "reachable": None},
        "capabilities": {},
    }
    if adb and serial and runner:
        rc, out = runner([adb, "-s", serial, "shell", "getprop",
                          "ro.build.fingerprint"], timeout=20)
        doc["device"]["reachable"] = rc == 0
        doc["device"]["build_fingerprint"] = (out or "").strip() if rc == 0 else None
    return doc


# ------------------------------------------------------- campaign layout

def create_campaign_dir(root, now=None):
    now = now if now is not None else time.time()
    stamp = time.strftime("%Y-%m-%dT%H-%M-%S", time.gmtime(now))
    cd = Path(root) / "analysis" / "campaigns" / stamp
    cd.mkdir(parents=True, exist_ok=True)
    (cd / "logs").mkdir(exist_ok=True)
    return cd


# ------------------------------------------------------------ aggregation

def _final_verdict_logic(campaign_dir, campaign_status=None):
    cd = Path(campaign_dir)
    safety = _read_json(cd / "SAFETY-GATE.json") or {}
    runtime_verdict = _read_json(cd / "RUNTIME-VERDICT.json") or {}
    evidence = _read_json(cd / "EVIDENCE-REPORT.json") or {}
    health = _read_json(cd / "RUNTIME-HEALTH.json") or {}

    if safety.get("safety") == "BLOCKED":
        final, reason = "SAFETY_BLOCKED", safety.get("reason")
    elif health.get("startup") == "CRASH":
        final = "BLOCKED_BY_ARTIFACT_CRASH"
        reason = health.get("crash_class")
    elif evidence:
        chain = evidence.get("causal_chain") or {}
        final = ("CONFIRMED" if evidence.get("causal_proof")
                 else chain.get("verdict") or "NOT_PROVEN")
        reason = evidence.get("runtime_validity_reason") or (
            "causal chain incomplete" if final != "CONFIRMED" else None)
    elif runtime_verdict:
        final = runtime_verdict.get("RUNTIME_PROOF_STATUS", "NOT_PROVEN")
        reason = None
    else:
        final = "NOT_PROVEN"
        reason = "no runtime or evidence artifacts produced"

    chain = (evidence.get("causal_chain") or {})
    links = {l["id"].split("_", 1)[0]: l["status"]
             for l in chain.get("links", [])}
    return {
        "schema_version": SCHEMA_VERDICT,
        "generated_at_epoch": time.time(),
        "campaign_dir": str(cd),
        "campaign_status": campaign_status,
        "final_verdict": final,
        "reason": reason,
        "safety": safety.get("safety"),
        "safety_reason": safety.get("reason"),
        "runtime": {
            "ORIGINAL_RUNTIME": runtime_verdict.get("ORIGINAL_RUNTIME"),
            "INSTRUMENTED_RUNTIME": runtime_verdict.get("INSTRUMENTED_RUNTIME"),
            "CRASH_CLASS": runtime_verdict.get("CRASH_CLASS"),
            "CRASH_CAUSE": runtime_verdict.get("CRASH_CAUSE"),
            "REGRESSION_STATUS": runtime_verdict.get("REGRESSION_STATUS"),
            "RUNTIME_PROOF_STATUS": runtime_verdict.get("RUNTIME_PROOF_STATUS"),
            "NEXT_ACTION": runtime_verdict.get("NEXT_ACTION"),
        },
        "scientific_status": {
            "L1": links.get("L1", "NOT_EVALUATED"),
            "L2": links.get("L2", "NOT_EVALUATED"),
            "L3": links.get("L3", "NOT_EVALUATED"),
            "L4": links.get("L4", "NOT_EVALUATED"),
            "SCREENSHOT_BLOCKING": (
                "CONFIRMED" if evidence.get("causal_proof") else "NOT_PROVEN"),
        },
        "evidence_report_verdict": chain.get("verdict"),
        "runtime_validity": evidence.get("runtime_validity"),
    }


def _final_report_md(verdict, manifest, publish=None):
    v = verdict
    lines = [
        "# ReelSec Campaign — Final Report",
        "",
        "Campaign: `%s`" % v["campaign_dir"],
        "Generated: %s" % time.strftime("%Y-%m-%dT%H:%M:%SZ",
                                        time.gmtime(v["generated_at_epoch"])),
        "",
        "## Final verdict",
        "",
        "**%s**%s" % (v["final_verdict"],
                      (" — %s" % v["reason"]) if v.get("reason") else ""),
        "",
        "## Safety",
        "",
        "SAFETY: %s%s" % (v.get("safety") or "NOT_EVALUATED",
                          (" — REASON: %s" % v["safety_reason"])
                          if v.get("safety_reason") else ""),
        "",
        "## Runtime",
        "",
        "| Field | Value |",
        "|---|---|",
    ]
    for k, val in (v.get("runtime") or {}).items():
        lines.append("| %s | %s |" % (k, val))
    lines += [
        "",
        "## Scientific status",
        "",
        "| Link | Status |",
        "|---|---|",
    ]
    for k, val in (v.get("scientific_status") or {}).items():
        lines.append("| %s | %s |" % (k, val))
    if publish:
        lines += [
            "",
            "## Publication",
            "",
            "PUBLISH_STATUS: %s" % publish.get("status"),
            "PUBLISH_COMMIT: %s" % (publish.get("commit") or "NONE"),
        ]
    if manifest:
        lines += [
            "",
            "## Evidence files (%d)" % manifest.get("file_count", 0),
            "",
            "| File | SHA-256 (12) | Bytes |",
            "|---|---|---|",
        ]
        for f in manifest.get("files", []):
            lines.append("| %s | %s | %d |" % (
                f["path"], f["sha256"][:12], f["size_bytes"]))
    lines.append("")
    return "\n".join(lines)


def aggregate(campaign_dir, campaign_status=None):
    """Evidence aggregation: manifest (SHA-256), final verdict, report md."""
    cd = Path(campaign_dir)
    verdict = _final_verdict_logic(cd, campaign_status=campaign_status)
    ev = _read_json(cd / "EVIDENCE.json") or {}
    files = (ev.get("data") or {}).get("files") or []
    manifest = {
        "schema_version": SCHEMA_MANIFEST,
        "campaign_dir": str(cd),
        "generated_at_epoch": time.time(),
        "file_count": len(files),
        "files": files,
        "collector_summary": _read_json(cd / "COLLECTOR-SUMMARY.json"),
    }
    return manifest, verdict


# ------------------------------------------------------------ git publish

def git_publish_campaign(root, campaign_dir, runner=None, branch="main",
                         message=None):
    """Commit + push the campaign directory. Never force-pushes."""
    runner = runner or _default_git_runner
    root = str(Path(root).resolve())
    rel = Path(campaign_dir).resolve().relative_to(Path(root).resolve()).as_posix()
    steps = []

    def step(name, cmd, timeout=300):
        rc, out = runner(cmd, timeout=timeout)
        steps.append({"step": name, "returncode": rc,
                      "output_tail": (out or "")[-800:]})
        return rc, out

    rc, _ = step("add", ["git", "-C", root, "add", "--", rel])
    if rc != 0:
        return {"status": "PUBLISH_FAILED", "stage": "add", "commit": None,
                "steps": steps}
    rc, out = step("commit", ["git", "-C", root, "commit", "-m",
                              message or "ReelSec campaign evidence: %s" % rel])
    if rc != 0:
        if "nothing to commit" in (out or ""):
            return {"status": "NOTHING_TO_COMMIT", "commit": None,
                    "steps": steps}
        return {"status": "PUBLISH_FAILED", "stage": "commit", "commit": None,
                "steps": steps}
    rc, out = step("rev-parse", ["git", "-C", root, "rev-parse", "HEAD"])
    commit = (out or "").strip().splitlines()[-1] if rc == 0 else None
    rc, _ = step("push", ["git", "-C", root, "push", "origin", branch])
    return {
        "status": "PUBLISHED" if rc == 0 else "PUSH_FAILED",
        "commit": commit,
        "pushed": rc == 0,
        "branch": branch,
        "campaign_path": rel,
        "steps": steps,
    }


# ---------------------------------------------------------------- platform

def run_platform(apk, root, runner=None, git_runner=None, env=None,
                 publish=True, adb=None, serial=None, now=None):
    """The autonomous pipeline. Returns the final platform result dict."""
    runner = runner or _default_runner
    env = env if env is not None else os.environ
    campaign_dir = create_campaign_dir(root, now=now)

    # --- Safety gate (doctor) ---
    safety = doctor(env=env, adb=adb, serial=serial, runner=runner)
    (campaign_dir / "SAFETY-GATE.json").write_text(
        json.dumps(safety, indent=2, sort_keys=True) + "\n", encoding="utf-8")

    if safety["safety"] != "OK":
        verdict = _final_verdict_logic(campaign_dir, campaign_status="NOT_RUN")
        (campaign_dir / "FINAL-VERDICT.json").write_text(
            json.dumps(verdict, indent=2, sort_keys=True) + "\n",
            encoding="utf-8")
        report = (
            "# ReelSec Platform\n\n"
            "SAFETY: BLOCKED\n"
            "REASON: %s\n\n"
            "No package was modified.\n"
            "No runtime campaign executed.\n\n"
            "## REPORT\n\n"
            "The environment carries a blanket destructive permission. The\n"
            "platform refuses to run any campaign until it is removed and,\n"
            "if a destructive step is genuinely required, replaced by a\n"
            "hash-bound authorization document (REELSEC_DESTRUCTIVE_AUTH)\n"
            "processed by safety_gate.execute_destructive.\n" % safety["reason"]
        )
        (campaign_dir / "FINAL-REPORT.md").write_text(report, encoding="utf-8")
        return {"status": "SAFETY_BLOCKED", "reason": safety["reason"],
                "campaign_dir": str(campaign_dir), "verdict": verdict,
                "publish": None}

    # --- Campaign orchestrator: run the existing campaign into the dir ---
    campaign_status = "COMPLETED"
    logs = campaign_dir / "logs" / "campaign.log"
    try:
        rc, out = runner([sys.executable, str(HERE / "reelsec.py"),
                          "campaign", str(apk),
                          "--output", str(campaign_dir), "--no-publish"],
                         timeout=5400)
        logs.write_text((out or "")[-200000:], encoding="utf-8")
        if rc != 0:
            campaign_status = "CAMPAIGN_EXIT_%d" % rc
    except Exception as exc:
        campaign_status = "CAMPAIGN_EXCEPTION"
        logs.write_text(str(exc)[:20000], encoding="utf-8")

    # --- Collectors (uniform envelopes, contained failures) ---
    ctx = {"runner": runner, "adb": adb, "serial": serial,
           "package": env.get("REELSEC_TEST_PACKAGE"),
           "campaign_dir": campaign_dir}
    summary = collectors_mod.run_collectors(ctx)
    (campaign_dir / "COLLECTOR-SUMMARY.json").write_text(
        json.dumps(summary, indent=2, sort_keys=True) + "\n", encoding="utf-8")

    # --- Evidence aggregator ---
    manifest, verdict = aggregate(campaign_dir,
                                  campaign_status=campaign_status)
    (campaign_dir / "MANIFEST.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")

    # --- Git publisher ---
    publish_result = None
    if publish:
        publish_result = git_publish_campaign(
            root, campaign_dir, runner=git_runner or _default_git_runner)
        verdict["publish"] = publish_result

    (campaign_dir / "FINAL-VERDICT.json").write_text(
        json.dumps(verdict, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    (campaign_dir / "FINAL-REPORT.md").write_text(
        _final_report_md(verdict, manifest, publish=publish_result),
        encoding="utf-8")

    return {"status": verdict["final_verdict"],
            "campaign_status": campaign_status,
            "campaign_dir": str(campaign_dir),
            "verdict": verdict, "publish": publish_result}
