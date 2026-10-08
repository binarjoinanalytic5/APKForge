"""JADX plugin process (Plugin SDK v1: JSON stdin → JSON stdout).

Reads one JSON object on stdin:
  {kind: decompile, input_path, out_dir, options, _limits}
Runs JADX as a subprocess (never a shell) and writes a single JSON
object on stdout; human logs go to stderr. Exit 0 = success.
"""
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

MAX_LOG_LINES = 200


def log(message):
    print(message, file=sys.stderr, flush=True)


def fail(message, code=1):
    log("jadx plugin: " + message)
    print(json.dumps({"status": "error", "error": message}))
    raise SystemExit(code)


def resolve_jadx():
    override = os.environ.get("APKFORGE_JADX", "").strip()
    if override:
        if os.path.isfile(override) and os.access(override, os.X_OK):
            return [override]
        return None
    binary = shutil.which("jadx")
    if binary:
        return [binary]
    return None


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception as exc:
        fail("stdin must be one JSON object: %s" % exc, code=2)
    if not isinstance(payload, dict):
        fail("stdin must be one JSON object", code=2)
    if payload.get("kind") != "decompile":
        fail("jadx supports kind=decompile only, got %r"
             % (payload.get("kind"),), code=2)
    apk = payload.get("input_path", "")
    if not apk or not os.path.isfile(apk):
        fail("input_path must be an existing APK file", code=2)
    tool_argv = resolve_jadx()
    if tool_argv is None:
        fail("jadx not installed (set APKFORGE_JADX to the binary "
             "or put 'jadx' on PATH)", code=2)
    out = Path(payload.get("out_dir") or "out")
    if out.exists():
        shutil.rmtree(out)
    timeout_s = (payload.get("_limits") or {}).get("timeout_s", 600)
    argv = tool_argv + ["-d", str(out), apk]
    extra = (payload.get("options") or {}).get("jadx_args")
    if isinstance(extra, list) and all(isinstance(a, str) for a in extra):
        argv += extra
    try:
        proc = subprocess.run(argv, stdout=subprocess.PIPE,
                              stderr=subprocess.STDOUT,
                              timeout=timeout_s, check=False, text=True)
    except subprocess.TimeoutExpired:
        fail("jadx timed out after %ss" % timeout_s)
    lines = proc.stdout.splitlines()
    for line in lines[:MAX_LOG_LINES]:
        log("jadx: " + line)
    if proc.returncode != 0:
        fail("jadx exited %d (see logs)" % proc.returncode)
    print(json.dumps({"status": "ok", "out_dir": str(out),
                      "log_lines": lines[:MAX_LOG_LINES]}))


if __name__ == "__main__":
    main()
