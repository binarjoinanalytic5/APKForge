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
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

from . import compat as _compat
from . import recovery as _recovery

IDENTITY_KEYS = ("step", "strategy", "package", "version", "python",
                 "env_fp", "toolchain_fp", "command_hash",
                 "requirements_hash", "build_env_hash")


def _ident_value(row, key):
    """Identity value; pre-build-env rows count as empty env."""
    value = row.get(key)
    if value is None and key == "build_env_hash":
        return _short(json.dumps({}, sort_keys=True))
    return value

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


def probe_toolchain(python_exe=None, commands=None):
    """Capability probe: path + version per tool (section 7).

    Runs in the caller's environment (the same one pip inherits).
    When python_exe is given, visibility is additionally confirmed
    from inside that interpreter, because a tool on the login PATH
    is not necessarily visible to the build subprocess.
    """
    tools = {}
    for name, argv in (commands or TOOL_VERSION_COMMANDS).items():
        path = shutil.which(argv[0])
        version = _tool_version(argv) if path else None
        tools[name] = {"path": path, "version": version,
                       "ok": bool(path and version)}
    if python_exe:
        seen = _venv_which(python_exe, ["rustc", "cargo", "cc",
                                        "clang", "ld"])
        for name, path in seen.items():
            entry = tools.get(name, {})
            entry["via_venv"] = path
            if path and not entry.get("path"):
                entry["path"] = path
                entry["ok"] = bool(entry.get("version"))
            tools[name] = entry
    tools["python"] = {"path": sys.executable, "version":
                       "%d.%d.%d" % sys.version_info[:3],
                       "ok": True}
    digest = _short(json.dumps(tools, sort_keys=True, default=str))
    return {"tools": tools, "hash": digest}


def _venv_which(python_exe, names):
    """shutil.which from inside another interpreter ({} on error)."""
    code = ("import shutil, json; print(json.dumps({n: "
            "shutil.which(n) for n in %r}))" % (names,))
    try:
        proc = subprocess.run(
            [str(python_exe), "-c", code], stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL, timeout=60, text=True,
            errors="replace")
    except OSError:
        return {}
    if proc.returncode != 0:
        return {}
    try:
        data = json.loads((proc.stdout or "").strip())
    except ValueError:
        return {}
    return data if isinstance(data, dict) else {}


def toolchain_fingerprint(commands=None):
    """Versions of every build tool (presence alone lies)."""
    return probe_toolchain(commands=commands)


def _valid_api_level(text):
    """An Android API level as int, else None (never invent one)."""
    cleaned = (text or "").strip()
    if not cleaned.isdigit():
        return None
    level = int(cleaned)
    if 16 <= level <= 100:
        return level
    return None


def _run_getprop(getprop_fn):
    if getprop_fn is not None:
        try:
            return getprop_fn()
        except Exception:
            return None
    if shutil.which("getprop") is None:
        return None
    try:
        proc = subprocess.run(
            ["getprop", "ro.build.version.sdk"],
            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
            timeout=10, text=True, errors="replace")
    except OSError:
        return None
    if proc.returncode != 0:
        return None
    return proc.stdout


def _device_api_level(getprop_fn=None,
                      build_prop_path="/system/build.prop"):
    """Device API level from getprop, else build.prop (int|None)."""
    raw = _run_getprop(getprop_fn)
    level = _valid_api_level(raw)
    if level is not None:
        return level, "getprop:ro.build.version.sdk"
    try:
        text = Path(build_prop_path).read_text(
            encoding="utf-8", errors="replace")
    except OSError:
        return None, None
    for line in text.splitlines():
        if line.startswith("ro.build.version.sdk="):
            level = _valid_api_level(line.split("=", 1)[1])
            if level is not None:
                return level, "file:%s" % build_prop_path
            return None, None
    return None, None


def detect_android_api_level(env=None, getprop_fn=None,
                             build_prop_path="/system/build.prop"):
    """Detect the Android API level for maturin builds.

    Precedence: a valid caller-provided ANDROID_API_LEVEL, then the
    device level (getprop, else build.prop). Never invents a number:
    when nothing validates, ok is False with a precise reason naming
    every source tried.
    """
    env = os.environ if env is None else env
    raw_env = (env.get("ANDROID_API_LEVEL") or "").strip()
    notes = []
    if raw_env and _valid_api_level(raw_env) is None:
        notes.append("env ANDROID_API_LEVEL=%r invalid" % raw_env)
    device, device_source = _device_api_level(
        getprop_fn, build_prop_path)
    if raw_env and _valid_api_level(raw_env) is not None:
        return {"ok": True, "level": int(raw_env),
                "source": "env:ANDROID_API_LEVEL",
                "device_api_level": device,
                "device_source": device_source,
                "reason": "using caller-provided "
                "ANDROID_API_LEVEL"}
    if device is not None:
        return {"ok": True, "level": device, "source":
                device_source, "device_api_level": device,
                "device_source": device_source,
                "reason": "device api level detected"}
    notes.append("no ANDROID_API_LEVEL in the environment")
    notes.append("getprop ro.build.version.sdk unavailable "
                 "or non-numeric")
    notes.append("%s unreadable or without "
                 "ro.build.version.sdk" % build_prop_path)
    return {"ok": False, "level": None, "source": "none",
            "device_api_level": None, "device_source": None,
            "reason": "; ".join(notes)}


def refine_category(category, probe, signals):
    """Log-based MISSING verdicts must survive a live probe.

    Returns (category, note). A toolchain the probe can see is
    present-but-failing, never missing.
    """
    tools = (probe or {}).get("tools", {})
    rust_ok = bool(tools.get("rustc", {}).get("ok")
                   and tools.get("cargo", {}).get("ok"))
    c_ok = bool(tools.get("cc", {}).get("ok")
                or tools.get("clang", {}).get("ok")
                or tools.get("gcc", {}).get("ok"))
    if category == "RUST_MISSING" and rust_ok:
        rustc = tools["rustc"].get("version", "?")
        return ("RUST_BUILD_FAILURE",
                "%s present; the crate build itself failed"
                % rustc)
    if category == "COMPILER_MISSING" and c_ok:
        return ("C_BUILD_FAILURE",
                "C compiler present; the native build failed")
    if category == "BUILD_TOOL_MISSING" and rust_ok and c_ok:
        return ("BUILD_BACKEND_FAILURE",
                "toolchains present; the PEP 517 backend failed")
    return (category, "")


def memory_status(memory, current_hash):
    """ACTIVE/STALE lifecycle for failure memory (section 30)."""
    if not memory:
        return {"status": "NONE", "reason": "no recorded failure"}
    if not memory.get("toolchain_fp"):
        return {"status": "STALE",
                "reason": "recorded before toolchain "
                "fingerprinting"}
    if memory["toolchain_fp"] != current_hash:
        return {"status": "STALE",
                "reason": "toolchain changed since the recorded "
                "failure"}
    return {"status": "ACTIVE", "reason": "toolchain unchanged"}


def attempt_fingerprint(step, strategy, package, version,
                        python_version, arch, platform, command,
                        requirements_text, toolchain_fp,
                        run_id="", build_env=None):
    """Full identity of one attempt (section 17).

    package/version here are the STRATEGY TARGET (an input, e.g.
    the pinned release for a version attempt, None for whole-file
    installs) -- never the diagnosed failure, which is an outcome
    and must not destabilize identity across rounds. build_env is
    the build-only environment (e.g. ANDROID_API_LEVEL): a changed
    build env is a changed attempt, never a repeat.
    """
    env_map = {str(key): str(value) for key, value in sorted(
        (build_env or {}).items())}
    row = {"kind": "attempt", "step": step, "strategy": strategy,
           "package": package, "version": version,
           "python": python_version, "arch": arch,
           "platform": platform,
           "env_fp": toolchain_fp.get("env_hash", ""),
           "toolchain_fp": toolchain_fp.get("hash", ""),
           "command_hash": _short(command),
           "requirements_hash": _short(requirements_text),
           "build_env": env_map,
           "build_env_hash": _short(json.dumps(
               env_map, sort_keys=True)),
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
    wanted = {key: _ident_value(fp_row, key)
              for key in IDENTITY_KEYS}
    for row in read_rows(ledger_path):
        if row.get("kind") != "attempt":
            continue
        if all(_ident_value(row, key) == value
               for key, value in wanted.items()):
            return row
    return None


def count_identical(ledger_path, fp_row):
    wanted = {key: _ident_value(fp_row, key)
              for key in IDENTITY_KEYS}
    return sum(
        1 for row in read_rows(ledger_path)
        if row.get("kind") == "attempt" and all(
            _ident_value(row, key) == value
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
                "log": memory.get("log", ""),
                "toolchain_fp": memory.get("toolchain_fp")}
    classified = _recovery.classify_failure(
        memory.get("detail", ""))
    return {"package": classified["package"],
            "version": None,
            "category": classified["category"],
            "python": None,
            "strategy": memory.get("strategy"),
            "ts": memory.get("ts", ""), "log": "", "toolchain_fp": None}


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

    runtime_implicated = category in (
        "PYTHON_INCOMPATIBILITY", "WHEEL_UNAVAILABLE",
        "NO_ARTIFACT", "ABI_INCOMPATIBILITY", "RUST_MISSING",
        "RUST_BUILD_FAILURE", "COMPILER_MISSING",
        "C_BUILD_FAILURE", "BUILD_TOOL_MISSING",
        "BUILD_BACKEND_FAILURE", "UNKNOWN")
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
        if caps.get("alternate_pythons") or provision_ok:
            add("runtime", "alternate python runtime")
        add("native", "plain pip install")
        return cands
    if category in ("PACKAGE_NOT_FOUND", "VERSION_INCOMPATIBILITY"):
        if package:
            add("version", "other %s releases" % package,
                package=package)
        add("native", "plain pip install")
        return cands

    if category == "ANDROID_API_LEVEL_MISSING":
        add("native_android_api_level",
            "retry with a detected ANDROID_API_LEVEL",
            package=package)

    # Build/wheel/unknown failures: fix inputs, then install.
    if toolchain_langs and provision_ok:
        add("toolchain", "provision %s toolchain" % "+".join(
            sorted(toolchain_langs)), langs=sorted(toolchain_langs))
    if sysdeps and provision_ok:
        add("sysdeps", "install %s" % ", ".join(sysdeps),
            packages=sysdeps)
    add("native", "plain pip install")
    if package:
        add("version", "compatible %s release" % package,
            package=package)
    if package and runtime_implicated and (
            caps.get("alternate_pythons") or provision_ok):
        add("runtime", "alternate python runtime")
    if droppable(package, caps.get("direct", set())):
        add("minimal", "drop optional native extras",
            package=package)
    return cands


def blocked_ideas(failure, caps):
    """Untried paths that need the user (for the final report)."""
    ideas = []
    package = failure.get("package")
    if failure.get("category") == "ANDROID_API_LEVEL_MISSING":
        detection = failure.get("api_detection") or {}
        if detection and not detection.get("ok"):
            ideas.append("android api level unknown (%s); "
                         "export ANDROID_API_LEVEL=<device api> "
                         "and re-run" % detection.get(
                             "reason", "?"))
        else:
            ideas.append("maturin still cannot see "
                         "ANDROID_API_LEVEL; export it from "
                         "`getprop ro.build.version.sdk` and "
                         "re-run")
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


def explain(fp_row, verdict, previous=None):
    """Why this attempt runs (or is refused): 3 honest lines."""
    lines = [
        "WHY        : strategy '%s'%s" % (
            fp_row.get("strategy"),
            " for %s" % fp_row["package"]
            if fp_row.get("package") else " (whole file)"),
        "FINGERPRINT: py=%s tc=%s req=%s cmd=%s be=%s" % (
            fp_row.get("python"), (fp_row.get("toolchain_fp")
                                   or "?")[:8],
            (fp_row.get("requirements_hash") or "?")[:8],
            (fp_row.get("command_hash") or "?")[:8],
            (fp_row.get("build_env_hash") or "?")[:8])]
    if verdict == "run":
        lines.append("DECISION   : RUN (%s)" % (
            "first attempt" if previous is None else
            "differs from %s" % previous))
    else:
        lines.append("DECISION   : REFUSE (byte-identical to a "
                     "recorded failure)")
    return lines


def now_ts():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
