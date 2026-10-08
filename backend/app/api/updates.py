"""Public update endpoints: current version, manifest, check.

Manifest responses carry an ETag; clients revalidate with
If-None-Match and get 304 when nothing changed (no polling floods).
"""
import hashlib
import json

from fastapi import APIRouter, Depends, Request
from fastapi.responses import Response
from pydantic import BaseModel

from ..core.updates import UpdateError
from ..version import APP_VERSION, APP_VERSION_CODE
from .deps import http_error, services

router = APIRouter(prefix="/api/v1/updates", tags=["updates"])


class CheckIn(BaseModel):
    current_version: str
    channel: str | None = None


def _etag(payload):
    body = json.dumps(payload, sort_keys=True).encode("utf-8")
    return '"%s"' % hashlib.sha256(body).hexdigest()[:32], body


@router.get("/current")
def current_version(request: Request, svc=Depends(services)):
    return {"version": APP_VERSION, "version_code": APP_VERSION_CODE,
            "channel": svc["updates"].get_channel()}


@router.get("/manifest")
def manifest(request: Request, channel: str | None = None,
             svc=Depends(services)):
    try:
        wanted = channel or svc["updates"].get_channel()
        payload = svc["updates"].manifest_for_channel(wanted)
    except (UpdateError, LookupError) as exc:
        raise http_error(exc)
    tag, body = _etag(payload)
    if request.headers.get("if-none-match", "").strip("\" ") == \
            tag.strip("\""):
        return Response(status_code=304)
    return Response(content=body, media_type="application/json",
                    headers={"ETag": tag})


@router.post("/check")
def check(body: CheckIn, request: Request, svc=Depends(services)):
    try:
        wanted = body.channel or svc["updates"].get_channel()
        return svc["updates"].check(body.current_version, wanted)
    except UpdateError as exc:
        raise http_error(exc)
