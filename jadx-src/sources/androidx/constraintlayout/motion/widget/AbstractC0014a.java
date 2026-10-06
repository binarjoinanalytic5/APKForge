package androidx.constraintlayout.motion.widget;

/* JADX INFO: renamed from: androidx.constraintlayout.motion.widget.a */
/* JADX INFO: loaded from: classes.dex */
public abstract /* synthetic */ class AbstractC0014a {

    /* JADX INFO: renamed from: a */
    public static final /* synthetic */ int[] f170a;

    static {
        int[] iArr = new int[MotionLayout.TransitionState.values().length];
        f170a = iArr;
        try {
            iArr[MotionLayout.TransitionState.UNDEFINED.ordinal()] = 1;
        } catch (NoSuchFieldError unused) {
        }
        try {
            f170a[MotionLayout.TransitionState.SETUP.ordinal()] = 2;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            f170a[MotionLayout.TransitionState.MOVING.ordinal()] = 3;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            f170a[MotionLayout.TransitionState.FINISHED.ordinal()] = 4;
        } catch (NoSuchFieldError unused4) {
        }
    }
}
