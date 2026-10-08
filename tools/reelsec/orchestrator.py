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
import runtime_health as rh_mod
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
    """Evidence aggregation -> FINAL-VERDICT (end-to-end requirement 3).

    The NEW comparison documents are read FIRST: when a working control
    was observed and a common-cause comparison exists, those documents —
    not the legacy baseline-round fields — drive the verdict. A completed
    COMMON_CAUSE_BOTH_CRASH investigation is a VALID campaign:
    final_verdict=NOT_PROVEN, runtime_status=COMMON_CAUSE_BOTH_CRASH,
    regression_status=NOT_ESTABLISHED, and NEXT_ACTION never recommends a
    destructive baseline or any uninstall permission flag.
    """
    cd = Path(campaign_dir)
    safety = _read_json(cd / "SAFETY-GATE.json") or {}
    runtime_verdict = _read_json(cd / "RUNTIME-VERDICT.json") or {}
    evidence = _read_json(cd / "EVIDENCE-REPORT.json") or {}
    health = _read_json(cd / "RUNTIME-HEALTH.json") or {}
    if isinstance(health.get("data"), dict) and "startup" not in health:
        health = health["data"]  # collector envelope (device campaigns)
    working_control = _read_json(cd / "WORKING-CONTROL.json") or {}
    common_cause = _read_json(cd / "COMMON-CAUSE-COMPARISON.json") or {}
    baseline_doc = _read_json(cd / "BASELINE-RUNTIME.json") or {}
    baseline_health = baseline_doc.get("health")
    deploy = _read_json(cd / "ADB-DEPLOY.json") or {}
    cc_status = common_cause.get("status")

    # Timeline-truth audit: recorded documents are never rewritten, but the
    # aggregation corrects startups that stale crash-buffer tombstones
    # fabricated, and annotates every correction.
    audit_notes = []
    i_audit = rh_mod.audit_startup_classification(health) if health else None
    health_startup = health.get("startup")
    if i_audit and i_audit["contradictions"]:
        health_startup = i_audit["audited_startup"]
        audit_notes.append("INSTRUMENTED: " + i_audit["reason"])
    original_side, original_note = rh_mod.audited_original_side(
        working_control or None, baseline_health=baseline_health)
    if original_note:
        audit_notes.append("ORIGINAL_SIDE: " + original_note)
    effective_cc = cc_status
    if cc_status == "COMMON_CAUSE_BOTH_CRASH" and original_side == "PASS" \
            and health_startup == "CRASH":
        effective_cc = "CONTROL_HEALTHY_INSTRUMENTED_CRASH"
        audit_notes.append(
            "COMMON_CAUSE: recorded COMMON_CAUSE_BOTH_CRASH downgraded — the "
            "original-side crash was contradicted by the session-bound audit")

    if safety.get("safety") == "BLOCKED":
        final, reason = "SAFETY_BLOCKED", safety.get("reason")
    elif effective_cc == "COMMON_CAUSE_BOTH_CRASH":
        # Requirement 12: a completed both-crash comparison is a valid
        # investigation — the scientific verdict is simply NOT_PROVEN.
        final = "NOT_PROVEN"
        reason = ("COMMON_CAUSE_BOTH_CRASH: the installed original AND the "
                  "instrumented artifact crash with a common cause; "
                  "instrumentation regression NOT_ESTABLISHED; runtime "
                  "proof remains blocked")
    elif health_startup == "CRASH":
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

    # Runtime fields — sourced from RUNTIME-VERDICT, then reconciled
    # against the working-control / common-cause documents (requirement
    # 17: FINAL == RUNTIME == COMMON-CAUSE on runtime/regression status)
    # and against the session-bound startup audit (timeline truth).
    regression = runtime_verdict.get("REGRESSION_STATUS")
    runtime_status = runtime_verdict.get("RUNTIME_STATUS")
    next_action = runtime_verdict.get("NEXT_ACTION")
    original_runtime = runtime_verdict.get("ORIGINAL_RUNTIME")
    if original_runtime in (None, "NOT_RUN") and working_control:
        original_runtime = {
            "CONTROL_ASSESSED": "PASS",
            "CONTROL_CRASHED": "CRASH",
            "CONTROL_NOT_INSTALLED": "NOT_INSTALLED",
        }.get(working_control.get("status"), original_runtime)
    b_audit = (rh_mod.audit_startup_classification(baseline_health)
               if baseline_health else None)
    if b_audit and b_audit["contradictions"]:
        audit_notes.append("BASELINE: " + b_audit["reason"])
    if original_side == "PASS" and original_runtime == "CRASH":
        # The recorded original-side CRASH was fabricated by stale
        # crash-buffer evidence: correct the verdict, keep the documents.
        original_runtime = "PASS"
        if health_startup == "CRASH":
            regression = rh_mod.REGRESSION_CONFIRMED
            runtime_status = "BLOCKED_BY_ARTIFACT_CRASH"
            next_action = (
                "Instrumentation regression confirmed: the original ran "
                "healthy within its observation window while the "
                "instrumented artifact crashed after installation; review "
                "INSTRUMENTATION-IMPACT.json change linkage before any "
                "further round.")
    elif original_side == "PASS" and original_runtime in (None, "NOT_RUN",
                                                          "NOT_INSTALLED"):
        # CONTROL_NOT_INSTALLED never means the original never ran: the
        # audited baseline round established the original-side runtime.
        original_runtime = "PASS"
    if effective_cc == "COMMON_CAUSE_BOTH_CRASH":
        regression = "NOT_ESTABLISHED"
        runtime_status = "COMMON_CAUSE_BOTH_CRASH"
        next_action = (
            "Investigate the common cause (device/OS/ROM or the app itself) "
            "with the working control left installed; instrumentation "
            "regression is NOT_ESTABLISHED and the crash MUST NOT be "
            "attributed to instrumentation. No destructive operation is "
            "required or permitted.")
    elif effective_cc == "CONTROL_HEALTHY_INSTRUMENTED_CRASH" and \
            cc_status == "COMMON_CAUSE_BOTH_CRASH" and health_startup == "CRASH":
        regression = regression if regression == rh_mod.REGRESSION_CONFIRMED \
            else "SUSPECTED_NOT_PROVEN"
        runtime_status = "CONTROL_HEALTHY_INSTRUMENTED_CRASH"
        next_action = (
            "The recorded BOTH_CRASH common cause was contradicted by the "
            "session-bound audit: the original ran healthy in its window "
            "while only the instrumented artifact crashed; instrumentation "
            "is a CANDIDATE cause — review INSTRUMENTATION-IMPACT.json "
            "change linkage. No destructive operation is required.")
    if runtime_status is None:
        runtime_status = ("BLOCKED_BY_ARTIFACT_CRASH"
                          if health_startup == "CRASH"
                          else runtime_verdict.get("RUNTIME_PROOF_STATUS"))
    # Defense in depth: a destructive-baseline recommendation must never
    # surface as NEXT_ACTION, whatever produced the legacy document.
    if next_action and ("REELSEC_ALLOW_TEST_DEVICE_UNINSTALL" in next_action
                        or "gated baseline round" in next_action):
        next_action = (
            "Run the non-destructive working-control round "
            "(REELSEC_WORKING_CONTROL, default on): the installed original "
            "is the control. Destructive operations are deny-by-default and "
            "are never a NEXT_ACTION.")

    state = rh_mod.campaign_state_machine(
        safety=safety,
        working_control=working_control or None,
        baseline_health=baseline_health or None,
        deploy_status=deploy.get("status"),
        instrumented_health=health or None,
        common_cause=common_cause or None,
        evidence=({"causal_proof": evidence.get("causal_proof"),
                   "missing": (evidence.get("causal_chain") or {}).get(
                       "missing")} if evidence else None))

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
        "campaign_state": state["state"],
        "campaign_state_reason": state["reason"],
        "campaign_state_transitions": state["transitions"],
        "runtime": {
            "ORIGINAL_RUNTIME": original_runtime,
            "INSTRUMENTED_RUNTIME": runtime_verdict.get("INSTRUMENTED_RUNTIME"),
            "CRASH_CLASS": runtime_verdict.get("CRASH_CLASS"),
            "CRASH_CAUSE": runtime_verdict.get("CRASH_CAUSE"),
            "REGRESSION_STATUS": regression,
            "RUNTIME_STATUS": runtime_status,
            "WORKING_CONTROL": (working_control.get("status")
                                or runtime_verdict.get("WORKING_CONTROL")),
            "COMMON_CAUSE_COMPARISON": (effective_cc or runtime_verdict.get(
                "COMMON_CAUSE_COMPARISON")),
            "COMMON_CAUSE_COMPARISON_RECORDED": cc_status,
            "RUNTIME_PROOF_STATUS": runtime_verdict.get("RUNTIME_PROOF_STATUS"),
            "STARTUP_AUDIT": ("; ".join(audit_notes) if audit_notes else None),
            "NEXT_ACTION": next_action,
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
        # Exit-code split (end-to-end requirement 13):
        #   rc 0 = valid completed investigation (an app crash WITH
        #          successful evidence collection + comparison is VALID,
        #          never CAMPAIGN_EXIT_2),
        #   rc 3 = scientific incomplete (e.g. crash without comparison),
        #   rc 2 = infrastructure failure (no device, invalid artifact).
        if rc == 3:
            campaign_status = "SCIENTIFIC_INCOMPLETE"
        elif rc == 2:
            campaign_status = "INFRASTRUCTURE_FAILURE"
        elif rc != 0:
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
        if publish_result.get("status") in ("PUSH_FAILED", "PUBLISH_FAILED"):
            # Requirement 14: a push failure (e.g. HTTP 403) is an
            # INFRASTRUCTURE-only issue. It is recorded as PUBLISH_FAILURE
            # and must never alter the scientific or runtime verdicts —
            # every verdict field above was computed before publishing.
            publish_result["classification"] = (
                "PUBLISH_FAILURE (infrastructure only; scientific and "
                "runtime verdicts unaffected)")
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
