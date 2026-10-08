# APKForge worker image (Phase 0 skeleton; Celery tasks land in Phase 1).
FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN useradd -m -u 10001 apkforge
WORKDIR /srv/apkforge
COPY backend/requirements.txt ./backend-requirements.txt
RUN pip install --no-cache-dir -r backend-requirements.txt
COPY workers/ ./workers/
COPY plugins/ ./plugins/
USER apkforge
# Phase 1: celery -A workers.celery_app worker
CMD ["python", "-c", "import workers.base; print('worker skeleton ok')"]
