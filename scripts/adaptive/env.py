"""Environment fingerprint: one detection pass per run.

Produces a stable fingerprint dict (plus a hash of the stable
subset used to validate checkpoints) and a capability profile the
rest of the pipeline decides from. Termux/Android is a first-class
platform, never assumed to be desktop Linux.
"""
from __future__ import annotations

import hashlib
import json
import os
import platform
import shutil
import socket
import subprocess
import sys
from pathlib import Path


def _get(env, key, default=""):
    source = os.environ if env is None else env
    return source.get(key, default)


# -- Termux / Android ----------------------------------------------------
def is_termux(env=None):
    prefix = _get(env, "PREFIX", "")
    home = _get(env, "HOME", "")
    return "com.termux" in prefix or "com.termux" in home


def _run_text(argv, timeout=5):
    try:
        proc = subprocess.run(
            argv, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
            timeout=timeout, text=True, errors="replace")
    except (OSError, subprocess.TimeoutExpired):
        return None
    if proc.returncode != 0:
        return None
    return proc.returncode, proc.stdout.strip()


def android_api_level():
    getlevel = getattr(sys, "getandroidapilevel", None)
    if callable(getlevel):
        try:
            return int(getlevel())
        except (OSError, ValueError):
            return None
    return None


def detect_termux(env=None):
    """Termux specifics; {termux: False} anywhere else."""
    if not is_termux(env):
        return {"termux": False}
    prefix = _get(env, "PREFIX", "")
    info = {"termux": True, "prefix": prefix,
            "home": _get(env, "HOME", ""),
            "android_api": android_api_level(),
            "android_release": None, "repos": []}
    if shutil.which("getprop"):
        out = _run_text(["getprop", "ro.build.version.release"])
        info["android_release"] = out[1] if out else None
    repos = Path(prefix) / "etc" / "apt" / "sources.list.d"
    try:
        info["repos"] = sorted(
            path.name for path in repos.iterdir()
            if path.suffix == ".list") if repos.is_dir() else []
    except OSError:
        info["repos"] = []
    return info


# -- OS / distro ----------------------------------------------------------
def parse_os_release(text):
    values = {}
    for line in (text or "").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        values[key.strip()] = value.strip().strip("'").strip('"')
    return values


def detect_distro(env=None, os_release_path="/etc/os-release"):
    if is_termux(env):
        return {"id": "android-termux", "name": "Android/Termux",
                "version": "", "like": "android"}
    try:
        text = Path(os_release_path).read_text(encoding="utf-8",
                                               errors="replace")
    except OSError:
        text = ""
    values = parse_os_release(text)
    return {"id": values.get("ID", platform.system().lower()),
            "name": values.get("PRETTY_NAME",
                               values.get("NAME", platform.system())),
            "version": values.get("VERSION_ID", ""),
            "like": values.get("ID_LIKE", "")}


def detect_libc():
    name, _version = platform.libc_ver()
    if android_api_level() is not None:
        return "bionic"
    return (name or "unknown").lower()


# -- hardware --------------------------------------------------------------
def detect_cpu():
    info = {"count": os.cpu_count() or 1, "machine": platform.machine(),
            "bits": "64" if sys.maxsize > 2 ** 32 else "32",
            "features": None}
    try:
        text = Path("/proc/cpuinfo").read_text(encoding="utf-8",
                                               errors="replace")
    except OSError:
        text = ""
    for line in text.splitlines():
        if line.startswith(("flags", "Features")) and ":" in line:
            info["features"] = line.split(":", 1)[1].strip()
            break
    return info


def detect_ram_mb():
    try:
        text = Path("/proc/meminfo").read_text(encoding="utf-8",
                                               errors="replace")
    except OSError:
        text = ""
    for line in text.splitlines():
        if line.startswith("MemTotal:"):
            parts = line.split()
            if len(parts) >= 2 and parts[1].isdigit():
                return int(parts[1]) // 1024
    if sys.platform == "darwin" and shutil.which("sysctl"):
        out = _run_text(["sysctl", "-n", "hw.memsize"])
        if out and out[1].isdigit():
            return int(out[1]) // (1024 * 1024)
    return None


def detect_disk(path):
    try:
        usage = shutil.disk_usage(str(path))
    except OSError:
        return {"free_mb": None, "total_mb": None, "fstype": None}
    fstype = None
    try:
        mounts = Path("/proc/mounts").read_text(
            encoding="utf-8", errors="replace").splitlines()
    except OSError:
        mounts = []
    best = ""
    for line in mounts:
        parts = line.split()
        if len(parts) >= 3 and str(path).startswith(parts[1]) \
                and len(parts[1]) > len(best):
            best, fstype = parts[1], parts[2]
    return {"free_mb": usage.free // (1024 * 1024),
            "total_mb": usage.total // (1024 * 1024),
            "fstype": fstype}


# -- network (single quick probe) -------------------------------------------
def probe_network(timeout=3):
    """One cheap probe: DNS + TCP to the two registries we need."""
    result = {"reachable": False, "dns": False, "ipv4": False,
              "ipv6": False}
    try:
        infos = socket.getaddrinfo("pypi.org", 443)
        result["dns"] = True
        for family, _, _, _, _ in infos:
            if family == socket.AF_INET:
                result["ipv4"] = True
            elif family == socket.AF_INET6:
                result["ipv6"] = True
    except OSError:
        return result
    for host in ("pypi.org", "registry.npmjs.org"):
        try:
            sock = socket.create_connection((host, 443),
                                            timeout=timeout)
            sock.close()
            result["reachable"] = True
            return result
        except OSError:
            continue
    return result


# -- managers / permissions / containers --------------------------------------
def detect_package_managers(env=None):
    found = []
    for manager in ("pkg", "apt-get", "dnf", "apk", "pacman",
                    "zypper", "brew"):
        if shutil.which(manager):
            found.append(manager)
    if is_termux(env) and "pkg" in found:
        found.remove("pkg")
        found.insert(0, "pkg")
    return found


def detect_permissions(root):
    root = str(root)
    home = os.path.expanduser("~")
    info = {"euid_zero": bool(hasattr(os, "geteuid")
                              and os.geteuid() == 0),
            "sudo_nopasswd": False,
            "writable_root": os.access(root, os.W_OK),
            "writable_home": os.access(home, os.W_OK)}
    if shutil.which("sudo"):
        try:
            proc = subprocess.run(
                ["sudo", "-n", "true"], stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL, timeout=5)
            info["sudo_nopasswd"] = proc.returncode == 0
        except OSError:
            pass
    return info


def detect_containers():
    info = {"docker": shutil.which("docker") is not None,
            "podman": shutil.which("podman") is not None,
            "virt": None, "wsl": "microsoft" in
            platform.release().lower()}
    if shutil.which("systemd-detect-virt"):
        out = _run_text(["systemd-detect-virt"])
        info["virt"] = out[1] if out else None
    return info


# -- fingerprint --------------------------------------------------------------
STABLE_KEYS = ("os_id", "arch_machine", "termux", "libc",
               "python_version", "managers")


def fingerprint(root, env=None, probe=True):
    """Full one-pass environment fingerprint (JSON-serializable)."""
    root = Path(root)
    distro = detect_distro(env)
    termux = detect_termux(env)
    managers = detect_package_managers(env)
    data = {
        "os": platform.system(), "os_release": platform.release(),
        "os_id": distro["id"], "distro": distro,
        "kernel": platform.version(),
        "arch": detect_cpu(), "arch_machine": platform.machine(),
        "libc": detect_libc(),
        "termux": termux["termux"], "termux_detail": termux,
        "python_version": platform.python_version(),
        "python_exe": sys.executable,
        "shell": _get(env, "SHELL", ""),
        "path_entries": len(_get(env, "PATH", "").split(os.pathsep)),
        "home": _get(env, "HOME", os.path.expanduser("~")),
        "cwd": str(Path.cwd()), "root": str(root),
        "ram_mb": detect_ram_mb(), "disk": detect_disk(root),
        "managers": managers,
        "permissions": detect_permissions(root),
        "containers": detect_containers(),
        "network": probe_network() if probe
        else {"reachable": None, "dns": None, "ipv4": None,
              "ipv6": None},
    }
    stable = {key: data.get(key) for key in STABLE_KEYS}
    data["fingerprint_hash"] = hashlib.sha256(
        json.dumps(stable, sort_keys=True,
                   default=str).encode()).hexdigest()[:16]
    return data


# -- capability profile ---------------------------------------------------------
def capability_profile(fp, inventory=None):
    """Small decision profile derived from fingerprint + inventory."""
    if fp.get("termux"):
        platform_name = "android-termux"
    else:
        system = (fp.get("os") or "").lower()
        platform_name = {"linux": "linux", "darwin": "macos",
                         "windows": "windows"}.get(system, "other")
    versions = {}
    for row in inventory or []:
        if row.get("status") == "AVAILABLE":
            versions[row["tool"]] = row.get("detected")
    managers = fp.get("managers") or []
    return {
        "platform": platform_name,
        "arch": fp.get("arch_machine", ""),
        "libc": fp.get("libc", ""),
        "python": fp.get("python_version", ""),
        "node": versions.get("node"),
        "java": versions.get("java"),
        "package_manager": managers[0] if managers else None,
        "network": (fp.get("network") or {}).get("reachable"),
        "compiler_c": shutil.which("cc") is not None
        or shutil.which("gcc") is not None
        or shutil.which("clang") is not None,
        "compiler_rust": shutil.which("rustc") is not None
        and shutil.which("cargo") is not None,
        "disk_free_mb": (fp.get("disk") or {}).get("free_mb"),
    }
