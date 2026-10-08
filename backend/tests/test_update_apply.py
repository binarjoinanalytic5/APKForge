"""Local update apply/local-status tests (guards, no real spawn)."""
import json
import os
import sys
from pathlib import Path

import pytest
from fastapi.testclient import TestClient

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))
sys.path.insert(0, str(ROOT))

GOV = ROOT / ".governance"


@pytest.fixture()
def app(tmp_path, monkeypatch):
    monkeypatch.setenv("APKFORGE_KEY",
                       "apply-test-key-0123456789abcdef-!")
    monkeypatch.setenv("APKFORGE_DB", str(tmp_path / "a.db"))
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
def admin(client):
    response = client.post(
        "/api/v1/auth/register",
        json={"username": "ap-admin",
              "password": "ap-password-12345"})
    return {"Authorization": "Bearer " + response.json()["access_token"]}


@pytest.fixture()
def viewer(client):
    client.post("/api/v1/auth/register",
                json={"username": "g-admin",
                      "password": "g-password-12345"})
    response = client.post(
        "/api/v1/auth/register",
        json={"username": "ap-viewer",
              "password": "ap-password-12345"})
    return {"Authorization": "Bearer " + response.json()["access_token"]}


@pytest.fixture(autouse=True)
def clean_state():
    yield
    for name in ("update.lock", "update-state.json"):
        (GOV / name).unlink(missing_ok=True)


def test_idle_status_and_already_updated(client, admin):
    status = client.get("/api/v1/admin/updates/local-status",
                        headers=admin).json()
    assert status["state"] == "IDLE"
    assert status["locked"] is False
    response = client.post("/api/v1/admin/updates/apply", json={},
                           headers=admin)
    assert response.status_code == 400
    assert "no published release" in response.text


def test_busy_and_stale_lock(client, admin):
    GOV.mkdir(parents=True, exist_ok=True)
    (GOV / "update.lock").write_text(
        json.dumps({"run_id": "APKFORGE-LIVE", "pid": os.getpid()}),
        encoding="utf-8")
    response = client.post("/api/v1/admin/updates/apply", json={},
                           headers=admin)
    assert response.status_code == 400
    assert "already running" in response.text
    (GOV / "update.lock").write_text(
        json.dumps({"run_id": "APKFORGE-STALE", "pid": 999999999}),
        encoding="utf-8")
    response = client.post("/api/v1/admin/updates/apply", json={},
                           headers=admin)
    assert response.status_code == 400
    assert "no published release" in response.text
    assert not (GOV / "update.lock").exists()


def test_apply_rbac(client, admin, viewer):
    assert client.get("/api/v1/admin/updates/local-status",
                      headers=viewer).status_code == 403
    assert client.post("/api/v1/admin/updates/apply", json={},
                       headers=viewer).status_code == 403
