package androidx.constraintlayout.core.widgets.analyzer;

import d1.l;
import java.util.Iterator;

/* JADX INFO: renamed from: androidx.constraintlayout.core.widgets.analyzer.c */
/* JADX INFO: loaded from: classes.dex */
public final class C0002c extends AbstractC0007h {
    /* JADX INFO: renamed from: a */
    public final void m4a(e1.e eVar) {
        d1.a aVar = this.f21b;
        int i = aVar.w0;
        C0000a c0000a = this.f27h;
        Iterator it = c0000a.f13l.iterator();
        int i2 = 0;
        int i3 = -1;
        while (it.hasNext()) {
            int i4 = ((C0000a) it.next()).f8g;
            if (i3 == -1 || i4 < i3) {
                i3 = i4;
            }
            if (i2 < i4) {
                i2 = i4;
            }
        }
        if (i == 0 || i == 2) {
            c0000a.mo3d(i3 + aVar.y0);
        } else {
            c0000a.mo3d(i2 + aVar.y0);
        }
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: d */
    public final void mo5d() {
        d1.a aVar = this.f21b;
        if (aVar instanceof d1.a) {
            C0000a c0000a = this.f27h;
            c0000a.f3b = true;
            d1.a aVar2 = aVar;
            int i = aVar2.w0;
            boolean z = aVar2.x0;
            int i2 = 0;
            if (i == 0) {
                c0000a.f6e = DependencyNode$Type.LEFT;
                while (i2 < ((l) aVar2).v0) {
                    d1.f fVar = ((l) aVar2).u0[i2];
                    if (z || fVar.i0 != 8) {
                        C0000a c0000a2 = fVar.d.f27h;
                        c0000a2.f12k.add(c0000a);
                        c0000a.f13l.add(c0000a2);
                    }
                    i2++;
                }
                m9m(this.f21b.d.f27h);
                m9m(this.f21b.d.f28i);
                return;
            }
            if (i == 1) {
                c0000a.f6e = DependencyNode$Type.RIGHT;
                while (i2 < ((l) aVar2).v0) {
                    d1.f fVar2 = ((l) aVar2).u0[i2];
                    if (z || fVar2.i0 != 8) {
                        C0000a c0000a3 = fVar2.d.f28i;
                        c0000a3.f12k.add(c0000a);
                        c0000a.f13l.add(c0000a3);
                    }
                    i2++;
                }
                m9m(this.f21b.d.f27h);
                m9m(this.f21b.d.f28i);
                return;
            }
            if (i == 2) {
                c0000a.f6e = DependencyNode$Type.TOP;
                while (i2 < ((l) aVar2).v0) {
                    d1.f fVar3 = ((l) aVar2).u0[i2];
                    if (z || fVar3.i0 != 8) {
                        C0000a c0000a4 = fVar3.e.f27h;
                        c0000a4.f12k.add(c0000a);
                        c0000a.f13l.add(c0000a4);
                    }
                    i2++;
                }
                m9m(this.f21b.e.f27h);
                m9m(this.f21b.e.f28i);
                return;
            }
            if (i != 3) {
                return;
            }
            c0000a.f6e = DependencyNode$Type.BOTTOM;
            while (i2 < ((l) aVar2).v0) {
                d1.f fVar4 = ((l) aVar2).u0[i2];
                if (z || fVar4.i0 != 8) {
                    C0000a c0000a5 = fVar4.e.f28i;
                    c0000a5.f12k.add(c0000a);
                    c0000a.f13l.add(c0000a5);
                }
                i2++;
            }
            m9m(this.f21b.e.f27h);
            m9m(this.f21b.e.f28i);
        }
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: e */
    public final void mo6e() {
        d1.a aVar = this.f21b;
        if (aVar instanceof d1.a) {
            int i = aVar.w0;
            C0000a c0000a = this.f27h;
            if (i == 0 || i == 1) {
                ((d1.f) aVar).a0 = c0000a.f8g;
            } else {
                ((d1.f) aVar).b0 = c0000a.f8g;
            }
        }
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: f */
    public final void mo7f() {
        this.f22c = null;
        this.f27h.m2c();
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: k */
    public final boolean mo8k() {
        return false;
    }

    /* JADX INFO: renamed from: m */
    public final void m9m(C0000a c0000a) {
        C0000a c0000a2 = this.f27h;
        c0000a2.f12k.add(c0000a);
        c0000a.f13l.add(c0000a2);
    }
}
