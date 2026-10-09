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
          "READY", "FAILED")

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
        output = proc.stdout[-4000:]
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


def install_via_manager(ctx, package):
    manager, args = package_manager()
    if manager is None:
        raise RuntimeError("no system package manager found")
    if not can_elevate():
        raise RuntimeError(
            "package manager needs privileges (no passwordless sudo)")
    termux = manager == "pkg"
    if termux:
        code, _ = run(["pkg", "update"], ctx, timeout=300)
        if code != 0:
            ctx.warn("pkg update failed; trying install anyway")
    prefix = [] if (termux or (hasattr(os, "geteuid")
                              and os.geteuid() == 0)) \
        else ["sudo", "-n"]
    code, output = run(prefix + args + [package], ctx, timeout=600)
    if code != 0:
        raise RuntimeError("%s failed: %s" % (manager, output[-300:]))


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
                install_via_manager(ctx, pkg)
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
    GOV.mkdir(parents=True, exist_ok=True)
    target = GOV / "requirements-minimal.txt"
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
    }
    return hints.get(category, ["see the log tail, fix the "
                                "cause, re-run"])


def pip_install_with_recovery(ctx, python, req_path, fp, profile,
                              ledger, env_hash, offline):
    """pip install across the strategy ladder (never repeats)."""
    LOGS.mkdir(parents=True, exist_ok=True)
    cache_dir = ROOT / ".cache" / "apkforge"
    attempts = []
    last = {"category": "-", "package": None, "evidence": []}
    retry_key = "|".join([
        env_hash,
        "c" if profile.get("compiler_c") else "C",
        "r" if profile.get("compiler_rust") else "R"])

    def attempt(strategy, argv, timeout=900):
        sig = _recovery.failure_signature(
            "DEPENDENCIES", last["category"], last["package"],
            strategy, retry_key)
        if ledger.attempted("DEPENDENCIES", sig, strategy):
            ctx.say("skip %s (already failed identically)"
                    % strategy)
            return None
        ctx.say("pip attempt [%s]" % strategy)
        code, output = run([str(python), "-m", "pip"] + argv,
                           ctx, timeout=timeout)
        ledger.record("DEPENDENCIES", sig, strategy,
                      "pip " + " ".join(argv), retry_key,
                      "ok" if code == 0 else "failed",
                      "" if code == 0 else output[-300:])
        attempts.append(strategy)
        if code == 0:
            ctx.recovered(strategy, "pip install succeeded")
            return True
        classified = _recovery.classify_failure(output)
        if ctx.state != "RECOVERING":
            ctx.step("RECOVERING")
        last.update(category=classified["category"],
                    package=classified["package"],
                    evidence=classified["evidence"])
        ctx.warn("attempt %s failed: %s (%s)" % (
            strategy, classified["root_cause"],
            classified["category"]))
        (LOGS / ("pip-%s-%s.log" % (
            ctx.run_id, strategy.replace(":", "-")))
         ).write_text(redact(output), encoding="utf-8")
        ctx.say(_recovery.full_diagnostic({
            "step": "DEPENDENCIES",
            "package": classified["package"] or "-",
            "python": fp.get("python_version", "?"),
            "platform": profile.get("platform", "?"),
            "arch": fp.get("arch_machine", "?"),
            "method": "pip " + " ".join(argv),
            "category": classified["category"],
            "root_cause": classified["root_cause"],
            "command": "pip " + " ".join(argv),
            "evidence": classified["evidence"],
            "alternatives": _recovery_alternatives(
                classified["category"], classified["package"],
                profile, fp),
            "attempts": list(attempts),
            "next_strategy": "next ladder step"}))
        return False

    if offline:
        done = attempt("cache-only",
                       ["install", "--no-index",
                        "--find-links",
                        str(cache_dir / "wheels"), "-r",
                        str(req_path)])
        if done:
            return attempts
    else:
        if attempt("native", ["install", "-r", str(req_path)]):
            return attempts
    if last["category"] in ("NETWORK_FAILURE", "DNS_FAILURE"):
        for num in (2, 3):
            time.sleep(2 * num)
            done = attempt("retry-%d" % num,
                           ["install", "-r", str(req_path)])
            if done:
                return attempts
            if done is None or last["category"] not in (
                    "NETWORK_FAILURE", "DNS_FAILURE"):
                break
    if last["category"] in ("RUST_MISSING", "COMPILER_MISSING",
                            "BUILD_TOOL_MISSING"):
        need = set(_compat.NATIVE_INDEX.get(
            (last["package"] or "").lower().replace("_", "-"),
            {}).get("build", []))
        if last["category"] == "RUST_MISSING":
            need.add("rust")
        if last["category"] == "COMPILER_MISSING":
            need.add("c")
        need -= {"c-optional", "unknown-toolchain"}
        if not need:
            need = {"c"}
        if _provision_toolchains(ctx, need, ledger, env_hash,
                                 profile, offline):
            if attempt("toolchain:%s" % "+".join(sorted(need)),
                       ["install", "-r", str(req_path)]):
                return attempts
    if last["package"] and not offline and last["category"] in (
            "WHEEL_UNAVAILABLE", "PYTHON_INCOMPATIBILITY",
            "BUILD_TOOL_MISSING", "RUST_MISSING",
            "COMPILER_MISSING"):
        norm = last["package"].lower().replace("_", "-")
        newer = _newer_with_wheels(norm, fp, cache_dir)
        if newer:
            ctx.say("compatible release with wheels: %s==%s"
                    % (norm, newer))
            if attempt("compatible-bump",
                       ["install", "%s==%s" % (norm, newer),
                        "-r", str(req_path)]):
                return attempts
    if _is_extras_failure(last["package"]):
        minimal = _write_minimal_requirements(ctx, req_path)
        if minimal is not None and attempt(
                "minimal-core", ["install", "-r",
                                 str(minimal)]):
            ctx.warn("SAFE FALLBACK active: running without "
                     "uvicorn[standard] extras (see "
                     ".governance/requirements-minimal.txt)")
            return attempts
    if last["category"] == "PERMISSION_FAILURE":
        sig = _recovery.failure_signature(
            "DEPENDENCIES", "PERMISSION_FAILURE", "-", "recreate",
            env_hash)
        if not ledger.attempted("DEPENDENCIES", sig, "recreate"):
            ctx.warn("venv permissions broken → recreating "
                     "(CAUTION)")
            shutil.rmtree(VENV, ignore_errors=True)
            code, output = run([sys.executable, "-m", "venv",
                                str(VENV)], ctx, timeout=300)
            ledger.record("DEPENDENCIES", sig, "recreate",
                          "venv recreate", env_hash,
                          "ok" if code == 0 else "failed",
                          "" if code == 0 else output[-200:])
            if code == 0 and attempt(
                    "venv-recreated",
                    ["install", "-r", str(req_path)]):
                return attempts
    if last["category"] == "DISK_SPACE":
        run([str(python), "-m", "pip", "cache", "purge"], ctx,
            timeout=120)
        if attempt("after-purge",
                   ["install", "-r", str(req_path)]):
            return attempts
    if not attempts:
        prior = [entry for entry in ledger.entries()
                 if entry.get("step") == "DEPENDENCIES"]
        raise RecoveryExhausted({
            "step": "DEPENDENCIES", "package": "-",
            "category": last["category"],
            "root_cause": "every strategy already failed "
            "identically for this environment; fix the cause "
            "below, then re-run",
            "tried": [{"strategy": entry.get("strategy"),
                       "result": entry.get("result")}
                      for entry in prior[-8:]],
            "required": "a changed environment (new toolchain, "
            "new pins) or a manual fix",
            "next_action": "inspect %s, fix the recorded "
            "cause, then re-run" % ledger.path,
            "ledger": str(ledger.path)})
    info = {"step": "DEPENDENCIES",
            "package": last["package"] or "-",
            "category": last["category"],
            "root_cause": "last attempt failed: %s" % last[
                "category"],
            "tried": [{"strategy": name, "result": "failed"}
                      for name in attempts],
            "required": "manual fix for %s" % last["category"],
            "next_action": "; ".join(_recovery_alternatives(
                last["category"], last["package"], profile,
                fp)[:2]),
            "ledger": str(ledger.path)}
    raise RecoveryExhausted(info)


def ensure_venv(ctx, offline, fp, profile, ledger, env_hash):
    """Validate/create/repair the venv, then install with recovery."""
    python = _venv_python()
    if python.is_file():
        ok, reason = validate_venv(ctx, python)
        if ok and _backend_imports_ok(ctx, python):
            ctx.say("backend deps present → skip install")
            return python
        if not ok:
            sig = _recovery.failure_signature(
                "RUNTIME", "BROKEN", "venv", "recreate",
                env_hash)
            if ledger.attempted("RUNTIME", sig, "recreate"):
                raise RuntimeError(
                    "venv recreate already failed once "
                    "(%s); delete .venv manually" % reason)
            ctx.warn("venv invalid (%s) → recreating (CAUTION)"
                     % reason)
            shutil.rmtree(VENV, ignore_errors=True)
            ledger.record("RUNTIME", sig, "recreate",
                          "rm -rf .venv", env_hash, "ok", reason)
            python = _venv_python()
        else:
            ctx.say("venv valid but deps missing → install")
    if not python.is_file():
        ctx.say("creating virtualenv .venv")
        code, output = run([sys.executable, "-m", "venv",
                            str(VENV)], ctx, timeout=300)
        if code != 0:
            raise RuntimeError("venv failed: %s" % output[-300:])
        python = _venv_python()
    req = ROOT / "backend" / "requirements.txt"
    lock = GOV / "requirements.lock"
    if offline and lock.is_file():
        ctx.say("offline: installing from locked resolution")
        req = lock
    pip_install_with_recovery(ctx, python, req, fp, profile,
                              ledger, env_hash, offline)
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
            ".venv/bin/python -c 'import fastapi, uvicorn, "
            "pydantic'",
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
    try:
        opened = webbrowser.open(url, new=2)
    except Exception as exc:
        ctx.say("browser: %s" % exc)
        return False
    ctx.say("browser: %s" % ("opened " + url if opened else
                             "headless — open manually: " + url))
    return opened


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
    python = _venv_python()
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
    venv_python = _venv_python()
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
        full = final_report(ctx, report, urls, True)
        write_governance(ctx, env, urls, full)
        print_banner(ctx, report, urls, initialized)
        if args.json:
            print(json.dumps(full, indent=2, default=str))
        return 0
    except RecoveryExhausted as exc:
        if ctx.state != "BLOCKED":
            ctx.step("BLOCKED")
        info = exc.info
        block = _recovery.exhausted_report(info)
        ctx.say(block)
        (LOGS / "errors").mkdir(exist_ok=True)
        (LOGS / "errors" / ("%s.log" % run_id)).write_text(
            redact(block), encoding="utf-8")
        record_failure(ctx, info.get("step", "?"), "pipeline",
                       info.get("root_cause", "?"),
                       info.get("next_action", "?"))
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
            "unknown command %r (try: update, gitcare)" % args.command)
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
