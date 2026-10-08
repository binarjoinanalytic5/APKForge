# START HERE — ReelSec 3.0

## آخر نقطة توقف موثّقة — ٨ أكتوبر ٢٠٢٦

ابدأ من [تقرير فحص آخر نقطة توقف الوكيل](../../حقيبة%20التسليم/آخر-نقطة-توقف-الوكيل-٢٠٢٦-١٠-٠٨.md). التوقف الحالي هو انهيار النسخة المزودة بأدوات الرصد بعد نجاح البناء والتوقيع والتثبيت، وليس عائق فك التطبيق أو التثبيت القديم. آخر تعديل تنفيذي صحّح إسناد الانهيار وهوية النسخة ونموذج استبدال الحزمة المشتركة؛ ولم يثبت إصلاح الانهيار أو منع التقاط الشاشة.

ما يلي سجل تسليم تاريخي. لا تُنفّذ أوامر الحملات أو إزالة التطبيقات الواردة في الوثائق القديمة تلقائيًا، ولا تتجاوز ضوابط السلامة الحالية.

اقرأ أولاً:

HANDOVER-PACKAGE.md

لا تطلب من المستخدم إعادة شرح التحقيق.

المشكلة الحالية ليست أن المستخدم يحتاج أوامر Apktool أكثر.

المشكلة الهندسية:

ReelSec لا تزال تعتمد على المستخدم كطبقة orchestration.

المطلوب:

تحويل ReelSec إلى منصة تحليل ذاتية.

ابدأ بـ:

1. Audit للبنية الحالية.
2. تحديد backend interfaces.
3. بناء Capability Matrix.
4. بناء Environment Resolver.
5. إضافة Apktool fallback.
6. إضافة Frida/Gadget capability backend.
7. بناء orchestration.
8. إضافة Evidence Ledger.
9. الحفاظ على PROVEN/UNPROVEN بشكل صارم.
10. عدم عمل Big Rewrite.

لا تعدّل original.apk.

لا تدّعِ screenshot blocking.

لا تعتبر instrumented-build proof دليلاً على original runtime.

لا تستخدم git reset/clean بشكل تدميري.

الهدف النهائي:

./tools/reelsec/reelsec.py campaign ./original.apk

ويجب أن تتولى ReelSec نفسها اكتشاف الأدوات واختيار البدائل وبناء الحملة وإنتاج التقرير.

## Latest gate — 2026-10-06 23:06

The first end-to-end phone campaign reached Apktool selection but decode returned `FAILED` because the output directory already existed. The campaign then exposed an unsafe repository-root fallback. That fallback has now been removed for campaign mode.

Current rule:

`campaign APK -> successful isolated decode -> READY inventory -> decoded target -> provenance -> analysis`

A failed decode now ends as `BLOCKED_DECODE_FAILED` and never analyzes the pre-existing `apktool-src` tree as if it came from the supplied APK.

Next phone validation command:

`cd ~/apk-lab/ReelShort-v4.2.00 && git show origin/main:tools/reelsec/bootstrap-run.sh | bash -s -- campaign ./original.apk`
