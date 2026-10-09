"""Failure classification + recovery ledger + diagnostics.

The core rule: never repeat a failed attempt with the same strategy.
Every attempt is recorded (step, signature, strategy, command,
environment, result) and the ledger refuses identical retries.
"""
from __future__ import annotations

import hashlib
import json
import re
import time
from pathlib import Path

CATEGORIES = ("NETWORK_FAILURE", "DNS_FAILURE", "PACKAGE_NOT_FOUND",
              "VERSION_INCOMPATIBILITY", "PYTHON_INCOMPATIBILITY",
              "WHEEL_UNAVAILABLE", "BUILD_TOOL_MISSING",
              "COMPILER_MISSING", "RUST_MISSING",
              "RUST_BUILD_FAILURE", "C_BUILD_FAILURE",
              "BUILD_BACKEND_FAILURE",
              "ABI_INCOMPATIBILITY", "ARCH_INCOMPATIBILITY",
              "JAVA_INCOMPATIBILITY", "PERMISSION_FAILURE",
              "DISK_SPACE", "CONFIG_ERROR", "PROJECT_ERROR",
              "UNKNOWN")

ACTION_CLASS = {
    "download": "SAFE", "venv_create": "SAFE",
    "pip_retry": "SAFE", "pip_bump": "SAFE",
    "cache_use": "SAFE", "pip_cache_purge": "SAFE",
    "toolchain_install": "CAUTION", "syspkg_install": "CAUTION",
    "venv_recreate": "CAUTION", "runtime_switch": "CAUTION",
    "minimal_fallback": "CAUTION", "pip_upgrade": "CAUTION",
    "index_rebuild": "CAUTION", "disposable_cleanup": "SAFE",
    "db_delete": "DESTRUCTIVE", "data_reset": "DESTRUCTIVE",
    "credential_remove": "DESTRUCTIVE",
}


def action_class(name):
    return ACTION_CLASS.get(name, "CAUTION")


def _tail(text, count=80):
    return (text or "").splitlines()[-count:]


def evidence_lines(log_text, limit=8):
    """Decisive lines: error signals from anywhere, then the tail.

    pip buries the real cause above generic boilerplate, so the
    last lines alone routinely mislead. Signal lines win; the tail
    fills the remainder.
    """
    import re
    lines = (log_text or "").splitlines()
    signal = re.compile(
        r"error|failed|failure|not found|no such|missing|cannot |"
        r"can't |exception|traceback|\u00d7|\u2570|"
        r"linker .* not found", re.IGNORECASE)
    picked = []
    for line in lines:
        stripped = line.strip()
        if len(stripped) > 8 and signal.search(stripped):
            cleaned = stripped[:200]
            if cleaned not in picked:
                picked.append(cleaned)
        if len(picked) >= limit:
            break
    for line in lines[-3:]:
        stripped = line.strip()
        if stripped and stripped[:200] not in picked \
                and len(picked) < limit + 2:
            picked.append(stripped[:200])
    return picked


def _find_package(lines):
    """Best-effort package name from pip/npm failure output."""
    patterns = (r"Failed to build `?([^`'\s=]+)",
                r"Failed building wheel for ([^`\s]+)",
                r"Building wheel for ([^`\s(]+)",
                r"Collecting ([A-Za-z0-9_.-]+)(?:==|>=|~=|<|>|$)",
                r"ERROR: No matching distribution found for "
                r"([A-Za-z0-9_.-]+)",
                r"Could not find a version that satisfies .*? "
                r"([A-Za-z0-9_.-]+)(?:==|>=|~=|<|>|$|=)",
                r"npm ERR! .*? '([^']+)'")
    for line in reversed(lines):
        for pattern in patterns:
            match = re.search(pattern, line)
            if match:
                name = match.group(1).strip().strip("`'\"")
                if name and name.lower() not in (
                        "from", "the", "a", "an"):
                    return name
    return None


def classify_failure(log_text):
    """Classify a failure log into (category, package, evidence).

    Root-cause oriented: a pydantic-core build failure is a
    dependency/build-resolution event, never just "pip failed".
    """
    text = log_text or ""
    lines = _tail(text)
    blob = "\n".join(lines)
    package = _find_package(lines)
    evidence = evidence_lines(text)

    def hit(*needles):
        lowered = blob.lower()
        return any(needle.lower() in lowered
                   for needle in needles)

    # -- network / dns -------------------------------------------------
    if hit("nodename nor servname", "name or service not known",
           "failed to resolve", "getaddrinfo failed", "eai_again",
           "enotfound", "dns"):
        return {"category": "DNS_FAILURE", "package": package,
                "evidence": evidence,
                "root_cause": "name resolution failed"}
    if hit("connectionerror", "newconnectionerror",
           "read timed out", "operation timed out",
           "temporary failure", "max retries exceeded",
           "connection refused", "connection reset",
           "network is unreachable", "enotconn", "socket timeout",
           "econnrefused", "econnreset", "etimedout"):
        return {"category": "NETWORK_FAILURE", "package": package,
                "evidence": evidence,
                "root_cause": "registry unreachable mid-operation"}

    # -- local environment ----------------------------------------------
    if hit("no space left", "errno 28", "enospc",
           "disk quota exceeded"):
        return {"category": "DISK_SPACE", "package": package,
                "evidence": evidence,
                "root_cause": "disk full"}
    if hit("permission denied", "errno 13", "eacces",
           "access is denied", "operation not permitted"):
        return {"category": "PERMISSION_FAILURE",
                "package": package, "evidence": evidence,
                "root_cause": "permission denied"}

    # -- resolution ------------------------------------------------------
    if hit("could not find a version that satisfies"):
        if "from versions:" in blob \
                and "from versions: none" not in blob.lower():
            return {"category": "VERSION_INCOMPATIBILITY",
                    "package": package, "evidence": evidence,
                    "root_cause": "no listed version satisfies "
                    "the constraint on this runtime"}
        return {"category": "PACKAGE_NOT_FOUND",
                "package": package, "evidence": evidence,
                "root_cause": "package unknown to the index"}
    if hit("no matching distribution found"):
        return {"category": "WHEEL_UNAVAILABLE",
                "package": package, "evidence": evidence,
                "root_cause": "no file for this "
                "python/platform/arch combination"}
    if hit("is not a supported wheel on this platform"):
        return {"category": "ABI_INCOMPATIBILITY",
                "package": package, "evidence": evidence,
                "root_cause": "wheel tag incompatible with this "
                "interpreter/platform"}
    if hit("requires-python", "requires python",
           "needs python", "only python", "ignored:.*python",
           "python_requires", "requires_dist.*python"):
        return {"category": "PYTHON_INCOMPATIBILITY",
                "package": package, "evidence": evidence,
                "root_cause": "package bounds exclude this "
                "interpreter"}

    # -- native build chain -----------------------------------------------
    # Rust/C markers are diagnostic on their own: a missing
    # toolchain must not require build-failure boilerplate.
    if hit("rustc", "cargo", "maturin", "requires-rust",
           "rustup", "pyo3"):
        if hit("not found", "no such file", "missing",
               "not installed", "could not find"):
            cause = "rust toolchain missing for a rust-backed " \
                "package"
        elif hit("aborted", "signal", "memory", "killed", "oom"):
            cause = "rust build killed (resources?)"
        else:
            cause = "rust-backed source build failed"
        return {"category": "RUST_MISSING", "package": package,
                "evidence": evidence, "root_cause": cause}
    if hit("python.h", "fatal error:", "gcc", "clang",
           "cc: not found", "cl.exe", "visual c++",
           "compiler", "cannot find -l"):
        return {"category": "COMPILER_MISSING",
                "package": package, "evidence": evidence,
                "root_cause": "c toolchain/headers missing for "
                "a native build"}
    if hit("metadata-generation-failed", "failed to build",
           "failed building wheel", "could not build wheels",
           "maturin failed", "gyp err!", "node-gyp"):
        return {"category": "BUILD_TOOL_MISSING",
                "package": package, "evidence": evidence,
                "root_cause": "source build failed "
                "(see evidence)"}

    # -- runtimes ----------------------------------------------------------
    if hit("unsupportedclassversionerror",
           "class file version", "bad major version",
           "unsupported class file"):
        return {"category": "JAVA_INCOMPATIBILITY",
                "package": package, "evidence": evidence,
                "root_cause": "bytecode newer than this jvm"}
    if hit("ebadengine", "ebadplatform"):
        return {"category": "VERSION_INCOMPATIBILITY",
                "package": package, "evidence": evidence,
                "root_cause": "node engine/platform mismatch"}
    if "aarch64" in blob.lower() and "x86_64" in blob.lower() \
            and hit("wrong", "mismatch", "incompatible",
                    "cannot", "failed"):
        return {"category": "ARCH_INCOMPATIBILITY",
                "package": package, "evidence": evidence,
                "root_cause": "binary built for another arch"}
    return {"category": "UNKNOWN", "package": package,
            "evidence": evidence,
            "root_cause": "unrecognized failure signature"}


def failure_signature(step, category, package, strategy,
                      env_hash):
    key = "|".join(str(part) for part in
                   (step, category, package or "-", strategy,
                    env_hash or "-"))
    return hashlib.sha256(key.encode()).hexdigest()[:12]


class Ledger:
    """Append-only attempt ledger (refuses identical retries)."""

    def __init__(self, path):
        self.path = Path(path)

    def entries(self):
        if not self.path.is_file():
            return []
        rows = []
        try:
            for line in self.path.read_text(
                    encoding="utf-8",
                    errors="replace").splitlines():
                line = line.strip()
                if line:
                    rows.append(json.loads(line))
        except (OSError, ValueError):
            return rows
        return rows

    def attempted(self, step, signature, strategy):
        for entry in self.entries():
            if entry.get("step") == step \
                    and entry.get("signature") == signature \
                    and entry.get("strategy") == strategy:
                return True
        return False

    def record(self, step, signature, strategy, command,
               env_hash, result, detail=""):
        self.path.parent.mkdir(parents=True, exist_ok=True)
        row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%SZ",
                                   time.gmtime()),
               "step": step, "signature": signature,
               "strategy": strategy, "command": command,
               "env": env_hash, "result": result, "detail":
               detail[:500]}
        with open(self.path, "a", encoding="utf-8") as handle:
            handle.write(json.dumps(row) + "\n")
        return row

    def record_row(self, mapping):
        """Append one free-form row (attempt fingerprints)."""
        self.path.parent.mkdir(parents=True, exist_ok=True)
        row = dict(mapping)
        row.setdefault("ts", time.strftime("%Y-%m-%dT%H:%M:%SZ",
                                           time.gmtime()))
        with open(self.path, "a", encoding="utf-8") as handle:
            handle.write(json.dumps(row) + "\n")
        return row

    def attempts_for(self, step):
        return [entry for entry in self.entries()
                if entry.get("step") == step]


def full_diagnostic(info):
    """Section-30 failure block (never just 'pip install failed')."""
    lines = ["", "FAILED STEP : %s" % info.get("step", "?"),
             "PACKAGE     : %s" % (info.get("package") or "-"),
             "VERSION     : %s" % (info.get("version") or "-"),
             "PYTHON      : %s" % (info.get("python") or "-"),
             "PLATFORM    : %s" % (info.get("platform") or "-"),
             "ARCH        : %s" % (info.get("arch") or "-"),
             "METHOD      : %s" % (info.get("method") or "-"),
             "CATEGORY    : %s" % info.get("category", "UNKNOWN"),
             "ROOT CAUSE  : %s" % info.get("root_cause", "?"),
             "COMMAND     : %s" % (info.get("command") or "-")]
    if info.get("log"):
        lines.append("LOG         : %s" % info["log"])
    if info.get("evidence"):
        lines.append("EVIDENCE    :")
        for line in info["evidence"][-8:]:
            lines.append("  | %s" % line.strip()[:200])
    if info.get("alternatives"):
        lines.append("ALTERNATIVES:")
        for alt in info["alternatives"]:
            lines.append("  - %s" % alt)
    lines.append("ATTEMPTS    : %s" %
                 ", ".join(info.get("attempts", [])) or "-")
    lines.append("NEXT        : %s" %
                 info.get("next_strategy", "?"))
    lines.append("")
    return "\n".join(lines)


def exhausted_report(info):
    """Section-36 block when every strategy is spent."""
    lines = ["", "AUTO-RECOVERY EXHAUSTED", "",
             "CAUSE       : %s" % info.get("root_cause", "?"),
             "STEP        : %s" % info.get("step", "?"),
             "PACKAGE     : %s" % (info.get("package") or "-"),
             "CATEGORY    : %s" % info.get("category", "?")]
    lines.append("TRIED       :")
    for attempt in info.get("tried", []):
        lines.append("  - %s → %s" % (
            attempt.get("strategy", "?"),
            attempt.get("result", "?")))
    nodes = info.get("nodes", [])
    if nodes:
        lines.append("EXHAUSTION REPORT:")
        for node in nodes:
            mark = {"done": "v", "failed": "x",
                    "skipped": "=", "blocked": "!"}.get(
                        node.get("status"), "?")
            lines.append("  %s %-28s %s" % (
                mark, node.get("node", "?"),
                node.get("reason", "")))
    skipped = info.get("skipped_identical", [])
    if skipped:
        lines.append("SKIPPED     : already failed identically")
        for name in skipped[:8]:
            lines.append("  - %s" % name)
    needs = info.get("needs_you", [])
    if needs:
        lines.append("NEEDS YOU   :")
        for need in needs[:6]:
            lines.append("  - %s" % need)
    lines.append("REQUIRED    : %s" %
                 info.get("required", "manual intervention"))
    lines.append("NEXT ACTION : %s" % info.get("next_action", "?"))
    lines.append("Do NOT re-run the same command unchanged; it "
                 "will fail identically (ledger: %s)." %
                 info.get("ledger", "recovery-ledger.jsonl"))
    lines.append("")
    return "\n".join(lines)
