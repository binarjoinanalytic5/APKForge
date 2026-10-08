# عميل CLI (نحيف فوق REST — المرحلة 1)

`apkforge.py` بمكتبة قياسية خالصة (بلا تبعيات) — كل أمر ترجمة 1:1
لاستدعاء REST وفق الخطة §7.2. لا مفاتيح خام في الوسائط (مراجع فقط).

```sh
apkforge register --username admin --password 'كلمة-سر-12+حرف'
apkforge login --token <TOKEN>            # أو: login --username U --password P
apkforge project create --name "MyApp"
apkforge project list
apkforge upload --project-id <prj-…> --file app.apk
apkforge decompile --project-id <prj-…> --tool jadx --wait
apkforge analyze --project-id <prj-…> --wait
apkforge rebuild --project-id <prj-…> --wait
apkforge sign --project-id <prj-…> --keystore-ref <ref> --schemes v1,v2
apkforge job --id <job-…> --follow
apkforge logs --id <job-…>
apkforge download --project-id <prj-…> --output ./result.zip
```

الرمز: `--token` ← `APKFORGE_TOKEN` ← `~/.config/apkforge/config.json`.
الخادم: `--base-url` ← `APKFORGE_URL` ← الإعداد ← `http://127.0.0.1:8000`.
الخروج 0 نجاح، 1 خطأ (تُطبَع `error: …` على stderr).

الاختبارات: `pytest cli -q` (خادم stub داخل العملية، بلا شبكة).
