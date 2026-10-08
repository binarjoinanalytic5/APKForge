"""Bootstrap engine unit tests (pure functions only; no side effects)."""
import importlib.util
import os
import socket
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "bootstrap_engine", ROOT / "scripts" / "apkforge.py")
eng = importlib.util.module_from_spec(spec)
spec.loader.exec_module(eng)


def test_parse_version():
    assert eng.parse_version("v20.20.2") == (20, 20, 2)
    assert eng.parse_version("Python 3.13.1") == (3, 13, 1)
    assert eng.parse_version("openjdk 11.0.9") == (11, 0, 9)
    assert eng.parse_version("no digits here") is None
    assert eng.parse_version("") is None


def test_redact_masks_secrets():
    assert "[redacted]" in eng.redact("Authorization: Bearer abc.def")
    assert "s3cr3t" not in eng.redact("token=s3cr3t-value")
    assert "hunter2" not in eng.redact("password: hunter2")
    jwt = ("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9."
           "SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJVadQssw5c")
    assert jwt not in eng.redact("got " + jwt)
    assert eng.redact("port 8000 healthy") == "port 8000 healthy"


def test_run_id_format():
    run_id = eng.new_run_id()
    assert run_id.startswith("APKFORGE-20")
    assert len(run_id.split("-")) == 4


def test_state_machine_complete():
    for state in ("INIT", "ENVIRONMENT_CHECK", "TOOLS_READY",
                  "CONFIG_READY", "DATABASE_READY", "MIGRATIONS_READY",
                  "SEED_READY", "BUILD_READY", "SERVICES_READY",
                  "HEALTHY", "ADMIN_SETUP_REQUIRED", "READY", "FAILED"):
        assert state in eng.STATES


def test_tool_matrix_covers_required():
    kinds = {row["tool"]: row["kind"] for row in eng.TOOL_MATRIX}
    for tool in ("python3", "pip", "node", "npm"):
        assert kinds[tool] == "required"
    assert kinds["apktool"] == "optional"
    assert kinds["docker"] == "not-needed-phase1"


def test_validate_config():
    good = {"APKFORGE_PORT": "8000", "APKFORGE_WEB_PORT": "3000"}
    assert eng.validate_config(good) == []
    assert eng.validate_config({"APKFORGE_PORT": "x",
                                "APKFORGE_WEB_PORT": "3000"})
    assert eng.validate_config({"APKFORGE_PORT": "8000",
                                "APKFORGE_WEB_PORT": "8000"})
    assert eng.validate_config({"APKFORGE_PORT": "99999",
                                "APKFORGE_WEB_PORT": "3000"})


def test_secret_check():
    assert eng.secret_check({"APKFORGE_KEY": "short"})
    assert eng.secret_check({"APKFORGE_KEY": "CHANGEME-" + "x" * 40})
    assert eng.secret_check({"APKFORGE_KEY": "k" * 48}) == []


def test_port_free_roundtrip():
    sock = socket.socket()
    sock.bind(("127.0.0.1", 0))
    sock.listen(1)
    port = sock.getsockname()[1]
    try:
        assert eng.port_free(port) is False
    finally:
        sock.close()
    assert eng.port_free(port) is True


def test_pid_helpers():
    assert eng.pid_alive(os.getpid()) is True
    assert eng.pid_alive(99999999) is False


def test_env_file_roundtrip(tmp_path):
    path = tmp_path / ".env"
    values = {"APKFORGE_ENV": "local", "APKFORGE_PORT": "8000",
              "APKFORGE_KEY": "k" * 48}
    eng.write_env_file(path, values)
    assert eng.parse_env_file(path) == values
    assert (path.stat().st_mode & 0o777) == 0o600
