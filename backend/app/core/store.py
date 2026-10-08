"""Local persistence (SQLite) behind a narrow interface.

Phase 1 stores users, projects, jobs, artifacts, and the audit log in
a single SQLite file. The PostgreSQL backend implements this same
narrow surface in Phase 2 — services never touch SQL directly.
"""
import json
import sqlite3
import time
import uuid

from .migrations import migrate


class StoreError(RuntimeError):
    pass


def _now():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())


class SqliteStore:
    def __init__(self, path):
        # Single-process Phase 1: the API thread and background tasks
        # share one connection (PostgreSQL pooling arrives in Phase 2).
        self.db = sqlite3.connect(path, check_same_thread=False)
        self.db.row_factory = sqlite3.Row
        migrate(self.db)  # idempotent; legacy DBs are baselined

    # -- users ------------------------------------------------------
    def user_count(self):
        return self.db.execute(
            "SELECT COUNT(*) FROM users").fetchone()[0]

    def create_user(self, username, pw_hash, role):
        try:
            self.db.execute(
                "INSERT INTO users VALUES (?,?,?,?)",
                (username, pw_hash, role, _now()))
            self.db.commit()
        except sqlite3.IntegrityError:
            raise StoreError("user exists") from None

    def get_user(self, username):
        row = self.db.execute(
            "SELECT * FROM users WHERE username=?",
            (username,)).fetchone()
        return dict(row) if row else None

    # -- projects ---------------------------------------------------
    def create_project(self, name, owner):
        project = {"id": "prj-" + uuid.uuid4().hex[:12], "name": name,
                   "owner": owner, "created_at": _now()}
        self.db.execute("INSERT INTO projects VALUES (?,?,?,?)",
                        (project["id"], name, owner,
                         project["created_at"]))
        self.db.commit()
        return project

    def list_projects(self):
        return [dict(row) for row in self.db.execute(
            "SELECT * FROM projects ORDER BY created_at")]

    def get_project(self, project_id):
        row = self.db.execute(
            "SELECT * FROM projects WHERE id=?",
            (project_id,)).fetchone()
        return dict(row) if row else None

    def delete_project(self, project_id):
        self.db.execute("DELETE FROM projects WHERE id=?",
                        (project_id,))
        self.db.execute("DELETE FROM jobs WHERE project_id=?",
                        (project_id,))
        self.db.commit()

    # -- jobs -------------------------------------------------------
    def create_job(self, project_id, kind, input_ref=None,
                   options=None):
        job = {"job_id": "job-" + uuid.uuid4().hex[:12],
               "project_id": project_id, "kind": kind,
               "status": "queued", "created_at": _now()}
        self.db.execute(
            "INSERT INTO jobs (job_id, project_id, kind, status,"
            " input_ref, options, created_at, updated_at)"
            " VALUES (?,?,?,?,?,?,?,?)",
            (job["job_id"], project_id, kind, "queued", input_ref,
             json.dumps(options or {}), job["created_at"],
             job["created_at"]))
        self.db.commit()
        return job

    def get_job(self, job_id):
        row = self.db.execute("SELECT * FROM jobs WHERE job_id=?",
                              (job_id,)).fetchone()
        if not row:
            return None
        job = dict(row)
        job["log_lines"] = json.loads(job["log_lines"] or "[]")
        job["options"] = json.loads(job["options"] or "{}")
        return job

    def set_job(self, job_id, **fields):
        fields["updated_at"] = _now()
        if "log_lines" in fields:
            fields["log_lines"] = json.dumps(fields["log_lines"])
        columns = ", ".join("%s=?" % key for key in fields)
        self.db.execute("UPDATE jobs SET %s WHERE job_id=?"
                        % columns, (*fields.values(), job_id))
        self.db.commit()

    def list_project_jobs(self, project_id):
        rows = self.db.execute(
            "SELECT * FROM jobs WHERE project_id=? ORDER BY created_at",
            (project_id,))
        jobs = []
        for row in rows:
            job = dict(row)
            job["log_lines"] = json.loads(job["log_lines"] or "[]")
            job["options"] = json.loads(job["options"] or "{}")
            jobs.append(job)
        return jobs

    # -- artifacts --------------------------------------------------
    def put_artifact(self, sha256, name, size, kind, project_id):
        self.db.execute(
            "INSERT OR REPLACE INTO artifacts VALUES (?,?,?,?,?,?)",
            (sha256, name, size, kind, project_id, _now()))
        self.db.commit()

    def list_project_artifacts(self, project_id):
        return [dict(row) for row in self.db.execute(
            "SELECT * FROM artifacts WHERE project_id=?", (project_id,))]

    # -- audit ------------------------------------------------------
    def append_audit(self, record):
        self.db.execute(
            "INSERT INTO audit (ts, actor, action, target, result,"
            " detail) VALUES (?,?,?,?,?,?)",
            (record["ts"], record["actor"], record["action"],
             record["target"], record["result"],
             json.dumps(record.get("detail") or {})))
        self.db.commit()

    def list_audit(self, limit=200):
        return [dict(row) for row in self.db.execute(
            "SELECT * FROM audit ORDER BY id DESC LIMIT ?", (limit,))]

    # -- system config --------------------------------------------
    def get_config(self, key, default=None):
        row = self.db.execute(
            "SELECT value FROM system_config WHERE key=?",
            (key,)).fetchone()
        return row[0] if row else default

    def set_config(self, key, value):
        self.db.execute(
            "INSERT OR REPLACE INTO system_config VALUES (?,?,?)",
            (key, value, _now()))
        self.db.commit()

    # -- releases ---------------------------------------------------
    def create_release(self, release):
        release = dict(release)
        release["id"] = "rel-" + uuid.uuid4().hex[:12]
        now = _now()
        release.setdefault("created_at", now)
        release.setdefault("updated_at", now)
        self.db.execute(
            "INSERT INTO releases (id, version, version_code,"
            " release_type, channel, status, minimum_supported_version,"
            " mandatory, security_update, artifact_kind, download_url,"
            " artifact_ref, checksum, signature, size_bytes,"
            " release_notes, breaking_changes, security_notes,"
            " migration_required, restart_required, release_date,"
            " published_at, created_by, created_at, updated_at)"
            " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
            (release["id"], release["version"], release["version_code"],
             release["release_type"], release["channel"],
             release.get("status", "draft"),
             release["minimum_supported_version"],
             int(bool(release.get("mandatory", False))),
             int(bool(release.get("security_update", False))),
             release["artifact_kind"], release.get("download_url"),
             release.get("artifact_ref"), release.get("checksum"),
             release.get("signature"), release.get("size_bytes", 0),
             json.dumps(release.get("release_notes", [])),
             json.dumps(release.get("breaking_changes", [])),
             release.get("security_notes", ""),
             int(bool(release.get("migration_required", False))),
             int(bool(release.get("restart_required", True))),
             release.get("release_date"), release.get("published_at"),
             release["created_by"], release["created_at"],
             release["updated_at"]))
        self.db.commit()
        return self.get_release(release["id"])

    def _release_row(self, row):
        release = dict(row)
        release["mandatory"] = bool(release["mandatory"])
        release["security_update"] = bool(release["security_update"])
        release["migration_required"] = bool(
            release["migration_required"])
        release["restart_required"] = bool(release["restart_required"])
        release["release_notes"] = json.loads(
            release["release_notes"] or "[]")
        release["breaking_changes"] = json.loads(
            release["breaking_changes"] or "[]")
        return release

    def get_release(self, release_id):
        row = self.db.execute(
            "SELECT * FROM releases WHERE id=?", (release_id,)).fetchone()
        return self._release_row(row) if row else None

    def get_release_by_version(self, version):
        row = self.db.execute(
            "SELECT * FROM releases WHERE version=?",
            (version,)).fetchone()
        return self._release_row(row) if row else None

    def list_releases(self, channel=None, status=None):
        query = "SELECT * FROM releases"
        clauses, params = [], []
        if channel:
            clauses.append("channel=?")
            params.append(channel)
        if status:
            clauses.append("status=?")
            params.append(status)
        if clauses:
            query += " WHERE " + " AND ".join(clauses)
        query += " ORDER BY version_code DESC"
        return [self._release_row(row) for row in
                self.db.execute(query, params)]

    def set_release(self, release_id, **fields):
        fields["updated_at"] = _now()
        for key in ("release_notes", "breaking_changes"):
            if key in fields:
                fields[key] = json.dumps(fields[key])
        for key in ("mandatory", "security_update",
                    "migration_required", "restart_required"):
            if key in fields:
                fields[key] = int(bool(fields[key]))
        columns = ", ".join("%s=?" % key for key in fields)
        self.db.execute("UPDATE releases SET %s WHERE id=?" % columns,
                        (*fields.values(), release_id))
        self.db.commit()
        return self.get_release(release_id)

    # -- notifications ----------------------------------------------
    def create_notification(self, note):
        note = dict(note)
        note["id"] = "notif-" + uuid.uuid4().hex[:12]
        note.setdefault("created_at", _now())
        self.db.execute(
            "INSERT INTO notifications (id, ntype, severity, priority,"
            " title, message, action, target, created_at, expires_at)"
            " VALUES (?,?,?,?,?,?,?,?,?,?)",
            (note["id"], note["ntype"], note.get("severity", "info"),
             note.get("priority", 1), note["title"], note["message"],
             json.dumps(note.get("action", {})), note.get("target", "all"),
             note["created_at"], note.get("expires_at")))
        self.db.commit()
        row = self.db.execute(
            "SELECT * FROM notifications WHERE id=?",
            (note["id"],)).fetchone()
        result = dict(row)
        result["action"] = json.loads(result["action"] or "{}")
        return result

    def list_notifications(self):
        notes = []
        for row in self.db.execute(
                "SELECT * FROM notifications ORDER BY priority DESC,"
                " created_at DESC"):
            note = dict(row)
            note["action"] = json.loads(note["action"] or "{}")
            notes.append(note)
        return notes

    def delete_notification(self, notification_id):
        self.db.execute("DELETE FROM notification_reads"
                        " WHERE notification_id=?", (notification_id,))
        self.db.execute("DELETE FROM notifications WHERE id=?",
                        (notification_id,))
        self.db.commit()

    def mark_notification(self, notification_id, username, read=True):
        if read:
            self.db.execute(
                "INSERT OR IGNORE INTO notification_reads VALUES (?,?,?)",
                (notification_id, username, _now()))
        else:
            self.db.execute(
                "DELETE FROM notification_reads"
                " WHERE notification_id=? AND username=?",
                (notification_id, username))
        self.db.commit()

    def read_ids(self, username):
        return {row[0] for row in self.db.execute(
            "SELECT notification_id FROM notification_reads"
            " WHERE username=?", (username,))}

    # -- notification prefs -----------------------------------------
    def get_prefs(self, username):
        row = self.db.execute(
            "SELECT prefs FROM notification_prefs WHERE username=?",
            (username,)).fetchone()
        if not row:
            return {}
        try:
            prefs = json.loads(row[0] or "{}")
        except ValueError:
            return {}
        return prefs if isinstance(prefs, dict) else {}

    def set_prefs(self, username, prefs):
        self.db.execute(
            "INSERT OR REPLACE INTO notification_prefs VALUES (?,?,?)",
            (username, json.dumps(prefs), _now()))
        self.db.commit()
        return self.get_prefs(username)
