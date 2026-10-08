"""ReelSec runtime health: artifact crash gate + crash classification + baseline comparison.

Root-cause mandate (2026-10-07): the instrumented test artifact of
com.newleaf.app.android.victor was observed to crash repeatedly at startup
(dumpsys activity exit-info: reason=5 APP CRASH(NATIVE) status=6, plus
reason=4 APP CRASH(EXCEPTION); process death after MainActivity). The old
platform masked this as READY -> CAPTURED -> RUNTIME_PROBE_TIMEOUT, which
misattributed an artifact runtime integrity failure to the probe window.

This module makes artifact health a FIRST-CLASS GATE:

    Install -> Launch -> Process Health Gate -> Crash Detection
          -> Baseline/Artifact Comparison -> (only then) Module/Probe/Target

Principles:
* ApplicationExitInfo (`dumpsys activity exit-info`) is the primary,
  non-root source for process-death diagnosis.
* Never wait for a probe timeout to discover a crash.
* Never invent a crash cause: unknown stays CRASH_CAUSE_UNKNOWN.
* Never suppress, bypass, or mask a crash; this module only OBSERVES and
  CLASSIFIES. It never patches, disables protection, or mutates APKs.
* Baseline vs instrumented comparison separates instrumentation regression
  from a baseline (application-level) runtime failure.
"""

import hashlib
import re
import time
import zipfile
from pathlib import Path

SCHEMA = "runtime-health-1"

# ApplicationExitInfo reason codes (android.app.ApplicationExitInfo).
EXIT_INFO_REASONS = {
    0: "UNKNOWN", 1: "EXIT_SELF", 2: "SIGNALED", 3: "LOW_MEMORY",
    4: "APP_CRASH_EXCEPTION", 5: "APP_CRASH_NATIVE", 6: "ANR",
    7: "INITIALIZATION_FAILURE", 8: "PERMISSION_CHANGE",
    9: "EXCESSIVE_RESOURCE_USAGE", 10: "USER_REQUESTED", 11: "USER_STOPPED",
    12: "DEPENDENCY_DIED", 13: "OTHER", 14: "FREEZER",
    15: "PACKAGE_STATE_CHANGE", 16: "PACKAGE_UPDATED",
}

# Crash classification vocabulary (required minimum).
NATIVE_CRASH = "NATIVE_CRASH"
JAVA_EXCEPTION = "JAVA_EXCEPTION"
PROCESS_KILLED = "PROCESS_KILLED"
ANR = "ANR"
STARTUP_FAILURE = "STARTUP_FAILURE"
PACKAGE_NOT_PRESENT = "PACKAGE_NOT_PRESENT"
PROCESS_NOT_OBSERVED = "PROCESS_NOT_OBSERVED"
MODULE_NOT_OBSERVED = "MODULE_NOT_OBSERVED"
PROBE_ATTACH_FAILED = "PROBE_ATTACH_FAILED"
TARGET_NOT_EXECUTED = "TARGET_NOT_EXECUTED"
HEALTHY = "HEALTHY"

CAUSE_UNKNOWN = "CRASH_CAUSE_UNKNOWN"

# Regression verdicts (requirement 4).
REGRESSION_CONFIRMED = "INSTRUMENTATION_REGRESSION_CONFIRMED"
BASELINE_RUNTIME_FAILURE = "BASELINE_RUNTIME_FAILURE"
BOTH_START_OK = "BOTH_START_OK"
BASELINE_CRASH_INSTRUMENTED_OK = "BASELINE_CRASH_INSTRUMENTED_OK"
NOT_COMPARABLE = "NOT_COMPARABLE"

# Crash-level comparison verdicts: original vs instrumented are treated as
# two INDEPENDENT evidence sides; when both crash the status is explicit
# and the crash must not be attributed to instrumentation.
CRASH_COMPARISON_SCHEMA = "crash-comparison-1"
BOTH_CRASH = "BOTH_CRASH"
INSTRUMENTED_ONLY_CRASH = "INSTRUMENTED_ONLY_CRASH"
ORIGINAL_ONLY_CRASH = "ORIGINAL_ONLY_CRASH"
NO_CRASH_EVIDENCE = "NO_CRASH_EVIDENCE"

# Working-control verdicts: the CURRENTLY INSTALLED original is observed
# in place (read-only + bounded launch) — never uninstalled, cleared, or
# re-installed — and compared against the instrumented crash evidence.
WORKING_CONTROL_SCHEMA = "working-control-1"
COMMON_CAUSE_SCHEMA = "common-cause-comparison-1"
CONTROL_ASSESSED = "CONTROL_ASSESSED"
CONTROL_CRASHED = "CONTROL_CRASHED"
CONTROL_NOT_INSTALLED = "CONTROL_NOT_INSTALLED"
COMMON_CAUSE_BOTH_CRASH = "COMMON_CAUSE_BOTH_CRASH"
CONTROL_HEALTHY_INSTRUMENTED_CRASH = "CONTROL_HEALTHY_INSTRUMENTED_CRASH"
CONTROL_ONLY_CRASH = "CONTROL_ONLY_CRASH"
CONTROL_HEALTHY_NO_INSTRUMENTED_EVIDENCE = \
    "CONTROL_HEALTHY_NO_INSTRUMENTED_EVIDENCE"
COMMON_CAUSE_INCOMPLETE = "COMMON_CAUSE_INCOMPLETE"

CONF_HIGH = "HIGH"
CONF_MEDIUM = "MEDIUM"
CONF_LOW = "LOW"
CONF_NONE = "NONE"

REASON_CODE_ARTIFACT_CRASH = "RUNTIME_ARTIFACT_CRASH"
REASON_CODE_INTEGRITY = "ARTIFACT_INTEGRITY_FAILURE"

_FATAL_RE = re.compile(r"Fatal signal\s+(\d+)\s+\((SIG[A-Z0-9]+)\)", re.I)
_FAULT_ADDR_RE = re.compile(r"fault addr\s+(0x[0-9a-fA-F]+)", re.I)
# Frame paths end in .so OR .apk (Android maps uncompressed APK entries
# directly, so fault PCs like `base.apk + 0x31e10` are real and must parse).
_FRAME_RE = re.compile(
    r"#\d{2}\s+pc\s+([0-9a-fA-F]+)\s+(\S+)(?:\s+\(([^)]*)\))?")
_ABORT_RE = re.compile(r"Abort message:\s*'?(.*?)'?\s*$")
_EXIT_PKG_RE = re.compile(r"Package\s+\[([^\]]+)\]")
_EXIT_FIELD_RE = re.compile(r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*[:=]\s*(.*)$")
_REASON_RE = re.compile(r"reason=(\d+)(?:\s*\((.+)\))?\s*$")


def parse_exit_info(text):
    """Parse `dumpsys activity exit-info <pkg>` output into structured entries.

    Recognized lines: 'Package [name]', then indented 'KEY: value' /
    'key=value' fields (UID, PID, Timestamp, reason=N (NAME), status=N,
    importance, description, trace, ...). User is derived from UID
    (Android uid = user * 100000 + appid).
    """
    entries = []
    current = None
    for line in (text or "").splitlines():
        m = _EXIT_PKG_RE.search(line)
        if m:
            current = {"package": m.group(1), "user": None, "uid": None,
                       "pid": None, "timestamp": None, "reason_code": None,
                       "reason_name": None, "status": None, "importance": None,
                       "description": None, "trace": None, "raw": []}
            entries.append(current)
            continue
        if current is None:
            continue
        current["raw"].append(line.strip()[:200])
        fm = _EXIT_FIELD_RE.match(line)
        if not fm:
            continue
        key, value = fm.group(1), fm.group(2).strip()
        low = key.lower()
        if low == "uid":
            try:
                current["uid"] = int(value.split()[0])
                current["user"] = current["uid"] // 100000
            except ValueError:
                pass
        elif low == "pid":
            try:
                current["pid"] = int(value.split()[0])
            except ValueError:
                pass
        elif low == "timestamp":
            current["timestamp"] = value
        elif low == "reason":
            rm = _REASON_RE.search(value) or _REASON_RE.search("reason=" + value)
            if rm:
                current["reason_code"] = int(rm.group(1))
                current["reason_name"] = (rm.group(2) or "").strip() or \
                    EXIT_INFO_REASONS.get(current["reason_code"])
            else:
                current["reason_name"] = value
        elif low == "status":
            try:
                current["status"] = int(value.split()[0])
            except ValueError:
                current["status"] = value
        elif low == "importance":
            current["importance"] = value
        elif low == "description":
            current["description"] = value[:500]
        elif low == "trace":
            current["trace"] = value[:300]
    for e in entries:
        if e["reason_code"] is not None and not e["reason_name"]:
            e["reason_name"] = EXIT_INFO_REASONS.get(e["reason_code"])
    return entries


def _entry_key(e):
    return (e.get("uid"), e.get("pid"), e.get("timestamp"),
            e.get("reason_code"), e.get("status"))


def new_exit_entries(pre_entries, post_entries):
    """Exit-info entries that appeared after the pre-launch snapshot.

    Set-difference keyed by (uid, pid, timestamp, reason, status) so stale
    crashes from earlier sessions can never trigger the gate, regardless of
    device clock skew.
    """
    seen = {_entry_key(e) for e in (pre_entries or [])}
    return [e for e in (post_entries or []) if _entry_key(e) not in seen]


def parse_tombstone_logcat(text, package=None):
    """Extract crash forensics from logcat (crash buffer / DEBUG tombstone echo).

    Non-root source. Returns fatal signals, backtrace frames (index, pc,
    library basename, symbol), abort messages, and whether the crash lines
    are associated with the target package.
    """
    fatal_signal = None
    fatal_status = None
    fault_addr = None
    frames = []
    abort_message = None
    pid = tid = None
    thread_name = None
    package_lines = []
    fatal_lines = []
    truncated = package[-15:] if package and len(package) > 15 else package
    for line in (text or "").splitlines():
        stripped = line.strip()
        fm = _FATAL_RE.search(stripped)
        if fm:
            fatal_lines.append(stripped[:240])
            if fatal_signal is None:
                fatal_signal = fm.group(2)
                fatal_status = fm.group(1)
            if package and (package in stripped or (truncated and truncated in stripped)):
                package_lines.append(stripped[:240])
            fam = _FAULT_ADDR_RE.search(stripped)
            if fam and fault_addr is None:
                fault_addr = fam.group(1)
        frm = _FRAME_RE.search(stripped)
        if frm:
            path = frm.group(2)
            sym = frm.group(3)
            lib = path.split("!")[-1] if "!" in path else path
            frames.append({
                "pc": frm.group(1),
                "library": lib.rsplit("/", 1)[-1],
                "library_path": path,
                "symbol": (sym or "").strip() or None,
            })
        am = _ABORT_RE.search(stripped)
        if am and abort_message is None:
            abort_message = am.group(1)[:300]
        pm = re.search(r"pid:\s*(\d+),\s*tid:\s*(\d+),\s*name:\s*(\S+)", stripped)
        if pm:
            pid, tid, thread_name = int(pm.group(1)), int(pm.group(2)), pm.group(3)
            if package and package in stripped:
                package_lines.append(stripped[:240])
        elif package and package in stripped:
            package_lines.append(stripped[:240])
    associated = bool(package_lines) or (
        bool(package) and thread_name and (
            package in thread_name or (truncated and truncated in thread_name)))
    return {
        "fatal_signal": fatal_signal,
        "fatal_status": fatal_status,
        "fault_addr": fault_addr,
        "fatal_lines": fatal_lines[:5],
        "backtrace_frames": frames[:40],
        "abort_message": abort_message,
        "abort_message_present": abort_message is not None,
        "pid": pid,
        "tid": tid,
        "thread_name": thread_name,
        "package_associated": associated,
        "package_matched_lines": package_lines[:10],
    }


def _crash_buffer_new_lines(pre_text, post_text):
    """Lines that appeared in the append-only crash buffer after a snapshot.

    The logcat crash ring buffer retains tombstones from PREVIOUS sessions
    (potentially hours old). Only lines that were NOT present in the
    pre-launch snapshot can belong to the current session. Returns
    (new_lines, matched): matched=False means the pre-snapshot tail could
    not be located in the post text (buffer rotated between reads) and the
    caller must fall back to PID-based binding.
    """
    pre_lines = [l for l in (pre_text or "").splitlines() if l.strip()]
    post_lines = [l for l in (post_text or "").splitlines() if l.strip()]
    if not pre_lines:
        return post_lines, True
    for anchor in reversed(pre_lines[-5:]):
        for i in range(len(post_lines) - 1, -1, -1):
            if post_lines[i] == anchor:
                return post_lines[i + 1:], True
    return post_lines, False


def _session_tombstone_binding(pre_crash_text, pre_rc, post_crash_text,
                               post_rc, package, proc, fresh_entries=None):
    """Bind crash-buffer tombstone evidence to the CURRENT session.

    Timeline-truth mandate: a package-associated fatal signal that was
    ALREADY in the crash buffer before this session launched is stale
    evidence from an earlier session/artifact. It is preserved (never
    deleted) but MUST NOT classify the current session as CRASH. A tombstone
    is session-bound only when:
      * BUFFER_DIFF  — its lines appeared in the crash buffer after launch;
      * PID_MATCH    — its pid equals a pid observed in this session (or an
                       ApplicationExitInfo crash pid of this session);
      * IN_WINDOW_DEATH — the observed process died inside the window and
                       the tombstone is the only package crash evidence;
      * NO_PROCESS_OBSERVED — the launch never produced an observable
                       process and a package fatal signal exists
                       (crash-before-first-poll; freshness unverifiable).
    A process that was still ALIVE at window exit with zero new exit-info
    entries is NEVER declared crashed from a different pid's tombstone.
    Returns (session_tombstone, binding) — the parsed tombstone usable for
    THIS session's classification (possibly empty) plus audit metadata.
    """
    empty = parse_tombstone_logcat("", package)
    full = parse_tombstone_logcat(post_crash_text if post_rc == 0 else "",
                                  package)
    if post_rc != 0:
        return empty, {"bound": False, "method": "CRASH_BUFFER_UNAVAILABLE",
                       "reason": "crash buffer read failed (rc=%s)" % post_rc}
    pids = set(proc.get("pids") or [])
    pids |= {e.get("pid") for e in (fresh_entries or []) if e.get("pid")}
    if pre_rc == 0:
        new_lines, matched = _crash_buffer_new_lines(pre_crash_text,
                                                     post_crash_text)
        if matched:
            sess = parse_tombstone_logcat("\n".join(new_lines), package)
            if sess.get("fatal_signal") and sess.get("package_associated"):
                return sess, {
                    "bound": True, "method": "BUFFER_DIFF",
                    "reason": ("package-associated fatal signal appeared in "
                               "the crash buffer after launch (pid=%s)"
                               % sess.get("pid"))}
            reason = "no new package-associated fatal line after launch"
            if full.get("fatal_signal"):
                reason += ("; stale tombstone (pid=%s) predates this session: "
                           "excluded from attribution, evidence preserved"
                           % full.get("pid"))
            return empty, {"bound": False, "method": "BUFFER_DIFF",
                           "reason": reason}
    # Pre-snapshot unusable (read failed or buffer rotated): PID binding.
    tp = full.get("pid")
    if not (full.get("fatal_signal") and full.get("package_associated")):
        return empty, {"bound": False, "method": "PID_FALLBACK",
                       "reason": "no package-associated fatal signal in buffer"}
    if tp is not None and tp in pids:
        return full, {"bound": True, "method": "PID_MATCH",
                      "reason": "tombstone pid %s belongs to this session" % tp}
    if proc.get("observed") and proc.get("alive_at_exit"):
        return empty, {
            "bound": False, "method": "PID_FALLBACK",
            "reason": ("tombstone pid %s does not match the session pids %s "
                       "and the launched process was alive at window exit "
                       "with no new exit-info: stale evidence from an "
                       "earlier session, excluded (preserved)"
                       % (tp, sorted(pids) if pids else []))}
    if proc.get("observed"):
        return full, {
            "bound": True, "method": "IN_WINDOW_DEATH",
            "reason": ("observed process died inside the window and the "
                       "tombstone (pid=%s) is the only package crash "
                       "evidence; freshness not independently verifiable"
                       % tp)}
    return full, {
        "bound": True, "method": "NO_PROCESS_OBSERVED",
        "reason": ("launch never produced an observable process and a "
                   "package-associated fatal signal exists "
                   "(crash-before-first-poll; freshness unverifiable)")}


def audit_startup_classification(health):
    """Post-hoc timeline-truth audit of a RECORDED health document.

    Documents written before session-bound attribution existed may classify
    startup=CRASH from a tombstone belonging to an EARLIER session (stale
    crash-buffer evidence). The audit never deletes evidence and never
    rewrites documents: it reports contradictions and returns the corrected
    startup value for verdict/state-machine consumption. Only an explicit
    contradiction is overridden — recorded CRASH whose ONLY source was a
    logcat tombstone (no ApplicationExitInfo entry), while the launched
    process was alive at window exit and the tombstone pid matches no
    observed pid. Everything else is returned unchanged.
    """
    result = {"recorded_startup": None, "audited_startup": None,
              "contradictions": [], "reason": None}
    if not health:
        return result
    recorded = health.get("startup")
    result["recorded_startup"] = recorded
    result["audited_startup"] = recorded
    if recorded != "CRASH":
        return result
    binding = health.get("crash_session_binding") or {}
    if binding.get("bound") is True:
        result["reason"] = "crash evidence was session-bound at collection"
        return result
    cls = health.get("classification") or {}
    ev = health.get("evidence") or {}
    tomb = ev.get("tombstone") or {}
    if cls.get("exit_reason_code") is not None or \
            (ev.get("exit_info_new_entries") or []):
        result["reason"] = ("ApplicationExitInfo crash entry present: "
                            "authoritative, no override")
        return result
    tp = tomb.get("pid")
    pids = health.get("pids") or []
    if health.get("process_observed") and health.get("process_alive_at_exit") \
            and pids and tp is not None and tp not in pids:
        result["contradictions"].append("STALE_TOMBSTONE_ATTRIBUTION")
        result["audited_startup"] = "PASS"
        result["reason"] = (
            "recorded CRASH attributed tombstone pid %s, but the launched "
            "process (pids %s) was alive at window exit with zero new "
            "exit-info entries; the tombstone predates this session — "
            "evidence preserved, attribution excluded" % (tp, pids))
    return result


def audited_original_side(working_control, baseline_health=None):
    """Resolve the ORIGINAL-side runtime truth from recorded documents.

    CONTROL_NOT_INSTALLED never means "the original never ran": the baseline
    round may have installed and run it afterwards. CONTROL_CRASHED records
    are audited for stale-tombstone attribution. Returns
    (side, note) with side in {"PASS", "CRASH", None}.
    """
    wc = working_control or {}
    wc_status = wc.get("status")
    if wc_status in (CONTROL_ASSESSED, CONTROL_CRASHED):
        # Test-model isolation guard: the control side only counts as the
        # ORIGINAL when its installed bytes were hash-bound to the local
        # original reference. An unverified identity (e.g. a leftover
        # instrumented build of the SAME package after a replacement
        # install) establishes NOTHING about the original.
        verif = (wc.get("identity") or {}).get("original_verification") or {}
        if verif.get("verified") is False:
            return None, (
                "working-control identity UNVERIFIED: installed sha %s != "
                "original reference %s — the observed build may be a "
                "leftover instrumented artifact of the same package; "
                "original-side runtime NOT established"
                % (verif.get("installed_sha256"),
                   verif.get("reference_sha256")))
    if wc_status == CONTROL_CRASHED:
        a = audit_startup_classification(wc.get("health") or {})
        if a["contradictions"]:
            return "PASS", ("working-control recorded CRASH contradicted by "
                            "session-bound audit: %s" % a["reason"])
        return "CRASH", None
    if wc_status == CONTROL_ASSESSED:
        return "PASS", None
    if wc_status == CONTROL_NOT_INSTALLED and baseline_health:
        a = audit_startup_classification(baseline_health)
        side = a["audited_startup"] if a["audited_startup"] in (
            "PASS", "CRASH") else None
        note = None
        if a["contradictions"]:
            note = ("baseline recorded CRASH contradicted by session-bound "
                    "audit: %s" % a["reason"])
        return side, note
    if wc_status == CONTROL_NOT_INSTALLED:
        return None, ("no installed original at control time and no baseline "
                      "round recorded: the original was never run in this "
                      "campaign")
    return None, None


def resolve_apk_offset(apk_path, offset):
    """Map a file offset inside an APK to the STORED zip entry containing it.

    Android maps uncompressed (STORED) APK entries directly into the process
    address space, so a fault PC reported as `base.apk + 0x31e10` points into
    one specific stored entry — typically a packed .so. This resolves that
    offset to the entry name + offset within the entry, read-only, from the
    LOCAL artifact file (byte-identical to the installed base.apk; identity
    is bound by the campaign's artifact_sha256). Never invents a mapping:
    anything not provably inside a STORED entry stays UNRESOLVED.
    """
    if apk_path is None:
        return {"status": "UNRESOLVED",
                "reason": "local artifact not provided"}
    p = Path(apk_path)
    if not p.is_file():
        return {"status": "UNRESOLVED",
                "reason": "local artifact file unavailable: %s" % p}
    try:
        offset = int(offset)
    except (TypeError, ValueError):
        return {"status": "UNRESOLVED", "reason": "offset not an integer"}
    try:
        with zipfile.ZipFile(p) as zf, p.open("rb") as fh:
            for info in zf.infolist():
                if info.compress_type != zipfile.ZIP_STORED:
                    continue
                fh.seek(info.header_offset)
                hdr = fh.read(30)
                if len(hdr) < 30 or hdr[:4] != b"PK\x03\x04":
                    continue
                name_len = int.from_bytes(hdr[26:28], "little")
                extra_len = int.from_bytes(hdr[28:30], "little")
                data_start = info.header_offset + 30 + name_len + extra_len
                data_end = data_start + info.file_size
                if data_start <= offset < data_end:
                    return {
                        "status": "RESOLVED",
                        "entry": info.filename,
                        "offset_within_entry": hex(offset - data_start),
                        "entry_data_start": hex(data_start),
                        "entry_size": info.file_size,
                        "compress_type": "STORED",
                        "note": ("resolved against the local artifact bytes; "
                                 "installed identity is bound by the campaign "
                                 "artifact_sha256"),
                    }
        return {"status": "UNRESOLVED",
                "reason": "offset not inside any STORED entry of the artifact"}
    except (OSError, zipfile.BadZipFile) as exc:
        return {"status": "UNRESOLVED",
                "reason": "artifact unreadable: %s" % str(exc)[:200]}


def build_crash_artifact(package, label, exit_entries, tombstone,
                         installed_path=None, artifact_apk=None,
                         artifact_sha256=None, session=None, identity=None):
    """CRASH-ARTIFACT-1: per package/UID/session crash evidence record.

    Collected automatically when a fatal signal or fresh crash exit-info is
    observed. Integrity rules enforced here:
    * entries are GROUPED by (uid/user, pid, timestamp) — a mixed buffer
      (multiple users/runs, e.g. uid 10805/10810/9510810) is never merged
      into one story;
    * the abort message is recorded only if actually captured; when absent,
      an explicit guard forbids labeling the crash anti-tamper or
      screenshot protection on this evidence;
    * `base.apk + 0x…` fault locations are resolved to the artifact's
      STORED zip entry when the local artifact is available.
    """
    tombstone = tombstone or {}
    session = session or {}
    crashes = []
    for e in exit_entries or []:
        crashes.append({
            "source": "APPLICATION_EXIT_INFO",
            "package": e.get("package"),
            "uid": e.get("uid"),
            "user": (e.get("uid") // 100000) if e.get("uid") is not None
                    else e.get("user"),
            "pid": e.get("pid"),
            "timestamp_device": e.get("timestamp"),
            "reason_code": e.get("reason_code"),
            "reason_name": e.get("reason_name")
                           or EXIT_INFO_REASONS.get(e.get("reason_code")),
            "status": e.get("status"),
            "description": e.get("description"),
            "tombstone_path": e.get("trace"),
        })
    # End-to-end fix (requirement 8): tombstone evidence with no exit-info
    # entry must NOT collapse to crash_instances=[]. When the crash buffer
    # carries a package-associated fatal signal, a structured instance is
    # synthesized from what the tombstone actually contains (pid, signal,
    # thread name); unavailable bindings stay null and the record is
    # classified EVIDENCE_PRESENT_BUT_INSTANCE_INCOMPLETE — the raw
    # evidence lines are kept and the scientific verdict is never upgraded
    # from incomplete parsing.
    tombstone_lines = ((tombstone.get("fatal_lines") or [])
                       + (tombstone.get("package_matched_lines") or []))
    if not crashes and tombstone.get("fatal_signal") and (
            tombstone.get("package_associated") or tombstone_lines):
        crashes.append({
            "source": "LOGCAT_TOMBSTONE_ECHO",
            "package": package,
            "uid": None,
            "user": None,
            "pid": tombstone.get("pid"),
            "timestamp_device": None,
            "reason_code": None,
            "reason_name": None,
            "status": None,
            "description": ("synthesized from logcat crash-buffer tombstone "
                            "echo (signal %s, pid %s, thread %s); UID/user "
                            "binding unavailable in this source"
                            % (tombstone.get("fatal_signal"),
                               tombstone.get("pid"),
                               tombstone.get("thread_name"))),
            "tombstone_path": None,
            "fatal_signal": tombstone.get("fatal_signal"),
        })
    if any(c.get("source") == "APPLICATION_EXIT_INFO" for c in crashes):
        instances_completeness = "EXIT_INFO_COMPLETE"
    elif crashes:
        instances_completeness = "EVIDENCE_PRESENT_BUT_INSTANCE_INCOMPLETE"
    else:
        instances_completeness = "NO_CRASH_INSTANCE_EVIDENCE"
    uids = sorted({c["uid"] for c in crashes if c.get("uid") is not None})
    users = sorted({c["user"] for c in crashes if c.get("user") is not None})

    fault_location = None
    offset_resolution = None
    frames = tombstone.get("backtrace_frames") or []
    if frames:
        f0 = frames[0]
        fault_location = {
            "library": f0.get("library"),
            "library_path": f0.get("library_path"),
            "pc": f0.get("pc"),
            "symbol": f0.get("symbol"),
        }
        if (f0.get("library_path") or "").endswith(".apk"):
            try:
                off = int(f0.get("pc"), 16)
            except (TypeError, ValueError):
                off = None
            installed_sha = ((identity or {}).get("apk_sha256") or "").lower()
            if (installed_sha and artifact_sha256
                    and installed_sha != str(artifact_sha256).lower()):
                # End-to-end requirement 9: an offset may be resolved ONLY
                # against the local artifact that is byte-identical to the
                # installed APK. Different artifacts => UNRESOLVED, never
                # a nearest-symbol guess.
                offset_resolution = {
                    "status": "UNRESOLVED",
                    "reason": ("installed APK sha256 (%s...) != local "
                               "artifact sha256 (%s...): offsets must not "
                               "be resolved across different artifacts"
                               % (installed_sha[:12],
                                  str(artifact_sha256)[:12]))}
            elif off is not None:
                offset_resolution = resolve_apk_offset(artifact_apk, off)
            else:
                offset_resolution = {"status": "UNRESOLVED",
                                     "reason": "frame pc not parseable"}

    abort_present = bool(tombstone.get("abort_message"))
    integrity_notes = []
    if not abort_present:
        integrity_notes.append(
            "no textual abort() message captured in this record; the cause "
            "MUST NOT be labeled anti-tamper or screenshot protection on "
            "this evidence alone")
    if len(uids) > 1 or len(users) > 1:
        integrity_notes.append(
            "crash buffer mixes multiple users/runs (uids=%s users=%s); "
            "entries are grouped per UID/session and must not be merged "
            "into a single narrative" % (uids, users))
    if instances_completeness == "EVIDENCE_PRESENT_BUT_INSTANCE_INCOMPLETE":
        integrity_notes.append(
            "crash evidence present but structured instance incomplete "
            "(no ApplicationExitInfo entry): raw fatal/package-matched "
            "lines are preserved; UID/user binding unavailable; this MUST "
            "NOT upgrade any scientific verdict")

    return {
        "schema_version": "crash-artifact-1",
        "package": package,
        "artifact": {
            "label": label,
            "artifact_type": ("INSTRUMENTED_TEST_ARTIFACT"
                              if label == "instrumented"
                              else "ORIGINAL_APK" if label == "original"
                              else label),
            "installed_path": installed_path,
            "local_artifact": str(artifact_apk) if artifact_apk else None,
            "artifact_sha256": artifact_sha256,
        },
        # Unified per-side identity (end-to-end requirement 6): the SAME
        # identity fields the working-control round records, collected
        # read-only via dumpsys package for THIS side. Null when the
        # source is unavailable — never fabricated.
        "identity": identity or {},
        "session": session,
        "fatal_signal": tombstone.get("fatal_signal"),
        "fault_addr": tombstone.get("fault_addr"),
        "abort_message": tombstone.get("abort_message"),
        "abort_message_present": abort_present,
        "fault_location": fault_location,
        "apk_offset_resolution": offset_resolution,
        "crash_instances": crashes,
        "grouping": {
            "uids": uids,
            "users": users,
            "instance_count": len(crashes),
            "instances_completeness": instances_completeness,
            "sessions_detected": len({(c.get("uid"), c.get("pid"))
                                      for c in crashes}),
        },
        "integrity_notes": integrity_notes,
        "evidence_lines": {
            "fatal_lines": tombstone.get("fatal_lines") or [],
            "package_matched_lines": tombstone.get("package_matched_lines") or [],
        },
    }


# ------------------------------------------------------------------
# End-to-end coherence (mission: ReelSec End-to-End before a new run)
# ------------------------------------------------------------------
# One unified per-side schema is used by EVERY A/B comparison document
# (CRASH-COMPARISON and COMMON-CAUSE-COMPARISON). Both sides expose the
# SAME field set; a field the round did not collect is null — never a
# fabricated value and never a differently-named twin that silently
# makes the comparison incomplete.
UNIFIED_SIDE_FIELDS = (
    "package", "artifact_type", "artifact_sha256", "installed_path",
    "uid", "uids", "users", "version_name", "version_code",
    "primary_cpu_abi", "pids", "startup", "lifetime_ms", "fatal_signal",
    "fault_library", "fault_pc", "abort_message_present", "exit_reason",
    "logcat_evidence_lines",
)


def unified_side(**values):
    """Build a unified side record: every UNIFIED_SIDE_FIELDS key is
    present; anything not supplied stays null (never fabricated)."""
    side = {field: None for field in UNIFIED_SIDE_FIELDS}
    for key, val in values.items():
        if key in UNIFIED_SIDE_FIELDS:
            side[key] = val
    return side


def _crash_side_summary(art):
    """Unified per-artifact crash side (never merged across sides).

    Keeps each side's own package/user/UID/PID/APK-path/artifact-SHA and
    timing bindings exactly as collected for THAT artifact, in the
    UNIFIED_SIDE_FIELDS schema shared with the working-control side.
    """
    if not art:
        return None
    artifact = art.get("artifact") or {}
    identity = art.get("identity") or {}
    session = art.get("session") or {}
    grouping = art.get("grouping") or {}
    fl = art.get("fault_location") or {}
    res = art.get("apk_offset_resolution") or {}
    lines = art.get("evidence_lines") or {}
    seen = session.get("first_process_seen_epoch")
    if seen is None:
        stage = "CRASHED_BEFORE_PROCESS_OBSERVED"
    elif session.get("process_alive_at_exit"):
        stage = "STILL_ALIVE_AT_WINDOW_EXIT_THEN_CRASH_EXIT_INFO"
    else:
        stage = "CRASHED_AFTER_PROCESS_OBSERVED"
    instances = art.get("crash_instances") or []
    exit_reasons = sorted({i.get("reason_name") for i in instances
                           if i.get("reason_name")})
    side = unified_side(
        package=art.get("package"),
        artifact_type=artifact.get("artifact_type"),
        artifact_sha256=artifact.get("artifact_sha256"),
        installed_path=artifact.get("installed_path"),
        uid=identity.get("uid"),
        uids=grouping.get("uids"),
        users=grouping.get("users"),
        version_name=identity.get("version_name"),
        version_code=identity.get("version_code"),
        primary_cpu_abi=identity.get("primary_cpu_abi"),
        pids=sorted({i.get("pid") for i in instances
                     if i.get("pid") is not None}),
        startup="CRASH",
        lifetime_ms=session.get("observed_process_lifetime_ms"),
        fatal_signal=art.get("fatal_signal"),
        fault_library=fl.get("library") if fl else None,
        fault_pc=fl.get("pc") if fl else None,
        abort_message_present=bool(art.get("abort_message_present")),
        exit_reason=", ".join(exit_reasons) if exit_reasons else None,
        logcat_evidence_lines=len(lines.get("fatal_lines") or [])
                              + len(lines.get("package_matched_lines") or []),
    )
    # Side-specific extras (comparison inputs, identity bindings).
    side.update({
        "role": artifact.get("label"),
        "local_artifact": artifact.get("local_artifact"),
        "signing_certificate_sha256":
            identity.get("signing_certificate_sha256"),
        "fault_location": ({"library": fl.get("library"),
                            "pc": fl.get("pc"),
                            "symbol": fl.get("symbol")} if fl else None),
        "apk_offset_resolution": (
            {"status": res.get("status"), "entry": res.get("entry"),
             "offset_within_entry": res.get("offset_within_entry"),
             "reason": res.get("reason")} if res else None),
        "startup_stage": stage,
        "instance_count": grouping.get("instance_count"),
        "instances_completeness": grouping.get("instances_completeness"),
    })
    return side


def build_crash_comparison(instrumented_artifact, original_artifact):
    """CRASH-COMPARISON-1: original-vs-instrumented crash comparison.

    The two sides are compared but never merged: each keeps its own
    package/user/UID/PID/APK-path/artifact-SHA/timing bindings and its own
    `base.apk + 0x…` offset resolution (the original and the instrumented
    build are DIFFERENT files, so offsets are resolved independently
    against each side's own local artifact and identical values are never
    assumed). When BOTH sides crashed the status is explicitly BOTH_CRASH
    and the crash MUST NOT be attributed to instrumentation on this
    evidence; a common cause (device/OS/ROM or the app itself) must be
    investigated and only differential evidence may isolate
    instrumentation. Returns None when neither side has crash evidence.
    """
    ins = _crash_side_summary(instrumented_artifact)
    orig = _crash_side_summary(original_artifact)
    if ins is None and orig is None:
        return None

    if ins is not None and orig is not None:
        status = BOTH_CRASH
        attribution = {
            "instrumentation_regression": "NOT_ESTABLISHED",
            "guard": ("both the ORIGINAL and the INSTRUMENTED artifact "
                      "crashed on this device: the crash MUST NOT be "
                      "attributed to instrumentation; a common cause "
                      "(device/OS/ROM or the app itself) must be "
                      "investigated and only differential evidence may "
                      "isolate instrumentation"),
        }
    elif ins is not None:
        status = INSTRUMENTED_ONLY_CRASH
        attribution = {
            "instrumentation_regression": "SUSPECTED_NOT_PROVEN",
            "guard": ("only the instrumented artifact has crash evidence; "
                      "instrumentation is a candidate cause, not a proven "
                      "one, until a clean original round on the same "
                      "device/session is recorded"),
        }
    else:
        status = ORIGINAL_ONLY_CRASH
        attribution = {
            "instrumentation_regression": "NOT_ESTABLISHED",
            "guard": ("the ORIGINAL artifact crashed without any "
                      "instrumentation present: this crash is not caused "
                      "by instrumentation"),
        }

    def _fault_str(side):
        if not side or not side.get("fault_location"):
            return None
        return "%s+%s" % (side["fault_location"].get("library"),
                          side["fault_location"].get("pc"))

    def _res(side):
        return (side or {}).get("apk_offset_resolution") or {}

    both = ins is not None and orig is not None
    ins_res, orig_res = _res(ins), _res(orig)
    resolved_identically = bool(
        both
        and ins_res.get("status") == "RESOLVED"
        and orig_res.get("status") == "RESOLVED"
        and ins_res.get("entry") == orig_res.get("entry")
        and ins_res.get("offset_within_entry")
        == orig_res.get("offset_within_entry")
        and _fault_str(ins) is not None
        and _fault_str(ins) == _fault_str(orig))

    integrity_notes = []
    if status == BOTH_CRASH:
        integrity_notes.append(attribution["guard"])
    if not ((ins or {}).get("abort_message_present")
            or (orig or {}).get("abort_message_present")):
        integrity_notes.append(
            "no textual abort() message captured on either side; the cause "
            "MUST NOT be labeled anti-tamper or screenshot protection on "
            "this evidence")

    return {
        "schema_version": CRASH_COMPARISON_SCHEMA,
        "status": status,
        "source_documents": {
            "instrumented": "CRASH-ARTIFACT.json" if ins else None,
            "original": "BASELINE-CRASH-ARTIFACT.json" if orig else None,
        },
        "instrumented": ins,
        "original": orig,
        "questions": {
            "both_sigabrt": bool(
                both and ins["fatal_signal"] == "SIGABRT"
                and orig["fatal_signal"] == "SIGABRT"),
            "fatal_signals": {
                "instrumented": (ins or {}).get("fatal_signal"),
                "original": (orig or {}).get("fatal_signal"),
                "match": bool(both and ins["fatal_signal"] is not None
                              and ins["fatal_signal"]
                              == orig["fatal_signal"]),
            },
            "fault_location": {
                "instrumented": _fault_str(ins),
                "original": _fault_str(orig),
                "match": bool(both and _fault_str(ins) is not None
                              and _fault_str(ins) == _fault_str(orig)),
            },
            "startup_stage": {
                "instrumented": (ins or {}).get("startup_stage"),
                "original": (orig or {}).get("startup_stage"),
                "match": (bool(ins["startup_stage"] == orig["startup_stage"])
                          if both else None),
            },
            "abort_message": {
                "instrumented_captured":
                    bool((ins or {}).get("abort_message_present")),
                "original_captured":
                    bool((orig or {}).get("abort_message_present")),
                "captured_either": bool(
                    (ins or {}).get("abort_message_present")
                    or (orig or {}).get("abort_message_present")),
            },
            "apk_offset_resolution": {
                "instrumented": {
                    "status": ins_res.get("status"),
                    "entry": ins_res.get("entry"),
                    "offset_within_entry": ins_res.get("offset_within_entry"),
                },
                "original": {
                    "status": orig_res.get("status"),
                    "entry": orig_res.get("entry"),
                    "offset_within_entry": orig_res.get("offset_within_entry"),
                },
                "resolved_identically": resolved_identically,
                "note": ("offsets are resolved independently against each "
                         "side's own local artifact (different builds bound "
                         "by artifact_sha256); identical resolution shows "
                         "the same relative code location but never by "
                         "itself proves a shared cause"),
            },
        },
        "attribution": attribution,
        "integrity_notes": integrity_notes,
    }


def parse_package_identity(dumpsys_text):
    """Best-effort READ-ONLY identity parse of `dumpsys package` output.

    Extracts version, UID, codePath, ABI, signing certificate and the
    installed users. Missing fields stay None — nothing is invented.
    """
    text = dumpsys_text or ""

    def _one(pattern):
        m = re.search(pattern, text)
        return m.group(1) if m else None

    identity = {
        "version_name": _one(r"versionName=(\S+)"),
        "version_code": _one(r"versionCode=(\d+)"),
        "uid": _one(r"userId=(\d+)"),
        "code_path": _one(r"codePath=(\S+)"),
        "primary_cpu_abi": _one(r"primaryCpuAbi=([^\s,]+)"),
    }
    identity["users_installed"] = sorted(
        {int(m.group(1))
         for m in re.finditer(r"User (\d+):[^\n]*installed=true", text)})
    cert_sha = None
    cert_raw = None
    m = re.search(r"signatures=PackageSignatures\{[^}]*\}", text)
    if m:
        blob = m.group(0)
        runs = re.findall(r"[0-9a-fA-F]{64,}", blob)
        if runs:
            der = runs[0]
            der = der[: len(der) // 2 * 2]
            try:
                cert_sha = hashlib.sha256(
                    bytes.fromhex(der)).hexdigest()
            except ValueError:
                cert_sha = None
        cert_raw = blob[:120]
    identity["signing_certificate_sha256"] = cert_sha
    identity["signing_certificate_raw_prefix"] = cert_raw
    return identity


def collect_working_control(runner, adb, serial, package, observe_s=8,
                            local_reference_apk=None):
    """WORKING-CONTROL-1: observe the CURRENTLY INSTALLED package in place.

    The installed build is the working control: this collector performs
    READ-ONLY device queries only (pm path, dumpsys package, sha256sum)
    plus the bounded observational launch already used by the health gate
    (monkey launch + ps polling + ApplicationExitInfo + crash logcat).
    NO install, NO uninstall, NO clear-data, NO re-install, NO bypass,
    NO destructive authorization — the device state is never modified
    beyond starting the app once under observation.

    `local_reference_apk` (e.g. the untouched original.apk) is used for
    base.apk+0x… offset resolution ONLY when its SHA-256 equals the
    on-device APK SHA-256 — hash-bound, never assumed.
    """
    doc = {"schema_version": WORKING_CONTROL_SCHEMA,
           "package": package, "status": CONTROL_NOT_INSTALLED}
    rc, out = runner([adb, "-s", serial, "shell", "pm", "path", package])
    installed_path = None
    for line in (out or "").splitlines():
        line = line.strip()
        if line.startswith("package:") and line.endswith(".apk"):
            installed_path = line[len("package:"):]
            break
    if not installed_path:
        doc["reason"] = ("pm path reports no installed package; nothing was "
                         "launched and nothing was modified")
        return doc
    doc["installed_path"] = installed_path
    rc, out = runner([adb, "-s", serial, "shell", "dumpsys", "package",
                      package])
    doc["identity"] = parse_package_identity(out)
    rc, out = runner([adb, "-s", serial, "shell", "sha256sum",
                      installed_path])
    m = re.match(r"\s*([0-9a-fA-F]{64})\s", out or "")
    device_sha = m.group(1).lower() if m else None
    doc["identity"]["apk_sha256"] = device_sha
    # Hash-bound local reference: offsets are resolved against the local
    # original ONLY when it is byte-identical to the installed APK.
    artifact_apk = None
    if local_reference_apk and Path(local_reference_apk).is_file():
        local_sha = hashlib.sha256(
            Path(local_reference_apk).read_bytes()).hexdigest()
        matches = bool(device_sha) and local_sha == device_sha
        doc["identity"]["local_reference"] = {
            "path": str(local_reference_apk), "sha256": local_sha,
            "matches_installed": matches}
        if matches:
            artifact_apk = str(local_reference_apk)
        # Original-identity verification (test-model isolation): the
        # "working control" is only the ORIGINAL when the installed bytes
        # are hash-bound to the local original. A leftover instrumented
        # artifact from a previous campaign (same package name — Android
        # keeps ONE shared APK per package) must never be observed as the
        # original side; unverified identity yields NO original-side claim.
        doc["identity"]["original_verification"] = {
            "verified": bool(matches),
            "installed_sha256": device_sha,
            "reference_sha256": local_sha,
            "reference_path": str(local_reference_apk),
            "note": None if matches else (
                "installed build is NOT byte-identical to the local "
                "original reference; it may be a leftover instrumented "
                "artifact of the same package — original-side runtime is "
                "NOT established by this observation"),
        }
    health = assess_startup(runner, adb, serial, package,
                            label="working_control", observe_s=observe_s,
                            artifact_apk=artifact_apk,
                            artifact_sha256=device_sha)
    doc["status"] = (CONTROL_CRASHED if health.get("startup") == "CRASH"
                     else CONTROL_ASSESSED)
    doc["health"] = health
    doc["crash_artifact"] = health.get("crash_artifact")
    doc["process"] = {"pids": health.get("pids"),
                      "observed": health.get("process_observed"),
                      "alive_ms": health.get("process_alive_ms")}
    return doc


def _control_side_summary(control_doc):
    """Independent working-control summary (never merged with the other
    side)."""
    if not control_doc or control_doc.get("status") not in (
            CONTROL_ASSESSED, CONTROL_CRASHED):
        return None
    identity = control_doc.get("identity") or {}
    process = control_doc.get("process") or {}
    health = control_doc.get("health") or {}
    art = control_doc.get("crash_artifact") or {}
    fl = art.get("fault_location") or {}
    lines = (art.get("evidence_lines") or {})
    side = unified_side(
        package=control_doc.get("package"),
        artifact_type=control_doc.get("artifact_type", "ORIGINAL_APK"),
        artifact_sha256=identity.get("apk_sha256"),
        installed_path=control_doc.get("installed_path"),
        uid=identity.get("uid"),
        uids=([identity.get("uid")] if identity.get("uid") is not None
              else None),
        users=identity.get("users_installed"),
        version_name=identity.get("version_name"),
        version_code=identity.get("version_code"),
        primary_cpu_abi=identity.get("primary_cpu_abi"),
        pids=process.get("pids"),
        startup=health.get("startup"),
        lifetime_ms=process.get("alive_ms"),
        fatal_signal=art.get("fatal_signal"),
        fault_library=fl.get("library") if fl else None,
        fault_pc=fl.get("pc") if fl else None,
        abort_message_present=(bool(art.get("abort_message_present"))
                               if art else None),
        exit_reason=None,
        logcat_evidence_lines=(len(lines.get("fatal_lines") or [])
                               + len(lines.get("package_matched_lines")
                                     or [])) if art else None,
    )
    side.update({
        "role": "working_control",
        "status": control_doc.get("status"),
        "signing_certificate_sha256":
            identity.get("signing_certificate_sha256"),
        "local_reference_apk": identity.get("local_reference_apk"),
        "matches_installed": identity.get("matches_installed"),
        "code_path": identity.get("code_path"),
        "fault_location": ({"library": fl.get("library"),
                            "pc": fl.get("pc")} if fl else None),
    })
    return side


def build_common_cause_comparison(control_doc, instrumented_artifact):
    """COMMON-CAUSE-COMPARISON-1: installed working control vs instrumented.

    The CURRENTLY INSTALLED original (observed in place, untouched) is
    compared against the instrumented crash artifact. Sides are never
    merged; each keeps its own package/user/UID/PID/APK-path/SHA/timing
    bindings. Verdicts:
    * COMMON_CAUSE_BOTH_CRASH — both crash: MUST NOT be attributed to
      instrumentation; common cause (device/OS/ROM or the app itself).
    * CONTROL_HEALTHY_INSTRUMENTED_CRASH — control starts cleanly while
      the instrumented artifact crashes: instrumentation is a candidate
      cause, NOT proven.
    * CONTROL_ONLY_CRASH / CONTROL_HEALTHY_NO_INSTRUMENTED_EVIDENCE /
      COMMON_CAUSE_INCOMPLETE — explicit, never guessed.
    This comparison NEVER upgrades SCREENSHOT_BLOCKING: that verdict
    stays NOT_PROVEN until the full causal chain is evidenced.
    Returns None when neither side has usable evidence.
    """
    ctrl = _control_side_summary(control_doc)
    ins = _crash_side_summary(instrumented_artifact)
    if ctrl is None and ins is None:
        return None

    if ctrl is not None and ins is not None:
        if ctrl["status"] == CONTROL_CRASHED:
            status = COMMON_CAUSE_BOTH_CRASH
            attribution = {
                "instrumentation_regression": "NOT_ESTABLISHED",
                "guard": ("the installed original (working control) AND the "
                          "instrumented artifact crash on this device: the "
                          "crash MUST NOT be attributed to instrumentation; "
                          "a common cause (device/OS/ROM or the app itself) "
                          "must be investigated and only differential "
                          "evidence may isolate instrumentation"),
            }
        else:
            status = CONTROL_HEALTHY_INSTRUMENTED_CRASH
            attribution = {
                "instrumentation_regression": "SUSPECTED_NOT_PROVEN",
                "guard": ("the working control starts cleanly while the "
                          "instrumented artifact crashes: instrumentation "
                          "is a candidate cause, not a proven one, until "
                          "the differential is confirmed on the same "
                          "device/session"),
            }
    elif ctrl is not None:
        if ctrl["status"] == CONTROL_CRASHED:
            status = CONTROL_ONLY_CRASH
            attribution = {
                "instrumentation_regression": "NOT_ESTABLISHED",
                "guard": ("the working control crashed with no instrumented "
                          "crash evidence on record: this crash is not "
                          "caused by instrumentation"),
            }
        else:
            status = CONTROL_HEALTHY_NO_INSTRUMENTED_EVIDENCE
            attribution = {
                "instrumentation_regression": "NOT_APPLICABLE",
                "guard": ("the working control is healthy and no "
                          "instrumented crash evidence exists to compare"),
            }
    else:
        status = COMMON_CAUSE_INCOMPLETE
        attribution = {
            "instrumentation_regression": "NOT_ESTABLISHED",
            "guard": ("instrumented crash evidence exists but no working "
                      "control was collected: no common-cause claim may be "
                      "made until the control round runs"),
        }

    def _fault_str(side):
        if not side or not side.get("fault_location"):
            return None
        return "%s+%s" % (side["fault_location"].get("library"),
                          side["fault_location"].get("pc"))

    both = ctrl is not None and ins is not None
    integrity_notes = [
        "this comparison MUST NOT upgrade SCREENSHOT_BLOCKING; that verdict "
        "remains NOT_PROVEN until the full causal chain is evidenced"]
    if not ((ctrl or {}).get("abort_message_present")
            or (ins or {}).get("abort_message_present")):
        integrity_notes.append(
            "no textual abort() message captured on either side; the cause "
            "MUST NOT be labeled anti-tamper or screenshot protection on "
            "this evidence")

    return {
        "schema_version": COMMON_CAUSE_SCHEMA,
        "status": status,
        "source_documents": {
            "working_control": "WORKING-CONTROL.json" if ctrl else None,
            "instrumented": "CRASH-ARTIFACT.json" if ins else None,
        },
        "working_control": ctrl,
        "instrumented": ins,
        "questions": {
            "both_sigabrt": bool(
                both and ctrl["fatal_signal"] == "SIGABRT"
                and ins["fatal_signal"] == "SIGABRT"),
            "fault_location": {
                "working_control": _fault_str(ctrl),
                "instrumented": _fault_str(ins),
                "match": bool(both and _fault_str(ctrl) is not None
                              and _fault_str(ctrl) == _fault_str(ins)),
            },
            "abort_message": {
                "working_control_captured":
                    bool((ctrl or {}).get("abort_message_present")),
                "instrumented_captured":
                    bool((ins or {}).get("abort_message_present")),
                "captured_either": bool(
                    (ctrl or {}).get("abort_message_present")
                    or (ins or {}).get("abort_message_present")),
            },
            "apk_identity": {
                "working_control_sha256":
                    (ctrl or {}).get("artifact_sha256"),
                "instrumented_sha256":
                    (ins or {}).get("artifact_sha256"),
                "note": ("different artifacts by construction: the control "
                         "is the installed original APK, the instrumented "
                         "side is the re-signed test build"),
            },
        },
        "attribution": attribution,
        "integrity_notes": integrity_notes,
    }


def classify_crash(package, exit_entries, tombstone, process_observed,
                   pids=None, package_present=True, stage="PROCESS_HEALTH_GATE"):
    """Deterministic crash classification from collected evidence.

    Returns a dict with the required audit fields: crash_class, confidence,
    reason, evidence_source, timestamp, pid, user, package, stage.
    Priority: ApplicationExitInfo (authoritative) > logcat tombstone >
    process observation. Never invents a class when evidence is absent.
    """
    pids = pids or []
    base = {"package": package, "stage": stage, "timestamp": None, "pid": None,
            "user": None, "crash_class": None, "confidence": CONF_NONE,
            "reason": None, "evidence_source": None, "exit_reason_code": None,
            "exit_reason_name": None, "exit_status": None}
    if not package_present:
        base.update(crash_class=PACKAGE_NOT_PRESENT, confidence=CONF_HIGH,
                    reason="pm path reports no installed package",
                    evidence_source="adb:pm path")
        return base

    crash_entry = None
    for e in exit_entries or []:
        if e.get("reason_code") in (5, 4, 6, 7, 2):
            crash_entry = e
            break
        if e.get("reason_code") in (3, 12, 13) and crash_entry is None:
            crash_entry = e
    if crash_entry is not None:
        code = crash_entry.get("reason_code")
        cls = {5: NATIVE_CRASH, 4: JAVA_EXCEPTION, 6: ANR,
               7: STARTUP_FAILURE}.get(code)
        if cls is None:
            cls = PROCESS_KILLED
        base.update(
            crash_class=cls, confidence=CONF_HIGH,
            reason="ApplicationExitInfo reason=%s (%s)" % (
                code, crash_entry.get("reason_name") or EXIT_INFO_REASONS.get(code)),
            evidence_source="adb:dumpsys activity exit-info (ApplicationExitInfo)",
            timestamp=crash_entry.get("timestamp"), pid=crash_entry.get("pid"),
            user=crash_entry.get("user"),
            exit_reason_code=code, exit_reason_name=crash_entry.get("reason_name"),
            exit_status=crash_entry.get("status"),
        )
        if crash_entry.get("trace"):
            base["tombstone_path"] = crash_entry["trace"]
        return base

    if tombstone and tombstone.get("fatal_signal") and tombstone.get("package_associated"):
        base.update(
            crash_class=NATIVE_CRASH, confidence=CONF_MEDIUM,
            reason="fatal signal %s in logcat associated with package" %
                   tombstone["fatal_signal"],
            evidence_source="adb:logcat -b crash (tombstone echo)",
            pid=tombstone.get("pid"),
        )
        return base

    if not process_observed:
        base.update(
            crash_class=PROCESS_NOT_OBSERVED, confidence=CONF_MEDIUM,
            reason="launch invoked but no process observed in bounded window; "
                   "no exit-info entry and no fatal signal captured",
            evidence_source="adb:ps polling + exit-info + logcat",
        )
        return base

    base.update(crash_class=HEALTHY, confidence=CONF_MEDIUM,
                reason="process observed alive; no new crash exit-info entry "
                       "and no package-associated fatal signal",
                evidence_source="adb:ps polling + exit-info + logcat")
    if pids:
        base["pid"] = pids[0]
    return base


def identify_crash_cause(classification, tombstone=None, maps_text=None,
                         frida_events=None, exit_entries=None):
    """Attribute the crash to a library/cause using only available sources.

    Never depends on /data/tombstones being readable (non-root devices).
    If attribution is impossible: CRASH_CAUSE_UNKNOWN with the searched
    source list. Never invents a cause.
    """
    searched = []
    evidence = []
    tombstone = tombstone or {}
    cause = CAUSE_UNKNOWN
    fault_library = None
    confidence = CONF_NONE

    if tombstone.get("backtrace_frames"):
        searched.append("logcat backtrace frames")
        first = tombstone["backtrace_frames"][0]
        fault_library = first["library"]
        evidence.append("first backtrace frame: #%s pc %s in %s" % (
            "00", first["pc"], first["library_path"]))
        if tombstone.get("package_associated"):
            cause = "NATIVE_LIBRARY:%s" % fault_library
            confidence = CONF_HIGH
        else:
            cause = "NATIVE_LIBRARY:%s" % fault_library
            confidence = CONF_MEDIUM
            evidence.append("crash lines not explicitly package-associated; "
                            "attribution downgraded to MEDIUM")
    elif tombstone.get("fatal_signal"):
        searched.append("logcat fatal signal")
        evidence.append("fatal signal %s captured without backtrace frames" %
                        tombstone["fatal_signal"])
        cause = "NATIVE_SIGNAL:%s" % tombstone["fatal_signal"]
        confidence = CONF_LOW

    if tombstone.get("abort_message"):
        searched.append("logcat abort message")
        evidence.append("abort message: %s" % tombstone["abort_message"])
        if cause == CAUSE_UNKNOWN:
            cause = "NATIVE_ABORT"
            confidence = CONF_LOW

    for e in exit_entries or []:
        if e.get("trace"):
            searched.append("ApplicationExitInfo trace field")
            evidence.append("tombstone recorded at %s (not read; non-root)" %
                            e["trace"])
            break

    if maps_text:
        searched.append("/proc/<pid>/maps (alive window)")
        libs = sorted({ln.split()[-1].rsplit("/", 1)[-1]
                       for ln in maps_text.splitlines()
                       if ln.strip().endswith(".so")})
        evidence.append("loaded native modules during life: %s" %
                        (", ".join(libs[:30]) or "none"))
    else:
        searched.append("/proc/<pid>/maps (unavailable without privilege)")

    if frida_events:
        searched.append("frida observation (pre-crash)")
        observed = [ev.get("module") for ev in frida_events
                    if ev.get("event") == "MODULE_OBSERVED"]
        evidence.append("modules observed before crash: %s" %
                        (", ".join(str(m) for m in observed) or "none"))

    if not searched:
        searched.append("no crash sources available")

    return {
        "cause": cause,
        "fault_library": fault_library,
        "confidence": confidence,
        "evidence": evidence[:15],
        "searched_sources": searched,
    }


def query_exit_info(runner, adb, serial, package):
    rc, out = runner([adb, "-s", serial, "shell", "dumpsys", "activity",
                      "exit-info", package], timeout=30)
    return {
        "entries": parse_exit_info(out) if rc == 0 else [],
        "returncode": rc,
        "source": "adb:dumpsys activity exit-info %s" % package,
        "available": rc == 0,
    }


def _launch_package(runner, adb, serial, package):
    started = time.time()
    rc, out = runner([adb, "-s", serial, "shell", "monkey", "-p", package,
                      "-c", "android.intent.category.LAUNCHER", "1"], timeout=20)
    return rc, (out or "")[-2000:], started


def _poll_process(runner, adb, serial, package, observe_s, interval=1.0):
    deadline = time.time() + observe_s
    first_seen = last_seen = None
    pids = []
    attempts = 0
    while time.time() < deadline:
        attempts += 1
        rc, out = runner([adb, "-s", serial, "shell", "ps", "-A"], timeout=20)
        pids = []
        for line in (out or "").splitlines():
            parts = line.split()
            if len(parts) >= 9 and parts[-1] == package:
                try:
                    pids.append(int(parts[1]))
                except ValueError:
                    pass
        now = time.time()
        if pids:
            if first_seen is None:
                first_seen = now
            last_seen = now
        time.sleep(interval)
    alive_at_exit = bool(pids)
    alive_ms = int((last_seen - first_seen) * 1000) if first_seen else 0
    return {"pids": pids, "observed": first_seen is not None,
            "alive_ms": alive_ms, "alive_at_exit": alive_at_exit,
            "poll_attempts": attempts,
            "first_seen_epoch": first_seen, "last_seen_epoch": last_seen}


def assess_startup(runner, adb, serial, package, label="instrumented",
                   launch=True, observe_s=8, interval=1.0, pre_entries=None,
                   artifact_apk=None, artifact_sha256=None):
    """Process Health Gate: launch, observe bounded, classify death.

    Returns the RUNTIME-HEALTH record (requirement 9). Read-only against the
    device except the launch itself. Never retries unboundedly, never
    suppresses crashes, never waits for a probe timeout. When a fatal signal
    or fresh crash exit-info is observed, a CRASH-ARTIFACT-1 record is
    attached automatically (per package/UID/session, abort message extracted
    only if captured, base.apk offsets resolved against the local artifact).
    """
    started = time.time()
    if pre_entries is None:
        pre = query_exit_info(runner, adb, serial, package)
    else:
        pre = {"entries": pre_entries, "available": True, "returncode": 0,
               "source": "caller-provided snapshot"}

    # Pre-launch crash-buffer snapshot (read-only): tombstones already in
    # the buffer belong to EARLIER sessions and must never be attributed
    # to this one (timeline-truth mandate). Evidence is preserved, not
    # deleted — only the attribution is session-bound.
    pre_crash_rc, pre_crash_text = runner(
        [adb, "-s", serial, "logcat", "-b", "crash", "-d", "-t", "400"],
        timeout=40)

    launch_rc = launch_output = None
    if launch:
        launch_rc, launch_output, _ = _launch_package(runner, adb, serial, package)

    proc = _poll_process(runner, adb, serial, package, observe_s, interval)

    post = query_exit_info(runner, adb, serial, package)
    fresh = new_exit_entries(pre.get("entries"), post.get("entries"))

    rc, crash_text = runner([adb, "-s", serial, "logcat", "-b", "crash", "-d",
                             "-t", "400"], timeout=40)
    tombstone_full = parse_tombstone_logcat(crash_text, package) if rc == 0 \
        else parse_tombstone_logcat("", package)
    tombstone_full["source"] = "adb:logcat -b crash -d -t 400" if rc == 0 \
        else "crash buffer unavailable (rc=%s)" % rc
    tombstone, crash_binding = _session_tombstone_binding(
        pre_crash_text, pre_crash_rc, crash_text, rc, package, proc, fresh)
    # Descriptor tombstone (frames/offsets/abort message): the session
    # tombstone when present; otherwise the raw-buffer tombstone ONLY when
    # its pid provably belongs to this session's crashing process.
    crash_pids = set(proc.get("pids") or [])
    crash_pids |= {e.get("pid") for e in fresh if e.get("pid")}
    descriptor = tombstone
    if not descriptor.get("fatal_signal") and \
            tombstone_full.get("fatal_signal") and \
            tombstone_full.get("pid") in crash_pids:
        descriptor = tombstone_full
        crash_binding = dict(crash_binding)
        crash_binding["descriptor_source"] = "RAW_BUFFER_PID_MATCH"

    maps_text = None
    if proc["pids"]:
        mrc, mout = runner([adb, "-s", serial, "shell", "cat",
                            "/proc/%d/maps" % proc["pids"][0]], timeout=15)
        if mrc == 0 and mout:
            maps_text = mout[-20000:]

    classification = classify_crash(package, fresh, tombstone, proc["observed"],
                                    pids=proc["pids"])
    cause = identify_crash_cause(classification, tombstone=descriptor,
                                 maps_text=maps_text, exit_entries=fresh)

    # Bound the installed APK path (read-only) for crash-evidence binding.
    irc, ipath = runner([adb, "-s", serial, "shell", "pm", "path", package],
                        timeout=20)
    installed_path = None
    for line in (ipath or "").splitlines():
        if line.startswith("package:"):
            installed_path = line.split(":", 1)[1].strip()
            break

    # Unified per-side identity (end-to-end requirement 6): every side —
    # baseline, instrumented, working control — records the SAME identity
    # fields (uid, version, ABI, users) read-only via dumpsys package.
    drc, dout = runner([adb, "-s", serial, "shell", "dumpsys", "package",
                        package], timeout=30)
    identity = parse_package_identity(dout if drc == 0 else "")
    if installed_path:
        src, sha = runner([adb, "-s", serial, "shell", "sha256sum",
                           installed_path], timeout=120)
        if src == 0 and sha and sha.strip().split():
            identity["apk_sha256"] = sha.strip().split()[0]

    crashed = classification["crash_class"] in (NATIVE_CRASH, JAVA_EXCEPTION,
                                                ANR, STARTUP_FAILURE,
                                                PROCESS_KILLED)

    # Automatic crash evidence: built ONLY from session-bound crash
    # evidence (fresh exit-info entries or a session-bound tombstone).
    # Stale crash-buffer tombstones from earlier sessions never create a
    # crash artifact for this session.
    crash_artifact = None
    if crashed or (tombstone.get("fatal_signal")
                   and tombstone.get("package_associated")):
        crash_artifact = build_crash_artifact(
            package, label, fresh, descriptor,
            installed_path=installed_path,
            artifact_apk=artifact_apk,
            artifact_sha256=artifact_sha256,
            identity=identity,
            session={
                "started_at_epoch": started,
                "observe_s": observe_s,
                "launch_returncode": launch_rc,
                "first_process_seen_epoch": proc.get("first_seen_epoch"),
                "last_process_seen_epoch": proc.get("last_seen_epoch"),
                "observed_process_lifetime_ms": proc.get("alive_ms"),
                "process_alive_at_exit": proc.get("alive_at_exit"),
            })
    if classification["crash_class"] == PACKAGE_NOT_PRESENT:
        startup = "PACKAGE_NOT_PRESENT"
    elif crashed:
        startup = "CRASH"
    elif classification["crash_class"] == PROCESS_NOT_OBSERVED:
        startup = "NOT_STARTED"
    else:
        startup = "PASS"

    health = {
        "schema_version": SCHEMA,
        "package": package,
        "artifact_type": "INSTRUMENTED_TEST_ARTIFACT" if label == "instrumented"
                         else "ORIGINAL_APK" if label == "original" else label,
        "startup": startup,
        "process_observed": proc["observed"],
        "process_alive_ms": proc["alive_ms"],
        "process_alive_at_exit": proc["alive_at_exit"],
        "pids": proc["pids"],
        "launch_returncode": launch_rc,
        "installed_apk_path": installed_path,
        "session_timing": {
            "started_at_epoch": started,
            "first_process_seen_epoch": proc.get("first_seen_epoch"),
            "last_process_seen_epoch": proc.get("last_seen_epoch"),
        },
        "crash_artifact": crash_artifact,
        "installed_identity": identity,
        "exit_reason": ("reason=%s (%s)" % (
            classification["exit_reason_code"], classification["exit_reason_name"])
            if classification.get("exit_reason_code") is not None else None),
        "exit_status": classification.get("exit_status"),
        "crash_class": classification["crash_class"],
        "crash_source": classification["evidence_source"],
        "crash_cause": cause["cause"],
        "crash_cause_library": cause["fault_library"],
        "crash_cause_confidence": cause["confidence"],
        "crash_session_binding": crash_binding,
        "classification": classification,
        "cause_analysis": cause,
        "runtime_probe_allowed": startup == "PASS",
        "elapsed_ms": int((time.time() - started) * 1000),
        "evidence": {
            "exit_info_pre_count": len(pre.get("entries") or []),
            "exit_info_new_entries": fresh[:10],
            "exit_info_source": post.get("source"),
            # raw buffer parse — preserved in full, never deleted; stale
            # entries stay visible but are excluded from attribution.
            "tombstone": tombstone_full,
            "session_tombstone": tombstone,
            "crash_buffer_binding": crash_binding,
            "maps_captured": bool(maps_text),
        },
    }
    return health


def static_artifact_profile(apk_path, manifest_decoder=None):
    """Read-only static profile of an APK for baseline comparison."""
    apk = Path(apk_path)
    prof = {"artifact": str(apk), "exists": apk.is_file(), "package": None,
            "abis": [], "native_libs": [], "signature_blocks": False,
            "sha256": None, "size_bytes": None}
    if not apk.is_file():
        return prof
    h = hashlib.sha256()
    with apk.open("rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    prof["sha256"] = h.hexdigest()
    prof["size_bytes"] = apk.stat().st_size
    try:
        with zipfile.ZipFile(apk) as zf:
            names = zf.namelist()
            prof["native_libs"] = sorted(n for n in names
                                         if n.startswith("lib/") and n.endswith(".so"))
            prof["abis"] = sorted({n.split("/")[1] for n in prof["native_libs"]
                                   if len(n.split("/")) >= 3})
            prof["signature_blocks"] = any(
                n.upper().startswith("META-INF/") and
                n.upper().endswith((".RSA", ".DSA", ".EC")) for n in names)
            if manifest_decoder is not None:
                try:
                    data = zf.read("AndroidManifest.xml")
                    prof["package"] = manifest_decoder(data)
                except Exception:
                    pass
    except zipfile.BadZipFile as exc:
        prof["zip_error"] = str(exc)
    return prof


def compare_artifacts(baseline_health, instrumented_health,
                      baseline_profile=None, instrumented_profile=None):
    """Baseline vs instrumented runtime+static comparison (requirement 4).

    ORIGINAL_STARTUP=PASS + INSTRUMENTED_STARTUP=CRASH =>
    INSTRUMENTATION_REGRESSION_CONFIRMED. Both crash =>
    BASELINE_RUNTIME_FAILURE (never attributed to ReelSec).
    """
    def _s(h):
        return (h or {}).get("startup")
    bs, ins = _s(baseline_health), _s(instrumented_health)
    if bs is None or ins is None:
        status = NOT_COMPARABLE
        note = "missing health record: %s" % (
            "baseline" if bs is None else "instrumented")
    elif bs == "PASS" and ins == "CRASH":
        status = REGRESSION_CONFIRMED
        note = ("original artifact starts cleanly while the instrumented "
                "artifact crashes: regression introduced by instrumentation "
                "(see INSTRUMENTATION-IMPACT.json for change linkage)")
    elif bs == "CRASH" and ins == "CRASH":
        status = BASELINE_RUNTIME_FAILURE
        note = ("both artifacts crash: baseline runtime failure; NOT "
                "attributed to ReelSec instrumentation")
    elif bs == "PASS" and ins == "PASS":
        status = BOTH_START_OK
        note = "both artifacts start cleanly"
    elif bs == "CRASH" and ins == "PASS":
        status = BASELINE_CRASH_INSTRUMENTED_OK
        note = "baseline crashes but instrumented artifact starts: record and investigate baseline"
    else:
        status = NOT_COMPARABLE
        note = "non-crash startup states: baseline=%s instrumented=%s" % (bs, ins)

    diff = {}
    if baseline_profile and instrumented_profile:
        bl = set(baseline_profile.get("native_libs") or [])
        il = set(instrumented_profile.get("native_libs") or [])
        diff = {
            "package_same": (baseline_profile.get("package") ==
                             instrumented_profile.get("package")),
            "baseline_package": baseline_profile.get("package"),
            "instrumented_package": instrumented_profile.get("package"),
            "abis_baseline": baseline_profile.get("abis"),
            "abis_instrumented": instrumented_profile.get("abis"),
            "missing_in_instrumented": sorted(bl - il),
            "added_in_instrumented": sorted(il - bl),
            "lib_count_baseline": len(bl),
            "lib_count_instrumented": len(il),
        }
    return {
        "schema_version": SCHEMA,
        "regression_status": status,
        "attribution_note": note,
        "baseline": {
            "startup": bs,
            "crash_class": (baseline_health or {}).get("crash_class"),
            "crash_cause": (baseline_health or {}).get("crash_cause"),
            "exit_reason": (baseline_health or {}).get("exit_reason"),
            "process_alive_ms": (baseline_health or {}).get("process_alive_ms"),
        },
        "instrumented": {
            "startup": ins,
            "crash_class": (instrumented_health or {}).get("crash_class"),
            "crash_cause": (instrumented_health or {}).get("crash_cause"),
            "exit_reason": (instrumented_health or {}).get("exit_reason"),
            "process_alive_ms": (instrumented_health or {}).get("process_alive_ms"),
        },
        "profile_diff": diff,
    }


# --------------------------------------------------------------- state machine
# End-to-end requirement 4: ONE explicit campaign state machine. The pipeline
# state is derived here from the collected documents — never from scattered
# booleans — and every transition carries a reason.

CAMPAIGN_STATES = (
    "SAFETY_BLOCKED",
    "NO_DEVICE",
    "DEVICE_READY",
    "CONTROL_NOT_INSTALLED",
    "CONTROL_HEALTHY",
    "CONTROL_CRASHED",
    # Test-model isolation: control observed but not hash-bound to the
    # original (possible leftover instrumented build of the same package).
    "CONTROL_IDENTITY_UNVERIFIED",
    # Real-timeline states (timeline-truth mandate): the baseline round
    # installs and runs the original AFTER CONTROL_NOT_INSTALLED, and the
    # instrumented install is an explicit replacement step.
    "ORIGINAL_HEALTHY",
    "ORIGINAL_CRASHED",
    "INSTRUMENTED_INSTALLED",
    "INSTRUMENTED_NOT_RUN",
    "INSTRUMENTED_HEALTHY",
    "INSTRUMENTED_CRASHED",
    "COMMON_CAUSE_BOTH_CRASH",
    "INSTRUMENTATION_ONLY_CRASH",
    "ORIGINAL_ONLY_CRASH",
    "COMPARISON_INCOMPLETE",
    "CAUSAL_CHAIN_INCOMPLETE",
    "PROVEN",
)


def campaign_state_machine(safety=None, device_ok=None, working_control=None,
                           baseline_health=None, deploy_status=None,
                           instrumented_health=None, common_cause=None,
                           crash_comparison=None, evidence=None, deploy=None):
    """Derive the single campaign state with an auditable transition log.

    Inputs are the collected documents (dicts or None). The machine walks
    Safety -> Device -> Control -> Original (baseline round) ->
    Instrumented install -> Instrumented run -> Comparison -> Science and
    stops at the first terminal state; every step records its reason.

    Timeline-truth mandate: CONTROL_NOT_INSTALLED never means "the original
    never ran" — the baseline round may have installed and run it, which is
    expressed as ORIGINAL_HEALTHY / ORIGINAL_CRASHED. Recorded health
    documents are audited for stale-tombstone attribution before driving
    transitions, and audited evidence outranks derived comparison documents
    written before the audit existed.
    """
    transitions = []

    def move(to, reason):
        transitions.append({"from": transitions[-1]["to"] if transitions
                            else None, "to": to, "reason": reason})
        return to

    if safety is not None and safety.get("safety") == "BLOCKED":
        move("SAFETY_BLOCKED", "safety gate blocked the run: %s"
             % (safety.get("reason") or "environment violation"))
        return _state_result(transitions)

    if device_ok is False:
        move("NO_DEVICE", "no online authorized Android device reachable")
        return _state_result(transitions)
    if device_ok is True:
        move("DEVICE_READY", "adb device online and authorized")

    wc = working_control or {}
    wc_status = wc.get("status")
    wc_side, wc_note = (audited_original_side(working_control)
                        if wc_status in (CONTROL_ASSESSED, CONTROL_CRASHED)
                        else (None, None))
    if wc_status in (CONTROL_ASSESSED, CONTROL_CRASHED) and wc_side is None:
        move("CONTROL_IDENTITY_UNVERIFIED",
             "installed control is not hash-bound to the local original "
             "reference — it may be a leftover instrumented build of the "
             "same package; original-side runtime NOT established (%s)"
             % (wc_note or "identity unverified"))
    elif wc_status == CONTROL_NOT_INSTALLED:
        move("CONTROL_NOT_INSTALLED",
             "pm path reports no installed original package at control time "
             "(this does NOT mean the original never ran: a baseline round "
             "may install and run it afterwards)")
    elif wc_status == CONTROL_ASSESSED:
        move("CONTROL_HEALTHY",
             "installed original observed starting cleanly in place")
    elif wc_status == CONTROL_CRASHED:
        move("CONTROL_CRASHED",
             "installed original itself crashed under observation")

    # --- Original-side timeline (baseline round after CONTROL_NOT_INSTALLED)
    bh = baseline_health or {}
    bh_audit = audit_startup_classification(bh) if bh else {}
    original_side, original_note = audited_original_side(
        working_control, baseline_health=bh or None)
    if wc_status == CONTROL_NOT_INSTALLED and bh:
        if original_side == "PASS":
            move("ORIGINAL_HEALTHY",
                 "baseline round installed the original APK and observed it "
                 "running cleanly within the bounded window"
                 + (" [audit: %s]" % original_note if original_note else ""))
        elif original_side == "CRASH":
            move("ORIGINAL_CRASHED",
                 "baseline round installed the original APK and it crashed "
                 "under session-bound evidence (class=%s)"
                 % bh.get("crash_class"))

    # --- Instrumented install (package replacement via install -r) ---------
    ih = instrumented_health or {}
    ih_audit = audit_startup_classification(ih) if ih else {}
    ins_startup = ih_audit.get("audited_startup") or ih.get("startup")
    deploy = deploy or {}
    eff_deploy_status = deploy_status or deploy.get("status")
    semantics = deploy.get("install_semantics") or {}
    if eff_deploy_status == "INSTALLED" or ih:
        reason = ("instrumented runtime session recorded: the instrumented "
                  "artifact was installed")
        if eff_deploy_status == "INSTALLED":
            reason = ("instrumented artifact installed over the package via "
                      "replace-install (install -r): every subsequent launch "
                      "runs the instrumented build")
            if semantics:
                reason += (" [%s: shared APK of users %s — original and "
                           "instrumented can never coexist; post-replacement "
                           "crashes on ANY user belong to the instrumented "
                           "build]"
                           % (semantics.get("mode"),
                              semantics.get("shared_apk_users")))
        move("INSTRUMENTED_INSTALLED", reason)

    if not ih:
        move("INSTRUMENTED_NOT_RUN", "no instrumented runtime health recorded")
    elif ins_startup == "CRASH":
        move("INSTRUMENTED_CRASHED",
             "instrumented artifact crashed (class=%s)"
             % ih.get("crash_class"))
    elif ins_startup == "PASS":
        move("INSTRUMENTED_HEALTHY",
             "instrumented artifact started cleanly")
    else:
        move("INSTRUMENTED_NOT_RUN",
             "instrumented startup not established (%s)"
             % (ins_startup or "NOT_RUN"))

    cc = common_cause or {}
    cc_status = cc.get("status")
    if original_side == "PASS" and ins_startup == "CRASH":
        # Audited evidence outranks derived comparison documents: an
        # original observed healthy in its window plus an instrumented-only
        # crash is an instrumentation-side timeline, whatever a pre-audit
        # BOTH_CRASH document recorded.
        contradicted = cc_status == "COMMON_CAUSE_BOTH_CRASH" or \
            (crash_comparison or {}).get("status") == "BOTH_CRASH"
        move("INSTRUMENTATION_ONLY_CRASH",
             "session-bound timeline: the original ran healthy within its "
             "observation window while only the instrumented artifact "
             "crashed after installation; instrumentation is the candidate "
             "regression"
             + ("; the recorded BOTH_CRASH comparison predates the "
                "session-bound audit (%s)" % original_note
                if contradicted and original_note else
                "; the recorded BOTH_CRASH comparison predates the "
                "session-bound audit" if contradicted else ""))
    elif cc_status == "COMMON_CAUSE_BOTH_CRASH":
        move("COMMON_CAUSE_BOTH_CRASH",
             "installed original AND instrumented artifact crash with a "
             "common cause; instrumentation regression NOT_ESTABLISHED")
    elif cc_status == "CONTROL_HEALTHY_INSTRUMENTED_CRASH":
        move("INSTRUMENTATION_ONLY_CRASH",
             "control starts cleanly while the instrumented artifact "
             "crashes: instrumentation is a candidate, not proven")
    elif cc_status == "CONTROL_ONLY_CRASH":
        move("ORIGINAL_ONLY_CRASH",
             "only the installed original crashed; no instrumented crash "
             "evidence in this session")
    elif cc_status == "COMMON_CAUSE_INCOMPLETE":
        move("COMPARISON_INCOMPLETE",
             "common-cause comparison incomplete: %s"
             % ((cc.get("attribution") or {}).get("guard")
                or "missing side evidence"))
    elif (crash_comparison or {}).get("status") in (
            "BOTH_CRASH", "INSTRUMENTED_ONLY_CRASH", "ORIGINAL_ONLY_CRASH"):
        move(crash_comparison.get("status") if crash_comparison.get("status")
             in ("COMMON_CAUSE_BOTH_CRASH", "INSTRUMENTATION_ONLY_CRASH",
                 "ORIGINAL_ONLY_CRASH") else
             {"BOTH_CRASH": "COMMON_CAUSE_BOTH_CRASH",
              "INSTRUMENTED_ONLY_CRASH": "INSTRUMENTATION_ONLY_CRASH",
              "ORIGINAL_ONLY_CRASH": "ORIGINAL_ONLY_CRASH"}
             [crash_comparison.get("status")],
             "baseline-vs-instrumented crash comparison recorded")
    elif ins_startup == "CRASH":
        move("COMPARISON_INCOMPLETE",
             "instrumented crash without any original-side comparison")

    ev = evidence or {}
    if ev.get("causal_proof") is True:
        move("PROVEN", "full causal chain L1-L4 confirmed by evidence report")
    elif ev:
        move("CAUSAL_CHAIN_INCOMPLETE",
             "evidence report present; causal chain not complete (%s)"
             % ", ".join(ev.get("missing") or [])[:200] or "links unproven")
    else:
        move("CAUSAL_CHAIN_INCOMPLETE",
             "no evidence report: causal chain not evaluated")
    return _state_result(transitions)


def _state_result(transitions):
    return {"state": transitions[-1]["to"],
            "reason": transitions[-1]["reason"],
            "transitions": transitions}


def runtime_verdict(baseline_health, instrumented_health, comparison=None,
                    runtime_probe=None, probe_allowed=None,
                    crash_comparison=None, working_control=None,
                    common_cause=None, deploy_status=None, deploy=None,
                    sign=None):
    """Compact autonomous verdict (requirement 12).

    Timeline-truth mandate: recorded health documents are audited for
    stale-tombstone attribution BEFORE driving the verdict; CONTROL_NOT_
    INSTALLED never implies the original never ran (the baseline round may
    have installed and run it); ORIGINAL_RUNTIME=CRASH survives only when
    crash evidence is bound to the original's process after its launch.
    Evidence documents are never rewritten — corrections are annotated.
    """
    # --- Session-bound audit of recorded startups (legacy correction) ----
    b_audit = (audit_startup_classification(baseline_health)
               if baseline_health else None)
    i_audit = (audit_startup_classification(instrumented_health)
               if instrumented_health else None)
    audit_notes = []
    b_view = baseline_health
    if b_audit and b_audit["contradictions"]:
        b_view = dict(baseline_health)
        b_view["startup"] = b_audit["audited_startup"]
        audit_notes.append("ORIGINAL: " + b_audit["reason"])
    i_view = instrumented_health
    if i_audit and i_audit["contradictions"]:
        i_view = dict(instrumented_health)
        i_view["startup"] = i_audit["audited_startup"]
        audit_notes.append("INSTRUMENTED: " + i_audit["reason"])
    if audit_notes:
        # The caller-provided comparison was computed from the unaudited
        # documents; recompute from the corrected views.
        comparison = compare_artifacts(b_view, i_view)
    comparison = comparison or compare_artifacts(b_view, i_view)
    ih = i_view or {}
    if probe_allowed is None:
        probe_allowed = ih.get("runtime_probe_allowed")
    proof = "NOT_RUN"
    if runtime_probe:
        st = runtime_probe.get("status")
        if st == "PROVEN_RUNTIME_TARGET_DISPATCH":
            proof = "TARGET_OBSERVED"
        elif st == "RUNTIME_ARTIFACT_CRASH":
            proof = "BLOCKED_BY_ARTIFACT_CRASH"
        elif st in ("RUNTIME_PROBE_TIMEOUT_NO_TARGET_OBSERVED",
                    "RUNTIME_TARGET_NOT_OBSERVED"):
            proof = "NOT_OBSERVED"
        else:
            proof = st or "NOT_RUN"

    # ---------------------------------------------------------------
    # End-to-end fix (requirement 3): the verdict consumes the NEW
    # comparison documents FIRST. WORKING-CONTROL.json is the
    # authoritative original-side runtime record when the baseline
    # round was skipped; COMMON_CAUSE_BOTH_CRASH forces
    # REGRESSION_STATUS=NOT_ESTABLISHED (never NOT_COMPARABLE); and
    # NEXT_ACTION never recommends a destructive baseline or any
    # uninstall permission flag.
    # ---------------------------------------------------------------
    cc_status = (common_cause or {}).get("status")
    wc_status = (working_control or {}).get("status")

    # Audited original-side truth: control document first (audited), then
    # the baseline round. CONTROL_NOT_INSTALLED alone never maps to a
    # runtime claim about the original.
    original_side, original_note = audited_original_side(
        working_control, baseline_health=b_view)
    if original_note:
        audit_notes.append("ORIGINAL_SIDE: " + original_note)
    # A BOTH_CRASH common-cause document built on a misattributed
    # original-side crash is downgraded to the audited timeline.
    effective_cc = cc_status
    if cc_status == "COMMON_CAUSE_BOTH_CRASH" and original_side == "PASS" \
            and ih.get("startup") == "CRASH":
        effective_cc = "CONTROL_HEALTHY_INSTRUMENTED_CRASH"
        audit_notes.append(
            "COMMON_CAUSE: recorded COMMON_CAUSE_BOTH_CRASH downgraded — the "
            "original-side crash was contradicted by the session-bound audit")

    original_runtime = (b_view or {}).get("startup")
    original_source = "BASELINE_ROUND" if original_runtime else None
    if not original_runtime:
        original_runtime = {
            CONTROL_ASSESSED: "PASS",
            CONTROL_CRASHED: "CRASH",
            CONTROL_NOT_INSTALLED: "NOT_INSTALLED",
        }.get(wc_status, "NOT_RUN")
        if wc_status == CONTROL_CRASHED and original_side == "PASS":
            original_runtime = "PASS"
        if wc_status in (CONTROL_ASSESSED, CONTROL_CRASHED) and \
                original_side is None:
            # Test-model isolation: the observed control is not hash-bound
            # to the original (possible leftover instrumented build of the
            # same package) — it establishes NO original-side runtime.
            original_runtime = "IDENTITY_UNVERIFIED"
        if original_runtime in ("PASS", "CRASH"):
            original_source = "WORKING_CONTROL"

    regression = comparison["regression_status"]
    if effective_cc == "COMMON_CAUSE_BOTH_CRASH":
        regression = "NOT_ESTABLISHED"
    elif effective_cc == "CONTROL_HEALTHY_INSTRUMENTED_CRASH" and \
            regression == "NOT_COMPARABLE":
        regression = "SUSPECTED_NOT_PROVEN"

    if effective_cc == "COMMON_CAUSE_BOTH_CRASH":
        runtime_status = "COMMON_CAUSE_BOTH_CRASH"
    elif effective_cc == "CONTROL_ONLY_CRASH":
        runtime_status = "CONTROL_ONLY_CRASH"
    elif effective_cc == "CONTROL_HEALTHY_INSTRUMENTED_CRASH":
        runtime_status = "CONTROL_HEALTHY_INSTRUMENTED_CRASH"
    elif ih.get("startup") == "CRASH":
        runtime_status = "BLOCKED_BY_ARTIFACT_CRASH"
    else:
        runtime_status = proof

    eff_deploy = deploy or {}
    eff_deploy_status = deploy_status or eff_deploy.get("status")

    # Upstream-block propagation (no false PACKAGE_NOT_INSTALLED): when
    # runtime never ran AND an earlier stage positively recorded a block,
    # the verdict names the true blocker instead of reading as a
    # device-side mystery. The probe-level fact stays in
    # RUNTIME_PROOF_STATUS for traceability. With no stage documents at
    # all, behavior is exactly as before.
    blocked_by = None
    if proof in ("PACKAGE_NOT_INSTALLED", "NOT_RUN") and not ih.get("startup"):
        if sign is not None and (sign or {}).get("status") != "SIGNED_VERIFIED":
            blocked_by = {
                "stage": "SIGN",
                "status": (sign or {}).get("status") or "NOT_SIGNED",
                "reason": ((sign or {}).get("error")
                           or "sign stage did not verify an artifact"),
            }
        elif (deploy is not None or deploy_status is not None) \
                and eff_deploy_status != "INSTALLED":
            blocked_by = {
                "stage": "DEPLOY",
                "status": eff_deploy_status or "NOT_DEPLOYED",
                "reason": (eff_deploy.get("error") or eff_deploy.get("reason")
                           or "deploy stage did not install an artifact"),
            }

    if blocked_by:
        next_action = (
            "Blocked before runtime by %s (%s): %s. Fix the %s stage; "
            "no device-side debugging is indicated by this verdict."
            % (blocked_by["stage"], blocked_by["status"],
               blocked_by["reason"], blocked_by["stage"].lower()))
    elif effective_cc == "COMMON_CAUSE_BOTH_CRASH":
        next_action = (
            "COMMON_CAUSE_BOTH_CRASH: the installed original AND the "
            "instrumented artifact crash with a common cause; "
            "instrumentation regression is NOT_ESTABLISHED and the crash "
            "MUST NOT be attributed to instrumentation. Investigate the "
            "common cause (device/OS/ROM or the app itself) with the "
            "working control left installed; no destructive operation is "
            "required or permitted.")
    elif ih.get("startup") == "CRASH":
        if regression == REGRESSION_CONFIRMED:
            next_action = (
                "Instrumentation regression confirmed: the original ran "
                "healthy within its observation window while the "
                "instrumented artifact crashed after installation; review "
                "INSTRUMENTATION-IMPACT.json change linkage; do NOT "
                "run further probe rounds until the injected "
                "loader/gadget change set is reduced or rebuilt.")
        elif regression == BASELINE_RUNTIME_FAILURE or \
                effective_cc == "CONTROL_ONLY_CRASH":
            next_action = (
                "Original-side runtime failure: the unmodified original "
                "also crashes on this device/build; do not attribute to "
                "ReelSec. Record device/build constraints; runtime proof "
                "remains blocked.")
        elif effective_cc == "CONTROL_HEALTHY_INSTRUMENTED_CRASH":
            next_action = (
                "Control starts cleanly while the instrumented artifact "
                "crashes: instrumentation is a CANDIDATE cause "
                "(SUSPECTED_NOT_PROVEN); review INSTRUMENTATION-IMPACT.json "
                "change linkage before any further round. No destructive "
                "operation is required.")
        else:
            next_action = (
                "Artifact crash without original-side comparison: run the "
                "non-destructive working-control round "
                "(REELSEC_WORKING_CONTROL, default on) to attribute the "
                "failure. The installed original is the control; no "
                "uninstall, clear-data or reinstall is required.")
    elif effective_cc == "CONTROL_ONLY_CRASH":
        next_action = (
            "Original-side failure: the installed working control itself "
            "crashed while no instrumented crash evidence exists; this "
            "crash is NOT caused by instrumentation. Record the "
            "device/build constraint; no destructive operation is "
            "required or permitted.")
    elif probe_allowed is False:
        next_action = "Runtime probe blocked: %s" % ih.get("crash_class")
    elif proof in ("NOT_RUN", "NOT_OBSERVED"):
        next_action = "Artifact healthy: bounded runtime probe is permitted."
    else:
        next_action = "Runtime proof recorded; evaluate evidence gate."

    eff_deploy = deploy or {}
    eff_deploy_status = deploy_status or eff_deploy.get("status")
    state = campaign_state_machine(
        working_control=working_control,
        baseline_health=b_view,
        deploy_status=eff_deploy_status,
        instrumented_health=i_view,
        common_cause=common_cause,
        crash_comparison=crash_comparison,
        deploy=eff_deploy or None)

    # Correct-verdict model (test-model isolation): the original's health
    # is a PRE-replacement fact; the instrumented crash is a
    # POST-replacement fact; the replacement itself is recorded with the
    # shared-APK users so post-replacement crashes on ANY user (including
    # the dual-app profile) are never read as baseline crashes.
    semantics = eff_deploy.get("install_semantics") or {}
    replaced_users = semantics.get("shared_apk_users") or None
    original_healthy_before = (True if original_side == "PASS"
                               else False if original_side == "CRASH"
                               else None)
    instrumented_crash_after = bool(ih.get("startup") == "CRASH")
    replacement_guard = (semantics.get("guard")
                         if semantics.get("replaced_existing_build")
                         and instrumented_crash_after else None)

    return {
        "schema_version": SCHEMA,
        "ORIGINAL_RUNTIME": original_runtime,
        "ORIGINAL_RUNTIME_SOURCE": original_source,
        "ORIGINAL_HEALTHY_BEFORE_INSTALL": original_healthy_before,
        "INSTRUMENTED_RUNTIME": ih.get("startup") or "NOT_RUN",
        "INSTRUMENTED_CRASH_AFTER_INSTALL": instrumented_crash_after,
        "INSTRUMENTED_INSTALLED": bool(eff_deploy_status == "INSTALLED" or ih),
        "REPLACED_SHARED_APK_USERS": replaced_users,
        "REPLACEMENT_GUARD": replacement_guard,
        "CRASH_CLASS": ih.get("crash_class"),
        "CRASH_CAUSE": ih.get("crash_cause"),
        "CRASH_CAUSE_CONFIDENCE": ih.get("crash_cause_confidence"),
        "REGRESSION_STATUS": regression,
        "RUNTIME_STATUS": runtime_status,
        "CRASH_COMPARISON": (crash_comparison or {}).get("status"),
        "WORKING_CONTROL": wc_status,
        "COMMON_CAUSE_COMPARISON": effective_cc,
        "COMMON_CAUSE_COMPARISON_RECORDED": cc_status,
        "RUNTIME_PROOF_STATUS": proof,
        "BLOCKED_BY": blocked_by,
        "CAMPAIGN_STATE": state["state"],
        "CAMPAIGN_STATE_REASON": state["reason"],
        "STARTUP_AUDIT": "; ".join(audit_notes) if audit_notes else None,
        "runtime_probe_allowed": bool(probe_allowed),
        "NEXT_ACTION": next_action,
    }
