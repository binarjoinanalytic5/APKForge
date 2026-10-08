# البنية (عقدة واحدة — Compose)

- `compose.yaml`: الخدمات الخمس (api/worker/db/redis/s3).
- `backend.Dockerfile` / `worker.Dockerfile`: صور `python:3.12-slim` بمستخدم غير جذري.
- `prometheus.yml`: كشط أدنى (المرحلة 1: لوحات Grafana + Loki).

لا أسرار في هذا المجلد — كل سر عبر البيئة أو مدير أسرار (يُفحَص في CI).

ملاحظة التثبيت: وسم SeaweedFS استثناء موثق في المرحلة 0 (انظر التعليق
في `compose.yaml`) — التثبيت المُتحقَّق عند أول سحب في المرحلة 1.
