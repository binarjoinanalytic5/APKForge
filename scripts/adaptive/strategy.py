"""Autonomous recovery decisions: change, never blindly repeat.

A strategy is blocked only when its FULL attempt fingerprint matches
a recorded failure: same environment + package + version + strategy +
command + requirements + toolchain (tool versions included, so a rust
1.98 -> 1.99 upgrade re-opens the attempt honestly). Anything that
actually changed is a new attempt and is allowed.
"""
from __future__ import annotations

import hashlib
import json
import shutil
import subprocess
import sys
import time
from pathlib import Path

from . import compat as _compat
from . import recovery as _recovery

IDENTITY_KEYS = ("step", "strategy", "package", "version", "python",
                 "env_fp", "toolchain_fp", "command_hash",
                 "requirements_hash")

# Bounded retries for flaky failures (identical fp, backoff, max 3).
FLAKY_CATEGORIES = ("NETWORK_FAILURE", "DNS_FAILURE")
FLAKY_MAX = 3

TOOL_VERSION_COMMANDS = {
    "rustc": ["rustc", "--version"],
    "cargo": ["cargo", "--version"],
    "cc": ["cc", "--version"],
    "clang": ["clang", "--version"],
    "gcc": ["gcc", "--version"],
    "make": ["make", "--version"],
    "cmake": ["cmake", "--version"],
    "pkg-config": ["pkg-config", "--version"],
    "ninja": ["ninja", "--version"],
    "ld": ["ld", "--version"],
}

# Missing build input -> Termux packages (never guessed elsewhere).
TERMUX_SYSDEPS = {
    "cc": ["clang"], "clang": ["clang"], "gcc": ["clang"],
    "make": ["make"], "cmake": ["cmake"], "ninja": ["ninja"],
    "pkg-config": ["pkg-config"], "ld": ["binutils"],
    "ar": ["binutils"], "autoconf": ["autoconf"],
    "Python.h": ["python"], "ffi.h": ["libffi"],
    "openssl/ssl.h": ["openssl"], "zlib.h": ["zlib"],
    "sqlite3.h": ["sqlite"], "libxml/parser.h": ["libxml2"],
}

APT_SYSDEPS = {
    "cc": ["build-essential"], "gcc": ["build-essential"],
    "make": ["build-essential"], "cmake": ["cmake"],
    "pkg-config": ["pkg-config"], "Python.h": ["python3-dev"],
    "ffi.h": ["libffi-dev"], "openssl/ssl.h": ["libssl-dev"],
    "zlib.h": ["zlib1g-dev"], "sqlite3.h": ["libsqlite3-dev"],
}


def _short(text):
    return hashlib.sha256((text or "").encode(
        "utf-8", "replace")).hexdigest()[:16]


def _tool_version(argv):
    if not shutil.which(argv[0]):
        return None
    try:
        proc = subprocess.run(
            argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
            timeout=15, text=True, errors="replace")
    except OSError:
        return None
    if proc.returncode != 0:
        return None
    first = (proc.stdout or "").strip().splitlines()
    return first[0][:120] if first else "present"


def toolchain_fingerprint(commands=None):
    """Versions of every build tool (presence alone lies)."""
    tools = {}
    for name, argv in (commands or TOOL_VERSION_COMMANDS).items():
        tools[name] = _tool_version(argv)
    tools["python"] = "%d.%d.%d" % sys.version_info[:3]
    digest = _short(json.dumps(tools, sort_keys=True))
    return {"tools": tools, "hash": digest}


def attempt_fingerprint(step, strategy, package, version,
                        python_version, arch, platform, command,
                        requirements_text, toolchain_fp,
                        run_id=""):
    """Full identity of one attempt (section 17)."""
    row = {"kind": "attempt", "step": step, "strategy": strategy,
           "package": package, "version": version,
           "python": python_version, "arch": arch,
           "platform": platform,
           "env_fp": toolchain_fp.get("env_hash", ""),
           "toolchain_fp": toolchain_fp.get("hash", ""),
           "command_hash": _short(command),
           "requirements_hash": _short(requirements_text),
           "run_id": run_id}
    row["attempt_id"] = _short(json.dumps(
        {key: row.get(key) for key in IDENTITY_KEYS},
        sort_keys=True))
    return row


def read_rows(ledger_path):
    """All ledger rows (legacy strategy rows + attempt rows)."""
    path = Path(ledger_path)
    if not path.is_file():
        return []
    rows = []
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return []
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            parsed = json.loads(line)
        except ValueError:
            continue
        if isinstance(parsed, dict):
            rows.append(parsed)
    return rows


def identical_attempt(ledger_path, fp_row):
    """A recorded failure with the exact same full fingerprint."""
    wanted = {key: fp_row.get(key) for key in IDENTITY_KEYS}
    for row in read_rows(ledger_path):
        if row.get("kind") != "attempt":
            continue
        if all(row.get(key) == value
               for key, value in wanted.items()):
            return row
    return None


def count_identical(ledger_path, fp_row):
    wanted = {key: fp_row.get(key) for key in IDENTITY_KEYS}
    return sum(
        1 for row in read_rows(ledger_path)
        if row.get("kind") == "attempt" and all(
            row.get(key) == value
            for key, value in wanted.items()))


def flaky_retry_allowed(ledger_path, fp_row, category):
    """Bounded identical retries for flaky network failures only."""
    if category not in FLAKY_CATEGORIES:
        return False
    return count_identical(ledger_path, fp_row) < FLAKY_MAX


def last_failure(ledger_path, step="DEPENDENCIES"):
    """Newest failed attempt (failure memory; legacy-aware)."""
    memory = None
    for row in read_rows(ledger_path):
        if row.get("step") != step:
            continue
        if row.get("result") != "failed":
            continue
        memory = row
    if memory is None:
        return {}
    if memory.get("kind") == "attempt":
        return {"package": memory.get("package"),
                "version": memory.get("version"),
                "category": memory.get("category") or "UNKNOWN",
                "python": memory.get("python"),
                "strategy": memory.get("strategy"),
                "ts": memory.get("ts", ""),
                "log": memory.get("log", "")}
    classified = _recovery.classify_failure(
        memory.get("detail", ""))
    return {"package": classified["package"],
            "version": None,
            "category": classified["category"],
            "python": None,
            "strategy": memory.get("strategy"),
            "ts": memory.get("ts", ""), "log": ""}


def extract_signals(log_text):
    """Actionable build signals (missing tools/headers/libs)."""
    import re
    signals = []
    seen = set()
    patterns = (
        ("missing-command",
         r"(?:/bin/sh: \d+: |command not found[:\s]+|"
         r"FileNotFoundError:[^\n]*?')([A-Za-z0-9_+.~-]+)"),
        ("missing-linker",
         r"linker [`']([^`'\s]+)[`'] not found"),
        ("missing-header",
         r"fatal error: ([A-Za-z0-9_./+-]+\.h):"),
        ("missing-python-header",
         r"(Python\.h): No such file"),
        ("rust-missing",
         r"(can't find Rust compiler|could not find [`']?cargo[`']?|"
         r"cargo: command not found|rustc: command not found)"),
        ("pkg-config-missing",
         r"(pkg-config[^:\n]* (?:not found|missing|required))"),
        ("mirror-failure",
         r"(Failed to fetch [^\s]+|Unable to locate package "
         r"[A-Za-z0-9_+.~-]+)"),
    )
    for kind, pattern in patterns:
        for match in re.finditer(pattern, log_text or ""):
            target = match.group(1).strip().strip("'`\"")[:80]
            key = (kind, target)
            if target and key not in seen:
                seen.add(key)
                signals.append({"kind": kind, "target": target,
                                "evidence": match.group(0)[:160]})
            if len(signals) >= 6:
                return signals
    return signals


def sysdeps_for_signals(signals, termux):
    """System packages that would clear the signals (dedupe kept)."""
    table = TERMUX_SYSDEPS if termux else APT_SYSDEPS
    ordered = []
    for signal in signals:
        target = signal.get("target", "")
        names = table.get(target, [])
        if signal["kind"] == "missing-header" and not names:
            continue
        for name in names:
            if name not in ordered:
                ordered.append(name)
    return ordered


def extras_providers():
    """Native packages reachable only via documented extras."""
    provided = set()
    for extras in _compat.KNOWN_EXTRAS.values():
        for deps in extras.values():
            provided.update(deps)
    provided.discard("websockets")  # pure-python
    return {item.lower().replace("_", "-") for item in provided}


def droppable(package, direct_names):
    """True only when the package is provably optional.

    A package is droppable only if it is NOT a direct requirement
    AND it is reachable solely via documented optional extras
    (uvicorn[standard] style). Required transitive packages such as
    pydantic-core (pulled by pydantic) are never droppable.
    """
    if not package:
        return False
    norm = package.lower().replace("_", "-")
    if norm in {item.lower().replace("_", "-")
                for item in direct_names}:
        return False
    return norm in extras_providers()


def order_candidates(failure, caps):
    """Changed strategies in preference order (never bare repeats).

    failure: {category, package, version}. caps: {termux,
    provision_ok, offline, direct, alternate_pythons, signals}.
    Each candidate: {id, label, params}.
    """
    category = failure.get("category", "-")
    package = failure.get("package")
    signals = caps.get("signals", [])
    cands = []

    def add(cid, label, **params):
        cands.append({"id": cid, "label": label, "params": params})

    sysdeps = sysdeps_for_signals(signals, caps.get("termux"))
    toolchain_langs = set()
    if category in ("RUST_MISSING", "BUILD_TOOL_MISSING"):
        toolchain_langs.add("rust")
    if category in ("COMPILER_MISSING", "BUILD_TOOL_MISSING"):
        toolchain_langs.add("c")
    for signal in signals:
        if signal["kind"] in ("rust-missing",):
            toolchain_langs.add("rust")
        if signal["kind"] in ("missing-command", "missing-linker") \
                and signal["target"] in ("cc", "clang", "gcc",
                                         "ld", "ar"):
            toolchain_langs.add("c")

    provision_ok = caps.get("provision_ok") and not caps.get(
        "offline")
    if category in ("NETWORK_FAILURE", "DNS_FAILURE"):
        add("retry", "retry with backoff", sleep=5)
        add("native", "plain pip install")
        return cands
    if category == "PERMISSION_FAILURE":
        add("recreate+pip", "recreate venv, then pip")
        add("native", "plain pip install")
        return cands
    if category == "DISK_SPACE":
        add("purge+pip", "purge pip cache, then pip")
        add("native", "plain pip install")
        return cands

    if category == "PYTHON_INCOMPATIBILITY":
        if package:
            add("version", "compatible %s release" % package,
                package=package)
        if caps.get("alternate_pythons"):
            add("runtime", "alternate python runtime")
        add("native", "plain pip install")
        return cands
    if category in ("PACKAGE_NOT_FOUND", "VERSION_INCOMPATIBILITY"):
        if package:
            add("version", "other %s releases" % package,
                package=package)
        add("native", "plain pip install")
        return cands

    # Build/wheel/unknown failures: fix inputs, then install.
    if toolchain_langs and provision_ok:
        add("toolchain", "provision %s toolchain" % "+".join(
            sorted(toolchain_langs)), langs=sorted(toolchain_langs))
    if sysdeps and provision_ok:
        add("sysdeps", "install %s" % ", ".join(sysdeps),
            packages=sysdeps)
    add("native", "plain pip install")
    if package and caps.get("version_ok"):
        add("version", "compatible %s release" % package,
            package=package)
    if caps.get("alternate_pythons") and package and \
            category in ("WHEEL_UNAVAILABLE", "NO_ARTIFACT",
                         "ABI_INCOMPATIBILITY", "RUST_MISSING",
                         "COMPILER_MISSING", "BUILD_TOOL_MISSING",
                         "UNKNOWN"):
        add("runtime", "alternate python runtime")
    if droppable(package, caps.get("direct", set())):
        add("minimal", "drop optional native extras",
            package=package)
    return cands


def blocked_ideas(failure, caps):
    """Untried paths that need the user (for the final report)."""
    ideas = []
    package = failure.get("package")
    if package and not caps.get("version_ok"):
        ideas.append("no %s release with a compatible wheel "
                     "found on PyPI" % package)
    if not caps.get("alternate_pythons") and failure.get(
            "category") in ("PYTHON_INCOMPATIBILITY",
                            "WHEEL_UNAVAILABLE", "NO_ARTIFACT",
                            "RUST_MISSING", "COMPILER_MISSING",
                            "BUILD_TOOL_MISSING"):
        if caps.get("termux"):
            ideas.append("no alternate python on device; try "
                         "'pkg install python3.12' (needs a repo "
                         "such as tur-repo) or install rust/clang "
                         "for source builds")
        else:
            ideas.append("no alternate python on device; install "
                         "python3.12/3.13 for prebuilt wheels")
    if not caps.get("provision_ok") and not caps.get("offline"):
        ideas.append("no usable package manager for toolchain "
                     "provisioning")
    return ideas[:4]


def now_ts():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
