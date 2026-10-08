"""Job lifecycle: create → execute (runner) → terminal + audit.

Phase 1 executes synchronously inside a FastAPI BackgroundTask (the
202 response returns first; status/log polling + WebSocket observe the
run). Celery workers bind the same runner in Phase 2.

Plugin selection: `options.tool` overrides the kind default; unknown
or unbound tools fail the job with an explicit reason (never a crash,
never a silent no-op).
"""
import io
import json
import shutil
import zipfile
from pathlib import Path

from ..core.rbac import audit_record, require

TERMINAL = ("succeeded", "failed", "cancelled")
KIND_PERMISSION = {
    "upload": "artifact.upload",
    "decompile": "job.decompile",
    "analyze": "job.analyze",
    "rebuild": "job.rebuild",
    "sign": "job.sign",
}


class JobService:
    def __init__(self, store, blobs, runner, registry, kind_default,
                 work_root):
        self.store = store
        self.blobs = blobs
        self.runner = runner
        self.registry = registry
        self.kind_default = dict(kind_default)
        self.work_root = Path(work_root)
        self.work_root.mkdir(parents=True, exist_ok=True)

    # -- creation ---------------------------------------------------
    def start(self, actor, project_id, kind, input_ref=None,
              options=None):
        if kind not in KIND_PERMISSION:
            raise ValueError("unknown job kind %r" % (kind,))
        require(actor["role"], KIND_PERMISSION[kind])
        if not self.store.get_project(project_id):
            raise LookupError("project not found")
        if input_ref is None:
            input_ref = self._latest_upload_ref(project_id)
        job = self.store.create_job(project_id, kind,
                                    input_ref=input_ref,
                                    options=options or {})
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="job.%s.start" % kind,
            target=job["job_id"], result="ok",
            detail={"project": project_id,
                    "options": options or {}}))
        return self.store.get_job(job["job_id"])

    def _latest_upload_ref(self, project_id):
        for job in reversed(
                self.store.list_project_jobs(project_id)):
            if job["kind"] == "upload" and job["status"] == "succeeded" \
                    and job.get("result_ref"):
                return job["result_ref"]
        return None

    def store_upload(self, actor, project_id, filename, data):
        require(actor["role"], "artifact.upload")
        if not self.store.get_project(project_id):
            raise LookupError("project not found")
        if len(data) > 256 * 1024 * 1024:
            raise ValueError("file exceeds 256 MB")
        record = self.blobs.put_bytes(bytes(data), name=filename)
        self.store.put_artifact(record["sha256"], filename,
                                record["size"], "apk", project_id)
        job = self.store.create_job(project_id, "upload",
                                    input_ref=record["sha256"])
        self.store.set_job(job["job_id"], status="succeeded",
                           result_ref=record["sha256"],
                           log_lines=["stored %s (%d bytes, sha256=%s)"
                                      % (filename, record["size"],
                                         record["sha256"][:16])])
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="artifact.upload",
            target=record["sha256"], result="ok",
            detail={"project": project_id, "size": record["size"]}))
        return self.store.get_job(job["job_id"])

    # -- execution (background) -------------------------------------
    def execute(self, job_id):
        job = self.store.get_job(job_id)
        if not job or job["status"] != "queued":
            return None
        self.store.set_job(job_id, status="running")
        lines = ["job %s (%s) started" % (job_id, job["kind"])]
        try:
            plugin_name = (job.get("options") or {}).get("tool") \
                or self.kind_default.get(job["kind"])
            if not plugin_name:
                raise RuntimeError(
                    "no plugin bound to kind %r in Phase 1 "
                    "(decompile/rebuild only)" % (job["kind"],))
            try:
                plugin = self.registry.get(plugin_name)
            except Exception:
                raise RuntimeError(
                    "unknown tool %r (available: %s)"
                    % (plugin_name,
                       ", ".join(self.registry.names()))) from None
            if not job.get("input_ref"):
                raise RuntimeError(
                    "no input: upload an APK to this project first")
            payload = self._payload(job)
            report = self.runner.run_job(job["kind"], plugin, payload)
            lines.extend(report.get("log_lines", []))
            if report.get("status") != "succeeded":
                raise RuntimeError(report.get("error") or "runner failed")
            result_ref = self._store_result(job, report.get("output"))
            self.store.set_job(job_id, status="succeeded",
                               result_ref=result_ref, log_lines=lines)
        except Exception as exc:
            lines.append("FAILED: %s" % exc)
            self.store.set_job(job_id, status="failed",
                               error=str(exc)[:2000], log_lines=lines)
        self.store.append_audit(audit_record(
            actor="system", action="job.execute", target=job_id,
            result=self.store.get_job(job_id)["status"]))
        return self.store.get_job(job_id)

    def _payload(self, job):
        payload = {"job_id": job["job_id"],
                   "project_id": job["project_id"],
                   "kind": job["kind"],
                   "options": job.get("options") or {}}
        payload["input_path"] = self.blobs.path_for(job["input_ref"])
        payload["input_sha256"] = job["input_ref"]
        run_dir = self.work_root / job["job_id"]
        run_dir.mkdir(parents=True, exist_ok=True)
        payload["out_dir"] = str(run_dir / "out")
        return payload

    def _store_result(self, job, output):
        output = output if isinstance(output, dict) else {"value": output}
        out_dir = output.get("out_dir")
        if out_dir and Path(out_dir).is_dir():
            buffer = io.BytesIO()
            with zipfile.ZipFile(buffer, "w",
                                 zipfile.ZIP_DEFLATED) as archive:
                for path in sorted(Path(out_dir).rglob("*")):
                    if path.is_file():
                        archive.write(path, path.relative_to(out_dir))
            record = self.blobs.put_bytes(
                buffer.getvalue(),
                name="%s-%s.zip" % (job["kind"], job["job_id"]))
        else:
            record = self.blobs.put_bytes(
                json.dumps(output, sort_keys=True).encode("utf-8"),
                name="%s-%s.json" % (job["kind"], job["job_id"]))
        self.store.put_artifact(record["sha256"], record["name"],
                                record["size"], "result",
                                job["project_id"])
        return record["sha256"]

    # -- reads ------------------------------------------------------
    def get(self, actor, job_id):
        require(actor["role"], "job.read")
        job = self.store.get_job(job_id)
        if not job:
            raise LookupError("job not found")
        return job

    def logs(self, actor, job_id):
        require(actor["role"], "job.read")
        job = self.store.get_job(job_id)
        if not job:
            raise LookupError("job not found")
        return {"job_id": job_id, "lines": job["log_lines"]}

    def latest_result(self, actor, project_id):
        require(actor["role"], "artifact.download")
        if not self.store.get_project(project_id):
            raise LookupError("project not found")
        jobs = [job for job in self.store.list_project_jobs(project_id)
                if job["status"] == "succeeded" and job.get("result_ref")]
        if not jobs:
            raise LookupError("no succeeded job with a result")
        return jobs[-1]

    def cleanup_run_dir(self, job_id, *, keep=False):
        if keep:
            return
        shutil.rmtree(self.work_root / job_id, ignore_errors=True)
