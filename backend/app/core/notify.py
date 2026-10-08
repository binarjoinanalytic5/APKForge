"""Notification domain: types, priorities, preferences (stdlib)."""
TYPES = ("UPDATE_AVAILABLE", "MANDATORY_UPDATE", "SECURITY_UPDATE",
         "MAINTENANCE", "SYSTEM_ANNOUNCEMENT", "FEATURE_RELEASE")
SEVERITIES = ("info", "important", "critical")
PRIORITY = {"SYSTEM_ANNOUNCEMENT": 1, "FEATURE_RELEASE": 1,
            "UPDATE_AVAILABLE": 2, "MAINTENANCE": 2,
            "SECURITY_UPDATE": 3, "MANDATORY_UPDATE": 3}
TYPE_TO_PREF = {"UPDATE_AVAILABLE": "system_updates",
                "MANDATORY_UPDATE": None,  # critical: never muted
                "SECURITY_UPDATE": "security_alerts",
                "MAINTENANCE": "maintenance",
                "SYSTEM_ANNOUNCEMENT": "announcements",
                "FEATURE_RELEASE": "feature_updates"}
DEFAULT_PREFS = {"system_updates": True, "feature_updates": True,
                 "announcements": True, "maintenance": True,
                 "security_alerts": True}


class NotifyError(ValueError):
    pass


def validate(ntype, severity="info"):
    if ntype not in TYPES:
        raise NotifyError("unknown notification type %r" % (ntype,))
    if severity not in SEVERITIES:
        raise NotifyError("unknown severity %r" % (severity,))
    return PRIORITY[ntype]


def is_critical(ntype, severity):
    """Critical items bypass user mute preferences, always visible."""
    return ntype == "MANDATORY_UPDATE" or severity == "critical"


def deliverable(ntype, severity, prefs):
    """True iff the notification passes the user's preferences."""
    if is_critical(ntype, severity):
        return True
    key = TYPE_TO_PREF.get(ntype)
    if key is None:
        return True
    merged = dict(DEFAULT_PREFS)
    merged.update(prefs or {})
    return bool(merged.get(key, True))


def is_expired(expires_at, now_iso):
    """ISO-8601 Z strings compare lexicographically — safe here."""
    if not expires_at:
        return False
    return str(expires_at) <= str(now_iso)
