#!/usr/bin/env python3
"""ReelSec environment/capability resolver.

Separates tool existence from actual usability. This module is deliberately
side-effect-light: it probes versions/help and never installs packages,
modifies the APK, or mutates the git checkout.
"""
import json
import os
import shutil
import subprocess
from pathlib import Path

STATUS = ("AVAILABLE", "USABLE", "BROKEN", "MISSING", "BLOCKED")


def _run(cmd, timeout=8):
    try:
        p = subprocess.run(cmd, text=True, stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT, check=False,
                           timeout=timeout)
        return p.returncode, (p.stdout or "").strip()
    except subprocess.TimeoutExpired as exc:
        out = exc.stdout or ""
        if isinstance(out, bytes):
            out = out.decode("utf-8", errors="replace")
        return 124, out
    except Exception as exc:
        return 127, str(exc)


def _tool(name):
    value = shutil.which(name)
    return str(Path(value).resolve()) if value else None


def _probe(name, candidates, version_args=("--version",)):
    for candidate in candidates:
        if not candidate:
            continue
        rc, out = _run([candidate, *version_args])
        if rc == 0:
            first = next((x.strip() for x in out.splitlines() if x.strip()), "")
            return {"name": name, "status": "USABLE", "path": candidate,
                    "version": first, "returncode": rc}
    existing = next((x for x in candidates if x), None)
    return {"name": name, "status": "BROKEN" if existing else "MISSING",
            "path": existing, "version": None,
            "returncode": None if not existing else 127}


def _apktool_candidates():
    found = []
    for name in ("apktool", "apktool.jar"):
        p = _tool(name)
        if p:
            found.append(p)
    prefix = os.environ.get("PREFIX")
    if prefix:
        root = Path(prefix) / "var/lib/proot-distro/containers/ubuntu/rootfs"
        apkdir = root / "usr/share/apktool"
        jars = sorted(apkdir.glob("*.jar"))
        if jars:
            java = _tool("java")
            if java:
                cp = str(apkdir / "*") + ":" + str(root / "usr/share/java/*")
                found.append("__JAVA_CLASSPATH__:" + java + ":" + cp)
    return found


def _probe_apktool():
    candidates = _apktool_candidates()
    attempts = []
    broken_cli = None
    for c in candidates:
        if c.startswith("__JAVA_CLASSPATH__:"):
            _, java, cp = c.split(":", 2)
            rc, out = _run([java, "-cp", cp, "brut.apktool.Main", "--version"], 15)
            attempts.append({"backend": "java-classpath", "path": java, "returncode": rc})
            if rc == 0:
                return {"name": "apktool-standalone", "status": "USABLE",
                        "path": java, "version": out.splitlines()[0] if out else "",
                        "backend": "java-classpath", "classpath": cp,
                        "attempts": attempts}
            continue
        rc, out = _run([c, "--version"], 15)
        attempts.append({"backend": "cli", "path": c, "returncode": rc})
        if rc == 0:
            return {"name": "apktool", "status": "USABLE", "path": c,
                    "version": out.splitlines()[0] if out else "",
                    "backend": "cli", "attempts": attempts}
        broken_cli = c
    if broken_cli:
        return {"name": "apktool", "status": "BROKEN", "path": broken_cli,
                "version": None, "backend": "cli", "attempts": attempts,
                "fallback_attempted": True}
    return {"name": "apktool", "status": "MISSING", "path": None,
            "version": None, "attempts": attempts}


def _probe_frida():
    frida = _tool("frida")
    if not frida:
        return {"name": "frida", "status": "MISSING", "path": None}
    rc, out = _run([frida, "--version"])
    return {"name": "frida", "status": "USABLE" if rc == 0 else "BROKEN",
            "path": frida, "version": out.splitlines()[0] if out else None,
            "returncode": rc}


def _probe_adb():
    adb = _tool("adb")
    if not adb:
        return {"name": "adb", "status": "MISSING", "path": None}
    rc, out = _run([adb, "version"])
    item = {"name": "adb", "status": "USABLE" if rc == 0 else "BROKEN",
            "path": adb, "version": next((x for x in out.splitlines() if "version" in x.lower()), None),
            "returncode": rc}
    if rc == 0:
        drc, devices = _run([adb, "devices", "-l"])
        item["device_query"] = "USABLE" if drc == 0 else "BROKEN"
        item["devices"] = [x.strip() for x in devices.splitlines()
                           if x.strip() and not x.lower().startswith("list of devices")]
    return item


def _probe_signing():
    tools = {}
    for name in ("zipalign", "apksigner", "jarsigner", "openssl"):
        p = _tool(name)
        tools[name] = _probe(name, [p])
    return tools


def discover_environment(root=None):
    root = str(Path(root or os.getcwd()).resolve())
    java = _probe("java", [_tool("java")])
    python = _probe("python", [_tool("python3"), _tool("python")])
    signing = _probe_signing()
    result = {
        "schema_version": "1.0",
        "resolver": "ReelSec Environment Resolver",
        "root": root,
        "tools": {
            "java": java,
            "python": python,
            "adb": _probe_adb(),
            "apktool": _probe_apktool(),
            "frida": _probe_frida(),
            "signing": signing,
            # Compatibility aliases for callers that historically expected
            # signing tools directly under tools.<name>.
            "zipalign": signing.get("zipalign"),
            "apksigner": signing.get("apksigner"),
            "jarsigner": signing.get("jarsigner"),
            "openssl": signing.get("openssl"),
        },
        "device": {},
        "policy": {
            "available_is_not_usable": True,
            "resolver_does_not_install": True,
            "original_apk_is_immutable": True,
        },
    }
    adb = result["tools"]["adb"]
    if adb.get("device_query") == "USABLE":
        online = [x for x in adb.get("devices", []) if " device" in (" " + x)]
        result["device"] = {
            "online_count": len(online),
            "state": "USABLE" if online else "BLOCKED",
            "records": online,
        }
    return result


def write_capability_matrix(output, root=None):
    data = discover_environment(root)
    path = Path(output)
    path.mkdir(parents=True, exist_ok=True)
    (path / "CAPABILITY-MATRIX.json").write_text(
        json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    lines = ["# ReelSec Capability Matrix", "",
             "Rule: command existence does not equal usability.", ""]
    for group, value in data["tools"].items():
        if isinstance(value, dict) and "status" in value:
            lines.append("- %s: %s" % (group, value["status"]))
        elif isinstance(value, dict):
            lines.append("## " + group)
            for name, item in value.items():
                lines.append("- %s: %s" % (name, item.get("status", "UNKNOWN")))
    if data["device"]:
        lines += ["", "Device: " + data["device"].get("state", "UNKNOWN"),
                  "Online count: " + str(data["device"].get("online_count", 0))]
    (path / "CAPABILITY-MATRIX.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    return data
