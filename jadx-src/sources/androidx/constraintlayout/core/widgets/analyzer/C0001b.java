package androidx.constraintlayout.core.widgets.analyzer;

/* JADX INFO: renamed from: androidx.constraintlayout.core.widgets.analyzer.b */
/* JADX INFO: loaded from: classes.dex */
public class C0001b extends C0000a {

    /* JADX INFO: renamed from: m */
    public int f14m;

    public C0001b(AbstractC0007h abstractC0007h) {
        super(abstractC0007h);
        if (abstractC0007h instanceof C0004e) {
            this.f6e = DependencyNode$Type.HORIZONTAL_DIMENSION;
        } else {
            this.f6e = DependencyNode$Type.VERTICAL_DIMENSION;
        }
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.C0000a
    /* JADX INFO: renamed from: d */
    public final void mo3d(int i) {
        if (this.f11j) {
            return;
        }
        this.f11j = true;
        this.f8g = i;
        for (e1.e eVar : this.f12k) {
            eVar.a(eVar);
        }
    }
}
