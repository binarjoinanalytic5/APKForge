"""Shared dependencies: actor extraction and error mapping."""
from fastapi import Header, HTTPException, Request

from ..core.rbac import RBACError
from ..core.security import AuthError


def services(request: Request):
    return request.app.state.services


def actor(authorization: str = Header(default=""), request: Request = None):
    """Extract the verified actor from `Authorization: Bearer <jwt>`."""
    token = ""
    if authorization.lower().startswith("bearer "):
        token = authorization[7:].strip()
    try:
        return request.app.state.services["auth"].verify(token)
    except AuthError as exc:
        raise HTTPException(status_code=401, detail=str(exc))


def http_error(exc):
    """Map stdlib service errors to HTTP status codes."""
    if isinstance(exc, RBACError):
        return HTTPException(status_code=403, detail=str(exc))
    if isinstance(exc, LookupError):
        return HTTPException(status_code=404, detail=str(exc))
    if isinstance(exc, ValueError):
        return HTTPException(status_code=400, detail=str(exc))
    if isinstance(exc, AuthError):
        return HTTPException(status_code=401, detail=str(exc))
    return HTTPException(status_code=500, detail="internal error")
