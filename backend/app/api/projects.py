"""Project routes."""
from fastapi import APIRouter, Depends, Request
from pydantic import BaseModel, Field

from .deps import actor, http_error, services

router = APIRouter(prefix="/api/v1/projects", tags=["projects"])


class ProjectIn(BaseModel):
    name: str = Field(min_length=1, max_length=128)


@router.post("", status_code=201)
def create_project(body: ProjectIn, request: Request,
                   who=Depends(actor), svc=Depends(services)):
    try:
        return svc["projects"].create(who, body.name)
    except Exception as exc:
        raise http_error(exc)


@router.get("")
def list_projects(request: Request, who=Depends(actor),
                  svc=Depends(services)):
    try:
        return svc["projects"].list(who)
    except Exception as exc:
        raise http_error(exc)


@router.get("/{project_id}")
def get_project(project_id: str, request: Request,
                who=Depends(actor), svc=Depends(services)):
    try:
        return svc["projects"].get(who, project_id)
    except Exception as exc:
        raise http_error(exc)


@router.delete("/{project_id}", status_code=204)
def delete_project(project_id: str, request: Request,
                   who=Depends(actor), svc=Depends(services)):
    try:
        svc["projects"].delete(who, project_id)
    except Exception as exc:
        raise http_error(exc)
    return None
