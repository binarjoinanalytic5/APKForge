"""Roles, permissions, and audit records (Phase 1, stdlib only).

Matrix (§8.2 of the plan): viewer reads; analyst adds decompile/analyze;
developer adds create/upload/rebuild/sign/delete; admin does everything
including user management.
"""
import time
import uuid

ROLES = ("admin", "analyst", "developer", "viewer")

_VIEWER = frozenset({"project.read", "job.read", "artifact.download"})
_ANALYST = _VIEWER | frozenset({"job.decompile", "job.analyze"})
_DEVELOPER = _ANALYST | frozenset({
    "project.create", "project.delete", "artifact.upload", "job.rebuild",
    "job.sign",
})
_PERMISSIONS = {
    "viewer": _VIEWER,
    "analyst": _ANALYST,
    "developer": _DEVELOPER,
    "admin": frozenset({"*"}),
}


class RBACError(PermissionError):
    pass


def permissions(role: str) -> frozenset:
    try:
        return _PERMISSIONS[role]
    except KeyError:
        raise RBACError("unknown role %r" % (role,)) from None


def check(role: str, permission: str) -> bool:
    granted = permissions(role)
    return "*" in granted or permission in granted


def require(role: str, permission: str) -> None:
    if not check(role, permission):
        raise RBACError("role %r lacks %r" % (role, permission))


def audit_record(*, actor: str, action: str, target: str,
                 result: str, detail: dict = None) -> dict:
    """Append-only audit entry (who/when/what/outcome)."""
    if not actor or not action or not target or not result:
        raise RBACError("audit entry requires actor/action/target/result")
    return {
        "id": uuid.uuid4().hex,
        "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "actor": actor,
        "action": action,
        "target": target,
        "result": result,
        "detail": detail or {},
    }
