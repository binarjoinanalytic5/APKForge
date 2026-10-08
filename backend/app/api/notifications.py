"""Notification center endpoints (per-user reads + preferences)."""
from fastapi import APIRouter, Depends, Request
from pydantic import BaseModel

from .deps import actor, http_error, services

router = APIRouter(prefix="/api/v1/notifications",
                   tags=["notifications"])


class ReadIn(BaseModel):
    read: bool = True


class PrefsIn(BaseModel):
    prefs: dict = {}


class BroadcastIn(BaseModel):
    ntype: str
    title: str
    message: str
    severity: str = "info"
    action: dict = {}
    expires_at: str | None = None


@router.get("")
def list_notes(request: Request, who=Depends(actor),
               svc=Depends(services)):
    notes = svc["notify"].list_for_user(who["sub"])
    unread = sum(1 for note in notes if not note["read"])
    return {"notifications": notes, "unread": unread}


@router.post("/{note_id}/read")
def mark_read(note_id: str, body: ReadIn, request: Request,
              who=Depends(actor), svc=Depends(services)):
    try:
        return svc["notify"].mark(who["sub"], note_id,
                                  read=body.read)
    except LookupError as exc:
        raise http_error(exc)


@router.get("/prefs")
def get_prefs(request: Request, who=Depends(actor),
              svc=Depends(services)):
    return {"prefs": svc["notify"].get_prefs(who["sub"])}


@router.put("/prefs")
def set_prefs(body: PrefsIn, request: Request, who=Depends(actor),
              svc=Depends(services)):
    try:
        return {"prefs": svc["notify"].set_prefs(who["sub"],
                                                 body.prefs)}
    except Exception as exc:
        raise http_error(exc)


@router.post("/broadcast", status_code=201)
def broadcast(body: BroadcastIn, request: Request,
              who=Depends(actor), svc=Depends(services)):
    try:
        return svc["notify"].broadcast(
            who, body.ntype, body.title, body.message,
            severity=body.severity, action=body.action,
            expires_at=body.expires_at)
    except Exception as exc:
        raise http_error(exc)


@router.delete("/{note_id}", status_code=204)
def delete_note(note_id: str, request: Request, who=Depends(actor),
                svc=Depends(services)):
    try:
        svc["notify"].delete(who, note_id)
    except Exception as exc:
        raise http_error(exc)
    return None
