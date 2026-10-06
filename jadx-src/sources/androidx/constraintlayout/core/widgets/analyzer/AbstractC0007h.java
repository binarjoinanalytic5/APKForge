package androidx.constraintlayout.core.widgets.analyzer;

import androidx.constraintlayout.core.widgets.ConstraintWidget$DimensionBehaviour;
import e1.i;
import e1.k;

/* JADX INFO: renamed from: androidx.constraintlayout.core.widgets.analyzer.h */
/* JADX INFO: loaded from: classes.dex */
public abstract class AbstractC0007h implements e1.e {

    /* JADX INFO: renamed from: a */
    public int f20a;

    /* JADX INFO: renamed from: b */
    public d1.f f21b;

    /* JADX INFO: renamed from: c */
    public i f22c;

    /* JADX INFO: renamed from: d */
    public ConstraintWidget$DimensionBehaviour f23d;

    /* JADX INFO: renamed from: e */
    public final C0001b f24e = new C0001b(this);

    /* JADX INFO: renamed from: f */
    public int f25f = 0;

    /* JADX INFO: renamed from: g */
    public boolean f26g = false;

    /* JADX INFO: renamed from: h */
    public final C0000a f27h = new C0000a(this);

    /* JADX INFO: renamed from: i */
    public final C0000a f28i = new C0000a(this);

    /* JADX INFO: renamed from: j */
    public WidgetRun$RunType f29j = WidgetRun$RunType.NONE;

    public AbstractC0007h(d1.f fVar) {
        this.f21b = fVar;
    }

    /* JADX INFO: renamed from: b */
    public static void m15b(C0000a c0000a, C0000a c0000a2, int i) {
        c0000a.f13l.add(c0000a2);
        c0000a.f7f = i;
        c0000a2.f12k.add(c0000a);
    }

    /* JADX INFO: renamed from: h */
    public static C0000a m16h(d1.d dVar) {
        d1.d dVar2 = dVar.f;
        if (dVar2 == null) {
            return null;
        }
        int i = k.a[dVar2.e.ordinal()];
        d1.f fVar = dVar2.d;
        if (i == 1) {
            return fVar.d.f27h;
        }
        if (i == 2) {
            return fVar.d.f28i;
        }
        if (i == 3) {
            return fVar.e.f27h;
        }
        if (i == 4) {
            return fVar.e.f18k;
        }
        if (i != 5) {
            return null;
        }
        return fVar.e.f28i;
    }

    /* JADX INFO: renamed from: i */
    public static C0000a m17i(d1.d dVar, int i) {
        d1.d dVar2 = dVar.f;
        if (dVar2 == null) {
            return null;
        }
        d1.f fVar = dVar2.d;
        AbstractC0007h abstractC0007h = i == 0 ? fVar.d : fVar.e;
        int i2 = k.a[dVar2.e.ordinal()];
        if (i2 != 1) {
            if (i2 != 2) {
                if (i2 != 3) {
                    if (i2 != 5) {
                        return null;
                    }
                }
            }
            return abstractC0007h.f28i;
        }
        return abstractC0007h.f27h;
    }

    /* JADX INFO: renamed from: c */
    public final void m18c(C0000a c0000a, C0000a c0000a2, int i, C0001b c0001b) {
        c0000a.f13l.add(c0000a2);
        c0000a.f13l.add(this.f24e);
        c0000a.f9h = i;
        c0000a.f10i = c0001b;
        c0000a2.f12k.add(c0000a);
        c0001b.f12k.add(c0000a);
    }

    /* JADX INFO: renamed from: d */
    public abstract void mo5d();

    /* JADX INFO: renamed from: e */
    public abstract void mo6e();

    /* JADX INFO: renamed from: f */
    public abstract void mo7f();

    /* JADX INFO: renamed from: g */
    public final int m19g(int i, int i2) {
        int iMax;
        if (i2 == 0) {
            d1.f fVar = this.f21b;
            int i3 = fVar.v;
            iMax = Math.max(fVar.u, i);
            if (i3 > 0) {
                iMax = Math.min(i3, i);
            }
            if (iMax == i) {
                return i;
            }
        } else {
            d1.f fVar2 = this.f21b;
            int i4 = fVar2.y;
            iMax = Math.max(fVar2.x, i);
            if (i4 > 0) {
                iMax = Math.min(i4, i);
            }
            if (iMax == i) {
                return i;
            }
        }
        return iMax;
    }

    /* JADX INFO: renamed from: j */
    public long m20j() {
        C0001b c0001b = this.f24e;
        if (c0001b.f11j) {
            return c0001b.f8g;
        }
        return 0L;
    }

    /* JADX INFO: renamed from: k */
    public abstract boolean mo8k();

    /* JADX WARN: Code duplicated, block: B:29:0x0056 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:30:0x0058  */
    /* JADX WARN: Code duplicated, block: B:33:0x0060  */
    /* JADX WARN: Code duplicated, block: B:35:0x0064  */
    /* JADX WARN: Code duplicated, block: B:36:0x006b  */
    /* JADX INFO: renamed from: l */
    public final void m21l(d1.d dVar, d1.d dVar2, int i) {
        C0001b c0001b;
        float f;
        int i2;
        C0000a c0000aM16h = m16h(dVar);
        C0000a c0000aM16h2 = m16h(dVar2);
        if (c0000aM16h.f11j && c0000aM16h2.f11j) {
            int iE = dVar.e() + c0000aM16h.f8g;
            int iE2 = c0000aM16h2.f8g - dVar2.e();
            int i3 = iE2 - iE;
            C0001b c0001b2 = this.f24e;
            if (!c0001b2.f11j) {
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour = this.f23d;
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour2 = ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT;
                if (constraintWidget$DimensionBehaviour == constraintWidget$DimensionBehaviour2) {
                    int i4 = this.f20a;
                    if (i4 == 0) {
                        c0001b2.mo3d(m19g(i3, i));
                    } else if (i4 == 1) {
                        c0001b2.mo3d(Math.min(m19g(c0001b2.f14m, i), i3));
                    } else if (i4 == 2) {
                        d1.f fVar = this.f21b;
                        d1.f fVar2 = fVar.V;
                        if (fVar2 != null) {
                            C0001b c0001b3 = (i == 0 ? fVar2.d : fVar2.e).f24e;
                            if (c0001b3.f11j) {
                                c0001b2.mo3d(m19g((int) ((c0001b3.f8g * (i == 0 ? fVar.w : fVar.z)) + 0.5f), i));
                            }
                        }
                    } else if (i4 == 3) {
                        d1.f fVar3 = this.f21b;
                        AbstractC0007h abstractC0007h = fVar3.d;
                        if (abstractC0007h.f23d == constraintWidget$DimensionBehaviour2 && abstractC0007h.f20a == 3) {
                            C0006g c0006g = fVar3.e;
                            if (c0006g.f23d != constraintWidget$DimensionBehaviour2 || c0006g.f20a != 3) {
                                if (i == 0) {
                                    abstractC0007h = fVar3.e;
                                }
                                c0001b = abstractC0007h.f24e;
                                if (c0001b.f11j) {
                                    f = fVar3.Y;
                                    if (i == 1) {
                                        i2 = (int) ((c0001b.f8g / f) + 0.5f);
                                    } else {
                                        i2 = (int) ((f * c0001b.f8g) + 0.5f);
                                    }
                                    c0001b2.mo3d(i2);
                                }
                            }
                        } else {
                            if (i == 0) {
                                abstractC0007h = fVar3.e;
                            }
                            c0001b = abstractC0007h.f24e;
                            if (c0001b.f11j) {
                                f = fVar3.Y;
                                if (i == 1) {
                                    i2 = (int) ((c0001b.f8g / f) + 0.5f);
                                } else {
                                    i2 = (int) ((f * c0001b.f8g) + 0.5f);
                                }
                                c0001b2.mo3d(i2);
                            }
                        }
                    }
                }
            }
            if (c0001b2.f11j) {
                int i5 = c0001b2.f8g;
                C0000a c0000a = this.f28i;
                C0000a c0000a2 = this.f27h;
                if (i5 == i3) {
                    c0000a2.mo3d(iE);
                    c0000a.mo3d(iE2);
                    return;
                }
                d1.f fVar4 = this.f21b;
                float f2 = i == 0 ? fVar4.f0 : fVar4.g0;
                if (c0000aM16h == c0000aM16h2) {
                    iE = c0000aM16h.f8g;
                    iE2 = c0000aM16h2.f8g;
                    f2 = 0.5f;
                }
                c0000a2.mo3d((int) ((((iE2 - iE) - i5) * f2) + iE + 0.5f));
                c0000a.mo3d(c0000a2.f8g + c0001b2.f8g);
            }
        }
    }
}
