"""APKForge API entrypoint (Phase 1: local-first backends).

Configuration is environment-only (no config files with credentials):
  APKFORGE_KEY      JWT/HMAC signing key, >=32 chars (required)
  APKFORGE_DB       SQLite path (default ./data/apkforge.db)
  APKFORGE_BLOBS    blob directory (default ./data/blobs)
  APKFORGE_WORK     job work directory (default ./data/work)
  APKFORGE_PLUGINS  plugins root (default <repo>/plugins)
  APKFORGE_CORS     comma-separated origins, or * (default *)

Phase 1 runs jobs inline via BackgroundTasks; Celery workers attach
to the same JobService in Phase 2 (see workers/celery_app.py).
"""
import os
import sys
from pathlib import Path

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from workers.loader import load_plugins  # noqa: E402
from workers.runner import Runner  # noqa: E402

from .api import auth as auth_routes  # noqa: E402
from .api import jobs as job_routes  # noqa: E402
from .api import projects as project_routes  # noqa: E402
from .api import ws as ws_routes  # noqa: E402
from .core.security import resolve_key  # noqa: E402
from .core.store import SqliteStore  # noqa: E402
from .services.auth import AuthService  # noqa: E402
from .services.jobs import JobService  # noqa: E402
from .services.projects import ProjectService  # noqa: E402
from .storage import LocalBlobStore  # noqa: E402
from .version import API_VERSION  # noqa: E402

KIND_DEFAULT_PLUGIN = {
    "decompile": "apktool",
    "rebuild": "apktool",
    # analyze/sign bind real plugins in Phase 2; until then jobs fail
    # explicitly instead of pretending to run.
}


def _data_dir(name, default):
    path = Path(os.environ.get(name, default))
    path.mkdir(parents=True, exist_ok=True)
    return path


def build_services():
    """Build every backend from the environment (also used by tests)."""
    key = resolve_key()
    data = Path(os.environ.get("APKFORGE_DATA", "data"))
    db_path = os.environ.get("APKFORGE_DB", str(data / "apkforge.db"))
    Path(db_path).parent.mkdir(parents=True, exist_ok=True)
    blobs = LocalBlobStore(_data_dir("APKFORGE_BLOBS",
                                     data / "blobs"))
    work = _data_dir("APKFORGE_WORK", data / "work")
    plugins_root = os.environ.get("APKFORGE_PLUGINS",
                                  str(ROOT / "plugins"))
    store = SqliteStore(db_path)
    registry = load_plugins(plugins_root)
    runner = Runner()
    auth = AuthService(store, key)
    projects = ProjectService(store)
    jobs = JobService(store, blobs, runner, registry,
                      KIND_DEFAULT_PLUGIN, work)
    services = {"auth": auth, "projects": projects, "jobs": jobs,
                "blobs": blobs, "store": store, "registry": registry}
    return services, jobs


def create_app():
    services, _jobs = build_services()
    app = FastAPI(title="APKForge API", version=API_VERSION)
    app.state.services = services
    origins = [origin.strip()
               for origin in os.environ.get("APKFORGE_CORS", "*")
               .split(",") if origin.strip()]
    app.add_middleware(
        CORSMiddleware, allow_origins=origins or ["*"],
        allow_credentials=True, allow_methods=["*"],
        allow_headers=["*"])

    @app.get("/api/v1/health")
    def health():
        return {"status": "ok", "api_version": API_VERSION}

    app.include_router(auth_routes.router)
    app.include_router(project_routes.router)
    app.include_router(job_routes.router)
    app.include_router(ws_routes.router)
    return app


app = create_app()
