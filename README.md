# APKForge — منصة متكاملة لهندسة وتوقيع APK

منصة مفتوحة المصدر (Apache-2.0) لفك وتحليل وتعديل وبناء وتوقيع ملفات APK:
تدمج أفضل الأدوات المجرّبة (Apktool وJADX وAndroguard وQuark وغيرها) خلف
واجهات موحدة — ويب وREST وWebSocket وCLI — بدل إعادة اختراعها.

> القاعدة الحاكمة: **لا بناء من الصفر.** أي قدرة لها بديل ناضج تُدمَج،
> وما يُكتَب هنا طبقة رقيقة (موصلات وعقود وواجهات). الوثيقة الحاكمة:
> [`docs/plan.md`](docs/plan.md).

## التشغيل بأمر واحد

```sh
./apkforge
```

يجهّز البيئة والأدوات والإعداد وقاعدة البيانات والترحيلات والبناء، ثم
يشغّل الخلفية والواجهة ويفحص الصحة ويدخن الاختبار ويفتح المتصفح على
صفحة إعداد المدير الأول. قابل لإعادة التشغيل بأمان (idempotent)،
والتفاصيل في [`docs/BOOTSTRAP.md`](docs/BOOTSTRAP.md).

## الحالة: المرحلة 1 (منصة عاملة محليًا)

- مصادقة JWT + أدوار RBAC + سجل تدقيق؛ مشاريع ومهام عبر REST المجمد v1.
- إضافتا `apktool/` و`jadx/` (Plugin SDK v1: عملية فرعية + JSON).
- واجهة Vue عربية RTL + بث WebSocket حي + CLI بمكتبة قياسية.
- الخلفيات محلية أولًا (SQLite/قرص/تنفيذ مضمن) خلف واجهات تُستبدَل في
  المرحلة 2 (PostgreSQL/S3/Celery) — انظر `docs/adr/ADR-004-*.md`.

## التشغيل السريع (محلي)

```sh
# 1) الخلفية
pip install -r backend/requirements.txt
export APKFORGE_KEY="$(python3 -c 'import secrets;print(secrets.token_hex(24))')"
uvicorn app.main:app --app-dir backend --host 127.0.0.1 --port 8000

# 2) الواجهة (نافذة ثانية)
cd frontend && npm ci && npm run dev   # http://localhost:5173

# 3) CLI (نافذة ثالثة)
python3 cli/apkforge.py register --username admin --password 'كلمة-سر-12+حرف'
python3 cli/apkforge.py project create --name MyApp
python3 cli/apkforge.py upload --project-id <prj-…> --file app.apk
python3 cli/apkforge.py decompile --project-id <prj-…> --tool apktool --wait
python3 cli/apkforge.py download --project-id <prj-…> --output result.zip
```

الأدوات الخارجية: ضع `apktool` و`jadx` على `PATH` (أو
`APKFORGE_APKTOOL`/`APKFORGE_JADX`) — غيابهما يفشل المهمة بسبب صريح.

## البنية

انظر [`ARCHITECTURE.md`](ARCHITECTURE.md) وقرارات [`docs/adr/`](docs/adr/).

## المساهمة والأمان

- المساهمة: [`CONTRIBUTING.md`](CONTRIBUTING.md) (البوابات إلزامية: اختبارات خضراء + فحص أسرار + مراجعة عقد).
- الأمان: [`SECURITY.md`](SECURITY.md) — الاستخدام المصرح به فقط، وبلا أدوات تجاوز DRM.

## English summary

APKForge is an Apache-2.0, self-hostable workbench for APK engineering:
decompile, analyze, modify, rebuild, align, and sign — by integrating proven
open-source tools behind unified APIs (REST/WebSocket/CLI) instead of
rebuilding them. Stage: Phase 1 (locally runnable: JWT auth, RBAC, projects,
jobs, Apktool/JADX plugins, RTL Arabic web UI, CLI). See
[`docs/plan.md`](docs/plan.md) (Arabic, normative).
