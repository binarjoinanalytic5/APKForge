"""API tests: full HTTP flow through a per-test app instance."""
import sys
import time
from pathlib import Path

import pytest
from fastapi.testclient import TestClient

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))
sys.path.insert(0, str(ROOT))

TERMINAL = ("succeeded", "failed", "cancelled")


@pytest.fixture()
def app(tmp_path, monkeypatch):
    monkeypatch.setenv("APKFORGE_KEY",
                       "api-test-key-0123456789abcdef-XYZ!")
    monkeypatch.setenv("APKFORGE_DB", str(tmp_path / "t.db"))
    monkeypatch.setenv("APKFORGE_BLOBS", str(tmp_path / "blobs"))
    monkeypatch.setenv("APKFORGE_WORK", str(tmp_path / "work"))
    monkeypatch.setenv("APKFORGE_PLUGINS", str(ROOT / "plugins"))
    import app.main as main
    import importlib
    importlib.reload(main)
    return main.create_app()


@pytest.fixture()
def client(app):
    return TestClient(app)


@pytest.fixture()
def token(client):
    response = client.post("/api/v1/auth/register",
                           json={"username": "api-admin",
                                 "password": "api-password-12345"})
    assert response.status_code == 201
    return response.json()["access_token"]


def _auth(token):
    return {"Authorization": "Bearer " + token}


def _poll(client, job_id, headers, timeout=60):
    deadline = time.time() + timeout
    while time.time() < deadline:
        response = client.get("/api/v1/jobs/" + job_id,
                              headers=headers)
        assert response.status_code == 200
        job = response.json()
        if job["status"] in TERMINAL:
            return job
        time.sleep(0.2)
    raise AssertionError("job %s never reached terminal" % job_id)


def test_health(client):
    response = client.get("/api/v1/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok", "api_version": "1.0.0"}


def _mount_app(tmp_path, monkeypatch, with_dist):
    """Build an app whose ROOT points at tmp (isolated frontend probe)."""
    if with_dist:
        dist = tmp_path / "frontend" / "dist"
        dist.mkdir(parents=True)
        (dist / "index.html").write_text(
            "<html>APKForge</html>", encoding="utf-8")
    monkeypatch.setenv("APKFORGE_KEY",
                       "mount-test-key-0123456789abcdef-XYZ!")
    monkeypatch.setenv("APKFORGE_DB", str(tmp_path / "t.db"))
    monkeypatch.setenv("APKFORGE_BLOBS", str(tmp_path / "blobs"))
    monkeypatch.setenv("APKFORGE_WORK", str(tmp_path / "work"))
    monkeypatch.setenv("APKFORGE_PLUGINS", str(ROOT / "plugins"))
    import app.main as main
    import importlib
    importlib.reload(main)
    monkeypatch.setattr(main, "ROOT", tmp_path)
    return main.create_app()


def test_frontend_dist_mount_keeps_api_authoritative(
        tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    app = _mount_app(tmp_path, monkeypatch, with_dist=True)
    client = TestClient(app)
    health = client.get("/api/v1/health")
    assert health.status_code == 200
    assert health.json() == {"status": "ok",
                             "api_version": "1.0.0"}
    assert client.get("/openapi.json").status_code == 200
    index = client.get("/")
    assert index.status_code == 200
    assert "APKForge" in index.text


def test_root_404_without_frontend_dist(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    app = _mount_app(tmp_path, monkeypatch, with_dist=False)
    client = TestClient(app)
    assert client.get("/api/v1/health").status_code == 200
    assert client.get("/").status_code == 404


def test_auth_flow_and_errors(client):
    bad = client.post("/api/v1/auth/login",
                      json={"username": "ghost",
                            "password": "ghost-password-1"})
    assert bad.status_code == 401
    created = client.post(
        "/api/v1/auth/register",
        json={"username": "user1", "password": "u1-password-12345"})
    assert created.status_code == 201
    assert created.json()["token_type"] == "bearer"
    logged = client.post(
        "/api/v1/auth/login",
        json={"username": "user1", "password": "u1-password-12345"})
    assert logged.status_code == 200
    dupe = client.post(
        "/api/v1/auth/register",
        json={"username": "user1", "password": "u1-password-12345"})
    assert dupe.status_code == 401


def test_projects_crud_and_authz(client, token):
    headers = _auth(token)
    assert client.post("/api/v1/projects", json={"name": "x"}) \
        .status_code == 401
    created = client.post("/api/v1/projects", json={"name": "demo"},
                          headers=headers)
    assert created.status_code == 201
    project_id = created.json()["id"]
    listed = client.get("/api/v1/projects", headers=headers)
    assert isinstance(listed.json(), list)
    assert listed.json()[0]["id"] == project_id
    assert client.get("/api/v1/projects/" + project_id,
                      headers=headers).status_code == 200
    assert client.delete("/api/v1/projects/" + project_id,
                         headers=headers).status_code == 204
    assert client.get("/api/v1/projects/" + project_id,
                      headers=headers).status_code == 404


def test_viewer_cannot_create_project(client):
    client.post("/api/v1/auth/register",
                json={"username": "owner",
                      "password": "owner-password-123"})
    viewer = client.post(
        "/api/v1/auth/register",
        json={"username": "watcher",
              "password": "watcher-password-1"}).json()["access_token"]
    response = client.post("/api/v1/projects", json={"name": "x"},
                           headers=_auth(viewer))
    assert response.status_code == 403


def test_upload_decompile_wiring_without_tool(client, token):
    """Decompile with no apktool installed must fail explicitly."""
    headers = _auth(token)
    project_id = client.post("/api/v1/projects", json={"name": "a"},
                             headers=headers).json()["id"]
    uploaded = client.post(
        "/api/v1/projects/%s/upload" % project_id, headers=headers,
        files={"file": ("app.apk", b"fake-apk-bytes")})
    assert uploaded.status_code == 202
    assert uploaded.json()["kind"] == "upload"
    started = client.post(
        "/api/v1/projects/%s/decompile" % project_id,
        headers=headers, json={"tool": "apktool"})
    assert started.status_code == 202
    job = _poll(client, started.json()["job_id"], headers)
    assert job["status"] == "failed"
    assert "apktool not installed" in job["error"]
    logs = client.get("/api/v1/jobs/%s/logs" % job["job_id"],
                      headers=headers)
    assert logs.status_code == 200
    assert logs.json()["job_id"] == job["job_id"]
    assert logs.json()["lines"]


def test_download_returns_latest_result(client, token):
    headers = _auth(token)
    project_id = client.post("/api/v1/projects", json={"name": "d"},
                             headers=headers).json()["id"]
    client.post("/api/v1/projects/%s/upload" % project_id,
                headers=headers,
                files={"file": ("app.apk", b"fake-apk-bytes")})
    response = client.get("/api/v1/projects/%s/download" % project_id,
                          headers=headers)
    assert response.status_code == 200
    assert response.content == b"fake-apk-bytes"


def test_analyze_unbound_fails_fast(client, token):
    headers = _auth(token)
    project_id = client.post("/api/v1/projects", json={"name": "n"},
                             headers=headers).json()["id"]
    started = client.post(
        "/api/v1/projects/%s/analyze" % project_id, headers=headers,
        json={})
    assert started.status_code == 202
    job = _poll(client, started.json()["job_id"], headers)
    assert job["status"] == "failed"
    assert "no plugin bound" in job["error"]


def test_websocket_streams_until_terminal(client, token):
    headers = _auth(token)
    project_id = client.post("/api/v1/projects", json={"name": "w"},
                             headers=headers).json()["id"]
    started = client.post(
        "/api/v1/projects/%s/analyze" % project_id, headers=headers,
        json={})
    job_id = started.json()["job_id"]
    frames = []
    with client.websocket_connect(
            "/api/v1/ws/jobs/%s?token=%s"
            % (job_id, token)) as websocket:
        while True:
            try:
                message = websocket.receive_json()
            except Exception:
                break
            frames.append(message)
            if message["type"] == "bye":
                break
    assert frames[0]["type"] == "hello"
    assert frames[0]["job_id"] == job_id
    assert frames[-1]["type"] == "bye"
    assert frames[-1]["status"] == "failed"
