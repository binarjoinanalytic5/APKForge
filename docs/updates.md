# نظام الإصدارات والتحديثات والإشعارات

دليل التشغيل الكامل: الإصدارات ← الفحص ← التنزيل ← التحقق ← النسخ ←
التثبيت ← الترحيل ← إعادة التشغيل ← فحص الصحة ← (التراجع عند الفشل).

## 1. نظرة عامة

```
لوحة الإدارة / API          قاعدة البيانات          المحرك / الواجهة
releases (draft→…→published) → manifest/check → ./apkforge update → UI
```

- مصدر الحقيقة للإصدارات: جدول `releases` (ترحيل `004_updates.sql`).
- نسخة المنصة الحية: ملف `VERSION` في جذر المستودع (حاليًا `1.0.0`).
- المقارنة رقمية دائمًا (`1.10.0 > 1.9.0`)، و`version_code` أحادي
  التزايد (`major*10000 + minor*100 + patch`).

## 2. القنوات

| القناة | ترى |
|---|---|
| `STABLE` | إصدارات `STABLE` فقط |
| `BETA` | `STABLE` + `BETA` |
| `DEV` | الكل |

قناة النظام: `system.channel` (الوضع الافتراضي `STABLE`)، تُدار من لوحة
الإدارة أو `PUT /api/v1/admin/channel`.

## 3. دورة حياة الإصدار

```
draft → validated → published
              ↘           ↘
            (تبقى draft)  unpublished (سحب)
```

- الإنشاء (`POST /api/v1/admin/releases`) ينتج مسودة دائمًا.
- الاعتماد (`…/validate`) يتحقق من التماسك: `bundle` يتطلب
  `download_url + checksum + signature`، و`git` يتطلب `artifact_ref`،
  وإصدار semver صالحًا غير مكرر.
- النشر (`…/publish`) يتطلب `validated`، ويبث إشعارًا تلقائيًا
  (`UPDATE_AVAILABLE` أو `MANDATORY_UPDATE`).
- السحب (`…/unpublish`) يعيد الإصدار إلى `unpublished` (لا حذف فيزيائي).
- السجل: `GET /api/v1/admin/releases/history` (المنشورة فقط، الأحدث أولًا).

كل انتقال مدقق في جدول `audit` (الأفعال `RELEASE_*` و`UPDATE_*`).

## 4. الفحص والحالات

- `POST /api/v1/updates/check` `{current_version, channel?}` →
  `NO_UPDATE` / `UPDATE_AVAILABLE` / `MANDATORY_UPDATE`.
- `GET /api/v1/updates/manifest?channel=` → بيان الإصدار + `ETag`
  (يرد `304` عند عدم التغيّر).
- `GET /api/v1/updates/current` → نسخة هذا العقد وقناته.
- الإلزامي يتحقق عند: `mandatory=true` أو
  `current < minimum_supported_version`.
- الواجهة تفحص تلقائيًا عند الإقلاع وبعد الدخول وكل 30 دقيقة
  (عبر `ETag` لتقليل الحمل)، وتُظهر لافتة عند الإلزامي.
- الترويسة `X-Update-Required: 1` تُرفَق بالردود عند وجود تحديث
  إلزامي معلّق، وخطاف الإقلاع (بعد `MIGRATIONS_READY`) يحذّر بصوت
  عالٍ دون تعطيل التشغيل أبدًا.

## 5. محرك التحديث `./apkforge update`

| الأمر | الوظيفة |
|---|---|
| `./apkforge update --check` | فحص يعرض الحالة والملاحظات |
| `./apkforge update --status` | حالة آخر عملية (`IDLE` إن لم توجد) |
| `./apkforge update` | تنفيذ التحديث الكامل |
| `./apkforge update --rollback [id]` | تراجع لنسخة (الأحدث افتراضيًا) |

خط الأنابيب (أي فشل بعد النسخ ⇒ تراجع تلقائي حقيقي):

1. فحص + رفض عدم وجود إصدار أحدث (لا تخفيض نسخة).
2. الحراس: لا مهام نشطة (`queued/running`) إلا بـ`--force`، ومساحة
   حرة ≥ ضعف الحجم (وبحد أدنى 100MB).
3. تنزيل قابل للاستئناف (`Range` + إعادة محاولة)، `https/http/file`
   فقط.
4. تحقق: الحجم + `sha256` + توقيع `HMAC` بمفتاح
   `APKFORGE_UPDATE_KEY` (غياب المفتاح = رفض، لا تخطٍّ صامت).
5. نسخ احتياطي متحقق (`.env` + `VERSION` + قاعدة البيانات +
   `code.tar.gz` للمستبدَل) مع حد 5 نسخ.
6. وضع صيانة، تثبيت (مع فحص الحزمة: لا `..` ولا مسارات محمية
   ولا `.env/data/.git` داخل الحزمة)، ترحيل، إعادة تشغيل عبر
   خط الإقلاع نفسه، فحص صحة، إطفاء الصيانة.
7. عند الفشل: إيقاف ← استعادة النسخة (كود + قاعدة + إعداد) ←
   إعادة تشغيل ← تحقق من النسخة السابقة.

زر «تثبيت التحديث الآن» في الواجهة يشغّل المحرك نفسه (منفصلًا عبر
`POST /api/v1/admin/updates/apply`) ويعرض تقدمه لحظيًا.

## 6. الإشعارات

الأنواع: `SYSTEM_ANNOUNCEMENT`، `MAINTENANCE`،
`UPDATE_AVAILABLE`، `MANDATORY_UPDATE`، `SECURITY_UPDATE`،
`FEATURE_RELEASE`. الأولويات: `info/important/critical`، وأولوية رقمية
مشتقة من النوع (`MANDATORY/SECURITY=3`، `UPDATE/MAINTENANCE=2`، الباقي 1).
مفاتيح التفضيلات الخمسة: `system_updates`، `security_alerts`،
`feature_updates`، `announcements`، `maintenance`.

- المركز: جرس + عدّاد + قائمة + تعليم مقروء/غير مقروء + حذف
  (إداري) + تفضيلات لكل مستخدم.
- الحرجة (`MANDATORY_UPDATE` أو أولوية `critical`) تتجاوز الكتم
  دائمًا وتصل للجميع.
- النشر التلقائي: نشر إصدار ⇒ بث، اكتمال تحديث ⇒ بث.

## 7. وضع الصيانة

`PUT /api/v1/admin/maintenance` `{active, message}`. عند التفعيل ترد
كل النهايات `503 {code: MAINTENANCE}` عدا الصحة والإعداد والتحديث
نفسها، وتعرض الواجهة شاشة صيانة مع إعادة المحاولة.

## 8. المفاتيح والأسرار

| المتغير | الدور |
|---|---|
| `APKFORGE_UPDATE_KEY` | توقيع/تحقق الحزم (مطلوب للتثبيت) |
| `APKFORGE_KEY` | بديل احتياطي للتوقيع، وأساسي للجلسات |

لا تُطبَع المفاتيح في أي سجل (تنقيح الإقلاع قائم)، ولا تُودَع في Git.

## 9. حالة الحوكمة التشغيلية

| المسار | المعنى |
|---|---|
| `.governance/update.lock` | قفل التشغيل (`run_id` + `pid` حي) |
| `.governance/update-state.json` | آخر حالة (`SUCCESS/FAILED/ROLLED_BACK/…`) |
| `.governance/backups.json` | سجل النسخ (5 أخيرة) |
| `.governance/backups/<id>/` | النسخة (`meta.json` + `state/` + `code.tar.gz`) |
| `.governance/downloads/` | الحزم المنزلة (قابلة للاستئناف) |
| `.governance/manifest-cache.json` | بيان بعيد مخزّن + `ETag` |
| `logs/update/<run>.log` | سجل كل تشغيل |

## 10. استكشاف الأخطاء

| العرض | السبب المحتمل | الحل |
|---|---|---|
| `no published release` | لا إصدار منشور على القناة | انشر إصدارًا أو بدّل القناة |
| `job(s) still active` | مهام تعمل | انتظر انتهاءها أو `--force` |
| `checksum/signature mismatch` | حزمة تالفة أو غير موثوقة | أعد التنزيل، تحقق من المفتاح |
| `cannot verify signature` | لا مفتاح تحديث | اضبط `APKFORGE_UPDATE_KEY` |
| `size mismatch` | انقطاع تنزيل | أعد التشغيل (يستأنف تلقائيًا) |
| `disk too full` | مساحة غير كافية | حرّر مساحة ثم أعد |
| `worktree has local changes` | تعديلات محلية (git) | ادمجها أو `--force` |
| `health FAILED` | الخدمة لم تقلع بالنسخة الجديدة | راجع `logs/update/`؛ التراجع تلقائي |
| `update already running` | تشغيل متزامن | انتظر انتهاءه (القفل يُحرَّر تلقائيًا) |

## 11. خريطة الملفات

- `backend/app/core/updates.py` + `notify.py`: منطق النطاق الخالص.
- `backend/app/services/updates.py` + `notify.py`: الدورة والفحص والبث.
- `backend/app/api/updates.py` + `notifications.py` + `admin.py`: النهايات.
- `backend/migrations/004_updates.sql`: الجداول الأربعة.
- `scripts/update.py`: المحرك (`check/status/run/rollback`).
- `frontend/src/{stores/{updates,notifications},components/NotificationCenter.vue,views/{UpdatesView,AdminUpdatesView}.vue}`.
- العقد: `docs/openapi.yaml` (33 مسارًا).
