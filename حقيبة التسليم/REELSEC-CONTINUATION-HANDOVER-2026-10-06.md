# REELSEC — حقيبة التسليم والاستئناف

**تاريخ:** 2026-10-06  
**المستودع:** binarjoinanalytic5/ReelShort-v4.2.00-analysis  
**المشروع المحلي:** ~/apk-lab/ReelShort-v4.2.00

## 1. الهدف
إثبات الآلية التنفيذية الحقيقية التي تمنع Android Screenshot / Screen Recording في ReelShort v4.2.00، عبر سلسلة قابلة لإعادة الإنتاج:

Trigger → Function → Security State → Surface/Window Protection → Android compositor/security policy → Screenshot/Recording restriction.

إذا لم تثبت السلسلة، يجب تفنيد الفرضية وتحديد المسار البديل. لا يُعتبر DRM وحده دليلاً على منع التصوير.

## 2. معيار الأدلة
- **مُثبت:** symbol/function boundary/disassembly/call site/data flow/JNI registration/native API/Java bytecode يثبت العلاقة مباشرة.
- **مرجح:** عدة مؤشرات متوافقة بدون execution link كامل.
- **غير مثبت:** فرضية بلا مسار تنفيذي.
- **منفي بالأدلة الحالية:** لم يظهر الدليل في المادة المفحوصة؛ ليس نفياً مطلقاً للـAPK.

لا تعتمد على String XREF وحده، أو CaptureScreen وحده، أو DRM وحده، أو SurfaceView وحده، أو nearest symbol، أو vtable-like structure وحدها.

## 3. ما تم إثباته
### Capture
- Cicada::SuperMediaPlayer::CaptureScreen() عند 0x5f93f0.
- مسار تنفيذ Capture عند 0x281fd4 مع رسالة captureScreen exception, frameWidth or frameHeight is 0.
- هذا يثبت Capture execution، وليس Screenshot Blocking.

### DRM / Widevine
ثبت وجود منظومة DRM/Widevine، ومنها:
- parseContentProtection, ContentProtection, initDrmHandler failed
- setForceInsecureDecoder عند 0x5bc62e
- queueSecureInputBuffer عند 0x5bc6fa
- setOutputSurface عند 0x5bc775
- ContentProtection عند 0x5bb312
- IAFPacket::isProtected(), AVAFPacket::isProtected(), AVAFPacket::setProtected()
- مؤشرات Widevine وhardware decoder وSurfaceView/TextureView وDRM keys.

**النتيجة:** DRM/Widevine مثبت، لكن DRM → Screenshot blocking غير مثبت.

### Decoder
- Cicada::avcodecDecoder::init_decoder(... DrmInfo ...) عند 0x27702c.
- Cicada::avcodecDecoder::enqueue_decoder(... IAFPacket ...) عند 0x2777f4.
- ActiveDecoder::decode_func() عند 0x27d304.
- ActiveDecoder::extract_decoder() عند 0x27d770.
- ActiveDecoder::needDrop() عند 0x27da90.
- thread_send_packet() عند 0x27dcf4.
- thread_getFrame() عند 0x27e038.

### Surface / EGL
ثبت المسار المعماري:
android.view.Surface → AndroidSurfaceHandle → ANativeWindow_fromSurface → NativeWindow → EGL → rendering.

كما ثبت OpenGL/EGL rendering.

## 4. VTable investigation
- candidate address point: 0x717e60
- candidate slot: 0x717f68 = +0x108 = virtual slot 33
- pointer: 0x27a510
- ABI-like header:
  - 0x717e50 → 0x0
  - 0x717e58 → 0x71f4d0
  - 0x717e60 → 0x2785bc
- constructor evidence عند 0x278450 يستدعي ActiveDecoderC2 ثم يكتب 0x717e60 إلى object vptr.
- RTTI pointer 0x71f4d0 يؤدي إلى mangled name N6Cicada17mediaCodecDecoderE، وتفسيره Cicada::mediaCodecDecoder.

### تحذير ABI
لا يُسمّى 0x717e60 تلقائياً _ZTVN6Cicada14avcodecDecoderE، لأن ذلك الرمز يبدأ 0x717ce0 وحجمه 0x170 وينتهي عند 0x717e50. لذلك candidate هو حالياً vtable-like / constructor-installed address point وليس global _ZTV مؤكداً.

## 5. Critical function
0x27a510 ليس له exact symbol (NOT_RESOLVED_BY_SYMBOL_TABLE). الـdisassembly الحقيقي ينتهي عند 0x27a540 ret، والجسم الطبيعي عبارة عن stack-canary bookkeeping ثم return، بلا Surface/EGL/security operation.

لا تسمّه dummyFunction بسبب nearest-symbol labeling.

## 6. Known tooling blocker
ملف CRITICAL-FUNCTION-BEHAVIOR.md في التقرير السابق لديه خطأ في function-boundary extraction: parser أدخل تعليمات من function التالية بعد أول ret.

**أول مهمة في الجلسة التالية:** إصلاح write_critical_behavior() ليحلل تعليمات ARM64 ويوقف عند أول mnemonic ret، ثم إعادة توليد التقرير والتحقق منه.

## 7. Native Security Audit
تمت أتمتة مراجعة:
ANativeWindow_fromSurface, ANativeWindow_setUsage, AHardwareBuffer, AHARDWAREBUFFER_USAGE_PROTECTED_CONTENT, GRALLOC_USAGE_PROTECTED, EGL_PROTECTED_CONTENT, EGL_EXT_protected_content, AMediaCodec_configure, MediaCodec.setOutputSurface, SurfaceControl, setSecure.

النتيجة الحالية: Surface/NativeWindow/EGL architecture مثبتة، لكن direct secure/protected APIs مثل setSecure, SurfaceControl, EGL_PROTECTED_CONTENT, protected HardwareBuffer usage لم تُثبت.

## 8. Java Security Audit
تمت أتمتة البحث عن:
FLAG_SECURE, Window.addFlags, Window.setFlags, SurfaceView, TextureView, MediaProjection, createVirtualDisplay, setOutputSurface, nSetSurface, nSurfaceChanged, onCaptureScreen, nativeOnCaptureScreen, screenshot/screen recording.

لم يظهر دليل مباشر حالي على FLAG_SECURE أو MediaProjection/createVirtualDisplay في جذور المصدر المفحوصة. هذا ليس نفياً مطلقاً للـAPK.

## 9. JNI
تم إثبات semantic JNI evidence لنمط GetMethodID حول 0x27af18 وما حوله، مع:
- setForceInsecureDecoder (Z)V
- queueSecureInputBuffer (I[BLjava/lang/Object;JZ)I
- setOutputSurface (Ljava/lang/Object;)I

**مهم:** ظهور +0x108 هنا لا يعني أنه نفس C++ vtable slot. السياقان مختلفان.

## 10. ما لم يُثبت
- FLAG_SECURE
- Window.setFlags(...FLAG_SECURE...)
- SurfaceControl.setSecure
- EGL_PROTECTED_CONTENT
- AHARDWAREBUFFER_USAGE_PROTECTED_CONTENT
- GRALLOC_USAGE_PROTECTED
- Secure Surface كحالة تنفيذية
- DRM → Screenshot blocking
- CaptureScreen → Screenshot blocking
- exact C++ identity للـvirtual slot 0x717f68
- complete RegisterNatives chain لكل screen-related methods

## 11. آخر نشر ناجح
Report branch: reelsec/reports/20261006_183031-321  
Report commit: 7035a50c854beafbea8dc5aee62d8526d65c6078  
Status commit: fd912394ccef82eab6df4569a22d9916ff520de7  
Report path: analysis/sec-shell-deep-v1/reelsec-20261006_183027/  
ELF SHA: a3b0c3fdc0817158cbbfaadb71fbcd608fe9835280bbf1defcb36c60090900e4.

آخر bootstrap ناجح أعاد PUBLISH_STATUS=PUBLISHED، REELSEC_BOOTSTRAP_STATUS=0، وLOCAL_CHANGES_PRESERVED=YES.

## 12. ملاحظة fetch
ظهر أكثر من From https://github.com/... في آخر تشغيل. لم يُثبت بعد أن duplicate fetch أزيل نهائياً؛ يجب فحص bootstrap-run.sh, update-and-run.sh, وreelsec.py وتحديد مصدر كل fetch.

## 13. خطة الاستئناف الإلزامية
1. Verify origin/main وlatest report.
2. Inspect tools/reelsec/reelsec.py قبل أي افتراض.
3. إصلاح critical function boundary parser.
4. إعادة تشغيل ReelSec ونشر تقرير جديد والتحقق من remote.
5. إعادة بناء candidate vtable مع ABI/RTTI/slot boundaries.
6. البحث عن call site حقيقي يستخدم object->vtable[33] / +0x108.
7. ربط slot بالcaller والوظيفة الفعلية.
8. تتبع Surface/output path.
9. تتبع protected state من DRM/decoder إلى Surface/buffer.
10. استكمال Java/JNI/native security bridge.
11. اختبار فرضيات: Window security، protected surface/buffer، secure codec/compositor، أو anti-capture frame behavior.
12. بناء evidence matrix نهائية.
13. عدم إعلان الحل إلا عند وجود execution chain قابلة للإثبات، أو إعلان UNRESOLVED مع تحديد موضع انقطاع الدليل.

## 14. نقطة الاستئناف الدقيقة
ابدأ من:
0x717e60 → +0x108 → 0x27a510

مع الحفاظ على حقيقة أن 0x27a510 حالياً يبدو no-op وأن هوية الـslot غير محسومة.

## 15. تعريف النجاح النهائي
النجاح ليس العثور على كلمة secure، بل إثبات سلسلة:
Trigger → Function → Security State → Surface/Window protection → Android compositor/security policy → Screenshot/Recording restriction.

أو تفنيد هذه السلسلة علمياً وتحديد الآلية البديلة.
