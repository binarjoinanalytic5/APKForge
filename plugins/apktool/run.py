"""Apktool plugin process (Plugin SDK v1: JSON stdin → JSON stdout).

Reads one JSON object on stdin:
  {kind: decompile|rebuild, input_path, out_dir, options, _limits}
Runs Apktool as a subprocess (never a shell) and writes a single JSON
object on stdout; human logs go to stderr. Exit 0 = success.
"""
import json
import os
import shutil
import subprocess
import sys
import zipfile
from pathlib import Path

MAX_LOG_LINES = 200


def log(message):
    print(message, file=sys.stderr, flush=True)


def fail(message, code=1):
    log("apktool plugin: " + message)
    print(json.dumps({"status": "error", "error": message}))
    raise SystemExit(code)


def resolve_apktool():
    """Return the argv prefix for Apktool or None when not installed."""
    override = os.environ.get("APKFORGE_APKTOOL", "").strip()
    if override:
        if override.endswith(".jar") and os.path.isfile(override):
            return ["java", "-jar", override]
        if os.path.isfile(override) and os.access(override, os.X_OK):
            return [override]
        return None
    binary = shutil.which("apktool")
    if binary:
        return [binary]
    return None


def run_tool(argv, timeout_s):
    try:
        proc = subprocess.run(argv, stdout=subprocess.PIPE,
                              stderr=subprocess.STDOUT, timeout=timeout_s,
                              check=False, text=True)
    except subprocess.TimeoutExpired:
        fail("apktool timed out after %ss" % timeout_s)
    lines = proc.stdout.splitlines()
    for line in lines[:MAX_LOG_LINES]:
        log("apktool: " + line)
    if proc.returncode != 0:
        fail("apktool exited %d (see logs)" % proc.returncode)
    return lines[:MAX_LOG_LINES]


def cmd_decompile(tool_argv, payload, out_dir, timeout_s):
    apk = payload.get("input_path", "")
    if not apk or not os.path.isfile(apk):
        fail("input_path must be an existing APK file")
    out = Path(out_dir)
    if out.exists():
        shutil.rmtree(out)
    argv = tool_argv + ["d", apk, "-o", str(out), "-f"]
    extra = (payload.get("options") or {}).get("apktool_args")
    if isinstance(extra, list) and all(isinstance(a, str) for a in extra):
        argv += extra
    log_lines = run_tool(argv, timeout_s)
    return {"status": "ok", "out_dir": str(out), "log_lines": log_lines}


def cmd_rebuild(tool_argv, payload, out_dir, timeout_s):
    src = payload.get("input_path", "")
    if not src or not os.path.exists(src):
        fail("input_path must exist (decoded tree or its zip)")
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    tree = src
    if os.path.isfile(src) and zipfile.is_zipfile(src):
        tree = str(out / "tree")
        with zipfile.ZipFile(src) as archive:
            archive.extractall(tree)
    if not os.path.isdir(tree):
        fail("rebuild needs a decoded directory")
    target = out / "rebuilt.apk"
    argv = tool_argv + ["b", tree, "-o", str(target)]
    log_lines = run_tool(argv, timeout_s)
    if not target.is_file():
        fail("apktool produced no APK")
    return {"status": "ok", "out_dir": str(out), "apk": str(target),
            "log_lines": log_lines}


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception as exc:
        fail("stdin must be one JSON object: %s" % exc, code=2)
    if not isinstance(payload, dict):
        fail("stdin must be one JSON object", code=2)
    kind = payload.get("kind")
    if kind not in ("decompile", "rebuild"):
        fail("kind must be decompile|rebuild, got %r" % (kind,),
             code=2)
    tool_argv = resolve_apktool()
    if tool_argv is None:
        fail("apktool not installed (set APKFORGE_APKTOOL to the "
             "jar or binary, or put 'apktool' on PATH)", code=2)
    out_dir = payload.get("out_dir") or "out"
    timeout_s = (payload.get("_limits") or {}).get("timeout_s", 600)
    if kind == "decompile":
        result = cmd_decompile(tool_argv, payload, out_dir, timeout_s)
    else:
        result = cmd_rebuild(tool_argv, payload, out_dir, timeout_s)
    print(json.dumps(result))


if __name__ == "__main__":
    main()
