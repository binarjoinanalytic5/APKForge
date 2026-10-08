# حزم الإضافات

كل أداة = مجلد بحزمة `plugin.yaml` وفق Plugin SDK v1
(`docs/plugin-sdk.md` + `docs/plugin.schema.json`).

- `_example/` الحزمة المرجعية (تُتحقَّق آليًا في CI).
- `apktool/` فك (`d`) وإعادة بناء (`b`) — Apktool 3.0.2.
- `jadx/` فك إلى Java — JADX 1.5.6.
- إضافات GPL/LGPL: مجلد مستقل + لاحقة `-isolated` + استبعاد من الصورة الافتراضية.

## البروتوكول

`run.py` يقرأ كائن JSON واحدًا على stdin
(`kind`/`input_path`/`out_dir`/`options`/`_limits`)، يُشغِّل الأداة
كعملية فرعية (بلا shell أبدًا)، ويكتب كائن JSON واحدًا على stdout
والسجلات على stderr. الخروج 0 = نجاح، غيره = فشل صريح.

## اكتشاف الأدوات

`APKFORGE_APKTOOL` (jar أو ثنائي) ثم `PATH`، و`APKFORGE_JADX` ثم
`PATH` — الغياب يُفشِل المهمة برسالة صريحة بدل كسر العقد.
