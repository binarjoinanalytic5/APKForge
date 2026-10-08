"""Notifications: broadcast, per-user reads, preferences (stdlib)."""
import time

from ..core.notify import (DEFAULT_PREFS, NotifyError, deliverable,
                           is_expired, validate)
from ..core.rbac import audit_record, require

PERM_BROADCAST = "notification.broadcast"  # admin-only via "*"
PERM_DELETE = "notification.delete"


def _now():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())


class NotificationService:
    def __init__(self, store):
        self.store = store

    def broadcast(self, actor, ntype, title, message, severity="info",
                  action=None, target="all", expires_at=None):
        require(actor["role"], PERM_BROADCAST)
        priority = validate(ntype, severity)
        if not title or not message:
            raise NotifyError("title and message are required")
        note = self.store.create_notification({
            "ntype": ntype, "severity": severity, "priority": priority,
            "title": title, "message": message,
            "action": action or {}, "target": target,
            "expires_at": expires_at})
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="notification.broadcast",
            target=note["id"], result="ok",
            detail={"type": ntype}))
        return note

    def list_for_user(self, username):
        prefs = self.store.get_prefs(username)
        reads = self.store.read_ids(username)
        now = _now()
        notes = []
        for note in self.store.list_notifications():
            if note["target"] not in ("all", "user:" + username):
                continue
            if is_expired(note.get("expires_at"), now):
                continue
            if not deliverable(note["ntype"], note["severity"], prefs):
                continue
            note = dict(note)
            note["read"] = note["id"] in reads
            notes.append(note)
        return notes

    def unread_count(self, username):
        return sum(1 for note in self.list_for_user(username)
                   if not note["read"])

    def mark(self, username, notification_id, read=True):
        known = {note["id"]
                 for note in self.store.list_notifications()}
        if notification_id not in known:
            raise LookupError("notification not found")
        self.store.mark_notification(notification_id, username,
                                     read=read)
        return {"id": notification_id, "read": bool(read)}

    def delete(self, actor, notification_id):
        require(actor["role"], PERM_DELETE)
        known = {note["id"]
                 for note in self.store.list_notifications()}
        if notification_id not in known:
            raise LookupError("notification not found")
        self.store.delete_notification(notification_id)
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="notification.deleted",
            target=notification_id, result="ok"))

    def get_prefs(self, username):
        merged = dict(DEFAULT_PREFS)
        merged.update(self.store.get_prefs(username))
        return merged

    def set_prefs(self, username, prefs):
        unknown = set((prefs or {})) - set(DEFAULT_PREFS)
        if unknown:
            raise NotifyError("unknown pref keys: %s"
                              % ", ".join(sorted(unknown)))
        merged = dict(DEFAULT_PREFS)
        merged.update(self.store.get_prefs(username))
        merged.update({key: bool(value)
                       for key, value in (prefs or {}).items()})
        self.store.set_prefs(username, merged)
        return merged
