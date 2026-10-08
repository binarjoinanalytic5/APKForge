# عميل CLI (نحيف فوق REST — المرحلة 1)

المواصفة (من الخطة §7.2) — التنفيذ في المرحلة 1:

```sh
apkforge login --token <TOKEN>
apkforge project create --name "MyApp"
apkforge decompile --project-id 123 --tool jadx
apkforge analyze --project-id 123 --scan owasp
apkforge rebuild --project-id 123 --sign --keystore <ref>
apkforge download --project-id 123 --output ./output.apk
```

القواعد: لا منطق هنا — كل أمر ترجمة 1:1 لاستدعاء REST؛ لا مفاتيح خام
في الوسائط (مراجع فقط)؛ كل عملية تسجل الأثر نفسه.
