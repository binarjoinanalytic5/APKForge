"""First-run administrator setup (additive bootstrap endpoints).

GET  /api/v1/setup/status → {initialized: bool} (public)
POST /api/v1/setup/admin  → creates the owner admin exactly once;
subsequent calls return 403 SYSTEM_INITIALIZED. No default
credentials exist anywhere: the admin is whoever completes setup.
"""
import json

from fastapi import APIRouter, Depends, Request
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field

from ..core.security import AuthError
from .deps import http_error, services

router = APIRouter(prefix="/api/v1/setup", tags=["setup"])


class SetupAdminIn(BaseModel):
    username: str = Field(min_length=3, max_length=64)
    password: str = Field(min_length=12, max_length=256)
    display_name: str | None = Field(default=None, max_length=128)
    email: str | None = Field(default=None, max_length=254)


@router.get("/status")
def setup_status(request: Request, svc=Depends(services)):
    store = svc["store"]
    return {"initialized": store.user_count() > 0}


@router.post("/admin", status_code=201)
def setup_admin(body: SetupAdminIn, request: Request,
                svc=Depends(services)):
    store = svc["store"]
    if store.user_count() > 0:
        return JSONResponse(
            status_code=403,
            content={"code": "SYSTEM_INITIALIZED",
                     "message": "an administrator already exists"})
    try:
        token = svc["auth"].register(body.username, body.password,
                                     "admin")
    except AuthError as exc:
        raise http_error(exc)
    profile = {key: value for key, value in
               (("display_name", body.display_name),
                ("email", body.email)) if value}
    store.set_config("initialized", "true")
    if profile:
        store.set_config("admin_profile", json.dumps(profile))
    return {"username": body.username.strip(), "role": "admin",
            "access_token": token["access_token"],
            "token_type": token["token_type"]}
