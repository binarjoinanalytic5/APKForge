# استكشاف الأعطال (TROUBLESHOOTING)

القاعدة: كل فشل يطبع `FAILED STEP` و`ERROR` و`DIAGNOSTIC` و`NEXT ACTION`
— ابدأ من `logs/errors/<run>.log` ثم أعد `./apkforge` (يستأنف بأمان).

| العرض | السبب الغالب | الإصلاح |
|---|---|---|
| `python3 >=3.10 is required` | لا بايثون | ثبّته من python.org (الشرط المسبق الوحيد) ثم أعد |
| `NETWORK REQUIRED` | بلا إنترنت وأداة ناقصة | وفّر الشبكة، أو ثبّت الأداة المسماة يدويًا ثم أعد |
| `npm ci failed` | شبكة/كاش | أعد (يجرّب `--offline` تلقائيًا) أو `npm cache clean` |
| `frontend build failed` | تبعيات/أنواع | راجع `logs/build-*.log`؛ أعد بعد الإصلاح |
| `backend died on boot` | مفتاح/منفذ/إعداد | راجع `logs/server/backend.log`؛ تحقق من `.env` |
| `port busy` متكرر | خدمة أجنبية | المحرك ينتقل حتميًا ويحفظ في `.env` — أو حرّر المنفذ |
| `migrations still pending` | ترحيل معطوب | لا تعدّل `schema_migrations` يدويًا؛ راجع سجل الترحيلات وأصلح ملف SQL ثم أعد |
| `SYSTEM_INITIALIZED` | إعداد مكرر | طبيعي: المدير موجود — سجّل الدخول بدل الإعداد |
| المتصفح لم يفتح | بيئة headless | انسخ الرابط المطبوع (المحرك لا يعتبر ذلك فشلًا) |
| `REFUSED: APKFORGE_ENV=prod` | حماية الإنتاج | مقصود — `--reset-dev` للتطوير فقط |

## مبادئ ممنوعة

- لا تحذف `data/` يدويًا بدل `--reset-dev` (يفقدك النسخة الاحتياطية).
- لا تطبع `APKFORGE_KEY` ولا تلصقه في تذاكر (السجلات تُنقّيه تلقائيًا).
- لا تعتبر وجود عملية دليل صحة — `HEALTHY` تعني 11 فحصًا أخضر.
