"""Update + admin API tests (lifecycle, check, manifest, guards)."""
import json
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
                       "update-test-key-0123456789abcdef-!")
    monkeypatch.setenv("APKFORGE_DB", str(tmp_path / "u.db"))
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
        json={"username": "upd-admin",
              "password": "upd-password-12345"})
    assert response.status_code == 201
    return {"Authorization": "Bearer " + response.json()["access_token"]}


@pytest.fixture()
def viewer(client):
    client.post("/api/v1/auth/register",
                json={"username": "first-admin",
                      "password": "first-password-12345"})
    response = client.post(
        "/api/v1/auth/register",
        json={"username": "upd-viewer",
              "password": "upd-password-12345"})
    return {"Authorization": "Bearer " + response.json()["access_token"]}


def _release(**over):
    body = {"version": "1.1.0", "release_type": "MINOR",
            "channel": "STABLE",
            "minimum_supported_version": "1.0.0",
            "artifact_kind": "bundle",
            "download_url": "https://example.test/1.1.0.zip",
            "checksum": "c" * 64, "signature": "d" * 64,
            "size_bytes": 100,
            "release_notes": ["faster", "fixed"]}
    body.update(over)
    return body


def _publish(client, headers, **over):
    created = client.post("/api/v1/admin/releases",
                          json=_release(**over), headers=headers)
    assert created.status_code == 201, created.text
    release_id = created.json()["id"]
    assert client.post(
        "/api/v1/admin/releases/%s/validate" % release_id,
        headers=headers).status_code == 200
    published = client.post(
        "/api/v1/admin/releases/%s/publish" % release_id,
        headers=headers)
    assert published.status_code == 200, published.text
    return published.json()


def test_current_reports_app_version(client):
    response = client.get("/api/v1/updates/current")
    assert response.status_code == 200
    body = response.json()
    assert body["version"] == "1.0.0"
    assert body["version_code"] == 10000
    assert body["channel"] == "STABLE"


def test_manifest_404_without_releases(client):
    assert client.get("/api/v1/updates/manifest").status_code == 404


def test_lifecycle_and_rbac(client, admin, viewer):
    denied = client.post("/api/v1/admin/releases",
                         json=_release(), headers=viewer)
    assert denied.status_code == 403
    created = client.post("/api/v1/admin/releases", json=_release(),
                          headers=admin)
    assert created.status_code == 201
    release_id = created.json()["id"]
    assert created.json()["status"] == "draft"
    dupe = client.post("/api/v1/admin/releases", json=_release(),
                       headers=admin)
    assert dupe.status_code == 400
    early = client.post("/api/v1/admin/releases/%s/publish" % release_id,
                        headers=admin)
    assert early.status_code == 400
    assert client.post("/api/v1/admin/releases/%s/validate" % release_id,
                       headers=admin).status_code == 200
    published = client.post(
        "/api/v1/admin/releases/%s/publish" % release_id,
        headers=admin)
    assert published.json()["status"] == "published"
    notes = client.get("/api/v1/notifications", headers=admin).json()
    assert notes["unread"] >= 1
    assert any(n["ntype"] == "UPDATE_AVAILABLE"
               for n in notes["notifications"])
    history = client.get("/api/v1/admin/releases/history",
                         headers=admin).json()
    assert [item["version"] for item in history] == ["1.1.0"]
    assert client.post("/api/v1/admin/releases/%s/unpublish"
                       % release_id, headers=admin).status_code == 200
    assert client.get("/api/v1/updates/manifest").status_code == 404


def test_validate_rejects_incoherent_bundle(client, admin):
    body = _release(version="1.2.0")
    del body["checksum"]
    created = client.post("/api/v1/admin/releases", json=body,
                          headers=admin)
    assert created.status_code == 201
    response = client.post(
        "/api/v1/admin/releases/%s/validate" % created.json()["id"],
        headers=admin)
    assert response.status_code == 400
    assert "checksum" in response.text


def test_check_matrix(client, admin):
    _publish(client, admin, version="1.1.0")
    same = client.post("/api/v1/updates/check",
                       json={"current_version": "1.1.0"})
    assert same.json()["status"] == "NO_UPDATE"
    older = client.post("/api/v1/updates/check",
                        json={"current_version": "1.0.0"})
    assert older.json()["status"] == "UPDATE_AVAILABLE"
    assert older.json()["latest_version"] == "1.1.0"
    bad = client.post("/api/v1/updates/check",
                      json={"current_version": "1.x"})
    assert bad.status_code == 400
    bad_channel = client.post(
        "/api/v1/updates/check",
        json={"current_version": "1.0.0", "channel": "GAMMA"})
    assert bad_channel.status_code == 400


def test_mandatory_and_minimum(client, admin):
    _publish(client, admin, version="1.1.0", mandatory=True)
    response = client.post("/api/v1/updates/check",
                           json={"current_version": "1.0.0"})
    assert response.json()["status"] == "MANDATORY_UPDATE"
    _publish(client, admin, version="1.2.0",
             minimum_supported_version="1.2.0")
    response = client.post("/api/v1/updates/check",
                           json={"current_version": "1.0.0"})
    assert response.json()["status"] == "MANDATORY_UPDATE"


def test_channel_isolation_and_etag(client, admin):
    _publish(client, admin, version="1.1.0", channel="BETA")
    stable = client.get("/api/v1/updates/manifest?channel=STABLE")
    assert stable.status_code == 404
    beta = client.get("/api/v1/updates/manifest?channel=BETA")
    assert beta.status_code == 200
    assert beta.json()["latest_version"] == "1.1.0"
    assert "etag" in {key.lower() for key in beta.headers}
    again = client.get("/api/v1/updates/manifest?channel=BETA",
                       headers={"If-None-Match": beta.headers["etag"]})
    assert again.status_code == 304


def test_maintenance_gate(client, admin, viewer):
    denied = client.put("/api/v1/admin/maintenance",
                        json={"active": True}, headers=viewer)
    assert denied.status_code == 403
    assert client.put("/api/v1/admin/maintenance",
                      json={"active": True, "message": "upgrading"},
                      headers=admin).status_code == 200
    blocked = client.get("/api/v1/projects", headers=admin)
    assert blocked.status_code == 503
    assert blocked.json()["code"] == "MAINTENANCE"
    assert client.get("/api/v1/health").status_code == 200
    assert client.post("/api/v1/updates/check",
                       json={"current_version": "9.9.9"}).json()[
        "maintenance"]["active"] is True
    assert client.put("/api/v1/admin/maintenance",
                      json={"active": False},
                      headers=admin).status_code == 200
    assert client.get("/api/v1/projects", headers=admin).status_code \
        == 200


def test_channel_admin(client, admin, viewer):
    assert client.get("/api/v1/admin/channel",
                      headers=admin).json() == {"channel": "STABLE"}
    assert client.put("/api/v1/admin/channel",
                      json={"channel": "NOPE"},
                      headers=admin).status_code == 400
    assert client.put("/api/v1/admin/channel",
                      json={"channel": "BETA"},
                      headers=viewer).status_code == 403
    assert client.put("/api/v1/admin/channel",
                      json={"channel": "BETA"},
                      headers=admin).json() == {"channel": "BETA"}


def test_backups_endpoint_lists_registry(client, admin):
    empty = client.get("/api/v1/admin/backups", headers=admin)
    assert empty.json() == {"backups": []}
    registry = ROOT / ".governance" / "backups.json"
    registry.parent.mkdir(parents=True, exist_ok=True)
    had = registry.is_file()
    previous = registry.read_text(encoding="utf-8") if had else None
    try:
        registry.write_text(json.dumps({"backups": [
            {"id": "bu-test", "version_from": "1.0.0",
             "version_to": "1.1.0"}]}), encoding="utf-8")
        filled = client.get("/api/v1/admin/backups", headers=admin)
        backup = filled.json()["backups"][0]
        assert backup["rollback_command"] == \
            "./apkforge update --rollback bu-test"
    finally:
        if had:
            registry.write_text(previous, encoding="utf-8")
        else:
            registry.unlink()
