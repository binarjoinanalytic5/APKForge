"""CLI tests against an in-process stub API (stdlib only)."""
import io
import json
import os
import sys
import threading
from contextlib import redirect_stdout
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))

import apkforge


class Stub(BaseHTTPRequestHandler):
    routes = {}
    seen = []

    def _send(self, status, payload, ctype="application/json"):
        body = payload if isinstance(payload, bytes) else \
            json.dumps(payload).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def _handle(self):
        length = int(self.headers.get("Content-Length", 0) or 0)
        raw = self.rfile.read(length) if length else b""
        Stub.seen.append((self.command, self.path,
                          dict(self.headers), raw))
        handler = Stub.routes.get((self.command, self.path.split("?")[0]))
        if handler is None:
            return self._send(404, {"code": "x", "message": "nope"})
        status, payload = handler(self, raw)
        if isinstance(payload, bytes):
            return self._send(status, payload,
                              "application/octet-stream")
        return self._send(status, payload)

    do_GET = do_POST = do_DELETE = _handle

    def log_message(self, *args):
        pass


@pytest.fixture()
def stub(monkeypatch, tmp_path):
    Stub.routes = {}
    Stub.seen = []
    server = HTTPServer(("127.0.0.1", 0), Stub)
    thread = threading.Thread(target=server.serve_forever,
                              daemon=True)
    thread.start()
    monkeypatch.setenv("HOME", str(tmp_path))
    monkeypatch.delenv("APKFORGE_TOKEN", raising=False)
    monkeypatch.delenv("APKFORGE_URL", raising=False)
    yield "http://127.0.0.1:%d" % server.server_port
    server.shutdown()


def _run(argv):
    buffer = io.StringIO()
    with redirect_stdout(buffer):
        code = apkforge.main(argv)
    return code, buffer.getvalue()


def test_login_with_token_saves_config(stub):
    code, out = _run(["login", "--base-url", stub,
                      "--token", "tok-123"])
    assert code == 0
    assert json.loads(out)["saved"] is True
    config = json.loads(Path(
        os.environ["HOME"], ".config", "apkforge",
        "config.json").read_text())
    assert config == {"base_url": stub, "token": "tok-123"}


def test_login_with_password_posts_credentials(stub):
    def login(request, raw):
        body = json.loads(raw.decode("utf-8"))
        assert body == {"username": "u", "password": "p" * 12}
        return 200, {"access_token": "tok-x", "token_type": "bearer"}

    Stub.routes[("POST", "/api/v1/auth/login")] = login
    code, _ = _run(["login", "--base-url", stub, "--username", "u",
                    "--password", "p" * 12])
    assert code == 0


def test_project_create_lists_paths(stub):
    Stub.routes[("POST", "/api/v1/projects")] = \
        lambda req, raw: (201, {"id": "prj-1"})
    code, out = _run(["--base-url", stub, "--token", "t", "project",
                      "create", "--name", "demo"])
    assert code == 0
    assert json.loads(out)["id"] == "prj-1"
    method, path, _headers, raw = Stub.seen[0]
    assert (method, path) == ("POST", "/api/v1/projects")
    assert json.loads(raw.decode("utf-8")) == {"name": "demo"}


def test_decompile_with_tool_and_wait(stub):
    Stub.routes[("POST", "/api/v1/projects/prj-1/decompile")] = \
        lambda req, raw: (202, {"job_id": "job-9",
                                "status": "queued"})
    calls = []

    def job(request, raw):
        calls.append(1)
        status = "running" if len(calls) < 2 else "succeeded"
        return 200, {"job_id": "job-9", "status": status}

    Stub.routes[("GET", "/api/v1/jobs/job-9")] = job
    code, out = _run(["--base-url", stub, "--token", "t",
                      "decompile", "--project-id", "prj-1",
                      "--tool", "jadx", "--wait", "--timeout", "30"])
    assert code == 0
    assert json.loads(out)["status"] == "succeeded"
    _, _, _, raw = Stub.seen[0]
    assert json.loads(raw.decode("utf-8")) == {"tool": "jadx"}


def test_logs_and_download(stub, tmp_path):
    Stub.routes[("GET", "/api/v1/jobs/job-1/logs")] = \
        lambda req, raw: (200, {"job_id": "job-1",
                                "lines": ["a", "b"]})
    Stub.routes[("GET", "/api/v1/projects/prj-1/download")] = \
        lambda req, raw: (200, b"BLOB")
    code, out = _run(["--base-url", stub, "--token", "t", "logs",
                      "--id", "job-1"])
    assert code == 0 and out == "a\nb\n"
    target = tmp_path / "result.bin"
    code, out = _run(["--base-url", stub, "--token", "t", "download",
                      "--project-id", "prj-1",
                      "--output", str(target)])
    assert code == 0
    assert target.read_bytes() == b"BLOB"


def test_upload_sends_multipart(stub, tmp_path):
    Stub.routes[("POST", "/api/v1/projects/prj-1/upload")] = \
        lambda req, raw: (202, {"job_id": "job-2"})
    apk = tmp_path / "app.apk"
    apk.write_bytes(b"APKBYTES")
    code, out = _run(["--base-url", stub, "--token", "t", "upload",
                      "--project-id", "prj-1", "--file", str(apk)])
    assert code == 0
    _m, _p, headers, raw = Stub.seen[0]
    assert "multipart/form-data" in headers["Content-Type"]
    assert b"APKBYTES" in raw


def test_http_error_exit_code_and_missing_token(stub):
    code, _out = _run(["--base-url", stub, "--token", "t", "job",
                       "--id", "missing"])
    assert code == 1
    code, _out = _run(["--base-url", stub, "job", "--id", "x"])
    assert code == 1
