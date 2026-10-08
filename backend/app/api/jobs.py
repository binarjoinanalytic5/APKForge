"""Job routes shaped exactly by the frozen OpenAPI contract.

POST .../upload | .../decompile | .../analyze | .../rebuild | .../sign
GET  /jobs/{job_id} | /jobs/{job_id}/logs | .../download
"""
import json

from fastapi import (APIRouter, BackgroundTasks, Depends, Request,
                     UploadFile)
from fastapi.responses import Response
from pydantic import BaseModel

from .deps import actor, http_error, services

router = APIRouter(tags=["jobs"])


class ToolSelect(BaseModel):
    tool: str | None = None
    options: dict = {}


class SignRequest(BaseModel):
    keystore_ref: str | None = None
    schemes: list[str] = []


def _job_response(job, status_code=202):
    return Response(status_code=status_code,
                    content=json.dumps(job),
                    media_type="application/json")


def _start(project_id, kind, body, request, background, who, svc):
    tool = getattr(body, "tool", None)
    options = dict(getattr(body, "options", None) or {})
    if tool:
        options["tool"] = tool
    if isinstance(body, SignRequest):
        options["keystore_ref"] = body.keystore_ref
        options["schemes"] = body.schemes
    try:
        job = svc["jobs"].start(who, project_id, kind,
                                options=options or None)
    except Exception as exc:
        raise http_error(exc)
    background.add_task(svc["jobs"].execute, job["job_id"])
    return _job_response(job)


@router.post("/api/v1/projects/{project_id}/upload",
             status_code=202)
async def upload(project_id: str, request: Request,
                 file: UploadFile, who=Depends(actor),
                 svc=Depends(services)):
    try:
        data = await file.read()
        job = svc["jobs"].store_upload(
            who, project_id, file.filename or "upload.apk", data)
    except Exception as exc:
        raise http_error(exc)
    return _job_response(job)


@router.post("/api/v1/projects/{project_id}/decompile",
             status_code=202)
def decompile(project_id: str, body: ToolSelect | None,
              request: Request, background: BackgroundTasks,
              who=Depends(actor), svc=Depends(services)):
    return _start(project_id, "decompile", body or ToolSelect(),
                  request, background, who, svc)


@router.post("/api/v1/projects/{project_id}/analyze",
             status_code=202)
def analyze(project_id: str, body: ToolSelect | None,
            request: Request, background: BackgroundTasks,
            who=Depends(actor), svc=Depends(services)):
    return _start(project_id, "analyze", body or ToolSelect(),
                  request, background, who, svc)


@router.post("/api/v1/projects/{project_id}/rebuild",
             status_code=202)
def rebuild(project_id: str, request: Request,
            background: BackgroundTasks, who=Depends(actor),
            svc=Depends(services)):
    return _start(project_id, "rebuild", ToolSelect(), request,
                  background, who, svc)


@router.post("/api/v1/projects/{project_id}/sign", status_code=202)
def sign(project_id: str, body: SignRequest | None,
         request: Request, background: BackgroundTasks,
         who=Depends(actor), svc=Depends(services)):
    return _start(project_id, "sign", body or SignRequest(),
                  request, background, who, svc)


@router.get("/api/v1/jobs/{job_id}")
def get_job(job_id: str, request: Request, who=Depends(actor),
            svc=Depends(services)):
    try:
        return svc["jobs"].get(who, job_id)
    except Exception as exc:
        raise http_error(exc)


@router.get("/api/v1/jobs/{job_id}/logs")
def get_logs(job_id: str, request: Request, who=Depends(actor),
             svc=Depends(services)):
    try:
        return svc["jobs"].logs(who, job_id)
    except Exception as exc:
        raise http_error(exc)


@router.get("/api/v1/projects/{project_id}/download")
def download(project_id: str, request: Request, who=Depends(actor),
             svc=Depends(services)):
    try:
        job = svc["jobs"].latest_result(who, project_id)
        blob = svc["blobs"].get_bytes(job["result_ref"])
    except Exception as exc:
        raise http_error(exc)
    return Response(
        content=blob, media_type="application/octet-stream",
        headers={"Content-Disposition":
                 'attachment; filename="%s-result"' % project_id})
