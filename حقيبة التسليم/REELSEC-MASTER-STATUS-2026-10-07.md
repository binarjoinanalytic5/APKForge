# ReelSec — Master Project Status / الحالة المرجعية للمشروع
## 2026-10-07

**Repository:** `binarjoinanalytic5/ReelShort-v4.2.00-analysis`  
**Branch:** `main`  
**Latest documentation commit checked:** `47b015cdae61f849c37d878dda4b56bed47679fc`  
**Latest known implementation commit recorded by handover:** `71fa8d7215da7666f18de0a8367190894be375b5`  
**Target APK:** `original.apk`  
**Package:** `com.newleaf.app.android.victor`  
**Version:** `4.2.00 / versionCode 4200`  
**Local project:** `~/apk-lab/ReelShort-v4.2.00`

---

## 1. Executive status

المشروع لم يعد في مرحلة "البحث عن أي مؤشر"، بل أصبح في مرحلة **إثبات السلسلة التنفيذية النهائية**.

الحالة الحالية:

| المحور | الحالة |
|---|---|
| تحديد ELF الهدف | PROVEN |
| SHA-256 للـELF في التقرير المرجعي | PROVEN |
| RTTI / mediaCodecDecoder correlation | PROVEN |
| constructor-installed vptr = 0x717e60 | PROVEN |
| vtable slot +0x108 = 0x717f68 | PROVEN |
| static slot value = 0x27a510 | PROVEN |
| حدود ودلالة جسم 0x27a510 | PROVEN كحقيقة محلية للجسم |
| C++ dispatch فعلي إلى 0x27a510 | NOT_PROVEN |
| تنفيذ 0x27a510 وقت التشغيل | NOT_PROVEN |
| ربط المسار بمنع Screenshot/Recording | NOT_PROVEN |
| Capture detector v3 | BUILT + REAL-RUN |
| Evidence platform / causal gate | BUILT + TESTED |
| Runtime evidence | غير مكتمل بسبب بوابة install/Gadget في آخر تشغيل موثق |

**الخلاصة:** لا يوجد حتى هذه اللحظة دليل كافٍ لإعلان أن التطبيق يمنع Screenshot/Screen Recording بسبب المسار الذي ندرسه.

---

## 2. الهدف الأصلي

الهدف هو إثبات سلسلة قابلة لإعادة الإنتاج:

`Trigger → Function → Security State → Surface/Window Protection → Android compositor/security policy → Screenshot/Recording restriction`

ولا تعتبر المؤشرات التالية دليلاً نهائياً منفرداً:
- وجود DRM/Widevine.
- تحميل `libSecShell.so`.
- وجود `0x27a510`.
- وجود `nativeOnCaptureScreen` أو `CaptureScreen`.
- وجود Surface/EGL.
- وجود anti-tamper أو `ptrace`.
- نجاح بناء/توقيع artifact instrumented.
- جاهزية Frida/Gadget.

---

## 3. أقوى النتائج الثابتة الحالية

### 3.1 ELF / vtable

تم تثبيت العلاقة التالية على مستوى الـELF:

`mediaCodecDecoder vtable address-point 0x717e60`
→ `slot +0x108`
→ `0x717f68`
→ `0x27a510`

كما تم إثبات:
- RTTI pointer: `0x71f4d0`
- RTTI name: `N6Cicada17mediaCodecDecoderE`
- constructor path يثبت `0x717e60` كـvptr للـobject.
- destructor/lifecycle correlation رفع العلاقة إلى **PROVEN_RTTI_VTABLE_CONSTRUCTOR_DESTRUCTOR_CORRELATION**.

### 3.2 الوظيفة 0x27a510

تم فصل حدودها بشكل صحيح عند أول ARM64 `ret`:

`0x27a510 … 0x27a540: d65f03c0 ret`

والجسم المستخرج لا يحتوي:
- `bl` / `blr`
- Surface/EGL operation
- secure/buffer/screenshot operation

لذلك **الجسم نفسه ليس دليلاً على Screenshot blocking**. المعنى المحتمل، إن كان هناك معنى أمني، يجب أن يأتي من caller/dispatch context.

### 3.3 JNI +0x108

تم إثبات وجود نمط:

`ldr x8, [x8,#0x108] -> blr x8`

في سياقات JNI/GetMethodID، مع أسماء مثل:
- `setForceInsecureDecoder`
- `queueSecureInputBuffer`
- `setOutputSurface`

تم توثيق أن هذه المواقع **JNI interface-table dispatches** وليست دليلاً على أن C++ vtable slot `+0x108` يصل إلى `0x27a510`.

---

## 4. ما تم تثبيته في بنية الوسائط والأمن

تم توثيق وجود:
- CaptureScreen/Capture execution داخل native media path.
- DRM / Widevine / protected-content pipeline.
- `setForceInsecureDecoder`
- `queueSecureInputBuffer`
- `setOutputSurface`
- `IAFPacket::isProtected()` / `setProtected()`
- Surface / AndroidSurfaceHandle / ANativeWindow / EGL path.
- مؤشرات capture callbacks مثل `nativeOnCaptureScreen`, `gj_NativePlayer_onCaptureScreen`, `onCaptureScreen`.

كما ظهر في ELF dynamic symbols:
- `AMediaDrm_createByUUID`
- `AMediaDrm_getPropertyByteArray`
- `AMediaDrm_getPropertyString`
- `AMediaDrm_release`
- `ptrace`

هذه كلها حقائق عن وجود/استخدام سطح API أو native surface، وليست وحدها دليلاً على سلوك منع التصوير.

---

## 5. ما لم يُثبت

ما يزال غير مثبت:

1. caller C++ حقيقي يحمّل vptr من object ثم يثبت أن القيمة هي `0x717e60`.
2. dispatch فعلي من `[vptr + 0x108]` إلى `0x27a510`.
3. runtime execution للعنوان `0x27a510`.
4. انتقال من هذا المسار إلى:
   - `FLAG_SECURE`
   - `Window.setFlags(...)`
   - `SurfaceControl.setSecure`
   - `EGL_PROTECTED_CONTENT`
   - protected HardwareBuffer/GRALLOC state
   - أو أي آلية Android compositor/security policy equivalent.
5. سلوك capture-block فعلي مربوط بنفس artifact ونفس runtime session.

**الحكم الصحيح الآن:** `SCREENSHOT_BLOCKING = NOT_PROVEN`.

---

## 6. تاريخ تطور ReelSec في الجلسات الأخيرة

### 2026-10-06 — إصلاحات التحليل والبنية

بدأت المشكلة بأن الحملة تستطيع تشغيل مراحلها لكنها كانت:
- تفسر وجود شجرة `apktool-src` سابقة على أنها ناتج APK الجاري تحليله.
- تتعامل مع decode فاشل بطريقة غير آمنة.
- لا تعرض نشاط Apktool الطويل بوضوح.

تم بناء/إصلاح:
- isolated decode provenance.
- heartbeat ومراقبة liveness.
- measured stage progress.
- no-res recovery.
- strict state handling.
- رفض استخدام pre-existing decoded tree عند فشل decode.

### 2026-10-07 — الانتقال من copy-only إلى instrumentation

بعد نجاح `DECODED_NO_RES -> READY` اكتشفنا أن Stage 7 كانت copy-only.

تم بعدها:
- تطبيق telemetry-only Smali probe على نسخة معزولة.
- جعل discovery يعتمد على بنية/محتوى Smali وليس اسم `AW.smali`.
- تصحيح parser من Java spelling إلى Smali form:
  `Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V`.
- دعم Application class المكتشفة من manifest.
- إضافة structural discovery لـSecShell.

### 2026-10-07 02:25 — signing gate

الحملة:
`reelsec-20261007_022538-31232`

النتيجة:
- Stages 01–08: PASS.
- Stage 09 فشل لأن `apksigner` طلب كلمة مرور keystore بشكل تفاعلي داخل subprocess غير تفاعلي.

تم إصلاح ذلك باستخدام password references من البيئة دون كتابة الأسرار في command arguments.

### 2026-10-07 02:41 — ADB endpoint drift

الحملة:
`reelsec-20261007_024159-17548`

النتيجة:
- Stages 01–09: PASS.
- Stage 10 فشل لأن `REELSEC_TEST_DEVICE` كان يشير إلى endpoint قديم:
  `192.168.8.8:39927`
بينما الجهاز الحالي كان:
  `192.168.8.8:32897`.

تم بناء resolution policy:
- exact online match.
- auto-rebind عند وجود جهاز online واحد فقط.
- رفض الاختيار الضمني إذا كان هناك صفر أو أكثر من جهاز واحد.

### 2026-10-07 02:47 — package signature mismatch

الحملة:
`reelsec-20261007_024703-21217`

النتيجة:
- Stage 10 نجح في اختيار endpoint الصحيح.
- artifact كان `SIGNED_VERIFIED`.
- Android رفض التثبيت لأن package نفسه مثبت بشهادة مختلفة:
  `INSTALL_FAILED_UPDATE_INCOMPATIBLE`.

تمت إضافة uninstall/reinstall guarded path، ولا يعمل إلا مع:
`REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1`
ومع package test محدد صراحة.

### 2026-10-07 03:15 — Gadget native-library packaging

الحملة:
`reelsec-20261007_031559-12375`

فشل Stage 10:
`INSTALL_FAILED_INVALID_APK: Failed to extract native libraries, res=-2`

الاستنتاج الصحيح:
- الفشل حدث قبل runtime observation.
- لذلك timeout لاحق في runtime لا يُفسر كدليل ضد target.
- السبب كان packaging/alignment بعد إضافة Frida Gadget إلى artifact المعزول.

تمت إضافة:
`zipalign -P 16 -f -v 4`
قبل signing، ثم:
`zipalign -c -P 16 -v 4`
للتحقق.

**آخر بوابة تنفيذية موثقة من هذا المسار:** إعادة تشغيل Gadget campaign والتحقق أولاً من وصول Stage 10 إلى `INSTALLED`.

---

## 7. Capture Detector v3

تم بناء `tools/reelsec/capture_detector.py` schema `capture-detection-3`.

القدرات:
- direct APK/ZIP in-memory scan.
- entry inventory.
- native string scan.
- packed DEX detection.
- binary AndroidManifest string-pool parsing ASCII/UTF-16LE.
- ELF `.dynsym` parsing مع import/export distinction.
- noise classification للـthird-party SDK.
- anti-tamper family tags.
- retained v2 heuristics: FLAG_SECURE bounded pattern, packer/hardening families, hidden DEX detection, DRM/protected-content strings.

الحد:
**Read-only.** لا patch ولا inject ولا disable ولا sign ولا rebuild للـoriginal APK.

---

## 8. Evidence Platform

تم بناء `tools/reelsec/evidence_report.py` schema `evidence-report-1`.

التصنيف:
- CONFIRMED
- INDICATOR
- NOT_PROVEN
- UNRELATED

والـcausal gate النهائي لمنع Screenshot/Recording يتطلب أربعة روابط:

- L1: mechanism identified statically.
- L2: exact artifact provenance / hash binding.
- L3: runtime execution observed.
- L4: capture-block behavior observed.

الـverdict يصبح CONFIRMED فقط عند اكتمال الروابط الأربعة.

---

## 9. آخر real-run موثق لمنصة الأدلة

Artifacts:
`analysis/evidence-platform-20261007/`

Verdict:
`PACKED_STATIC_ANALYSIS_LIMITED`

Causal chain:
`NOT_PROVEN`

وفق التوثيق:
- L1 = CONFIRMED
- L2 = NOT_PROVEN
- L3 = NOT_PROVEN
- L4 = NOT_PROVEN

ومن real-run تم تأكيد مؤشرات مهمة، منها:
- SecShell presence.
- native capture callback strings.
- DRM imports.
- `ptrace` import.
- third-party noise classified separately.

---

## 10. أدوات ReelSec التي أصبحت موجودة

المنصة الحالية تحتوي على مسارات مثل:

`tools/reelsec/reelsec.py`  
`tools/reelsec/bootstrap-run.sh`  
`tools/reelsec/update-and-run.sh`  
`tools/reelsec/capture_detector.py`  
`tools/reelsec/evidence_report.py`  
`tools/reelsec/adb_deploy.py`  
`tools/reelsec/sign_verify.py`  
`tools/reelsec/optional_adapters.py`

كما تمت إضافة/دمج optional adapters لبيئات مثل JADX / radare2 / MobSF/Mobsfscan / objection بحسب توفرها، وتبقى نتائجها evidence-only.

---

## 11. اختبار وجودة الأداة

آخر توثيق لمنصة الأدلة يذكر:

`94/94 OK`

باستخدام:

`python -m unittest discover -s tools/reelsec`

والاختبارات تغطي:
- capture detector v3.
- evidence report causal gate.
- read-only boundaries.
- optional adapter contracts.
- instrumentation/campaign regressions.
- ADB deploy behavior.
- signing automation.

---

## 12. نقطة التوقف الحالية — IMPORTANT

هناك فرق بين:

**آخر كود موثق على main**
و
**آخر تشغيل فعلي موثق على الهاتف**.

آخر تشغيل فعلي موثق قبل حزمة الأدلة الحديثة هو حملة:
`reelsec-20261007_031559-12375`

وقد توقفت عند **Stage 10 / install** بسبب:
`INSTALL_FAILED_INVALID_APK`

ثم تم تسجيل إصلاح zipalign/Gadget.

بعد ذلك أضيفت منصة Capture Detector v3 وEvidence Report وحقائب التوثيق الحديثة، لكن **لم يتم في المواد التي راجعناها توثيق حملة هاتف لاحقة تثبت أن Stage 10 أصبح INSTALLED ثم Stage 12 CAPTURED**.

لذلك لا ينبغي افتراض أن runtime proof أصبح ناجحاً لمجرد أن الكود صار جاهزاً.

---

## 13. الأمر المرجعي للخطوة التالية

من جهاز الاختبار:

```bash
cd ~/apk-lab/ReelShort-v4.2.00

git fetch origin main

git show origin/main:tools/reelsec/bootstrap-run.sh | bash -s -- campaign ./original.apk
```

مع إبقاء متغيرات signing التي تم إعدادها سابقاً.

وفي مسار Gadget/الاختبار يجب أن تكون صلاحية uninstall صريحة عند الحاجة:

```bash
export REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1
```

ولا يتم تغيير `original.apk`.

---

## 14. ما الذي يجب فحصه مباشرة بعد التشغيل

الأولوية ليست "هل اكتمل الـcampaign؟" فقط، بل:

1. هل Stage 10 = `INSTALLED` فعلاً؟
2. هل `ADB-DEPLOY.json` يثبت device resolution والـinstall mode؟
3. هل Stage 12 = `CAPTURED`؟
4. هل يوجد `RUNTIME-PROBE.json` مع observations فعلية؟
5. هل `AUTONOMOUS-DATAFLOW` يثبت vptr provenance إلى `0x717e60`؟
6. هل يوجد dispatch C++ مثبت إلى `0x27a510`؟
7. هل توجد `BEHAVIOR-CAPTURE.json` مرتبطة بنفس artifact/session؟
8. فقط عند اكتمال L1–L4 يسمح النظام برفع verdict إلى CONFIRMED.

---

## 15. ترتيب القراءة للوكيل/الجلسة الجديدة

اقرأ بهذا الترتيب:

1. `حقيبة التسليم/REELSEC-SESSION-HANDOVER-2026-10-07.md`
2. `حقيبة التسليم/REELSEC-EVIDENCE-PLATFORM-2026-10-07.md`
3. هذا الملف.
4. `HANDOVER/ReelSec-3.0/PHASE-STATUS.md`
5. `HANDOVER/ReelSec-3.0/START-HERE.md`
6. `حقيبة التسليم/REELSEC-PROOF-MATRIX-2026-10-06.md`

لا تبدأ التحقيق من الصفر.

---

## 16. المخاطر/الحدود التي يجب عدم كسرها

- لا تعدّل `original.apk`.
- لا تستخدم `git reset --hard`, `git clean -fd`, أو أي destructive sync.
- لا تعتمد على nearest symbol لإعطاء هوية `0x27a510`.
- لا تخلط JNI index `0x108` مع C++ vtable slot `+0x108`.
- لا تعتبر instrumented artifact دليلاً على original runtime.
- لا تعلن Screenshot/Recording protection بدون L1–L4.
- لا تعتبر DRM وحده آلية منع التصوير.
- أي uninstall على test device يجب أن يكون explicit/guarded ومقيداً بالـconfigured test package.

---

## 17. تعريف النجاح النهائي

النجاح له شكلان مقبولان:

### A) إثبات

`Trigger → caller → vptr/object → slot → target → security state → protected surface/compositor → observed capture restriction`

مع provenance/runtime/behavior evidence كافية.

### B) تفنيد/UNRESOLVED

إذا لم تُستكمل السلسلة:
- يتم إبقاء `SCREENSHOT_BLOCKING=NOT_PROVEN`
- وتحديد نقطة انقطاع الدليل بدقة.
- وإذا ظهر مسار بديل أقوى، يُبنى عليه proof matrix جديدة.

**الحالة المرجعية في 2026-10-07: UNRESOLVED / NOT_PROVEN، مع بنية أدوات وأدلة متقدمة وجاهزة لمواصلة بوابة runtime.**
