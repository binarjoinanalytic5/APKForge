# الإقلاع بأمر واحد (`./apkforge`)

الأمر الوحيد لتهيئة المشروع وتشغيله على بيئة جديدة — عقل الإقلاع
`scripts/apkforge.py` (مكتبة قياسية خالصة، يعمل من أي مجلد).

## خط الأنابيب

```
./apkforge                      (المحرك 2.0.0: تكيفي)
  GIT? → ENVIRONMENT_CHECK → ENVIRONMENT_DETECTED
  → TOOLS_INVENTORIED → COMPATIBILITY_RESOLVED → PLAN_CREATED
  → TOOLS_READY → CONFIG_READY → RUNTIME_READY → DEPENDENCIES_READY
  → DATABASE_READY → MIGRATIONS_READY → SEED_READY → BUILD_READY
  → SERVICES_READY → HEALTHY → ADMIN_SETUP_REQUIRED? → READY
  (الفشل الذريع: RECOVERING → BLOCKED + تقرير AUTO-RECOVERY EXHAUSTED)
```

- كل تشغيل يبدأ ببصمة بيئة واحدة (نظام/معمارية/بايثون/شبكة/ذاكرة)
  وجرد أدوات واحد فقط — لا فحص مكرر أبدًا.
- فحص توافق مسبق قبل أي `pip`/`npm`: عجلات PyPI مقابل
  (المفسر/المنصة/`requires-python`) مع مانعات صريحة لا تخمين.
- التشغيل **idempotent** مع استئناف حقيقي: كل مرحلة محفوظة في
  `.governance/bootstrap-state.json` (مرتبطة بالبصمة) ولا تُتخطى إلا
  بتحقق خفيف ناجح.
- كل إخفاق يُسجَّل في `.governance/recovery-ledger.jsonl` (بصمة سبب +
  استراتيجية + نتيجة) فلا تُعاد محاولة فاشلة بعينها — وتغيير البيئة
  (تثبيت أدوات بناء مثلًا) يفتح باب إعادة المحاولة تلقائيًا.
- لا يُعلَن `READY` إلا بصحة حقيقية: عمليات + منافذ + HTTP + قاعدة
  بيانات + ترحيلات + مصادقة سالبة + صفحة واجهة.

## الأوضاع

| الأمر | الأثر |
|---|---|
| `./apkforge` | الخط الكامل + فتح المتصفح على الإعداد أو التطبيق |
| `./apkforge --check` | تدقيق فقط (بيئة/أدوات/توافق/خطة/إعداد/قاعدة/خدمات) بلا تغيير |
| `./apkforge --plan` | عرض خطة الإقلاع التكيفية (إعادة استخدام/تخطي/إنشاء/تثبيت) بلا تغيير |
| `./apkforge gitcare status` | بوابة صحة المستودع (فهرس/أجسام/مصدر) |
| `./apkforge gitcare diagnose` | تشخيص كامل + تقرير `logs/git-recovery/<run>/report.md` |
| `./apkforge gitcare cleanup [--deep --yes]` | حذف المؤقت والكاش فقط (المصدر و`.git` محميان دائمًا) |
| `./apkforge gitcare repair-index --yes` | إصلاح الفهرس التالف مع حفظ الأجسام والتاريخ |
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
| الترحيلات | `backend/migrations/001–004` + سجل `schema_migrations` |
| الجداول | users وprojects وjobs وartifacts وaudit وsystem_config (مستعادة من الكود — بلا اشتراكات/مدفوعات لأن المشروع لا يملكها) |
| الخلفية | FastAPI (`app.main:app`) على `APKFORGE_PORT` (8000) |
| الواجهة | Vue مبنية (`frontend/dist`) تُقدَّم ستاتيكيًا على `APKFORGE_WEB_PORT` (3000) |
| التشغيل السابق | uvicorn وnpm يدويًا (تحوَّل تلقائيًا) |

## الوحدات التكيفية (`scripts/adaptive/`)

| الوحدة | الدور |
|---|---|
| `env` | بصمة البيئة وكشف Termux وملف القدرات |
| `tools` | جرد الأدوات مرة واحدة (`REQUIRED/OPTIONAL/PHASE_DEPENDENT`) |
| `compat` | مصفوفة التوافق والفحص المسبق قبل التثبيت |
| `recovery` | تصنيف الأسباب (16 صنفًا) وسجل المحاولات والتشخيص |
| `plan` | بناء الخطة وعرضها |
| `checkpoint` | نقاط الحفظ والاستئناف المرتبطة بالبصمة |
| `gitcare` | تشخيص المستودع وإصلاح الفهرس والتنظيف الآمن |

سلّم استرداد `pip` (بالترتيب): أصلي ← إعادة شبكية ← أدوات بناء
← إصدار متوافق بعجلات ← نواة دنيا بلا إضافات أصلية ← إعادة إنشاء
البيئة (صلاحيات) ← تطهير الكاش (قرص) ← `AUTO-RECOVERY EXHAUSTED`
بتشخيص وخطوة تالية. كل تثبيت ناجح يُتحقق (`import` + إقلاع) ثم يُقفل
في `.governance/requirements.lock`.

Termux أصلي: `pkg` أولًا وبلا `sudo`، وفتح المتصفح عبر `termux-open-url` (يتطلب تطبيق Termux:API، وإلا يُطبَع الرابط لفتحه يدويًا)، عجلات `none-any` فقط، سلالم
`clang`/`rust` عند الحاجة، وتحذير صريح عند غياب العجلات لنسخة بايثون.

## ملاحظات أمانة (انحرافات موثقة)

- نقطتا `/setup/status` و`/setup/admin` **إضافة تراكمية** غير كاسرة
  للعقد v1 (الإصدار ثابت 1.0.0؛ بوابات العقود المجمدة ما زالت خضراء).
- `jadx` لا يُجلَب تلقائيًا أبدًا (حجمه ~130MB) — تعليمات يدوية فقط.
- البذور (seed): لا صفوف بذور عمدًا — أول مدير يُنشَأ عبر صفحة الإعداد.
