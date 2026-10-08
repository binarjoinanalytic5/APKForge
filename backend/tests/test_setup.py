"""First-run setup endpoint tests (one-shot admin creation)."""
import sys
from pathlib import Path

import pytest
from fastapi.testclient import TestClient

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))
sys.path.insert(0, str(ROOT))


@pytest.fixture()
def app(tmp_path, monkeypatch):
    monkeypatch.setenv("APKFORGE_KEY",
                       "setup-test-key-0123456789abcdef-Z!")
    monkeypatch.setenv("APKFORGE_DB", str(tmp_path / "s.db"))
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


def test_status_false_on_fresh_system(client):
    response = client.get("/api/v1/setup/status")
    assert response.status_code == 200
    assert response.json() == {"initialized": False}


def test_setup_creates_owner_admin_once(client):
    created = client.post(
        "/api/v1/setup/admin",
        json={"username": "owner-admin",
              "password": "owner-password-12345",
              "display_name": "Owner",
              "email": "owner@example.test"})
    assert created.status_code == 201
    body = created.json()
    assert body["username"] == "owner-admin"
    assert body["role"] == "admin"
    assert body["token_type"] == "bearer"
    assert body["access_token"]
    assert client.get("/api/v1/setup/status").json() == \
        {"initialized": True}
    logged = client.post(
        "/api/v1/auth/login",
        json={"username": "owner-admin",
              "password": "owner-password-12345"})
    assert logged.status_code == 200


def test_second_setup_rejected_with_403(client):
    client.post("/api/v1/setup/admin",
                json={"username": "first-admin",
                      "password": "first-password-12345"})
    again = client.post(
        "/api/v1/setup/admin",
        json={"username": "second-admin",
              "password": "second-password-12345"})
    assert again.status_code == 403
    assert again.json()["code"] == "SYSTEM_INITIALIZED"


def test_setup_validates_input(client):
    short = client.post(
        "/api/v1/setup/admin",
        json={"username": "ab", "password": "short"})
    assert short.status_code == 422
    assert client.get("/api/v1/setup/status").json() == \
        {"initialized": False}
