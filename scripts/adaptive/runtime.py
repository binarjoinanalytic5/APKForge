"""Runtime resolution: pick (or provision) a python that fits.

General engine, no hardcoding: scan the device for interpreters,
verify each, score wheel coverage for the project's native set,
and select the best. Provisioning on Termux stays inside pkg (no
sudo, no third-party repo is ever added automatically).
"""
from __future__ import annotations

import json
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

CURRENT = sys.version_info[:2]
MINIMUM = (3, 10)
NAMES = ["python3.14", "python3.13", "python3.12", "python3.11",
         "python3.10"]

# apt-style guesses per minor (tried, never assumed to exist).
TERMUX_PYTHON_PKGS = {"3.14": ["python"], "3.13": ["python3.13"],
                      "3.12": ["python3.12"], "3.11": ["python3.11"],
                      "3.10": ["python3.10"]}
SYSTEM_PYTHON_PKGS = {"3.14": ["python3.14"],
                      "3.13": ["python3.13", "python3.13-venv"],
                      "3.12": ["python3.12", "python3.12-venv"],
                      "3.11": ["python3.11", "python3.11-venv"],
                      "3.10": ["python3.10", "python3.10-venv"]}


def _run_text(exe, args, timeout=30):
    try:
        proc = subprocess.run(
            [exe] + args, stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT, timeout=timeout, text=True,
            errors="replace")
    except OSError:
        return None
    if proc.returncode != 0:
        return None
    return (proc.stdout or "").strip()


def find_pythons(extra_dirs=()):
    """Every usable interpreter except the running one."""
    found = []
    seen = set()
    dirs = list(extra_dirs)
    prefix = os.environ.get("PREFIX", "")
    if prefix:
        dirs.append(os.path.join(prefix, "bin"))
    for name in NAMES:
        exe = shutil.which(name)
        if exe is None:
            for directory in dirs:
                candidate = os.path.join(directory, name)
                if os.access(candidate, os.X_OK):
                    exe = candidate
                    break
        if exe is None:
            continue
        real = os.path.realpath(exe)
        if real in seen:
            continue
        seen.add(real)
        text = _run_text(exe, ["--version"], timeout=15) or ""
        match = re.search(r"(\d+)\.(\d+)", text)
        if not match:
            continue
        version = (int(match.group(1)), int(match.group(2)))
        if version == CURRENT or version < MINIMUM:
            continue
        found.append({"exe": exe, "version": version,
                      "text": text.splitlines()[0][:40]
                      if text else ""})
    return sorted(found, key=lambda item: item["version"],
                  reverse=True)


def verify_python(exe):
    """Executable + pip usable (venv implied by ensurepip check)."""
    version_text = _run_text(exe, ["--version"], timeout=15)
    if not version_text:
        return {"ok": False, "reason": "not executable"}
    pip_text = _run_text(exe, ["-m", "pip", "--version"],
                         timeout=60)
    if pip_text is None:
        return {"ok": False, "reason": "pip broken"}
    ensure = _run_text(exe, ["-m", "ensurepip", "--version"],
                       timeout=60)
    return {"ok": True, "version": version_text.splitlines()[0],
            "pip": pip_text.splitlines()[0][:60],
            "ensurepip": bool(ensure)}


def wheel_coverage(version_tuple, reqs, fp, assess):
    """Share of required native reqs with wheels on that python."""
    trial = dict(fp)
    trial["python_version"] = "%d.%d.0" % version_tuple
    native = [req for req in reqs if "name" in req]
    if not native:
        return 1.0
    ok = 0
    for req in native:
        try:
            verdict = assess(req, trial)
        except Exception:
            continue
        if verdict.get("status") == "WHEEL_OK":
            ok += 1
    return ok / len(native)


def select_runtime(candidates, current_coverage, reqs, fp, assess):
    """Best verified interpreter strictly better than current."""
    best = None
    for item in candidates:
        check = verify_python(item["exe"])
        if not check["ok"]:
            continue
        coverage = wheel_coverage(item["version"], reqs, fp,
                                  assess)
        scored = {"exe": item["exe"], "version": item["version"],
                  "coverage": coverage, "check": check}
        if coverage > current_coverage and (
                best is None or coverage > best["coverage"] or
                (coverage == best["coverage"] and
                 item["version"] > best["version"])):
            best = scored
    return best


def provision_names(version_tuple, termux):
    table = TERMUX_PYTHON_PKGS if termux else SYSTEM_PYTHON_PKGS
    return list(table.get("%d.%d" % version_tuple, []))


def venv_for(root, version_tuple=None):
    """Default .venv for the main runtime, suffixed clones else."""
    root = Path(root)
    if version_tuple is None or tuple(version_tuple) == CURRENT:
        return root / ".venv"
    return root / (".venv-py%d%d" % tuple(version_tuple))


def record_path(gov):
    return Path(gov) / "current-runtime.json"


def read_runtime(gov):
    try:
        data = json.loads(record_path(gov).read_text(
            encoding="utf-8"))
    except (OSError, ValueError):
        return {}
    return data if isinstance(data, dict) else {}


def record_runtime(gov, current, previous=None):
    gov = Path(gov)
    gov.mkdir(parents=True, exist_ok=True)
    payload = {"current": current}
    if previous:
        payload["previous"] = previous
    else:
        old = read_runtime(gov).get("current")
        if old and old != current:
            payload["previous"] = old
    record_path(gov).write_text(json.dumps(payload, indent=2),
                                encoding="utf-8")
    return payload


# -- termux package mirrors ------------------------------------------------

MIRROR_STATE = "pkg-mirrors.json"


def read_mirror_state(gov):
    try:
        data = json.loads((Path(gov) / MIRROR_STATE).read_text(
            encoding="utf-8"))
    except (OSError, ValueError):
        return {"failed": []}
    return data if isinstance(data, dict) else {"failed": []}


def write_mirror_state(gov, state):
    gov = Path(gov)
    gov.mkdir(parents=True, exist_ok=True)
    (gov / MIRROR_STATE).write_text(json.dumps(state, indent=2),
                                    encoding="utf-8")


def list_mirror_bases(prefix):
    """Mirror base URLs shipped with Termux (no network)."""
    mirror_dir = Path(prefix or "") / "etc" / "termux" / "mirrors"
    bases = []
    if not mirror_dir.is_dir():
        return []
    for path in sorted(mirror_dir.rglob("*")):
        if not path.is_file():
            continue
        try:
            text = path.read_text(encoding="utf-8",
                                  errors="replace")
        except OSError:
            continue
        for token in re.findall(r"https?://[^\s'\"]+", text):
            base = token.rstrip("/")
            if base not in bases:
                bases.append(base)
    return bases


def current_base(prefix):
    """Base URL of the configured main repo (None when unknown)."""
    sources = Path(prefix or "") / "etc" / "apt" / "sources.list"
    try:
        lines = sources.read_text(encoding="utf-8",
                                  errors="replace").splitlines()
    except OSError:
        return None
    for line in lines:
        match = re.match(r"\s*deb\s+(\S+)", line)
        if match:
            return match.group(1).rstrip("/")
    return None


def choose_mirror(prefix, failed):
    """First shipped mirror not known-bad (None when exhausted)."""
    for base in list_mirror_bases(prefix):
        if base not in failed:
            return base
    return None


def apply_mirror(prefix, new_base, say=None):
    """Point sources.list at a new base (backup kept, no delete)."""
    sources = Path(prefix or "") / "etc" / "apt" / "sources.list"
    try:
        text = sources.read_text(encoding="utf-8",
                                 errors="replace")
    except OSError as exc:
        return False, "cannot read sources.list: %s" % exc
    current = current_base(prefix)
    if not current:
        return False, "no deb line found"
    backup = sources.with_suffix(".list.apkforge-bak")
    try:
        if not backup.is_file():
            backup.write_text(text, encoding="utf-8")
        sources.write_text(text.replace(current, new_base),
                           encoding="utf-8")
    except OSError as exc:
        return False, "cannot rewrite sources.list: %s" % exc
    if say:
        say("pkg mirror switched %s -> %s" % (current, new_base))
    return True, current


def mirror_failed_signals(output):
    lowered = (output or "").lower()
    return ("failed to fetch" in lowered
            or "unable to connect" in lowered
            or "connection failed" in lowered
            or "404" in lowered and "not found" in lowered)
