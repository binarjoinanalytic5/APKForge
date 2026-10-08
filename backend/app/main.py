"""APKForge API entrypoint (Phase 0: health only).

Full v1 routes land in Phase 1, implemented against docs/openapi.yaml.
"""
from fastapi import FastAPI

from .version import API_VERSION

app = FastAPI(title="APKForge API", version=API_VERSION)


@app.get("/api/v1/health")
def health():
    return {"status": "ok", "api_version": API_VERSION}
