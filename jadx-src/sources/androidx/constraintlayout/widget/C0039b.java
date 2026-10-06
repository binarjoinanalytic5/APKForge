package androidx.constraintlayout.widget;

import android.view.View;
import android.view.ViewGroup;
import androidx.constraintlayout.core.widgets.ConstraintWidget$DimensionBehaviour;
import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import d1.f;
import d1.g;
import d1.m;
import d1.o;

/* JADX INFO: renamed from: androidx.constraintlayout.widget.b */
/* JADX INFO: loaded from: classes.dex */
public final class C0039b implements e1.c {

    /* JADX INFO: renamed from: a */
    public final ConstraintLayout f532a;

    /* JADX INFO: renamed from: b */
    public int f533b;

    /* JADX INFO: renamed from: c */
    public int f534c;

    /* JADX INFO: renamed from: d */
    public int f535d;

    /* JADX INFO: renamed from: e */
    public int f536e;

    /* JADX INFO: renamed from: f */
    public int f537f;

    /* JADX INFO: renamed from: g */
    public int f538g;

    /* JADX INFO: renamed from: h */
    public final /* synthetic */ ConstraintLayout f539h;

    public C0039b(ConstraintLayout constraintLayout, ConstraintLayout constraintLayout2) {
        this.f539h = constraintLayout;
        this.f532a = constraintLayout2;
    }

    /* JADX INFO: renamed from: a */
    public static boolean m119a(int i, int i2, int i3) {
        if (i == i2) {
            return true;
        }
        int mode = View.MeasureSpec.getMode(i);
        View.MeasureSpec.getSize(i);
        int mode2 = View.MeasureSpec.getMode(i2);
        int size = View.MeasureSpec.getSize(i2);
        if (mode2 == 1073741824) {
            return (mode == Integer.MIN_VALUE || mode == 0) && i3 == size;
        }
        return false;
    }

    /* JADX INFO: renamed from: b */
    public final void m120b(f fVar, e1.b bVar) {
        int iMakeMeasureSpec;
        int iMakeMeasureSpec2;
        int iMax;
        int iMax2;
        int i;
        boolean z;
        int baseline;
        int i2;
        int childMeasureSpec;
        if (fVar == null) {
            return;
        }
        if (fVar.i0 == 8 && !fVar.F) {
            bVar.e = 0;
            bVar.f = 0;
            bVar.g = 0;
            return;
        }
        if (fVar.V == null) {
            return;
        }
        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour = bVar.a;
        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour2 = bVar.b;
        int i3 = bVar.c;
        int i4 = bVar.d;
        int i5 = this.f533b + this.f534c;
        int i6 = this.f535d;
        View view = fVar.h0;
        int[] iArr = j1.c.a;
        int i7 = iArr[constraintWidget$DimensionBehaviour.ordinal()];
        d1.d dVar = fVar.L;
        d1.d dVar2 = fVar.J;
        if (i7 != 1) {
            if (i7 == 2) {
                childMeasureSpec = ViewGroup.getChildMeasureSpec(this.f537f, i6, -2);
            } else if (i7 == 3) {
                int i8 = this.f537f;
                int i9 = dVar2 != null ? dVar2.g : 0;
                if (dVar != null) {
                    i9 += dVar.g;
                }
                childMeasureSpec = ViewGroup.getChildMeasureSpec(i8, i6 + i9, -1);
            } else if (i7 != 4) {
                iMakeMeasureSpec = 0;
            } else {
                iMakeMeasureSpec = ViewGroup.getChildMeasureSpec(this.f537f, i6, -2);
                boolean z2 = fVar.r == 1;
                int i10 = bVar.j;
                if (i10 == 1 || i10 == 2) {
                    boolean z3 = view.getMeasuredHeight() == fVar.l();
                    if (bVar.j == 2 || !z2 || ((z2 && z3) || (view instanceof Placeholder) || fVar.B())) {
                        childMeasureSpec = View.MeasureSpec.makeMeasureSpec(fVar.r(), BasicMeasure.EXACTLY);
                    }
                }
            }
            iMakeMeasureSpec = childMeasureSpec;
        } else {
            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(i3, BasicMeasure.EXACTLY);
        }
        int i11 = iArr[constraintWidget$DimensionBehaviour2.ordinal()];
        if (i11 == 1) {
            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(i4, BasicMeasure.EXACTLY);
        } else if (i11 == 2) {
            iMakeMeasureSpec2 = ViewGroup.getChildMeasureSpec(this.f538g, i5, -2);
        } else if (i11 == 3) {
            int i12 = this.f538g;
            int i13 = dVar2 != null ? fVar.K.g : 0;
            if (dVar != null) {
                i13 += fVar.M.g;
            }
            iMakeMeasureSpec2 = ViewGroup.getChildMeasureSpec(i12, i5 + i13, -1);
        } else if (i11 != 4) {
            iMakeMeasureSpec2 = 0;
        } else {
            iMakeMeasureSpec2 = ViewGroup.getChildMeasureSpec(this.f538g, i5, -2);
            boolean z4 = fVar.s == 1;
            int i14 = bVar.j;
            if (i14 == 1 || i14 == 2) {
                boolean z5 = view.getMeasuredWidth() == fVar.r();
                if (bVar.j == 2 || !z4 || ((z4 && z5) || (view instanceof Placeholder) || fVar.C())) {
                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(fVar.l(), BasicMeasure.EXACTLY);
                }
            }
        }
        g gVar = fVar.V;
        ConstraintLayout constraintLayout = this.f539h;
        if (gVar != null && m.c(constraintLayout.f364i, 256) && view.getMeasuredWidth() == fVar.r() && view.getMeasuredWidth() < gVar.r() && view.getMeasuredHeight() == fVar.l() && view.getMeasuredHeight() < gVar.l() && view.getBaseline() == fVar.c0 && !fVar.A() && m119a(fVar.H, iMakeMeasureSpec, fVar.r()) && m119a(fVar.I, iMakeMeasureSpec2, fVar.l())) {
            bVar.e = fVar.r();
            bVar.f = fVar.l();
            bVar.g = fVar.c0;
            return;
        }
        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour3 = ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT;
        boolean z6 = constraintWidget$DimensionBehaviour == constraintWidget$DimensionBehaviour3;
        boolean z7 = constraintWidget$DimensionBehaviour2 == constraintWidget$DimensionBehaviour3;
        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour4 = ConstraintWidget$DimensionBehaviour.MATCH_PARENT;
        boolean z8 = constraintWidget$DimensionBehaviour2 == constraintWidget$DimensionBehaviour4 || constraintWidget$DimensionBehaviour2 == ConstraintWidget$DimensionBehaviour.FIXED;
        boolean z9 = constraintWidget$DimensionBehaviour == constraintWidget$DimensionBehaviour4 || constraintWidget$DimensionBehaviour == ConstraintWidget$DimensionBehaviour.FIXED;
        boolean z10 = z6 && fVar.Y > 0.0f;
        boolean z11 = z7 && fVar.Y > 0.0f;
        if (view == null) {
            return;
        }
        ConstraintLayout.LayoutParams layoutParams = (ConstraintLayout.LayoutParams) view.getLayoutParams();
        int i15 = bVar.j;
        if (i15 != 1 && i15 != 2 && z6 && fVar.r == 0 && z7 && fVar.s == 0) {
            baseline = 0;
            i2 = -1;
            z = false;
            iMax = 0;
            iMax2 = 0;
        } else {
            if ((view instanceof VirtualLayout) && (fVar instanceof o)) {
                ((VirtualLayout) view).mo29r((o) fVar, iMakeMeasureSpec, iMakeMeasureSpec2);
            } else {
                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
            }
            fVar.H = iMakeMeasureSpec;
            fVar.I = iMakeMeasureSpec2;
            fVar.g = false;
            int measuredWidth = view.getMeasuredWidth();
            int measuredHeight = view.getMeasuredHeight();
            int baseline2 = view.getBaseline();
            int i16 = fVar.u;
            iMax = i16 > 0 ? Math.max(i16, measuredWidth) : measuredWidth;
            int i17 = fVar.v;
            if (i17 > 0) {
                iMax = Math.min(i17, iMax);
            }
            int i18 = fVar.x;
            iMax2 = i18 > 0 ? Math.max(i18, measuredHeight) : measuredHeight;
            int i19 = fVar.y;
            if (i19 > 0) {
                iMax2 = Math.min(i19, iMax2);
            }
            if (!m.c(constraintLayout.f364i, 1)) {
                if (z10 && z8) {
                    iMax = (int) ((iMax2 * fVar.Y) + 0.5f);
                } else if (z11 && z9) {
                    iMax2 = (int) ((iMax / fVar.Y) + 0.5f);
                }
            }
            if (measuredWidth == iMax && measuredHeight == iMax2) {
                baseline = baseline2;
                i2 = -1;
                z = false;
            } else {
                if (measuredWidth != iMax) {
                    i = BasicMeasure.EXACTLY;
                    iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMax, BasicMeasure.EXACTLY);
                } else {
                    i = BasicMeasure.EXACTLY;
                }
                int iMakeMeasureSpec3 = measuredHeight != iMax2 ? View.MeasureSpec.makeMeasureSpec(iMax2, i) : iMakeMeasureSpec2;
                view.measure(iMakeMeasureSpec, iMakeMeasureSpec3);
                fVar.H = iMakeMeasureSpec;
                fVar.I = iMakeMeasureSpec3;
                z = false;
                fVar.g = false;
                iMax = view.getMeasuredWidth();
                iMax2 = view.getMeasuredHeight();
                baseline = view.getBaseline();
                i2 = -1;
            }
        }
        boolean z12 = baseline != i2 ? true : z;
        bVar.i = (iMax == bVar.c && iMax2 == bVar.d) ? z : true;
        boolean z13 = layoutParams.f405c0 ? true : z12;
        if (z13 && baseline != -1 && fVar.c0 != baseline) {
            bVar.i = true;
        }
        bVar.e = iMax;
        bVar.f = iMax2;
        bVar.h = z13;
        bVar.g = baseline;
    }
}
