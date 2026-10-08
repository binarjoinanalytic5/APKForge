"""Unit tests: RBAC matrix + audit record shape (core/rbac.py)."""
import pytest

from app.core.rbac import (RBACError, ROLES, audit_record, check,
                           permissions, require)


def test_roles_known():
    assert ROLES == ("admin", "analyst", "developer", "viewer")


def test_admin_has_everything():
    for action in ("project.read", "project.create", "project.delete",
                   "artifact.upload", "artifact.download",
                   "job.read", "job.decompile", "job.analyze",
                   "job.rebuild", "job.sign", "anything.future"):
        assert check("admin", action) is True
        assert require("admin", action) is None


def test_viewer_read_only():
    for action in ("project.read", "job.read", "artifact.download"):
        assert require("viewer", action) is None
    for action in ("project.create", "job.decompile", "job.analyze",
                   "artifact.upload", "job.rebuild", "job.sign",
                   "project.delete"):
        with pytest.raises(RBACError):
            require("viewer", action)


def test_analyst_adds_decompile_and_analyze():
    for action in ("project.read", "job.decompile", "job.analyze"):
        assert require("analyst", action) is None
    for action in ("project.create", "artifact.upload", "job.rebuild",
                   "job.sign", "project.delete"):
        with pytest.raises(RBACError):
            require("analyst", action)


def test_developer_adds_mutations():
    for action in ("project.create", "project.delete",
                   "artifact.upload", "job.rebuild", "job.sign",
                   "job.decompile", "job.analyze", "project.read"):
        assert require("developer", action) is None


def test_unknown_role_denied():
    with pytest.raises(RBACError):
        require("ghost", "job.read")
    with pytest.raises(RBACError):
        permissions("ghost")
    with pytest.raises(RBACError):
        check("ghost", "job.read")


def test_audit_record_shape():
    record = audit_record(actor="alice", action="job.decompile.start",
                          target="job-1", result="ok",
                          detail={"tool": "apktool"})
    assert record["actor"] == "alice"
    assert record["result"] == "ok"
    assert record["detail"] == {"tool": "apktool"}
    assert record["ts"].endswith("Z")
    assert record["id"]
    with pytest.raises(RBACError):
        audit_record(actor="", action="b", target="c", result="ok")
