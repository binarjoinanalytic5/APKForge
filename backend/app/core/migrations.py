"""Versioned SQLite migrations (idempotent, baseline-aware).

Migration files live in ``backend/migrations/NNN_name.sql`` and run in
version order, exactly once each, tracked in ``schema_migrations``.

Legacy databases created by the pre-migration schema bootstrap (tables
exist but no registry) are *baselined*: 001 is recorded as applied
without re-running, then every later migration applies normally — data
is never wiped and migrations never repeat.
"""
import sqlite3
import time
from pathlib import Path

MIGRATIONS_DIR = Path(__file__).resolve().parents[2] / "migrations"

REGISTRY_SQL = (
    "CREATE TABLE IF NOT EXISTS schema_migrations ("
    "version TEXT PRIMARY KEY, name TEXT NOT NULL, "
    "applied_at TEXT NOT NULL)")


class MigrationError(RuntimeError):
    pass


def _now():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())


def discover(migrations_dir=None):
    """Return [(version, name, path)] sorted by version."""
    directory = Path(migrations_dir or MIGRATIONS_DIR)
    found = []
    if directory.is_dir():
        for path in sorted(directory.glob("*.sql")):
            stem = path.stem
            version, _, name = stem.partition("_")
            if version.isdigit() and name:
                found.append((version, name, path))
    versions = [version for version, _, _ in found]
    if len(set(versions)) != len(versions):
        raise MigrationError("duplicate migration version")
    return sorted(found, key=lambda item: item[0])


def applied_versions(db):
    db.execute(REGISTRY_SQL)
    return {row[0] for row in
            db.execute("SELECT version FROM schema_migrations")}


def status(db_path, migrations_dir=None):
    """Report {applied:[...], pending:[...]} without changing anything."""
    db = sqlite3.connect(db_path)
    try:
        applied = applied_versions(db)
        versions = [version for version, _, _ in
                    discover(migrations_dir)]
        return {"applied": sorted(applied),
                "pending": [version for version in versions
                            if version not in applied]}
    finally:
        db.close()


def migrate(db, migrations_dir=None):
    """Apply pending migrations on an open connection.

    Returns {"baselined": [...], "applied": [...]}. Safe to call on
    every boot: applied versions are skipped, never re-run.
    """
    migrations = discover(migrations_dir)
    applied = applied_versions(db)
    baselined = []
    if not applied:
        tables = {row[0] for row in db.execute(
            "SELECT name FROM sqlite_master WHERE type='table'")}
        if "users" in tables and migrations:
            version, name, _path = migrations[0]
            db.execute(
                "INSERT INTO schema_migrations VALUES (?,?,?)",
                (version, name, _now()))
            db.commit()
            applied.add(version)
            baselined.append(version)
    applied_now = []
    for version, name, path in migrations:
        if version in applied:
            continue
        sql = path.read_text(encoding="utf-8")
        try:
            db.executescript(sql)
            db.execute(
                "INSERT INTO schema_migrations VALUES (?,?,?)",
                (version, name, _now()))
            db.commit()
        except Exception as exc:
            db.rollback()
            raise MigrationError(
                "migration %s_%s failed: %s" % (version, name, exc))
        applied_now.append(version)
    return {"baselined": baselined, "applied": applied_now}
