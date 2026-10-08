# APKForge — منصة متكاملة لهندسة وتوقيع APK

منصة مفتوحة المصدر (Apache-2.0) لفك وتحليل وتعديل وبناء وتوقيع ملفات APK:
تدمج أفضل الأدوات المجرّبة (Apktool وJADX وAndroguard وQuark وغيرها) خلف
واجهات موحدة — ويب وREST وWebSocket وCLI — بدل إعادة اختراعها.

> القاعدة الحاكمة: **لا بناء من الصفر.** أي قدرة لها بديل ناضج تُدمَج،
> وما يُكتَب هنا طبقة رقيقة (موصلات وعقود وواجهات). الوثيقة الحاكمة:
> [`docs/plan.md`](docs/plan.md).

## الحالة: المرحلة 0 (التأسيس)

- الهيكل والعقود المجمدة: `docs/openapi.yaml` (v1) و`docs/plugin-sdk.md` (SDK v1).
- `backend/` نواة FastAPI (هيكل)، `workers/` محولات الأدوات، `plugins/` حزم الأدوات.
- `infra/compose.yaml` تشغيل عقدة واحدة: API وعامل وPostgres وRedis وتخزين S3.
- `archive/reelsec-legacy/` العمل السابق كاملًا (مؤرشف، يُدمَج لاحقًا كإضافة `reelsec-verify`).

## التشغيل السريع (عند اكتمال المرحلة 1)

```sh
docker compose -f infra/compose.yaml up -d
```

## البنية

انظر [`ARCHITECTURE.md`](ARCHITECTURE.md) وقرارات [`docs/adr/`](docs/adr/).

## المساهمة والأمان

- المساهمة: [`CONTRIBUTING.md`](CONTRIBUTING.md) (البوابات إلزامية: اختبارات خضراء + فحص أسرار + مراجعة عقد).
- الأمان: [`SECURITY.md`](SECURITY.md) — الاستخدام المصرح به فقط، وبلا أدوات تجاوز DRM.

## English summary

APKForge is an Apache-2.0, self-hostable workbench for APK engineering:
decompile, analyze, modify, rebuild, align, and sign — by integrating proven
open-source tools behind unified APIs (REST/WebSocket/CLI) instead of
rebuilding them. Stage: Phase 0 (skeleton + frozen contracts). See
[`docs/plan.md`](docs/plan.md) (Arabic, normative).
