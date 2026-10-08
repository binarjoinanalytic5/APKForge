"""Auth routes: register + login."""
from fastapi import APIRouter, Depends, Request
from pydantic import BaseModel, Field

from ..core.security import AuthError
from .deps import http_error, services

router = APIRouter(prefix="/api/v1/auth", tags=["auth"])


class Credentials(BaseModel):
    username: str = Field(min_length=3, max_length=64)
    password: str = Field(min_length=12, max_length=256)
    role: str = "viewer"


@router.post("/register", status_code=201)
def register(body: Credentials, request: Request,
             svc=Depends(services)):
    try:
        return svc["auth"].register(body.username, body.password,
                                    body.role)
    except AuthError as exc:
        raise http_error(exc)


@router.post("/login")
def login(body: Credentials, request: Request, svc=Depends(services)):
    try:
        return svc["auth"].login(body.username, body.password)
    except AuthError as exc:
        raise http_error(exc)
