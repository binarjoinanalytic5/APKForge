"""Update engine tests (hermetic: tmp roots, file:// artifacts)."""
import hashlib
import hmac
import importlib.util
import json
import sqlite3
import sys
import zipfile
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "backend"))

from app.core.migrations import migrate  # noqa: E402
from app.core.updates import version_code  # noqa: E402

spec = importlib.util.spec_from_file_location(
    "apkforge_update", ROOT / "scripts" / "update.py")
upd = importlib.util.module_from_spec(spec)
spec.loader.exec_module(upd)

UPDATE_KEY = "update-key-for-tests-1234567890"


@pytest.fixture()
def site(tmp_path):
    root = tmp_path / "site"
    root.mkdir()
    (root / "VERSION").write_text("1.0.0", encoding="utf-8")
    (root / ".env").write_text(
        "APKFORGE_DB=data/apkforge.db\n"
        "APKFORGE_KEY=test-key-0123456789abcdef-!\n"
        "APKFORGE_UPDATE_KEY=%s\nAPKFORGE_PORT=8123\n"
        % UPDATE_KEY, encoding="utf-8")
    (root / "data").mkdir()
    conn = sqlite3.connect(str(root / "data" / "apkforge.db"))
    migrate(conn, ROOT / "backend" / "migrations")
    conn.close()
    (root / "backend").mkdir()
    (root / "backend" / "app.py").write_text("OLD\n",
                                             encoding="utf-8")
    return root


def _db(site):
    conn = sqlite3.connect(str(site / "data" / "apkforge.db"))
    conn.row_factory = sqlite3.Row
    return conn


def add_release(site, version="1.1.0", status="published",
                channel="STABLE", kind="bundle", **over):
    row = {"id": "rel-%s" % version.replace(".", ""),
           "version": version,
           "version_code": version_code(version),
           "release_type": "MINOR", "channel": channel,
           "status": status, "minimum_supported_version":
           "1.0.0", "mandatory": 0, "security_update": 0,
           "artifact_kind": kind,
           "download_url": "file:///none", "artifact_ref": None,
           "checksum": "c" * 64, "signature": "d" * 64,
           "size_bytes": 10, "release_notes": "[]",
           "breaking_changes": "[]", "security_notes": "[]",
           "migration_required": 0, "restart_required": 1,
           "release_date": "2026-10-08",
           "published_at": "2026-10-08T00:00:00Z",
           "created_by": "tester",
           "created_at": "2026-10-08T00:00:00Z",
           "updated_at": "2026-10-08T00:00:00Z"}
    row.update(over)
    conn = _db(site)
    try:
        conn.execute(
            "INSERT INTO releases (%s) VALUES (%s)"
            % (",".join(row), ",".join("?" * len(row))),
            tuple(row.values()))
        conn.commit()
    finally:
        conn.close()
    return row


def make_bundle(site, version, name="pkg.zip"):
    path = site / name
    with zipfile.ZipFile(path, "w") as bundle:
        bundle.writestr("VERSION", version + "\n")
        bundle.writestr("backend/app.py", "NEW-%s\n" % version)
    digest = upd.sha256_file(path)
    signature = hmac.new(UPDATE_KEY.encode(), path.read_bytes(),
                         hashlib.sha256).hexdigest()
    return path, digest, signature


def test_check_matrix(site):
    with pytest.raises(upd.UpdateEngineError):
        upd.check(site)
    add_release(site, version="1.1.0")
    report = upd.check(site)
    assert report["status"] == "UPDATE_AVAILABLE"
    assert report["manifest"]["latest_version"] == "1.1.0"
    (site / "VERSION").write_text("1.1.0", encoding="utf-8")
    assert upd.check(site)["status"] == "NO_UPDATE"


def test_check_mandatory_and_minimum(site):
    add_release(site, version="1.1.0", mandatory=1)
    assert upd.check(site)["status"] == "MANDATORY_UPDATE"
    conn = _db(site)
    try:
        conn.execute("UPDATE releases SET mandatory=0,"
                     " minimum_supported_version='1.2.0'")
        conn.commit()
    finally:
        conn.close()
    assert upd.check(site)["status"] == "MANDATORY_UPDATE"


def test_check_channel_isolation(site):
    add_release(site, version="1.1.0", channel="BETA")
    with pytest.raises(upd.UpdateEngineError):
        upd.check(site)
    conn = _db(site)
    try:
        conn.execute("INSERT OR REPLACE INTO system_config "
                     "VALUES (?,?,?)",
                     ("system.channel", "BETA",
                      "2026-10-08T00:00:00Z"))
        conn.commit()
    finally:
        conn.close()
    assert upd.check(site)["status"] == "UPDATE_AVAILABLE"


def test_download_resume_and_size(site, tmp_path):
    src = tmp_path / "big.bin"
    src.write_bytes(b"B" * (1024 * 256 + 100))
    dest = site / "got.bin"
    dest.write_bytes(b"B" * 1000)  # partial previous attempt
    total = upd.download("file://%s" % src, dest,
                         expected_size=src.stat().st_size)
    assert total == src.stat().st_size
    assert dest.read_bytes() == src.read_bytes()
    with pytest.raises(upd.UpdateEngineError):
        upd.download("file://%s" % src, site / "x.bin",
                     expected_size=5)
    with pytest.raises(upd.UpdateEngineError):
        upd.download("ftp://example.test/x", site / "y.bin")


def test_verify_artifact(site):
    path, digest, signature = make_bundle(site, "1.1.0")
    manifest = {"latest_version": "1.1.0",
                "size_bytes": path.stat().st_size,
                "checksum": digest, "signature": signature}
    assert upd.verify_artifact(path, manifest,
                               UPDATE_KEY) == digest
    with open(path, "ab") as handle:
        handle.write(b"tamper")
    with pytest.raises(upd.UpdateEngineError):
        upd.verify_artifact(path, manifest, UPDATE_KEY)
    path, digest, signature = make_bundle(site, "1.1.0",
                                          name="pkg2.zip")
    manifest = {"latest_version": "1.1.0",
                "size_bytes": path.stat().st_size,
                "checksum": digest, "signature": signature}
    with pytest.raises(upd.UpdateEngineError):
        upd.verify_artifact(path, manifest, "wrong-key")
    with pytest.raises(upd.UpdateEngineError):
        upd.verify_artifact(path, manifest, "")


def test_install_bundle(site):
    path, _digest, _sig = make_bundle(site, "1.1.0")
    tops = upd.install_bundle(
        site, path, {"latest_version": "1.1.0"})
    assert "backend" in tops
    assert (site / "VERSION").read_text(
        encoding="utf-8").strip() == "1.1.0"
    assert (site / "backend" / "app.py").read_text(
        encoding="utf-8") == "NEW-1.1.0\n"
    assert (site / ".env").is_file()  # never touched


def test_install_bundle_refuses_unsafe(site):
    evil = site / "evil.zip"
    with zipfile.ZipFile(evil, "w") as bundle:
        bundle.writestr("../escape.txt", "x")
        bundle.writestr("VERSION", "9.9.9\n")
    with pytest.raises(upd.UpdateEngineError):
        upd.install_bundle(site, evil,
                           {"latest_version": "9.9.9"})
    sneaky = site / "sneaky.zip"
    with zipfile.ZipFile(sneaky, "w") as bundle:
        bundle.writestr("VERSION", "9.9.9\n")
        bundle.writestr("data/stolen.txt", "x")
        bundle.writestr("backend/a.py", "x")
    with pytest.raises(upd.UpdateEngineError):
        upd.install_bundle(site, sneaky,
                           {"latest_version": "9.9.9"})
    path, _d, _s = make_bundle(site, "1.1.0", name="mm.zip")
    with pytest.raises(upd.UpdateEngineError):
        upd.install_bundle(site, path,
                           {"latest_version": "2.0.0"})


def test_backup_and_restore(site):
    meta = upd.create_backup(site, "1.0.0", "1.1.0", "bundle",
                             members=("backend",))
    assert meta["id"].startswith("bu-")
    assert "code.tar.gz" in meta["files"]
    assert "apkforge.db" in meta["files"]
    (site / "backend" / "app.py").write_text("CORRUPT\n",
                                             encoding="utf-8")
    (site / "VERSION").write_text("9.9.9", encoding="utf-8")
    (site / "backend" / "added-by-update.py").write_text(
        "STALE\n", encoding="utf-8")
    upd.restore_backup(site, meta["id"])
    assert not (site / "backend" / "added-by-update.py").exists()
    assert (site / "backend" / "app.py").read_text(
        encoding="utf-8") == "OLD\n"
    assert (site / "VERSION").read_text(
        encoding="utf-8").strip() == "1.0.0"
    registry = upd.read_registry(site)
    assert registry["backups"][0]["rollback_command"] == \
        "./apkforge update --rollback %s" % meta["id"]
    with pytest.raises(upd.UpdateEngineError):
        upd.restore_backup(site, "bu-missing")


def test_registry_prunes_to_five(site):
    upd.create_backup(site, "1.0.0", "1.1.0", "bundle")
    registry = upd.read_registry(site)
    fakes = [{"id": "bu-fake-%d" % index}
             for index in range(6)]
    registry["backups"] = fakes + registry["backups"]
    upd.write_registry(site, registry)
    upd.create_backup(site, "1.0.0", "1.1.0", "bundle")
    assert len(upd.read_registry(site)["backups"]) == 5


def test_guards_jobs_and_lock(site):
    add_release(site, version="1.1.0")
    manifest = upd.check(site)["manifest"]
    upd.guard_all(site, manifest)  # idle: fine
    conn = _db(site)
    try:
        conn.execute(
            "INSERT INTO jobs (job_id, project_id, kind, status,"
            " options, created_at, updated_at) VALUES "
            "(?,?,?,?,?,?,?)",
            ("job-1", "proj-1", "decompile", "running", "{}",
             "2026-10-08T00:00:00Z", "2026-10-08T00:00:00Z"))
        conn.commit()
    finally:
        conn.close()
    with pytest.raises(upd.UpdateEngineError):
        upd.guard_all(site, manifest)
    upd.guard_all(site, manifest, force=True)  # override works
    upd.acquire_lock(site, "APKFORGE-T1")
    with pytest.raises(upd.UpdateEngineError):
        upd.acquire_lock(site, "APKFORGE-T2")
    upd.release_lock(site, "APKFORGE-T1")
    upd.acquire_lock(site, "APKFORGE-T2")
    upd.release_lock(site, "APKFORGE-T2")
    (site / ".governance" / "update.lock").write_text(
        json.dumps({"run_id": "APKFORGE-STALE",
                    "pid": 999999999}), encoding="utf-8")
    upd.acquire_lock(site, "APKFORGE-T3")  # stale cleared
    upd.release_lock(site, "APKFORGE-T3")


def test_boot_notice(site):
    notice = upd.boot_update_notice(site)
    assert notice["update_required"] is False
    add_release(site, version="1.1.0", mandatory=1)
    notice = upd.boot_update_notice(site)
    assert notice["update_required"] is True
    assert notice["status"] == "MANDATORY_UPDATE"
    assert "./apkforge update" in notice["lines"][0]


def test_cli_check_status_aliases(site, capsys):
    add_release(site, version="1.1.0")
    assert upd.main(["check", "--root", str(site)]) == 0
    assert "UPDATE_AVAILABLE" in capsys.readouterr().out
    assert upd.main(["--check", "--root", str(site)]) == 0
    assert upd.main(["status", "--root", str(site)]) == 0
    assert "IDLE" in capsys.readouterr().out
    assert upd.main(["--status", "--root", str(site)]) == 0
    with pytest.raises(upd.UpdateEngineError):
        upd.rollback(site, None, yes=True)  # no backups


def test_git_kind_records_sha(site):
    pytest.importorskip("shutil")
    import shutil as _shutil
    if _shutil.which("git") is None:
        pytest.skip("git not installed")
    import subprocess
    subprocess.run(["git", "init", "-q", str(site)],
                   check=True, timeout=30)
    subprocess.run(["git", "-C", str(site), "config",
                    "user.email", "t@t.t"], check=True,
                   timeout=30)
    subprocess.run(["git", "-C", str(site), "config",
                    "user.name", "t"], check=True, timeout=30)
    subprocess.run(["git", "-C", str(site), "add", "."],
                   check=True, timeout=30)
    subprocess.run(["git", "-C", str(site), "commit", "-qm",
                    "one"], check=True, timeout=30)
    sha = upd.run_git(site, "rev-parse", "HEAD")
    meta = upd.create_backup(site, "1.0.0", "1.1.0", "git",
                             git_sha=sha)
    assert meta["git_sha"] == sha
    (site / "backend" / "app.py").write_text("DIRTY\n",
                                             encoding="utf-8")
    with pytest.raises(upd.UpdateEngineError):
        upd.install_git(site, sha)  # dirty tracked file
    subprocess.run(["git", "-C", str(site), "checkout",
                    "--", "."], check=True, timeout=30)
    assert upd.install_git(site, sha) == sha


def test_engine_audit_and_broadcast_roundtrip(site):
    upd.append_audit(site, "UPDATE_COMPLETED", "1.1.0", "ok",
                     {"run_id": "APKFORGE-T"})
    conn = _db(site)
    try:
        row = conn.execute(
            "SELECT actor, action, target, result FROM audit "
            "WHERE action='UPDATE_COMPLETED'").fetchone()
        assert tuple(row) == ("update-engine", "UPDATE_COMPLETED",
                              "1.1.0", "ok")
    finally:
        conn.close()
    upd.broadcast(site, "UPDATE_AVAILABLE", "done", "msg")
    conn = _db(site)
    try:
        row = conn.execute(
            "SELECT ntype, severity, priority, title, target"
            " FROM notifications").fetchone()
        assert tuple(row) == ("UPDATE_AVAILABLE", "info", 2,
                              "done", "all")
    finally:
        conn.close()
