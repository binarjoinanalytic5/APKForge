# APKForge API image (Phase 0 skeleton).
FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN useradd -m -u 10001 apkforge
WORKDIR /srv/apkforge
COPY backend/requirements.txt ./backend-requirements.txt
RUN pip install --no-cache-dir -r backend-requirements.txt
COPY backend/ ./backend/
COPY docs/openapi.yaml ./docs-openapi.yaml
USER apkforge
EXPOSE 8000
CMD ["python", "-m", "uvicorn", "backend.app.main:app", "--host", "0.0.0.0", "--port", "8000"]
