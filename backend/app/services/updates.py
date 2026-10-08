"""Release lifecycle + update checks (stdlib logic).

Lifecycle: draft → validated → published → (unpublished). Only
published releases on an allowed channel feed the update manifest.
Every lifecycle step and every check is audit-logged (UPDATE_*).
"""
import time

from ..core.rbac import audit_record, require
from ..core.updates import (ARTIFACT_KINDS, CHANNELS, RELEASE_TYPES,
                            UpdateError, channel_allows,
                            compare_versions, evaluate, parse_version,
                            version_code)

PERM_MANAGE = "release.manage"  # admin-only via "*" (matrix untouched)
PERM_MAINTENANCE = "maintenance.toggle"
PERM_CHANNEL = "channel.manage"


def _now():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())


class UpdateService:
    def __init__(self, store, app_version, app_code):
        self.store = store
        self.app_version = app_version
        self.app_code = app_code

    # -- lifecycle --------------------------------------------------
    def create_release(self, actor, data):
        require(actor["role"], PERM_MANAGE)
        release = self._coerce(data, for_create=True)
        release["created_by"] = actor["sub"]
        if self.store.get_release_by_version(release["version"]):
            raise UpdateError("release %s already exists"
                              % release["version"])
        created = self.store.create_release(release)
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="release.created",
            target=created["id"], result="ok",
            detail={"version": created["version"]}))
        return created

    def validate_release(self, actor, release_id):
        require(actor["role"], PERM_MANAGE)
        release = self._need(release_id)
        if release["status"] != "draft":
            raise UpdateError("only draft releases validate "
                              "(now %s)" % release["status"])
        problems = self._coherence(release)
        if problems:
            raise UpdateError("; ".join(problems))
        updated = self.store.set_release(release_id, status="validated")
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="release.validated",
            target=release_id, result="ok",
            detail={"version": updated["version"]}))
        return updated

    def publish_release(self, actor, release_id, notify=None):
        require(actor["role"], PERM_MANAGE)
        release = self._need(release_id)
        if release["status"] != "validated":
            raise UpdateError("only validated releases publish "
                              "(now %s)" % release["status"])
        updated = self.store.set_release(
            release_id, status="published", published_at=_now())
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="release.published",
            target=release_id, result="ok",
            detail={"version": updated["version"],
                    "channel": updated["channel"]}))
        if notify is not None:
            self._fan_out(actor, updated, notify)
        return updated

    def unpublish_release(self, actor, release_id):
        require(actor["role"], PERM_MANAGE)
        release = self._need(release_id)
        if release["status"] != "published":
            raise UpdateError("only published releases unpublish "
                              "(now %s)" % release["status"])
        updated = self.store.set_release(release_id,
                                         status="unpublished")
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="release.unpublished",
            target=release_id, result="ok",
            detail={"version": updated["version"]}))
        return updated

    def _fan_out(self, actor, release, notify):
        title = "تحديث جديد متوفر: %s" % release["version"]
        lines = list(release.get("release_notes") or [])
        if release.get("security_update"):
            lines.append("تحسين الأمان")
        message = "يتوفر الإصدار %s من النظام." % release["version"]
        if lines:
            message += "\nيتضمن:\n" + "\n".join("• %s" % line
                                                for line in lines[:8])
        if release.get("mandatory"):
            ntype, severity = "MANDATORY_UPDATE", "critical"
        elif release.get("security_update"):
            ntype, severity = "SECURITY_UPDATE", "important"
        else:
            ntype, severity = "UPDATE_AVAILABLE", "info"
        notify.broadcast(
            actor, ntype, title, message, severity=severity,
            action={"kind": "open-updates",
                    "version": release["version"]})

    def list_releases(self, actor, channel=None, status=None):
        require(actor["role"], PERM_MANAGE)
        return self.store.list_releases(channel=channel, status=status)

    def history(self, actor):
        require(actor["role"], PERM_MANAGE)
        return [release for release in self.store.list_releases()
                if release["status"] in ("published", "unpublished")]

    # -- manifest + check (public) ----------------------------------
    def latest_for_channel(self, channel):
        if channel not in CHANNELS:
            raise UpdateError("unknown channel %r" % (channel,))
        candidates = [
            release for release in self.store.list_releases(
                status="published")
            if channel_allows(channel, release["channel"])]
        if not candidates:
            return None
        return max(candidates, key=lambda item: item["version_code"])

    def manifest_for_channel(self, channel):
        latest = self.latest_for_channel(channel)
        if latest is None:
            raise LookupError("no published release for %s" % channel)
        return {
            "latest_version": latest["version"],
            "version_code": latest["version_code"],
            "minimum_supported_version":
                latest["minimum_supported_version"],
            "release_type": latest["release_type"],
            "channel": latest["channel"],
            "mandatory": latest["mandatory"],
            "security_update": latest["security_update"],
            "release_date": latest["release_date"] or "",
            "artifact_kind": latest["artifact_kind"],
            "download_url": latest["download_url"] or "",
            "artifact_ref": latest["artifact_ref"] or "",
            "checksum": latest["checksum"] or "",
            "signature": latest["signature"] or "",
            "size_bytes": latest["size_bytes"],
            "release_notes": latest["release_notes"],
            "breaking_changes": latest["breaking_changes"],
            "migration_required": latest["migration_required"],
            "restart_required": latest["restart_required"],
        }

    def check(self, current_version, channel, actor_name="anonymous"):
        """Decide the update status for a client (audited)."""
        parse_version(current_version)  # raises UpdateError when bad
        if channel not in CHANNELS:
            raise UpdateError("unknown channel %r" % (channel,))
        latest = self.latest_for_channel(channel)
        maintenance = self.get_maintenance()
        if latest is None:
            status = "NO_UPDATE"
            detail = {"latest_version": None}
        else:
            status = evaluate(
                current_version, latest["version"],
                minimum=latest["minimum_supported_version"],
                mandatory=latest["mandatory"])
            if status == "MANDATORY_UPDATE":
                self.store.set_config("update_required", "true")
            elif status == "NO_UPDATE":
                self.store.set_config("update_required", "false")
            detail = {"latest_version": latest["version"],
                      "latest_code": latest["version_code"],
                      "mandatory": latest["mandatory"],
                      "security_update": latest["security_update"],
                      "release_type": latest["release_type"],
                      "release_notes": latest["release_notes"]}
        self.store.set_config("last_update_check", _now())
        self.store.append_audit(audit_record(
            actor=actor_name, action="UPDATE_CHECK", target=channel,
            result="ok", detail={"current": current_version,
                                 "status": status, **detail}))
        if status != "NO_UPDATE":
            self.store.append_audit(audit_record(
                actor=actor_name, action="UPDATE_DETECTED",
                target=detail.get("latest_version") or "?",
                result="ok", detail={"current": current_version}))
        return {"status": status, "current_version": current_version,
                "channel": channel, "maintenance": maintenance,
                **detail}

    # -- channel + maintenance --------------------------------------
    def get_channel(self):
        return self.store.get_config("update_channel", "STABLE")

    def set_channel(self, actor, channel):
        require(actor["role"], PERM_CHANNEL)
        if channel not in CHANNELS:
            raise UpdateError("unknown channel %r" % (channel,))
        self.store.set_config("update_channel", channel)
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="channel.changed",
            target=channel, result="ok"))
        return {"channel": channel}

    def get_maintenance(self):
        active = self.store.get_config("maintenance", "false") == "true"
        return {"active": active,
                "message": self.store.get_config(
                    "maintenance_message", "") if active else ""}

    def set_maintenance(self, actor, active, message=""):
        require(actor["role"], PERM_MAINTENANCE)
        self.store.set_config("maintenance",
                              "true" if active else "false")
        self.store.set_config("maintenance_message", message or "")
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="maintenance.toggled",
            target="system", result="ok",
            detail={"active": bool(active)}))
        return self.get_maintenance()

    # -- local apply (spawns the engine runner) ----------------------
    def apply_local(self, actor, version=None):
        """Trigger a local update run (202 + run_id, runs detached).

        Refuses when another update holds the lock or no newer
        published release exists. The runner (scripts/update.py)
        performs download → verify → backup → install → migrate →
        restart → health, rolling back on any failure.
        """
        require(actor["role"], PERM_MANAGE)
        import json as _json
        import secrets as _secrets
        import subprocess as _subprocess
        import sys as _sys
        from pathlib import Path as _Path
        root = _Path(__file__).resolve().parents[3]
        gov = root / ".governance"
        gov.mkdir(parents=True, exist_ok=True)
        lock = gov / "update.lock"
        holder = self._lock_holder(lock)
        if holder is not None:
            raise UpdateError("update already running (run %s)"
                              % holder.get("run_id", "?"))
        if version is not None:
            target = self.store.get_release_by_version(version)
            if not target or target["status"] != "published":
                raise UpdateError(
                    "no published release %r" % (version,))
        else:
            target = self.latest_for_channel(self.get_channel())
            if target is None:
                raise UpdateError("no published release to apply")
        if compare_versions(self.app_version,
                            target["version"]) >= 0:
            raise UpdateError("already updated (current %s >= %s)"
                              % (self.app_version, target["version"]))
        stamp = time.strftime("%Y%m%d-%H%M%S", time.localtime())
        run_id = "APKFORGE-%s-%s" % (
            stamp, _secrets.token_hex(2).upper())
        state = {"state": "STARTED", "run_id": run_id,
                 "version_from": self.app_version,
                 "version_to": target["version"],
                 "started_at": _now(), "log": "logs/update/%s.log"
                 % run_id}
        (gov / "update-state.json").write_text(
            _json.dumps(state, indent=2), encoding="utf-8")
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="UPDATE_STARTED",
            target=target["version"], result="ok",
            detail={"run_id": run_id,
                    "version_from": self.app_version}))
        log_path = root / "logs" / "update" / ("%s.log" % run_id)
        log_path.parent.mkdir(parents=True, exist_ok=True)
        kwargs = {"stdout": open(log_path, "a", encoding="utf-8"),
                  "stderr": _subprocess.STDOUT, "cwd": str(root)}
        if __import__("os").name == "posix":
            kwargs["start_new_session"] = True
        _subprocess.Popen(
            [_sys.executable, str(root / "scripts" / "update.py"),
             "run", "--root", str(root), "--run-id", run_id,
             "--version", target["version"]], **kwargs)
        return dict(state)

    def local_status(self, actor):
        require(actor["role"], PERM_MANAGE)
        import json as _json
        from pathlib import Path as _Path
        root = _Path(__file__).resolve().parents[3]
        state_path = root / ".governance" / "update-state.json"
        if state_path.is_file():
            try:
                state = _json.loads(
                    state_path.read_text(encoding="utf-8"))
                if isinstance(state, dict) and state.get("state"):
                    state["locked"] = self._lock_holder(
                        root / ".governance" / "update.lock") \
                        is not None
                    return state
            except ValueError:
                pass
        return {"state": "IDLE", "run_id": None, "locked": False}

    @staticmethod
    def _lock_holder(lock):
        import json as _json
        import os as _os
        if not lock.is_file():
            return None
        try:
            data = _json.loads(lock.read_text(encoding="utf-8"))
            pid = int(data.get("pid", 0))
        except (ValueError, TypeError):
            lock.unlink(missing_ok=True)
            return None
        try:
            _os.kill(pid, 0)
        except OSError:
            lock.unlink(missing_ok=True)
            return None
        return data

    # -- internals --------------------------------------------------
    def _need(self, release_id):
        release = self.store.get_release(release_id)
        if not release:
            raise LookupError("release not found")
        return release

    def _coerce(self, data, for_create=False):
        data = dict(data or {})
        try:
            version = data["version"]
            parse_version(version)
            code = data.get("version_code")
            if code is None:
                code = version_code(version)
            if int(code) != version_code(version):
                raise UpdateError(
                    "version_code does not match version")
        except KeyError:
            raise UpdateError("version is required") from None
        if data.get("release_type") not in RELEASE_TYPES:
            raise UpdateError("release_type must be one of %s"
                              % (RELEASE_TYPES,))
        if data.get("channel") not in CHANNELS:
            raise UpdateError("channel must be one of %s" % (CHANNELS,))
        if data.get("artifact_kind") not in ARTIFACT_KINDS:
            raise UpdateError("artifact_kind must be bundle|git")
        try:
            parse_version(data.get("minimum_supported_version", ""))
        except UpdateError:
            raise UpdateError(
                "minimum_supported_version must be X.Y.Z") from None
        if data["artifact_kind"] == "bundle" and \
                not data.get("download_url"):
            raise UpdateError("bundle releases need download_url")
        if data["artifact_kind"] == "git" and \
                not data.get("artifact_ref"):
            raise UpdateError("git releases need artifact_ref")
        release = {
            "version": version, "version_code": int(code),
            "release_type": data["release_type"],
            "channel": data["channel"], "status": "draft",
            "minimum_supported_version":
                data["minimum_supported_version"],
            "mandatory": bool(data.get("mandatory", False)),
            "security_update": bool(data.get("security_update", False)),
            "artifact_kind": data["artifact_kind"],
            "download_url": data.get("download_url"),
            "artifact_ref": data.get("artifact_ref"),
            "checksum": data.get("checksum"),
            "signature": data.get("signature"),
            "size_bytes": int(data.get("size_bytes", 0) or 0),
            "release_notes": list(data.get("release_notes", [])),
            "breaking_changes": list(data.get("breaking_changes", [])),
            "security_notes": data.get("security_notes", ""),
            "migration_required": bool(
                data.get("migration_required", False)),
            "restart_required": bool(
                data.get("restart_required", True)),
            "release_date": data.get("release_date") or _now(),
        }
        if for_create and not all(
                isinstance(item, str)
                for item in release["release_notes"]):
            raise UpdateError("release_notes must be strings")
        return release

    def _coherence(self, release):
        problems = []
        if compare_versions(release["minimum_supported_version"],
                            release["version"]) > 0:
            problems.append("minimum_supported_version is newer than "
                            "the release itself")
        if release["artifact_kind"] == "bundle":
            if not release.get("checksum"):
                problems.append("bundle needs a checksum")
            if not release.get("signature"):
                problems.append("bundle needs a signature")
        same_channel = [
            item for item in self.store.list_releases(
                channel=release["channel"], status="published")
            if item["version_code"] >= release["version_code"]]
        if same_channel:
            problems.append(
                "channel %s already publishes %s (code %d >= %d)" % (
                    release["channel"], same_channel[0]["version"],
                    same_channel[0]["version_code"],
                    release["version_code"]))
        return problems
