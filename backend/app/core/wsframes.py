"""WebSocket frame builders per docs/websocket.md (stdlib only)."""
import time


def _ts():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())


class Seq:
    """Per-connection sequence counter (gaps mean loss)."""

    def __init__(self):
        self.value = 0

    def next(self):
        self.value += 1
        return self.value


def hello(job_id, status):
    return {"type": "hello", "job_id": job_id, "status": status, "ts": _ts()}


def log(seq, stream, line):
    if stream not in ("stdout", "stderr"):
        raise ValueError("unknown stream %r" % (stream,))
    return {"type": "log", "seq": seq, "ts": _ts(), "stream": stream,
            "line": line}


def progress(seq, percent, stage):
    percent = int(percent)
    if not 0 <= percent <= 100:
        raise ValueError("percent out of range")
    return {"type": "progress", "seq": seq, "ts": _ts(),
            "percent": percent, "stage": stage}


def status(seq, job_status, reason=None):
    frame = {"type": "status", "seq": seq, "ts": _ts(),
             "status": job_status}
    if reason:
        frame["reason"] = reason
    return frame


def bye(job_status, summary=None):
    frame = {"type": "bye", "ts": _ts(), "status": job_status}
    if summary:
        frame["summary"] = summary
    return frame
