# START HERE — ReelSec 3.0

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
