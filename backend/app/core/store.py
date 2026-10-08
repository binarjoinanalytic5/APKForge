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
