package androidx.constraintlayout.core.widgets.analyzer;

/* JADX INFO: renamed from: androidx.constraintlayout.core.widgets.analyzer.d */
/* JADX INFO: loaded from: classes.dex */
public abstract /* synthetic */ class AbstractC0003d {

    /* JADX INFO: renamed from: a */
    public static final /* synthetic */ int[] f15a;

    static {
        int[] iArr = new int[WidgetRun$RunType.values().length];
        f15a = iArr;
        try {
            iArr[WidgetRun$RunType.START.ordinal()] = 1;
        } catch (NoSuchFieldError unused) {
        }
        try {
            f15a[WidgetRun$RunType.END.ordinal()] = 2;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            f15a[WidgetRun$RunType.CENTER.ordinal()] = 3;
        } catch (NoSuchFieldError unused3) {
        }
    }
}
