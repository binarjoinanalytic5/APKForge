# الحوكمة (GOVERNANCE)

حالة الإقلاع التشغيلية تُكتَب في `.governance/` (مُتجاهَل من Git عمدًا —
حالة محلية متغيرة، لا تُودَع في المستودع):

| المسار التشغيلي | المعنى |
|---|---|
| `.governance/bootstrap-state.json` | آلة الحالة + آخر تشغيل ناجح (للاستئناف) |
| `.governance/PROJECT_STATE.yaml` | البوابة والمرحلة والحالة والمعوقات والخطوة التالية |
| `.governance/CHECKPOINTS/<run>.json` | تقرير كل تشغيل |
| `.governance/AUDIT/<run>.json` | سجل التدقيق (الحالات والتحذيرات) |
| `.governance/failures.jsonl` | سجل الإخفاقات (المحاولة والبديل — لمنع تكرار الفشل) |
| `.governance/*.pid` | الخدمات العاملة (خلفية/واجهة) |
| `.governance/update.lock` | قفل تشغيل التحديث (`run_id` + `pid`) |
| `.governance/update-state.json` | آخر حالة تحديث (`SUCCESS/FAILED/ROLLED_BACK/…`) |
| `.governance/backups.json` + `backups/<id>/` | سجل النسخ (5 أخيرة) ومحتواها المتحقق |
| `.governance/downloads/` | حزم قيد التنزيل (استئناف تلقائي) |
| `.governance/manifest-cache.json` | بيان بعيد مخزّن + `ETag` |

القواعد: كل تشغيل له `RUN_ID`؛ لا أسرار في أي ملف حوكمة؛ الفشل يُسجَّل
مع البديل ولا تُعاد المحاولة الفاشلة بالطريقة نفسها.
