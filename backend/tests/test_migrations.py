"""Migration system tests: fresh apply, idempotency, legacy baseline."""
import sqlite3
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))

from app.core.migrations import (MIGRATIONS_DIR, MigrationError,  # noqa: E402
                                 applied_versions, discover,
                                 migrate, status)


def _tables(db):
    return {row[0] for row in db.execute(
        "SELECT name FROM sqlite_master WHERE type='table'")}


def test_discover_finds_ordered_versions():
    found = discover()
    versions = [version for version, _, _ in found]
    assert versions == ["001", "002", "003"]
    assert all(path.is_file() for _, _, path in found)
    assert MIGRATIONS_DIR.is_dir()


def test_fresh_db_applies_everything(tmp_path):
    db = sqlite3.connect(str(tmp_path / "fresh.db"))
    try:
        report = migrate(db)
        assert report == {"baselined": [], "applied": ["001", "002", "003"]}
        tables = _tables(db)
        for name in ("users", "projects", "jobs", "artifacts",
                     "audit", "system_config", "schema_migrations"):
            assert name in tables, name
        indexes = {row[0] for row in db.execute(
            "SELECT name FROM sqlite_master WHERE type='index'")}
        assert "idx_jobs_project" in indexes
        assert applied_versions(db) == {"001", "002", "003"}
    finally:
        db.close()


def test_migrate_is_idempotent(tmp_path):
    db = sqlite3.connect(str(tmp_path / "idem.db"))
    try:
        assert migrate(db)["applied"] == ["001", "002", "003"]
        assert migrate(db) == {"baselined": [], "applied": []}
        assert migrate(db) == {"baselined": [], "applied": []}
    finally:
        db.close()


def test_legacy_db_baselined_without_data_loss(tmp_path):
    """Pre-migration DBs (tables, no registry) keep every row."""
    path = str(tmp_path / "legacy.db")
    db = sqlite3.connect(path)
    try:
        legacy_sql = (MIGRATIONS_DIR / "001_initial.sql").read_text(
            encoding="utf-8")
        db.executescript(legacy_sql)  # what the old bootstrap did
        db.execute("INSERT INTO users VALUES (?,?,?,?)",
                   ("old-admin", "hash", "admin", "2026-01-01T00:00:00Z"))
        db.commit()
    finally:
        db.close()
    db = sqlite3.connect(path)
    try:
        report = migrate(db)
        assert report["baselined"] == ["001"]
        assert report["applied"] == ["002", "003"]
        row = db.execute(
            "SELECT * FROM users WHERE username='old-admin'").fetchone()
        assert row is not None
        assert "system_config" in _tables(db)
        assert migrate(db) == {"baselined": [], "applied": []}
    finally:
        db.close()


def test_status_reports_without_changing(tmp_path):
    path = str(tmp_path / "status.db")
    assert status(path) == {"applied": [],
                            "pending": ["001", "002", "003"]}
    db = sqlite3.connect(path)
    try:
        migrate(db)
    finally:
        db.close()
    assert status(path) == {"applied": ["001", "002", "003"],
                            "pending": []}


def test_duplicate_versions_rejected(tmp_path):
    (tmp_path / "001_a.sql").write_text("SELECT 1;")
    (tmp_path / "001_b.sql").write_text("SELECT 1;")
    with pytest.raises(MigrationError):
        discover(tmp_path)


def test_broken_migration_fails_closed(tmp_path):
    (tmp_path / "001_ok.sql").write_text(
        "CREATE TABLE t (id INTEGER PRIMARY KEY);")
    (tmp_path / "002_bad.sql").write_text("THIS IS NOT SQL AT ALL;")
    db = sqlite3.connect(":memory:")
    try:
        with pytest.raises(MigrationError):
            migrate(db, tmp_path)
        assert applied_versions(db) == {"001"}
    finally:
        db.close()


def test_store_boots_through_migrations(tmp_path):
    from app.core.store import SqliteStore
    store = SqliteStore(str(tmp_path / "via-store.db"))
    assert store.get_config("missing", "dflt") == "dflt"
    store.set_config("initialized", "true")
    assert store.get_config("initialized") == "true"
    versions = {row[0] for row in store.db.execute(
        "SELECT version FROM schema_migrations")}
    assert versions == {"001", "002", "003"}
