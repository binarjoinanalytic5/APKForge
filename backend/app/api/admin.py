"""Admin update management: releases, channel, maintenance, backups.

Rollback itself runs in the bootstrap engine (it must stop services
and restore files); this API lists backups with their CLI command —
no fake rollback buttons.
"""
import json
from pathlib import Path

from fastapi import APIRouter, Depends, Request
from pydantic import BaseModel

from .deps import actor, http_error, services

router = APIRouter(prefix="/api/v1/admin", tags=["admin"])


class ReleaseIn(BaseModel):
    version: str
    version_code: int | None = None
    release_type: str
    channel: str
    minimum_supported_version: str
    mandatory: bool = False
    security_update: bool = False
    artifact_kind: str
    download_url: str | None = None
    artifact_ref: str | None = None
    checksum: str | None = None
    signature: str | None = None
    size_bytes: int = 0
    release_notes: list[str] = []
    breaking_changes: list[str] = []
    security_notes: str = ""
    migration_required: bool = False
    restart_required: bool = True
    release_date: str | None = None


class MaintenanceIn(BaseModel):
    active: bool
    message: str = ""


class ChannelIn(BaseModel):
    channel: str


class ApplyIn(BaseModel):
    version: str | None = None


@router.post("/releases", status_code=201)
def create_release(body: ReleaseIn, request: Request,
                   who=Depends(actor), svc=Depends(services)):
    try:
        return svc["updates"].create_release(
            who, body.model_dump())
    except Exception as exc:
        raise http_error(exc)


@router.get("/releases")
def list_releases(request: Request, channel: str | None = None,
                  status: str | None = None, who=Depends(actor),
                  svc=Depends(services)):
    try:
        return svc["updates"].list_releases(who, channel=channel,
                                            status=status)
    except Exception as exc:
        raise http_error(exc)


@router.get("/releases/history")
def release_history(request: Request, who=Depends(actor),
                    svc=Depends(services)):
    try:
        return svc["updates"].history(who)
    except Exception as exc:
        raise http_error(exc)


@router.post("/releases/{release_id}/validate")
def validate_release(release_id: str, request: Request,
                     who=Depends(actor), svc=Depends(services)):
    try:
        return svc["updates"].validate_release(who, release_id)
    except Exception as exc:
        raise http_error(exc)


@router.post("/releases/{release_id}/publish")
def publish_release(release_id: str, request: Request,
                    who=Depends(actor), svc=Depends(services)):
    try:
        return svc["updates"].publish_release(
            who, release_id, notify=svc["notify"])
    except Exception as exc:
        raise http_error(exc)


@router.post("/releases/{release_id}/unpublish")
def unpublish_release(release_id: str, request: Request,
                      who=Depends(actor), svc=Depends(services)):
    try:
        return svc["updates"].unpublish_release(who, release_id)
    except Exception as exc:
        raise http_error(exc)


@router.get("/maintenance")
def get_maintenance(request: Request, who=Depends(actor),
                    svc=Depends(services)):
    return svc["updates"].get_maintenance()


@router.put("/maintenance")
def set_maintenance(body: MaintenanceIn, request: Request,
                    who=Depends(actor), svc=Depends(services)):
    try:
        return svc["updates"].set_maintenance(
            who, body.active, body.message)
    except Exception as exc:
        raise http_error(exc)


@router.get("/channel")
def get_channel(request: Request, who=Depends(actor),
                svc=Depends(services)):
    return {"channel": svc["updates"].get_channel()}


@router.put("/channel")
def set_channel(body: ChannelIn, request: Request,
                who=Depends(actor), svc=Depends(services)):
    try:
        return svc["updates"].set_channel(who, body.channel)
    except Exception as exc:
        raise http_error(exc)


@router.post("/updates/apply", status_code=202)
def apply_update(body: ApplyIn, request: Request,
                 who=Depends(actor), svc=Depends(services)):
    try:
        return svc["updates"].apply_local(who, version=body.version)
    except Exception as exc:
        raise http_error(exc)


@router.get("/updates/local-status")
def update_local_status(request: Request, who=Depends(actor),
                        svc=Depends(services)):
    try:
        return svc["updates"].local_status(who)
    except Exception as exc:
        raise http_error(exc)


@router.get("/backups")
def list_backups(request: Request, who=Depends(actor),
                 svc=Depends(services)):
    from ..core.rbac import require
    try:
        require(who["role"], "release.manage")
        registry = Path(__file__).resolve().parents[3] \
            / ".governance" / "backups.json"
        backups = []
        if registry.is_file():
            loaded = json.loads(registry.read_text(encoding="utf-8"))
            backups = loaded.get("backups", []) \
                if isinstance(loaded, dict) else []
        for backup in backups:
            backup["rollback_command"] = \
                "./apkforge update --rollback %s" % backup.get("id")
        return {"backups": backups}
    except Exception as exc:
        raise http_error(exc)
