"""WebSocket job feed implementing docs/websocket.md (frozen v1).

hello → log* → status* → bye, then close. Phase-1 simplifications
(documented, not silent): no 30s ping heartbeat and no 100-subscriber
cap — both arrive with the multi-worker fan-out in Phase 2.
"""
import asyncio

from fastapi import APIRouter, WebSocket, WebSocketDisconnect

from ..core.wsframes import Seq, bye, hello, log, status
from ..services.jobs import TERMINAL

router = APIRouter()


@router.websocket("/api/v1/ws/jobs/{job_id}")
async def job_feed(websocket: WebSocket, job_id: str):
    await websocket.accept()
    svc = websocket.app.state.services
    try:
        who = svc["auth"].verify(
            websocket.query_params.get("token", ""))
    except Exception:
        await websocket.close(code=4401)
        return
    try:
        job = svc["jobs"].get(who, job_id)
    except LookupError:
        await websocket.close(code=4404)
        return
    except Exception:
        await websocket.close(code=4403)
        return
    seq = Seq()
    await websocket.send_json(hello(job_id, job["status"]))
    last_status = job["status"]
    sent_lines = 0
    try:
        while True:
            job = svc["jobs"].get(who, job_id)
            lines = job["log_lines"]
            for line in lines[sent_lines:]:
                sent_lines += 1
                await websocket.send_json(
                    log(seq.next(), "stdout", line))
            if job["status"] != last_status:
                last_status = job["status"]
                reason = job.get("error") \
                    if last_status == "failed" else None
                await websocket.send_json(
                    status(seq.next(), last_status, reason))
            if last_status in TERMINAL:
                await websocket.send_json(
                    bye(last_status, {"job_id": job_id}))
                await websocket.close(code=1000)
                return
            await asyncio.sleep(0.5)
    except WebSocketDisconnect:
        return
