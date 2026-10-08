# أرشيف العمل السابق (مجمد — 2026-10-08)

سجل تاريخي لعمل تحليل ReelShort السابق — **يُمنَع تعديله** (CONTRIBUTING).
نُقِل هنا عند إعادة الهيكلة حول APKForge (§9 من الخطة) دون مساس بالتاريخ
(النقل عبر git يحفظ كل الالتزامات).

## المحتوى

- `reelsec-legacy/*.py` (55 ملفًا): منصة ReelSec التحليلية (ودليلها الأصلي محفوظ في `reelsec-legacy/README.md`) — التوقيع والتحقق والهوية
  والعزل والمصفوفات — مجمدة عند **438/438 اختبارًا** (الدفع `af75923b`).
- `reelsec-legacy/reelshort-native-audit/`: مدقق المكتبات الأصلية (`audit.sh`).
- شيتات التشغيل: `bootstrap-run.sh` و`fetch_frida_gadget.sh` و`update-and-run.sh`.

## الخريطة إلى APKForge

تُغلَّف الوحدات المختبرة كإضافة `reelsec-verify` (المرحلة 2) دون تعديل
منطقها: `sign_verify.py` للتوقيع، `build_verify.py` للفحص،
`artifact_diff.py` للتشريح، `runtime_health.py` للصحة، `isolation.py`
للعزل، `orchestrator.py` للأحكام.

## ما لم يُنقَل (بقي في مكانه عمدًا)

- `analysis/` أدلة الحملات (مراجع الحملات المنشورة تعتمد مساراتها).
- `apktool-src/` و`jadx-src/` و`native-libs/` المادة المفككة.
- `HANDOVER/` و`حقيبة التسليم/` مذكرات التسليم.
- سيرتا `android.yml` و`reelsec-tests.yml` (تعملان على الأرشيف).

## README الجذر الأصلي (محفوظ)

```text
# ReelShort v4.2.00 — Deep APK Analysis

This repository contains the decompiled static-analysis material for ReelShort v4.2.00.

## Original APK
SHA-256:

e67f2a69a108e5fb36f98eb6ca5fdd1030872f43d216b4163fb3e7c999deb278

The original APK is intentionally excluded from Git history.

## Analysis material
- `jadx-src/` — JADX decompilation
- `apktool-src/` — Apktool Smali/resources
- `native-libs/` — extracted native libraries
- `analysis/` — analysis reports and search results

## Focus
Deep investigation of screenshot / screen-recording prevention and related Java/Smali/Native mechanisms.
```
