# ReelSec — Runtime Diagnostics Handover
## Session — 2026-10-07 (runtime lifecycle evidence platform)

**Repository:** binarjoinanalytic5/ReelShort-v4.2.00-analysis
**Branch:** main
**Baseline:** 09da2bd — Tests before: 94/94 OK

---

## CURRENT-RUNTIME-STATUS

### ماذا كان الخطأ (root cause — مؤكد من الكود، لا تخمين)

1. **`Process.attachModuleObserver` ليست API موجودة في Frida.** السكربت
   القديم (`reelsec-runtime-probe.js`) كان يستدعيها عندما تكون المكتبة غير
   محمّلة لحظة الـ attach. النتيجة: `TypeError` صامت يقتل السكربت قبل إرسال
   أي حدث — ولهذا كانت `events=[]` في الحملات الأربع الأخيرة، ثم يقتل
   timeout الـ CLI بعد 18s فيظهر `frida_exit=124`.
2. **`execution_attempted=true` كان يُضبط بمجرد نجاح `adb devices`** — قبل
   أي إطلاق أو attach. لا يعني أن التطبيق أو العملية أو المكتبة ظهرت.
3. **لا فحص لوجود العملية** (لا `ps` polling)، ولا فحص `pm path` لوجود
   الحزمة، ولا استخدام لـ `-s serial` في أوامر gadget (forward/monkey) —
   اعتماد ضمني على جهاز وحيد.
4. النتيجة: كل الفشلَات (A–G) انهارت إلى حالة واحدة غامضة
   `RUNTIME_PROBE_TIMEOUT_NO_TARGET_OBSERVED`.

### لماذا كان التشخيص السابق غير كافٍ
لم يميّز بين: تطبيق لم يبدأ / عملية غائبة / مكتبة لم تُحمّل / attach فشل /
الهدف لم يُنفَّذ. لا timestamp، لا pid، لا source لكل حالة.

### ماذا تم إصلاحه
- `runtime_probe.py` (جديد): lifecycle مرحلي + reason codes A–G + probe JS
  معاد كتابته بـ APIs موثقة فقط (polling ‏`findModuleByName` كل 250ms +
  أحداث لكل انتقال).
- `write_runtime_probe` في `reelsec.py`: تدفق مرحلي كامل —
  ADB resolution بسياسة آمنة (لا endpoint تاريخي) → `pm path` →
  launch → ‏`ps -A` polling (12 محاولة) → Frida → اشتقاق المراحل من
  الأحداث. كل مرحلة: status/timestamp/reason_code/source/elapsed/pid.
- `adb_deploy.py`: ‏`diagnose_install_failure` (reason codes للتثبيت)،
  ‏`artifact_preflight_checks` (محاذاة/ضغط/ABI قبل التثبيت)،
  ‏`verify_installed_package` (pm path + versionCode بعد التثبيت).
- `behavior_capture.py` (جديد): **producer L4** — لم يكن موجودًا (كان عقدًا
  في `evidence_report.py` فقط). مراقب محكوم opt-in:
  ‏`REELSEC_BEHAVIOR_CAPTURE=1`، لقطة screencap واحدة على مستوى المستخدم،
  تحليل PNG للإطار الأسود، و`secure_content_protected=true` فقط مع تأكيد
  تشغيل صريح (`REELSEC_BEHAVIOR_PLAYBACK_CONFIRMED=1`). لا hooks، لا تعديل
  حماية، لا محاولة تجاوز.

### ما الذي ثبت
- الأخطاء البرمجية أعلاه (من قراءة الكود + اختبارات الانحدار).
- الاختبارات 128/128 OK ( كانت 94/94).
- سلوك الاشتقاق: كل سبب A–G مُختبَر بمصفوفة أحداث اصطناعية.

### ما الذي لم يثبت
- **لم تُنفَّذ حملة runtime على الجهاز الحقيقي بعد** — البيئة الحالية
  (sandbox الوكيل) لا تصل إليها ADB. التشخيص الجديد سيُنتج الأدلة تلقائيًا
  عند أول حملة على الهاتف.
- SCREENSHOT_BLOCKING ما زال **NOT_PROVEN** (لم تتغير الأدلة).

### نقطة الاستئناف التالية
على الهاتف (Termux):
```bash
cd ~/apk-lab/ReelShort-v4.2.00
git fetch origin main && git merge --ff-only origin/main
# حملة واحدة فقط — الأداة الآن تجمع lifecycle كامل تلقائيًا:
export REELSEC_USE_GADGET=1
export REELSEC_FRIDA_GADGET="$HOME/apk-lab/reelsec-gadget/frida-gadget-17.2.14-android-arm64.so"
export REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1
export REELSEC_BEHAVIOR_CAPTURE=1          # اختياري: ينتج BEHAVIOR-CAPTURE.json
git show origin/main:tools/reelsec/bootstrap-run.sh | bash -s -- campaign ./original.apk
```
ثم اقرأ `RUNTIME-PROBE.json → lifecycle.reason_code` — سيحدد بدقة أي طبقة
فشلت بدل Timeout الغامض.

---

## RUNTIME-DIAGNOSTICS

### المراحل (كل مرحلة: status/timestamp/reason_code/source/elapsed)
```
ADB_CONNECTED → PACKAGE_RESOLVED → PACKAGE_PRESENT → APP_LAUNCH_ATTEMPTED
→ PROCESS_OBSERVED → TARGET_PROCESS_CONFIRMED → PROBE_ATTACHED
→ MODULE_WAIT_STARTED → MODULE_OBSERVED → TARGET_RESOLUTION → TARGET_OBSERVED
```

### Reason codes
| Code | المعنى | الطبقة |
|---|---|---|
| `ADB_UNAVAILABLE` / `ADB_NO_ONLINE_DEVICE` | لا adb أو لا جهاز online | ADB |
| `PACKAGE_NAME_UNRESOLVED` | اسم الحزمة لم يُستخرج | PACKAGE |
| `PACKAGE_NOT_INSTALLED` | ‏`pm path` لم يجد الحزمة | PACKAGE |
| `APP_NOT_STARTED` (A) | الإطلاق فشل | LAUNCH |
| `TARGET_PROCESS_NOT_OBSERVED` (B) | العملية لم تظهر في `ps -A` بعد 12 محاولة | PROCESS |
| `TARGET_MODULE_NOT_OBSERVED` (C) | attach نجح لكن `libsaasCorePlayer.so` لم تُحمّل | MODULE |
| `PROBE_ATTACH_FAILED` (D) | Frida لم يثبت (لا حدث PROBE_ATTACHED) | PROBE |
| `TARGET_NOT_EXECUTED_BEFORE_TIMEOUT` (E) | hook مُثبّت والهدف لم يُنفَّذ قبل نهاية النافذة | TARGET |
| `TARGET_OBSERVED` (F) | TARGET_FUNCTION_ENTER مع vptr+slot كاملين | TARGET |
| `PROBE_TIMEOUT_AFTER_VALID_ATTACH` (G) | timeout بعد attach+module صالحين دون اكتمال النافذة | PROBE/TARGET |

قاعدة الأسبقية: أعمق طبقة فاشلة تفوز؛ كود Frida لا يحجب فشلًا أسبق
(launch/package/adb) — مُختبَر.

### ADB endpoint
لا endpoint تاريخي: `resolve_test_device` يكتشف الأجهزة الحالية، EXPLICIT_MATCH
أو AUTO_REBOUND_SINGLE_ONLINE_DEVICE (جهاز وحيد فقط)، ويرفض الاختيار الضمني
مع صفر/عدة أجهزة. الـ endpoint المستخدم + model يُسجَّلان في
`RUNTIME-PROBE.json` و`ADB-DEPLOY.json`.

### Install diagnostics
قبل التثبيت: فحص ضغط `.so` (STORED) + محاذاة `zipalign -c -P 16` + توافق ABI
مع `ro.product.cpu.abilist`. عند الفشل: reason code
(`NATIVE_LIB_EXTRACTION_FAILED`, ‏`SIGNATURE_MISMATCH`, …) + hint. بعد النجاح:
‏`pm path` + versionCode. الـ artifact موسوم `INSTRUMENTED_TEST_ARTIFACT`.
‏`original.apk` لا يُمس. الـ uninstall يبقى محكومًا بـ
‏`REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1` دون أي توسيع.

### L3 ≠ L4
‏`TARGET_OBSERVED` يثبت طبقة runtime فقط (L3). سلوك منع التصوير (L4) يتطلب
‏`BEHAVIOR-CAPTURE.json` مستقل. `evidence_report.py` لم يُخفَّف: أي حلقة
ناقصة ⇒ `SCREENSHOT_BLOCKING = NOT_PROVEN`.

---

## TEST-RESULTS

```
Tests:
PASS 128
FAIL 0
```
(قبل الجلسة: 94/94 — أُضيفت 34 اختبارًا)

الاختبارات الجديدة:
- `test_runtime_probe.py` (+15): الأسباب A–G، أولوية الطبقات، predicate
  جزئي ≠ هدف، JS بلا APIs وهمية، parse لغلاف frida send، observe_process
  وcheck_package_present بـ fake runner، وفحص end-to-end حقيقي لـ
  `write_runtime_probe` (مسار RUNTIME_ENVIRONMENT_UNAVAILABLE مع stages).
- `test_adb_deploy.py` (+7): تصنيف فشل التثبيت (native libs/signature/
  unknown)، preflight ضغط المكتبات + ABI، تحقق ما بعد التثبيت (ناجح/غائب).
- `test_behavior_capture.py` (+9): محلل PNG (أسود/مضيء/filtered/تالف)،
  دلالات L4 الصارمة (تأكيد التشغيل، foreground، فشل اللقطة).
- `test_evidence_report.py` (+3): سيناريو 13 (lifecycle بلا هدف ⇒ L3
  NOT_PROVEN)، 14 (behavior ناقص ⇒ L4 NOT_PROVEN)، 15 (أدلة جزئية بلا
  provenance ⇒ مرفوضة).

---

## EVIDENCE-STATUS

```
L1 = CONFIRMED (سطح static محدد: nativeOnCaptureScreen + AMediaDrm_* imports + SecShell packer)
L2 = NOT_PROVEN (لا ربط hash بدون original.apk / حملة على الجهاز)
L3 = NOT_PROVEN (آخر 4 حملات: runtime_matches=0; التشخيص الجديد سيحدد الطبقة F/G/E/D/C/B/A بدقة)
L4 = NOT_PROVEN (لا BEHAVIOR-CAPTURE.json؛ الـ producer صار موجودًا ومحكومًا لكنه لم يُنفَّذ)

SCREENSHOT_BLOCKING = NOT_PROVEN
```

لم يتغير الحكم. لا مؤشرات رُفعت إلى CONFIRMED. بوابة السببية
(`ALL_LINKS_MUST_BE_CONFIRMED`) كما هي.
