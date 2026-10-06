package androidx.constraintlayout.motion.widget;

/* JADX INFO: renamed from: androidx.constraintlayout.motion.widget.b */
/* JADX INFO: loaded from: classes.dex */
public final class C0015b {

    /* JADX INFO: renamed from: a */
    public float f171a = Float.NaN;

    /* JADX INFO: renamed from: b */
    public float f172b = Float.NaN;

    /* JADX INFO: renamed from: c */
    public int f173c = -1;

    /* JADX INFO: renamed from: d */
    public int f174d = -1;

    /* JADX INFO: renamed from: e */
    public final /* synthetic */ MotionLayout f175e;

    public C0015b(MotionLayout motionLayout) {
        this.f175e = motionLayout;
    }

    /* JADX INFO: renamed from: a */
    public final void m66a() {
        int i = this.f173c;
        MotionLayout motionLayout = this.f175e;
        if (i != -1 || this.f174d != -1) {
            if (i == -1) {
                motionLayout.m48I(this.f174d);
            } else {
                int i2 = this.f174d;
                if (i2 == -1) {
                    motionLayout.m44E(i);
                } else {
                    motionLayout.m45F(i, i2);
                }
            }
            motionLayout.setState(MotionLayout.TransitionState.SETUP);
        }
        if (Float.isNaN(this.f172b)) {
            if (Float.isNaN(this.f171a)) {
                return;
            }
            motionLayout.setProgress(this.f171a);
        } else {
            motionLayout.m43D(this.f171a, this.f172b);
            this.f171a = Float.NaN;
            this.f172b = Float.NaN;
            this.f173c = -1;
            this.f174d = -1;
        }
    }
}
