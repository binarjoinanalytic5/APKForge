# ReelShort v4.2.00 — VTable Resolution Report

## الهدف

إثبات القيمة الفعلية للـ function pointer عند:

`0x717f68`

وهو المسار المحسوب من:

`ActiveDecoder object -> vptr/address-point ~= 0x717e60 -> +0x108 -> 0x717f68`

## مواقع dispatch المعروفة

- `0x27af94`
- `0x27b148`
- `0x27b220`

كلها تستخدم:

`[object] -> [vtable] -> +0x108 -> blr x8`

## القاعدة

لا يتم اعتبار الدالة Screenshot blocker إلا بعد:

1. استخراج function pointer الحقيقي.
2. مطابقته مع عنوان/رمز الدالة.
3. فحص جسم الدالة.
4. تتبع Surface/ANativeWindow/protected usage/EGL/secure state.
5. ربط ذلك بسياسة Screenshot/Screen Recording في Android.

## ملفات الدليل

- `CRITICAL-FUNCTION-POINTER.txt`
- `vtable-raw-bytes.txt`
- `vtable-qwords.txt`
- `elf-python-analysis.txt`
- `dispatch-sites.txt`
- `ActiveDecoder-constructor.txt`
- `relevant-symbols.txt`
- `security-strings.txt`

## ملاحظة

لا يتم افتراض أن `0x717f68` دالة معينة حتى يتم استخراج محتواه الخام من الـELF.

