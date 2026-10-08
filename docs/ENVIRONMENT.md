# البيئة والأدوات (ENVIRONMENT)

## مصفوفة المتطلبات (الحقيقية — من ملفات البناء والكود)

| الأداة | النوع | المطلوب | الاكتشاف | التثبيت |
|---|---|---|---|---|
| python3 | إلزامية | ≥3.10 | `python3 --version` | شرط مسبق وحيد (لا يثبّت نفسه) |
| pip | إلزامية | أي | `python -m pip --version` | `ensurepip` من المكتبة القياسية |
| node | إلزامية | ≥20 | `node --version` | مدير الحزم ← ثم tarball موثق من nodejs.org إلى `.tools` مع فحص SHA |
| npm | إلزامية | مع node | `npm --version` | تأتي مع node |
| java | اختيارية | ≥11 | `java -version` | يدوي (لازمة فقط للأدوات الحقيقية) |
| apktool | اختيارية | 3.x | `PATH` أو `APKFORGE_APKTOOL` | `--install-tools` (إصدار GitHub + فحص jar) |
| jadx | اختيارية | 1.5.x | `PATH` أو `APKFORGE_JADX` | يدوي فقط (~130MB) |
| git | اختيارية | أي | `git --version` | مدير الحزم |
| sqlite3 | اختيارية | أي | `sqlite3 --version` | مدير الحزم (بايثون يغني عنها) |
| curl | اختيارية | أي | `curl --version` | مدير الحزم (المحرك يستخدم urllib) |
| docker | غير مطلوبة (مرحلة 1) | — | تُرصَد فقط | لا تُثبَّت هنا |

## تدقيق البيئة (`--check`)

يكتشف: النظام والمعمارية والنواة والمعالجات والذاكرة والقرص والصدفة
والشبكة والمنافذ والصلاحيات — ويطبع تقريرًا (`logs/environment-*.json`):

```
OK   python3 detected=3.13 want=>=3.10
OK   node detected=20.20 want=>=20
WARN apktool skip-missing (jobs fail explicitly until installed)
```

## القواعد

- لا تفشل العملية لأداة قابلة للتثبيت تلقائيًا؛ ولا تُثبَّت أداة غير
  مطلوبة (لا Gradle ولا Android SDK ولا قواعد خارجية في المرحلة 1).
- المصادر الموثوقة فقط (مدير النظام، nodejs.org مع SHA، إصدارات GitHub
  الرسمية) — وكل عملية في `logs/bootstrap/`.
- بلا إنترنت: تُستخدَم الكاشات المحلية (npm/pip) وما هو موجود؛ وما
  يستحيل بلا شبكة يُرفَض بـ `NETWORK REQUIRED` مع تسمية المكوّن.
