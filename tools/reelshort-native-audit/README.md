# ReelShort Native Audit Tool

أداة تدقيق محلية موجهة لتحليل ELF/ARM64 وإثبات مسار vtable التنفيذي.

## التشغيل

بعد سحب التحديثات:

```bash
git pull --ff-only origin main
chmod +x tools/reelshort-native-audit/audit.sh
bash tools/reelshort-native-audit/audit.sh
```

الأداة لا تعدّل APK. تبحث عن مكتبة Cicada/decoder، تحفظ hash وELF metadata والرموز والنصوص الأمنية، ثم تحسب file offset للعنوان الافتراضي 0x717f68 وتقرأ الـ8 bytes الخام مباشرة من ELF.

تُحفظ التقارير في:

analysis/sec-shell-deep-v1/vtable-resolution-<timestamp>/

أهم ملف:
CRITICAL-FUNCTION-POINTER.txt

الأداة تسجل الإخفاقات ولا تستخدم set -e، وتحاول دفع التقرير إلى Git بعد إنشائه.

لا يُعتبر pointer أو callee دليلاً على منع Screenshot إلا بعد تتبع التنفيذ الفعلي إلى Surface/protected buffer/compositor أو آلية Android الأمنية ذات الصلة.
