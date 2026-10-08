# النواة (FastAPI نمطي — المرحلة 1)

## البنية

- `app/core/` منطق خالص بمكتبة قياسية: `security.py` (PBKDF2 + JWT)،
  `rbac.py` (مصفوفة الأدوار)، `store.py` (SQLite خلف واجهة)،
  `wsframes.py` (إطارات WebSocket حسب العقد).
- `app/services/` الخدمات: مصادقة ومشاريع ومهام (بلا إطار عمل).
- `app/api/` محولات FastAPI نحيفة تطابق `docs/openapi.yaml` حرفيًا.
- `app/storage.py` تخزين الملفات المُعنوَن بالمحتوى (محلي/S3 لاحقًا).

## التشغيل المحلي

```sh
pip install -r requirements.txt
export APKFORGE_KEY="$(python3 -c 'import secrets;print(secrets.token_hex(24))')"
uvicorn app.main:app --app-dir backend --host 127.0.0.1 --port 8000
```

المتغيرات: `APKFORGE_KEY` (≥32 حرفًا، إلزامي) و`APKFORGE_DB`
و`APKFORGE_BLOBS` و`APKFORGE_WORK` و`APKFORGE_PLUGINS` و`APKFORGE_CORS`.

## الاختبارات

```sh
pip install -r requirements-test.txt
pytest backend workers cli -q
```

## ملاحظة التثبيت

`requirements.txt` حدود دنيا؛ ملفات القفل (`pip-compile`) إلزامية قبل
أي نشر إنتاجي (المنع 9). خلفيات المرحلة 2 في
`requirements-phase2.txt` (غير مثبتة الآن).
