#!/usr/bin/env python3
"""Backend selection for APK decoding.

Selection is evidence-driven: a backend is selected only after a real probe
succeeds. No installation or APK mutation occurs here.
"""
from pathlib import Path
from environment import discover_environment

BACKEND_USABLE = "USABLE"


class ApktoolBackendError(RuntimeError):
    pass


def select_apktool_backend(environment):
    item = environment.get("tools", {}).get("apktool", {})
    if item.get("status") != BACKEND_USABLE:
        raise ApktoolBackendError(
            "No usable Apktool backend: %s" % item.get("status", "UNKNOWN")
        )
    backend = item.get("backend")
    if backend not in ("cli", "java-classpath"):
        raise ApktoolBackendError("Unknown Apktool backend: %r" % backend)
    return {
        "name": "apktool-standalone" if backend == "java-classpath" else "apktool",
        "backend": backend,
        "path": item.get("path"),
        "version": item.get("version"),
        "status": "SELECTED",
    }


def resolve_apktool_backend(root=None):
    env = discover_environment(root)
    selected = select_apktool_backend(env)
    return {"environment": env, "selected": selected}


def decode_command(selection, apk, output_dir):
    apk = str(Path(apk).resolve())
    output_dir = str(Path(output_dir).resolve())
    if selection["backend"] == "cli":
        return [selection["path"], "d", apk, "-o", output_dir]
    # The standalone Ubuntu installation is invoked through the discovered
    # Java binary and its classpath encoded by the environment probe.
    raise ApktoolBackendError(
        "Standalone Java-classpath decode command requires its classpath metadata"
    )
