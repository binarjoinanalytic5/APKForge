# حزم الإضافات

كل أداة = مجلد بحزمة `plugin.yaml` وفق Plugin SDK v1
(`docs/plugin-sdk.md` + `docs/plugin.schema.json`).

- `_example/` الحزمة المرجعية (تُتحقَّق آليًا في CI).
- المرحلة 1: `apktool/` و`jadx/` (أول إضافتين حقيقيتين).
- إضافات GPL/LGPL: مجلد مستقل + لاحقة `-isolated` + استبعاد من الصورة الافتراضية.
