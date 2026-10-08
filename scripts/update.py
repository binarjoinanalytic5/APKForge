#!/usr/bin/env python3
"""APKForge update engine (standard library only).

One engine, two triggers: ``./apkforge update`` (foreground) and the
admin API ``POST /api/v1/admin/updates/apply`` (detached runner).

Pipeline: check -> guards -> download(resumable) -> verify(size,
checksum, signature, source, compat, disk) -> verified backup ->
maintenance ON -> install -> migrate -> restart -> health ->
maintenance OFF. Any failure after the backup triggers a real
rollback (code + database + config), never a half-updated system.
"""
from __future__ import annotations

import argparse
import hashlib
import hmac
import json
import os
import shutil
import sqlite3
import subprocess
import sys
import tarfile
import tempfile
import time
import urllib.error
import urllib.request
import zipfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
DEFAULT_ROOT = HERE.parent

CHANNELS = ("STABLE", "BETA", "DEV")
ACTIVE_JOB = ("queued", "running")
BACKUP_KEEP = 5
FORBIDDEN_TOPS = {".env", "data", ".git", ".governance", "logs",
                  ".tools", ".venv", "backups"}
CHUNK = 1024 * 256


class UpdateEngineError(RuntimeError):
    """Every engine failure raises this (message is user-facing)."""


# -- version + manifest primitives (single implementation lives in --
# -- backend/app/core/updates.py; tiny fallback below if missing)  --
try:
    sys.path.insert(0, str(DEFAULT_ROOT / "backend"))
    from app.core.updates import (compare_versions as _cmp,
                                  evaluate as _evaluate,
                                  validate_manifest as _validate)
    _CORE = True
    from app.core.notify import validate as _note_priority
except Exception:  # pragma: no cover - backend missing
    _CORE = False

    def _parse(version):
        parts = str(version or "").split(".")
        if len(parts) != 3 or not all(
                item.isdigit() for item in parts):
            raise UpdateEngineError(
                "bad version %r" % (version,))
        return tuple(int(item) for item in parts)

    def _cmp(left, right):
        ours, theirs = _parse(left), _parse(right)
        return (ours > theirs) - (ours < theirs)

    def _evaluate(current, latest, mandatory=False, minimum=None):
        if _cmp(current, latest) >= 0:
            return "NO_UPDATE"
        if mandatory or (minimum is not None and
                         _cmp(current, minimum) < 0):
            return "MANDATORY_UPDATE"
        return "UPDATE_AVAILABLE"

    def _validate(manifest):
        if not isinstance(manifest, dict) or \
                not manifest.get("latest_version"):
            raise UpdateEngineError("bad manifest")
        _parse(manifest["latest_version"])
        return dict(manifest)

    _PRIORITY = {"SYSTEM_ANNOUNCEMENT": 1,
                 "FEATURE_RELEASE": 1, "UPDATE_AVAILABLE": 2,
                 "MAINTENANCE": 2, "SECURITY_UPDATE": 3,
                 "MANDATORY_UPDATE": 3}

    def _note_priority(ntype, severity="info"):
        if severity == "critical":
            return 3
        return _PRIORITY.get(ntype, 1)


def say(text):
    print(text, flush=True)


def _now():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())


def parse_env_file(path):
    values = {}
    try:
        text = Path(path).read_text(encoding="utf-8")
    except OSError:
        return values
    for line in text.splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        key = key.strip()
        value = value.strip().strip("'").strip('"')
        if key:
            values[key] = value
    return values


def current_version(root):
    try:
        text = (root / "VERSION").read_text(
            encoding="utf-8").strip()
    except OSError:
        return "0.0.0"
    return text or "0.0.0"


def db_path_for(root, env=None):
    env = env if env is not None else parse_env_file(root / ".env")
    raw = env.get("APKFORGE_DB", "data/apkforge.db")
    path = Path(raw)
    return path if path.is_absolute() else root / raw


def connect_db(root):
    path = db_path_for(root)
    if not path.is_file():
        return None
    conn = sqlite3.connect(str(path))
    conn.row_factory = sqlite3.Row
    return conn


def get_setting(conn, key, default=None):
    try:
        row = conn.execute(
            "SELECT value FROM system_config WHERE key=?",
            (key,)).fetchone()
    except sqlite3.Error:
        return default
    return row["value"] if row else default


def set_setting(conn, key, value):
    conn.execute("CREATE TABLE IF NOT EXISTS system_config ("
                 "key TEXT PRIMARY KEY, value TEXT NOT NULL, "
                 "updated_at TEXT NOT NULL)")
    conn.execute("INSERT OR REPLACE INTO system_config "
                 "VALUES (?,?,?)", (key, value, _now()))
    conn.commit()


def active_jobs(conn):
    try:
        row = conn.execute(
            "SELECT COUNT(*) AS n FROM jobs WHERE status IN (?,?)",
            ACTIVE_JOB).fetchone()
    except sqlite3.Error:
        return 0
    return int(row["n"])


def latest_published(conn, channel):
    rank = {name: index for index, name in enumerate(CHANNELS)}
    wanted = rank.get(channel, 0)
    try:
        rows = conn.execute(
            "SELECT * FROM releases WHERE status='published' "
            "ORDER BY version_code DESC").fetchall()
    except sqlite3.Error:
        return None
    for row in rows:
        if rank.get(row["channel"], 0) <= wanted:
            return dict(row)
    return None


def release_by_version(conn, version):
    try:
        row = conn.execute(
            "SELECT * FROM releases WHERE version=?", (version,),
            ).fetchone()
    except sqlite3.Error:
        return None
    return dict(row) if row else None


def release_to_manifest(row):
    manifest = {
        "latest_version": row["version"],
        "version_code": row["version_code"],
        "release_type": row["release_type"],
        "channel": row["channel"],
        "mandatory": bool(row["mandatory"]),
        "security_update": bool(row["security_update"]),
        "artifact_kind": row["artifact_kind"],
        "security_notes": _as_list(row["security_notes"]),
        "release_notes": _as_list(row["release_notes"]),
        "breaking_changes": _as_list(row["breaking_changes"]),
        "migration_required": bool(row["migration_required"]),
        "restart_required": bool(row["restart_required"]),
        "release_date": row["release_date"],
        "published_at": row["published_at"],
        "size_bytes": row["size_bytes"],
    }
    if row["minimum_supported_version"]:
        manifest["minimum_supported_version"] = \
            row["minimum_supported_version"]
    if row["artifact_kind"] == "bundle":
        manifest["download_url"] = row["download_url"]
        manifest["checksum"] = row["checksum"]
        manifest["signature"] = row["signature"]
    else:
        manifest["artifact_ref"] = row["artifact_ref"]
    return manifest


def _as_list(raw):
    if not raw:
        return []
    try:
        value = json.loads(raw)
    except ValueError:
        return []
    return value if isinstance(value, list) else []


# -- manifest resolution (local DB default, remote URL override) ----
def fetch_manifest(url, root):
    """GET a remote manifest with ETag cache + offline fallback."""
    cache_path = root / ".governance" / "manifest-cache.json"
    cached = {}
    if cache_path.is_file():
        try:
            cached = json.loads(cache_path.read_text(
                encoding="utf-8"))
        except ValueError:
            cached = {}
    if url.startswith("file://"):
        body = Path(url[7:]).read_bytes()
        return _validate(json.loads(body.decode("utf-8")))
    headers = {}
    if cached.get("etag") and cached.get("url") == url \
            and cached.get("body"):
        headers["If-None-Match"] = cached["etag"]
    request = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(request,
                                    timeout=20) as response:
            if response.status == 304 and cached.get("body"):
                return _validate(cached["body"])
            body = json.loads(response.read().decode("utf-8"))
            manifest = _validate(body)
            etag = response.headers.get("ETag")
            cache_path.parent.mkdir(parents=True, exist_ok=True)
            cache_path.write_text(json.dumps(
                {"url": url, "etag": etag, "body": body,
                 "fetched_at": _now()}), encoding="utf-8")
            return manifest
    except urllib.error.HTTPError as exc:
        if exc.code == 304 and cached.get("body"):
            return _validate(cached["body"])
        raise UpdateEngineError(
            "manifest http %s" % exc.code)
    except (urllib.error.URLError, TimeoutError, OSError) as exc:
        if cached.get("body") and cached.get("url") == url:
            say("تحذير: تعذر الوصول للخادم، أستخدم نسخة مخزنة")
            return _validate(cached["body"])
        raise UpdateEngineError("manifest unreachable: %s" % exc)


def resolve_manifest(root, version=None, manifest_url=None,
                     channel=None):
    if manifest_url:
        manifest = fetch_manifest(manifest_url, root)
        if version is not None and \
                manifest["latest_version"] != version:
            raise UpdateEngineError(
                "remote manifest is %s, not %s"
                % (manifest["latest_version"], version))
        return manifest
    conn = connect_db(root)
    if conn is None:
        raise UpdateEngineError("no local database and no "
                                "--manifest-url (nothing to check)")
    try:
        if channel is None:
            channel = get_setting(conn, "system.channel",
                                  "STABLE")
        if version is not None:
            row = release_by_version(conn, version)
            if not row or row["status"] != "published":
                raise UpdateEngineError(
                    "no published release %r" % (version,))
        else:
            row = latest_published(conn, channel)
            if row is None:
                raise UpdateEngineError(
                    "no published release on %s" % (channel,))
        return _validate(release_to_manifest(row))
    finally:
        conn.close()


def check(root, version=None, manifest_url=None, channel=None):
    current = current_version(root)
    manifest = resolve_manifest(root, version, manifest_url,
                                channel)
    status = _evaluate(
        current, manifest["latest_version"],
        mandatory=manifest.get("mandatory", False),
        minimum=manifest.get("minimum_supported_version"))
    return {"status": status, "current_version": current,
            "channel": channel or manifest.get("channel"),
            "manifest": manifest}


# -- download (resumable) + verification -----------------------------
def download(url, dest, expected_size=None, progress=None,
             retries=3):
    dest = Path(dest)
    dest.parent.mkdir(parents=True, exist_ok=True)
    if url.startswith("file://"):
        src = Path(url[7:])
        if not src.is_file():
            raise UpdateEngineError("artifact not found: %s" % url)
        total = src.stat().st_size
        have = dest.stat().st_size if dest.is_file() else 0
        if have > total:
            have = 0
        with open(src, "rb") as handle_in, open(
                dest, "ab" if have else "wb") as handle_out:
            handle_in.seek(have)
            while True:
                chunk = handle_in.read(CHUNK)
                if not chunk:
                    break
                handle_out.write(chunk)
                have += len(chunk)
                if progress:
                    progress(have, total)
        if expected_size is not None and have != expected_size:
            raise UpdateEngineError(
                "size mismatch: got %d want %d" % (have,
                                                  expected_size))
        return have
    if not url.startswith(("https://", "http://")):
        raise UpdateEngineError("refusing unsafe url %r" % (url,))
    attempt = 0
    while True:
        try:
            return _download_http(url, dest, expected_size,
                                  progress)
        except (urllib.error.URLError, TimeoutError,
                OSError) as exc:
            attempt += 1
            if attempt > retries:
                raise UpdateEngineError(
                    "download failed after %d tries: %s"
                    % (retries, exc))
            time.sleep(2 * attempt)


def _download_http(url, dest, expected_size, progress):
    have = dest.stat().st_size if dest.is_file() else 0
    headers = {"Range": "bytes=%d-" % have} if have else {}
    request = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(request,
                                timeout=60) as response:
        if have and response.status != 206:
            have = 0  # server ignored Range: restart cleanly
        total = response.headers.get("Content-Length")
        total = (int(total) + have) if total else None
        mode = "ab" if have else "wb"
        with open(dest, mode) as handle:
            while True:
                chunk = response.read(CHUNK)
                if not chunk:
                    break
                handle.write(chunk)
                have += len(chunk)
                if progress:
                    progress(have, total)
    if expected_size is not None and have != expected_size:
        raise UpdateEngineError(
            "size mismatch: got %d want %d" % (have,
                                              expected_size))
    return have


def sha256_file(path):
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        while True:
            chunk = handle.read(CHUNK)
            if not chunk:
                break
            digest.update(chunk)
    return digest.hexdigest()


def verify_artifact(path, manifest, key):
    """Size + checksum + HMAC signature. All must pass."""
    size = Path(path).stat().st_size
    want_size = manifest.get("size_bytes")
    if want_size is not None and size != want_size:
        raise UpdateEngineError(
            "size mismatch: got %d want %d" % (size, want_size))
    digest = sha256_file(path)
    if digest != (manifest.get("checksum") or "").lower():
        raise UpdateEngineError("checksum mismatch (corrupt or "
                                "tampered artifact)")
    signature = manifest.get("signature") or ""
    if not signature:
        raise UpdateEngineError("manifest has no signature")
    if not key:
        raise UpdateEngineError(
            "cannot verify signature: set APKFORGE_UPDATE_KEY")
    data = Path(path).read_bytes()
    expected = hmac.new(key.encode("utf-8"), data,
                        hashlib.sha256).hexdigest()
    if not hmac.compare_digest(expected, signature.lower()):
        raise UpdateEngineError("signature mismatch (untrusted "
                                "artifact)")
    return digest


# -- guards -----------------------------------------------------------
def guard_all(root, manifest, force=False):
    conn = connect_db(root)
    try:
        if conn is not None:
            busy = active_jobs(conn)
            if busy and not force:
                raise UpdateEngineError(
                    "%d job(s) still active; finish or retry "
                    "with --force" % (busy,))
    finally:
        if conn is not None:
            conn.close()
    need = int(manifest.get("size_bytes") or 0)
    free = shutil.disk_usage(str(root)).free
    required = max(need * 2, 100 * 1024 * 1024)
    if free < required:
        raise UpdateEngineError(
            "disk too full: free %dMB need %dMB"
            % (free // (1024 * 1024),
               required // (1024 * 1024)))


# -- state, lock, audit, maintenance ----------------------------------
def state_path(root):
    return root / ".governance" / "update-state.json"


def write_state(root, **fields):
    path = state_path(root)
    path.parent.mkdir(parents=True, exist_ok=True)
    current = {}
    if path.is_file():
        try:
            current = json.loads(path.read_text(
                encoding="utf-8"))
        except ValueError:
            current = {}
    current.update(fields)
    current["updated_at"] = _now()
    path.write_text(json.dumps(current, indent=2),
                    encoding="utf-8")
    return current


def read_state(root):
    path = state_path(root)
    if not path.is_file():
        return {"state": "IDLE", "run_id": None, "locked": False}
    try:
        state = json.loads(path.read_text(encoding="utf-8"))
    except ValueError:
        return {"state": "UNKNOWN", "run_id": None,
                "locked": False}
    state["locked"] = lock_holder(root) is not None
    return state


def lock_path(root):
    return root / ".governance" / "update.lock"


def lock_holder(root):
    path = lock_path(root)
    if not path.is_file():
        return None
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
        pid = int(data.get("pid", 0))
    except (ValueError, TypeError):
        path.unlink(missing_ok=True)
        return None
    try:
        os.kill(pid, 0)
    except OSError:
        path.unlink(missing_ok=True)
        return None
    return data


def acquire_lock(root, run_id):
    holder = lock_holder(root)
    if holder is not None:
        raise UpdateEngineError("update already running (run %s)"
                                % holder.get("run_id", "?"))
    lock_path(root).parent.mkdir(parents=True, exist_ok=True)
    lock_path(root).write_text(json.dumps(
        {"run_id": run_id, "pid": os.getpid(),
         "started_at": _now()}), encoding="utf-8")


def release_lock(root, run_id):
    holder = lock_holder(root)
    if holder is not None and holder.get("run_id") == run_id:
        lock_path(root).unlink(missing_ok=True)


def append_audit(root, action, target="", result="ok",
                 detail=None):
    conn = connect_db(root)
    if conn is None:
        return
    try:
        conn.execute(
            "INSERT INTO audit (ts, actor, action, target, result,"
            " detail) VALUES (?,?,?,?,?,?)",
            (_now(), "update-engine", action, target, result,
             json.dumps(detail or {})))
        conn.commit()
    except sqlite3.Error as exc:
        say("تحذير: تعذر كتابة التدقيق: %s" % exc)
    finally:
        conn.close()


def broadcast(root, ntype, title, message, severity="info"):
    conn = connect_db(root)
    if conn is None:
        return
    try:
        try:
            priority = _note_priority(ntype, severity)
        except Exception:
            priority = 1
        conn.execute(
            "INSERT INTO notifications (id, ntype, severity,"
            " priority, title, message, action, target,"
            " created_at) VALUES (?,?,?,?,?,?,?,?,?)",
            ("notif-%s"
             % hashlib.sha256(("%s%s" % (ntype,
                                        time.time())).encode()
                              ).hexdigest()[:12],
             ntype, severity, priority, title, message, "{}",
             "all", _now()))
        conn.commit()
    except sqlite3.Error as exc:
        say("تحذير: تعذر بث الإشعار: %s" % exc)
    finally:
        conn.close()


def set_maintenance(root, active, message=""):
    conn = connect_db(root)
    if conn is None:
        return
    try:
        set_setting(conn, "maintenance.active",
                    "true" if active else "false")
        set_setting(conn, "maintenance.message", message)
    finally:
        conn.close()


# -- backup + restore --------------------------------------------------
def registry_path(root):
    return root / ".governance" / "backups.json"


def read_registry(root):
    path = registry_path(root)
    if not path.is_file():
        return {"backups": []}
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except ValueError:
        return {"backups": []}
    return data if isinstance(data, dict) else {"backups": []}


def write_registry(root, data):
    path = registry_path(root)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, indent=2), encoding="utf-8")


def create_backup(root, version_from, version_to, kind,
                  members=(), git_sha=None):
    stamp = time.strftime("%Y%m%d-%H%M%S", time.localtime())
    backup_id = "bu-%s" % stamp
    target = root / ".governance" / "backups" / backup_id
    state_dir = target / "state"
    state_dir.mkdir(parents=True, exist_ok=True)
    saved = []
    for name in ("VERSION", ".env"):
        src = root / name
        if src.is_file():
            shutil.copyfile(src, state_dir / name)
            saved.append(name)
    db_path = db_path_for(root)
    db_digest = None
    if db_path.is_file():
        shutil.copyfile(db_path, state_dir / "apkforge.db")
        db_digest = sha256_file(db_path)
        live = sha256_file(state_dir / "apkforge.db")
        if live != db_digest:
            raise UpdateEngineError("backup failed: db copy "
                                    "corrupt")
        saved.append("apkforge.db")
    if kind == "bundle" and members:
        archive = target / "code.tar.gz"
        with tarfile.open(archive, "w:gz") as tar:
            for member in sorted(set(members)):
                src = root / member
                if src.exists():
                    tar.add(src, arcname=member)
        with tarfile.open(archive, "r:gz") as tar:  # verify
            tar.getmembers()
        saved.append("code.tar.gz")
    meta = {"id": backup_id, "created_at": _now(),
            "version_from": version_from,
            "version_to": version_to, "kind": kind,
            "git_sha": git_sha, "members": sorted(set(members)),
            "files": saved, "db_sha256": db_digest,
            "rollback_command":
                "./apkforge update --rollback %s" % backup_id}
    (target / "meta.json").write_text(json.dumps(meta, indent=2),
                                      encoding="utf-8")
    registry = read_registry(root)
    backups = [entry for entry in registry.get("backups", [])
               if entry.get("id") != backup_id]
    backups.insert(0, meta)
    for stale in backups[BACKUP_KEEP:]:
        shutil.rmtree(root / ".governance" / "backups"
                      / stale.get("id", "missing"),
                      ignore_errors=True)
    del backups[BACKUP_KEEP:]
    write_registry(root, {"backups": backups})
    return meta


def restore_backup(root, backup_id):
    target = root / ".governance" / "backups" / backup_id
    meta_path = target / "meta.json"
    if not meta_path.is_file():
        raise UpdateEngineError("backup %r not found"
                                % (backup_id,))
    meta = json.loads(meta_path.read_text(encoding="utf-8"))
    if meta.get("kind") == "git" and meta.get("git_sha"):
        run_git(root, "checkout", meta["git_sha"])
    archive = target / "code.tar.gz"
    if archive.is_file():
        # Exact restore: remove the replaced tops first so files
        # added by the failed update do not linger (git-kind is
        # exact via checkout; this makes bundles exact too).
        for member in meta.get("members", []):
            _remove_top(root, member)
        _extract_safe(archive, root)
    state_dir = target / "state"
    for name in ("VERSION", ".env", "apkforge.db"):
        src = state_dir / name
        if not src.is_file():
            continue
        dest = root / name if name != "apkforge.db" else \
            db_path_for(root)
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(src, dest)
    if meta.get("db_sha256"):
        digest = sha256_file(db_path_for(root))
        if digest != meta["db_sha256"]:
            raise UpdateEngineError("rollback failed: db "
                                    "restore corrupt")
    return meta


def _remove_top(root, member):
    if not member or ".." in Path(member).parts:
        raise UpdateEngineError("unsafe backup member %r"
                                % (member,))
    if Path(member).is_absolute():
        raise UpdateEngineError("unsafe backup member %r"
                                % (member,))
    if Path(member).parts[0] in FORBIDDEN_TOPS:
        raise UpdateEngineError("unsafe backup member %r"
                                % (member,))
    target = root / member
    if target.is_dir() and not target.is_symlink():
        shutil.rmtree(target)
    elif target.is_file() or target.is_symlink():
        target.unlink()


def _extract_safe(archive, root):
    with tarfile.open(archive, "r:gz") as tar:
        for member in tar.getmembers():
            path = Path(member.name)
            if path.is_absolute() or ".." in path.parts:
                raise UpdateEngineError(
                    "unsafe backup member %r" % (member.name,))
            if path.parts and path.parts[0] in FORBIDDEN_TOPS:
                raise UpdateEngineError(
                    "unsafe backup member %r" % (member.name,))
        tar.extractall(str(root))


# -- install -----------------------------------------------------------
def run_git(root, *argv):
    proc = subprocess.run(
        ["git", "-C", str(root)] + list(argv),
        stdout=subprocess.PIPE, stderr=subprocess.PIPE,
        text=True, timeout=120)
    if proc.returncode != 0:
        raise UpdateEngineError("git %s failed: %s"
                                % (argv[0], proc.stderr.strip()))
    return proc.stdout.strip()


def install_git(root, ref, force=False):
    if not shutil.which("git"):
        raise UpdateEngineError("git is not installed")
    previous = run_git(root, "rev-parse", "HEAD")
    if run_git(root, "rev-parse", "--verify", "--quiet",
               "%s^{commit}" % ref) == "":
        raise UpdateEngineError("unknown git ref %r" % (ref,))
    dirty = run_git(root, "status", "--porcelain",
                    "--untracked-files=no")
    if dirty and not force:
        raise UpdateEngineError("worktree has local changes; "
                                "commit or retry with --force")
    run_git(root, "checkout", ref)
    return previous


def install_bundle(root, archive, manifest):
    archive = Path(archive)
    with zipfile.ZipFile(archive) as bundle:
        names = bundle.namelist()
        tops = set()
        for name in names:
            path = Path(name)
            if path.is_absolute() or ".." in path.parts:
                raise UpdateEngineError(
                    "unsafe bundle entry %r" % (name,))
            if path.parts:
                tops.add(path.parts[0])
        if tops & FORBIDDEN_TOPS:
            raise UpdateEngineError(
                "bundle touches protected paths: %s"
                % sorted(tops & FORBIDDEN_TOPS))
        if "VERSION" not in names or "backend/" not in [
                name for name in names if name.endswith("/")
                ] and not any(name.startswith("backend/")
                              for name in names):
            raise UpdateEngineError(
                "bundle must contain VERSION + backend/")
        tmp = Path(tempfile.mkdtemp(prefix="apkforge-update-"))
        try:
            bundle.extractall(str(tmp))
            inner = (tmp / "VERSION").read_text(
                encoding="utf-8").strip()
            if inner != manifest["latest_version"]:
                raise UpdateEngineError(
                    "bundle says %s, manifest says %s"
                    % (inner, manifest["latest_version"]))
            for entry in tmp.iterdir():
                dest = root / entry.name
                if entry.is_dir():
                    shutil.copytree(entry, dest,
                                    dirs_exist_ok=True)
                else:
                    shutil.copyfile(entry, dest)
        finally:
            shutil.rmtree(tmp, ignore_errors=True)
    for cache in root.rglob("__pycache__"):
        if ".venv" not in cache.parts:
            shutil.rmtree(cache, ignore_errors=True)
    return sorted(tops)


# -- migrate + restart + health ----------------------------------------
def migrate_db(root):
    sys.path.insert(0, str(root / "backend"))
    from app.core.migrations import migrate
    conn = sqlite3.connect(str(db_path_for(root)))
    try:
        return migrate(conn, root / "backend" / "migrations")
    finally:
        conn.close()


def stop_services(root):
    sys.path.insert(0, str(HERE))
    import apkforge as engine
    ctx = engine.Ctx("update-%d" % os.getpid(),
                     root / "logs" / "update" / "stop.log")
    try:
        stopped = []
        for name in ("backend", "frontend"):
            try:
                if engine.stop_service(name, ctx):
                    stopped.append(name)
            except Exception as exc:
                say("تحذير: تعذر إيقاف %s: %s" % (name, exc))
        return stopped
    finally:
        ctx.close()


def restart_pipeline(root, skip_build=False):
    argv = [sys.executable, str(HERE / "apkforge.py"),
           "--no-browser"]
    if skip_build:
        argv.append("--skip-build")
    proc = subprocess.run(argv, cwd=str(root), timeout=1500)
    return proc.returncode


def frontend_changed_git(root, previous):
    try:
        out = run_git(root, "diff", "--name-only", previous,
                      "HEAD", "--", "frontend")
        return bool(out.strip())
    except UpdateEngineError:
        return True


def api_base(root):
    env = parse_env_file(root / ".env")
    port = env.get("APKFORGE_PORT", "8000")
    return "http://127.0.0.1:%s" % port


def verify_version(root, target, tries=40):
    url = api_base(root) + "/api/v1/updates/current"
    last = None
    for _ in range(tries):
        try:
            request = urllib.request.Request(url)
            with urllib.request.urlopen(request,
                                        timeout=5) as response:
                body = json.loads(response.read().decode(
                    "utf-8"))
            last = body.get("version")
            if last == target:
                return True
        except Exception:
            last = None
        time.sleep(3)
    raise UpdateEngineError(
        "health FAILED: api reports %r, want %r"
        % (last, target))


# -- the run ------------------------------------------------------------
def run_update(root, run_id=None, version=None, manifest_url=None,
               channel=None, force=False):
    root = Path(root)
    stamp = time.strftime("%Y%m%d-%H%M%S", time.localtime())
    run_id = run_id or ("APKFORGE-%s-CLI" % stamp)
    acquire_lock(root, run_id)
    backup_id = None
    maintenance_on = False
    try:
        report = check(root, version, manifest_url, channel)
        manifest = report["manifest"]
        current = report["current_version"]
        latest = manifest["latest_version"]
        say("الإصدار الحالي: %s | المتاح: %s (%s)" % (
            current, latest, report["status"]))
        if report["status"] == "NO_UPDATE" and not force:
            write_state(root, state="NO_UPDATE", run_id=run_id,
                        version_from=current,
                        version_to=latest)
            return {"state": "NO_UPDATE", "run_id": run_id,
                    "version_from": current,
                    "version_to": latest}
        append_audit(root, "UPDATE_DETECTED", latest, "ok",
                     {"run_id": run_id,
                      "status": report["status"]})
        write_state(root, state="CHECKED", run_id=run_id,
                    version_from=current, version_to=latest)
        guard_all(root, manifest, force)
        kind = manifest.get("artifact_kind", "bundle")
        artifact = None
        if kind == "bundle":
            write_state(root, state="DOWNLOADING")
            say("تنزيل الحزمة...")
            tmp = root / ".governance" / "downloads"
            tmp.mkdir(parents=True, exist_ok=True)

            def progress(have, total):
                if total:
                    say("  %d%% (%d/%dKB)" % (
                        have * 100 // total, have // 1024,
                        total // 1024), )

            artifact = tmp / ("apkforge-%s.zip" % latest)
            download(manifest["download_url"], artifact,
                     manifest.get("size_bytes"), progress)
            append_audit(root, "UPDATE_DOWNLOADED", latest,
                         "ok", {"run_id": run_id})
            write_state(root, state="VERIFYING")
            say("التحقق من الحزمة (الحجم + البصمة + التوقيع)...")
            env = parse_env_file(root / ".env")
            key = env.get("APKFORGE_UPDATE_KEY") or \
                env.get("APKFORGE_KEY", "")
            verify_artifact(artifact, manifest, key)
            append_audit(root, "UPDATE_VERIFIED", latest, "ok",
                         {"run_id": run_id})
        git_sha = None
        if kind == "git":
            git_sha = run_git(root, "rev-parse", "HEAD")
        write_state(root, state="BACKING_UP")
        say("نسخ احتياطي متحقق قبل التحديث...")
        meta = create_backup(root, current, latest, kind,
                             members=_bundle_tops(artifact)
                             if artifact else (),
                             git_sha=git_sha)
        backup_id = meta["id"]
        say("تم النسخ: %s" % backup_id)
        write_state(root, state="BACKED_UP",
                    backup_id=backup_id)
        set_maintenance(root, True,
                        "تحديث النظام إلى %s" % latest)
        maintenance_on = True
        write_state(root, state="INSTALLING")
        say("تثبيت %s..." % latest)
        skip_build = False
        if kind == "git":
            previous = install_git(root,
                                   manifest["artifact_ref"],
                                   force)
            skip_build = not frontend_changed_git(root,
                                                  previous)
        else:
            install_bundle(root, artifact, manifest)
            skip_build = "frontend" not in _bundle_tops(
                artifact)
        write_state(root, state="MIGRATING")
        say("ترحيل قاعدة البيانات...")
        migrated = migrate_db(root)
        if migrated.get("applied"):
            say("ترحيلات مطبقة: %s"
                % ", ".join(migrated["applied"]))
        write_state(root, state="RESTARTING")
        say("إعادة تشغيل الخدمات...")
        stop_services(root)
        code = restart_pipeline(root, skip_build)
        if code != 0:
            raise UpdateEngineError(
                "service restart FAILED (pipeline exit %d)"
                % (code,))
        write_state(root, state="HEALTHY")
        say("فحص الصحة بعد التحديث...")
        verify_version(root, latest)
        set_maintenance(root, False)
        maintenance_on = False
        write_state(root, state="SUCCESS",
                    backup_id=backup_id)
        append_audit(root, "UPDATE_COMPLETED", latest, "ok",
                     {"run_id": run_id, "backup_id": backup_id,
                      "version_from": current})
        broadcast(root, "SYSTEM_ANNOUNCEMENT",
                  "اكتمل التحديث إلى %s" % latest,
                  "تم تثبيت الإصدار %s والتحقق من سلامته."
                  % latest)
        say("اكتمل التحديث إلى %s بنجاح" % latest)
        return {"state": "SUCCESS", "run_id": run_id,
                "version_from": current, "version_to": latest,
                "backup_id": backup_id}
    except Exception as exc:
        message = str(exc)
        say("فشل التحديث: %s" % message)
        write_state(root, state="FAILED", run_id=run_id,
                    error=message, backup_id=backup_id)
        append_audit(root, "UPDATE_FAILED",
                     version or "unknown", "error",
                     {"run_id": run_id, "error": message})
        if backup_id is not None:
            write_state(root, state="ROLLING_BACK")
            say("تراجع تلقائي إلى النسخة الاحتياطية...")
            try:
                stop_services(root)
                restore_backup(root, backup_id)
                code = restart_pipeline(root)
                if code != 0:
                    raise UpdateEngineError(
                        "restart after rollback FAILED")
                state = read_state(root)
                previous = (state.get("version_from")
                            or current_version(root))
                verify_version(root, previous)
                write_state(root, state="ROLLED_BACK",
                            backup_id=backup_id)
                append_audit(root, "UPDATE_ROLLED_BACK",
                             previous, "ok",
                             {"run_id": run_id,
                              "backup_id": backup_id})
                say("تم التراجع إلى %s" % previous)
            except Exception as rollback_exc:
                write_state(root, state="ROLLBACK_FAILED",
                            error=str(rollback_exc))
                append_audit(root, "UPDATE_ROLLBACK_FAILED",
                             version or "unknown", "error",
                             {"run_id": run_id,
                              "error": str(rollback_exc)})
                say("فشل التراجع: %s" % rollback_exc)
        if maintenance_on:
            set_maintenance(root, False)
        raise
    finally:
        release_lock(root, run_id)


def _bundle_tops(artifact):
    if artifact is None:
        return ()
    with zipfile.ZipFile(artifact) as bundle:
        tops = set()
        for name in bundle.namelist():
            parts = Path(name).parts
            if parts:
                tops.add(parts[0])
    return tuple(sorted(tops - FORBIDDEN_TOPS))


def rollback(root, backup_id=None, yes=False):
    root = Path(root)
    registry = read_registry(root)
    backups = registry.get("backups", [])
    if not backups:
        raise UpdateEngineError("no backups available")
    if backup_id is None:
        meta = backups[0]
        backup_id = meta["id"]
    else:
        meta = next((entry for entry in backups
                     if entry.get("id") == backup_id), None)
        if meta is None:
            raise UpdateEngineError("backup %r not found"
                                    % (backup_id,))
    if not yes:
        say("سيعيد هذا %s إلى الإصدار %s (النسخة %s)."
            % (root, meta.get("version_from"), backup_id))
        answer = input("اكتب YES للتأكيد: ").strip()
        if answer != "YES":
            say("أُلغي التراجع")
            return {"state": "CANCELLED"}
    run_id = "APKFORGE-%s-ROLLBACK" % time.strftime(
        "%Y%m%d-%H%M%S", time.localtime())
    acquire_lock(root, run_id)
    try:
        set_maintenance(root, True, "تراجع يدوي إلى %s"
                        % meta.get("version_from"))
        stop_services(root)
        restore_backup(root, backup_id)
        migrate_db(root)
        skip_build = meta.get("kind") == "bundle" and \
            "frontend" not in (meta.get("members") or [])
        code = restart_pipeline(root, skip_build)
        if code != 0:
            raise UpdateEngineError(
                "restart after rollback FAILED")
        verify_version(root, meta.get("version_from"))
        set_maintenance(root, False)
        write_state(root, state="ROLLED_BACK", run_id=run_id,
                    version_from=meta.get("version_to"),
                    version_to=meta.get("version_from"),
                    backup_id=backup_id)
        append_audit(root, "UPDATE_ROLLED_BACK",
                     meta.get("version_from"), "ok",
                     {"run_id": run_id,
                      "backup_id": backup_id})
        say("تم التراجع إلى %s" % meta.get("version_from"))
        return {"state": "ROLLED_BACK", "backup_id": backup_id,
                "version_to": meta.get("version_from")}
    finally:
        set_maintenance(root, False)
        release_lock(root, run_id)


# -- boot hook (engine calls this; never raises) -------------------------
def boot_update_notice(root):
    """After migrations: warn loudly if an update is required."""
    root = Path(root)
    current = current_version(root)
    notice = {"update_required": False, "status": "NO_UPDATE",
              "latest": current, "lines": []}
    conn = connect_db(root)
    if conn is None:
        return notice
    try:
        channel = get_setting(conn, "system.channel", "STABLE")
        row = latest_published(conn, channel)
        if row is None:
            return notice
        manifest = _validate(release_to_manifest(row))
        status = _evaluate(
            current, manifest["latest_version"],
            mandatory=manifest.get("mandatory", False),
            minimum=manifest.get(
                "minimum_supported_version"))
        notice.update(status=status,
                      latest=manifest["latest_version"])
        try:
            set_setting(conn, "update_required",
                        "true" if status == "MANDATORY_UPDATE"
                        else "false")
        except Exception:
            pass
        if status == "NO_UPDATE":
            return notice
        notice["update_required"] = True
        if status == "MANDATORY_UPDATE":
            notice["lines"].append(
                "!!! MANDATORY UPDATE %s -> %s (run: "
                "./apkforge update)" % (current,
                                        manifest["latest_version"]))
        else:
            notice["lines"].append(
                "update available: %s -> %s (run: "
                "./apkforge update)" % (current,
                                        manifest["latest_version"]))
        return notice
    except Exception:
        return notice
    finally:
        conn.close()


# -- CLI ------------------------------------------------------------------
def build_parser():
    parser = argparse.ArgumentParser(
        prog="apkforge update",
        description="APKForge update engine")
    sub = parser.add_subparsers(dest="command")
    check = sub.add_parser("check", help="فحص التحديثات")
    check.add_argument("--root", default=str(DEFAULT_ROOT))
    check.add_argument("--version", default=None)
    check.add_argument("--manifest-url", default=None)
    check.add_argument("--channel", default=None)
    check.add_argument("--json", action="store_true")
    status = sub.add_parser("status", help="حالة آخر عملية")
    status.add_argument("--root", default=str(DEFAULT_ROOT))
    status.add_argument("--json", action="store_true")
    run = sub.add_parser("run", help="تنفيذ التحديث")
    run.add_argument("--root", default=str(DEFAULT_ROOT))
    run.add_argument("--run-id", default=None)
    run.add_argument("--version", default=None)
    run.add_argument("--manifest-url", default=None)
    run.add_argument("--channel", default=None)
    run.add_argument("--force", action="store_true")
    back = sub.add_parser("rollback", help="تراجع لنسخة سابقة")
    back.add_argument("--root", default=str(DEFAULT_ROOT))
    back.add_argument("--id", default=None)
    back.add_argument("--yes", action="store_true")
    return parser


def main(argv=None):
    # flag-style aliases: ./apkforge update --check / --status /
    # --rollback [id] (spec section 34).
    argv = list(sys.argv[1:] if argv is None else argv)
    if argv and argv[0] == "update":
        argv = argv[1:]
    root_alias = str(DEFAULT_ROOT)
    if "--root" in argv:
        index = argv.index("--root")
        if index + 1 < len(argv):
            root_alias = argv[index + 1]
    if argv[:1] == ["--check"]:
        argv = ["check", "--root", root_alias] + \
            [item for item in argv[1:]
             if item not in ("--root", root_alias)]
    elif argv[:1] == ["--status"]:
        argv = ["status", "--root", root_alias]
    elif argv[:1] == ["--rollback"]:
        rest = argv[1:]
        backup_id = None
        if rest and not rest[0].startswith("-"):
            backup_id, rest = rest[0], rest[1:]
        argv = ["rollback", "--root", root_alias]
        if backup_id:
            argv += ["--id", backup_id]
        argv += [item for item in rest
                 if item not in ("--root", root_alias)]
    elif not argv or argv[0] not in ("check", "status", "run",
                                     "rollback"):
        argv = ["run", "--root", root_alias] + argv
    args = build_parser().parse_args(argv)
    root = Path(args.root)
    if args.command == "check":
        try:
            report = check(root, args.version,
                           args.manifest_url, args.channel)
        except UpdateEngineError as exc:
            say("تعذر الفحص: %s" % exc)
            return 1
        if args.json:
            say(json.dumps(report, indent=2,
                           ensure_ascii=False))
        else:
            manifest = report["manifest"]
            say("الحالة: %s" % report["status"])
            say("الحالي: %s | الأحدث: %s" % (
                report["current_version"],
                manifest["latest_version"]))
            for note in manifest.get("release_notes", []):
                say("  - %s" % note)
        return 0
    if args.command == "status":
        state = read_state(root)
        if args.json:
            say(json.dumps(state, indent=2,
                           ensure_ascii=False))
        else:
            say("الحالة: %s" % state.get("state"))
            if state.get("run_id"):
                say("التشغيل: %s" % state["run_id"])
            if state.get("version_from"):
                say("%s -> %s" % (state.get("version_from"),
                                  state.get("version_to")))
            if state.get("error"):
                say("الخطأ: %s" % state["error"])
        return 0
    if args.command == "rollback":
        try:
            rollback(root, args.id, args.yes)
        except UpdateEngineError as exc:
            say("فشل التراجع: %s" % exc)
            return 1
        return 0
    try:
        run_update(root, args.run_id, args.version,
                   args.manifest_url, args.channel,
                   args.force)
    except UpdateEngineError as exc:
        say("انتهى التحديث بفشل: %s" % exc)
        return 1
    except Exception as exc:  # never a naked traceback
        say("انتهى التحديث بفشل غير متوقع: %s" % exc)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
