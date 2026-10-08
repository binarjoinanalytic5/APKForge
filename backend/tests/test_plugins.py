"""Plugin protocol tests: run.py via stdin/stdout with fake tools."""
import json
import os
import subprocess
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]

FAKE_APKTOOL = """#!/bin/sh
set -e
if [ "$1" = "d" ]; then
  out=""; prev=""
  for a in "$@"; do
    if [ "$prev" = "-o" ]; then out="$a"; fi
    prev="$a"
  done
  mkdir -p "$out"
  echo '<manifest/>' > "$out/AndroidManifest.xml"
  echo "I: decoding sources"
elif [ "$1" = "b" ]; then
  out=""; prev=""
  for a in "$@"; do
    if [ "$prev" = "-o" ]; then out="$a"; fi
    prev="$a"
  done
  mkdir -p "$(dirname "$out")"
  echo "fake-apk" > "$out"
  echo "I: building apk"
else
  echo "unknown fake-apktool command" >&2; exit 2
fi
"""

FAKE_JADX = """#!/bin/sh
set -e
out=""; prev=""
for a in "$@"; do
  if [ "$prev" = "-d" ]; then out="$a"; fi
  prev="$a"
done
mkdir -p "$out/sources"
echo 'class A {}' > "$out/sources/A.java"
echo "I: decompiling"
"""


@pytest.fixture()
def fake_bin(tmp_path):
    bindir = tmp_path / "bin"
    bindir.mkdir()
    apktool = bindir / "apktool"
    apktool.write_text(FAKE_APKTOOL)
    apktool.chmod(0o755)
    jadx = bindir / "jadx"
    jadx.write_text(FAKE_JADX)
    jadx.chmod(0o755)
    return bindir


def _run_plugin(plugin, payload, env):
    proc = subprocess.run(
        [sys.executable, str(ROOT / "plugins" / plugin / "run.py")],
        input=json.dumps(payload), stdout=subprocess.PIPE,
        stderr=subprocess.PIPE, text=True, env=env, timeout=60)
    return proc


def _env(monkeypatch, fake_bin):
    env = dict(os.environ)
    env["PATH"] = str(fake_bin) + os.pathsep + env["PATH"]
    env.pop("APKFORGE_APKTOOL", None)
    env.pop("APKFORGE_JADX", None)
    return env


def test_apktool_decompile(tmp_path, fake_bin, monkeypatch):
    apk = tmp_path / "app.apk"
    apk.write_bytes(b"fake")
    payload = {"kind": "decompile", "input_path": str(apk),
               "out_dir": str(tmp_path / "out"),
               "_limits": {"timeout_s": 60}}
    proc = _run_plugin("apktool", payload,
                       _env(monkeypatch, fake_bin))
    assert proc.returncode == 0, proc.stderr
    result = json.loads(proc.stdout)
    assert result["status"] == "ok"
    assert (tmp_path / "out" / "AndroidManifest.xml").is_file()
    assert result["log_lines"]


def test_apktool_rebuild_from_dir(tmp_path, fake_bin, monkeypatch):
    tree = tmp_path / "tree"
    tree.mkdir()
    (tree / "apktool.yml").write_text("x")
    payload = {"kind": "rebuild", "input_path": str(tree),
               "out_dir": str(tmp_path / "out2"),
               "_limits": {"timeout_s": 60}}
    proc = _run_plugin("apktool", payload,
                       _env(monkeypatch, fake_bin))
    assert proc.returncode == 0, proc.stderr
    result = json.loads(proc.stdout)
    assert result["status"] == "ok"
    assert Path(result["apk"]).is_file()


def test_apktool_rebuild_from_zip(tmp_path, fake_bin, monkeypatch):
    import zipfile
    archive = tmp_path / "tree.zip"
    with zipfile.ZipFile(archive, "w") as handle:
        handle.writestr("apktool.yml", "x")
    payload = {"kind": "rebuild", "input_path": str(archive),
               "out_dir": str(tmp_path / "out3"),
               "_limits": {"timeout_s": 60}}
    proc = _run_plugin("apktool", payload,
                       _env(monkeypatch, fake_bin))
    assert proc.returncode == 0, proc.stderr
    assert json.loads(proc.stdout)["status"] == "ok"


def test_apktool_missing_tool_explicit(tmp_path, monkeypatch):
    apk = tmp_path / "app.apk"
    apk.write_bytes(b"fake")
    env = dict(os.environ)
    env["PATH"] = str(tmp_path)
    env["APKFORGE_APKTOOL"] = str(tmp_path / "missing")
    payload = {"kind": "decompile", "input_path": str(apk),
               "out_dir": str(tmp_path / "out")}
    proc = _run_plugin("apktool", payload, env)
    assert proc.returncode == 2
    assert "not installed" in json.loads(proc.stdout)["error"]


def test_apktool_bad_payload_rejected(tmp_path):
    payload = {"kind": "explode"}
    proc = _run_plugin("apktool", payload, dict(os.environ))
    assert proc.returncode == 2


def test_jadx_decompile(tmp_path, fake_bin, monkeypatch):
    apk = tmp_path / "app.apk"
    apk.write_bytes(b"fake")
    payload = {"kind": "decompile", "input_path": str(apk),
               "out_dir": str(tmp_path / "jout"),
               "_limits": {"timeout_s": 60}}
    proc = _run_plugin("jadx", payload, _env(monkeypatch, fake_bin))
    assert proc.returncode == 0, proc.stderr
    result = json.loads(proc.stdout)
    assert result["status"] == "ok"
    assert (tmp_path / "jout" / "sources" / "A.java").is_file()


def test_jadx_rejects_other_kinds(tmp_path, fake_bin, monkeypatch):
    payload = {"kind": "rebuild", "input_path": "x",
               "out_dir": str(tmp_path / "j")}
    proc = _run_plugin("jadx", payload, _env(monkeypatch, fake_bin))
    assert proc.returncode == 2


def test_adapters_spawn_real_plugins(tmp_path, fake_bin, monkeypatch):
    """Adapter classes drive run.py end to end (fake tool on PATH)."""
    import importlib.util
    monkeypatch.setenv("PATH",
                       str(fake_bin) + os.pathsep +
                       os.environ["PATH"])
    apk = tmp_path / "app.apk"
    apk.write_bytes(b"fake")
    for plugin in ("apktool", "jadx"):
        path = ROOT / "plugins" / plugin / "adapter.py"
        spec = importlib.util.spec_from_file_location(
            "t_%s" % plugin, path)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        out = module.Adapter().run(
            {"kind": "decompile", "input_path": str(apk),
             "out_dir": str(tmp_path / ("%s-out" % plugin)),
             "_limits": {"timeout_s": 60}})
        assert out["status"] == "ok", plugin
        assert Path(out["out_dir"]).is_dir()
