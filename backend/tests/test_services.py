"""Service-layer tests: auth, projects, jobs (no HTTP)."""
import sys
import zipfile
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))

from app.core.security import AuthError, create_token  # noqa: E402
from app.core.store import SqliteStore  # noqa: E402
from app.core.rbac import RBACError  # noqa: E402
from app.services.auth import AuthService  # noqa: E402
from app.services.jobs import JobService  # noqa: E402
from app.services.projects import ProjectService  # noqa: E402
from app.storage import LocalBlobStore  # noqa: E402

KEY = "service-test-key-0123456789abcdef-XY"


class FakeRegistry:
    def __init__(self, plugins):
        self._plugins = dict(plugins)

    def get(self, name):
        try:
            return self._plugins[name]
        except KeyError:
            raise LookupError(name) from None

    def names(self):
        return sorted(self._plugins)


class FakePlugin:
    def run(self, payload):  # pragma: no cover - runner is faked too
        raise AssertionError("runner is faked in these tests")


class FakeRunner:
    def __init__(self, report):
        self._report = report
        self.seen = []

    def run_job(self, kind, plugin, payload):
        self.seen.append((kind, plugin, payload))
        return dict(self._report)


@pytest.fixture()
def store():
    return SqliteStore(":memory:")


@pytest.fixture()
def auth(store):
    return AuthService(store, KEY)


@pytest.fixture()
def admin(auth):
    auth.register("root-admin", "root-password-12345")
    return {"sub": "root-admin", "role": "admin"}


@pytest.fixture()
def jobs(store, tmp_path):
    blobs = LocalBlobStore(tmp_path / "blobs")
    out = tmp_path / "out"
    out.mkdir()
    (out / "AndroidManifest.xml").write_text("<manifest/>")
    runner = FakeRunner({"status": "succeeded",
                         "output": {"out_dir": str(out)},
                         "log_lines": ["fake decode"]})
    registry = FakeRegistry({"apktool": FakePlugin()})
    return JobService(store, blobs, runner, registry,
                      {"decompile": "apktool", "rebuild": "apktool"},
                      tmp_path / "work")


# -- auth -----------------------------------------------------------
def test_bootstrap_first_user_is_admin(auth, store):
    token = auth.register("first-user", "first-password-12345")
    assert token["token_type"] == "bearer"
    assert store.get_user("first-user")["role"] == "admin"


def test_second_user_defaults_to_viewer(auth, store):
    auth.register("first-user", "first-password-12345")
    auth.register("second-user", "second-password-12345")
    assert store.get_user("second-user")["role"] == "viewer"


def test_duplicate_and_bad_role_rejected(auth):
    auth.register("first-user", "first-password-12345")
    with pytest.raises(AuthError):
        auth.register("first-user", "other-password-12345")
    with pytest.raises(AuthError):
        auth.register("nope", "short")
    with pytest.raises(AuthError):
        auth.register("second", "second-password-12345",
                      role="admin")


def test_login_ok_and_denied_and_audited(auth, store):
    auth.register("alice-user", "alice-password-12345")
    token = auth.login("alice-user", "alice-password-12345")
    assert token["access_token"]
    with pytest.raises(AuthError):
        auth.login("alice-user", "wrong-password-12345")
    with pytest.raises(AuthError):
        auth.login("ghost", "ghost-password-12345")
    actions = [row["action"] for row in store.list_audit()]
    assert "auth.login" in actions


def test_verify_roundtrip_and_unknown_user(auth):
    auth.register("bob-user", "bob-password-12345")
    token = auth.login("bob-user", "bob-password-12345")
    who = auth.verify(token["access_token"])
    assert who == {"sub": "bob-user", "role": "admin"}
    ghost = create_token("ghost", "viewer", KEY)
    with pytest.raises(AuthError):
        auth.verify(ghost)


# -- projects -------------------------------------------------------
def test_project_crud(store, admin):
    svc = ProjectService(store)
    project = svc.create(admin, "demo")
    assert project["id"].startswith("prj-")
    assert svc.get(admin, project["id"])["name"] == "demo"
    assert len(svc.list(admin)) == 1
    svc.delete(admin, project["id"])
    assert svc.list(admin) == []
    with pytest.raises(LookupError):
        svc.get(admin, project["id"])


def test_project_rbac(store):
    svc = ProjectService(store)
    viewer = {"sub": "v", "role": "viewer"}
    with pytest.raises(RBACError):
        svc.create(viewer, "nope")
    with pytest.raises(ValueError):
        svc.create({"sub": "a", "role": "admin"}, "")


# -- jobs ------------------------------------------------------------
def test_upload_start_execute_success(store, admin, jobs):
    project = ProjectService(store).create(admin, "app")
    uploaded = jobs.store_upload(admin, project["id"], "app.apk",
                                 b"fake-apk-bytes")
    assert uploaded["status"] == "succeeded"
    job = jobs.start(admin, project["id"], "decompile")
    assert job["status"] == "queued"
    assert job["input_ref"] == uploaded["result_ref"]
    done = jobs.execute(job["job_id"])
    assert done["status"] == "succeeded"
    blob = jobs.blobs.get_bytes(done["result_ref"])
    assert zipfile.is_zipfile(__import__("io").BytesIO(blob))
    assert jobs.runner.seen[0][0] == "decompile"


def test_execute_without_input_fails_explicitly(store, admin, jobs):
    project = ProjectService(store).create(admin, "empty")
    job = jobs.start(admin, project["id"], "decompile")
    done = jobs.execute(job["job_id"])
    assert done["status"] == "failed"
    assert "upload an APK" in done["error"]


def test_unbound_kind_fails_explicitly(store, admin, jobs):
    project = ProjectService(store).create(admin, "app")
    jobs.store_upload(admin, project["id"], "app.apk", b"x")
    job = jobs.start(admin, project["id"], "analyze")
    done = jobs.execute(job["job_id"])
    assert done["status"] == "failed"
    assert "no plugin bound" in done["error"]


def test_unknown_tool_option_fails_explicitly(store, admin, jobs):
    project = ProjectService(store).create(admin, "app")
    jobs.store_upload(admin, project["id"], "app.apk", b"x")
    job = jobs.start(admin, project["id"], "decompile",
                     options={"tool": "nope"})
    done = jobs.execute(job["job_id"])
    assert done["status"] == "failed"
    assert "unknown tool 'nope'" in done["error"]
    assert "apktool" in done["error"]


def test_runner_failure_fails_job(store, admin, tmp_path):
    blobs = LocalBlobStore(tmp_path / "blobs")
    runner = FakeRunner({"status": "failed", "error": "tool exploded",
                         "log_lines": ["boom"]})
    svc = JobService(store, blobs, runner,
                     FakeRegistry({"apktool": FakePlugin()}),
                     {"decompile": "apktool"}, tmp_path / "work")
    project = ProjectService(store).create(admin, "app")
    svc.store_upload(admin, project["id"], "app.apk", b"x")
    job = svc.start(admin, project["id"], "decompile")
    done = svc.execute(job["job_id"])
    assert done["status"] == "failed"
    assert "tool exploded" in done["error"]


def test_job_reads_and_rbac(store, admin, jobs):
    project = ProjectService(store).create(admin, "app")
    uploaded = jobs.store_upload(admin, project["id"], "app.apk",
                                 b"bytes")
    viewer = {"sub": "v", "role": "viewer"}
    assert jobs.get(viewer, uploaded["job_id"])["kind"] == "upload"
    logs = jobs.logs(viewer, uploaded["job_id"])
    assert logs["job_id"] == uploaded["job_id"]
    assert logs["lines"]
    latest = jobs.latest_result(viewer, project["id"])
    assert latest["job_id"] == uploaded["job_id"]
    with pytest.raises(RBACError):
        jobs.start(viewer, project["id"], "decompile")
    with pytest.raises(LookupError):
        jobs.get(viewer, "job-missing")
