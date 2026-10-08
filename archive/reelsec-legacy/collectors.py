"""ReelSec collectors: uniform, bounded evidence collection.

Every collector produces the same envelope (schema collector-1) and is run
by the orchestrator automatically — no manual grep/sed/adb/logcat/dumpsys
sessions between the operator and the tool. Device-facing collectors are
read-only; file-backed collectors validate campaign artifacts already
produced by the pipeline. A collector never invents data: unavailable
sources are recorded as SKIPPED/FAILED with the specific reason.
"""

import json
import time
from pathlib import Path

import runtime_health

SCHEMA = "collector-1"


def envelope(name, status, data=None, errors=None, **extra):
    doc = {
        "collector": name,
        "schema_version": SCHEMA,
        "collected_at_epoch": time.time(),
        "status": status,  # OK | FAILED | SKIPPED
        "data": data or {},
        "errors": errors or [],
    }
    doc.update(extra)
    return doc


def _read_json(path):
    try:
        return json.loads(Path(path).read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return None


def _device(ctx):
    adb, serial = ctx.get("adb"), ctx.get("serial")
    if not adb or not serial:
        return None
    return adb, serial


def _sh(ctx, args, timeout=20):
    adb, serial = _device(ctx)
    return ctx["runner"]([adb, "-s", serial] + args, timeout=timeout)


class DeviceSnapshotCollector:
    """Device identity + users + bounded state, read-only."""
    name = "DEVICE-SNAPSHOT"

    @classmethod
    def collect(cls, ctx):
        if not _device(ctx):
            return envelope(cls.name, "SKIPPED",
                            errors=["no adb endpoint in context"])
        adb, serial = _device(ctx)
        snap = runtime_health and __import__("safety_gate").device_snapshot(
            ctx["runner"], adb, serial, package=ctx.get("package"))
        status = "OK" if snap.get("status") == "OK" else "FAILED"
        return envelope(cls.name, status, data=snap)


class PackageCollector:
    """Installed-package identity for the target package, read-only."""
    name = "PACKAGE"

    @classmethod
    def collect(cls, ctx):
        if not _device(ctx) or not ctx.get("package"):
            return envelope(cls.name, "SKIPPED",
                            errors=["no adb endpoint or package in context"])
        rc, out = _sh(ctx, ["shell", "pm", "path", ctx["package"]])
        path = None
        for line in (out or "").splitlines():
            if line.startswith("package:"):
                path = line.split(":", 1)[1].strip()
                break
        rc2, out2 = _sh(ctx, ["shell", "dumpsys", "package", ctx["package"]],
                        timeout=30)
        version_code = version_name = installer = None
        for line in (out2 or "").splitlines():
            if "versionCode=" in line and version_code is None:
                version_code = line.split("versionCode=", 1)[1].split()[0]
            if "versionName=" in line and version_name is None:
                version_name = line.split("versionName=", 1)[1].split()[0]
            if "installerPackageName=" in line and installer is None:
                installer = line.split("installerPackageName=", 1)[1].split()[0]
        data = {"package": ctx["package"], "installed_path": path,
                "version_code": version_code, "version_name": version_name,
                "installer": installer}
        return envelope(cls.name, "OK" if path else "FAILED", data=data,
                        errors=[] if path else ["package not installed"])


class ProcessCollector:
    """Process presence for the target package, read-only."""
    name = "PROCESS"

    @classmethod
    def collect(cls, ctx):
        if not _device(ctx) or not ctx.get("package"):
            return envelope(cls.name, "SKIPPED",
                            errors=["no adb endpoint or package in context"])
        rc, out = _sh(ctx, ["shell", "ps", "-A"])
        pids = []
        for line in (out or "").splitlines():
            parts = line.split()
            if len(parts) >= 9 and parts[-1] == ctx["package"]:
                try:
                    pids.append(int(parts[1]))
                except ValueError:
                    pass
        return envelope(cls.name, "OK",
                        data={"package": ctx["package"], "pids": pids,
                              "running": bool(pids)})


class CrashCollector:
    """ApplicationExitInfo + crash logcat, parsed. Read-only."""
    name = "CRASH"

    @classmethod
    def collect(cls, ctx):
        if not _device(ctx) or not ctx.get("package"):
            return envelope(cls.name, "SKIPPED",
                            errors=["no adb endpoint or package in context"])
        adb, serial = _device(ctx)
        info = runtime_health.query_exit_info(ctx["runner"], adb, serial,
                                              ctx["package"])
        rc, out = ctx["runner"]([adb, "-s", serial, "logcat", "-b", "crash",
                                 "-d", "-t", "400"], timeout=40)
        tomb = runtime_health.parse_tombstone_logcat(
            out if rc == 0 else "", ctx["package"])
        tomb["source"] = "adb:logcat -b crash -d -t 400"
        return envelope(cls.name, "OK" if info["available"] else "FAILED",
                        data={"exit_info": info, "tombstone": tomb},
                        errors=[] if info["available"]
                        else ["dumpsys activity exit-info unavailable"])


class LogcatCollector:
    """Bounded, filtered logcat capture (never a raw multi-MB dump)."""
    name = "LOGCAT"
    KEYWORDS = ("Fatal signal", "FATAL EXCEPTION", "ANR in", "crash_dump",
                "SIGSEGV", "SIGABRT", "Force finishing", "am_crash",
                "am_anr", "am_kill", "died")

    @classmethod
    def collect(cls, ctx):
        if not _device(ctx) or not ctx.get("package"):
            return envelope(cls.name, "SKIPPED",
                            errors=["no adb endpoint or package in context"])
        rc, out = _sh(ctx, ["logcat", "-d", "-t", "3000"], timeout=60)
        if rc != 0:
            return envelope(cls.name, "FAILED",
                            errors=["logcat unavailable (rc=%s)" % rc])
        package = ctx["package"]
        kept = []
        for line in (out or "").splitlines():
            if package in line or any(k in line for k in cls.KEYWORDS):
                kept.append(line.strip()[:240])
        return envelope(cls.name, "OK",
                        data={"matched_lines": kept[-400:],
                              "matched_count": len(kept),
                              "filter": "package or crash keywords",
                              "window": "logcat -d -t 3000"})


class ArtifactIntegrityCollector:
    """Validates the pre-install integrity gate artifact."""
    name = "ARTIFACT-INTEGRITY"

    @classmethod
    def collect(cls, ctx):
        doc = _read_json(Path(ctx["campaign_dir"]) / "ARTIFACT-INTEGRITY.json")
        if not doc:
            return envelope(cls.name, "FAILED",
                            errors=["ARTIFACT-INTEGRITY.json not produced by "
                                    "the campaign"])
        return envelope(cls.name,
                        "OK" if doc.get("status") == "PASS" else "FAILED",
                        data=doc,
                        errors=[] if doc.get("status") == "PASS"
                        else ["integrity gate status=%s" % doc.get("status")])


class RuntimeHealthCollector:
    """Validates the process-health-gate artifact."""
    name = "RUNTIME-HEALTH"

    @classmethod
    def collect(cls, ctx):
        doc = _read_json(Path(ctx["campaign_dir"]) / "RUNTIME-HEALTH.json")
        if not doc:
            return envelope(cls.name, "FAILED",
                            errors=["RUNTIME-HEALTH.json not produced (health "
                                    "gate never ran)"])
        return envelope(cls.name,
                        "OK" if doc.get("startup") == "PASS" else "FAILED",
                        data=doc)


class BaselineCollector:
    """Validates the gated baseline-round artifact."""
    name = "BASELINE"

    @classmethod
    def collect(cls, ctx):
        doc = _read_json(Path(ctx["campaign_dir"]) / "BASELINE-RUNTIME.json")
        if not doc:
            return envelope(cls.name, "SKIPPED",
                            errors=["BASELINE-RUNTIME.json absent (baseline "
                                    "round not attempted)"])
        status = {"BASELINE_ASSESSED": "OK"}.get(doc.get("status"), "FAILED")
        return envelope(cls.name, status, data=doc)


class BehaviorCollector:
    """Validates the L4 behavioral capture artifact (never re-runs it)."""
    name = "BEHAVIOR"

    @classmethod
    def collect(cls, ctx):
        doc = _read_json(Path(ctx["campaign_dir"]) / "BEHAVIOR-CAPTURE.json")
        if not doc:
            return envelope(cls.name, "SKIPPED",
                            errors=["BEHAVIOR-CAPTURE.json absent (L4 capture "
                                    "not attempted)"])
        auditable = (str(doc.get("schema_version", "")).startswith(
            "behavior-capture-2"))
        return envelope(cls.name, "OK" if auditable else "FAILED", data=doc,
                        errors=[] if auditable
                        else ["record is not an auditable behavior-capture-2"])


class EvidenceCollector:
    """Hashes every campaign artifact; no device access."""
    name = "EVIDENCE"

    @classmethod
    def collect(cls, ctx):
        import hashlib
        cd = Path(ctx["campaign_dir"])
        files = []
        for p in sorted(cd.rglob("*")):
            if not p.is_file():
                continue
            rel = p.relative_to(cd).as_posix()
            if rel in ("MANIFEST.json", "FINAL-VERDICT.json"):
                continue
            h = hashlib.sha256()
            with p.open("rb") as fh:
                for chunk in iter(lambda: fh.read(1 << 20), b""):
                    h.update(chunk)
            files.append({"path": rel, "sha256": h.hexdigest(),
                          "size_bytes": p.stat().st_size})
        return envelope(cls.name, "OK",
                        data={"file_count": len(files), "files": files})


COLLECTORS = {
    "DeviceSnapshotCollector": DeviceSnapshotCollector,
    "PackageCollector": PackageCollector,
    "ProcessCollector": ProcessCollector,
    "CrashCollector": CrashCollector,
    "LogcatCollector": LogcatCollector,
    "ArtifactIntegrityCollector": ArtifactIntegrityCollector,
    "RuntimeHealthCollector": RuntimeHealthCollector,
    "BaselineCollector": BaselineCollector,
    "BehaviorCollector": BehaviorCollector,
    "EvidenceCollector": EvidenceCollector,
}

# Deterministic order: device state first, campaign artifacts, evidence last.
COLLECTOR_SEQUENCE = (
    DeviceSnapshotCollector, PackageCollector, ProcessCollector,
    CrashCollector, LogcatCollector, ArtifactIntegrityCollector,
    RuntimeHealthCollector, BaselineCollector, BehaviorCollector,
    EvidenceCollector,
)


def run_collectors(ctx, sequence=None):
    """Run every collector; each writes <NAME>.json into the campaign dir.

    Collector exceptions are contained: a failing collector records FAILED
    with the error and never aborts the platform.
    """
    results = []
    for cls in (sequence or COLLECTOR_SEQUENCE):
        try:
            doc = cls.collect(ctx)
        except Exception as exc:  # containment by design
            doc = envelope(cls.name, "FAILED",
                           errors=["collector exception: %s" % str(exc)[:300]])
        out = Path(ctx["campaign_dir"]) / ("%s.json" % cls.name)
        out.write_text(json.dumps(doc, indent=2, sort_keys=True) + "\n",
                       encoding="utf-8")
        results.append({"collector": cls.name, "status": doc["status"],
                        "errors": doc.get("errors") or []})
    return results
