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

---

## ADDENDUM — نفس اليوم: تشديد L4 + جولة بيئة Sandbox

### تشديد قاعدة L4 (إلزامي — نُفّذ)
- `BEHAVIOR-CAPTURE.json` صار `behavior-capture-2` بأربع طبقات قابلة للتدقيق:
  `device_observations` (حقيقة الجهاز: foreground dump + screencap rc +
  bytes + **SHA-256**) / `operator_inputs` (تأكيد التشغيل — **موسوم صراحةً
  كافتراض مشغّل وليس ملاحظة جهاز**) / `program_analysis` (تحليل الإطار:
  max_channel/threshold/uniform_dark) / `gate_inference` (الاستدلال + rationale).
- `evidence_report.py` **لا يؤكد L4 إلا بسجل v2 قابل للتدقيق**: بصمة screencap
  + تحليل إطار analyzable + session_bound. المطالبة اليدوية أو علم
  `REELSEC_BEHAVIOR_PLAYBACK_CONFIRMED=1` وحده ⇒ `NOT_PROVEN` (اختبارات
  مضادة للتزوير مضافة).
- الاختبارات: **131/131 PASS** (+3: منع التزوير، العلم وحده ليس دليلًا، فصل الطبقات).

### جولة 2026-10-07 (بيئة Sandbox — ليست دليل جهاز)
`analysis/runtime-round-20261007-sandbox/` — أول تشغيل حقيقي للخط الجديد:
- `lifecycle.reason_code = ADB_UNAVAILABLE` (البيئة بلا adb/frida ولا مسار
  للجهاز) — **سبب محدد وقابل للتفسير** بدل timeout الغامض.
- `execution_attempted=false` — لم يُدّعَ تنفيذ لم يحدث.
- السلسلة: L1 CONFIRMED / L2 INDICATOR / L3 NOT_PROVEN / L4 NOT_PROVEN /
  `SCREENSHOT_BLOCKING = NOT_PROVEN`.
- جولة الجهاز الحقيقية ما زالت مطلوبة على Termux (استثناء الجهاز الفعلي).

---

## ملحق 2026-10-07 (ب): Native Crash Gate — إصلاح جذري بعد ثبوت انهيار الـartifact

### الحالة المثبتة من الجهاز (دفع هذا التكليف)
- `dumpsys activity exit-info` سجل للحزمة الاختبارية: `reason=5 (APP CRASH(NATIVE))`
  مع `status=6`، انهيارات Native متعددة في User 0 وUser 95، وحالتَي
  `reason=4 (APP CRASH(EXCEPTION))` مع `trace=null`.
- العملية تموت بعد تشغيل `MainActivity`. لا stack trace موثوق في logcat.

### ما تغيّر رسميًا في المنصة
1. **Native Crash أصبح blocker رسميًا**: مرحلة `PROCESS_HEALTH_GATE` تسبق Frida.
   إذا انهار الـartifact يفشل التشغيل فورًا بحالة `RUNTIME_ARTIFACT_CRASH` —
   ولا يُنتَج أبدًا `READY → CAPTURED → RUNTIME_PROBE_TIMEOUT` وكأن الـprobe هو
   المشكلة. الفصول اللاحقة (module/probe/target) تُسجَّل SKIP صراحةً.
2. **timeout القديم كان يخفي مشكلة أعمق**: نافذة الـprobe كانت تبتلع موت
   العملية. الآن موت العملية يُشخَّص قبل أي probe عبر ApplicationExitInfo.
3. **ApplicationExitInfo مصدر أساسي**: `dumpsys activity exit-info <pkg>` يُقرأ
   قبل الإطلاق وبعده؛ **الفروق فقط** (delta) تُحتسب، فالانهيارات القديمة من
   جلسات سابقة لا تُشغّل البوابة أبدًا (محصّن ضد انحراف ساعة الجهاز).
4. **artifact health شرط مسبق لإثبات runtime**: `runtime_probe_allowed=false`
   عند أي crash؛ وبوابة Evidence ترفض L3/L4 وتعلن
   `RUNTIME_VALIDITY = BLOCKED_BY_ARTIFACT_CRASH` (السبب NATIVE_CRASH أو
   JAVA_EXCEPTION) حتى لو وُجدت أحداث مطابقة مزروعة.
5. **الفرق بين artifact failure وapplication failure**: مقارنة Baseline آلية —
   توقيع نسخة من original.apk بمفتاح الاختبار (الأصل لا يُمس)، تشغيلها،
   ومقارنتها بالـinstrumented:
   - original يعمل + instrumented ينهار ⇒ `INSTRUMENTATION_REGRESSION_CONFIRMED`
   - الاثنان ينهاران ⇒ `BASELINE_RUNTIME_FAILURE` (**لا يُنسب إلى ReelSec**)
   الجولة محكومة بـ`REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1` و`REELSEC_TEST_PACKAGE`
   وkeystore الاختبار؛ وبدونها تُسجَّل `BASELINE_NOT_RUN` **بسبب محدد**.
6. **تصنيف آلي للانهيار** (timestamp/pid/user/package/stage/source/reason/confidence):
   NATIVE_CRASH, JAVA_EXCEPTION, PROCESS_KILLED, ANR, STARTUP_FAILURE,
   PACKAGE_NOT_PRESENT, PROCESS_NOT_OBSERVED, MODULE_NOT_OBSERVED,
   PROBE_ATTACH_FAILED, TARGET_NOT_EXECUTED, HEALTHY.
7. **تحديد المكتبة المسؤولة دون root**: من logcat backtrace frames
   (`#00 pc ... /lib/arm64/libX.so`)، Abort message، حقل trace في exit-info
   (يُسجَّل مساره دون قراءة)، `/proc/<pid>/maps` أثناء الحياة (best-effort)،
   ومراقبة Frida إن سبقت الانهيار. عند التعذر: `CRASH_CAUSE_UNKNOWN` —
   **لا يُخترع سبب أبدًا**. ملاحظة مدققة: سطر `Fatal signal` يحمل اسم العملية
   مبتورًا إلى 15 حرفًا؛ الربط يقبل الاسم المبتور/الكامل وكل الأسطر تُسجَّل.
8. **Artifact Integrity Gate قبل التثبيت**: توقيع (META-INF + apksigner إن وجد)،
   هوية الحزمة من الـmanifest، وجود `.so` المتوقعة مقابل الأصل، ضغط/محاذاة/ABI،
   `pm path` وversionCode المثبَّت. أي فشل ⇒ `INTEGRITY_FAILED` يمنع runtime.
9. **INSTRUMENTATION-IMPACT.json**: كل تعديل تضيفه ReelSec (smali/manifest/
   إعادة توقيع/repackaging) مرتبط بالـartifact، وقاعدة الإسناد: يُربط الانهيار
   بالـinstrumentation **فقط** إذا كانت مكتبة السبب مطابقة لملف حقنته ReelSec؛
   `CRASH_CAUSE_UNKNOWN` لا يُنسب أبدًا.
10. **مخرجات قابلة للتدقيق**: `RUNTIME-HEALTH.json` (الحقول المطلوبة حرفيًا:
    startup/process_observed/process_alive_ms/exit_reason/exit_status/crash_class/
    crash_source/crash_cause_confidence/instrumentation_regression/
    baseline_comparison/runtime_probe_allowed)، `BASELINE-RUNTIME.json`,
    `ARTIFACT-INTEGRITY.json`, `RUNTIME-VERDICT.json` (ORIGINAL_RUNTIME /
    INSTRUMENTED_RUNTIME / CRASH_CLASS / CRASH_CAUSE / REGRESSION_STATUS /
    RUNTIME_PROOF_STATUS / NEXT_ACTION).
11. **الممنوعات ملتزمة**: لا زيادة timeout كعلاج، لا تجاهل لموت العملية، لا
    اعتبار CAPTURED نجاحًا، لا إعادة تشغيل بلا حدود، لا suppress/bypass،
    original.apk لا يُمس، ولا يُدّعى أن Frida رأى الهدف إذا لم يره.

### مصفوفة الانحدار (10 سيناريوهات — كلها مغطاة باختبارات آلية)
original/instrumented يعملان ⇒ BOTH_START_OK · instrumented native-crash ⇒
REGRESSION_CONFIRMED · exception-crash ⇒ REGRESSION+JAVA_EXCEPTION · original
ينهار ⇒ BASELINE_RUNTIME_FAILURE · عملية لا تبدأ ⇒ PROCESS_NOT_OBSERVED ·
تبدأ ثم تموت ⇒ تصنيف من exit-info · module لا يُحمَّل ⇒ C · attach يفشل ⇒ D ·
target لا يُنفَّذ ⇒ E · target يُنفَّذ ⇒ F. **لا سيناريو يتحول إلى
RUNTIME_PROBE_TIMEOUT مضلل** (اختبار صريح).

### حالة الأدلة العلمية (بلا تغيير)
L1 CONFIRMED / L2 INDICATOR / L3 NOT_PROVEN / L4 NOT_PROVEN /
`SCREENSHOT_BLOCKING = NOT_PROVEN`. الانهيار الحالي يمنع أي إثبات runtime حتى
إصلاح الـartifact أو إثبات أن الأصل نفسه ينهار (BASELINE_RUNTIME_FAILURE).

### ما على الجهاز فعله في الجولة القادمة
`git fetch origin main && git merge --ff-only origin/main` ثم bootstrap كالمعتاد.
النظام سيجيب تلقائيًا: هل original يعمل؟ هل instrumented يعمل؟ نوع الانهيار؟
سببه؟ regression أم baseline؟ هل probe مسموح؟ ولماذا؟ — بدون تحقيق يدوي.

---

## ملحق 2026-10-07 (ج): Autonomous Evidence Platform + Safety-by-Design

### الحادث المؤسِّس لهذا الملحق
جولة الـbaseline نفّذت **uninstall هدمي** لحزمة الاختبار على الجهاز استنادًا إلى
متغير بيئة واحد (`REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1`). سُجِّلت الجولة كـ
**`SAFETY/DESIGN FAILURE — DESTRUCTIVE BASELINE UNINSTALL`** في
`analysis/campaigns/2026-10-07T20-06-46-incident/` — فشل في تصميم منصة ReelSec،
**وليس فشلًا في تطبيق ReelShort**. الحالة العلمية بلا تغيير:
L1 CONFIRMED / L2 INDICATOR / L3 NOT_PROVEN / L4 NOT_PROVEN /
`SCREENSHOT_BLOCKING = NOT_PROVEN`.

### المعمارية الجديدة (داخل الكود، لا في الإعدادات)
1. **`safety_gate.py`**: الهدم مرفوض افتراضيًا **داخل الكود**:
   `UNINSTALL = DENY · CLEAR_DATA = DENY · REMOVE_PACKAGE = DENY ·
   FACTORY_RESET = DENY` (الأخير غير قابل للتنفيذ مطلقًا حتى مع تفويض).
2. **التفويض وثيقة لا متغير بيئة**: `destructive-auth-1` — مطابقة تامة
   (operation/package/user/device) + نافذة زمنية ≤ 15 دقيقة + authorized_by +
   reason + بصمة SHA-256. أعلام البيئة القديمة **مخالفات** تُوقف المنصة.
3. **السلسلة التسعية إلزامية**: بوابة → مطابقة الحزمة → مطابقة المستخدم →
   تحقق هوية الجهاز → Snapshot مسبق → تفويض صريح → العملية → تحقق لاحق →
   سجل تدقيق (`SAFETY-AUDIT.jsonl` — يُسجَّل التنفيذ **والمنع** معًا).
4. **`reelsec doctor`**: يفحص البيئة؛ عند وجود أي علم هدمي شامل:
   `SAFETY: BLOCKED / REASON: destructive uninstall permission enabled /
   No package was modified. / No runtime campaign executed.` — ولا تُنفَّذ
   أي حملة. **الأداة تعرف متى تتوقف.**
5. **`reelsec platform <apk>`**: المنسق المستقل —
   doctor → بوابة السلامة → حملة → Collectors → Evidence Aggregator →
   Git Publisher → تقرير نهائي. المخرجات في
   `analysis/campaigns/<timestamp>/`: ‏`MANIFEST.json` (SHA-256 لكل ملف)،
   `FINAL-VERDICT.json`، ‏`FINAL-REPORT.md`، ‏`SAFETY-GATE.json`، وملفات
   الـCollectors العشرة الموحدة (`collector-1`): DEVICE-SNAPSHOT, PACKAGE,
   PROCESS, CRASH, LOGCAT, ARTIFACT-INTEGRITY, RUNTIME-HEALTH, BASELINE,
   BEHAVIOR, EVIDENCE. الرفع تلقائي بعد كل حملة (ناجحة أو فاشلة) مع
   `PUBLISH_COMMIT` — لا أوامر Termux يدوية ولا grep/sed بين الوكيل والأداة.
6. **كل مسارات الـuninstall القديمة** (baseline + تعارض التوقيع في مرحلة 10)
   تمر الآن عبر `safety_gate.execute_destructive` حصريًا.
7. **الاختبارات**: ‏20 اختبار سلامة تجعل سيناريو الحادث مستحيلًا بنيويًا
   (منصة ترفض، ولا أمر uninstall واحد يصدر) — المجموعة الكاملة 187/187.

### ما تغيّر للمشغّل على Termux
- `reelsec doctor` قبل أي شيء؛ إن ظهر `SAFETY: BLOCKED` فأزل العلم ولا تتجاوزه.
- الحملة المستقلة: `python3 tools/reelsec/reelsec.py platform ./original.apk`
  — تجمع وتحلل وتنشر وتعطي verdict واحدًا ومرجع commit.
- إن تطلبت جولة uninstall فعلًا: وثيقة تفويض `destructive-auth-1` محددة
  بالحزمة والمستخدم والجهاز و15 دقيقة، عبر `REELSEC_DESTRUCTIVE_AUTH`.
