"""Adaptive gitcare tests (real git repos in tmp; real repairs)."""
import os
import subprocess
import sys
import time
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from adaptive import gitcare as G  # noqa: E402


def _git(root, *args):
    proc = subprocess.run(
        ["git", "-C", str(root)] + list(args),
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True,
        timeout=60)
    assert proc.returncode == 0, (args, proc.stderr)
    return proc.stdout.strip()


@pytest.fixture()
def repo(tmp_path):
    root = tmp_path / "repo"
    root.mkdir()
    _git(root, "init", "-q")
    _git(root, "config", "user.email", "test@test")
    _git(root, "config", "user.name", "test")
    (root / "scripts").mkdir()
    (root / "scripts" / "apkforge.py").write_text("# engine\n")
    (root / "backend").mkdir()
    (root / "backend" / "app.py").write_text("# app\n")
    (root / "frontend" / "src").mkdir(parents=True)
    (root / "frontend" / "src" / "App.vue").write_text("x\n")
    _git(root, "add", "-A")
    _git(root, "commit", "-qm", "init")
    return root


def _junk(root):
    cache = root / "__pycache__"
    cache.mkdir(exist_ok=True)
    (cache / "x.pyc").write_bytes(b"\x00" * 100)
    (root / "stray.pyc").write_bytes(b"\x00" * 50)
    logs = root / "logs" / "bootstrap"
    logs.mkdir(parents=True, exist_ok=True)
    now = time.time()
    for index in range(5):
        path = logs / ("old%d.log" % index)
        path.write_text("log\n")
        os.utime(path, (now - 1000 + index, now - 1000 + index))
    (root / "dl.part").write_bytes(b"\x00" * 10)
    (root / "frontend" / "dist").mkdir(parents=True,
                                       exist_ok=True)
    (root / "frontend" / "dist" / "app.js").write_text("app")
    (root / ".venv" / "lib").mkdir(parents=True, exist_ok=True)
    (root / ".venv" / "lib" / "x.py").write_text("x")


def test_classify_matrix():
    assert G.classify_path("backend/app.py") == "SOURCE"
    assert G.classify_path("x.pyc") == "TEMP"
    assert G.classify_path("a/__pycache__/x.pyc") == "CACHE"
    assert G.classify_path("node_modules/a/index.js") == \
        "DEPENDENCY_CACHE"
    assert G.classify_path(".venv/lib/x") == "DEPENDENCY_CACHE"
    assert G.classify_path("logs/a.log") == "LOG"
    assert G.classify_path("in/app.apk") == "APK"
    assert G.classify_path("x/big.zip") == "ARCHIVE"
    assert G.classify_path("data/x.db") == "DATABASE"
    assert G.classify_path(".governance/s.json") == "GOVERNANCE"
    assert G.classify_path("docs/a.md") == "DOCUMENTATION"
    assert G.classify_path(".env") == "CONFIG"
    assert G.classify_path("frontend/dist/a.js") == "BUILD_OUTPUT"
    assert G.classify_path(".git/objects/x") == "GIT"
    assert G.classify_path("weird/thing.dat") == "UNKNOWN"


def test_quick_gate_matrix(repo, tmp_path):
    assert G.quick_gate(repo)["verdict"] == "OK"
    plain = tmp_path / "plain"
    plain.mkdir()
    assert G.quick_gate(plain)["verdict"] == "NOT_A_REPO"
    (repo / ".git" / "index").write_bytes(b"corrupt!!")
    gate = G.quick_gate(repo)
    assert gate["verdict"] == "RECOVERY_REQUIRED"
    assert any(check["name"] == "index"
               and not check["ok"] for check in gate["checks"])


def test_quick_gate_missing_source(repo):
    (repo / "backend" / "app.py").unlink()
    (repo / "backend").rmdir()
    gate = G.quick_gate(repo)
    assert gate["verdict"] == "RECOVERY_REQUIRED"


def test_repair_index_preserves_everything(repo, tmp_path):
    before_log = _git(repo, "log", "-1", "--format=%H")
    (repo / ".git" / "index").write_bytes(b"corrupt!!")
    payload = G.repair_index(repo, "APKFORGE-T1",
                             tmp_path / "logs")
    assert G.quick_gate(repo)["verdict"] == "OK"
    assert _git(repo, "log", "-1", "--format=%H") == before_log
    assert (repo / "scripts" / "apkforge.py").read_text() == \
        "# engine\n"
    assert payload["backup"] is not None
    assert Path(payload["backup"]).is_file()


def test_cleanup_disposable_only(repo, tmp_path):
    _junk(repo)
    payload = G.cleanup(repo, "APKFORGE-T2", tmp_path / "logs")
    assert not (repo / "__pycache__").exists()
    assert not (repo / "stray.pyc").exists()
    assert not (repo / "dl.part").exists()
    remaining = sorted(
        path.name for path in (repo / "logs" / "bootstrap").iterdir())
    assert remaining == ["old2.log", "old3.log", "old4.log"]
    assert (repo / "frontend" / "dist" / "app.js").is_file()
    assert (repo / ".venv" / "lib" / "x.py").is_file()
    assert (repo / "backend" / "app.py").is_file()
    assert payload["removed_count"] == 5
    assert payload["reclaimed_bytes"] > 0


def test_tracked_and_nested(repo, tmp_path):
    assert G.tracked(repo, "backend/app.py") is True
    (repo / "new.txt").write_text("new")
    assert G.tracked(repo, "new.txt") is False
    nested = repo / "vendor" / "dep"
    nested.mkdir(parents=True)
    _git(nested, "init", "-q")
    assert G.find_nested_git(repo) == ["vendor/dep/.git"]


def test_diagnose_small_repo(repo, tmp_path):
    report = G.diagnose(repo, "APKFORGE-T3", tmp_path / "logs")
    assert report["gate"]["verdict"] == "OK"
    assert "init" in report["git"]["head"]
    assert report["git"]["fsck_code"] == 0
    assert report["git"]["shallow"] == "false"
    assert report["sizes"]["file_count"] > 5
    assert report["sizes"]["top_files"]
    assert isinstance(report["lfs"]["installed"], bool)
    assert (tmp_path / "logs" / "git-recovery" / "APKFORGE-T3"
            / "diagnose.json").is_file()


def test_auto_repairs_and_cleans(repo, tmp_path):
    _junk(repo)
    (repo / ".git" / "index").write_bytes(b"corrupt!!")
    result = G.auto(repo, "APKFORGE-T4", tmp_path / "logs",
                    say=lambda message: None)
    assert result["verdict"] == "OK"
    assert "repair-index" in result["actions"]
    assert not (repo / "stray.pyc").exists()
    assert (tmp_path / "logs" / "git-recovery" / "APKFORGE-T4"
            / "report.md").is_file()
    plain = tmp_path / "plain"
    plain.mkdir()
    assert G.auto(plain, "APKFORGE-T5",
                  tmp_path / "logs")["verdict"] == "NOT_A_REPO"
