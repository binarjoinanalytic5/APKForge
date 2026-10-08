# الإقلاع بأمر واحد (`./apkforge`)

الأمر الوحيد لتهيئة المشروع وتشغيله على بيئة جديدة — عقل الإقلاع
`scripts/apkforge.py` (مكتبة قياسية خالصة، يعمل من أي مجلد).

## خط الأنابيب

```
./apkforge
  INIT → ENVIRONMENT_CHECK → TOOLS_READY → CONFIG_READY
  → DATABASE_READY → MIGRATIONS_READY → SEED_READY → BUILD_READY
  → SERVICES_READY → HEALTHY → ADMIN_SETUP_REQUIRED? → READY
```

- كل خطوة تتحقق أولًا (`already installed/running/migrated`) فالتشغيل
  **idempotent**: آمن عشرات المرات دون تكرار أو تخريب.
- الحالة تُحفَظ في `.governance/bootstrap-state.json` فيُستأنَف من آخر
  نقطة صالحة؛ وكل إخفاق يُسجَّل مع بديله في `failures.jsonl` ولا يُعاد
  بالطريقة نفسها.
- لا يُعلَن `READY` إلا بصحة حقيقية: عمليات + منافذ + HTTP + قاعدة
  بيانات + ترحيلات + مصادقة سالبة + صفحة واجهة.

## الأوضاع

| الأمر | الأثر |
|---|---|
| `./apkforge` | الخط الكامل + فتح المتصفح على الإعداد أو التطبيق |
| `./apkforge --check` | تدقيق فقط (بيئة/أدوات/إعداد/قاعدة/خدمات) بلا تغيير |
| `./apkforge --status` | الحالة والخدمات والمنافذ بلا تغيير |
| `./apkforge --repair` | إعادة الخط مع بدائل الخطوات الفاشلة |
| `./apkforge --reset-dev --yes` | إيقاف + حذف قاعدة التطوير والحالة (يرفض الإنتاج، وينسخ `.env` احتياطيًا ولا يحذف الأسرار) |
| `./apkforge --logs` | ذيول السجلات |
| `./apkforge --stop` | إيقاف الخدمات |
| `--skip-build` / `--no-browser` / `--install-tools` / `--json` | معدِّلات (تخطي البناء، بلا متصفح، جلب Apktool، تقرير آلي) |

## البنية المكتشفة من المشروع (لا تخمين)

| السؤال | الجواب المستخرج |
|---|---|
| نظام التشغيل | أي نظام (يُكتشَف وقت التشغيل؛ Linux/macOS/Windows) |
| الأدوات المطلوبة فعلًا | python3 ≥3.10 وpip وnode ≥20 وnpm (من `requirements*.txt` و`package.json`) |
| الأدوات الاختيارية | java وapktool وjadx (تُكتشَف من `PATH` أو متغيرات `APKFORGE_*`) |
| الخدمات المطلوبة | خلفية uvicorn + واجهة ستاتيكية (لا Postgres/Redis/Celery في المرحلة 1 — ADR-004) |
| محرك القاعدة | SQLite ملفي (`APKFORGE_DB`) |
| الترحيلات | `backend/migrations/001–003` + سجل `schema_migrations` |
| الجداول | users وprojects وjobs وartifacts وaudit وsystem_config (مستعادة من الكود — بلا اشتراكات/مدفوعات لأن المشروع لا يملكها) |
| الخلفية | FastAPI (`app.main:app`) على `APKFORGE_PORT` (8000) |
| الواجهة | Vue مبنية (`frontend/dist`) تُقدَّم ستاتيكيًا على `APKFORGE_WEB_PORT` (3000) |
| التشغيل السابق | uvicorn وnpm يدويًا (تحوَّل تلقائيًا) |

## ملاحظات أمانة (انحرافات موثقة)

- نقطتا `/setup/status` و`/setup/admin` **إضافة تراكمية** غير كاسرة
  للعقد v1 (الإصدار ثابت 1.0.0؛ بوابات العقود المجمدة ما زالت خضراء).
- `jadx` لا يُجلَب تلقائيًا أبدًا (حجمه ~130MB) — تعليمات يدوية فقط.
- البذور (seed): لا صفوف بذور عمدًا — أول مدير يُنشَأ عبر صفحة الإعداد.
