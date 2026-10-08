"""Celery binding (queues attach in Phase 2; import-safe today).

Without celery installed the module still imports: the task entrypoint
stays a plain function so API tests never need a broker. With celery,
`apkforge.run_job` executes the same JobService path the API uses.
"""
import os

try:
    from celery import Celery
except ImportError:  # Phase-1 unit context: broker optional
    Celery = None

CELERY_AVAILABLE = Celery is not None

if CELERY_AVAILABLE:
    celery_app = Celery(
        "apkforge",
        broker=os.environ.get("APKFORGE_REDIS",
                              "redis://localhost:6379/0"),
        backend=os.environ.get("APKFORGE_REDIS",
                               "redis://localhost:6379/0"))
    celery_app.conf.update(task_acks_late=True,
                           worker_prefetch_multiplier=1,
                           task_time_limit=3600)
else:
    celery_app = None


def execute_job(job_id):
    """Run one queued job through the service layer (lazy imports)."""
    import sys
    from pathlib import Path
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]
                           / "backend"))
    from app.main import app as api_app
    return api_app.state.services["jobs"].execute(job_id)


if CELERY_AVAILABLE:
    run_job_task = celery_app.task(name="apkforge.run_job")(execute_job)
else:
    def run_job_task(job_id):
        return execute_job(job_id)
