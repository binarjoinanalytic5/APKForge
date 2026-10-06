package androidx.constraintlayout.core.widgets.analyzer;

import androidx.constraintlayout.core.widgets.ConstraintAnchor$Type;
import androidx.constraintlayout.core.widgets.ConstraintWidget$DimensionBehaviour;
import d1.l;

/* JADX INFO: renamed from: androidx.constraintlayout.core.widgets.analyzer.g */
/* JADX INFO: loaded from: classes.dex */
public final class C0006g extends AbstractC0007h {

    /* JADX INFO: renamed from: k */
    public final C0000a f18k;

    /* JADX INFO: renamed from: l */
    public e1.a f19l;

    public C0006g(d1.f fVar) {
        super(fVar);
        C0000a c0000a = new C0000a(this);
        this.f18k = c0000a;
        this.f19l = null;
        this.f27h.f6e = DependencyNode$Type.TOP;
        this.f28i.f6e = DependencyNode$Type.BOTTOM;
        c0000a.f6e = DependencyNode$Type.BASELINE;
        this.f25f = 1;
    }

    /* JADX INFO: renamed from: a */
    public final void m13a(e1.e eVar) {
        float f;
        float f2;
        float f3;
        int i;
        if (AbstractC0005f.f17a[this.f29j.ordinal()] == 3) {
            d1.f fVar = this.f21b;
            m21l(fVar.K, fVar.M, 1);
            return;
        }
        C0001b c0001b = this.f24e;
        if (c0001b.f4c && !c0001b.f11j && this.f23d == ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT) {
            d1.f fVar2 = this.f21b;
            int i2 = fVar2.s;
            if (i2 == 2) {
                d1.f fVar3 = fVar2.V;
                if (fVar3 != null) {
                    C0001b c0001b2 = fVar3.e.f24e;
                    if (c0001b2.f11j) {
                        c0001b.mo3d((int) ((c0001b2.f8g * fVar2.z) + 0.5f));
                    }
                }
            } else if (i2 == 3) {
                C0001b c0001b3 = fVar2.d.f24e;
                if (c0001b3.f11j) {
                    int i3 = fVar2.Z;
                    if (i3 != -1) {
                        if (i3 == 0) {
                            f3 = c0001b3.f8g * fVar2.Y;
                            i = (int) (f3 + 0.5f);
                        } else if (i3 != 1) {
                            i = 0;
                        } else {
                            f = c0001b3.f8g;
                            f2 = fVar2.Y;
                        }
                        c0001b.mo3d(i);
                    } else {
                        f = c0001b3.f8g;
                        f2 = fVar2.Y;
                    }
                    f3 = f / f2;
                    i = (int) (f3 + 0.5f);
                    c0001b.mo3d(i);
                }
            }
        }
        C0000a c0000a = this.f27h;
        if (c0000a.f4c) {
            C0000a c0000a2 = this.f28i;
            if (c0000a2.f4c) {
                if (c0000a.f11j && c0000a2.f11j && c0001b.f11j) {
                    return;
                }
                if (!c0001b.f11j && this.f23d == ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT) {
                    d1.f fVar4 = this.f21b;
                    if (fVar4.r == 0 && !fVar4.z()) {
                        C0000a c0000a3 = (C0000a) c0000a.f13l.get(0);
                        C0000a c0000a4 = (C0000a) c0000a2.f13l.get(0);
                        int i4 = c0000a3.f8g + c0000a.f7f;
                        int i5 = c0000a4.f8g + c0000a2.f7f;
                        c0000a.mo3d(i4);
                        c0000a2.mo3d(i5);
                        c0001b.mo3d(i5 - i4);
                        return;
                    }
                }
                if (!c0001b.f11j && this.f23d == ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT && this.f20a == 1 && c0000a.f13l.size() > 0 && c0000a2.f13l.size() > 0) {
                    C0000a c0000a5 = (C0000a) c0000a.f13l.get(0);
                    int i6 = (((C0000a) c0000a2.f13l.get(0)).f8g + c0000a2.f7f) - (c0000a5.f8g + c0000a.f7f);
                    int i7 = c0001b.f14m;
                    if (i6 < i7) {
                        c0001b.mo3d(i6);
                    } else {
                        c0001b.mo3d(i7);
                    }
                }
                if (c0001b.f11j && c0000a.f13l.size() > 0 && c0000a2.f13l.size() > 0) {
                    C0000a c0000a6 = (C0000a) c0000a.f13l.get(0);
                    C0000a c0000a7 = (C0000a) c0000a2.f13l.get(0);
                    int i8 = c0000a6.f8g;
                    int i9 = c0000a.f7f + i8;
                    int i10 = c0000a7.f8g;
                    int i11 = c0000a2.f7f + i10;
                    float f4 = this.f21b.g0;
                    if (c0000a6 == c0000a7) {
                        f4 = 0.5f;
                    } else {
                        i8 = i9;
                        i10 = i11;
                    }
                    c0000a.mo3d((int) ((((i10 - i8) - c0001b.f8g) * f4) + i8 + 0.5f));
                    c0000a2.mo3d(c0000a.f8g + c0001b.f8g);
                }
            }
        }
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: d */
    public final void mo5d() {
        d1.f fVar;
        d1.f fVar2;
        d1.f fVar3;
        d1.f fVar4;
        d1.f fVar5 = this.f21b;
        boolean z = fVar5.a;
        C0001b c0001b = this.f24e;
        if (z) {
            c0001b.mo3d(fVar5.l());
        }
        boolean z2 = c0001b.f11j;
        C0000a c0000a = this.f28i;
        C0000a c0000a2 = this.f27h;
        if (!z2) {
            d1.f fVar6 = this.f21b;
            this.f23d = fVar6.U[1];
            if (fVar6.E) {
                this.f19l = new e1.a(this);
            }
            ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour = this.f23d;
            if (constraintWidget$DimensionBehaviour != ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT) {
                if (constraintWidget$DimensionBehaviour == ConstraintWidget$DimensionBehaviour.MATCH_PARENT && (fVar4 = this.f21b.V) != null && fVar4.U[1] == ConstraintWidget$DimensionBehaviour.FIXED) {
                    int iL = (fVar4.l() - this.f21b.K.e()) - this.f21b.M.e();
                    AbstractC0007h.m15b(c0000a2, fVar4.e.f27h, this.f21b.K.e());
                    AbstractC0007h.m15b(c0000a, fVar4.e.f28i, -this.f21b.M.e());
                    c0001b.mo3d(iL);
                    return;
                }
                if (constraintWidget$DimensionBehaviour == ConstraintWidget$DimensionBehaviour.FIXED) {
                    c0001b.mo3d(this.f21b.l());
                }
            }
        } else if (this.f23d == ConstraintWidget$DimensionBehaviour.MATCH_PARENT && (fVar2 = (fVar = this.f21b).V) != null && fVar2.U[1] == ConstraintWidget$DimensionBehaviour.FIXED) {
            AbstractC0007h.m15b(c0000a2, fVar2.e.f27h, fVar.K.e());
            AbstractC0007h.m15b(c0000a, fVar2.e.f28i, -this.f21b.M.e());
            return;
        }
        boolean z3 = c0001b.f11j;
        C0000a c0000a3 = this.f18k;
        if (z3) {
            d1.f fVar7 = this.f21b;
            if (fVar7.a) {
                d1.d[] dVarArr = fVar7.R;
                d1.d dVar = dVarArr[2];
                d1.d dVar2 = dVar.f;
                if (dVar2 != null && dVarArr[3].f != null) {
                    if (fVar7.z()) {
                        c0000a2.f7f = this.f21b.R[2].e();
                        c0000a.f7f = -this.f21b.R[3].e();
                    } else {
                        C0000a c0000aM16h = AbstractC0007h.m16h(this.f21b.R[2]);
                        if (c0000aM16h != null) {
                            AbstractC0007h.m15b(c0000a2, c0000aM16h, this.f21b.R[2].e());
                        }
                        C0000a c0000aM16h2 = AbstractC0007h.m16h(this.f21b.R[3]);
                        if (c0000aM16h2 != null) {
                            AbstractC0007h.m15b(c0000a, c0000aM16h2, -this.f21b.R[3].e());
                        }
                        c0000a2.f3b = true;
                        c0000a.f3b = true;
                    }
                    d1.f fVar8 = this.f21b;
                    if (fVar8.E) {
                        AbstractC0007h.m15b(c0000a3, c0000a2, fVar8.c0);
                        return;
                    }
                    return;
                }
                if (dVar2 != null) {
                    C0000a c0000aM16h3 = AbstractC0007h.m16h(dVar);
                    if (c0000aM16h3 != null) {
                        AbstractC0007h.m15b(c0000a2, c0000aM16h3, this.f21b.R[2].e());
                        AbstractC0007h.m15b(c0000a, c0000a2, c0001b.f8g);
                        d1.f fVar9 = this.f21b;
                        if (fVar9.E) {
                            AbstractC0007h.m15b(c0000a3, c0000a2, fVar9.c0);
                            return;
                        }
                        return;
                    }
                    return;
                }
                d1.d dVar3 = dVarArr[3];
                if (dVar3.f != null) {
                    C0000a c0000aM16h4 = AbstractC0007h.m16h(dVar3);
                    if (c0000aM16h4 != null) {
                        AbstractC0007h.m15b(c0000a, c0000aM16h4, -this.f21b.R[3].e());
                        AbstractC0007h.m15b(c0000a2, c0000a, -c0001b.f8g);
                    }
                    d1.f fVar10 = this.f21b;
                    if (fVar10.E) {
                        AbstractC0007h.m15b(c0000a3, c0000a2, fVar10.c0);
                        return;
                    }
                    return;
                }
                d1.d dVar4 = dVarArr[4];
                if (dVar4.f != null) {
                    C0000a c0000aM16h5 = AbstractC0007h.m16h(dVar4);
                    if (c0000aM16h5 != null) {
                        AbstractC0007h.m15b(c0000a3, c0000aM16h5, 0);
                        AbstractC0007h.m15b(c0000a2, c0000a3, -this.f21b.c0);
                        AbstractC0007h.m15b(c0000a, c0000a2, c0001b.f8g);
                        return;
                    }
                    return;
                }
                if ((fVar7 instanceof l) || fVar7.V == null || fVar7.j(ConstraintAnchor$Type.CENTER).f != null) {
                    return;
                }
                d1.f fVar11 = this.f21b;
                AbstractC0007h.m15b(c0000a2, fVar11.V.e.f27h, fVar11.t());
                AbstractC0007h.m15b(c0000a, c0000a2, c0001b.f8g);
                d1.f fVar12 = this.f21b;
                if (fVar12.E) {
                    AbstractC0007h.m15b(c0000a3, c0000a2, fVar12.c0);
                    return;
                }
                return;
            }
        }
        if (z3 || this.f23d != ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT) {
            c0001b.m1b(this);
        } else {
            d1.f fVar13 = this.f21b;
            int i = fVar13.s;
            if (i == 2) {
                d1.f fVar14 = fVar13.V;
                if (fVar14 != null) {
                    C0001b c0001b2 = fVar14.e.f24e;
                    c0001b.f13l.add(c0001b2);
                    c0001b2.f12k.add(c0001b);
                    c0001b.f3b = true;
                    c0001b.f12k.add(c0000a2);
                    c0001b.f12k.add(c0000a);
                }
            } else if (i == 3 && !fVar13.z()) {
                d1.f fVar15 = this.f21b;
                if (fVar15.r != 3) {
                    C0001b c0001b3 = fVar15.d.f24e;
                    c0001b.f13l.add(c0001b3);
                    c0001b3.f12k.add(c0001b);
                    c0001b.f3b = true;
                    c0001b.f12k.add(c0000a2);
                    c0001b.f12k.add(c0000a);
                }
            }
        }
        d1.f fVar16 = this.f21b;
        d1.d[] dVarArr2 = fVar16.R;
        d1.d dVar5 = dVarArr2[2];
        d1.d dVar6 = dVar5.f;
        if (dVar6 != null && dVarArr2[3].f != null) {
            if (fVar16.z()) {
                c0000a2.f7f = this.f21b.R[2].e();
                c0000a.f7f = -this.f21b.R[3].e();
            } else {
                C0000a c0000aM16h6 = AbstractC0007h.m16h(this.f21b.R[2]);
                C0000a c0000aM16h7 = AbstractC0007h.m16h(this.f21b.R[3]);
                if (c0000aM16h6 != null) {
                    c0000aM16h6.m1b(this);
                }
                if (c0000aM16h7 != null) {
                    c0000aM16h7.m1b(this);
                }
                this.f29j = WidgetRun$RunType.CENTER;
            }
            if (this.f21b.E) {
                m18c(c0000a3, c0000a2, 1, this.f19l);
            }
        } else if (dVar6 != null) {
            C0000a c0000aM16h8 = AbstractC0007h.m16h(dVar5);
            if (c0000aM16h8 != null) {
                AbstractC0007h.m15b(c0000a2, c0000aM16h8, this.f21b.R[2].e());
                m18c(c0000a, c0000a2, 1, c0001b);
                if (this.f21b.E) {
                    m18c(c0000a3, c0000a2, 1, this.f19l);
                }
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour2 = this.f23d;
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour3 = ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT;
                if (constraintWidget$DimensionBehaviour2 == constraintWidget$DimensionBehaviour3) {
                    d1.f fVar17 = this.f21b;
                    if (fVar17.Y > 0.0f) {
                        C0004e c0004e = fVar17.d;
                        if (c0004e.f23d == constraintWidget$DimensionBehaviour3) {
                            c0004e.f24e.f12k.add(c0001b);
                            c0001b.f13l.add(this.f21b.d.f24e);
                            c0001b.f2a = this;
                        }
                    }
                }
            }
        } else {
            d1.d dVar7 = dVarArr2[3];
            if (dVar7.f != null) {
                C0000a c0000aM16h9 = AbstractC0007h.m16h(dVar7);
                if (c0000aM16h9 != null) {
                    AbstractC0007h.m15b(c0000a, c0000aM16h9, -this.f21b.R[3].e());
                    m18c(c0000a2, c0000a, -1, c0001b);
                    if (this.f21b.E) {
                        m18c(c0000a3, c0000a2, 1, this.f19l);
                    }
                }
            } else {
                d1.d dVar8 = dVarArr2[4];
                if (dVar8.f != null) {
                    C0000a c0000aM16h10 = AbstractC0007h.m16h(dVar8);
                    if (c0000aM16h10 != null) {
                        AbstractC0007h.m15b(c0000a3, c0000aM16h10, 0);
                        m18c(c0000a2, c0000a3, -1, this.f19l);
                        m18c(c0000a, c0000a2, 1, c0001b);
                    }
                } else if (!(fVar16 instanceof l) && (fVar3 = fVar16.V) != null) {
                    AbstractC0007h.m15b(c0000a2, fVar3.e.f27h, fVar16.t());
                    m18c(c0000a, c0000a2, 1, c0001b);
                    if (this.f21b.E) {
                        m18c(c0000a3, c0000a2, 1, this.f19l);
                    }
                    ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour4 = this.f23d;
                    ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour5 = ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT;
                    if (constraintWidget$DimensionBehaviour4 == constraintWidget$DimensionBehaviour5) {
                        d1.f fVar18 = this.f21b;
                        if (fVar18.Y > 0.0f) {
                            C0004e c0004e2 = fVar18.d;
                            if (c0004e2.f23d == constraintWidget$DimensionBehaviour5) {
                                c0004e2.f24e.f12k.add(c0001b);
                                c0001b.f13l.add(this.f21b.d.f24e);
                                c0001b.f2a = this;
                            }
                        }
                    }
                }
            }
        }
        if (c0001b.f13l.size() == 0) {
            c0001b.f4c = true;
        }
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: e */
    public final void mo6e() {
        C0000a c0000a = this.f27h;
        if (c0000a.f11j) {
            this.f21b.b0 = c0000a.f8g;
        }
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: f */
    public final void mo7f() {
        this.f22c = null;
        this.f27h.m2c();
        this.f28i.m2c();
        this.f18k.m2c();
        this.f24e.m2c();
        this.f26g = false;
    }

    @Override // androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h
    /* JADX INFO: renamed from: k */
    public final boolean mo8k() {
        return this.f23d != ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT || this.f21b.s == 0;
    }

    /* JADX INFO: renamed from: m */
    public final void m14m() {
        this.f26g = false;
        C0000a c0000a = this.f27h;
        c0000a.m2c();
        c0000a.f11j = false;
        C0000a c0000a2 = this.f28i;
        c0000a2.m2c();
        c0000a2.f11j = false;
        C0000a c0000a3 = this.f18k;
        c0000a3.m2c();
        c0000a3.f11j = false;
        this.f24e.f11j = false;
    }

    public final String toString() {
        return "VerticalRun " + this.f21b.k0;
    }
}
