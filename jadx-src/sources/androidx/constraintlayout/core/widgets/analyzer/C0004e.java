package androidx.constraintlayout.core.widgets.analyzer;

import androidx.constraintlayout.core.widgets.ConstraintAnchor$Type;
import androidx.constraintlayout.core.widgets.ConstraintWidget$DimensionBehaviour;
import d1.l;
import java.util.ArrayList;

/* JADX INFO: renamed from: androidx.constraintlayout.core.widgets.analyzer.e */
/* JADX INFO: loaded from: classes.dex */
public final class C0004e extends AbstractC0007h {

    /* JADX INFO: renamed from: k */
    public static final int[] f16k = new int[2];

    public C0004e(d1.f fVar) {
        super(fVar);
        this.f27h.f6e = DependencyNode$Type.LEFT;
        this.f28i.f6e = DependencyNode$Type.RIGHT;
        this.f25f = 0;
    }

    /* JADX INFO: renamed from: m */
    public static void m10m(int[] iArr, int i, int i2, int i3, int i4, float f, int i5) {
        int i6 = i2 - i;
        int i7 = i4 - i3;
        if (i5 != -1) {
            if (i5 == 0) {
                iArr[0] = (int) ((i7 * f) + 0.5f);
                iArr[1] = i7;
                return;
            } else {
                if (i5 != 1) {
                    return;
                }
                iArr[0] = i6;
                iArr[1] = (int) ((i6 * f) + 0.5f);
                return;
            }
        }
        int i8 = (int) ((i7 * f) + 0.5f);
        int i9 = (int) ((i6 / f) + 0.5f);
        if (i8 <= i6) {
            iArr[0] = i8;
            iArr[1] = i7;
        } else if (i9 <= i7) {
            iArr[0] = i6;
            iArr[1] = i9;
        }
    }

    /* JADX WARN: Code duplicated, block: B:118:0x026c  */
    /* JADX WARN: Code duplicated, block: B:120:0x027b  */
    /* JADX INFO: renamed from: a */
    public final void m11a(e1.e eVar) {
        int iM19g;
        int i;
        int iM19g2;
        float f;
        float f2;
        float f3;
        int i2;
        if (AbstractC0003d.f15a[this.f29j.ordinal()] == 3) {
            d1.f fVar = this.f21b;
            m21l(fVar.J, fVar.L, 0);
            return;
        }
        C0001b c0001b = this.f24e;
        boolean z = c0001b.f11j;
        C0000a c0000a = this.f27h;
        C0000a c0000a2 = this.f28i;
        if (!z && this.f23d == ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT) {
            d1.f fVar2 = this.f21b;
            int i3 = fVar2.r;
            if (i3 == 2) {
                d1.f fVar3 = fVar2.V;
                if (fVar3 != null) {
                    C0001b c0001b2 = fVar3.d.f24e;
                    if (c0001b2.f11j) {
                        c0001b.mo3d((int) ((c0001b2.f8g * fVar2.w) + 0.5f));
                    }
                }
            } else if (i3 == 3) {
                int i4 = fVar2.s;
                if (i4 == 0 || i4 == 3) {
                    C0006g c0006g = fVar2.e;
                    C0000a c0000a3 = c0006g.f27h;
                    C0000a c0000a4 = c0006g.f28i;
                    boolean z2 = fVar2.J.f != null;
                    boolean z3 = fVar2.K.f != null;
                    boolean z4 = fVar2.L.f != null;
                    boolean z5 = fVar2.M.f != null;
                    int i5 = fVar2.Z;
                    if (z2 && z3 && z4 && z5) {
                        float f4 = fVar2.Y;
                        boolean z6 = c0000a3.f11j;
                        int[] iArr = f16k;
                        if (z6 && c0000a4.f11j) {
                            if (c0000a.f4c && c0000a2.f4c) {
                                m10m(iArr, ((C0000a) c0000a.f13l.get(0)).f8g + c0000a.f7f, ((C0000a) c0000a2.f13l.get(0)).f8g - c0000a2.f7f, c0000a3.f8g + c0000a3.f7f, c0000a4.f8g - c0000a4.f7f, f4, i5);
                                c0001b.mo3d(iArr[0]);
                                this.f21b.e.f24e.mo3d(iArr[1]);
                                return;
                            }
                            return;
                        }
                        boolean z7 = c0000a.f11j;
                        ArrayList arrayList = c0000a3.f13l;
                        if (z7 && c0000a2.f11j) {
                            if (!c0000a3.f4c || !c0000a4.f4c) {
                                return;
                            }
                            m10m(iArr, c0000a.f8g + c0000a.f7f, c0000a2.f8g - c0000a2.f7f, ((C0000a) arrayList.get(0)).f8g + c0000a3.f7f, ((C0000a) c0000a4.f13l.get(0)).f8g - c0000a4.f7f, f4, i5);
                            c0001b.mo3d(iArr[0]);
                            this.f21b.e.f24e.mo3d(iArr[1]);
                        }
                        if (!c0000a.f4c || !c0000a2.f4c || !c0000a3.f4c || !c0000a4.f4c) {
                            return;
                        }
                        m10m(iArr, ((C0000a) c0000a.f13l.get(0)).f8g + c0000a.f7f, ((C0000a) c0000a2.f13l.get(0)).f8g - c0000a2.f7f, ((C0000a) arrayList.get(0)).f8g + c0000a3.f7f, ((C0000a) c0000a4.f13l.get(0)).f8g - c0000a4.f7f, f4, i5);
                        c0001b.mo3d(iArr[0]);
                        this.f21b.e.f24e.mo3d(iArr[1]);
                    } else if (z2 && z4) {
                        if (!c0000a.f4c || !c0000a2.f4c) {
                            return;
                        }
                        float f5 = fVar2.Y;
                        int i6 = ((C0000a) c0000a.f13l.get(0)).f8g + c0000a.f7f;
                        int i7 = ((C0000a) c0000a2.f13l.get(0)).f8g - c0000a2.f7f;
                        if (i5 == -1 || i5 == 0) {
                            int iM19g3 = m19g(i7 - i6, 0);
                            int i8 = (int) ((iM19g3 * f5) + 0.5f);
                            int iM19g4 = m19g(i8, 1);
                            if (i8 != iM19g4) {
                                iM19g3 = (int) ((iM19g4 / f5) + 0.5f);
                            }
                            c0001b.mo3d(iM19g3);
                            this.f21b.e.f24e.mo3d(iM19g4);
                        } else if (i5 == 1) {
                            int iM19g5 = m19g(i7 - i6, 0);
                            int i9 = (int) ((iM19g5 / f5) + 0.5f);
                            int iM19g6 = m19g(i9, 1);
                            if (i9 != iM19g6) {
                                iM19g5 = (int) ((iM19g6 * f5) + 0.5f);
                            }
                            c0001b.mo3d(iM19g5);
                            this.f21b.e.f24e.mo3d(iM19g6);
                        }
                    } else if (z3 && z5) {
                        if (!c0000a3.f4c || !c0000a4.f4c) {
                            return;
                        }
                        float f6 = fVar2.Y;
                        int i10 = ((C0000a) c0000a3.f13l.get(0)).f8g + c0000a3.f7f;
                        int i11 = ((C0000a) c0000a4.f13l.get(0)).f8g - c0000a4.f7f;
                        if (i5 == -1) {
                            iM19g = m19g(i11 - i10, 1);
                            i = (int) ((iM19g / f6) + 0.5f);
                            iM19g2 = m19g(i, 0);
                            if (i != iM19g2) {
                                iM19g = (int) ((iM19g2 * f6) + 0.5f);
                            }
                            c0001b.mo3d(iM19g2);
                            this.f21b.e.f24e.mo3d(iM19g);
                        } else if (i5 == 0) {
                            int iM19g7 = m19g(i11 - i10, 1);
                            int i12 = (int) ((iM19g7 * f6) + 0.5f);
                            int iM19g8 = m19g(i12, 0);
                            if (i12 != iM19g8) {
                                iM19g7 = (int) ((iM19g8 / f6) + 0.5f);
                            }
                            c0001b.mo3d(iM19g8);
                            this.f21b.e.f24e.mo3d(iM19g7);
                        } else if (i5 == 1) {
                            iM19g = m19g(i11 - i10, 1);
                            i = (int) ((iM19g / f6) + 0.5f);
                            iM19g2 = m19g(i, 0);
                            if (i != iM19g2) {
                                iM19g = (int) ((iM19g2 * f6) + 0.5f);
                            }
                            c0001b.mo3d(iM19g2);
                            this.f21b.e.f24e.mo3d(iM19g);
                        }
                    }
                } else {
                    int i13 = fVar2.Z;
                    if (i13 != -1) {
                        if (i13 == 0) {
                            f3 = fVar2.e.f24e.f8g / fVar2.Y;
                            i2 = (int) (f3 + 0.5f);
                        } else if (i13 != 1) {
                            i2 = 0;
                        } else {
                            f = fVar2.e.f24e.f8g;
                            f2 = fVar2.Y;
                        }
                        c0001b.mo3d(i2);
                    } else {
                        f = fVar2.e.f24e.f8g;
                        f2 = fVar2.Y;
                    }
                    f3 = f * f2;
                    i2 = (int) (f3 + 0.5f);
                    c0001b.mo3d(i2);
                }
            }
        }
        if (c0000a.f4c && c0000a2.f4c) {
            if (c0000a.f11j && c0000a2.f11j && c0001b.f11j) {
                return;
            }
            if (!c0001b.f11j && this.f23d == ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT) {
                d1.f fVar4 = this.f21b;
                if (fVar4.r == 0 && !fVar4.y()) {
                    C0000a c0000a5 = (C0000a) c0000a.f13l.get(0);
                    C0000a c0000a6 = (C0000a) c0000a2.f13l.get(0);
                    int i14 = c0000a5.f8g + c0000a.f7f;
                    int i15 = c0000a6.f8g + c0000a2.f7f;
                    c0000a.mo3d(i14);
                    c0000a2.mo3d(i15);
                    c0001b.mo3d(i15 - i14);
                    return;
                }
            }
            if (!c0001b.f11j && this.f23d == ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT && this.f20a == 1 && c0000a.f13l.size() > 0 && c0000a2.f13l.size() > 0) {
                int iMin = Math.min((((C0000a) c0000a2.f13l.get(0)).f8g + c0000a2.f7f) - (((C0000a) c0000a.f13l.get(0)).f8g + c0000a.f7f), c0001b.f14m);
                d1.f fVar5 = this.f21b;
                int i16 = fVar5.v;
                int iMax = Math.max(fVar5.u, iMin);
                if (i16 > 0) {
                    iMax = Math.min(i16, iMax);
                }
                c0001b.mo3d(iMax);
            }
            if (c0001b.f11j) {
                C0000a c0000a7 = (C0000a) c0000a.f13l.get(0);
                C0000a c0000a8 = (C0000a) c0000a2.f13l.get(0);
                int i17 = c0000a7.f8g;
                int i18 = c0000a.f7f + i17;
                int i19 = c0000a8.f8g;
                int i20 = c0000a2.f7f + i19;
                float f7 = this.f21b.f0;
                if (c0000a7 == c0000a8) {
                    f7 = 0.5f;
                } else {
                    i17 = i18;
                    i19 = i20;
                }
                c0000a.mo3d((int) ((((i19 - i17) - c0001b.f8g) * f7) + i17 + 0.5f));
                c0000a2.mo3d(c0000a.f8g + c0001b.f8g);
            }
        }
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: d */
    public final void mo5d() {
        d1.f fVar;
        d1.f fVar2;
        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour;
        d1.f fVar3;
        d1.f fVar4;
        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour2;
        d1.f fVar5 = this.f21b;
        boolean z = fVar5.a;
        C0001b c0001b = this.f24e;
        if (z) {
            c0001b.mo3d(fVar5.r());
        }
        boolean z2 = c0001b.f11j;
        C0000a c0000a = this.f28i;
        C0000a c0000a2 = this.f27h;
        if (z2) {
            ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour3 = this.f23d;
            ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour4 = ConstraintWidget$DimensionBehaviour.MATCH_PARENT;
            if (constraintWidget$DimensionBehaviour3 == constraintWidget$DimensionBehaviour4 && (fVar2 = (fVar = this.f21b).V) != null && ((constraintWidget$DimensionBehaviour = fVar2.U[0]) == ConstraintWidget$DimensionBehaviour.FIXED || constraintWidget$DimensionBehaviour == constraintWidget$DimensionBehaviour4)) {
                AbstractC0007h.m15b(c0000a2, fVar2.d.f27h, fVar.J.e());
                AbstractC0007h.m15b(c0000a, fVar2.d.f28i, -this.f21b.L.e());
                return;
            }
        } else {
            d1.f fVar6 = this.f21b;
            ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour5 = fVar6.U[0];
            this.f23d = constraintWidget$DimensionBehaviour5;
            if (constraintWidget$DimensionBehaviour5 != ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT) {
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour6 = ConstraintWidget$DimensionBehaviour.MATCH_PARENT;
                if (constraintWidget$DimensionBehaviour5 == constraintWidget$DimensionBehaviour6 && (fVar4 = fVar6.V) != null && ((constraintWidget$DimensionBehaviour2 = fVar4.U[0]) == ConstraintWidget$DimensionBehaviour.FIXED || constraintWidget$DimensionBehaviour2 == constraintWidget$DimensionBehaviour6)) {
                    int iR = (fVar4.r() - this.f21b.J.e()) - this.f21b.L.e();
                    AbstractC0007h.m15b(c0000a2, fVar4.d.f27h, this.f21b.J.e());
                    AbstractC0007h.m15b(c0000a, fVar4.d.f28i, -this.f21b.L.e());
                    c0001b.mo3d(iR);
                    return;
                }
                if (constraintWidget$DimensionBehaviour5 == ConstraintWidget$DimensionBehaviour.FIXED) {
                    c0001b.mo3d(fVar6.r());
                }
            }
        }
        if (c0001b.f11j) {
            d1.f fVar7 = this.f21b;
            if (fVar7.a) {
                d1.d[] dVarArr = fVar7.R;
                d1.d dVar = dVarArr[0];
                d1.d dVar2 = dVar.f;
                if (dVar2 != null && dVarArr[1].f != null) {
                    if (fVar7.y()) {
                        c0000a2.f7f = this.f21b.R[0].e();
                        c0000a.f7f = -this.f21b.R[1].e();
                        return;
                    }
                    C0000a c0000aM16h = AbstractC0007h.m16h(this.f21b.R[0]);
                    if (c0000aM16h != null) {
                        AbstractC0007h.m15b(c0000a2, c0000aM16h, this.f21b.R[0].e());
                    }
                    C0000a c0000aM16h2 = AbstractC0007h.m16h(this.f21b.R[1]);
                    if (c0000aM16h2 != null) {
                        AbstractC0007h.m15b(c0000a, c0000aM16h2, -this.f21b.R[1].e());
                    }
                    c0000a2.f3b = true;
                    c0000a.f3b = true;
                    return;
                }
                if (dVar2 != null) {
                    C0000a c0000aM16h3 = AbstractC0007h.m16h(dVar);
                    if (c0000aM16h3 != null) {
                        AbstractC0007h.m15b(c0000a2, c0000aM16h3, this.f21b.R[0].e());
                        AbstractC0007h.m15b(c0000a, c0000a2, c0001b.f8g);
                        return;
                    }
                    return;
                }
                d1.d dVar3 = dVarArr[1];
                if (dVar3.f != null) {
                    C0000a c0000aM16h4 = AbstractC0007h.m16h(dVar3);
                    if (c0000aM16h4 != null) {
                        AbstractC0007h.m15b(c0000a, c0000aM16h4, -this.f21b.R[1].e());
                        AbstractC0007h.m15b(c0000a2, c0000a, -c0001b.f8g);
                        return;
                    }
                    return;
                }
                if ((fVar7 instanceof l) || fVar7.V == null || fVar7.j(ConstraintAnchor$Type.CENTER).f != null) {
                    return;
                }
                d1.f fVar8 = this.f21b;
                AbstractC0007h.m15b(c0000a2, fVar8.V.d.f27h, fVar8.s());
                AbstractC0007h.m15b(c0000a, c0000a2, c0001b.f8g);
                return;
            }
        }
        if (this.f23d == ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT) {
            d1.f fVar9 = this.f21b;
            int i = fVar9.r;
            if (i == 2) {
                d1.f fVar10 = fVar9.V;
                if (fVar10 != null) {
                    C0001b c0001b2 = fVar10.e.f24e;
                    c0001b.f13l.add(c0001b2);
                    c0001b2.f12k.add(c0001b);
                    c0001b.f3b = true;
                    c0001b.f12k.add(c0000a2);
                    c0001b.f12k.add(c0000a);
                }
            } else if (i == 3) {
                if (fVar9.s == 3) {
                    c0000a2.f2a = this;
                    c0000a.f2a = this;
                    C0006g c0006g = fVar9.e;
                    c0006g.f27h.f2a = this;
                    c0006g.f28i.f2a = this;
                    c0001b.f2a = this;
                    if (fVar9.z()) {
                        c0001b.f13l.add(this.f21b.e.f24e);
                        this.f21b.e.f24e.f12k.add(c0001b);
                        C0006g c0006g2 = this.f21b.e;
                        c0006g2.f24e.f2a = this;
                        c0001b.f13l.add(c0006g2.f27h);
                        c0001b.f13l.add(this.f21b.e.f28i);
                        this.f21b.e.f27h.f12k.add(c0001b);
                        this.f21b.e.f28i.f12k.add(c0001b);
                    } else if (this.f21b.y()) {
                        this.f21b.e.f24e.f13l.add(c0001b);
                        c0001b.f12k.add(this.f21b.e.f24e);
                    } else {
                        this.f21b.e.f24e.f13l.add(c0001b);
                    }
                } else {
                    C0001b c0001b3 = fVar9.e.f24e;
                    c0001b.f13l.add(c0001b3);
                    c0001b3.f12k.add(c0001b);
                    this.f21b.e.f27h.f12k.add(c0001b);
                    this.f21b.e.f28i.f12k.add(c0001b);
                    c0001b.f3b = true;
                    c0001b.f12k.add(c0000a2);
                    c0001b.f12k.add(c0000a);
                    c0000a2.f13l.add(c0001b);
                    c0000a.f13l.add(c0001b);
                }
            }
        }
        d1.f fVar11 = this.f21b;
        d1.d[] dVarArr2 = fVar11.R;
        d1.d dVar4 = dVarArr2[0];
        d1.d dVar5 = dVar4.f;
        if (dVar5 != null && dVarArr2[1].f != null) {
            if (fVar11.y()) {
                c0000a2.f7f = this.f21b.R[0].e();
                c0000a.f7f = -this.f21b.R[1].e();
                return;
            }
            C0000a c0000aM16h5 = AbstractC0007h.m16h(this.f21b.R[0]);
            C0000a c0000aM16h6 = AbstractC0007h.m16h(this.f21b.R[1]);
            if (c0000aM16h5 != null) {
                c0000aM16h5.m1b(this);
            }
            if (c0000aM16h6 != null) {
                c0000aM16h6.m1b(this);
            }
            this.f29j = WidgetRun$RunType.CENTER;
            return;
        }
        if (dVar5 != null) {
            C0000a c0000aM16h7 = AbstractC0007h.m16h(dVar4);
            if (c0000aM16h7 != null) {
                AbstractC0007h.m15b(c0000a2, c0000aM16h7, this.f21b.R[0].e());
                m18c(c0000a, c0000a2, 1, c0001b);
                return;
            }
            return;
        }
        d1.d dVar6 = dVarArr2[1];
        if (dVar6.f != null) {
            C0000a c0000aM16h8 = AbstractC0007h.m16h(dVar6);
            if (c0000aM16h8 != null) {
                AbstractC0007h.m15b(c0000a, c0000aM16h8, -this.f21b.R[1].e());
                m18c(c0000a2, c0000a, -1, c0001b);
                return;
            }
            return;
        }
        if ((fVar11 instanceof l) || (fVar3 = fVar11.V) == null) {
            return;
        }
        AbstractC0007h.m15b(c0000a2, fVar3.d.f27h, fVar11.s());
        m18c(c0000a, c0000a2, 1, c0001b);
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: e */
    public final void mo6e() {
        C0000a c0000a = this.f27h;
        if (c0000a.f11j) {
            this.f21b.a0 = c0000a.f8g;
        }
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: f */
    public final void mo7f() {
        this.f22c = null;
        this.f27h.m2c();
        this.f28i.m2c();
        this.f24e.m2c();
        this.f26g = false;
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: k */
    public final boolean mo8k() {
        return this.f23d != ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT || this.f21b.r == 0;
    }

    /* JADX INFO: renamed from: n */
    public final void m12n() {
        this.f26g = false;
        C0000a c0000a = this.f27h;
        c0000a.m2c();
        c0000a.f11j = false;
        C0000a c0000a2 = this.f28i;
        c0000a2.m2c();
        c0000a2.f11j = false;
        this.f24e.f11j = false;
    }

    public final String toString() {
        return "HorizontalRun " + this.f21b.k0;
    }
}
