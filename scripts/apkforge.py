#!/usr/bin/env python3
"""APKForge adaptive bootstrap engine: detect → classify → plan →
verify → provision → install → validate → recover → continue.

Stdlib only. Never prints or logs secrets. Run from anywhere:
  ./apkforge              full pipeline (default)
  ./apkforge --check      audit only, no changes
  ./apkforge --plan       show bootstrap plan, no changes
  ./apkforge --status     services + state, no changes
  ./apkforge --repair     re-run pipeline, retry failed steps
  ./apkforge --reset-dev  guarded dev reset (never touches prod)
  ./apkforge --logs       tail this run's logs
  ./apkforge --stop       stop local services
  ./apkforge gitcare ...  repository health + cleanup + recovery
"""
import argparse
import hashlib
import json
import os
import platform
import re
import secrets
import shutil
import socket
import subprocess
import sys
import tarfile
import tempfile
import time
import urllib.error
import urllib.request
import webbrowser
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from adaptive import checkpoint as _checkpoint
from adaptive import compat as _compat
from adaptive import env as _env
from adaptive import gitcare as _gitcare
from adaptive import plan as _plan
from adaptive import recovery as _recovery
from adaptive import runtime as _runtime
from adaptive import strategy as _strategy
from adaptive import tools as _tools

ROOT = Path(__file__).resolve().parents[1]
GOV = ROOT / ".governance"
LOGS = ROOT / "logs"
TOOLS_DIR = ROOT / ".tools"
VENV = ROOT / ".venv"

ENGINE_VERSION = "2.0.0"
MIN_PYTHON = (3, 10)
MIN_NODE = (20, 0)

STATES = ("INIT", "ENVIRONMENT_CHECK", "ENVIRONMENT_DETECTED",
          "TOOLS_INVENTORIED", "COMPATIBILITY_RESOLVED",
          "PLAN_CREATED", "TOOLS_READY", "CONFIG_READY",
          "RUNTIME_READY", "DEPENDENCIES_READY", "DATABASE_READY",
          "MIGRATIONS_READY", "SEED_READY", "BUILD_READY",
          "SERVICES_READY", "HEALTHY", "ADMIN_SETUP_REQUIRED",
          "GIT_RECOVERY_REQUIRED", "RECOVERING", "BLOCKED",
          "RECOVERY_AVAILABLE", "READY", "FAILED")

SECRET_PATTERNS = (
    re.compile(r"(?i)(bearer\s+)[A-Za-z0-9._~+/-]+=*"),
    re.compile(r"(?i)(apikey|api_key|token|secret|password|passwd)\s*"
               r"[:=]\s*['\"]?([^'\"\s,}]+)"),
    re.compile(r"(eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\."
               r"[A-Za-z0-9_-]{10,})"),
)


def redact(text):
    text = str(text)
    text = SECRET_PATTERNS[0].sub(r"\1[redacted]", text)
    text = SECRET_PATTERNS[1].sub(r"\1=[redacted]", text)
    return SECRET_PATTERNS[2].sub("[jwt-redacted]", text)


class Ctx:
    """Per-run context: logging, state, timing."""

    def __init__(self, run_id, log_path, quiet=False, json_only=False):
        self.run_id = run_id
        self.log_path = log_path
        self.quiet = quiet
        self.json_only = json_only
        self.state = "INIT"
        self.history = []
        self.step_started = time.time()
        self.warnings = []
        self.recovery = []
        log_path.parent.mkdir(parents=True, exist_ok=True)
        self._handle = open(log_path, "a", encoding="utf-8")

    def say(self, message):
        line = "[%s] %s" % (time.strftime("%H:%M:%S"), redact(message))
        self._handle.write(line + "\n")
        self._handle.flush()
        if not self.quiet and not self.json_only:
            print(line, flush=True)

    def warn(self, message):
        self.warnings.append(redact(message))
        self.say("WARN: " + message)

    def recovered(self, strategy, detail=""):
        self.recovery.append({"strategy": strategy,
                              "detail": redact(detail)})
        suffix = ": " + detail if detail else ""
        self.say("recovered via %s%s" % (strategy, suffix))

    def step(self, state):
        assert state in STATES, state
        self.state = state
        self.history.append({"state": state,
                             "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ",
                                                 time.gmtime())})
        save_state(self)
        self.say("== %s ==" % state)

    def close(self):
        try:
            self._handle.close()
        except Exception:
            pass


def new_run_id():
    stamp = time.strftime("%Y%m%d-%H%M%S", time.localtime())
    rand = secrets.token_hex(2).upper()
    return "APKFORGE-%s-%s" % (stamp, rand)


def save_state(ctx):
    GOV.mkdir(parents=True, exist_ok=True)
    try:
        previous = json.loads(
            (GOV / "bootstrap-state.json").read_text(
                encoding="utf-8"))
    except (OSError, ValueError):
        previous = {}
    payload = {"run_id": ctx.run_id, "state": ctx.state,
               "updated_at": time.strftime("%Y-%m-%dT%H:%M:%SZ",
                                           time.gmtime()),
               "history": ctx.history[-40:]}
    if isinstance(previous, dict):
        for key in ("stages", "fingerprint_hash"):
            if key in previous:
                payload[key] = previous[key]
    (GOV / "bootstrap-state.json").write_text(
        json.dumps(payload, indent=2), encoding="utf-8")


def load_state():
    path = GOV / "bootstrap-state.json"
    if not path.is_file():
        return None
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except ValueError:
        return None


def record_failure(ctx, step, method, error, alternative):
    GOV.mkdir(parents=True, exist_ok=True)
    record = {"run_id": ctx.run_id, "step": step, "method": method,
              "result": "failed", "error": redact(error)[:500],
              "alternative": alternative,
              "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())}
    with open(GOV / "failures.jsonl", "a", encoding="utf-8") as handle:
        handle.write(json.dumps(record) + "\n")
    return record


def last_failure(step):
    path = GOV / "failures.jsonl"
    if not path.is_file():
        return None
    found = None
    for line in path.read_text(encoding="utf-8").splitlines():
        try:
            record = json.loads(line)
        except ValueError:
            continue
        if record.get("step") == step:
            found = record
    return found


# -- subprocess + http ------------------------------------------------
def run(argv, ctx=None, timeout=300, cwd=None, env=None, check=False):
    started = time.time()
    try:
        proc = subprocess.run(
            argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
            timeout=timeout, cwd=str(cwd or ROOT), env=env, text=True,
            errors="replace")
        output = proc.stdout[-16000:]
        if ctx:
            ctx.say("$ %s → %d (%.1fs)" % (
                " ".join(argv[:4]), proc.returncode,
                time.time() - started))
        if check and proc.returncode != 0:
            raise RuntimeError("exit %d: %s" % (proc.returncode,
                                                output[-500:]))
        return proc.returncode, output
    except subprocess.TimeoutExpired:
        if ctx:
            ctx.say("$ %s → TIMEOUT" % " ".join(argv[:4]))
        raise RuntimeError("timed out: %s" % " ".join(argv[:4]))


def http_json(method, url, body=None, timeout=15):
    data = None
    headers = {}
    if body is not None:
        data = json.dumps(body).encode("utf-8")
        headers["Content-Type"] = "application/json"
    request = urllib.request.Request(url, data=data, headers=headers,
                                     method=method)
    try:
        with urllib.request.urlopen(request, timeout=timeout) as resp:
            raw = resp.read(1_000_000)
    except urllib.error.HTTPError as exc:
        raw = exc.read(10000)
        return exc.code, raw.decode("utf-8", "replace")
    try:
        return 200, json.loads(raw.decode("utf-8"))
    except ValueError:
        return 200, raw.decode("utf-8", "replace")


def parse_version(text):
    return _tools.parse_version(text)


def port_free(port):
    sock = socket.socket()
    sock.settimeout(1)
    try:
        sock.connect(("127.0.0.1", port))
        return False
    except OSError:
        return True
    finally:
        sock.close()


def pid_alive(pid):
    try:
        os.kill(pid, 0)
        return True
    except (ProcessLookupError, PermissionError, OSError):
        return False


def has_network(ctx=None, timeout=6):
    targets = [("pypi.org", 443), ("registry.npmjs.org", 443)]
    for host, port in targets:
        try:
            socket.create_connection((host, port),
                                     timeout=timeout).close()
            return True
        except OSError:
            continue
    if ctx:
        ctx.say("network: unreachable (offline mode)")
    return False


# -- environment audit ------------------------------------------------
def audit_environment(ctx):
    fp = _env.fingerprint(ROOT)
    disk = fp.get("disk") or {}
    network = fp.get("network") or {}
    facts = {
        "os": fp["os"],
        "os_release": fp["os_release"],
        "arch": fp["arch_machine"],
        "kernel": fp["kernel"],
        "cpu_count": fp["arch"]["count"],
        "python": fp["python_version"],
        "shell": fp["shell"],
        "cwd": fp["cwd"],
        "root": fp["root"],
        "ram_mb": fp["ram_mb"],
        "disk_free_mb": disk.get("free_mb")
        if disk.get("free_mb") is not None else -1,
        "network": bool(network.get("reachable")),
        "writable_root": fp["permissions"]["writable_root"],
        "fingerprint": fp,
    }
    if not facts["network"]:
        ctx.say("network: unreachable (offline mode)")
    return facts


def tool_version(argv):
    try:
        proc = subprocess.run(argv, stdout=subprocess.PIPE,
                              stderr=subprocess.STDOUT, timeout=15,
                              text=True, errors="replace")
        return parse_version(proc.stdout), proc.returncode
    except (OSError, subprocess.TimeoutExpired):
        return None, -1


TOOL_MATRIX = [
    {"tool": "python3", "kind": "required", "want": ">=3.10",
     "detect": ["python3", "--version"], "min": MIN_PYTHON,
     "method": "preinstalled (bootstrap itself needs it)",
     "source": "system"},
    {"tool": "pip", "kind": "required", "want": "any",
     "detect": [sys.executable, "-m", "pip", "--version"],
     "min": None, "method": "python -m ensurepip",
     "source": "stdlib"},
    {"tool": "node", "kind": "required", "want": ">=20",
     "detect": ["node", "--version"], "min": MIN_NODE,
     "method": "package manager, else nodejs.org tarball → .tools",
     "source": "system or nodejs.org"},
    {"tool": "npm", "kind": "required", "want": "bundled with node",
     "detect": ["npm", "--version"], "min": None,
     "method": "ships with node", "source": "system or nodejs.org"},
    {"tool": "java", "kind": "optional", "want": ">=11 for apktool/jadx",
     "detect": ["java", "-version"], "min": (11, 0),
     "method": "package manager (only if you run real tools)",
     "source": "system"},
    {"tool": "apktool", "kind": "optional",
     "want": "3.x (or APKFORGE_APKTOOL)",
     "detect": ["apktool", "--version"], "min": None,
     "method": "--install-tools downloads the release jar → .tools",
     "source": "github.com/iBotPeaches/Apktool"},
    {"tool": "jadx", "kind": "optional",
     "want": "1.5.x (or APKFORGE_JADX)",
     "detect": ["jadx", "--version"], "min": None,
     "method": "manual install (release is ~130MB; never auto-fetched)",
     "source": "github.com/skylot/jadx"},
    {"tool": "git", "kind": "optional", "want": "any for version info",
     "detect": ["git", "--version"], "min": None,
     "method": "package manager", "source": "system"},
    {"tool": "sqlite3", "kind": "optional",
     "want": "cli convenience (python covers the need)",
     "detect": ["sqlite3", "--version"], "min": None,
     "method": "package manager", "source": "system"},
    {"tool": "curl", "kind": "optional",
     "want": "user convenience (engine uses urllib)",
     "detect": ["curl", "--version"], "min": None,
     "method": "package manager", "source": "system"},
    {"tool": "docker", "kind": "not-needed-phase1",
     "want": "phase 2+ only",
     "detect": ["docker", "--version"], "min": None,
     "method": "not installed by this bootstrap",
     "source": "-", "not_on": ["android-termux"]},
]


def _legacy_row(spec, fp):
    """Re-probe exactly one tool (provisioning verification)."""
    probed = _tools.probe(spec)
    platform_name = "android-termux" if fp.get("termux") else None
    status = _tools.classify(spec, probed, platform_name,
                             fp.get("libc"))
    role = _tools.role_of(spec["kind"])
    if role != "REQUIRED" and status != "AVAILABLE":
        legacy_status = "skip-" + status.lower().replace("_",
                                                         "-")
    else:
        legacy_status = {"AVAILABLE": "ok", "MISSING": "missing",
                         "OUTDATED": "too-old",
                         "INCOMPATIBLE": "incompatible",
                         "BROKEN": "broken",
                         "NOT_APPLICABLE": "skip-na"}.get(
                             status, status)
    detected = probed["detected_text"] or "-"
    return {
        "tool": spec["tool"], "kind": spec["kind"], "role": role,
        "status": legacy_status, "adaptive_status": status,
        "required_version": spec.get("want", ""),
        "detected_version": detected, "path": probed["path"],
        "installation_method": spec.get("method", ""),
        "source": spec.get("source", "")}


def _spec_of(tool):
    for spec in TOOL_MATRIX:
        if spec["tool"] == tool:
            return spec
    raise RuntimeError("unknown tool %r" % (tool,))


def detect_tools(ctx, fp=None):
    """Inventory every tool exactly once (never re-scan blindly)."""
    if fp is None:
        fp = _env.fingerprint(ROOT, probe=False)
    rows = [_legacy_row(spec, fp) for spec in TOOL_MATRIX]
    for row in rows:
        mark = "OK " if row["adaptive_status"] == "AVAILABLE" \
            else ("WARN" if row["role"] != "REQUIRED"
                  else "MISS")
        ctx.say("tool %-10s %-4s detected=%s want=%s" % (
            row["tool"], mark, row["detected_version"],
            row["required_version"]))
    return rows


# -- provisioning -----------------------------------------------------
def package_manager():
    if _env.is_termux() and shutil.which("pkg"):
        return "pkg", ["pkg", "install", "-y"]
    for manager, args in (("apt-get", ["apt-get", "install", "-y"]),
                          ("dnf", ["dnf", "install", "-y"]),
                          ("apk", ["apk", "add"]),
                          ("brew", ["brew", "install"])):
        if shutil.which(manager):
            return manager, args
    return None, None


def can_elevate():
    if _env.is_termux() and shutil.which("pkg"):
        return True  # pkg needs no sudo
    if os.name != "posix":
        return False
    if hasattr(os, "geteuid") and os.geteuid() == 0:
        return True
    if not shutil.which("sudo"):
        return False
    try:
        proc = subprocess.run(["sudo", "-n", "true"],
                              stdout=subprocess.DEVNULL,
                              stderr=subprocess.DEVNULL, timeout=10)
        return proc.returncode == 0
    except OSError:
        return False


_PKG_UPDATED = False


def install_via_manager(ctx, package):
    manager, args = package_manager()
    if manager is None:
        raise RuntimeError("no system package manager found")
    if not can_elevate():
        raise RuntimeError(
            "package manager needs privileges (no passwordless sudo)")
    global _PKG_UPDATED
    termux = manager == "pkg"
    if termux and not _PKG_UPDATED:
        code, _ = run(["pkg", "update"], ctx, timeout=300)
        _PKG_UPDATED = True
        if code != 0:
            ctx.warn("pkg update failed; trying install anyway")
    prefix = [] if (termux or (hasattr(os, "geteuid")
                              and os.geteuid() == 0)) \
        else ["sudo", "-n"]
    code, output = run(prefix + args + [package], ctx, timeout=600)
    if code != 0:
        raise RuntimeError("%s failed: %s" % (manager, output[-300:]))


def pkg_install_resilient(ctx, package, gov=None):
    """install_via_manager + one Termux mirror switch on fetch failure."""
    gov = gov or GOV
    try:
        return install_via_manager(ctx, package)
    except RuntimeError as exc:
        message = str(exc)
        if not (_env.is_termux()
                and _runtime.mirror_failed_signals(message)):
            raise
        state = _runtime.read_mirror_state(gov)
        failed = list(state.get("failed", []))
        prefix = os.environ.get("PREFIX", "")
        current = _runtime.current_base(prefix)
        if current and current not in failed:
            failed.append(current)
        nxt = _runtime.choose_mirror(prefix, failed)
        if nxt is None:
            _runtime.write_mirror_state(gov, {"failed": failed})
            raise RuntimeError(
                "pkg mirror failed and no untried mirror left: %s"
                % message[-200:])
        ok, detail = _runtime.apply_mirror(
            prefix, nxt, say=ctx.say)
        _runtime.write_mirror_state(
            gov, {"failed": failed, "current": nxt if ok else current})
        if not ok:
            raise RuntimeError("mirror switch failed: %s" % detail)
        code, _ = run(["pkg", "update"], ctx, timeout=300)
        if code != 0:
            ctx.warn("pkg update on the new mirror failed; "
                     "trying install anyway")
        ctx.recovered("pkg-mirror", nxt)
        return install_via_manager(ctx, package)


def download(url, target, ctx, timeout=120):
    target = Path(target)
    target.parent.mkdir(parents=True, exist_ok=True)
    ctx.say("fetch %s (%s)" % (url, target.name))
    request = urllib.request.Request(
        url, headers={"User-Agent": "apkforge-bootstrap/1.0"})
    with urllib.request.urlopen(request,
                                timeout=timeout) as resp, \
            open(target, "wb") as handle:
        shutil.copyfileobj(resp, handle, 65536)
    return target


def install_node_local(ctx):
    """Fetch the latest Node 20 LTS tarball into .tools (verified)."""
    if platform.system() != "Linux" or platform.machine() not in (
            "x86_64", "amd64", "aarch64", "arm64"):
        raise RuntimeError("local node install supports Linux "
                           "x86_64/aarch64 only")
    index_url = "https://nodejs.org/dist/index.json"
    request = urllib.request.Request(
        index_url, headers={"User-Agent": "apkforge-bootstrap/1.0"})
    with urllib.request.urlopen(request, timeout=60) as resp:
        index = json.loads(resp.read().decode("utf-8"))
    pick = next((item for item in index
                 if item["version"].startswith("v20") and item.get("lts")),
                None)
    if not pick:
        raise RuntimeError("no Node 20 LTS in nodejs.org index")
    version = pick["version"]
    arch = "x64" if platform.machine() in ("x86_64", "amd64") else "arm64"
    base = "node-%s-linux-%s" % (version, arch)
    dist = "https://nodejs.org/dist/%s/" % version
    tmp = Path(tempfile.mkdtemp(prefix="apkforge-node-"))
    try:
        archive = download(dist + base + ".tar.xz", tmp / "node.tar.xz",
                           ctx)
        sums = download(dist + "SHASUMS256.txt", tmp / "sums.txt", ctx)
        digest = hashlib.sha256(archive.read_bytes()).hexdigest()
        wanted = [line.split()[0] for line in
                  sums.read_text().splitlines()
                  if line.endswith(base + ".tar.xz")]
        if not wanted or wanted[0] != digest:
            raise RuntimeError("node checksum mismatch")
        node_dir = TOOLS_DIR / "node"
        if node_dir.exists():
            shutil.rmtree(node_dir)
        with tarfile.open(archive, "r:xz") as tar:
            tar.extractall(tmp)
        shutil.move(str(tmp / base), str(node_dir))
    finally:
        shutil.rmtree(tmp, ignore_errors=True)
    bindir = str(TOOLS_DIR / "node" / "bin")
    prepend_path([bindir])
    version_found, _ = tool_version(["node", "--version"])
    if not version_found or version_found < MIN_NODE:
        raise RuntimeError("local node install did not take effect")
    ctx.say("node %s installed locally" % version)


def prepend_path(entries):
    current = os.environ.get("PATH", "")
    parts = [entry for entry in entries
             if entry and entry not in current.split(os.pathsep)]
    if parts:
        os.environ["PATH"] = os.pathsep.join(parts + [current])
    GOV.mkdir(parents=True, exist_ok=True)
    (GOV / "path.json").write_text(
        json.dumps({"prepend": entries}), encoding="utf-8")
    if os.name == "posix":
        (GOV / "path.sh").write_text(
            'export PATH="%s:$PATH"\n' % ":".join(entries),
            encoding="utf-8")


def load_local_path():
    path = GOV / "path.json"
    if not path.is_file():
        return
    try:
        entries = json.loads(path.read_text(encoding="utf-8")).get(
            "prepend", [])
        current = os.environ.get("PATH", "")
        fresh = [entry for entry in entries
                 if entry not in current.split(os.pathsep)]
        if fresh:
            os.environ["PATH"] = os.pathsep.join(fresh + [current])
    except ValueError:
        pass


def _provision_pip(ctx, ledger, env_hash):
    sig = _recovery.failure_signature("TOOLS", "MISSING", "pip",
                                      "ensurepip", env_hash)
    if ledger.attempted("TOOLS", sig, "ensurepip"):
        raise RuntimeError("pip ensurepip already failed once; "
                           "repair python, then re-run")
    ctx.say("pip missing → python -m ensurepip")
    code, output = run([sys.executable, "-m", "ensurepip",
                        "--default-pip"], ctx, timeout=180)
    ledger.record("TOOLS", sig, "ensurepip",
                  "python -m ensurepip", env_hash,
                  "ok" if code == 0 else "failed",
                  "" if code == 0 else output[-300:])
    if code != 0:
        raise RuntimeError("ensurepip failed")


def _provision_node(ctx, offline, ledger, env_hash):
    tried = []
    manager, _ = package_manager()
    if not offline and manager is not None:
        sig = _recovery.failure_signature("TOOLS", "MISSING",
                                          "node", "manager",
                                          env_hash)
        if not ledger.attempted("TOOLS", sig, "manager"):
            try:
                install_via_manager(ctx, "nodejs")
                tried.append("manager:nodejs")
                ledger.record("TOOLS", sig, "manager",
                              "%s nodejs" % manager, env_hash,
                              "ok")
            except RuntimeError as exc:
                ledger.record("TOOLS", sig, "manager",
                              "%s nodejs" % manager, env_hash,
                              "failed", str(exc))
                ctx.warn("manager node install failed: %s" % exc)
    if _tools.probe(_spec_of("node"))["detected"] is None:
        if offline:
            raise RuntimeError(
                "NETWORK REQUIRED: node >=20 missing and offline")
        sig = _recovery.failure_signature("TOOLS", "MISSING",
                                          "node", "tarball",
                                          env_hash)
        if ledger.attempted("TOOLS", sig, "tarball"):
            raise RuntimeError(
                "node tarball already failed once; install "
                "node 20 manually, then re-run")
        try:
            install_node_local(ctx)
            tried.append("tarball")
            ledger.record("TOOLS", sig, "tarball",
                          "nodejs.org tarball", env_hash, "ok")
        except RuntimeError as exc:
            ledger.record("TOOLS", sig, "tarball",
                          "nodejs.org tarball", env_hash,
                          "failed", str(exc))
            raise
    ctx.say("node provisioned via %s" % "+".join(tried))


def ensure_required_tools(ctx, offline, rows, ledger, env_hash,
                          fp):
    """Provision from the single inventory; re-probe only touched."""
    by_name = {row["tool"]: row for row in rows}
    if by_name["python3"]["adaptive_status"] != "AVAILABLE":
        raise RuntimeError("python3 >=3.10 is the one prerequisite "
                           "this bootstrap cannot install itself")
    if by_name["pip"]["adaptive_status"] != "AVAILABLE":
        _provision_pip(ctx, ledger, env_hash)
        by_name["pip"] = _legacy_row(_spec_of("pip"), fp)
    if by_name["node"]["adaptive_status"] != "AVAILABLE":
        _provision_node(ctx, offline, ledger, env_hash)
        by_name["node"] = _legacy_row(_spec_of("node"), fp)
        by_name["npm"] = _legacy_row(_spec_of("npm"), fp)
    rows[:] = [by_name[spec["tool"]] for spec in TOOL_MATRIX]
    missing = [name for name in
               ("python3", "pip", "node", "npm")
               if by_name[name]["adaptive_status"] != "AVAILABLE"]
    if missing:
        raise RuntimeError("required tools still missing: %s"
                           % ", ".join(missing))
    return rows


def install_apktool(ctx):
    """Download the Apktool release jar into .tools (opt-in)."""
    api_url = ("https://api.github.com/repos/iBotPeaches/Apktool/"
               "releases/latest")
    request = urllib.request.Request(
        api_url, headers={"User-Agent": "apkforge-bootstrap/1.0",
                          "Accept": "application/vnd.github+json"})
    with urllib.request.urlopen(request, timeout=60) as resp:
        release = json.loads(resp.read().decode("utf-8"))
    assets = [asset for asset in release.get("assets", [])
              if asset["name"].endswith(".jar")]
    if not assets:
        raise RuntimeError("no jar asset in latest Apktool release")
    asset = assets[0]
    target = TOOLS_DIR / "apktool" / "apktool.jar"
    download(asset["browser_download_url"], target, ctx)
    if target.stat().st_size < 10_000_000:
        raise RuntimeError("apktool jar suspiciously small")
    import zipfile
    with zipfile.ZipFile(target) as archive:
        names = archive.namelist()
    if not any(name == "brut/apktool/Main.class" for name in names):
        raise RuntimeError("downloaded jar is not Apktool")
    wrapper = TOOLS_DIR / "apktool" / "apktool"
    wrapper.write_text('#!/bin/sh\nexec java -jar "%s" "$@"\n' % target,
                       encoding="utf-8")
    wrapper.chmod(0o755)
    prepend_path([str(wrapper.parent)])
    ctx.say("apktool %s installed locally" % release.get("tag_name"))
    return str(target)


class RecoveryExhausted(RuntimeError):
    """Every recovery strategy failed; carries the diagnostic."""

    def __init__(self, info):
        super().__init__("auto-recovery exhausted")
        self.info = info


def exhaustion_state(info):
    """RECOVERY_AVAILABLE when a human/unlock step can resume work.

    BLOCKED is reserved for failures with no known next action.
    """
    if info.get("needs_you") or info.get("required"):
        return "RECOVERY_AVAILABLE"
    return "BLOCKED"


TOOLCHAIN_PKGS = {
    "pkg": {"c": ["clang"], "rust": ["rust"]},
    "apt-get": {"c": ["build-essential", "python3-dev"],
                "rust": ["rustc", "cargo"]},
    "dnf": {"c": ["gcc", "python3-devel"],
            "rust": ["rustc", "cargo"]},
    "apk": {"c": ["build-base", "python3-dev"],
            "rust": ["rust", "cargo"]},
    "brew": {"c": [], "rust": ["rust"]},
}


def _venv_python():
    return VENV / ("Scripts" if os.name == "nt" else "bin") / \
        ("python.exe" if os.name == "nt" else "python")


def _runtime_record():
    return _runtime.read_runtime(GOV)


def _current_python(default_python=None):
    """Recorded runtime interpreter, else the given/default one."""
    record = _runtime_record().get("current") or {}
    exe = record.get("python")
    if exe and Path(exe).is_file():
        return Path(exe)
    if default_python is not None:
        return Path(default_python)
    return _venv_python()


def validate_venv(ctx, python):
    """Validate an existing venv (version/pip/arch; no changes)."""
    if not Path(python).is_file():
        return False, "no interpreter"
    code, _ = run([str(python), "--version"], ctx, timeout=30)
    if code != 0:
        return False, "interpreter broken"
    code, _ = run([str(python), "-m", "pip", "--version"], ctx,
                  timeout=60)
    if code != 0:
        return False, "pip broken"
    code, output = run(
        [str(python), "-c",
         "import platform; print(platform.machine())"], ctx,
        timeout=30)
    if code == 0 and output.strip():
        arch = output.strip().splitlines()[-1]
        if arch and arch != platform.machine():
            return False, "arch mismatch (%s)" % arch
    return True, "ok"


def _backend_imports_ok(ctx, python):
    code, _ = run(
        [str(python), "-c",
         "import fastapi, uvicorn, pydantic; "
         "print(fastapi.__version__, pydantic.VERSION)"], ctx,
        timeout=60)
    return code == 0


def _import_ok(ctx, python, module):
    """True when `import <module>` works under that interpreter."""
    code, output = run(
        [str(python), "-c",
         "import %s; print('import-ok')" % module], ctx,
        timeout=120)
    return code == 0 and "import-ok" in output


def _write_lock(ctx, python):
    code, output = run([str(python), "-m", "pip", "freeze",
                        "--exclude-editable"], ctx, timeout=120)
    if code != 0:
        ctx.warn("pip freeze failed; resolution not locked")
        return
    GOV.mkdir(parents=True, exist_ok=True)
    (GOV / "requirements.lock").write_text(output,
                                           encoding="utf-8")
    count = len([line for line in output.splitlines()
                 if line.strip() and not line.startswith("#")])
    ctx.say("dependency resolution locked (%d pins)" % count)


def _newer_with_wheels(package, fp, cache_dir):
    """Latest release installable here (None when none/offline)."""
    release = _compat.pypi_release(package, cache_dir=cache_dir)
    if not release:
        return None
    interpreter, version = _compat.interpreter_tag(
        fp.get("python_version", ""))
    for item in release.get("files", []):
        if item.get("yanked"):
            continue
        parsed = _compat.parse_wheel_filename(
            item.get("filename", ""))
        if _compat.wheel_matches(parsed, interpreter, version,
                                 fp):
            return release.get("version")
    return None


def _redetect_compilers(profile):
    profile["compiler_c"] = shutil.which("cc") is not None or \
        shutil.which("gcc") is not None or \
        shutil.which("clang") is not None
    profile["compiler_rust"] = \
        shutil.which("rustc") is not None and \
        shutil.which("cargo") is not None


def _provision_toolchains(ctx, langs, ledger, env_hash, profile,
                          offline):
    """Install missing C/Rust toolchains (CAUTION, validated)."""
    langs = {lang for lang in langs if lang in ("c", "rust")}
    if not langs:
        return False
    if offline:
        ctx.warn("offline: cannot provision %s toolchains"
                 % "+".join(sorted(langs)))
        return False
    manager, _ = package_manager()
    if manager is None or not can_elevate():
        ctx.warn("no usable package manager for toolchains")
        return False
    names = TOOLCHAIN_PKGS.get(manager, {})
    did = False
    for lang in sorted(langs):
        if lang == "c" and profile.get("compiler_c"):
            continue
        if lang == "rust" and profile.get("compiler_rust"):
            continue
        pkgs = names.get(lang, [])
        if not pkgs:
            ctx.warn("no %s toolchain mapping for %s"
                     % (lang, manager))
            continue
        strategy = "toolchain:%s" % lang
        sig = _recovery.failure_signature(
            "DEPENDENCIES", "TOOLCHAIN", lang, strategy,
            env_hash)
        if ledger.attempted("DEPENDENCIES", sig, strategy):
            ctx.say("toolchain %s already failed once; skip"
                    % lang)
            continue
        try:
            for pkg in pkgs:
                pkg_install_resilient(ctx, pkg)
            ledger.record("DEPENDENCIES", sig, strategy,
                          "%s %s" % (manager, " ".join(pkgs)),
                          env_hash, "ok")
            did = True
        except RuntimeError as exc:
            ledger.record("DEPENDENCIES", sig, strategy,
                          "%s %s" % (manager, " ".join(pkgs)),
                          env_hash, "failed", str(exc))
            ctx.warn("toolchain %s failed: %s" % (lang, exc))
    _redetect_compilers(profile)
    return did


def _write_minimal_requirements(ctx, req_path):
    """requirements without native-heavy extras (SAFE fallback).

    uvicorn[standard] extras are performance-only (uvloop,
    httptools, watchfiles); the app is fully functional without
    them. Written to .governance (local-only, never committed).
    """
    try:
        text = Path(req_path).read_text(encoding="utf-8")
    except OSError as exc:
        ctx.warn("cannot read requirements: %s" % exc)
        return None
    minimal = _compat.strip_known_extras(text)
    if minimal == text:
        return None
    generated = GOV / "generated"
    generated.mkdir(parents=True, exist_ok=True)
    target = generated / "requirements-minimal.txt"
    target.write_text(minimal, encoding="utf-8")
    return target


def _is_extras_failure(package):
    extra_deps = set()
    for extras in _compat.KNOWN_EXTRAS.values():
        for deps in extras.values():
            extra_deps.update(deps)
    extra_deps.discard("websockets")  # pure-python
    return (package or "").lower().replace("_", "-") in extra_deps


def _recovery_alternatives(category, package, profile, fp):
    termux = bool(fp.get("termux"))
    rust_hint = "pkg install rust, then re-run (source build " \
        "~15 min, needs free RAM)" if termux else \
        "install rustc+cargo via the system manager, then re-run"
    c_hint = "pkg install clang, then re-run" if termux else \
        "install gcc/clang + python headers, then re-run"
    hints = {
        "RUST_MISSING": [rust_hint,
                         "use a Python with prebuilt %s wheels "
                         "(see the PyPI files page)" % package],
        "COMPILER_MISSING": [c_hint],
        "BUILD_TOOL_MISSING": [c_hint, rust_hint],
        "WHEEL_UNAVAILABLE": [
            "use a Python version with %s wheels" % package,
            c_hint + " (source build instead)"],
        "PYTHON_INCOMPATIBILITY": [
            "use a supported Python (see requires-python)",
            "provision a project-local python3.12/3.13"],
        "NETWORK_FAILURE": ["check firewall/proxy, then re-run "
                            "(resume continues)"],
        "DNS_FAILURE": ["check DNS, then re-run"],
        "PERMISSION_FAILURE": ["fix .venv ownership or delete "
                               ".venv and re-run"],
        "DISK_SPACE": ["free disk space (pip cache purge, "
                       "gitcare cleanup), then re-run"],
        "PACKAGE_NOT_FOUND": ["check the spelling in "
                              "backend/requirements.txt"],
        "VERSION_INCOMPATIBILITY": ["relax the pin in "
                                    "backend/requirements.txt"],
        "RUST_BUILD_FAILURE": [
            "the crate source failed to compile under rustc here; "
            "try an older %s with wheels (see the PyPI files page)"
            % package,
            "free RAM and re-run (Termux source builds need "
            "~1 GB free)"],
        "C_BUILD_FAILURE": [
            "the C extension failed to compile; try an older %s "
            "with wheels" % package,
            c_hint + " (missing headers are the usual cause)"],
        "BUILD_BACKEND_FAILURE": [
            "upgrade pip/setuptools/wheel in the venv, then re-run",
            "try an older %s with wheels" % package],
        "ANDROID_API_LEVEL_MISSING": [
            "a verified prebuilt android wheel is tried first, "
            "else the build retries with a detected "
            "ANDROID_API_LEVEL (automatic)",
            "manual fallback: export ANDROID_API_LEVEL=$(getprop "
            "ro.build.version.sdk), then re-run"],
    }
    return hints.get(category, ["see the log tail, fix the "
                                "cause, re-run"])


def _pip_log_path(ctx, strategy):
    safe = "".join(char if char.isalnum() else "-"
                   for char in strategy)[:60]
    return LOGS / ("pip-%s-%s.log" % (ctx.run_id, safe))


def _collect_pip_tags(ctx, python):
    """Snapshot `pip debug` tags for wheel diagnosis (path/None)."""
    try:
        code, output = run(
            [str(python), "-m", "pip", "debug", "--verbose"], ctx,
            timeout=120)
    except Exception as exc:
        ctx.warn("pip tags unavailable: %s" % exc)
        return None
    if code != 0 or "Compatible tags" not in output:
        return None
    path = LOGS / ("pip-tags-%s.txt" % ctx.run_id)
    path.write_text(redact(output), encoding="utf-8")
    return path


def _record_attempt(ledger, fp_row, category, result, log_path,
                    detail):
    row = dict(fp_row)
    row.update({"category": category or "UNKNOWN",
                "result": result,
                "log": str(log_path or ""),
                "detail": (detail or "")[-500:]})
    ledger.record_row(row)
    return row


def _toolchain_now(env_hash):
    row = _strategy.toolchain_fingerprint()
    row["env_hash"] = env_hash
    return row


def _generated_dir():
    target = GOV / "generated"
    target.mkdir(parents=True, exist_ok=True)
    return target


def _resolve_version_pick(package, category, fp, cache_dir):
    """A release that changes the outcome (None when none would)."""
    try:
        options = _compat.compatible_versions(
            package, fp, cache_dir=cache_dir, limit=6)
    except Exception:
        return None
    for item in options:
        status = item.get("status")
        if category == "PYTHON_INCOMPATIBILITY":
            if status not in ("PYTHON_INCOMPATIBILITY", "UNKNOWN"):
                return item
        elif category in ("PACKAGE_NOT_FOUND",
                          "VERSION_INCOMPATIBILITY"):
            if status in ("WHEEL_OK", "NEEDS_BUILD"):
                return item
        elif status == "WHEEL_OK":
            return item
    return None


def _pydantic_core_constraint(req_path, cache_dir):
    """pydantic-core spec implied by the resolved pydantic (or '').

    Reads the pydantic spec from requirements, resolves the newest
    satisfying release on PyPI, and returns its pydantic-core
    constraint (usually an exact pin).
    """
    try:
        reqs = _compat.parse_requirements(req_path)
    except OSError:
        return ""
    spec = ""
    for req in reqs:
        if "name" in req and _compat.normalize(
                req["name"]) == "pydantic":
            spec = req.get("spec", "")
            break
    else:
        return ""
    try:
        versions = _compat.pypi_versions("pydantic",
                                         cache_dir=cache_dir)
    except Exception:
        return ""
    pick = None
    for version in versions:
        if _compat.spec_satisfied(spec, version):
            pick = version
            break
    if pick is None:
        return ""
    try:
        meta = _compat.pypi_release("pydantic", pick,
                                    cache_dir=cache_dir)
    except Exception:
        return ""
    if not meta:
        return ""
    for dep in meta.get("requires_dist", []) or []:
        name, wanted = _compat.dep_spec(dep)
        if name == "pydantic-core":
            return wanted
    return ""


def _apt_pkg_available(ctx, pkg):
    """True/False/None(unknown) for an apt-cache install candidate."""
    if shutil.which("apt-cache") is None:
        return None
    try:
        code, output = run(["apt-cache", "policy", pkg], ctx,
                           timeout=60)
    except Exception:
        return None
    if code != 0:
        return None
    for line in output.splitlines():
        if "Candidate:" in line:
            return "(none)" not in line
    return None


def _python_for_wheels(package, reqs, fp, cache_dir):
    """Newest older minor whose wheels beat this runtime (or None)."""
    current = tuple(sys.version_info[:2])
    trial = dict(fp)
    for minor in range(current[1] - 1, 9, -1):
        trial["python_version"] = "%d.%d.0" % (current[0], minor)
        cache = cache_dir

        def fetch(name, version=None, _cache=cache):
            return _compat.pypi_release(name, version,
                                        cache_dir=_cache)

        better = False
        for req in reqs:
            if "name" not in req:
                continue
            if package and req["name"] != package:
                continue
            try:
                verdict = _compat.assess_package(req, trial, fetch)
            except Exception:
                continue
            if verdict.get("status") == "WHEEL_OK":
                better = True
        if better:
            return (current[0], minor)
    return None


def pip_install_with_recovery(ctx, python, req_path, fp, profile,
                              ledger, env_hash, offline):
    """Strategy loop: run changed strategies until one validates.

    Returns {"attempts": [...], "python": str, "version": str,
    "venv": str}. Raises RecoveryExhausted only when no untried
    changed strategy remains.
    """
    LOGS.mkdir(parents=True, exist_ok=True)
    cache_dir = ROOT / ".cache" / "apkforge"
    req_path = Path(req_path)
    base_text = req_path.read_text(encoding="utf-8")
    try:
        parsed_reqs = _compat.parse_requirements(req_path)
    except OSError:
        parsed_reqs = []
    direct = {item["name"] for item in parsed_reqs
              if "name" in item}
    native_reqs = [item for item in parsed_reqs if "name" in item]
    restored = _strategy.restore_failure_context(ledger.path)
    memory = restored["memory"] or {}
    if restored["evidence_source"] == "log":
        ctx.say("legacy failure log loaded: %s" % restored["log"])
    if restored["reclassified"]:
        ctx.say("previous category reclassified: %s"
                % restored["reclassify_note"])
        _strategy.record_reclassification(
            ledger.path, memory.get("attempt_id") or "legacy",
            memory.get("category") or "UNKNOWN",
            restored["category"], restored["diagnosed_package"])
    if restored["diagnosed_package"]:
        ctx.say("diagnosed package: %s"
                % restored["diagnosed_package"])
    mem_status = _strategy.memory_status(
        memory, _toolchain_now(env_hash).get("hash"))
    if mem_status["status"] == "ACTIVE":
        last = {"category": restored["category"],
                "package": restored["diagnosed_package"],
                "version": restored["version"], "evidence": []}
        ctx.say("failure memory ACTIVE: %s (%s) — selecting a "
                "changed strategy, never a bare repeat" % (
                    restored["diagnosed_package"] or "?",
                    restored["category"]))
    else:
        last = {"category": "-",
                "package": restored["diagnosed_package"],
                "version": restored["version"], "evidence": []}
        if memory:
            hint = ("; package hint kept: %s"
                    % restored["diagnosed_package"]
                    if restored["diagnosed_package"] else "")
            ctx.say("failure memory %s (%s) — re-probing from "
                    "scratch%s" % (mem_status["status"],
                                   mem_status["reason"], hint))
    python = str(python)
    py_version = fp.get("python_version", "")
    venv = str(Path(python).parent.parent)
    attempts = []
    skipped = []
    executed = set()
    blocked = []
    trail = []
    constraints = None
    current_path = req_path
    current_text = base_text
    last_output = ""
    termux = bool(fp.get("termux"))
    cache_cov = {}

    def assess_now(req, trial_fp):
        cache = cache_dir

        def fetch(name, version=None, _cache=cache):
            return _compat.pypi_release(name, version,
                                        cache_dir=_cache)

        return _compat.assess_package(req, trial_fp, fetch)

    def current_coverage():
        if "now" not in cache_cov:
            cache_cov["now"] = _runtime.wheel_coverage(
                tuple(sys.version_info[:2]), native_reqs, fp,
                assess_now)
        return cache_cov["now"]

    probe_cache = {}

    def probe_now(refresh=False):
        if refresh or "probe" not in probe_cache:
            probe_cache["probe"] = _strategy.probe_toolchain(
                python)
        return probe_cache["probe"]

    def fp_for(strategy, command, req_text, py_ver, target=None,
               target_ver=None, build_env=None):
        return _strategy.attempt_fingerprint(
            "DEPENDENCIES", strategy, target, target_ver, py_ver,
            fp.get("arch_machine", ""),
            profile.get("platform", ""), command, req_text,
            _toolchain_now(env_hash), run_id=ctx.run_id,
            build_env=build_env)

    def pip_argv(extra_pkgs=()):
        argv = ["install"]
        if offline:
            argv += ["--no-index", "--find-links",
                    str(cache_dir / "wheels")]
        if constraints is not None:
            argv += ["-c", str(constraints)]
        argv += ["-r", str(current_path)] + list(extra_pkgs)
        return argv

    def do_pip(strategy, argv, target=None, target_ver=None,
               timeout=1200):
        command = "pip " + " ".join(argv)
        row = fp_for(strategy, command, current_text
                     + ("\n###constraints###\n" + constraints.read_text(
                         encoding="utf-8") if constraints else ""),
                     py_version, target, target_ver)
        if row["attempt_id"] in executed:
            skipped.append(strategy)
            for line in _strategy.explain(row, "refuse"):
                ctx.say(line)
            return "done"
        ident = _strategy.identical_attempt(ledger.path, row)
        if ident is not None and not (
                strategy == "native" and _strategy.flaky_retry_allowed(
                    ledger.path, row, last["category"])):
            skipped.append(strategy)
            for line in _strategy.explain(row, "refuse"):
                ctx.say(line)
            return "skipped"
        if strategy == "native" and ident is not None:
            num = _strategy.count_identical(ledger.path, row)
            ctx.say("flaky network: identical retry %d/3 with "
                    "backoff" % (num + 1))
            time.sleep(5 * (num + 1))
        for line in _strategy.explain(
                row, "run",
                memory.get("strategy") or "recorded failure"):
            ctx.say(line)
        ctx.say("pip attempt [%s]" % strategy)
        code, output, log_path = run_pip(strategy, argv, timeout)
        executed.add(row["attempt_id"])
        nonlocal_last_output = output
        if code == 0:
            _record_attempt(ledger, row, "OK", "ok", log_path, "")
            attempts.append({"strategy": strategy,
                             "result": "ok"})
            trail.append((strategy, "done", "OK"))
            ctx.recovered(strategy, "pip install succeeded")
            return "ok"
        classified = _recovery.classify_failure(output)
        probe = probe_now(refresh=True)
        refined, note = _strategy.refine_category(
            classified["category"], probe,
            _strategy.extract_signals(output))
        if note:
            ctx.say("probe: %s" % note)
            classified = dict(classified, category=refined,
                              root_cause="%s (%s)" % (
                                  classified["root_cause"], note))
        if ctx.state != "RECOVERING":
            ctx.step("RECOVERING")
        last.update(category=classified["category"],
                    package=classified["package"],
                    evidence=classified["evidence"])
        row["probe"] = probe.get("tools", {})
        row["diagnosed_package"] = classified["package"]
        _record_attempt(ledger, row, classified["category"],
                        "failed", log_path, output)
        attempts.append({"strategy": strategy, "result": "failed"})
        trail.append((strategy, "failed", classified["category"]))
        ctx.warn("attempt %s failed: %s (%s)" % (
            strategy, classified["root_cause"],
            classified["category"]))
        for signal in _strategy.extract_signals(output):
            ctx.say("signal: %s %s" % (signal["kind"],
                                      signal["target"]))
        ctx.say(_recovery.full_diagnostic({
            "step": "DEPENDENCIES",
            "package": classified["package"] or "-",
            "python": py_version, "platform": profile.get(
                "platform", "?"), "arch": fp.get(
                    "arch_machine", "?"),
            "method": command, "category": classified["category"],
            "root_cause": classified["root_cause"],
            "command": command, "log": str(log_path),
            "evidence": classified["evidence"],
            "alternatives": _recovery_alternatives(
                classified["category"], classified["package"],
                profile, fp),
            "attempts": [item["strategy"] for item in attempts],
            "next_strategy": "next changed strategy"}))
        return ("failed", nonlocal_last_output)

    def run_pip(strategy, argv, timeout, env=None):
        log_path = _pip_log_path(ctx, strategy)
        if env:
            extra = {key: value for key, value in env.items()
                     if os.environ.get(key) != value}
            if extra:
                ctx.say("build env: %s" % ", ".join(
                    "%s=%s" % item
                    for item in sorted(extra.items())))
        code, output = run([python, "-m", "pip"] + argv, ctx,
                           timeout=timeout, env=env)
        log_path.write_text(redact(output), encoding="utf-8")
        return code, output, log_path

    def do_provision(pkgs, label):
        nonlocal_provisioned = False
        for pkg in pkgs:
            row = fp_for("provision:" + pkg,
                         "%s install %s" % ("pkg" if termux else
                                            "manager", pkg),
                         "", py_version)
            if row["attempt_id"] in executed or \
                    _strategy.identical_attempt(ledger.path, row):
                skipped.append("provision:" + pkg)
                ctx.say("skip provision %s (already attempted "
                        "identically)" % pkg)
                continue
            executed.add(row["attempt_id"])
            try:
                if termux:
                    pkg_install_resilient(ctx, pkg)
                else:
                    install_via_manager(ctx, pkg)
            except RuntimeError as exc:
                _record_attempt(ledger, row, "PROVISION_FAILED",
                                "failed", "", str(exc))
                attempts.append({"strategy": "provision:" + pkg,
                                 "result": "failed"})
                trail.append(("provision:" + pkg, "failed",
                              "PROVISION_FAILED"))
                ctx.warn("provision %s failed: %s" % (pkg, exc))
                continue
            _record_attempt(ledger, row, "OK", "ok", "", "")
            attempts.append({"strategy": "provision:" + pkg,
                             "result": "ok"})
            trail.append(("provision:" + pkg, "done", "OK"))
            nonlocal_provisioned = True
        if nonlocal_provisioned:
            ctx.recovered("provision:" + label, ", ".join(pkgs))
        return nonlocal_provisioned

    def isolated_candidate(label, package, version, env=None,
                           extra_imports=(), pre_install=(),
                           pip_check=False, provenance=None):
        """Fresh venv, same interpreter, changed build inputs.

        Fallback when the shared venv holds a broken mix or the
        build needs extra environment (e.g. ANDROID_API_LEVEL).
        Lives under .governance/venv-candidates/<attempt-id>; the
        shared venv is never touched. pre_install paths (verified
        wheel files) install first; pip_check adds a final `pip
        check`. Returns ("ok", python, venv_dir) when pip AND
        every import check pass, else ("failed", classified,
        output) or ("unavailable", reason, "").
        """
        benv = None
        if env and env.get("ANDROID_API_LEVEL"):
            benv = {"ANDROID_API_LEVEL": str(
                env["ANDROID_API_LEVEL"])}
        command = "pip " + " ".join(pip_argv())
        row = fp_for(label + " (isolated)", command,
                     current_text
                     + ("\n###constraints###\n" + constraints.read_text(
                         encoding="utf-8") if constraints else ""),
                     py_version, package, version, benv)
        if row["attempt_id"] in executed or \
                _strategy.identical_attempt(ledger.path, row):
            skipped.append(label + " (isolated)")
            return ("unavailable", "already failed identically",
                    "")
        cand_dir = GOV / "venv-candidates" / row["attempt_id"][:12]
        cand_dir.parent.mkdir(parents=True, exist_ok=True)
        ctx.say("isolated candidate: %s in %s" % (label, cand_dir))
        code, output = run([python, "-m", "venv", str(cand_dir)],
                           ctx, timeout=300)
        if code != 0:
            row["diagnosed_package"] = package
            _record_attempt(ledger, row, "PROJECT_ERROR", "failed",
                            "", output)
            attempts.append({"strategy": label + " (isolated)",
                             "result": "failed"})
            trail.append((label + " (isolated)", "failed",
                          "PROJECT_ERROR"))
            return ("failed", {"category": "PROJECT_ERROR",
                               "package": package,
                               "root_cause": "candidate venv "
                               "failed",
                               "evidence": [output[-200:]]}, output)
        cand_python = cand_dir / ("Scripts" if os.name == "nt"
                                  else "bin") / (
                                      "python.exe" if os.name == "nt"
                                      else "python")
        for wheel_path in pre_install:
            wargv = ["install"]
            if offline:
                wargv += ["--no-index", "--find-links",
                          str(cache_dir / "wheels")]
            wargv.append(str(wheel_path))
            ctx.say("pre-installing verified wheel: %s"
                    % Path(wheel_path).name)
            code, output = run([str(cand_python), "-m", "pip"] +
                               wargv, ctx, timeout=600)
            if code != 0:
                classified = _recovery.classify_failure(output)
                row["diagnosed_package"] = classified["package"]
                if provenance:
                    row["wheel_provenance"] = provenance
                _record_attempt(ledger, row,
                                classified["category"], "failed",
                                "", output)
                attempts.append(
                    {"strategy": label + " (isolated)",
                     "result": "failed"})
                trail.append((label + " (isolated)", "failed",
                              classified["category"]))
                return ("failed", classified, output)
        log_path = _pip_log_path(ctx, label + "-isolated")
        if provenance:
            row["wheel_provenance"] = provenance
        if benv:
            ctx.say("build env: %s" % ", ".join(
                "%s=%s" % item for item in sorted(benv.items())))
        code, output = run([str(cand_python), "-m", "pip"] +
                           pip_argv(), ctx, timeout=1200, env=env)
        log_path.write_text(redact(output), encoding="utf-8")
        executed.add(row["attempt_id"])
        if code != 0:
            classified = _recovery.classify_failure(output)
            probe = probe_now(refresh=True)
            refined, note = _strategy.refine_category(
                classified["category"], probe,
                _strategy.extract_signals(output))
            if note:
                classified = dict(classified, category=refined)
            row["probe"] = probe.get("tools", {})
            row["diagnosed_package"] = classified["package"]
            _record_attempt(ledger, row, classified["category"],
                            "failed", log_path, output)
            attempts.append({"strategy": label + " (isolated)",
                             "result": "failed"})
            trail.append((label + " (isolated)", "failed",
                          classified["category"]))
            return ("failed", classified, output)
        broken = [mod for mod in extra_imports
                  if not _import_ok(ctx, cand_python, mod)]
        if not broken and not _backend_imports_ok(ctx, cand_python):
            broken = ["fastapi/uvicorn/pydantic"]
        if broken:
            row["diagnosed_package"] = package
            _record_attempt(ledger, row, last["category"], "failed",
                            log_path, "import check failed: %s"
                            % ", ".join(broken))
            attempts.append({"strategy": label + " (isolated)",
                             "result": "failed"})
            trail.append((label + " (isolated)", "failed",
                          last["category"]))
            return ("failed", {"category": last["category"],
                               "package": package,
                               "root_cause": "pip ok but %s "
                               "fail to import in the isolated "
                               "candidate" % ", ".join(broken),
                               "evidence": []}, output)
        if pip_check:
            code, output = run(
                [str(cand_python), "-m", "pip", "check"], ctx,
                timeout=120)
            if code != 0:
                row["diagnosed_package"] = package
                _record_attempt(ledger, row, last["category"],
                                "failed", log_path, output)
                attempts.append(
                    {"strategy": label + " (isolated)",
                     "result": "failed"})
                trail.append((label + " (isolated)", "failed",
                              last["category"]))
                return ("failed", {"category": last["category"],
                                   "package": package,
                                   "root_cause": "pip check "
                                   "failed in the isolated "
                                   "candidate: %s"
                                   % (output.strip().splitlines()
                                      or ["?"])[-1],
                                   "evidence": []}, output)
        _record_attempt(ledger, row, "OK", "ok", log_path, "")
        attempts.append({"strategy": label + " (isolated)",
                         "result": "ok"})
        trail.append((label + " (isolated)", "done", "OK"))
        return ("ok", str(cand_python), str(cand_dir))

    tags_path = _collect_pip_tags(ctx, python)
    if tags_path is not None:
        ctx.say("pip tags: %s" % tags_path)
    _redetect_compilers(profile)
    need_langs = set()
    for req in native_reqs:
        need_langs.update(_compat.native_languages(req["name"]))
    need_langs -= {"c-optional", "unknown-toolchain"}
    if need_langs and not offline and \
            package_manager()[0] is not None and can_elevate():
        ctx.say("pre-pip probe: requirements may need %s" % (
            "+".join(sorted(need_langs))))
        _provision_toolchains(ctx, need_langs, ledger, env_hash,
                              profile, offline)
        probe_now(refresh=True)

    guard = 0
    runtime_done = set()
    while guard < 14:
        guard += 1
        caps = {"termux": termux,
                "provision_ok": package_manager()[0] is not None
                and can_elevate(),
                "offline": offline, "direct": direct,
                "alternate_pythons": _runtime.find_pythons(),
                "signals": _strategy.extract_signals(last_output)}
        cands = _strategy.order_candidates(last, caps)
        moved = False
        for cand in cands:
            cid = cand["id"]
            if cid in ("native", "retry"):
                outcome = do_pip("native", pip_argv())
                if outcome == "ok":
                    return {"attempts": attempts, "python": python,
                            "version": py_version, "venv": venv}
                if isinstance(outcome, tuple):
                    last_output = outcome[1]
                    moved = True
                    break
                continue
            if cid == "toolchain":
                langs = cand["params"].get("langs", [])
                if _provision_toolchains(ctx, set(langs), ledger,
                                         env_hash, profile,
                                         offline):
                    moved = True
                    break
                continue
            if cid == "sysdeps":
                if do_provision(cand["params"].get("packages", []),
                                "sysdeps"):
                    moved = True
                    break
                continue
            if cid == "android_prebuilt_wheel":
                package = cand["params"].get("package") \
                    or "pydantic-core"
                ctx.say("candidate: android_prebuilt_wheel")
                detection = _strategy.detect_android_api_level()
                device_api = detection.get("device_api_level")
                if device_api is None:
                    blocked.append(
                        "prebuilt android wheel unavailable: "
                        "device android api unknown (%s)"
                        % detection.get("reason", "?"))
                    continue
                constraint = _pydantic_core_constraint(
                    req_path, cache_dir)
                interpreter, _ = _compat.interpreter_tag(
                    py_version)
                candidate, reason = _compat.resolve_android_wheel(
                    constraint, interpreter,
                    fp.get("arch_machine", ""), device_api,
                    cache_dir)
                if candidate is None:
                    blocked.append(
                        "prebuilt android wheel unavailable: %s"
                        % reason)
                    continue
                ctx.say("android wheel selected: %s (sha256=%s, "
                        "api>=%d, %s)" % (
                            candidate["filename"],
                            candidate["sha256"][:16],
                            candidate["api"],
                            candidate["source"]))
                wheel_path, fetch_note = \
                    _compat.fetch_verified_wheel(
                        candidate["url"], candidate["sha256"],
                        GOV / "wheel-cache"
                        / candidate["filename"])
                if wheel_path is None:
                    blocked.append(
                        "prebuilt android wheel rejected: %s"
                        % fetch_note)
                    continue
                ctx.say("android wheel verified: sha256 ok (%s)"
                        % fetch_note)
                wlabel = "android_prebuilt_wheel"
                provenance = {
                    key: candidate.get(key) for key in
                    ("filename", "version", "sha256", "source",
                     "url", "api", "arch")}
                cand_outcome = isolated_candidate(
                    wlabel, package, candidate["version"],
                    extra_imports=("pydantic_core",),
                    pre_install=(wheel_path,), pip_check=True,
                    provenance=provenance)
                if cand_outcome[0] == "ok":
                    ctx.recovered(wlabel + " (isolated)",
                                  "adopted %s (%s)" % (
                                      cand_outcome[2],
                                      candidate["filename"]))
                    return {"attempts": attempts,
                            "python": cand_outcome[1],
                            "version": py_version,
                            "venv": cand_outcome[2],
                            "exe": sys.executable}
                if cand_outcome[0] == "failed":
                    failed = cand_outcome[1]
                    last.update(category=failed["category"],
                                package=failed["package"],
                                evidence=failed["evidence"])
                    last_output = cand_outcome[2]
                    moved = True
                    break
                blocked.append("android wheel %s==%s already "
                               "failed identically" % (
                                   package, candidate["version"]))
                continue
            if cid == "native_android_api_level":
                package = cand["params"].get("package")
                ctx.say("candidate: native_android_api_level")
                detection = _strategy.detect_android_api_level()
                ctx.say("ANDROID_API_LEVEL detected: %s "
                        "(source=%s device=%s)" % (
                            detection.get("level") or "-",
                            detection.get("source"),
                            detection.get("device_api_level")
                            or "-"))
                last["api_detection"] = {
                    key: detection.get(key) for key in
                    ("ok", "level", "source", "device_api_level",
                     "reason")}
                if not detection["ok"]:
                    blocked.append("android api level unknown: %s"
                                   % detection["reason"])
                    continue
                level = detection["level"]
                build_env = os.environ.copy()
                build_env["ANDROID_API_LEVEL"] = str(level)
                alabel = "native_android_api_level"
                ctx.say("ANDROID_API_LEVEL passed to isolated "
                        "pip process: %s" % level)
                cand_outcome = isolated_candidate(
                    alabel, package, None, env=build_env,
                    extra_imports=("pydantic_core",))
                if cand_outcome[0] == "ok":
                    ctx.recovered(alabel + " (isolated)",
                                  "adopted %s (ANDROID_API_LEVEL"
                                  "=%s)" % (cand_outcome[2], level))
                    return {"attempts": attempts,
                            "python": cand_outcome[1],
                            "version": py_version,
                            "venv": cand_outcome[2],
                            "exe": sys.executable}
                if cand_outcome[0] == "failed":
                    failed = cand_outcome[1]
                    last.update(category=failed["category"],
                                package=failed["package"],
                                evidence=failed["evidence"])
                    last_output = cand_outcome[2]
                    moved = True
                    break
                blocked.append("android api level %s already "
                               "failed identically" % level)
                continue
            if cid == "version":
                package = cand["params"]["package"]
                pick = _resolve_version_pick(
                    package, last["category"], fp, cache_dir)
                if pick is None:
                    blocked.append("no %s release changes the "
                                   "outcome" % package)
                    continue
                constraints = _generated_dir() / "constraints.txt"
                constraints.write_text(
                    "%s==%s\n" % (package, pick["version"]),
                    encoding="utf-8")
                current_text = base_text
                ctx.say("version strategy: %s==%s (%s)" % (
                    package, pick["version"], pick["status"]))
                vlabel = "version:%s==%s" % (package,
                                                 pick["version"])
                outcome = do_pip(vlabel, pip_argv(), package,
                                 pick["version"])
                if outcome == "ok":
                    if _backend_imports_ok(ctx, python):
                        _generated_dir().joinpath(
                            "resolved-requirements.txt").write_text(
                                base_text
                                + "\n# resolved pin: %s==%s\n"
                                % (package, pick["version"]),
                                encoding="utf-8")
                        return {"attempts": attempts,
                                "python": python,
                                "version": py_version, "venv": venv}
                    ctx.warn("version combo rejected by the import "
                             "check; trying an isolated candidate")
                    cand_outcome = isolated_candidate(
                        vlabel, package, pick["version"])
                    if cand_outcome[0] == "ok":
                        ctx.recovered(vlabel + " (isolated)",
                                      "adopted %s"
                                      % cand_outcome[2])
                        return {"attempts": attempts,
                                "python": cand_outcome[1],
                                "version": py_version,
                                "venv": cand_outcome[2],
                                "exe": sys.executable}
                    if cand_outcome[0] == "failed":
                        failed = cand_outcome[1]
                        last.update(category=failed["category"],
                                    package=failed["package"],
                                    evidence=failed["evidence"])
                        last_output = cand_outcome[2]
                        moved = True
                        break
                    continue
                if isinstance(outcome, tuple):
                    last_output = outcome[1]
                    moved = True
                    break
                continue
            if cid == "runtime":
                pick = _runtime.select_runtime(
                    caps["alternate_pythons"], current_coverage(),
                    native_reqs, fp, assess_now)
                if pick is None:
                    target = _python_for_wheels(
                        last["package"], native_reqs, fp,
                        cache_dir)
                    if target is not None and caps[
                            "provision_ok"] and not offline:
                        names = _runtime.provision_names(
                            target, termux)
                        manager, _ = package_manager()
                        if names and manager in ("pkg",
                                                 "apt-get"):
                            known = [_apt_pkg_available(ctx, name)
                                     for name in names]
                            dropped = [
                                name for name, ok in zip(
                                    names, known) if ok is False]
                            names = [
                                name for name, ok in zip(
                                    names, known)
                                if ok is not False]
                            if dropped:
                                ctx.say(
                                    "runtime packages absent "
                                    "from subscribed repos: %s"
                                    % ", ".join(dropped))
                                if not names:
                                    blocked.append(
                                        "python%d%d has no "
                                        "installable package in "
                                        "subscribed repos (no "
                                        "third-party repo added "
                                        "automatically)"
                                        % target)
                        if names and do_provision(
                                names, "python%d%d" % target):
                            moved = True
                            break
                    blocked.append(_strategy.blocked_ideas(
                        last, caps)[0] if _strategy.blocked_ideas(
                            last, caps) else
                        "no alternate python available")
                    continue
                rlabel = "runtime:python%d%d" % pick["version"]
                if rlabel in runtime_done:
                    continue
                runtime_done.add(rlabel)
                try:
                    _switch_to_runtime(ctx, pick, fp, profile,
                                       ledger, env_hash,
                                       offline, cache_dir,
                                       current_path, constraints)
                except _RuntimeSwitch as switch:
                    attempts.append({"strategy": rlabel,
                                     "result": "ok"})
                    trail.append((rlabel, "done", "OK"))
                    return {"attempts": attempts,
                            "python": switch.python,
                            "version": switch.version,
                            "venv": switch.venv,
                            "exe": switch.exe}
                moved = True
                break
            if cid == "minimal":
                minimal = _write_minimal_requirements(
                    ctx, req_path)
                if minimal is None:
                    continue
                current_path = minimal
                current_text = minimal.read_text(encoding="utf-8")
                outcome = do_pip("minimal-core", pip_argv())
                if outcome == "ok":
                    (GOV / "degraded.json").write_text(json.dumps(
                        {"enabled": True,
                         "reason": "optional native extras "
                         "unavailable",
                         "dropped": [last["package"] or "extras"],
                         "run_id": ctx.run_id}, indent=2),
                        encoding="utf-8")
                    ctx.warn("SAFE FALLBACK active: running without "
                             "optional native extras (see "
                             ".governance/degraded.json)")
                    return {"attempts": attempts, "python": python,
                            "version": py_version, "venv": venv}
                if isinstance(outcome, tuple):
                    last_output = outcome[1]
                    moved = True
                    break
                continue
            if cid == "recreate+pip":
                probe = fp_for("venv-recreated",
                               "pip " + " ".join(pip_argv()),
                               current_text, py_version)
                if probe["attempt_id"] in executed or \
                        _strategy.identical_attempt(ledger.path,
                                                    probe):
                    skipped.append("venv-recreated")
                    continue
                aside = VENV.parent / (".venv-broken-%s"
                                       % ctx.run_id)
                try:
                    VENV.rename(aside)
                except OSError as exc:
                    blocked.append("cannot move broken venv "
                                   "aside: %s" % exc)
                    continue
                ctx.warn("venv moved aside to %s (kept, never "
                         "deleted)" % aside)
                code, output = run([sys.executable, "-m", "venv",
                                    str(VENV)], ctx, timeout=300)
                if code != 0:
                    blocked.append("venv recreate failed")
                    continue
                outcome = do_pip("venv-recreated", pip_argv())
                if outcome == "ok":
                    return {"attempts": attempts, "python": python,
                            "version": py_version, "venv": venv}
                if isinstance(outcome, tuple):
                    last_output = outcome[1]
                    moved = True
                    break
                continue
            if cid == "purge+pip":
                probe = fp_for("after-purge",
                               "pip " + " ".join(pip_argv()),
                               current_text, py_version)
                if probe["attempt_id"] in executed or \
                        _strategy.identical_attempt(ledger.path,
                                                    probe):
                    skipped.append("after-purge")
                    continue
                run([python, "-m", "pip", "cache", "purge"], ctx,
                    timeout=120)
                outcome = do_pip("after-purge", pip_argv())
                if outcome == "ok":
                    return {"attempts": attempts, "python": python,
                            "version": py_version, "venv": venv}
                if isinstance(outcome, tuple):
                    last_output = outcome[1]
                    moved = True
                    break
                continue
        if not moved:
            break

    ideas = list(dict.fromkeys(
        blocked + _strategy.blocked_ideas(last, caps)))
    skipped = list(dict.fromkeys(skipped))
    nodes = [{"node": item[0], "status": item[1],
              "reason": item[2] or "-"} for item in trail]
    for name in skipped:
        nodes.append({"node": name, "status": "skipped",
                      "reason": "identical fingerprint"})
    for idea in ideas:
        nodes.append({"node": "unlock", "status": "blocked",
                      "reason": idea})
    if not attempts:
        prior = [entry for entry in ledger.entries()
                 if entry.get("step") == "DEPENDENCIES"
                 and entry.get("kind") != "reclassify"]
        raise RecoveryExhausted({
            "step": "DEPENDENCIES",
            "package": last["package"] or "-",
            "category": last["category"],
            "root_cause": "every strategy already failed "
            "identically for this environment; fix the cause "
            "below, then re-run",
            "tried": [{"strategy": entry.get("strategy"),
                       "result": entry.get("result")}
                      for entry in prior[-8:]],
            "skipped_identical": skipped,
            "nodes": nodes,
            "needs_you": ideas,
            "required": "a changed environment (new toolchain, "
            "new pins, new runtime) or a manual fix",
            "next_action": "; ".join(ideas[:2]) or
            "inspect %s, fix the recorded cause, then re-run"
            % ledger.path,
            "ledger": str(ledger.path)})
    info = {"step": "DEPENDENCIES",
            "package": last["package"] or "-",
            "category": last["category"],
            "root_cause": "last attempt failed: %s" % last[
                "category"],
            "tried": attempts,
            "skipped_identical": skipped,
            "nodes": nodes,
            "needs_you": ideas,
            "required": "manual fix for %s" % last["category"],
            "next_action": "; ".join(ideas[:2]) or "; ".join(
                _recovery_alternatives(
                    last["category"], last["package"], profile,
                    fp)[:2]),
            "ledger": str(ledger.path)}
    raise RecoveryExhausted(info)


def _switch_to_runtime(ctx, pick, fp, profile, ledger, env_hash,
                       offline, cache_dir, req_path, constraints):
    """Try the alternate runtime in its own venv (old kept).

    Returns True when the switch validated (caller returns the new
    interpreter via the result dict); False moves the loop on. The
    previous venv is never touched, so rollback is automatic.
    """
    version = pick["version"]
    target = _runtime.venv_for(ROOT, version)
    label = "runtime:python%d%d" % version
    ctx.say("runtime strategy: %s (wheels %.0f%%) in %s" % (
        pick["exe"], pick["coverage"] * 100, target))
    if not (target / "bin" / "python").is_file() and not (
            target / "Scripts" / "python.exe").is_file():
        code, output = run([pick["exe"], "-m", "venv",
                            str(target)], ctx, timeout=300)
        if code != 0:
            ctx.warn("runtime venv create failed: %s"
                     % output[-200:])
            return False
    new_python = target / ("Scripts" if os.name == "nt"
                           else "bin") / (
                               "python.exe" if os.name == "nt"
                               else "python")
    argv = ["install"]
    if offline:
        argv += ["--no-index", "--find-links",
                str(cache_dir / "wheels")]
    if constraints is not None:
        argv += ["-c", str(constraints)]
    argv += ["-r", str(req_path)]
    row = _strategy.attempt_fingerprint(
        "DEPENDENCIES", label, None, None,
        "%d.%d.0" % version, fp.get("arch_machine", ""),
        profile.get("platform", ""), "pip " + " ".join(argv),
        Path(req_path).read_text(encoding="utf-8"),
        _toolchain_now(env_hash), run_id=ctx.run_id)
    if _strategy.identical_attempt(ledger.path, row):
        ctx.say("skip %s (already failed identically)" % label)
        return False
    log_path = _pip_log_path(ctx, label)
    code, output = run([str(new_python), "-m", "pip"] + argv, ctx,
                       timeout=1200)
    log_path.write_text(redact(output), encoding="utf-8")
    if code != 0:
        classified = _recovery.classify_failure(output)
        _record_attempt(ledger, row, classified["category"],
                        "failed", log_path, output)
        ctx.warn("runtime %s failed: %s" % (
            label, classified["root_cause"]))
        return False
    check = run([str(new_python), "-c",
                 "import fastapi, uvicorn, pydantic"], ctx,
                timeout=60)[0]
    if check != 0:
        _record_attempt(ledger, row, "PROJECT_ERROR", "failed",
                        log_path, "imports fail on new runtime")
        ctx.warn("runtime %s installed but imports fail" % label)
        return False
    _record_attempt(ledger, row, "OK", "ok", log_path, "")
    ctx.recovered(label, "validated in %s" % target)
    raise _RuntimeSwitch(str(new_python), "%d.%d.0" % version,
                         str(target), pick["exe"])


class _RuntimeSwitch(Exception):
    """Internal: the runtime candidate validated; unwind to caller."""

    def __init__(self, python, version, venv, exe=""):
        super().__init__("runtime switch")
        self.python = python
        self.version = version
        self.venv = venv
        self.exe = exe




def ensure_venv(ctx, offline, fp, profile, ledger, env_hash):
    """Validate/create/repair the venv, then install with recovery.

    Honors the recorded current runtime; a validated runtime switch
    from the ladder is adopted atomically (the old venv is kept, so
    rollback is just not switching). Nothing here ever deletes a venv.
    """
    record = _runtime_record().get("current") or {}
    wanted = Path(record["venv"]) if record.get("venv") else VENV
    if wanted == VENV:
        python = _venv_python()
    else:
        python = wanted / ("Scripts" if os.name == "nt" else "bin") / \
            ("python.exe" if os.name == "nt" else "python")
    if python.is_file():
        ok, reason = validate_venv(ctx, python)
        if ok and _backend_imports_ok(ctx, python):
            ctx.say("backend deps present → skip install")
            return python
        if not ok:
            aside = wanted.parent / ("%s-broken-%s" % (
                wanted.name, ctx.run_id))
            try:
                wanted.rename(aside)
            except OSError as exc:
                raise RuntimeError(
                    "venv invalid (%s) and cannot be moved aside: "
                    "%s" % (reason, exc))
            ctx.warn("venv invalid (%s) → moved aside to %s (kept, "
                     "never deleted); creating fresh" % (reason, aside))
            ledger.record("RUNTIME", "broken-venv", "move-aside",
                          "mv %s %s" % (wanted, aside),
                          env_hash, "ok", reason)
            python = wanted / ("Scripts" if os.name == "nt"
                               else "bin") / (
                                   "python.exe" if os.name == "nt"
                                   else "python")
        else:
            ctx.say("venv valid but deps missing → install")
    if not python.is_file():
        ctx.say("creating virtualenv %s" % wanted)
        maker = record.get("exe") or sys.executable
        code, output = run([maker, "-m", "venv", str(wanted)], ctx,
                           timeout=300)
        if code != 0:
            raise RuntimeError("venv failed: %s" % output[-300:])
        python = wanted / ("Scripts" if os.name == "nt"
                           else "bin") / (
                               "python.exe" if os.name == "nt"
                               else "python")
    req = ROOT / "backend" / "requirements.txt"
    lock = GOV / "requirements.lock"
    if offline and lock.is_file():
        ctx.say("offline: installing from locked resolution")
        req = lock
    result = pip_install_with_recovery(ctx, python, req, fp, profile,
                                       ledger, env_hash, offline)
    final = Path(result["python"])
    if str(final) != str(python):
        _runtime.record_runtime(
            GOV, {"python": str(final),
                  "version": result.get("version", "?"),
                  "venv": result.get("venv", "?"),
                  "exe": result.get("exe", "")})
        ctx.recovered("runtime-switch",
                      "%s -> %s" % (python, final))
        python = final
    if not _backend_imports_ok(ctx, python):
        raise RecoveryExhausted({
            "step": "DEPENDENCIES", "package": "-",
            "category": "PROJECT_ERROR",
            "root_cause": "pip exited 0 but app imports fail",
            "tried": [{"strategy": "import-validation",
                       "result": "failed"}],
            "required": "working fastapi/uvicorn/pydantic "
            "imports",
            "next_action": "inspect the venv with: "
            "%s -c 'import fastapi, uvicorn, pydantic'" % python,
            "ledger": str(ledger.path)})
    _write_lock(ctx, python)
    return python


# -- configuration ----------------------------------------------------
ENV_DEFAULTS = [
    ("APKFORGE_ENV", "local"),
    ("APKFORGE_PORT", "8000"),
    ("APKFORGE_WEB_PORT", "3000"),
    ("APKFORGE_DATA", "data"),
    ("APKFORGE_CORS", "*"),
]


def parse_env_file(path):
    values = {}
    if not Path(path).is_file():
        return values
    for line in Path(path).read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        values[key.strip()] = value.strip().strip("'\"")
    return values


def write_env_file(path, values):
    lines = ["# APKForge local config (generated; never commit)",
             "# Managed by ./apkforge — safe keys only, secrets stay here."]
    for key in ("APKFORGE_ENV", "APKFORGE_PORT", "APKFORGE_WEB_PORT",
                "APKFORGE_DATA", "APKFORGE_DB", "APKFORGE_BLOBS",
                "APKFORGE_WORK", "APKFORGE_PLUGINS", "APKFORGE_CORS",
                "APKFORGE_APKTOOL", "APKFORGE_JADX", "APKFORGE_KEY"):
        if key in values and values[key] not in (None, ""):
            lines.append("%s=%s" % (key, values[key]))
    Path(path).write_text("\n".join(lines) + "\n", encoding="utf-8")
    try:
        os.chmod(path, 0o600)
    except OSError:
        pass


def ensure_config(ctx):
    env_path = ROOT / ".env"
    values = parse_env_file(env_path)
    changed = False
    for key, default in ENV_DEFAULTS:
        if key not in values or values[key] == "":
            values[key] = os.environ.get(key, default)
            changed = True
    key = values.get("APKFORGE_KEY", "")
    if len(key) < 32 or "CHANGE" in key.upper():
        values["APKFORGE_KEY"] = secrets.token_hex(24)
        changed = True
        ctx.say("generated a fresh signing key (not shown, not logged)")
    else:
        ctx.say("signing key present → kept (never rotated silently)")
    data_dir = ROOT / values.get("APKFORGE_DATA", "data")
    for name, default in (("APKFORGE_DB", str(data_dir / "apkforge.db")),
                          ("APKFORGE_BLOBS", str(data_dir / "blobs")),
                          ("APKFORGE_WORK", str(data_dir / "work"))):
        if not values.get(name):
            values[name] = os.environ.get(name, default)
            changed = True
    if changed or not env_path.is_file():
        write_env_file(env_path, values)
        ctx.say("wrote .env (mode 600)")
    else:
        ctx.say(".env valid → kept")
    errors = validate_config(values)
    if errors:
        raise RuntimeError("CONFIG CHECK failed: %s" % "; ".join(errors))
    secret_errors = secret_check(values)
    if secret_errors:
        raise RuntimeError("SECRET CHECK failed: %s"
                           % "; ".join(secret_errors))
    ctx.say("CONFIG CHECK ok; SECRET CHECK ok")
    return values


def validate_config(values):
    errors = []
    for key in ("APKFORGE_PORT", "APKFORGE_WEB_PORT"):
        try:
            port = int(values.get(key, ""))
            if not 1 <= port <= 65535:
                raise ValueError()
        except ValueError:
            errors.append("%s must be a TCP port" % key)
    if values.get("APKFORGE_PORT") == values.get("APKFORGE_WEB_PORT"):
        errors.append("API and web ports must differ")
    return errors


def secret_check(values):
    errors = []
    key = values.get("APKFORGE_KEY", "")
    if len(key) < 32:
        errors.append("APKFORGE_KEY too short")
    if "CHANGE" in key.upper() or "EXAMPLE" in key.upper():
        errors.append("APKFORGE_KEY is a placeholder")
    gitignore = (ROOT / ".gitignore").read_text(encoding="utf-8") \
        if (ROOT / ".gitignore").is_file() else ""
    if ".env" not in gitignore:
        errors.append(".env not git-ignored")
    return errors


# -- database -----------------------------------------------------------
def ensure_database(ctx, env):
    sys.path.insert(0, str(ROOT / "backend"))
    from app.core.migrations import discover, migrate, status
    db_path = env["APKFORGE_DB"]
    Path(db_path).parent.mkdir(parents=True, exist_ok=True)
    existed = Path(db_path).is_file() and \
        Path(db_path).stat().st_size > 0
    import sqlite3
    db = sqlite3.connect(db_path)
    try:
        report = migrate(db)
        tables = sorted(row[0] for row in db.execute(
            "SELECT name FROM sqlite_master WHERE type='table'"))
        counts = {}
        for table in ("users", "projects", "jobs"):
            try:
                counts[table] = db.execute(
                    "SELECT COUNT(*) FROM %s" % table).fetchone()[0]
            except sqlite3.Error:
                counts[table] = -1
        final = status(db_path)
    finally:
        db.close()
    versions = [version for version, _, _ in discover()]
    result = {"db": db_path, "existed": existed,
              "migrations": versions, "baselined": report["baselined"],
              "applied": report["applied"], "tables": tables,
              "counts": counts, "pending": final["pending"]}
    LOGS.mkdir(parents=True, exist_ok=True)
    (LOGS / "migrations").mkdir(exist_ok=True)
    (LOGS / "migrations" / ("%s.json" % ctx.run_id)).write_text(
        json.dumps(result, indent=2), encoding="utf-8")
    if report["baselined"]:
        ctx.say("database baselined legacy tables %s (data kept)"
                % report["baselined"])
    if report["applied"]:
        ctx.say("migrations applied: %s" % report["applied"])
    else:
        ctx.say("migrations already complete → nothing to do")
    if final["pending"]:
        raise RuntimeError("migrations still pending: %s"
                           % final["pending"])
    ctx.say("tables present: %s" % ", ".join(tables))
    ctx.say("seed: no seed rows by design (first admin via setup page)")
    return result


# -- build ----------------------------------------------------------------
def npm_state_path():
    return GOV / "npm.json"


def ensure_build(ctx, env, skip_build, offline, ledger=None,
                   env_hash=""):
    if skip_build:
        ctx.say("build skipped by flag (services must already exist)")
        return {"skipped": True}
    frontend = ROOT / "frontend"
    lock = frontend / "package-lock.json"
    modules = frontend / "node_modules"
    dist = frontend / "dist"
    lock_hash = hashlib.sha256(lock.read_bytes()).hexdigest() \
        if lock.is_file() else "none"
    recorded = {}
    if npm_state_path().is_file():
        try:
            recorded = json.loads(npm_state_path().read_text(
                encoding="utf-8"))
        except ValueError:
            recorded = {}
    if modules.is_dir() and recorded.get("lock") == lock_hash:
        ctx.say("node_modules fresh for lockfile → skip npm ci")
    else:
        if offline and modules.is_dir():
            ctx.warn("offline: keeping existing node_modules")
        else:
            failure = last_failure("build.npm-ci")
            flags = ["ci", "--no-audit", "--no-fund"]
            if offline or (failure and "offline" in
                           failure.get("alternative", "")):
                flags = ["ci", "--offline", "--no-audit", "--no-fund"]
                ctx.say("npm ci in offline mode (cache)")
            code, output = run(["npm"] + flags, ctx, timeout=900,
                               cwd=frontend)
            if code != 0 and not offline and ledger is not None:
                classified = _recovery.classify_failure(output)
                if classified["category"] in ("NETWORK_FAILURE",
                                             "DNS_FAILURE"):
                    sig = _recovery.failure_signature(
                        "BUILD", classified["category"], None,
                        "retry", env_hash)
                    if not ledger.attempted("BUILD", sig,
                                            "retry"):
                        ctx.say("npm failed on network; one "
                                "retry with backoff")
                        time.sleep(5)
                        code, output = run(["npm"] + flags, ctx,
                                           timeout=900,
                                           cwd=frontend)
                        ledger.record(
                            "BUILD", sig, "retry", "npm ci",
                            env_hash,
                            "ok" if code == 0 else "failed",
                            "" if code == 0 else output[-300:])
            if code != 0 and not offline:
                record_failure(ctx, "build.npm-ci", "npm ci",
                               output[-300:], "npm ci --offline")
                ctx.say("npm ci failed, retrying offline from cache")
                code, output = run(
                    ["npm", "ci", "--offline", "--no-audit",
                     "--no-fund"], ctx, timeout=900, cwd=frontend)
            if code != 0:
                record_failure(ctx, "build.npm-ci", "npm ci",
                               output[-300:],
                               "check network or npm cache")
                raise RuntimeError("npm ci failed: %s" % output[-500:])
            npm_state_path().write_text(
                json.dumps({"lock": lock_hash}), encoding="utf-8")
    code, output = run(["npm", "run", "build"], ctx, timeout=900,
                       cwd=frontend)
    (LOGS / ("build-%s.log" % ctx.run_id)).write_text(
        redact(output), encoding="utf-8")
    if code != 0:
        raise RuntimeError("frontend build failed (see logs/build-%s.log)"
                           % ctx.run_id)
    if not (dist / "index.html").is_file():
        raise RuntimeError("build reported success but dist/ is empty")
    ctx.say("backend: no build step (interpreted; REAL, not mocked)")
    ctx.say("frontend: built → frontend/dist")
    return {"skipped": False, "dist": str(dist)}


# -- services ---------------------------------------------------------------
def pid_file(name):
    return GOV / ("%s.pid" % name)


def read_pid(name):
    path = pid_file(name)
    if not path.is_file():
        return None
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
        pid = int(data.get("pid", 0))
        return data if pid_alive(pid) else None
    except (ValueError, TypeError):
        return None


def write_pid(name, pid, port):
    pid_file(name).write_text(json.dumps(
        {"pid": pid, "port": port,
         "started": time.strftime("%Y-%m-%dT%H:%M:%SZ",
                                  time.gmtime())}), encoding="utf-8")


def spawn_detached(argv, log_path, env):
    LOGS.mkdir(parents=True, exist_ok=True)
    log = open(log_path, "a", encoding="utf-8")
    kwargs = {"stdout": log, "stderr": subprocess.STDOUT,
              "cwd": str(ROOT), "env": env}
    if os.name == "posix":
        kwargs["start_new_session"] = True
    else:
        flags = getattr(subprocess, "DETACHED_PROCESS", 0) | getattr(
            subprocess, "CREATE_NEW_PROCESS_GROUP", 0)
        kwargs["creationflags"] = flags
    proc = subprocess.Popen(argv, **kwargs)
    return proc.pid


def stop_service(name, ctx):
    data = read_pid(name)
    path = pid_file(name)
    if data is None:
        if path.is_file():
            path.unlink()
        ctx.say("%s: not running" % name)
        return False
    pid = data["pid"]
    ctx.say("stopping %s (pid %d)" % (name, pid))
    try:
        if os.name == "posix":
            os.kill(pid, 15)
        else:
            subprocess.run(["taskkill", "/PID", str(pid), "/F"],
                           stdout=subprocess.DEVNULL,
                           stderr=subprocess.DEVNULL, timeout=15)
    except OSError:
        pass
    deadline = time.time() + 10
    while pid_alive(pid) and time.time() < deadline:
        time.sleep(0.3)
    if pid_alive(pid):
        try:
            os.kill(pid, 9)
        except OSError:
            pass
    path.unlink(missing_ok=True)
    return True


def service_env(env):
    child = dict(os.environ)
    for key, value in env.items():
        if key.startswith("APKFORGE_"):
            child[key] = value
    return child


def api_healthy(base_url):
    try:
        code, body = http_json("GET", base_url + "/api/v1/health",
                               timeout=5)
        return code == 200 and isinstance(body, dict) and \
            body.get("status") == "ok"
    except Exception:
        return False


def pick_port(ctx, env, key, occupied_ok_url=None):
    port = int(env[key])
    for _ in range(11):
        if port_free(port):
            break
        if occupied_ok_url and api_healthy(occupied_ok_url):
            break
        failure_note = last_failure("ports.%s" % key)
        ctx.say("port %d busy%s → trying %d" % (
            port, " (previous: %s)" % failure_note["error"][:80]
            if failure_note else "", port + 1))
        port += 1
    else:
        raise RuntimeError("no free port near %s" % env[key])
    if str(port) != str(env[key]):
        record_failure(ctx, "ports.%s" % key, "port %s" % env[key],
                       "busy", "use %d" % port)
        env[key] = str(port)
        values = parse_env_file(ROOT / ".env")
        values[key] = str(port)
        write_env_file(ROOT / ".env", values)
        ctx.say("%s moved to %d (saved to .env)" % (key, port))
    return port


def ensure_services(ctx, env, venv_python):
    backend_port = pick_port(ctx, env, "APKFORGE_PORT",
                             "http://127.0.0.1:%s" % env["APKFORGE_PORT"])
    web_port = pick_port(ctx, env, "APKFORGE_WEB_PORT")
    base_url = "http://127.0.0.1:%d" % backend_port
    web_url = "http://127.0.0.1:%d" % web_port

    backend = read_pid("backend")
    if backend and api_healthy(base_url):
        ctx.say("backend already running (pid %d) → reuse"
                % backend["pid"])
    else:
        if backend:
            stop_service("backend", ctx)
        (LOGS / "server").mkdir(parents=True, exist_ok=True)
        pid = spawn_detached(
            [str(venv_python), "-m", "uvicorn", "app.main:app",
             "--app-dir", "backend", "--host", "127.0.0.1",
             "--port", str(backend_port)],
            LOGS / "server" / "backend.log", service_env(env))
        write_pid("backend", pid, backend_port)
        ctx.say("backend starting (pid %d, port %d)" % (pid,
                                                        backend_port))
        deadline = time.time() + 45
        while time.time() < deadline:
            if api_healthy(base_url):
                break
            if not pid_alive(pid):
                raise RuntimeError(
                    "backend died on boot (see logs/server/backend.log)")
            time.sleep(0.5)
        else:
            raise RuntimeError("backend never became healthy")

    frontend = read_pid("frontend")
    dist = ROOT / "frontend" / "dist"
    web_ok = False
    try:
        code, body = http_json("GET", web_url + "/", timeout=5)
        web_ok = code == 200 and "APKForge" in str(body)
    except Exception:
        web_ok = False
    if frontend and web_ok:
        ctx.say("frontend already running (pid %d) → reuse"
                % frontend["pid"])
    else:
        if frontend:
            stop_service("frontend", ctx)
        if not (dist / "index.html").is_file():
            raise RuntimeError("frontend dist missing; build first")
        pid = spawn_detached(
            [str(venv_python), "-m", "http.server", str(web_port),
             "--bind", "127.0.0.1", "--directory", str(dist)],
            LOGS / "server" / "frontend.log", service_env(env))
        write_pid("frontend", pid, web_port)
        ctx.say("frontend starting (pid %d, port %d)" % (pid, web_port))
        deadline = time.time() + 20
        while time.time() < deadline:
            try:
                code, body = http_json("GET", web_url + "/", timeout=5)
                if code == 200 and "APKForge" in str(body):
                    break
            except Exception:
                pass
            if not pid_alive(pid):
                raise RuntimeError("frontend server died on boot")
            time.sleep(0.5)
        else:
            raise RuntimeError("frontend never became healthy")
    return {"api_port": backend_port, "web_port": web_port,
            "api_url": base_url, "web_url": web_url}


# -- health + smoke ---------------------------------------------------------
def health_checks(ctx, env, urls):
    sys.path.insert(0, str(ROOT / "backend"))
    from app.core.migrations import status as migration_status
    checks = []

    def add(name, ok, detail=""):
        checks.append({"name": name, "ok": bool(ok), "detail": detail})
        ctx.say("health %-22s %s %s" % (name, "OK" if ok else "FAIL",
                                        detail))

    backend = read_pid("backend")
    frontend = read_pid("frontend")
    add("backend.process", bool(backend),
        "pid %s" % (backend and backend["pid"]))
    add("frontend.process", bool(frontend),
        "pid %s" % (frontend and frontend["pid"]))
    add("backend.port", not port_free(urls["api_port"]),
        str(urls["api_port"]))
    add("frontend.port", not port_free(urls["web_port"]),
        str(urls["web_port"]))
    try:
        code, body = http_json("GET", urls["api_url"] + "/api/v1/health")
        add("api.health", code == 200 and body.get("status") == "ok",
            "api_version=%s" % (isinstance(body, dict) and
                                body.get("api_version")))
    except Exception as exc:
        add("api.health", False, str(exc)[:120])
    try:
        code, body = http_json("GET", urls["api_url"] +
                               "/api/v1/setup/status")
        initialized = isinstance(body, dict) and \
            isinstance(body.get("initialized"), bool)
        add("setup.endpoint", code == 200 and initialized,
            "initialized=%s" % (body.get("initialized")
                                if initialized else "?"))
    except Exception as exc:
        add("setup.endpoint", False, str(exc)[:120])
    try:
        import sqlite3
        db = sqlite3.connect(env["APKFORGE_DB"])
        try:
            count = db.execute("SELECT COUNT(*) FROM users").fetchone()
            pending = migration_status(env["APKFORGE_DB"])["pending"]
            add("database.query", True, "users=%d" % count[0])
            add("migrations.complete", pending == [],
                "pending=%s" % pending)
        finally:
            db.close()
    except Exception as exc:
        add("database.query", False, str(exc)[:120])
        add("migrations.complete", False, "db unreachable")
    try:
        code, _ = http_json("POST", urls["api_url"] + "/api/v1/auth/login",
                            {"username": "nobody-matches-this",
                             "password": "wrong-password-12345"})
        add("auth.negative", code == 401, "bogus login → %s" % code)
    except Exception as exc:
        add("auth.negative", False, str(exc)[:120])
    try:
        code, body = http_json("GET", urls["web_url"] + "/")
        add("frontend.page", code == 200 and "APKForge" in str(body),
            "http %s" % code)
    except Exception as exc:
        add("frontend.page", False, str(exc)[:120])
    (LOGS / "health").mkdir(exist_ok=True)
    (LOGS / "health" / ("%s.json" % ctx.run_id)).write_text(
        json.dumps(checks, indent=2), encoding="utf-8")
    return checks


def smoke_tests(ctx, env, urls):
    ctx.say("smoke: non-mutating end-to-end probes")
    return health_checks(ctx, env, urls)


# -- governance outputs -------------------------------------------------------
def write_yaml_mapping(path, mapping):
    def esc(value):
        text = str(value).replace("\\", "\\\\").replace('"', '\\"')
        return '"%s"' % text.replace("\n", " ")
    lines = ["# Generated by ./apkforge (do not edit by hand)"]
    for key, value in mapping.items():
        if isinstance(value, list):
            lines.append("%s:" % key)
            for item in value:
                lines.append("  - %s" % esc(item))
        else:
            lines.append("%s: %s" % (key, esc(value)))
    Path(path).write_text("\n".join(lines) + "\n", encoding="utf-8")


def write_governance(ctx, env, urls, report):
    (GOV / "CHECKPOINTS").mkdir(parents=True, exist_ok=True)
    (GOV / "AUDIT").mkdir(parents=True, exist_ok=True)
    (GOV / "CHECKPOINTS" / ("%s.json" % ctx.run_id)).write_text(
        json.dumps(report, indent=2), encoding="utf-8")
    audit = {"run_id": ctx.run_id, "state": ctx.state,
             "warnings": ctx.warnings,
             "history": ctx.history,
             "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())}
    (GOV / "AUDIT" / ("%s.json" % ctx.run_id)).write_text(
        json.dumps(audit, indent=2), encoding="utf-8")
    blockers = [check["name"] + ": " + check["detail"]
                for check in report.get("health", [])
                if not check["ok"]]
    if report.get("failed_step"):
        blockers.append(report["failed_step"])
    write_yaml_mapping(GOV / "PROJECT_STATE.yaml", {
        "current_gate": "bootstrap",
        "current_phase": "phase-1-local",
        "last_run_id": ctx.run_id,
        "environment_status": report.get("environment", "?"),
        "database_status": report.get("database", "?"),
        "server_status": report.get("services", "?"),
        "health_status": "HEALTHY" if report.get("healthy")
        else "DEGRADED",
        "blockers": blockers or ["none"],
        "next_action": "open %s" % urls.get("web_url", "")
        if ctx.state == "READY" else "inspect logs/errors/%s.log"
        % ctx.run_id,
    })


# -- pipeline -------------------------------------------------------------------
def open_browser(ctx, url):
    if shutil.which("termux-open-url") is not None:
        try:
            proc = subprocess.run(
                ["termux-open-url", url],
                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                timeout=30, text=True, errors="replace")
        except (OSError, subprocess.TimeoutExpired) as exc:
            ctx.say("browser: termux-open-url failed (%s); "
                    "open manually: %s" % (exc, url))
            return False
        if proc.returncode == 0:
            ctx.say("browser: opened " + url)
            return True
        ctx.say("browser: termux-open-url exit %d%s; open "
                "manually: %s" % (
                    proc.returncode,
                    " (install the Termux:API app?)"
                    if "not found" in (proc.stdout or "").lower()
                    or "no such" in (proc.stdout or "").lower()
                    else "", url))
        return False
    try:
        opened = webbrowser.open(url, new=2)
    except Exception as exc:
        ctx.say("browser: %s" % exc)
        return False
    ctx.say("browser: %s" % ("opened " + url if opened else
                             "headless — open manually: " + url))
    return opened


def write_bootstrap_report(ctx, report, urls, status, failed=None):
    """Final .governance/bootstrap-report.{json,md} (never fatal)."""
    try:
        degraded = json.loads((GOV / "degraded.json").read_text(
            encoding="utf-8"))
    except (OSError, ValueError):
        degraded = {"enabled": False}
    try:
        rows = _strategy.read_rows(GOV / "recovery-ledger.jsonl")
        mine = [row for row in rows
                if row.get("run_id") == ctx.run_id]
    except Exception:
        mine = []
    doc = {
        "run_id": ctx.run_id, "engine": ENGINE_VERSION,
        "status": status,
        "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "environment": report.get("env_summary", "?"),
        "runtime": _runtime_record().get("current", {}),
        "toolchain": _strategy.toolchain_fingerprint()["tools"],
        "dependencies": {
            "strategies": [{"strategy": row.get("strategy"),
                            "result": row.get("result"),
                            "category": row.get("category")}
                           for row in mine],
            "locked": (GOV / "requirements.lock").is_file(),
            "degraded": degraded},
        "stages": _checkpoint.completed_stages(GOV),
        "recovery_actions": ctx.recovery,
        "warnings": ctx.warnings,
        "services": urls,
        "health": [check.get("name") for check in
                   report.get("health", [])
                   if isinstance(check, dict)],
        "blocker": failed}
    try:
        GOV.mkdir(parents=True, exist_ok=True)
        (GOV / "bootstrap-report.json").write_text(
            json.dumps(doc, indent=2, default=str),
            encoding="utf-8")
        lines = ["# bootstrap report %s" % ctx.run_id, "",
                 "- status: %s" % status,
                 "- environment: %s" % doc["environment"],
                 "- runtime: %s" % (doc["runtime"] or "default"),
                 "- stages: %s" % ", ".join(doc["stages"]),
                 "- strategies:"]
        for item in doc["dependencies"]["strategies"]:
            lines.append("  - %s → %s (%s)" % (
                item.get("strategy"), item.get("result"),
                item.get("category")))
        lines += ["- degraded: %s" % degraded.get("enabled"),
                  "- warnings: %d" % len(ctx.warnings),
                  "- blocker: %s" % (failed or "none"), ""]
        (GOV / "bootstrap-report.md").write_text(
            "\n".join(lines), encoding="utf-8")
    except OSError:
        pass


def _write_runtime_profile(fp, profile):
    """Current platform capability profile (regenerated per run)."""
    try:
        slug = "".join(
            char if char.isalnum() else "-"
            for char in (profile.get("platform", "unknown") or
                         "unknown").lower()).strip("-") or "unknown"
        target = GOV / "runtime-profiles" / ("%s.yaml" % slug)
        target.parent.mkdir(parents=True, exist_ok=True)
        write_yaml_mapping(target, {
            "platform": profile.get("platform", "?"),
            "arch": fp.get("arch_machine", "?"),
            "libc": fp.get("libc", "?"),
            "termux": fp.get("termux", False),
            "python_current": fp.get("python_version", "?"),
            "compiler_c": profile.get("compiler_c", False),
            "compiler_rust": profile.get("compiler_rust", False),
            "package_manager":
                profile.get("package_manager") or "none",
            "wheels_prefer": True,
            "fallback_source_build": True,
        })
    except OSError:
        pass


def final_report(ctx, sections, urls, healthy, failed=None):
    return {"run_id": ctx.run_id, "engine": ENGINE_VERSION,
            "state": ctx.state, "healthy": healthy,
            "failed_step": failed, "urls": urls,
            "warnings": ctx.warnings, **sections}


def print_banner(ctx, report, urls, initialized):
    print("")
    print("=" * 52)
    print(" APKFORGE BOOTSTRAP")
    print("=" * 52)
    print("")
    print("Run ID: %s" % ctx.run_id)
    print("Engine: %s" % ENGINE_VERSION)
    print("Environment: %s" % report.get("env_summary", "?"))
    print("")
    print("TOOLS")
    for row in report.get("tools_detail", []):
        if row.get("adaptive_status") == "AVAILABLE":
            mark = "reused %s" % row.get("detected_version", "-")
        elif row.get("role") == "REQUIRED":
            mark = "!! %s" % row.get("adaptive_status")
        else:
            mark = "skipped (%s)" % str(
                row.get("adaptive_status", "?")).lower().replace(
                    "_", " ")
        print("  %-10s %s" % (row.get("tool", "?"), mark))
    print("")
    for key in ("runtime", "dependencies", "database",
                "configuration", "build", "backend", "frontend",
                "health", "smoke"):
        value = report.get(key, "?")
        if isinstance(value, list):
            value = "ok" if value and all(
                check.get("ok") for check in value) else (
                    "?" if not value else "FAIL")
        print("  %-12s %s" % (
            key.upper(), value.upper()
            if isinstance(value, str) else "?"))
    print("")
    recovered = report.get("recovery", [])
    if recovered:
        print("RECOVERY")
        for item in recovered:
            print("  recovered via %s: %s"
                  % (item.get("strategy"), item.get("detail")))
    else:
        print("Recovery: none needed")
    print("")
    print("Administrator: %s" % ("READY (setup complete)"
                                 if initialized else
                                 "OPEN the setup URL below"))
    print("API URL: %s" % urls.get("api_url", "?"))
    print("Web URL: %s" % urls.get("web_url", "?"))
    print("Status: READY")
    print("")


def _saved_inventory():
    path = GOV / "tool-inventory.json"
    try:
        rows = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return None
    return rows if isinstance(rows, list) else None


def verify_tools_saved():
    rows = _saved_inventory()
    if not rows:
        return False
    for row in rows:
        if row.get("role") != "REQUIRED":
            continue
        if row.get("adaptive_status") != "AVAILABLE":
            return False
        path = row.get("path")
        if not path or not Path(path).exists():
            return False
    return True


def verify_runtime_saved():
    python = _current_python()
    if not python.is_file():
        return False
    if not (GOV / "requirements.lock").is_file():
        return False
    try:
        proc = subprocess.run(
            [str(python), "-c",
             "import fastapi, uvicorn, pydantic"],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
            timeout=60)
    except OSError:
        return False
    return proc.returncode == 0


def verify_config_saved():
    values = parse_env_file(ROOT / ".env")
    if not values:
        return False
    return not validate_config(values) and not secret_check(values)


def verify_database_saved():
    values = parse_env_file(ROOT / ".env")
    db_path = values.get("APKFORGE_DB",
                         str(ROOT / "data" / "apkforge.db"))
    if not Path(db_path).is_file():
        return False
    sys.path.insert(0, str(ROOT / "backend"))
    try:
        from app.core.migrations import status as migration_status
        return migration_status(db_path)["pending"] == []
    except Exception:
        return False


def verify_build_saved():
    if not (ROOT / "frontend" / "dist" / "index.html").is_file():
        return False
    lock = ROOT / "frontend" / "package-lock.json"
    lock_hash = hashlib.sha256(lock.read_bytes()).hexdigest() \
        if lock.is_file() else "none"
    try:
        recorded = json.loads(npm_state_path().read_text(
            encoding="utf-8"))
    except (OSError, ValueError):
        return False
    return recorded.get("lock") == lock_hash


def _plan_state(ctx):
    values = parse_env_file(ROOT / ".env")
    db_path = values.get("APKFORGE_DB",
                         str(ROOT / "data" / "apkforge.db"))
    venv_python = _current_python()
    valid = validate_venv(ctx, venv_python)[0] \
        if venv_python.is_file() else False
    return {"venv_exists": venv_python.is_file(),
            "venv_valid": valid,
            "env_exists": (ROOT / ".env").is_file(),
            "db_exists": Path(db_path).is_file()}


def _adaptive_rows(rows):
    """Legacy rows back to the adaptive shape (plan/profile)."""
    return [{"tool": row["tool"],
             "status": row.get("adaptive_status"),
             "role": row.get("role"),
             "detected": row.get("detected_version"),
             "source": row.get("source", "")}
            for row in rows]


def run_pipeline(args):
    run_id = new_run_id()
    ctx = Ctx(run_id, LOGS / "bootstrap" / ("%s.log" % run_id),
              json_only=args.json)
    ctx.say("apkforge bootstrap %s (run %s)" % (ENGINE_VERSION, run_id))
    ledger = _recovery.Ledger(GOV / "recovery-ledger.jsonl")
    report = {}
    urls = {}
    failed = None
    try:
        load_local_path()
        if (ROOT / ".git").exists():
            gate = _gitcare.quick_gate(ROOT)
            if gate["verdict"] == "RECOVERY_REQUIRED":
                ctx.step("GIT_RECOVERY_REQUIRED")
                ctx.warn("git health gate failed; build blocked "
                         "until green")
                result = _gitcare.auto(ROOT, run_id, LOGS,
                                       say=ctx.say)
                final = _gitcare.quick_gate(ROOT)
                if final["verdict"] != "OK":
                    record_failure(
                        ctx, "GIT", "gitcare auto",
                        final["verdict"],
                        "see logs/git-recovery/%s/report.md"
                        % run_id)
                    ctx.step("BLOCKED")
                    raise RecoveryExhausted({
                        "step": "GIT", "package": "-",
                        "category": "PROJECT_ERROR",
                        "root_cause": "repository still "
                        "unhealthy after auto recovery",
                        "tried": [{"strategy": action,
                                   "result": "done"}
                                  for action in
                                  result["actions"]],
                        "required": "valid index + objects + "
                        "required source",
                        "next_action": "run ./apkforge gitcare "
                        "diagnose, fix the cause, re-run",
                        "ledger": str(ledger.path)})
                ctx.recovered("gitcare",
                              ", ".join(result["actions"]))
            report["git"] = "ok"
        else:
            report["git"] = "no-repo"
        ctx.step("ENVIRONMENT_CHECK")
        facts = audit_environment(ctx)
        fp = facts["fingerprint"]
        env_hash = fp["fingerprint_hash"]
        offline = not facts["network"]
        report["environment"] = "ok"
        (LOGS / ("environment-%s.json" % run_id)).write_text(
            json.dumps(fp, indent=2, default=str),
            encoding="utf-8")
        ctx.say("os=%s arch=%s ram=%sMB disk_free=%sMB network=%s" % (
            facts["os"], facts["arch"], facts.get("ram_mb", "?"),
            facts.get("disk_free_mb", "?"), facts["network"]))
        ctx.step("ENVIRONMENT_DETECTED")
        previous = _checkpoint.completed_stages(GOV)
        if previous:
            ctx.say("checkpoints from earlier runs: %s"
                    % ",".join(previous))
        rows = detect_tools(ctx, fp)
        (GOV / "tool-inventory.json").write_text(
            json.dumps(rows, indent=2), encoding="utf-8")
        (LOGS / ("tools-%s.json" % run_id)).write_text(
            json.dumps(rows, indent=2), encoding="utf-8")
        ctx.step("TOOLS_INVENTORIED")
        profile = _env.capability_profile(
            fp, _adaptive_rows(rows))
        _write_runtime_profile(fp, profile)
        preflight = _compat.preflight(
            ROOT / "backend" / "requirements.txt", fp, profile,
            cache_dir=ROOT / ".cache" / "apkforge")
        (GOV / "compat-matrix.json").write_text(
            json.dumps(preflight, indent=2, default=str),
            encoding="utf-8")
        for blocker in preflight["blockers"]:
            ctx.warn("preflight: %s" % blocker)
        ctx.step("COMPATIBILITY_RESOLVED")
        plan = _plan.build_plan(
            fp, profile, _adaptive_rows(rows), preflight, _plan_state(ctx),
            {"install_tools": args.install_tools,
             "skip_build": args.skip_build, "offline": offline})
        (GOV / "bootstrap-plan.json").write_text(
            json.dumps(plan, indent=2), encoding="utf-8")
        for line in _plan.render_plan(plan).splitlines():
            ctx.say("plan | " + line)
        ctx.step("PLAN_CREATED")
        if _checkpoint.should_skip(GOV, "TOOLS", env_hash,
                                   verify_tools_saved):
            ctx.say("resume: TOOLS verified → skip provisioning")
        else:
            rows = ensure_required_tools(ctx, offline, rows,
                                         ledger, env_hash, fp)
            (GOV / "tool-inventory.json").write_text(
                json.dumps(rows, indent=2), encoding="utf-8")
            _checkpoint.save_stage(GOV, "TOOLS",
                                   "required tools available",
                                   env_hash, run_id)
        ctx.step("TOOLS_READY")
        report["tools"] = "ok"
        report["tools_detail"] = rows
        if args.install_tools:
            if offline:
                raise RuntimeError("NETWORK REQUIRED: --install-tools "
                                   "needs downloads")
            try:
                jar = install_apktool(ctx)
                values = parse_env_file(ROOT / ".env")
                values["APKFORGE_APKTOOL"] = jar
                write_env_file(ROOT / ".env", values)
            except RuntimeError as exc:
                ctx.warn("apktool install failed: %s" % exc)
        if _checkpoint.should_skip(GOV, "CONFIG", env_hash,
                                   verify_config_saved):
            ctx.say("resume: CONFIG verified → skip")
            env = parse_env_file(ROOT / ".env")
        else:
            env = ensure_config(ctx)
            _checkpoint.save_stage(GOV, "CONFIG", ".env validated",
                                   env_hash, run_id)
        ctx.step("CONFIG_READY")
        report["configuration"] = "ok"
        if _checkpoint.should_skip(GOV, "RUNTIME", env_hash,
                                   verify_runtime_saved):
            ctx.say("resume: RUNTIME verified → skip install")
            venv_python = _venv_python()
        else:
            venv_python = ensure_venv(ctx, offline, fp, profile,
                                      ledger, env_hash)
            _checkpoint.save_stage(GOV, "RUNTIME",
                                   "venv + deps validated",
                                   env_hash, run_id)
        ctx.step("RUNTIME_READY")
        report["runtime"] = "ok"
        ctx.step("DEPENDENCIES_READY")
        report["dependencies"] = "ok"
        if _checkpoint.should_skip(GOV, "DATABASE", env_hash,
                                   verify_database_saved):
            ctx.say("resume: DATABASE verified → skip")
        else:
            ensure_database(ctx, env)
            _checkpoint.save_stage(GOV, "DATABASE",
                                   "migrations complete",
                                   env_hash, run_id)
        ctx.step("DATABASE_READY")
        report["database"] = "ok"
        ctx.step("MIGRATIONS_READY")
        report["migrations"] = "ok"
        try:
            from update import boot_update_notice
            notice = boot_update_notice(ROOT)
            report["update_required"] = notice["update_required"]
            report["update_status"] = notice["status"]
            for line in notice["lines"]:
                ctx.warn(line)
        except Exception as exc:
            ctx.warn("update notice skipped: %s" % exc)
        ctx.step("SEED_READY")
        report["seed"] = "ok"
        if args.skip_build:
            build_report = ensure_build(ctx, env, True, offline,
                                        ledger, env_hash)
        elif _checkpoint.should_skip(GOV, "BUILD", env_hash,
                                     verify_build_saved):
            ctx.say("resume: BUILD verified → skip")
            build_report = {"skipped": False}
        else:
            build_report = ensure_build(ctx, env, False, offline,
                                        ledger, env_hash)
            _checkpoint.save_stage(GOV, "BUILD",
                                   "frontend dist ready",
                                   env_hash, run_id)
        ctx.step("BUILD_READY")
        report["build"] = "skipped" if build_report["skipped"] else "ok"
        urls = ensure_services(ctx, env, venv_python)
        ctx.step("SERVICES_READY")
        report["backend"] = "ok"
        report["frontend"] = "ok"
        report["services"] = "ok"
        health = health_checks(ctx, env, urls)
        report["health"] = health
        if not all(check["ok"] for check in health):
            bad = [check["name"] for check in health if not check["ok"]]
            raise RuntimeError("health FAILED: %s" % ", ".join(bad))
        ctx.step("HEALTHY")
        smoke = smoke_tests(ctx, env, urls)
        report["smoke"] = "ok" if all(
            check["ok"] for check in smoke) else "FAIL"
        if report["smoke"] != "ok":
            raise RuntimeError("smoke tests FAILED")
        _code, setup_body = http_json(
            "GET", urls["api_url"] + "/api/v1/setup/status")
        initialized = isinstance(setup_body, dict) and \
            setup_body.get("initialized") is True
        target = urls["web_url"] + ("#/admin/setup"
                                    if not initialized else "")
        if not args.no_browser:
            open_browser(ctx, target)
        else:
            ctx.say("browser suppressed by flag; url: %s" % target)
        if not initialized:
            ctx.step("ADMIN_SETUP_REQUIRED")
            ctx.say("first run: complete admin setup in the browser")
        ctx.step("READY")
        report["env_summary"] = "%s / %s (%s)" % (
            profile["platform"], fp["arch_machine"], env_hash)
        report["recovery"] = ctx.recovery
        try:
            write_bootstrap_report(ctx, report, urls, "READY")
        except Exception:
            pass
        full = final_report(ctx, report, urls, True)
        write_governance(ctx, env, urls, full)
        print_banner(ctx, report, urls, initialized)
        if args.json:
            print(json.dumps(full, indent=2, default=str))
        return 0
    except RecoveryExhausted as exc:
        info = exc.info
        state = exhaustion_state(info)
        if ctx.state != state:
            ctx.step(state)
        block = _recovery.exhausted_report(info)
        ctx.say("auto-recovery exhausted: %s"
                % info.get("root_cause", "?"))
        (LOGS / "errors").mkdir(exist_ok=True)
        (LOGS / "errors" / ("%s.log" % run_id)).write_text(
            redact(block), encoding="utf-8")
        record_failure(ctx, info.get("step", "?"), "pipeline",
                       info.get("root_cause", "?"),
                       info.get("next_action", "?"))
        try:
            write_bootstrap_report(
                ctx, report, urls, state,
                failed="%s: %s" % (info.get("step"),
                                   info.get("root_cause")))
        except Exception:
            pass
        full = final_report(ctx, report, urls, False, failed="%s: %s" % (
            info.get("step"), info.get("root_cause")))
        try:
            write_governance(ctx, parse_env_file(ROOT / ".env") or {},
                             urls, full)
        except Exception:
            pass
        if not ctx.json_only:
            print(block, flush=True)
        if args.json:
            print(json.dumps(full, indent=2, default=str))
        return 1
    except Exception as exc:
        failed = "%s: %s" % (ctx.state, exc)
        ctx.say("FAILED: %s" % failed)
        import traceback
        (LOGS / "errors").mkdir(exist_ok=True)
        (LOGS / "errors" / ("%s.log" % run_id)).write_text(
            redact(traceback.format_exc()), encoding="utf-8")
        record_failure(ctx, ctx.state, "pipeline", str(exc),
                       "see logs/errors/%s.log, fix cause, re-run" % run_id)
        ctx.state = "FAILED"
        save_state(ctx)
        try:
            write_bootstrap_report(ctx, report, urls, "FAILED",
                                   failed=failed)
        except Exception:
            pass
        full = final_report(ctx, report, urls, False, failed=failed)
        try:
            write_governance(ctx, parse_env_file(ROOT / ".env") or {},
                             urls, full)
        except Exception:
            pass
        if not ctx.json_only:
            print("", flush=True)
            print("FAILED STEP : %s" % ctx.history[-1]["state"]
                  if ctx.history else "INIT", flush=True)
            print("ERROR       : %s" % redact(exc), flush=True)
            print("DIAGNOSTIC  : logs/errors/%s.log" % run_id, flush=True)
            print("NEXT ACTION : fix the cause above, then re-run "
                  "./apkforge (it resumes safely)", flush=True)
        if args.json:
            print(json.dumps(full, indent=2, default=str))
        return 1
    finally:
        ctx.close()


def cmd_plan(args):
    run_id = new_run_id()
    ctx = Ctx(run_id, LOGS / "bootstrap" / ("%s.log" % run_id),
              json_only=args.json)
    try:
        load_local_path()
        facts = audit_environment(ctx)
        fp = facts["fingerprint"]
        profile = _env.capability_profile(
            fp, _tools.inventory(TOOL_MATRIX, fp=fp))
        flex = _compat.preflight(
            ROOT / "backend" / "requirements.txt", fp, profile,
            cache_dir=ROOT / ".cache" / "apkforge")
        plan = _plan.build_plan(
            fp, profile, _adaptive_rows(detect_tools(ctx, fp)), flex,
            _plan_state(ctx),
            {"install_tools": args.install_tools,
             "skip_build": args.skip_build,
             "offline": not facts["network"]})
        report = _plan.render_plan(plan)
        print(report)
        (LOGS / ("plan-%s.txt" % run_id)).write_text(
            report + "\n", encoding="utf-8")
        return 0
    finally:
        ctx.close()


def cmd_gitcare(args):
    import argparse as _ap
    parser = _ap.ArgumentParser(prog="apkforge gitcare")
    parser.add_argument("action", nargs="?", default="status",
                        choices=["status", "diagnose", "cleanup",
                                 "repair-index", "report"])
    parser.add_argument("--yes", action="store_true")
    parser.add_argument("--deep", action="store_true")
    parser.add_argument("--json", action="store_true")
    parsed = parser.parse_args(args.command_args or [])
    run_id = new_run_id()
    ctx = Ctx(run_id, LOGS / "bootstrap" / ("%s.log" % run_id),
              json_only=args.json)
    try:
        if parsed.action == "status":
            gate = _gitcare.quick_gate(ROOT)
            for check in gate["checks"]:
                mark = "ok" if check["ok"] else "FAIL"
                detail = (" (%s)" % check["detail"]
                          if not check["ok"] and check["detail"]
                          else "")
                print("%-14s %s%s" % (check["name"], mark,
                                      detail))
            print("verdict: %s" % gate["verdict"])
            return 0 if gate["verdict"] == "OK" else 1
        if parsed.action == "report":
            repodir = LOGS / "git-recovery"
            reports = sorted(repodir.glob("*/report.md")) \
                if repodir.exists() else []
            if parsed.json:
                print(json.dumps(
                    {"reports": [str(item) for item in reports]},
                    indent=2))
            elif reports:
                print("latest: %s" % reports[-1])
            else:
                print("no gitcare reports yet "
                      "(run: ./apkforge gitcare diagnose)")
            return 0 if reports else 1
        if parsed.action == "diagnose":
            data = _gitcare.diagnose(ROOT)
            if parsed.json:
                print(json.dumps(data, indent=2, default=str))
            else:
                print("verdict: %s" % data["verdict"])
                for issue in data["issues"]:
                    print("- [%s] %s: %s"
                          % (issue["severity"],
                             issue["finding"], issue["detail"]))
                if data["verdict"] == "OK":
                    print("repository healthy")
            return 0
        if parsed.action == "cleanup":
            if parsed.deep and not parsed.yes:
                print("refusing deep cleanup without --yes")
                return 1
            payload = _gitcare.cleanup(ROOT, dry_run=False,
                                       deep=parsed.deep)
            if parsed.json:
                print(json.dumps(payload, indent=2))
            else:
                print("removed %d files (%d bytes)"
                      % (payload["removed_count"],
                         payload["removed_bytes"]))
                if payload["protected"]:
                    print("protected: %s"
                          % ", ".join(payload["protected"]))
            return 0
        if not parsed.yes:
            print("refusing index repair without --yes")
            return 1
        try:
            result = _gitcare.repair_index(
                ROOT, say=lambda msg: print("gitcare: %s" % msg))
        except _gitcare.GitCareError as exc:
            print("gitcare: %s" % exc)
            return 1
        if parsed.json:
            print(json.dumps(result, indent=2))
        else:
            for step in result["steps"]:
                print("- %s" % step)
        return 0
    finally:
        ctx.close()


def _doctor_collect(ctx):
    """Read-only full diagnosis (never installs, never writes)."""
    load_local_path()
    facts = audit_environment(ctx)
    fp = facts["fingerprint"]
    rows = _tools.inventory(TOOL_MATRIX, fp=fp)
    profile = _env.capability_profile(fp, rows)
    req_path = ROOT / "backend" / "requirements.txt"
    try:
        reqs = _compat.parse_requirements(req_path)
    except OSError:
        reqs = []
    flex = _compat.preflight(req_path, fp, profile,
                             cache_dir=ROOT / ".cache" / "apkforge")
    alternates = []
    for item in _runtime.find_pythons():
        check = _runtime.verify_python(item["exe"])
        alternates.append({"exe": item["exe"],
                           "version": "%d.%d" % item["version"],
                           "ok": check["ok"],
                           "reason": check.get("reason", "")})
    ledger_rows = _strategy.read_rows(GOV / "recovery-ledger.jsonl")
    values = parse_env_file(ROOT / ".env")
    db_path = values.get("APKFORGE_DB",
                         str(ROOT / "data" / "apkforge.db"))
    try:
        sys.path.insert(0, str(ROOT / "backend"))
        from app.core.migrations import status as migration_status
        pending = migration_status(db_path)["pending"] \
            if Path(db_path).is_file() else ["db-missing"]
    except Exception as exc:
        pending = ["unreadable: %s" % exc]
    dist = ROOT / "frontend" / "dist" / "index.html"
    gate = _gitcare.quick_gate(ROOT) if (ROOT / ".git").exists() \
        else {"verdict": "NOT_A_REPO", "checks": []}
    return {
        "environment": {
            "os": facts["os"], "arch": facts["arch"],
            "termux": fp.get("termux", False),
            "libc": fp.get("libc", "?"),
            "ram_mb": facts.get("ram_mb", "?"),
            "disk_free_mb": facts.get("disk_free_mb", "?"),
            "network": facts["network"],
            "fingerprint": fp.get("fingerprint_hash", "?")},
        "runtime": {
            "current": fp.get("python_version", "?"),
            "recorded": _runtime_record().get("current", {}),
            "alternates": alternates},
        "toolchain": _strategy.toolchain_fingerprint()["tools"],
        "python_compatibility": [
            {"package": verdict["package"],
             "status": verdict["status"],
             "version": verdict.get("version") or verdict.get(
                 "requested", "")}
            for verdict in flex["packages"]],
        "dependency_graph": [
            {"name": req.get("name"), "spec": req.get("spec", ""),
             "extras": req.get("extras", [])}
            for req in reqs if "name" in req],
        "wheel_availability": {
            "blockers": flex["blockers"],
            "warnings": flex["warnings"]},
        "build_capability": {
            "compiler_c": profile.get("compiler_c"),
            "compiler_rust": profile.get("compiler_rust"),
            "package_manager": profile.get("package_manager")},
        "recovery_ledger": [
            {"strategy": row.get("strategy"),
             "result": row.get("result"),
             "category": row.get("category", "?"),
             "ts": row.get("ts", "")}
            for row in ledger_rows[-8:]
            if row.get("kind") != "reclassify"],
        "failure_memory": _strategy.last_failure(
            GOV / "recovery-ledger.jsonl"),
        "checkpoint": {
            "stages": _checkpoint.completed_stages(GOV)},
        "database": {"path": db_path,
                     "exists": Path(db_path).is_file(),
                     "pending": pending},
        "frontend": {"dist": dist.is_file()},
        "git": {"verdict": gate["verdict"]},
        "disk": {"free_mb": facts.get("disk_free_mb", "?")},
        "network": {"online": facts["network"]}}


def cmd_doctor(args):
    run_id = new_run_id()
    ctx = Ctx(run_id, LOGS / "bootstrap" / ("%s.log" % run_id),
              json_only=args.json)
    try:
        doc = _doctor_collect(ctx)
        if args.json:
            print(json.dumps(doc, indent=2, default=str))
            return 0
        for section, payload in doc.items():
            print("--- %s ---" % section)
            if isinstance(payload, dict):
                for key, value in payload.items():
                    print("%s: %s" % (key, value))
            elif isinstance(payload, list):
                for item in payload:
                    print(item)
            else:
                print(payload)
        return 0
    finally:
        ctx.close()


def cmd_recover(args):
    restored = _strategy.restore_failure_context(
        GOV / "recovery-ledger.jsonl")
    memory = restored["memory"] or {}
    if not memory:
        print("failure memory: none recorded")
    else:
        status = _strategy.memory_status(
            memory,
            _strategy.toolchain_fingerprint().get("hash"))
        print("failure memory [%s]: package=%s category=%s "
              "strategy=%s" % (
                  status["status"],
                  restored["diagnosed_package"]
                  or memory.get("package") or "-",
                  restored["category"],
                  memory.get("strategy") or "-"))
        print("  recorded: %s (%s) target=%s" % (
            memory.get("ts") or "?", status["reason"],
            memory.get("package") or "-"))
        if restored["reclassified"]:
            print("  reclassified: %s"
                  % restored["reclassify_note"])
        print("  log: %s" % (memory.get("log") or "-"))
    print("checkpoints: %s" % ", ".join(
        _checkpoint.completed_stages(GOV)) or "none")
    print("resuming bootstrap; the strategy loop picks the next "
          "changed strategy")
    return run_pipeline(args)


# -- modes ------------------------------------------------------------------------
def cmd_check(args):
    run_id = new_run_id()
    ctx = Ctx(run_id, LOGS / "bootstrap" / ("%s.log" % run_id),
              json_only=args.json)
    try:
        load_local_path()
        facts = audit_environment(ctx)
        rows = detect_tools(ctx)
        values = parse_env_file(ROOT / ".env")
        print("--- environment ---")
        print("os=%s arch=%s network=%s" % (
            facts["os"], facts["arch"], facts["network"]))
        print("--- tool matrix ---")
        for row in rows:
            print("%-10s %-14s detected=%-8s want=%s" % (
                row["tool"], row["status"], row["detected_version"],
                row["required_version"]))
        fp = facts["fingerprint"]
        profile = _env.capability_profile(
            fp, _adaptive_rows(rows))
        flex = _compat.preflight(
            ROOT / "backend" / "requirements.txt", fp, profile,
            cache_dir=ROOT / ".cache" / "apkforge")
        print("--- compatibility ---")
        for verdict in flex["packages"]:
            detail = verdict.get("version") or verdict.get(
                "requested") or ""
            print("%s %s %s" % (verdict["package"],
                                verdict["status"],
                                detail).rstrip())
        for warning in flex["warnings"]:
            print("warning: %s" % warning)
        for blocker in flex["blockers"]:
            print("blocker: %s" % blocker)
        plan = _plan.build_plan(
            fp, profile, _adaptive_rows(rows), flex, _plan_state(ctx),
            {"install_tools": False, "skip_build": False,
             "offline": not facts["network"]})
        print("--- plan ---")
        print(_plan.render_plan(plan))
        print("--- config ---")
        print(".env:", "present" if values else "missing (will create)")
        if values:
            print("config errors:", validate_config(values) or "none")
            print("secret errors:", secret_check(values) or "none")
        print("--- database ---")
        sys.path.insert(0, str(ROOT / "backend"))
        from app.core.migrations import status as migration_status
        db_path = values.get("APKFORGE_DB",
                             str(ROOT / "data" / "apkforge.db"))
        print("db:", db_path, "exists:", Path(db_path).is_file())
        if Path(db_path).is_file():
            print("migrations:", migration_status(db_path))
        print("--- services ---")
        for name in ("backend", "frontend"):
            data = read_pid(name)
            print("%s:" % name, "pid %d port %s" % (
                data["pid"], data["port"]) if data else "stopped")
        print("--- state ---")
        print(load_state() or "never bootstrapped")
        return 0
    finally:
        ctx.close()


def cmd_status(args):
    del args
    state = load_state()
    values = parse_env_file(ROOT / ".env")
    api_url = "http://127.0.0.1:%s" % values.get("APKFORGE_PORT", "8000")
    web_url = "http://127.0.0.1:%s" % values.get("APKFORGE_WEB_PORT",
                                                 "3000")
    print("state:", (state or {}).get("state", "never bootstrapped"))
    for name in ("backend", "frontend"):
        data = read_pid(name)
        print("%s:" % name, "pid %d port %s" % (data["pid"],
                                                data["port"])
              if data else "stopped")
    print("api:", api_url, "healthy:" if api_healthy(api_url) else
          "down:")
    try:
        code, body = http_json("GET", api_url + "/api/v1/setup/status",
                               timeout=5)
        print("initialized:", body.get("initialized")
              if code == 200 else "?")
    except Exception:
        print("initialized: ? (api down)")
    print("web:", web_url)
    return 0


def cmd_logs(args):
    del args
    for name in ("bootstrap", "server", "health", "errors"):
        print("=== logs/%s ===" % name)
        directory = LOGS / name if name != "bootstrap" else LOGS / name
        files = sorted(directory.glob("*"), reverse=True)[:1] \
            if directory.is_dir() else []
        if not files:
            print("(empty)")
            continue
        lines = files[0].read_text(encoding="utf-8",
                                   errors="replace").splitlines()
        for line in lines[-15:]:
            print(line)
    return 0


def cmd_stop(args):
    del args
    run_id = new_run_id()
    ctx = Ctx(run_id, LOGS / "bootstrap" / ("%s.log" % run_id))
    try:
        stop_service("backend", ctx)
        stop_service("frontend", ctx)
        return 0
    finally:
        ctx.close()


def cmd_reset_dev(args):
    values = parse_env_file(ROOT / ".env")
    if values.get("APKFORGE_ENV") == "prod":
        print("REFUSED: APKFORGE_ENV=prod — reset-dev never touches "
              "production", file=sys.stderr)
        return 1
    if not args.yes:
        print("reset-dev deletes the local database and runtime state.",
              file=sys.stderr)
        print("re-run with --yes to confirm (secrets in .env are "
              "backed up, never deleted).", file=sys.stderr)
        return 1
    run_id = new_run_id()
    ctx = Ctx(run_id, LOGS / "bootstrap" / ("%s.log" % run_id))
    try:
        stop_service("backend", ctx)
        stop_service("frontend", ctx)
        env_path = ROOT / ".env"
        if env_path.is_file():
            backup = ROOT / (".env.bak.%s" % run_id)
            shutil.copyfile(env_path, backup)
            ctx.say("backed up .env → %s" % backup.name)
        data_dir = ROOT / values.get("APKFORGE_DATA", "data")
        if data_dir.is_dir():
            shutil.rmtree(data_dir)
            ctx.say("removed %s" % data_dir)
        for stale in ("backend.pid", "frontend.pid", "npm.json",
                      "bootstrap-state.json"):
            (GOV / stale).unlink(missing_ok=True)
        ctx.say("reset-dev complete; re-run ./apkforge to rebuild")
        return 0
    finally:
        ctx.close()


def build_parser():
    parser = argparse.ArgumentParser(
        prog="apkforge", description="APKForge one-command bootstrap")
    parser.add_argument("--check", action="store_true",
                        help="audit only, change nothing")
    parser.add_argument("--plan", action="store_true",
                        help="print the adaptive plan and exit")
    parser.add_argument("--status", action="store_true",
                        help="show services + state, change nothing")
    parser.add_argument("--logs", action="store_true",
                        help="tail recent logs")
    parser.add_argument("--stop", action="store_true",
                        help="stop local services")
    parser.add_argument("--repair", action="store_true",
                        help="re-run pipeline, retry failed steps")
    parser.add_argument("--reset-dev", action="store_true",
                        help="guarded dev reset (needs --yes)")
    parser.add_argument("--yes", action="store_true",
                        help="confirm destructive actions")
    parser.add_argument("--skip-build", action="store_true",
                        help="reuse existing frontend/dist")
    parser.add_argument("--no-browser", action="store_true",
                        help="do not open a browser")
    parser.add_argument("--install-tools", action="store_true",
                        help="also fetch the optional apktool binary")
    parser.add_argument("--json", action="store_true",
                        help="machine-readable final report")
    parser.add_argument("command", nargs="?",
                        help="subcommand (update)")
    parser.add_argument("command_args", nargs=argparse.REMAINDER,
                        help="arguments for the subcommand")
    return parser


def main(argv=None):
    args = build_parser().parse_args(argv)
    load_local_path()
    if args.command == "gitcare":
        return cmd_gitcare(args)
    if args.command == "doctor":
        return cmd_doctor(args)
    if args.command == "recover":
        return cmd_recover(args)
    if args.command == "update":
        import importlib.util as _ilu
        _spec = _ilu.spec_from_file_location(
            "apkforge_update",
            Path(__file__).resolve().parent / "update.py")
        _mod = _ilu.module_from_spec(_spec)
        _spec.loader.exec_module(_mod)
        return _mod.main(args.command_args)
    if args.command is not None:
        build_parser().error(
            "unknown command %r (try: update, gitcare, doctor, recover)" % args.command)
    if args.check:
        return cmd_check(args)
    if args.plan:
        return cmd_plan(args)
    if args.status:
        return cmd_status(args)
    if args.logs:
        return cmd_logs(args)
    if args.stop:
        return cmd_stop(args)
    if args.reset_dev:
        return cmd_reset_dev(args)
    return run_pipeline(args)  # default + --repair


if __name__ == "__main__":
    raise SystemExit(main())
