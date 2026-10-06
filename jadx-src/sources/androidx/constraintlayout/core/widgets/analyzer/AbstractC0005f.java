package androidx.constraintlayout.core.widgets.analyzer;

/* JADX INFO: renamed from: androidx.constraintlayout.core.widgets.analyzer.f */
/* JADX INFO: loaded from: classes.dex */
public abstract /* synthetic */ class AbstractC0005f {

    /* JADX INFO: renamed from: a */
    public static final /* synthetic */ int[] f17a;

    static {
        int[] iArr = new int[WidgetRun$RunType.values().length];
        f17a = iArr;
        try {
            iArr[WidgetRun$RunType.START.ordinal()] = 1;
        } catch (NoSuchFieldError unused) {
        }
        try {
            f17a[WidgetRun$RunType.END.ordinal()] = 2;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            f17a[WidgetRun$RunType.CENTER.ordinal()] = 3;
        } catch (NoSuchFieldError unused3) {
        }
    }
}
