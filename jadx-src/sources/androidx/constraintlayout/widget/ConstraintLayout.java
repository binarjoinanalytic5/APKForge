package androidx.constraintlayout.widget;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.core.widgets.ConstraintAnchor$Type;
import androidx.constraintlayout.core.widgets.ConstraintWidget$DimensionBehaviour;
import androidx.constraintlayout.core.widgets.analyzer.AbstractC0007h;
import androidx.constraintlayout.core.widgets.analyzer.C0004e;
import androidx.constraintlayout.core.widgets.analyzer.C0006g;
import androidx.constraintlayout.solver.widgets.ConstraintWidget;
import androidx.constraintlayout.solver.widgets.Optimizer;
import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import androidx.work.impl.model.v;
import com.google.firebase.messaging.C0082o;
import d1.f;
import d1.g;
import d1.k;
import d1.l;
import e1.h;
import j1.m;
import j1.o;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;

/* JADX INFO: loaded from: classes.dex */
public class ConstraintLayout extends ViewGroup {

    /* JADX INFO: renamed from: r */
    public static o f355r;

    /* JADX INFO: renamed from: a */
    public SparseArray f356a;

    /* JADX INFO: renamed from: b */
    public ArrayList f357b;

    /* JADX INFO: renamed from: c */
    public g f358c;

    /* JADX INFO: renamed from: d */
    public int f359d;

    /* JADX INFO: renamed from: e */
    public int f360e;

    /* JADX INFO: renamed from: f */
    public int f361f;

    /* JADX INFO: renamed from: g */
    public int f362g;

    /* JADX INFO: renamed from: h */
    public boolean f363h;

    /* JADX INFO: renamed from: i */
    public int f364i;

    /* JADX INFO: renamed from: j */
    public C0041d f365j;

    /* JADX INFO: renamed from: k */
    public C0082o f366k;

    /* JADX INFO: renamed from: l */
    public int f367l;

    /* JADX INFO: renamed from: m */
    public HashMap f368m;

    /* JADX INFO: renamed from: n */
    public SparseArray f369n;

    /* JADX INFO: renamed from: o */
    public C0039b f370o;

    /* JADX INFO: renamed from: p */
    public int f371p;

    /* JADX INFO: renamed from: q */
    public int f372q;

    public ConstraintLayout(@NonNull Context context, @Nullable AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f356a = new SparseArray();
        this.f357b = new ArrayList(4);
        this.f358c = new g();
        this.f359d = 0;
        this.f360e = 0;
        this.f361f = Integer.MAX_VALUE;
        this.f362g = Integer.MAX_VALUE;
        this.f363h = true;
        this.f364i = 257;
        this.f365j = null;
        this.f366k = null;
        this.f367l = -1;
        this.f368m = new HashMap();
        this.f369n = new SparseArray();
        this.f370o = new C0039b(this, this);
        this.f371p = 0;
        this.f372q = 0;
        m111k(attributeSet, 0);
    }

    private int getPaddingWidth() {
        int iMax = Math.max(0, getPaddingRight()) + Math.max(0, getPaddingLeft());
        int iMax2 = Math.max(0, getPaddingEnd()) + Math.max(0, getPaddingStart());
        return iMax2 > 0 ? iMax2 : iMax;
    }

    public static o getSharedValues() {
        if (f355r == null) {
            f355r = new o();
        }
        return f355r;
    }

    /* JADX WARN: Code duplicated, block: B:152:0x02cf  */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:152:0x02cf -> B:153:0x02d0). Please report as a decompilation issue!!! */
    /* JADX INFO: renamed from: a */
    public final void m108a(boolean z, View view, f fVar, LayoutParams layoutParams, SparseArray sparseArray) {
        float f;
        f fVar2;
        f fVar3;
        f fVar4;
        f fVar5;
        int i;
        int i2;
        float fAbs;
        int i3;
        layoutParams.m116a();
        fVar.i0 = view.getVisibility();
        if (layoutParams.f411f0) {
            fVar.F = true;
            fVar.i0 = 8;
        }
        fVar.h0 = view;
        if (view instanceof ConstraintHelper) {
            ((ConstraintHelper) view).mo28m(fVar, this.f358c.z0);
        }
        int i4 = -1;
        if (layoutParams.f407d0) {
            k kVar = (k) fVar;
            int i5 = layoutParams.f427n0;
            int i6 = layoutParams.f429o0;
            float f2 = layoutParams.f431p0;
            if (f2 != -1.0f) {
                if (f2 > -1.0f) {
                    kVar.u0 = f2;
                    kVar.v0 = -1;
                    kVar.w0 = -1;
                    return;
                }
                return;
            }
            if (i5 != -1) {
                if (i5 > -1) {
                    kVar.u0 = -1.0f;
                    kVar.v0 = i5;
                    kVar.w0 = -1;
                    return;
                }
                return;
            }
            if (i6 == -1 || i6 <= -1) {
                return;
            }
            kVar.u0 = -1.0f;
            kVar.v0 = -1;
            kVar.w0 = i6;
            return;
        }
        int i7 = layoutParams.f413g0;
        int i8 = layoutParams.f415h0;
        int i9 = layoutParams.f417i0;
        int i10 = layoutParams.f419j0;
        int i11 = layoutParams.f421k0;
        int i12 = layoutParams.f423l0;
        float f3 = layoutParams.f425m0;
        int i13 = layoutParams.f430p;
        if (i13 != -1) {
            f fVar6 = (f) sparseArray.get(i13);
            if (fVar6 != null) {
                float f4 = layoutParams.f434r;
                int i14 = layoutParams.f432q;
                ConstraintAnchor$Type constraintAnchor$Type = ConstraintAnchor$Type.CENTER;
                fVar.w(constraintAnchor$Type, fVar6, constraintAnchor$Type, i14, 0);
                fVar.D = f4;
            }
            f = 0.0f;
        } else {
            if (i7 != -1) {
                f fVar7 = (f) sparseArray.get(i7);
                if (fVar7 != null) {
                    ConstraintAnchor$Type constraintAnchor$Type2 = ConstraintAnchor$Type.LEFT;
                    f = 0.0f;
                    fVar.w(constraintAnchor$Type2, fVar7, constraintAnchor$Type2, ((ViewGroup.MarginLayoutParams) layoutParams).leftMargin, i11);
                } else {
                    f = 0.0f;
                }
            } else {
                f = 0.0f;
                if (i8 != -1 && (fVar2 = (f) sparseArray.get(i8)) != null) {
                    fVar.w(ConstraintAnchor$Type.LEFT, fVar2, ConstraintAnchor$Type.RIGHT, ((ViewGroup.MarginLayoutParams) layoutParams).leftMargin, i11);
                }
            }
            if (i9 != -1) {
                f fVar8 = (f) sparseArray.get(i9);
                if (fVar8 != null) {
                    fVar.w(ConstraintAnchor$Type.RIGHT, fVar8, ConstraintAnchor$Type.LEFT, ((ViewGroup.MarginLayoutParams) layoutParams).rightMargin, i12);
                }
            } else if (i10 != -1 && (fVar3 = (f) sparseArray.get(i10)) != null) {
                ConstraintAnchor$Type constraintAnchor$Type3 = ConstraintAnchor$Type.RIGHT;
                fVar.w(constraintAnchor$Type3, fVar3, constraintAnchor$Type3, ((ViewGroup.MarginLayoutParams) layoutParams).rightMargin, i12);
            }
            int i15 = layoutParams.f416i;
            if (i15 != -1) {
                f fVar9 = (f) sparseArray.get(i15);
                if (fVar9 != null) {
                    ConstraintAnchor$Type constraintAnchor$Type4 = ConstraintAnchor$Type.TOP;
                    fVar.w(constraintAnchor$Type4, fVar9, constraintAnchor$Type4, ((ViewGroup.MarginLayoutParams) layoutParams).topMargin, layoutParams.f440x);
                }
            } else {
                int i16 = layoutParams.f418j;
                if (i16 != -1 && (fVar4 = (f) sparseArray.get(i16)) != null) {
                    fVar.w(ConstraintAnchor$Type.TOP, fVar4, ConstraintAnchor$Type.BOTTOM, ((ViewGroup.MarginLayoutParams) layoutParams).topMargin, layoutParams.f440x);
                }
            }
            int i17 = layoutParams.f420k;
            if (i17 != -1) {
                f fVar10 = (f) sparseArray.get(i17);
                if (fVar10 != null) {
                    fVar.w(ConstraintAnchor$Type.BOTTOM, fVar10, ConstraintAnchor$Type.TOP, ((ViewGroup.MarginLayoutParams) layoutParams).bottomMargin, layoutParams.f442z);
                }
            } else {
                int i18 = layoutParams.f422l;
                if (i18 != -1 && (fVar5 = (f) sparseArray.get(i18)) != null) {
                    ConstraintAnchor$Type constraintAnchor$Type5 = ConstraintAnchor$Type.BOTTOM;
                    fVar.w(constraintAnchor$Type5, fVar5, constraintAnchor$Type5, ((ViewGroup.MarginLayoutParams) layoutParams).bottomMargin, layoutParams.f442z);
                }
            }
            int i19 = layoutParams.f424m;
            if (i19 != -1) {
                m115p(fVar, layoutParams, sparseArray, i19, ConstraintAnchor$Type.BASELINE);
            } else {
                int i20 = layoutParams.f426n;
                if (i20 != -1) {
                    m115p(fVar, layoutParams, sparseArray, i20, ConstraintAnchor$Type.TOP);
                } else {
                    int i21 = layoutParams.f428o;
                    if (i21 != -1) {
                        m115p(fVar, layoutParams, sparseArray, i21, ConstraintAnchor$Type.BOTTOM);
                    }
                }
            }
            if (f3 >= f) {
                fVar.f0 = f3;
            }
            float f5 = layoutParams.f379F;
            if (f5 >= f) {
                fVar.g0 = f5;
            }
        }
        if (z && ((i3 = layoutParams.f393T) != -1 || layoutParams.f394U != -1)) {
            int i22 = layoutParams.f394U;
            fVar.a0 = i3;
            fVar.b0 = i22;
        }
        if (layoutParams.f401a0) {
            fVar.N(ConstraintWidget$DimensionBehaviour.FIXED);
            fVar.P(((ViewGroup.MarginLayoutParams) layoutParams).width);
            if (((ViewGroup.MarginLayoutParams) layoutParams).width == -2) {
                fVar.N(ConstraintWidget$DimensionBehaviour.WRAP_CONTENT);
            }
        } else if (((ViewGroup.MarginLayoutParams) layoutParams).width == -1) {
            if (layoutParams.f396W) {
                fVar.N(ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT);
            } else {
                fVar.N(ConstraintWidget$DimensionBehaviour.MATCH_PARENT);
            }
            fVar.j(ConstraintAnchor$Type.LEFT).g = ((ViewGroup.MarginLayoutParams) layoutParams).leftMargin;
            fVar.j(ConstraintAnchor$Type.RIGHT).g = ((ViewGroup.MarginLayoutParams) layoutParams).rightMargin;
        } else {
            fVar.N(ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT);
            fVar.P(0);
        }
        if (layoutParams.f403b0) {
            fVar.O(ConstraintWidget$DimensionBehaviour.FIXED);
            fVar.M(((ViewGroup.MarginLayoutParams) layoutParams).height);
            if (((ViewGroup.MarginLayoutParams) layoutParams).height == -2) {
                fVar.O(ConstraintWidget$DimensionBehaviour.WRAP_CONTENT);
            }
        } else if (((ViewGroup.MarginLayoutParams) layoutParams).height == -1) {
            if (layoutParams.f397X) {
                fVar.O(ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT);
            } else {
                fVar.O(ConstraintWidget$DimensionBehaviour.MATCH_PARENT);
            }
            fVar.j(ConstraintAnchor$Type.TOP).g = ((ViewGroup.MarginLayoutParams) layoutParams).topMargin;
            fVar.j(ConstraintAnchor$Type.BOTTOM).g = ((ViewGroup.MarginLayoutParams) layoutParams).bottomMargin;
        } else {
            fVar.O(ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT);
            fVar.M(0);
        }
        String str = layoutParams.f380G;
        if (str == null || str.length() == 0) {
            fVar.Y = f;
        } else {
            int length = str.length();
            int iIndexOf = str.indexOf(44);
            if (iIndexOf <= 0 || iIndexOf >= length - 1) {
                i = 1;
                i2 = 0;
            } else {
                String strSubstring = str.substring(0, iIndexOf);
                if (strSubstring.equalsIgnoreCase("W")) {
                    i4 = 0;
                } else {
                    if (strSubstring.equalsIgnoreCase("H")) {
                        i = 1;
                        i4 = 1;
                    }
                    i2 = iIndexOf + i;
                }
                i = 1;
                i2 = iIndexOf + i;
            }
            int iIndexOf2 = str.indexOf(58);
            try {
                if (iIndexOf2 < 0 || iIndexOf2 >= length - i) {
                    String strSubstring2 = str.substring(i2);
                    if (strSubstring2.length() > 0) {
                        fAbs = Float.parseFloat(strSubstring2);
                    } else {
                        fAbs = f;
                    }
                } else {
                    String strSubstring3 = str.substring(i2, iIndexOf2);
                    String strSubstring4 = str.substring(iIndexOf2 + i);
                    if (strSubstring3.length() <= 0 || strSubstring4.length() <= 0) {
                        fAbs = f;
                    } else {
                        float f6 = Float.parseFloat(strSubstring3);
                        float f7 = Float.parseFloat(strSubstring4);
                        if (f6 <= f || f7 <= f) {
                            fAbs = f;
                        } else {
                            fAbs = i4 == 1 ? Math.abs(f7 / f6) : Math.abs(f6 / f7);
                        }
                    }
                }
            } catch (NumberFormatException unused) {
            }
            if (fAbs > f) {
                fVar.Y = fAbs;
                fVar.Z = i4;
            }
        }
        float f8 = layoutParams.f381H;
        float[] fArr = fVar.n0;
        fArr[0] = f8;
        fArr[1] = layoutParams.f382I;
        fVar.l0 = layoutParams.f383J;
        fVar.m0 = layoutParams.f384K;
        int i23 = layoutParams.f399Z;
        if (i23 >= 0 && i23 <= 3) {
            fVar.q = i23;
        }
        int i24 = layoutParams.f385L;
        int i25 = layoutParams.f387N;
        int i26 = layoutParams.f389P;
        float f9 = layoutParams.f391R;
        fVar.r = i24;
        fVar.u = i25;
        if (i26 == Integer.MAX_VALUE) {
            i26 = 0;
        }
        fVar.v = i26;
        fVar.w = f9;
        if (f9 > f && f9 < 1.0f && i24 == 0) {
            fVar.r = 2;
        }
        int i27 = layoutParams.f386M;
        int i28 = layoutParams.f388O;
        int i29 = layoutParams.f390Q;
        float f10 = layoutParams.f392S;
        fVar.s = i27;
        fVar.x = i28;
        fVar.y = i29 != Integer.MAX_VALUE ? i29 : 0;
        fVar.z = f10;
        if (f10 <= f || f10 >= 1.0f || i27 != 0) {
            return;
        }
        fVar.s = 2;
    }

    @Override // android.view.ViewGroup
    public final boolean checkLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return layoutParams instanceof LayoutParams;
    }

    @Override // android.view.ViewGroup, android.view.View
    public void dispatchDraw(Canvas canvas) {
        Object tag;
        int size;
        ArrayList arrayList = this.f357b;
        if (arrayList != null && (size = arrayList.size()) > 0) {
            for (int i = 0; i < size; i++) {
                ((ConstraintHelper) arrayList.get(i)).mo32o(this);
            }
        }
        super.dispatchDraw(canvas);
        if (isInEditMode()) {
            float width = getWidth();
            float height = getHeight();
            int childCount = getChildCount();
            for (int i2 = 0; i2 < childCount; i2++) {
                View childAt = getChildAt(i2);
                if (childAt.getVisibility() != 8 && (tag = childAt.getTag()) != null && (tag instanceof String)) {
                    String[] strArrSplit = ((String) tag).split(",");
                    if (strArrSplit.length == 4) {
                        int i3 = Integer.parseInt(strArrSplit[0]);
                        int i4 = Integer.parseInt(strArrSplit[1]);
                        int i5 = Integer.parseInt(strArrSplit[2]);
                        int i6 = (int) ((i3 / 1080.0f) * width);
                        int i7 = (int) ((i4 / 1920.0f) * height);
                        int i8 = (int) ((Integer.parseInt(strArrSplit[3]) / 1920.0f) * height);
                        Paint paint = new Paint();
                        paint.setColor(-65536);
                        float f = i6;
                        float f2 = i7;
                        float f3 = i6 + ((int) ((i5 / 1080.0f) * width));
                        canvas.drawLine(f, f2, f3, f2, paint);
                        float f4 = i7 + i8;
                        canvas.drawLine(f3, f2, f3, f4, paint);
                        canvas.drawLine(f3, f4, f, f4, paint);
                        canvas.drawLine(f, f4, f, f2, paint);
                        paint.setColor(-16711936);
                        canvas.drawLine(f, f2, f3, f4, paint);
                        canvas.drawLine(f, f4, f3, f2, paint);
                    }
                }
            }
        }
    }

    /* JADX INFO: renamed from: f */
    public final View m109f(int i) {
        return (View) this.f356a.get(i);
    }

    @Override // android.view.View
    public final void forceLayout() {
        this.f363h = true;
        super.forceLayout();
    }

    @Override // android.view.ViewGroup
    public final ViewGroup.LayoutParams generateDefaultLayoutParams() {
        return new LayoutParams(-2, -2);
    }

    @Override // android.view.ViewGroup
    public final ViewGroup.LayoutParams generateLayoutParams(AttributeSet attributeSet) {
        return new LayoutParams(getContext(), attributeSet);
    }

    public int getMaxHeight() {
        return this.f362g;
    }

    public int getMaxWidth() {
        return this.f361f;
    }

    public int getMinHeight() {
        return this.f360e;
    }

    public int getMinWidth() {
        return this.f359d;
    }

    public int getOptimizationLevel() {
        return this.f358c.H0;
    }

    public String getSceneString() {
        int id;
        StringBuilder sb = new StringBuilder();
        g gVar = this.f358c;
        if (((f) gVar).j == null) {
            int id2 = getId();
            if (id2 != -1) {
                ((f) gVar).j = getContext().getResources().getResourceEntryName(id2);
            } else {
                ((f) gVar).j = "parent";
            }
        }
        if (((f) gVar).k0 == null) {
            ((f) gVar).k0 = ((f) gVar).j;
        }
        for (f fVar : gVar.u0) {
            View view = fVar.h0;
            if (view != null) {
                if (fVar.j == null && (id = view.getId()) != -1) {
                    fVar.j = getContext().getResources().getResourceEntryName(id);
                }
                if (fVar.k0 == null) {
                    fVar.k0 = fVar.j;
                }
            }
        }
        gVar.o(sb);
        return sb.toString();
    }

    /* JADX INFO: renamed from: j */
    public final f m110j(View view) {
        if (view == this) {
            return this.f358c;
        }
        if (view == null) {
            return null;
        }
        if (view.getLayoutParams() instanceof LayoutParams) {
            return ((LayoutParams) view.getLayoutParams()).f433q0;
        }
        view.setLayoutParams(new LayoutParams(view.getLayoutParams()));
        if (view.getLayoutParams() instanceof LayoutParams) {
            return ((LayoutParams) view.getLayoutParams()).f433q0;
        }
        return null;
    }

    /* JADX INFO: renamed from: k */
    public final void m111k(AttributeSet attributeSet, int i) {
        g gVar = this.f358c;
        ((f) gVar).h0 = this;
        C0039b c0039b = this.f370o;
        gVar.y0 = c0039b;
        gVar.w0.f = c0039b;
        this.f356a.put(getId(), this);
        this.f365j = null;
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.c, i, 0);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i2 = 0; i2 < indexCount; i2++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i2);
                if (index == 16) {
                    this.f359d = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f359d);
                } else if (index == 17) {
                    this.f360e = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f360e);
                } else if (index == 14) {
                    this.f361f = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f361f);
                } else if (index == 15) {
                    this.f362g = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f362g);
                } else if (index == 113) {
                    this.f364i = typedArrayObtainStyledAttributes.getInt(index, this.f364i);
                } else if (index == 56) {
                    int resourceId = typedArrayObtainStyledAttributes.getResourceId(index, 0);
                    if (resourceId != 0) {
                        try {
                            mo56m(resourceId);
                        } catch (Resources.NotFoundException unused) {
                            this.f366k = null;
                        }
                    }
                } else if (index == 34) {
                    int resourceId2 = typedArrayObtainStyledAttributes.getResourceId(index, 0);
                    try {
                        C0041d c0041d = new C0041d();
                        this.f365j = c0041d;
                        c0041d.m145m(getContext(), resourceId2);
                    } catch (Resources.NotFoundException unused2) {
                        this.f365j = null;
                    }
                    this.f367l = resourceId2;
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
        gVar.H0 = this.f364i;
        a1.d.p = gVar.X(512);
    }

    /* JADX INFO: renamed from: l */
    public final boolean m112l() {
        return (getContext().getApplicationInfo().flags & 4194304) != 0 && 1 == getLayoutDirection();
    }

    /* JADX INFO: renamed from: m */
    public void mo56m(int i) {
        this.f366k = new C0082o(getContext(), this, i);
    }

    /* JADX INFO: renamed from: n */
    public final void m113n(int i, int i2, int i3, int i4, boolean z, boolean z2) {
        C0039b c0039b = this.f370o;
        int i5 = c0039b.f536e;
        int iResolveSizeAndState = View.resolveSizeAndState(i3 + c0039b.f535d, i, 0);
        int iResolveSizeAndState2 = View.resolveSizeAndState(i4 + i5, i2, 0) & 16777215;
        int iMin = Math.min(this.f361f, iResolveSizeAndState & 16777215);
        int iMin2 = Math.min(this.f362g, iResolveSizeAndState2);
        if (z) {
            iMin |= 16777216;
        }
        if (z2) {
            iMin2 |= 16777216;
        }
        setMeasuredDimension(iMin, iMin2);
    }

    /* JADX WARN: Code duplicated, block: B:276:0x04c5 A[PHI: r15
      0x04c5: PHI (r15v24 boolean) = (r15v23 boolean), (r15v23 boolean), (r15v23 boolean), (r15v27 boolean) binds: [B:254:0x0496, B:256:0x049c, B:258:0x04a0, B:274:0x04c2] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Code duplicated, block: B:30:0x00b6 A[PHI: r12
      0x00b6: PHI (r12v41 androidx.constraintlayout.core.widgets.ConstraintWidget$DimensionBehaviour) = 
      (r12v40 androidx.constraintlayout.core.widgets.ConstraintWidget$DimensionBehaviour)
      (r12v1 androidx.constraintlayout.core.widgets.ConstraintWidget$DimensionBehaviour)
     binds: [B:33:0x00c3, B:29:0x00b4] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX INFO: renamed from: o */
    public final void m114o(g gVar, int i, int i2, int i3) {
        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour;
        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour2;
        int i4;
        int iMin;
        int iMax;
        int iMax2;
        boolean z;
        e1.c cVar;
        int i5;
        boolean zU;
        int i6;
        g gVar2;
        ArrayList arrayList;
        int i7;
        e1.c cVar2;
        e1.c cVar3;
        boolean z2;
        C0004e c0004e;
        C0006g c0006g;
        int i8;
        int i9;
        int i10;
        boolean z3;
        boolean z4;
        int mode = View.MeasureSpec.getMode(i2);
        int size = View.MeasureSpec.getSize(i2);
        int mode2 = View.MeasureSpec.getMode(i3);
        int size2 = View.MeasureSpec.getSize(i3);
        int iMax3 = Math.max(0, getPaddingTop());
        int iMax4 = Math.max(0, getPaddingBottom());
        int i11 = iMax3 + iMax4;
        int paddingWidth = getPaddingWidth();
        C0039b c0039b = this.f370o;
        c0039b.f533b = iMax3;
        c0039b.f534c = iMax4;
        c0039b.f535d = paddingWidth;
        c0039b.f536e = i11;
        c0039b.f537f = i2;
        c0039b.f538g = i3;
        int iMax5 = Math.max(0, getPaddingStart());
        int iMax6 = Math.max(0, getPaddingEnd());
        if (iMax5 <= 0 && iMax6 <= 0) {
            iMax5 = Math.max(0, getPaddingLeft());
        } else if (m112l()) {
            iMax5 = iMax6;
        }
        int i12 = size - paddingWidth;
        int i13 = size2 - i11;
        int i14 = c0039b.f536e;
        int i15 = c0039b.f535d;
        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour3 = ConstraintWidget$DimensionBehaviour.FIXED;
        int childCount = getChildCount();
        if (mode == Integer.MIN_VALUE) {
            constraintWidget$DimensionBehaviour = ConstraintWidget$DimensionBehaviour.WRAP_CONTENT;
            if (childCount == 0) {
                iMax = Math.max(0, this.f359d);
                i4 = BasicMeasure.AT_MOST;
                int i16 = iMax;
                constraintWidget$DimensionBehaviour2 = constraintWidget$DimensionBehaviour;
                iMin = i16;
            } else {
                constraintWidget$DimensionBehaviour2 = constraintWidget$DimensionBehaviour;
                i4 = BasicMeasure.AT_MOST;
                iMin = i12;
            }
        } else if (mode != 0) {
            iMin = mode != 1073741824 ? 0 : Math.min(this.f361f - i15, i12);
            i4 = Integer.MIN_VALUE;
            constraintWidget$DimensionBehaviour2 = constraintWidget$DimensionBehaviour3;
        } else {
            constraintWidget$DimensionBehaviour = ConstraintWidget$DimensionBehaviour.WRAP_CONTENT;
            if (childCount == 0) {
                iMax = Math.max(0, this.f359d);
                i4 = BasicMeasure.AT_MOST;
                int i17 = iMax;
                constraintWidget$DimensionBehaviour2 = constraintWidget$DimensionBehaviour;
                iMin = i17;
            } else {
                iMin = 0;
                i4 = Integer.MIN_VALUE;
                constraintWidget$DimensionBehaviour2 = constraintWidget$DimensionBehaviour;
            }
        }
        if (mode2 == i4) {
            constraintWidget$DimensionBehaviour3 = ConstraintWidget$DimensionBehaviour.WRAP_CONTENT;
            iMax2 = childCount == 0 ? Math.max(0, this.f360e) : i13;
        } else if (mode2 == 0) {
            constraintWidget$DimensionBehaviour3 = ConstraintWidget$DimensionBehaviour.WRAP_CONTENT;
            if (childCount == 0) {
                iMax2 = Math.max(0, this.f360e);
            } else {
                iMax2 = 0;
            }
        } else if (mode2 != 1073741824) {
            iMax2 = 0;
        } else {
            iMax2 = Math.min(this.f362g - i14, i13);
        }
        int iR = gVar.r();
        e1.f fVar = gVar.w0;
        if (iMin != iR || iMax2 != gVar.l()) {
            fVar.c = true;
        }
        ((f) gVar).a0 = 0;
        ((f) gVar).b0 = 0;
        int i18 = this.f361f - i15;
        int[] iArr = ((f) gVar).C;
        iArr[0] = i18;
        iArr[1] = this.f362g - i14;
        ((f) gVar).d0 = 0;
        ((f) gVar).e0 = 0;
        gVar.N(constraintWidget$DimensionBehaviour2);
        gVar.P(iMin);
        gVar.O(constraintWidget$DimensionBehaviour3);
        gVar.M(iMax2);
        int i19 = this.f359d - i15;
        if (i19 < 0) {
            ((f) gVar).d0 = 0;
        } else {
            ((f) gVar).d0 = i19;
        }
        int i20 = this.f360e - i14;
        if (i20 < 0) {
            ((f) gVar).e0 = 0;
        } else {
            ((f) gVar).e0 = i20;
        }
        gVar.B0 = iMax5;
        gVar.C0 = iMax3;
        v vVar = gVar.v0;
        vVar.getClass();
        e1.c cVar4 = gVar.y0;
        int size3 = gVar.u0.size();
        int iR2 = gVar.r();
        int iL = gVar.l();
        boolean zC = d1.m.c(i, Optimizer.OPTIMIZATION_GRAPH_WRAP);
        boolean z5 = zC || d1.m.c(i, 64);
        if (z5) {
            for (int i21 = 0; i21 < size3; i21++) {
                f fVar2 = (f) gVar.u0.get(i21);
                ConstraintWidget$DimensionBehaviour[] constraintWidget$DimensionBehaviourArr = fVar2.U;
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour4 = constraintWidget$DimensionBehaviourArr[0];
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour5 = ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT;
                boolean z6 = (constraintWidget$DimensionBehaviour4 == constraintWidget$DimensionBehaviour5) && (constraintWidget$DimensionBehaviourArr[1] == constraintWidget$DimensionBehaviour5) && fVar2.Y > 0.0f;
                if ((fVar2.y() && z6) || ((fVar2.z() && z6) || (fVar2 instanceof d1.o) || fVar2.y() || fVar2.z())) {
                    z5 = false;
                    break;
                }
            }
        }
        boolean z7 = z5 & ((mode == 1073741824 && mode2 == 1073741824) || zC);
        if (z7) {
            int iMin2 = Math.min(((f) gVar).C[0], i12);
            int iMin3 = Math.min(((f) gVar).C[1], i13);
            if (mode == 1073741824 && gVar.r() != iMin2) {
                gVar.P(iMin2);
                gVar.w0.b = true;
            }
            if (mode2 == 1073741824 && gVar.l() != iMin3) {
                gVar.M(iMin3);
                gVar.w0.b = true;
            }
            if (mode == 1073741824 && mode2 == 1073741824) {
                boolean z8 = fVar.b;
                f fVar3 = fVar.a;
                if (z8 || fVar.c) {
                    for (f fVar4 : ((g) fVar3).u0) {
                        fVar4.i();
                        fVar4.a = false;
                        fVar4.d.m12n();
                        fVar4.e.m14m();
                    }
                    fVar3.i();
                    i10 = 0;
                    fVar3.a = false;
                    fVar3.d.m12n();
                    fVar3.e.m14m();
                    fVar.c = false;
                } else {
                    i10 = 0;
                }
                fVar.b(fVar.d);
                fVar3.a0 = i10;
                fVar3.b0 = i10;
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviourK = fVar3.k(i10);
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviourK2 = fVar3.k(1);
                if (fVar.b) {
                    fVar.c();
                }
                int iS = fVar3.s();
                int iT = fVar3.t();
                z = z7;
                fVar3.d.f27h.mo3d(iS);
                fVar3.e.f27h.mo3d(iT);
                fVar.g();
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour6 = ConstraintWidget$DimensionBehaviour.WRAP_CONTENT;
                cVar = cVar4;
                ArrayList<AbstractC0007h> arrayList2 = fVar.e;
                if (constraintWidget$DimensionBehaviourK == constraintWidget$DimensionBehaviour6 || constraintWidget$DimensionBehaviourK2 == constraintWidget$DimensionBehaviour6) {
                    if (zC) {
                        Iterator it = arrayList2.iterator();
                        while (it.hasNext()) {
                            if (!((AbstractC0007h) it.next()).mo8k()) {
                                zC = false;
                                break;
                            }
                        }
                    }
                    if (zC && constraintWidget$DimensionBehaviourK == ConstraintWidget$DimensionBehaviour.WRAP_CONTENT) {
                        fVar3.N(ConstraintWidget$DimensionBehaviour.FIXED);
                        fVar3.P(fVar.d(fVar3, 0));
                        fVar3.d.f24e.mo3d(fVar3.r());
                    }
                    if (zC && constraintWidget$DimensionBehaviourK2 == ConstraintWidget$DimensionBehaviour.WRAP_CONTENT) {
                        fVar3.O(ConstraintWidget$DimensionBehaviour.FIXED);
                        fVar3.M(fVar.d(fVar3, 1));
                        fVar3.e.f24e.mo3d(fVar3.l());
                    }
                } else {
                    iR2 = iR2;
                }
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour7 = fVar3.U[0];
                ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour8 = ConstraintWidget$DimensionBehaviour.FIXED;
                if (constraintWidget$DimensionBehaviour7 == constraintWidget$DimensionBehaviour8 || constraintWidget$DimensionBehaviour7 == ConstraintWidget$DimensionBehaviour.MATCH_PARENT) {
                    int iR3 = fVar3.r() + iS;
                    fVar3.d.f28i.mo3d(iR3);
                    fVar3.d.f24e.mo3d(iR3 - iS);
                    fVar.g();
                    ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour9 = fVar3.U[1];
                    if (constraintWidget$DimensionBehaviour9 == constraintWidget$DimensionBehaviour8 || constraintWidget$DimensionBehaviour9 == ConstraintWidget$DimensionBehaviour.MATCH_PARENT) {
                        int iL2 = fVar3.l() + iT;
                        fVar3.e.f28i.mo3d(iL2);
                        fVar3.e.f24e.mo3d(iL2 - iT);
                    }
                    fVar.g();
                    z3 = true;
                } else {
                    z3 = false;
                }
                for (AbstractC0007h abstractC0007h : arrayList2) {
                    if (abstractC0007h.f21b != fVar3 || abstractC0007h.f26g) {
                        abstractC0007h.mo6e();
                    }
                }
                Iterator it2 = arrayList2.iterator();
                while (true) {
                    if (!it2.hasNext()) {
                        z4 = true;
                        break;
                    }
                    AbstractC0007h abstractC0007h2 = (AbstractC0007h) it2.next();
                    if (z3 || abstractC0007h2.f21b != fVar3) {
                        if (!abstractC0007h2.f27h.f11j || ((!abstractC0007h2.f28i.f11j && !(abstractC0007h2 instanceof h)) || (!abstractC0007h2.f24e.f11j && !(abstractC0007h2 instanceof e1.d) && !(abstractC0007h2 instanceof h)))) {
                            z4 = false;
                            break;
                        }
                    }
                }
                fVar3.N(constraintWidget$DimensionBehaviourK);
                fVar3.O(constraintWidget$DimensionBehaviourK2);
                zU = z4;
                i9 = BasicMeasure.EXACTLY;
                i5 = 2;
            } else {
                z = z7;
                iR2 = iR2;
                cVar = cVar4;
                boolean z9 = fVar.b;
                g gVar3 = fVar.a;
                if (z9) {
                    for (f fVar5 : gVar3.u0) {
                        fVar5.i();
                        fVar5.a = false;
                        C0004e c0004e2 = fVar5.d;
                        c0004e2.f24e.f11j = false;
                        c0004e2.f26g = false;
                        c0004e2.m12n();
                        C0006g c0006g2 = fVar5.e;
                        c0006g2.f24e.f11j = false;
                        c0006g2.f26g = false;
                        c0006g2.m14m();
                    }
                    i8 = 0;
                    gVar3.i();
                    ((f) gVar3).a = false;
                    C0004e c0004e3 = ((f) gVar3).d;
                    c0004e3.f24e.f11j = false;
                    c0004e3.f26g = false;
                    c0004e3.m12n();
                    C0006g c0006g3 = ((f) gVar3).e;
                    c0006g3.f24e.f11j = false;
                    c0006g3.f26g = false;
                    c0006g3.m14m();
                    fVar.c();
                } else {
                    i8 = 0;
                }
                fVar.b(fVar.d);
                ((f) gVar3).a0 = i8;
                ((f) gVar3).b0 = i8;
                ((f) gVar3).d.f27h.mo3d(i8);
                ((f) gVar3).e.f27h.mo3d(i8);
                i9 = BasicMeasure.EXACTLY;
                if (mode == 1073741824) {
                    zU = gVar.U(i8, zC);
                    i5 = 1;
                } else {
                    i5 = 0;
                    zU = true;
                }
                if (mode2 == 1073741824) {
                    zU &= gVar.U(1, zC);
                    i5++;
                }
            }
            if (zU) {
                gVar.Q(mode == i9, mode2 == i9);
            }
        } else {
            z = z7;
            cVar = cVar4;
            iR2 = iR2;
            i5 = 0;
            zU = false;
        }
        if (zU && i5 == 2) {
            return;
        }
        int i22 = gVar.H0;
        if (size3 > 0) {
            int size4 = gVar.u0.size();
            boolean zX = gVar.X(64);
            e1.c cVar5 = gVar.y0;
            for (int i23 = 0; i23 < size4; i23++) {
                f fVar6 = (f) gVar.u0.get(i23);
                if (!(fVar6 instanceof k) && !(fVar6 instanceof d1.a) && !fVar6.G && (!zX || (c0004e = fVar6.d) == null || (c0006g = fVar6.e) == null || !c0004e.f24e.f11j || !c0006g.f24e.f11j)) {
                    ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviourK3 = fVar6.k(0);
                    ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviourK4 = fVar6.k(1);
                    ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour10 = ConstraintWidget$DimensionBehaviour.MATCH_CONSTRAINT;
                    boolean z10 = constraintWidget$DimensionBehaviourK3 == constraintWidget$DimensionBehaviour10 && fVar6.r != 1 && constraintWidget$DimensionBehaviourK4 == constraintWidget$DimensionBehaviour10 && fVar6.s != 1;
                    if (!z10 && gVar.X(1) && !(fVar6 instanceof d1.o)) {
                        if (constraintWidget$DimensionBehaviourK3 == constraintWidget$DimensionBehaviour10 && fVar6.r == 0 && constraintWidget$DimensionBehaviourK4 != constraintWidget$DimensionBehaviour10 && !fVar6.y()) {
                            z10 = true;
                        }
                        if (constraintWidget$DimensionBehaviourK4 == constraintWidget$DimensionBehaviour10 && fVar6.s == 0 && constraintWidget$DimensionBehaviourK3 != constraintWidget$DimensionBehaviour10 && !fVar6.y()) {
                            z10 = true;
                        }
                        if (constraintWidget$DimensionBehaviourK3 == constraintWidget$DimensionBehaviour10 || constraintWidget$DimensionBehaviourK4 == constraintWidget$DimensionBehaviour10) {
                            if (fVar6.Y > 0.0f) {
                                z10 = true;
                            }
                        }
                    }
                    if (!z10) {
                        vVar.h(0, fVar6, cVar5);
                    }
                }
            }
            ConstraintLayout constraintLayout = ((C0039b) cVar5).f532a;
            int childCount2 = constraintLayout.getChildCount();
            for (int i24 = 0; i24 < childCount2; i24++) {
                View childAt = constraintLayout.getChildAt(i24);
                if (childAt instanceof Placeholder) {
                    Placeholder placeholder = (Placeholder) childAt;
                    if (placeholder.f459b != null) {
                        LayoutParams layoutParams = (LayoutParams) placeholder.getLayoutParams();
                        LayoutParams layoutParams2 = (LayoutParams) placeholder.f459b.getLayoutParams();
                        f fVar7 = layoutParams2.f433q0;
                        fVar7.i0 = 0;
                        f fVar8 = layoutParams.f433q0;
                        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour11 = fVar8.U[0];
                        ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour12 = ConstraintWidget$DimensionBehaviour.FIXED;
                        if (constraintWidget$DimensionBehaviour11 != constraintWidget$DimensionBehaviour12) {
                            fVar8.P(fVar7.r());
                        }
                        f fVar9 = layoutParams.f433q0;
                        if (fVar9.U[1] != constraintWidget$DimensionBehaviour12) {
                            fVar9.M(layoutParams2.f433q0.l());
                        }
                        layoutParams2.f433q0.i0 = 8;
                    }
                }
            }
            ArrayList arrayList3 = constraintLayout.f357b;
            int size5 = arrayList3.size();
            if (size5 > 0) {
                for (int i25 = 0; i25 < size5; i25++) {
                    ((ConstraintHelper) arrayList3.get(i25)).getClass();
                }
            }
        }
        vVar.n(gVar);
        ArrayList arrayList4 = (ArrayList) vVar.a;
        int size6 = arrayList4.size();
        int i26 = iR2;
        if (size3 > 0) {
            vVar.m(gVar, 0, i26, iL);
        }
        if (size6 > 0) {
            ConstraintWidget$DimensionBehaviour[] constraintWidget$DimensionBehaviourArr2 = ((f) gVar).U;
            ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour13 = constraintWidget$DimensionBehaviourArr2[0];
            ConstraintWidget$DimensionBehaviour constraintWidget$DimensionBehaviour14 = ConstraintWidget$DimensionBehaviour.WRAP_CONTENT;
            boolean z11 = constraintWidget$DimensionBehaviour13 == constraintWidget$DimensionBehaviour14;
            boolean z12 = constraintWidget$DimensionBehaviourArr2[1] == constraintWidget$DimensionBehaviour14;
            int iR4 = gVar.r();
            g gVar4 = (g) vVar.c;
            int iMax7 = Math.max(iR4, ((f) gVar4).d0);
            int iMax8 = Math.max(gVar.l(), ((f) gVar4).e0);
            int i27 = 0;
            boolean z13 = false;
            while (i27 < size6) {
                d1.o oVar = (f) arrayList4.get(i27);
                if (oVar instanceof d1.o) {
                    int iR5 = oVar.r();
                    int iL3 = oVar.l();
                    cVar3 = cVar;
                    boolean zH = z13 | vVar.h(1, oVar, cVar3);
                    int iR6 = oVar.r();
                    int iL4 = oVar.l();
                    if (iR6 != iR5) {
                        oVar.P(iR6);
                        if (z11 && oVar.s() + ((f) oVar).W > iMax7) {
                            iMax7 = Math.max(iMax7, oVar.j(ConstraintAnchor$Type.RIGHT).e() + oVar.s() + ((f) oVar).W);
                        }
                        z2 = true;
                    } else {
                        z2 = zH;
                    }
                    if (iL4 != iL3) {
                        oVar.M(iL4);
                        if (z12 && oVar.t() + ((f) oVar).X > iMax8) {
                            iMax8 = Math.max(iMax8, oVar.j(ConstraintAnchor$Type.BOTTOM).e() + oVar.t() + ((f) oVar).X);
                        }
                        z2 = true;
                    }
                    z13 = oVar.C0 | z2;
                } else {
                    cVar3 = cVar;
                }
                i27++;
                cVar = cVar3;
                i22 = i22;
            }
            i6 = i22;
            e1.c cVar6 = cVar;
            int i28 = 2;
            int i29 = 0;
            while (i29 < i28) {
                int i30 = 0;
                while (i30 < size6) {
                    f fVar10 = (f) arrayList4.get(i30);
                    if ((!(fVar10 instanceof l) || (fVar10 instanceof d1.o)) && !(fVar10 instanceof k)) {
                        if (fVar10.i0 != 8 && ((!z || !fVar10.d.f24e.f11j || !fVar10.e.f24e.f11j) && !(fVar10 instanceof d1.o))) {
                            int iR7 = fVar10.r();
                            int iL5 = fVar10.l();
                            arrayList = arrayList4;
                            int i31 = fVar10.c0;
                            i7 = size6;
                            boolean zH2 = vVar.h(i29 == 1 ? 2 : 1, fVar10, cVar6) | z13;
                            int iR8 = fVar10.r();
                            cVar2 = cVar6;
                            int iL6 = fVar10.l();
                            if (iR8 != iR7) {
                                fVar10.P(iR8);
                                if (z11 && fVar10.s() + fVar10.W > iMax7) {
                                    iMax7 = Math.max(iMax7, fVar10.j(ConstraintAnchor$Type.RIGHT).e() + fVar10.s() + fVar10.W);
                                }
                                zH2 = true;
                            }
                            if (iL6 != iL5) {
                                fVar10.M(iL6);
                                if (z12 && fVar10.t() + fVar10.X > iMax8) {
                                    iMax8 = Math.max(iMax8, fVar10.j(ConstraintAnchor$Type.BOTTOM).e() + fVar10.t() + fVar10.X);
                                }
                                zH2 = true;
                            }
                            z13 = (!fVar10.E || i31 == fVar10.c0) ? zH2 : true;
                        }
                        i30++;
                        arrayList4 = arrayList;
                        size6 = i7;
                        cVar6 = cVar2;
                    }
                    cVar2 = cVar6;
                    arrayList = arrayList4;
                    i7 = size6;
                    i30++;
                    arrayList4 = arrayList;
                    size6 = i7;
                    cVar6 = cVar2;
                }
                e1.c cVar7 = cVar6;
                ArrayList arrayList5 = arrayList4;
                int i32 = size6;
                if (!z13) {
                    break;
                }
                i29++;
                cVar6 = cVar7;
                vVar.m(gVar, i29, i26, iL);
                arrayList4 = arrayList5;
                size6 = i32;
                i28 = 2;
                z13 = false;
            }
            gVar2 = gVar;
        } else {
            i6 = i22;
            gVar2 = gVar;
        }
        gVar2.H0 = i6;
        a1.d.p = gVar2.X(512);
    }

    @Override // android.view.ViewGroup, android.view.View
    public void onLayout(boolean z, int i, int i2, int i3, int i4) {
        View content;
        int childCount = getChildCount();
        boolean zIsInEditMode = isInEditMode();
        for (int i5 = 0; i5 < childCount; i5++) {
            View childAt = getChildAt(i5);
            LayoutParams layoutParams = (LayoutParams) childAt.getLayoutParams();
            f fVar = layoutParams.f433q0;
            if ((childAt.getVisibility() != 8 || layoutParams.f407d0 || layoutParams.f409e0 || zIsInEditMode) && !layoutParams.f411f0) {
                int iS = fVar.s();
                int iT = fVar.t();
                int iR = fVar.r() + iS;
                int iL = fVar.l() + iT;
                childAt.layout(iS, iT, iR, iL);
                if ((childAt instanceof Placeholder) && (content = ((Placeholder) childAt).getContent()) != null) {
                    content.setVisibility(0);
                    content.layout(iS, iT, iR, iL);
                }
            }
        }
        ArrayList arrayList = this.f357b;
        int size = arrayList.size();
        if (size > 0) {
            for (int i6 = 0; i6 < size; i6++) {
                ((ConstraintHelper) arrayList.get(i6)).mo31n();
            }
        }
    }

    @Override // android.view.View
    public void onMeasure(int i, int i2) {
        boolean z;
        f fVar;
        if (this.f371p == i) {
            int i3 = this.f372q;
        }
        int i4 = 0;
        if (!this.f363h) {
            int childCount = getChildCount();
            for (int i5 = 0; i5 < childCount; i5++) {
                if (getChildAt(i5).isLayoutRequested()) {
                    this.f363h = true;
                    break;
                }
            }
        }
        this.f371p = i;
        this.f372q = i2;
        boolean zM112l = m112l();
        f fVar2 = this.f358c;
        ((g) fVar2).z0 = zM112l;
        if (this.f363h) {
            this.f363h = false;
            int childCount2 = getChildCount();
            int i6 = 0;
            while (true) {
                if (i6 >= childCount2) {
                    z = false;
                    break;
                } else {
                    if (getChildAt(i6).isLayoutRequested()) {
                        z = true;
                        break;
                    }
                    i6++;
                }
            }
            if (z) {
                boolean zIsInEditMode = isInEditMode();
                int childCount3 = getChildCount();
                for (int i7 = 0; i7 < childCount3; i7++) {
                    f fVarM110j = m110j(getChildAt(i7));
                    if (fVarM110j != null) {
                        fVarM110j.D();
                    }
                }
                Object obj = null;
                if (zIsInEditMode) {
                    for (int i8 = 0; i8 < childCount3; i8++) {
                        View childAt = getChildAt(i8);
                        try {
                            String resourceName = getResources().getResourceName(childAt.getId());
                            Integer numValueOf = Integer.valueOf(childAt.getId());
                            if (resourceName instanceof String) {
                                if (this.f368m == null) {
                                    this.f368m = new HashMap();
                                }
                                int iIndexOf = resourceName.indexOf("/");
                                this.f368m.put(iIndexOf != -1 ? resourceName.substring(iIndexOf + 1) : resourceName, numValueOf);
                            }
                            int iIndexOf2 = resourceName.indexOf(47);
                            if (iIndexOf2 != -1) {
                                resourceName = resourceName.substring(iIndexOf2 + 1);
                            }
                            int id = childAt.getId();
                            if (id != 0) {
                                View viewFindViewById = (View) this.f356a.get(id);
                                if (viewFindViewById == null && (viewFindViewById = findViewById(id)) != null && viewFindViewById != this && viewFindViewById.getParent() == this) {
                                    onViewAdded(viewFindViewById);
                                }
                                fVar = viewFindViewById == this ? fVar2 : viewFindViewById == null ? null : ((LayoutParams) viewFindViewById.getLayoutParams()).f433q0;
                            }
                            fVar.k0 = resourceName;
                        } catch (Resources.NotFoundException unused) {
                        }
                    }
                }
                if (this.f367l != -1) {
                    for (int i9 = 0; i9 < childCount3; i9++) {
                        View childAt2 = getChildAt(i9);
                        if (childAt2.getId() == this.f367l && (childAt2 instanceof Constraints)) {
                            this.f365j = ((Constraints) childAt2).getConstraintSet();
                        }
                    }
                }
                C0041d c0041d = this.f365j;
                if (c0041d != null) {
                    c0041d.m138c(this);
                }
                ((g) fVar2).u0.clear();
                ArrayList arrayList = this.f357b;
                int size = arrayList.size();
                if (size > 0) {
                    int i10 = 0;
                    while (i10 < size) {
                        ConstraintHelper constraintHelper = (ConstraintHelper) arrayList.get(i10);
                        if (constraintHelper.isInEditMode()) {
                            constraintHelper.setIds(constraintHelper.f351e);
                        }
                        l lVar = constraintHelper.f350d;
                        if (lVar != null) {
                            lVar.v0 = i4;
                            Arrays.fill(lVar.u0, obj);
                            for (int i11 = i4; i11 < constraintHelper.f348b; i11++) {
                                int i12 = constraintHelper.f347a[i11];
                                View viewM109f = m109f(i12);
                                if (viewM109f == null) {
                                    Integer numValueOf2 = Integer.valueOf(i12);
                                    HashMap map = constraintHelper.f354h;
                                    String str = (String) map.get(numValueOf2);
                                    int iM104h = constraintHelper.m104h(this, str);
                                    if (iM104h != 0) {
                                        constraintHelper.f347a[i11] = iM104h;
                                        map.put(Integer.valueOf(iM104h), str);
                                        viewM109f = m109f(iM104h);
                                    }
                                }
                                View view = viewM109f;
                                if (view != null) {
                                    constraintHelper.f350d.S(m110j(view));
                                }
                            }
                            constraintHelper.f350d.U();
                        }
                        i10++;
                        obj = null;
                        i4 = 0;
                    }
                }
                for (int i13 = 0; i13 < childCount3; i13++) {
                    View childAt3 = getChildAt(i13);
                    if (childAt3 instanceof Placeholder) {
                        Placeholder placeholder = (Placeholder) childAt3;
                        if (placeholder.f458a == -1 && !placeholder.isInEditMode()) {
                            placeholder.setVisibility(placeholder.f460c);
                        }
                        View viewFindViewById2 = findViewById(placeholder.f458a);
                        placeholder.f459b = viewFindViewById2;
                        if (viewFindViewById2 != null) {
                            ((LayoutParams) viewFindViewById2.getLayoutParams()).f411f0 = true;
                            placeholder.f459b.setVisibility(0);
                            placeholder.setVisibility(0);
                        }
                    }
                }
                SparseArray sparseArray = this.f369n;
                sparseArray.clear();
                sparseArray.put(0, fVar2);
                sparseArray.put(getId(), fVar2);
                for (int i14 = 0; i14 < childCount3; i14++) {
                    View childAt4 = getChildAt(i14);
                    sparseArray.put(childAt4.getId(), m110j(childAt4));
                }
                for (int i15 = 0; i15 < childCount3; i15++) {
                    View childAt5 = getChildAt(i15);
                    f fVarM110j2 = m110j(childAt5);
                    if (fVarM110j2 != null) {
                        LayoutParams layoutParams = (LayoutParams) childAt5.getLayoutParams();
                        ((g) fVar2).u0.add(fVarM110j2);
                        g gVar = fVarM110j2.V;
                        if (gVar != null) {
                            gVar.u0.remove(fVarM110j2);
                            fVarM110j2.D();
                        }
                        fVarM110j2.V = fVar2;
                        m108a(zIsInEditMode, childAt5, fVarM110j2, layoutParams, sparseArray);
                    }
                }
            }
            if (z) {
                ((g) fVar2).v0.n(fVar2);
            }
        }
        m114o(fVar2, this.f364i, i, i2);
        m113n(i, i2, fVar2.r(), fVar2.l(), ((g) fVar2).I0, ((g) fVar2).J0);
    }

    @Override // android.view.ViewGroup
    public void onViewAdded(View view) {
        super.onViewAdded(view);
        f fVarM110j = m110j(view);
        if ((view instanceof Guideline) && !(fVarM110j instanceof k)) {
            LayoutParams layoutParams = (LayoutParams) view.getLayoutParams();
            k kVar = new k();
            layoutParams.f433q0 = kVar;
            layoutParams.f407d0 = true;
            kVar.T(layoutParams.f395V);
        }
        if (view instanceof ConstraintHelper) {
            ConstraintHelper constraintHelper = (ConstraintHelper) view;
            constraintHelper.m107q();
            ((LayoutParams) view.getLayoutParams()).f409e0 = true;
            ArrayList arrayList = this.f357b;
            if (!arrayList.contains(constraintHelper)) {
                arrayList.add(constraintHelper);
            }
        }
        this.f356a.put(view.getId(), view);
        this.f363h = true;
    }

    @Override // android.view.ViewGroup
    public void onViewRemoved(View view) {
        super.onViewRemoved(view);
        this.f356a.remove(view.getId());
        f fVarM110j = m110j(view);
        this.f358c.u0.remove(fVarM110j);
        fVarM110j.D();
        this.f357b.remove(view);
        this.f363h = true;
    }

    /* JADX INFO: renamed from: p */
    public final void m115p(f fVar, LayoutParams layoutParams, SparseArray sparseArray, int i, ConstraintAnchor$Type constraintAnchor$Type) {
        View view = (View) this.f356a.get(i);
        f fVar2 = (f) sparseArray.get(i);
        if (fVar2 == null || view == null || !(view.getLayoutParams() instanceof LayoutParams)) {
            return;
        }
        layoutParams.f405c0 = true;
        ConstraintAnchor$Type constraintAnchor$Type2 = ConstraintAnchor$Type.BASELINE;
        if (constraintAnchor$Type == constraintAnchor$Type2) {
            LayoutParams layoutParams2 = (LayoutParams) view.getLayoutParams();
            layoutParams2.f405c0 = true;
            layoutParams2.f433q0.E = true;
        }
        fVar.j(constraintAnchor$Type2).b(fVar2.j(constraintAnchor$Type), layoutParams.f377D, layoutParams.f376C, true);
        fVar.E = true;
        fVar.j(ConstraintAnchor$Type.TOP).j();
        fVar.j(ConstraintAnchor$Type.BOTTOM).j();
    }

    @Override // android.view.View, android.view.ViewParent
    public void requestLayout() {
        this.f363h = true;
        super.requestLayout();
    }

    public void setConstraintSet(C0041d c0041d) {
        this.f365j = c0041d;
    }

    @Override // android.view.View
    public void setId(int i) {
        int id = getId();
        SparseArray sparseArray = this.f356a;
        sparseArray.remove(id);
        super.setId(i);
        sparseArray.put(getId(), this);
    }

    public void setMaxHeight(int i) {
        if (i == this.f362g) {
            return;
        }
        this.f362g = i;
        requestLayout();
    }

    public void setMaxWidth(int i) {
        if (i == this.f361f) {
            return;
        }
        this.f361f = i;
        requestLayout();
    }

    public void setMinHeight(int i) {
        if (i == this.f360e) {
            return;
        }
        this.f360e = i;
        requestLayout();
    }

    public void setMinWidth(int i) {
        if (i == this.f359d) {
            return;
        }
        this.f359d = i;
        requestLayout();
    }

    public void setOnConstraintsChanged(j1.k kVar) {
        C0082o c0082o = this.f366k;
        if (c0082o != null) {
            c0082o.getClass();
        }
    }

    public void setOptimizationLevel(int i) {
        this.f364i = i;
        g gVar = this.f358c;
        gVar.H0 = i;
        a1.d.p = gVar.X(512);
    }

    @Override // android.view.ViewGroup
    public final boolean shouldDelayChildPressedState() {
        return false;
    }

    @Override // android.view.ViewGroup
    public final ViewGroup.LayoutParams generateLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return new LayoutParams(layoutParams);
    }

    public ConstraintLayout(@NonNull Context context, @Nullable AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f356a = new SparseArray();
        this.f357b = new ArrayList(4);
        this.f358c = new g();
        this.f359d = 0;
        this.f360e = 0;
        this.f361f = Integer.MAX_VALUE;
        this.f362g = Integer.MAX_VALUE;
        this.f363h = true;
        this.f364i = 257;
        this.f365j = null;
        this.f366k = null;
        this.f367l = -1;
        this.f368m = new HashMap();
        this.f369n = new SparseArray();
        this.f370o = new C0039b(this, this);
        this.f371p = 0;
        this.f372q = 0;
        m111k(attributeSet, i);
    }

    public static class LayoutParams extends ViewGroup.MarginLayoutParams {

        /* JADX INFO: renamed from: A */
        public int f374A;

        /* JADX INFO: renamed from: B */
        public int f375B;

        /* JADX INFO: renamed from: C */
        public final int f376C;

        /* JADX INFO: renamed from: D */
        public final int f377D;

        /* JADX INFO: renamed from: E */
        public float f378E;

        /* JADX INFO: renamed from: F */
        public float f379F;

        /* JADX INFO: renamed from: G */
        public String f380G;

        /* JADX INFO: renamed from: H */
        public float f381H;

        /* JADX INFO: renamed from: I */
        public float f382I;

        /* JADX INFO: renamed from: J */
        public int f383J;

        /* JADX INFO: renamed from: K */
        public int f384K;

        /* JADX INFO: renamed from: L */
        public int f385L;

        /* JADX INFO: renamed from: M */
        public int f386M;

        /* JADX INFO: renamed from: N */
        public int f387N;

        /* JADX INFO: renamed from: O */
        public int f388O;

        /* JADX INFO: renamed from: P */
        public int f389P;

        /* JADX INFO: renamed from: Q */
        public int f390Q;

        /* JADX INFO: renamed from: R */
        public float f391R;

        /* JADX INFO: renamed from: S */
        public float f392S;

        /* JADX INFO: renamed from: T */
        public int f393T;

        /* JADX INFO: renamed from: U */
        public int f394U;

        /* JADX INFO: renamed from: V */
        public int f395V;

        /* JADX INFO: renamed from: W */
        public boolean f396W;

        /* JADX INFO: renamed from: X */
        public boolean f397X;

        /* JADX INFO: renamed from: Y */
        public String f398Y;

        /* JADX INFO: renamed from: Z */
        public int f399Z;

        /* JADX INFO: renamed from: a */
        public int f400a;

        /* JADX INFO: renamed from: a0 */
        public boolean f401a0;

        /* JADX INFO: renamed from: b */
        public int f402b;

        /* JADX INFO: renamed from: b0 */
        public boolean f403b0;

        /* JADX INFO: renamed from: c */
        public float f404c;

        /* JADX INFO: renamed from: c0 */
        public boolean f405c0;

        /* JADX INFO: renamed from: d */
        public final boolean f406d;

        /* JADX INFO: renamed from: d0 */
        public boolean f407d0;

        /* JADX INFO: renamed from: e */
        public int f408e;

        /* JADX INFO: renamed from: e0 */
        public boolean f409e0;

        /* JADX INFO: renamed from: f */
        public int f410f;

        /* JADX INFO: renamed from: f0 */
        public boolean f411f0;

        /* JADX INFO: renamed from: g */
        public int f412g;

        /* JADX INFO: renamed from: g0 */
        public int f413g0;

        /* JADX INFO: renamed from: h */
        public int f414h;

        /* JADX INFO: renamed from: h0 */
        public int f415h0;

        /* JADX INFO: renamed from: i */
        public int f416i;

        /* JADX INFO: renamed from: i0 */
        public int f417i0;

        /* JADX INFO: renamed from: j */
        public int f418j;

        /* JADX INFO: renamed from: j0 */
        public int f419j0;

        /* JADX INFO: renamed from: k */
        public int f420k;

        /* JADX INFO: renamed from: k0 */
        public int f421k0;

        /* JADX INFO: renamed from: l */
        public int f422l;

        /* JADX INFO: renamed from: l0 */
        public int f423l0;

        /* JADX INFO: renamed from: m */
        public int f424m;

        /* JADX INFO: renamed from: m0 */
        public float f425m0;

        /* JADX INFO: renamed from: n */
        public int f426n;

        /* JADX INFO: renamed from: n0 */
        public int f427n0;

        /* JADX INFO: renamed from: o */
        public int f428o;

        /* JADX INFO: renamed from: o0 */
        public int f429o0;

        /* JADX INFO: renamed from: p */
        public int f430p;

        /* JADX INFO: renamed from: p0 */
        public float f431p0;

        /* JADX INFO: renamed from: q */
        public int f432q;

        /* JADX INFO: renamed from: q0 */
        public f f433q0;

        /* JADX INFO: renamed from: r */
        public float f434r;

        /* JADX INFO: renamed from: s */
        public int f435s;

        /* JADX INFO: renamed from: t */
        public int f436t;

        /* JADX INFO: renamed from: u */
        public int f437u;

        /* JADX INFO: renamed from: v */
        public int f438v;

        /* JADX INFO: renamed from: w */
        public final int f439w;

        /* JADX INFO: renamed from: x */
        public int f440x;

        /* JADX INFO: renamed from: y */
        public final int f441y;

        /* JADX INFO: renamed from: z */
        public int f442z;

        public LayoutParams(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.f400a = -1;
            this.f402b = -1;
            this.f404c = -1.0f;
            this.f406d = true;
            this.f408e = -1;
            this.f410f = -1;
            this.f412g = -1;
            this.f414h = -1;
            this.f416i = -1;
            this.f418j = -1;
            this.f420k = -1;
            this.f422l = -1;
            this.f424m = -1;
            this.f426n = -1;
            this.f428o = -1;
            this.f430p = -1;
            this.f432q = 0;
            this.f434r = 0.0f;
            this.f435s = -1;
            this.f436t = -1;
            this.f437u = -1;
            this.f438v = -1;
            this.f439w = BasicMeasure.AT_MOST;
            this.f440x = BasicMeasure.AT_MOST;
            this.f441y = BasicMeasure.AT_MOST;
            this.f442z = BasicMeasure.AT_MOST;
            this.f374A = BasicMeasure.AT_MOST;
            this.f375B = BasicMeasure.AT_MOST;
            this.f376C = BasicMeasure.AT_MOST;
            this.f377D = 0;
            this.f378E = 0.5f;
            this.f379F = 0.5f;
            this.f380G = null;
            this.f381H = -1.0f;
            this.f382I = -1.0f;
            this.f383J = 0;
            this.f384K = 0;
            this.f385L = 0;
            this.f386M = 0;
            this.f387N = 0;
            this.f388O = 0;
            this.f389P = 0;
            this.f390Q = 0;
            this.f391R = 1.0f;
            this.f392S = 1.0f;
            this.f393T = -1;
            this.f394U = -1;
            this.f395V = -1;
            this.f396W = false;
            this.f397X = false;
            this.f398Y = null;
            this.f399Z = 0;
            this.f401a0 = true;
            this.f403b0 = true;
            this.f405c0 = false;
            this.f407d0 = false;
            this.f409e0 = false;
            this.f411f0 = false;
            this.f413g0 = -1;
            this.f415h0 = -1;
            this.f417i0 = -1;
            this.f419j0 = -1;
            this.f421k0 = BasicMeasure.AT_MOST;
            this.f423l0 = BasicMeasure.AT_MOST;
            this.f425m0 = 0.5f;
            this.f433q0 = new f();
            TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, m.c);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                int i2 = AbstractC0038a.f531a.get(index);
                switch (i2) {
                    case 1:
                        this.f395V = typedArrayObtainStyledAttributes.getInt(index, this.f395V);
                        break;
                    case 2:
                        int resourceId = typedArrayObtainStyledAttributes.getResourceId(index, this.f430p);
                        this.f430p = resourceId;
                        if (resourceId == -1) {
                            this.f430p = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case 3:
                        this.f432q = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f432q);
                        break;
                    case 4:
                        float f = typedArrayObtainStyledAttributes.getFloat(index, this.f434r) % 360.0f;
                        this.f434r = f;
                        if (f < 0.0f) {
                            this.f434r = (360.0f - f) % 360.0f;
                        }
                        break;
                    case 5:
                        this.f400a = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f400a);
                        break;
                    case 6:
                        this.f402b = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f402b);
                        break;
                    case 7:
                        this.f404c = typedArrayObtainStyledAttributes.getFloat(index, this.f404c);
                        break;
                    case 8:
                        int resourceId2 = typedArrayObtainStyledAttributes.getResourceId(index, this.f408e);
                        this.f408e = resourceId2;
                        if (resourceId2 == -1) {
                            this.f408e = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_LEFT_TO_RIGHT_OF /* 9 */:
                        int resourceId3 = typedArrayObtainStyledAttributes.getResourceId(index, this.f410f);
                        this.f410f = resourceId3;
                        if (resourceId3 == -1) {
                            this.f410f = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_RIGHT_TO_LEFT_OF /* 10 */:
                        int resourceId4 = typedArrayObtainStyledAttributes.getResourceId(index, this.f412g);
                        this.f412g = resourceId4;
                        if (resourceId4 == -1) {
                            this.f412g = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_RIGHT_TO_RIGHT_OF /* 11 */:
                        int resourceId5 = typedArrayObtainStyledAttributes.getResourceId(index, this.f414h);
                        this.f414h = resourceId5;
                        if (resourceId5 == -1) {
                            this.f414h = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_TOP_TO_TOP_OF /* 12 */:
                        int resourceId6 = typedArrayObtainStyledAttributes.getResourceId(index, this.f416i);
                        this.f416i = resourceId6;
                        if (resourceId6 == -1) {
                            this.f416i = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_TOP_TO_BOTTOM_OF /* 13 */:
                        int resourceId7 = typedArrayObtainStyledAttributes.getResourceId(index, this.f418j);
                        this.f418j = resourceId7;
                        if (resourceId7 == -1) {
                            this.f418j = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_BOTTOM_TO_TOP_OF /* 14 */:
                        int resourceId8 = typedArrayObtainStyledAttributes.getResourceId(index, this.f420k);
                        this.f420k = resourceId8;
                        if (resourceId8 == -1) {
                            this.f420k = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_BOTTOM_TO_BOTTOM_OF /* 15 */:
                        int resourceId9 = typedArrayObtainStyledAttributes.getResourceId(index, this.f422l);
                        this.f422l = resourceId9;
                        if (resourceId9 == -1) {
                            this.f422l = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case 16:
                        int resourceId10 = typedArrayObtainStyledAttributes.getResourceId(index, this.f424m);
                        this.f424m = resourceId10;
                        if (resourceId10 == -1) {
                            this.f424m = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case 17:
                        int resourceId11 = typedArrayObtainStyledAttributes.getResourceId(index, this.f435s);
                        this.f435s = resourceId11;
                        if (resourceId11 == -1) {
                            this.f435s = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_START_TO_START_OF /* 18 */:
                        int resourceId12 = typedArrayObtainStyledAttributes.getResourceId(index, this.f436t);
                        this.f436t = resourceId12;
                        if (resourceId12 == -1) {
                            this.f436t = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_END_TO_START_OF /* 19 */:
                        int resourceId13 = typedArrayObtainStyledAttributes.getResourceId(index, this.f437u);
                        this.f437u = resourceId13;
                        if (resourceId13 == -1) {
                            this.f437u = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_END_TO_END_OF /* 20 */:
                        int resourceId14 = typedArrayObtainStyledAttributes.getResourceId(index, this.f438v);
                        this.f438v = resourceId14;
                        if (resourceId14 == -1) {
                            this.f438v = typedArrayObtainStyledAttributes.getInt(index, -1);
                        }
                        break;
                    case Table.LAYOUT_GONE_MARGIN_LEFT /* 21 */:
                        this.f439w = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f439w);
                        break;
                    case Table.LAYOUT_GONE_MARGIN_TOP /* 22 */:
                        this.f440x = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f440x);
                        break;
                    case Table.LAYOUT_GONE_MARGIN_RIGHT /* 23 */:
                        this.f441y = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f441y);
                        break;
                    case Table.LAYOUT_GONE_MARGIN_BOTTOM /* 24 */:
                        this.f442z = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f442z);
                        break;
                    case Table.LAYOUT_GONE_MARGIN_START /* 25 */:
                        this.f374A = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f374A);
                        break;
                    case Table.LAYOUT_GONE_MARGIN_END /* 26 */:
                        this.f375B = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f375B);
                        break;
                    case Table.LAYOUT_CONSTRAINED_WIDTH /* 27 */:
                        this.f396W = typedArrayObtainStyledAttributes.getBoolean(index, this.f396W);
                        break;
                    case Table.LAYOUT_CONSTRAINED_HEIGHT /* 28 */:
                        this.f397X = typedArrayObtainStyledAttributes.getBoolean(index, this.f397X);
                        break;
                    case Table.LAYOUT_CONSTRAINT_HORIZONTAL_BIAS /* 29 */:
                        this.f378E = typedArrayObtainStyledAttributes.getFloat(index, this.f378E);
                        break;
                    case Table.LAYOUT_CONSTRAINT_VERTICAL_BIAS /* 30 */:
                        this.f379F = typedArrayObtainStyledAttributes.getFloat(index, this.f379F);
                        break;
                    case Table.LAYOUT_CONSTRAINT_WIDTH_DEFAULT /* 31 */:
                        int i3 = typedArrayObtainStyledAttributes.getInt(index, 0);
                        this.f385L = i3;
                        if (i3 == 1) {
                            Log.e("ConstraintLayout", "layout_constraintWidth_default=\"wrap\" is deprecated.\nUse layout_width=\"WRAP_CONTENT\" and layout_constrainedWidth=\"true\" instead.");
                        }
                        break;
                    case 32:
                        int i4 = typedArrayObtainStyledAttributes.getInt(index, 0);
                        this.f386M = i4;
                        if (i4 == 1) {
                            Log.e("ConstraintLayout", "layout_constraintHeight_default=\"wrap\" is deprecated.\nUse layout_height=\"WRAP_CONTENT\" and layout_constrainedHeight=\"true\" instead.");
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_WIDTH_MIN /* 33 */:
                        try {
                            this.f387N = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f387N);
                        } catch (Exception unused) {
                            if (typedArrayObtainStyledAttributes.getInt(index, this.f387N) == -2) {
                                this.f387N = -2;
                            }
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_WIDTH_MAX /* 34 */:
                        try {
                            this.f389P = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f389P);
                        } catch (Exception unused2) {
                            if (typedArrayObtainStyledAttributes.getInt(index, this.f389P) == -2) {
                                this.f389P = -2;
                            }
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_WIDTH_PERCENT /* 35 */:
                        this.f391R = Math.max(0.0f, typedArrayObtainStyledAttributes.getFloat(index, this.f391R));
                        this.f385L = 2;
                        break;
                    case Table.LAYOUT_CONSTRAINT_HEIGHT_MIN /* 36 */:
                        try {
                            this.f388O = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f388O);
                        } catch (Exception unused3) {
                            if (typedArrayObtainStyledAttributes.getInt(index, this.f388O) == -2) {
                                this.f388O = -2;
                            }
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_HEIGHT_MAX /* 37 */:
                        try {
                            this.f390Q = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f390Q);
                        } catch (Exception unused4) {
                            if (typedArrayObtainStyledAttributes.getInt(index, this.f390Q) == -2) {
                                this.f390Q = -2;
                            }
                        }
                        break;
                    case Table.LAYOUT_CONSTRAINT_HEIGHT_PERCENT /* 38 */:
                        this.f392S = Math.max(0.0f, typedArrayObtainStyledAttributes.getFloat(index, this.f392S));
                        this.f386M = 2;
                        break;
                    default:
                        switch (i2) {
                            case Table.LAYOUT_CONSTRAINT_DIMENSION_RATIO /* 44 */:
                                C0041d.m133q(this, typedArrayObtainStyledAttributes.getString(index));
                                break;
                            case Table.LAYOUT_CONSTRAINT_HORIZONTAL_WEIGHT /* 45 */:
                                this.f381H = typedArrayObtainStyledAttributes.getFloat(index, this.f381H);
                                break;
                            case Table.LAYOUT_CONSTRAINT_VERTICAL_WEIGHT /* 46 */:
                                this.f382I = typedArrayObtainStyledAttributes.getFloat(index, this.f382I);
                                break;
                            case Table.LAYOUT_CONSTRAINT_HORIZONTAL_CHAINSTYLE /* 47 */:
                                this.f383J = typedArrayObtainStyledAttributes.getInt(index, 0);
                                break;
                            case Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE /* 48 */:
                                this.f384K = typedArrayObtainStyledAttributes.getInt(index, 0);
                                break;
                            case Table.LAYOUT_EDITOR_ABSOLUTEX /* 49 */:
                                this.f393T = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f393T);
                                break;
                            case Table.LAYOUT_EDITOR_ABSOLUTEY /* 50 */:
                                this.f394U = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f394U);
                                break;
                            case Table.LAYOUT_CONSTRAINT_TAG /* 51 */:
                                this.f398Y = typedArrayObtainStyledAttributes.getString(index);
                                break;
                            case 52:
                                int resourceId15 = typedArrayObtainStyledAttributes.getResourceId(index, this.f426n);
                                this.f426n = resourceId15;
                                if (resourceId15 == -1) {
                                    this.f426n = typedArrayObtainStyledAttributes.getInt(index, -1);
                                }
                                break;
                            case 53:
                                int resourceId16 = typedArrayObtainStyledAttributes.getResourceId(index, this.f428o);
                                this.f428o = resourceId16;
                                if (resourceId16 == -1) {
                                    this.f428o = typedArrayObtainStyledAttributes.getInt(index, -1);
                                }
                                break;
                            case 54:
                                this.f377D = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f377D);
                                break;
                            case 55:
                                this.f376C = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, this.f376C);
                                break;
                            default:
                                switch (i2) {
                                    case Optimizer.OPTIMIZATION_GRAPH /* 64 */:
                                        C0041d.m132p(this, typedArrayObtainStyledAttributes, index, 0);
                                        break;
                                    case 65:
                                        C0041d.m132p(this, typedArrayObtainStyledAttributes, index, 1);
                                        break;
                                    case 66:
                                        this.f399Z = typedArrayObtainStyledAttributes.getInt(index, this.f399Z);
                                        break;
                                    case 67:
                                        this.f406d = typedArrayObtainStyledAttributes.getBoolean(index, this.f406d);
                                        break;
                                }
                                break;
                        }
                        break;
                }
            }
            typedArrayObtainStyledAttributes.recycle();
            m116a();
        }

        /* JADX INFO: renamed from: a */
        public final void m116a() {
            this.f407d0 = false;
            this.f401a0 = true;
            this.f403b0 = true;
            int i = ((ViewGroup.MarginLayoutParams) this).width;
            if (i == -2 && this.f396W) {
                this.f401a0 = false;
                if (this.f385L == 0) {
                    this.f385L = 1;
                }
            }
            int i2 = ((ViewGroup.MarginLayoutParams) this).height;
            if (i2 == -2 && this.f397X) {
                this.f403b0 = false;
                if (this.f386M == 0) {
                    this.f386M = 1;
                }
            }
            if (i == 0 || i == -1) {
                this.f401a0 = false;
                if (i == 0 && this.f385L == 1) {
                    ((ViewGroup.MarginLayoutParams) this).width = -2;
                    this.f396W = true;
                }
            }
            if (i2 == 0 || i2 == -1) {
                this.f403b0 = false;
                if (i2 == 0 && this.f386M == 1) {
                    ((ViewGroup.MarginLayoutParams) this).height = -2;
                    this.f397X = true;
                }
            }
            if (this.f404c == -1.0f && this.f400a == -1 && this.f402b == -1) {
                return;
            }
            this.f407d0 = true;
            this.f401a0 = true;
            this.f403b0 = true;
            if (!(this.f433q0 instanceof k)) {
                this.f433q0 = new k();
            }
            this.f433q0.T(this.f395V);
        }

        /* JADX WARN: Code duplicated, block: B:17:0x004a  */
        /* JADX WARN: Code duplicated, block: B:20:0x0051  */
        /* JADX WARN: Code duplicated, block: B:23:0x0058  */
        /* JADX WARN: Code duplicated, block: B:26:0x005e  */
        /* JADX WARN: Code duplicated, block: B:29:0x0064  */
        /* JADX WARN: Code duplicated, block: B:38:0x007a  */
        /* JADX WARN: Code duplicated, block: B:39:0x0082 A[DONT_INVERT] */
        /* JADX WARN: Code duplicated, block: B:40:0x0084  */
        /* JADX WARN: Code duplicated, block: B:41:0x008b A[DONT_INVERT] */
        /* JADX WARN: Code duplicated, block: B:42:0x008d  */
        @Override // android.view.ViewGroup.MarginLayoutParams, android.view.ViewGroup.LayoutParams
        public final void resolveLayoutDirection(int i) {
            int i2;
            int i3;
            int i4;
            int i5;
            int i6 = ((ViewGroup.MarginLayoutParams) this).leftMargin;
            int i7 = ((ViewGroup.MarginLayoutParams) this).rightMargin;
            super.resolveLayoutDirection(i);
            boolean z = false;
            boolean z2 = 1 == getLayoutDirection();
            this.f417i0 = -1;
            this.f419j0 = -1;
            this.f413g0 = -1;
            this.f415h0 = -1;
            this.f421k0 = this.f439w;
            this.f423l0 = this.f441y;
            float f = this.f378E;
            this.f425m0 = f;
            int i8 = this.f400a;
            this.f427n0 = i8;
            int i9 = this.f402b;
            this.f429o0 = i9;
            float f2 = this.f404c;
            this.f431p0 = f2;
            if (z2) {
                int i10 = this.f435s;
                if (i10 != -1) {
                    this.f417i0 = i10;
                } else {
                    int i11 = this.f436t;
                    if (i11 != -1) {
                        this.f419j0 = i11;
                    } else {
                        i2 = this.f437u;
                        if (i2 != -1) {
                            this.f415h0 = i2;
                            z = true;
                        }
                        i3 = this.f438v;
                        if (i3 != -1) {
                            this.f413g0 = i3;
                            z = true;
                        }
                        i4 = this.f374A;
                        if (i4 != Integer.MIN_VALUE) {
                            this.f423l0 = i4;
                        }
                        i5 = this.f375B;
                        if (i5 != Integer.MIN_VALUE) {
                            this.f421k0 = i5;
                        }
                        if (z) {
                            this.f425m0 = 1.0f - f;
                        }
                        if (this.f407d0 && this.f395V == 1 && this.f406d) {
                            if (f2 != -1.0f) {
                                this.f431p0 = 1.0f - f2;
                                this.f427n0 = -1;
                                this.f429o0 = -1;
                            } else if (i8 != -1) {
                                this.f429o0 = i8;
                                this.f427n0 = -1;
                                this.f431p0 = -1.0f;
                            } else if (i9 != -1) {
                                this.f427n0 = i9;
                                this.f429o0 = -1;
                                this.f431p0 = -1.0f;
                            }
                        }
                    }
                }
                z = true;
                i2 = this.f437u;
                if (i2 != -1) {
                    this.f415h0 = i2;
                    z = true;
                }
                i3 = this.f438v;
                if (i3 != -1) {
                    this.f413g0 = i3;
                    z = true;
                }
                i4 = this.f374A;
                if (i4 != Integer.MIN_VALUE) {
                    this.f423l0 = i4;
                }
                i5 = this.f375B;
                if (i5 != Integer.MIN_VALUE) {
                    this.f421k0 = i5;
                }
                if (z) {
                    this.f425m0 = 1.0f - f;
                }
                if (this.f407d0) {
                    if (f2 != -1.0f) {
                        this.f431p0 = 1.0f - f2;
                        this.f427n0 = -1;
                        this.f429o0 = -1;
                    } else if (i8 != -1) {
                        this.f429o0 = i8;
                        this.f427n0 = -1;
                        this.f431p0 = -1.0f;
                    } else if (i9 != -1) {
                        this.f427n0 = i9;
                        this.f429o0 = -1;
                        this.f431p0 = -1.0f;
                    }
                }
            } else {
                int i12 = this.f435s;
                if (i12 != -1) {
                    this.f415h0 = i12;
                }
                int i13 = this.f436t;
                if (i13 != -1) {
                    this.f413g0 = i13;
                }
                int i14 = this.f437u;
                if (i14 != -1) {
                    this.f417i0 = i14;
                }
                int i15 = this.f438v;
                if (i15 != -1) {
                    this.f419j0 = i15;
                }
                int i16 = this.f374A;
                if (i16 != Integer.MIN_VALUE) {
                    this.f421k0 = i16;
                }
                int i17 = this.f375B;
                if (i17 != Integer.MIN_VALUE) {
                    this.f423l0 = i17;
                }
            }
            if (this.f437u == -1 && this.f438v == -1 && this.f436t == -1 && this.f435s == -1) {
                int i18 = this.f412g;
                if (i18 != -1) {
                    this.f417i0 = i18;
                    if (((ViewGroup.MarginLayoutParams) this).rightMargin <= 0 && i7 > 0) {
                        ((ViewGroup.MarginLayoutParams) this).rightMargin = i7;
                    }
                } else {
                    int i19 = this.f414h;
                    if (i19 != -1) {
                        this.f419j0 = i19;
                        if (((ViewGroup.MarginLayoutParams) this).rightMargin <= 0 && i7 > 0) {
                            ((ViewGroup.MarginLayoutParams) this).rightMargin = i7;
                        }
                    }
                }
                int i20 = this.f408e;
                if (i20 != -1) {
                    this.f413g0 = i20;
                    if (((ViewGroup.MarginLayoutParams) this).leftMargin > 0 || i6 <= 0) {
                        return;
                    }
                    ((ViewGroup.MarginLayoutParams) this).leftMargin = i6;
                    return;
                }
                int i21 = this.f410f;
                if (i21 != -1) {
                    this.f415h0 = i21;
                    if (((ViewGroup.MarginLayoutParams) this).leftMargin > 0 || i6 <= 0) {
                        return;
                    }
                    ((ViewGroup.MarginLayoutParams) this).leftMargin = i6;
                }
            }
        }

        public LayoutParams(int i, int i2) {
            super(i, i2);
            this.f400a = -1;
            this.f402b = -1;
            this.f404c = -1.0f;
            this.f406d = true;
            this.f408e = -1;
            this.f410f = -1;
            this.f412g = -1;
            this.f414h = -1;
            this.f416i = -1;
            this.f418j = -1;
            this.f420k = -1;
            this.f422l = -1;
            this.f424m = -1;
            this.f426n = -1;
            this.f428o = -1;
            this.f430p = -1;
            this.f432q = 0;
            this.f434r = 0.0f;
            this.f435s = -1;
            this.f436t = -1;
            this.f437u = -1;
            this.f438v = -1;
            this.f439w = BasicMeasure.AT_MOST;
            this.f440x = BasicMeasure.AT_MOST;
            this.f441y = BasicMeasure.AT_MOST;
            this.f442z = BasicMeasure.AT_MOST;
            this.f374A = BasicMeasure.AT_MOST;
            this.f375B = BasicMeasure.AT_MOST;
            this.f376C = BasicMeasure.AT_MOST;
            this.f377D = 0;
            this.f378E = 0.5f;
            this.f379F = 0.5f;
            this.f380G = null;
            this.f381H = -1.0f;
            this.f382I = -1.0f;
            this.f383J = 0;
            this.f384K = 0;
            this.f385L = 0;
            this.f386M = 0;
            this.f387N = 0;
            this.f388O = 0;
            this.f389P = 0;
            this.f390Q = 0;
            this.f391R = 1.0f;
            this.f392S = 1.0f;
            this.f393T = -1;
            this.f394U = -1;
            this.f395V = -1;
            this.f396W = false;
            this.f397X = false;
            this.f398Y = null;
            this.f399Z = 0;
            this.f401a0 = true;
            this.f403b0 = true;
            this.f405c0 = false;
            this.f407d0 = false;
            this.f409e0 = false;
            this.f411f0 = false;
            this.f413g0 = -1;
            this.f415h0 = -1;
            this.f417i0 = -1;
            this.f419j0 = -1;
            this.f421k0 = BasicMeasure.AT_MOST;
            this.f423l0 = BasicMeasure.AT_MOST;
            this.f425m0 = 0.5f;
            this.f433q0 = new f();
        }

        public LayoutParams(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
            this.f400a = -1;
            this.f402b = -1;
            this.f404c = -1.0f;
            this.f406d = true;
            this.f408e = -1;
            this.f410f = -1;
            this.f412g = -1;
            this.f414h = -1;
            this.f416i = -1;
            this.f418j = -1;
            this.f420k = -1;
            this.f422l = -1;
            this.f424m = -1;
            this.f426n = -1;
            this.f428o = -1;
            this.f430p = -1;
            this.f432q = 0;
            this.f434r = 0.0f;
            this.f435s = -1;
            this.f436t = -1;
            this.f437u = -1;
            this.f438v = -1;
            this.f439w = BasicMeasure.AT_MOST;
            this.f440x = BasicMeasure.AT_MOST;
            this.f441y = BasicMeasure.AT_MOST;
            this.f442z = BasicMeasure.AT_MOST;
            this.f374A = BasicMeasure.AT_MOST;
            this.f375B = BasicMeasure.AT_MOST;
            this.f376C = BasicMeasure.AT_MOST;
            this.f377D = 0;
            this.f378E = 0.5f;
            this.f379F = 0.5f;
            this.f380G = null;
            this.f381H = -1.0f;
            this.f382I = -1.0f;
            this.f383J = 0;
            this.f384K = 0;
            this.f385L = 0;
            this.f386M = 0;
            this.f387N = 0;
            this.f388O = 0;
            this.f389P = 0;
            this.f390Q = 0;
            this.f391R = 1.0f;
            this.f392S = 1.0f;
            this.f393T = -1;
            this.f394U = -1;
            this.f395V = -1;
            this.f396W = false;
            this.f397X = false;
            this.f398Y = null;
            this.f399Z = 0;
            this.f401a0 = true;
            this.f403b0 = true;
            this.f405c0 = false;
            this.f407d0 = false;
            this.f409e0 = false;
            this.f411f0 = false;
            this.f413g0 = -1;
            this.f415h0 = -1;
            this.f417i0 = -1;
            this.f419j0 = -1;
            this.f421k0 = BasicMeasure.AT_MOST;
            this.f423l0 = BasicMeasure.AT_MOST;
            this.f425m0 = 0.5f;
            this.f433q0 = new f();
        }

        private static class Table {
            public static final int ANDROID_ORIENTATION = 1;
            public static final int LAYOUT_CONSTRAINED_HEIGHT = 28;
            public static final int LAYOUT_CONSTRAINED_WIDTH = 27;
            public static final int LAYOUT_CONSTRAINT_BASELINE_CREATOR = 43;
            public static final int LAYOUT_CONSTRAINT_BASELINE_TO_BASELINE_OF = 16;
            public static final int LAYOUT_CONSTRAINT_BOTTOM_CREATOR = 42;
            public static final int LAYOUT_CONSTRAINT_BOTTOM_TO_BOTTOM_OF = 15;
            public static final int LAYOUT_CONSTRAINT_BOTTOM_TO_TOP_OF = 14;
            public static final int LAYOUT_CONSTRAINT_CIRCLE = 2;
            public static final int LAYOUT_CONSTRAINT_CIRCLE_ANGLE = 4;
            public static final int LAYOUT_CONSTRAINT_CIRCLE_RADIUS = 3;
            public static final int LAYOUT_CONSTRAINT_DIMENSION_RATIO = 44;
            public static final int LAYOUT_CONSTRAINT_END_TO_END_OF = 20;
            public static final int LAYOUT_CONSTRAINT_END_TO_START_OF = 19;
            public static final int LAYOUT_CONSTRAINT_GUIDE_BEGIN = 5;
            public static final int LAYOUT_CONSTRAINT_GUIDE_END = 6;
            public static final int LAYOUT_CONSTRAINT_GUIDE_PERCENT = 7;
            public static final int LAYOUT_CONSTRAINT_HEIGHT_DEFAULT = 32;
            public static final int LAYOUT_CONSTRAINT_HEIGHT_MAX = 37;
            public static final int LAYOUT_CONSTRAINT_HEIGHT_MIN = 36;
            public static final int LAYOUT_CONSTRAINT_HEIGHT_PERCENT = 38;
            public static final int LAYOUT_CONSTRAINT_HORIZONTAL_BIAS = 29;
            public static final int LAYOUT_CONSTRAINT_HORIZONTAL_CHAINSTYLE = 47;
            public static final int LAYOUT_CONSTRAINT_HORIZONTAL_WEIGHT = 45;
            public static final int LAYOUT_CONSTRAINT_LEFT_CREATOR = 39;
            public static final int LAYOUT_CONSTRAINT_LEFT_TO_LEFT_OF = 8;
            public static final int LAYOUT_CONSTRAINT_LEFT_TO_RIGHT_OF = 9;
            public static final int LAYOUT_CONSTRAINT_RIGHT_CREATOR = 41;
            public static final int LAYOUT_CONSTRAINT_RIGHT_TO_LEFT_OF = 10;
            public static final int LAYOUT_CONSTRAINT_RIGHT_TO_RIGHT_OF = 11;
            public static final int LAYOUT_CONSTRAINT_START_TO_END_OF = 17;
            public static final int LAYOUT_CONSTRAINT_START_TO_START_OF = 18;
            public static final int LAYOUT_CONSTRAINT_TAG = 51;
            public static final int LAYOUT_CONSTRAINT_TOP_CREATOR = 40;
            public static final int LAYOUT_CONSTRAINT_TOP_TO_BOTTOM_OF = 13;
            public static final int LAYOUT_CONSTRAINT_TOP_TO_TOP_OF = 12;
            public static final int LAYOUT_CONSTRAINT_VERTICAL_BIAS = 30;
            public static final int LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE = 48;
            public static final int LAYOUT_CONSTRAINT_VERTICAL_WEIGHT = 46;
            public static final int LAYOUT_CONSTRAINT_WIDTH_DEFAULT = 31;
            public static final int LAYOUT_CONSTRAINT_WIDTH_MAX = 34;
            public static final int LAYOUT_CONSTRAINT_WIDTH_MIN = 33;
            public static final int LAYOUT_CONSTRAINT_WIDTH_PERCENT = 35;
            public static final int LAYOUT_EDITOR_ABSOLUTEX = 49;
            public static final int LAYOUT_EDITOR_ABSOLUTEY = 50;
            public static final int LAYOUT_GONE_MARGIN_BOTTOM = 24;
            public static final int LAYOUT_GONE_MARGIN_END = 26;
            public static final int LAYOUT_GONE_MARGIN_LEFT = 21;
            public static final int LAYOUT_GONE_MARGIN_RIGHT = 23;
            public static final int LAYOUT_GONE_MARGIN_START = 25;
            public static final int LAYOUT_GONE_MARGIN_TOP = 22;
            public static final int UNUSED = 0;
            public static final SparseIntArray map;

            private Table() {
            }

            static {
                SparseIntArray sparseIntArray = new SparseIntArray();
                map = sparseIntArray;
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintLeft_toLeftOf, 8);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintLeft_toRightOf, 9);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintRight_toLeftOf, 10);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintRight_toRightOf, 11);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintTop_toTopOf, 12);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintTop_toBottomOf, 13);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintBottom_toTopOf, 14);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintBottom_toBottomOf, 15);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintBaseline_toBaselineOf, 16);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintCircle, 2);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintCircleRadius, 3);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintCircleAngle, 4);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_editor_absoluteX, 49);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_editor_absoluteY, 50);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintGuide_begin, 5);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintGuide_end, 6);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintGuide_percent, 7);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_android_orientation, 1);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintStart_toEndOf, 17);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintStart_toStartOf, 18);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintEnd_toStartOf, 19);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintEnd_toEndOf, 20);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_goneMarginLeft, 21);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_goneMarginTop, 22);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_goneMarginRight, 23);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_goneMarginBottom, 24);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_goneMarginStart, 25);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_goneMarginEnd, 26);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintHorizontal_bias, 29);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintVertical_bias, 30);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintDimensionRatio, 44);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintHorizontal_weight, 45);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintVertical_weight, 46);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintHorizontal_chainStyle, 47);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintVertical_chainStyle, 48);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constrainedWidth, 27);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constrainedHeight, 28);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintWidth_default, 31);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintHeight_default, 32);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintWidth_min, 33);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintWidth_max, 34);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintWidth_percent, 35);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintHeight_min, 36);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintHeight_max, 37);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintHeight_percent, 38);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintLeft_creator, 39);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintTop_creator, 40);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintRight_creator, 41);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintBottom_creator, 42);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintBaseline_creator, 43);
                sparseIntArray.append(C0037R.styleable.ConstraintLayout_Layout_layout_constraintTag, 51);
            }
        }
    }

    class Measurer implements BasicMeasure.Measurer {
        ConstraintLayout layout;
        int layoutHeightSpec;
        int layoutWidthSpec;
        int paddingBottom;
        int paddingHeight;
        int paddingTop;
        int paddingWidth;

        public void captureLayoutInfos(int i, int i2, int i3, int i4, int i5, int i6) {
            this.paddingTop = i3;
            this.paddingBottom = i4;
            this.paddingWidth = i5;
            this.paddingHeight = i6;
            this.layoutWidthSpec = i;
            this.layoutHeightSpec = i2;
        }

        public Measurer(ConstraintLayout constraintLayout) {
            this.layout = constraintLayout;
        }

        /* JADX WARN: Code duplicated, block: B:100:0x0166  */
        /* JADX WARN: Code duplicated, block: B:103:0x016e  */
        /* JADX WARN: Code duplicated, block: B:106:0x0179 A[ADDED_TO_REGION] */
        /* JADX WARN: Code duplicated, block: B:114:0x018e  */
        /* JADX WARN: Code duplicated, block: B:116:0x0192  */
        /* JADX WARN: Code duplicated, block: B:119:0x01a0  */
        /* JADX WARN: Code duplicated, block: B:122:0x01b1  */
        /* JADX WARN: Code duplicated, block: B:123:0x01be  */
        /* JADX WARN: Code duplicated, block: B:125:0x01cc  */
        /* JADX WARN: Code duplicated, block: B:126:0x01d8  */
        /* JADX WARN: Code duplicated, block: B:129:0x01e7  */
        /* JADX WARN: Code duplicated, block: B:130:0x01ee  */
        /* JADX WARN: Code duplicated, block: B:133:0x01f3  */
        /* JADX WARN: Code duplicated, block: B:136:0x01fd  */
        /* JADX WARN: Code duplicated, block: B:137:0x0204  */
        /* JADX WARN: Code duplicated, block: B:140:0x0209  */
        /* JADX WARN: Code duplicated, block: B:143:0x0213 A[ADDED_TO_REGION] */
        /* JADX WARN: Code duplicated, block: B:145:0x021e A[DONT_INVERT] */
        /* JADX WARN: Code duplicated, block: B:146:0x0220 A[ADDED_TO_REGION] */
        /* JADX WARN: Code duplicated, block: B:149:0x022b A[ADDED_TO_REGION] */
        /* JADX WARN: Code duplicated, block: B:153:0x0232  */
        /* JADX WARN: Code duplicated, block: B:155:0x0236  */
        /* JADX WARN: Code duplicated, block: B:157:0x023c  */
        /* JADX WARN: Code duplicated, block: B:160:0x0253  */
        /* JADX WARN: Code duplicated, block: B:161:0x0255  */
        /* JADX WARN: Code duplicated, block: B:164:0x025a  */
        /* JADX WARN: Code duplicated, block: B:168:0x0261  */
        /* JADX WARN: Code duplicated, block: B:171:0x0268  */
        /* JADX WARN: Code duplicated, block: B:172:0x026a  */
        /* JADX WARN: Code duplicated, block: B:174:0x026d  */
        /* JADX WARN: Code duplicated, block: B:42:0x00bf A[DONT_INVERT] */
        /* JADX WARN: Code duplicated, block: B:43:0x00c1 A[DONT_INVERT] */
        /* JADX WARN: Code duplicated, block: B:44:0x00c3  */
        /* JADX WARN: Code duplicated, block: B:46:0x00c6  */
        /* JADX WARN: Code duplicated, block: B:47:0x00ca  */
        /* JADX WARN: Code duplicated, block: B:49:0x00d4  */
        /* JADX WARN: Code duplicated, block: B:50:0x00d6  */
        /* JADX WARN: Code duplicated, block: B:53:0x00e0  */
        /* JADX WARN: Code duplicated, block: B:54:0x00e2  */
        /* JADX WARN: Code duplicated, block: B:58:0x00f2  */
        /* JADX WARN: Code duplicated, block: B:63:0x00fb A[ADDED_TO_REGION] */
        /* JADX WARN: Code duplicated, block: B:65:0x0108  */
        /* JADX WARN: Code duplicated, block: B:67:0x011a  */
        /* JADX WARN: Code duplicated, block: B:69:0x0127  */
        /* JADX WARN: Code duplicated, block: B:73:0x0136  */
        /* JADX WARN: Code duplicated, block: B:74:0x0138  */
        /* JADX WARN: Code duplicated, block: B:77:0x013d  */
        /* JADX WARN: Code duplicated, block: B:78:0x013f  */
        /* JADX WARN: Code duplicated, block: B:81:0x0144  */
        /* JADX WARN: Code duplicated, block: B:85:0x014b  */
        /* JADX WARN: Code duplicated, block: B:88:0x0150  */
        /* JADX WARN: Code duplicated, block: B:92:0x0157  */
        /* JADX WARN: Code duplicated, block: B:95:0x015b  */
        /* JADX WARN: Code duplicated, block: B:98:0x0163  */
        @Override // androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure.Measurer
        public final void measure(ConstraintWidget constraintWidget, BasicMeasure.Measure measure) {
            int iMakeMeasureSpec;
            boolean z;
            int i;
            int iMakeMeasureSpec2;
            boolean z2;
            boolean z3;
            boolean z4;
            boolean z5;
            boolean z6;
            boolean z7;
            boolean z8;
            LayoutParams layoutParams;
            int measuredWidth;
            int measuredHeight;
            int baseline;
            int i2;
            int iMin;
            int iMin2;
            int measuredWidth2;
            int measuredHeight2;
            int i3;
            boolean z9;
            boolean z10;
            boolean z11;
            int childMeasureSpec;
            int childMeasureSpec2;
            boolean z12;
            if (constraintWidget == null) {
                return;
            }
            if (constraintWidget.getVisibility() == 8 && !constraintWidget.isInPlaceholder()) {
                measure.measuredWidth = 0;
                measure.measuredHeight = 0;
                measure.measuredBaseline = 0;
                return;
            }
            ConstraintWidget.DimensionBehaviour dimensionBehaviour = measure.horizontalBehavior;
            ConstraintWidget.DimensionBehaviour dimensionBehaviour2 = measure.verticalBehavior;
            int i4 = measure.horizontalDimension;
            int i5 = measure.verticalDimension;
            int i6 = this.paddingTop + this.paddingBottom;
            int i7 = this.paddingWidth;
            View view = (View) constraintWidget.getCompanionWidget();
            int i8 = C00361.f373xdde91696[dimensionBehaviour.ordinal()];
            if (i8 == 1) {
                int iMakeMeasureSpec3 = View.MeasureSpec.makeMeasureSpec(i4, BasicMeasure.EXACTLY);
                constraintWidget.wrapMeasure[2] = i4;
                iMakeMeasureSpec = iMakeMeasureSpec3;
            } else {
                if (i8 == 2) {
                    iMakeMeasureSpec = ViewGroup.getChildMeasureSpec(this.layoutWidthSpec, i7, -2);
                    constraintWidget.wrapMeasure[2] = -2;
                } else if (i8 == 3) {
                    iMakeMeasureSpec = ViewGroup.getChildMeasureSpec(this.layoutWidthSpec, i7 + constraintWidget.getHorizontalMargin(), -1);
                    constraintWidget.wrapMeasure[2] = -1;
                } else if (i8 != 4) {
                    iMakeMeasureSpec = 0;
                } else {
                    iMakeMeasureSpec = ViewGroup.getChildMeasureSpec(this.layoutWidthSpec, i7, -2);
                    boolean z13 = constraintWidget.mMatchConstraintDefaultWidth == 1;
                    constraintWidget.wrapMeasure[2] = 0;
                    if (measure.useCurrentDimensions) {
                        boolean z14 = !(!z13 || constraintWidget.wrapMeasure[3] == 0 || constraintWidget.wrapMeasure[0] == constraintWidget.getWidth()) || (view instanceof Placeholder);
                        if (!z13 || z14) {
                            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(constraintWidget.getWidth(), BasicMeasure.EXACTLY);
                        }
                        i = C00361.f373xdde91696[dimensionBehaviour2.ordinal()];
                        if (i == 1) {
                            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(i5, BasicMeasure.EXACTLY);
                            constraintWidget.wrapMeasure[3] = i5;
                        } else {
                            if (i != 2) {
                                if (i == 3) {
                                    childMeasureSpec2 = ViewGroup.getChildMeasureSpec(this.layoutHeightSpec, i6 + constraintWidget.getVerticalMargin(), -1);
                                    constraintWidget.wrapMeasure[3] = -1;
                                } else {
                                    if (i != 4) {
                                        z2 = false;
                                        iMakeMeasureSpec2 = 0;
                                    } else {
                                        childMeasureSpec = ViewGroup.getChildMeasureSpec(this.layoutHeightSpec, i6, -2);
                                        if (constraintWidget.mMatchConstraintDefaultHeight == 1) {
                                            z12 = true;
                                        } else {
                                            z12 = false;
                                        }
                                        constraintWidget.wrapMeasure[3] = 0;
                                        if (measure.useCurrentDimensions) {
                                            boolean z15 = !(z12 || constraintWidget.wrapMeasure[2] == 0 || constraintWidget.wrapMeasure[1] == constraintWidget.getHeight()) || (view instanceof Placeholder);
                                            if (z12 || z15) {
                                                childMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(constraintWidget.getHeight(), BasicMeasure.EXACTLY);
                                            }
                                        }
                                    }
                                    if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                        z3 = true;
                                    } else {
                                        z3 = false;
                                    }
                                    if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                        z4 = true;
                                    } else {
                                        z4 = false;
                                    }
                                    if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.MATCH_PARENT || dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.FIXED) {
                                        z5 = true;
                                    } else {
                                        z5 = false;
                                    }
                                    if (dimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_PARENT || dimensionBehaviour == ConstraintWidget.DimensionBehaviour.FIXED) {
                                        z6 = true;
                                    } else {
                                        z6 = false;
                                    }
                                    if (z3 || constraintWidget.mDimensionRatio <= 0.0f) {
                                        z7 = false;
                                    } else {
                                        z7 = true;
                                    }
                                    if (z4 || constraintWidget.mDimensionRatio <= 0.0f) {
                                        z8 = false;
                                    } else {
                                        z8 = true;
                                    }
                                    layoutParams = (LayoutParams) view.getLayoutParams();
                                    if (measure.useCurrentDimensions && z3 && constraintWidget.mMatchConstraintDefaultWidth == 0 && z4 && constraintWidget.mMatchConstraintDefaultHeight == 0) {
                                        measuredWidth2 = 0;
                                        measuredHeight2 = 0;
                                        i3 = -1;
                                        baseline = 0;
                                    } else {
                                        if (!(view instanceof VirtualLayout) && (constraintWidget instanceof androidx.constraintlayout.solver.widgets.VirtualLayout)) {
                                            ((VirtualLayout) view).onMeasure((androidx.constraintlayout.solver.widgets.VirtualLayout) constraintWidget, iMakeMeasureSpec, iMakeMeasureSpec2);
                                        } else {
                                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                        }
                                        measuredWidth = view.getMeasuredWidth();
                                        measuredHeight = view.getMeasuredHeight();
                                        baseline = view.getBaseline();
                                        if (z) {
                                            i2 = 0;
                                            constraintWidget.wrapMeasure[0] = measuredWidth;
                                            constraintWidget.wrapMeasure[2] = measuredHeight;
                                        } else {
                                            i2 = 0;
                                            constraintWidget.wrapMeasure[0] = 0;
                                            constraintWidget.wrapMeasure[2] = 0;
                                        }
                                        if (z2) {
                                            constraintWidget.wrapMeasure[1] = measuredHeight;
                                            constraintWidget.wrapMeasure[3] = measuredWidth;
                                        } else {
                                            constraintWidget.wrapMeasure[1] = i2;
                                            constraintWidget.wrapMeasure[3] = i2;
                                        }
                                        if (constraintWidget.mMatchConstraintMinWidth > 0) {
                                            iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                                        } else {
                                            iMin = measuredWidth;
                                        }
                                        if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                                            iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                                        }
                                        if (constraintWidget.mMatchConstraintMinHeight > 0) {
                                            iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                                        } else {
                                            iMin2 = measuredHeight;
                                        }
                                        if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                                            iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                                        }
                                        if (!z7 && z5) {
                                            iMin = (int) ((iMin2 * constraintWidget.mDimensionRatio) + 0.5f);
                                        } else if (z8 && z6) {
                                            iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                        }
                                        if (measuredWidth == iMin || measuredHeight != iMin2) {
                                            if (measuredWidth != iMin) {
                                                iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                            }
                                            if (measuredHeight != iMin2) {
                                                iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                            }
                                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                            measuredWidth2 = view.getMeasuredWidth();
                                            measuredHeight2 = view.getMeasuredHeight();
                                            baseline = view.getBaseline();
                                        } else {
                                            measuredWidth2 = iMin;
                                            measuredHeight2 = iMin2;
                                        }
                                        i3 = -1;
                                    }
                                    if (baseline != i3) {
                                        z9 = true;
                                    } else {
                                        z9 = false;
                                    }
                                    if (measuredWidth2 == measure.horizontalDimension || measuredHeight2 != measure.verticalDimension) {
                                        z10 = true;
                                    } else {
                                        z10 = false;
                                    }
                                    measure.measuredNeedsSolverPass = z10;
                                    if (layoutParams.needsBaseline) {
                                        z11 = true;
                                    } else {
                                        z11 = z9;
                                    }
                                    if (z11 && baseline != -1 && constraintWidget.getBaselineDistance() != baseline) {
                                        measure.measuredNeedsSolverPass = true;
                                    }
                                    measure.measuredWidth = measuredWidth2;
                                    measure.measuredHeight = measuredHeight2;
                                    measure.measuredHasBaseline = z11;
                                    measure.measuredBaseline = baseline;
                                }
                                iMakeMeasureSpec2 = childMeasureSpec2;
                            } else {
                                childMeasureSpec = ViewGroup.getChildMeasureSpec(this.layoutHeightSpec, i6, -2);
                                constraintWidget.wrapMeasure[3] = -2;
                            }
                            iMakeMeasureSpec2 = childMeasureSpec;
                            z2 = true;
                            if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                z3 = true;
                            } else {
                                z3 = false;
                            }
                            if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                z4 = true;
                            } else {
                                z4 = false;
                            }
                            if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                                z5 = true;
                            } else {
                                z5 = true;
                            }
                            if (dimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                                z6 = true;
                            } else {
                                z6 = true;
                            }
                            if (z3) {
                                z7 = false;
                            } else {
                                z7 = false;
                            }
                            if (z4) {
                                z8 = false;
                            } else {
                                z8 = false;
                            }
                            layoutParams = (LayoutParams) view.getLayoutParams();
                            if (measure.useCurrentDimensions) {
                                if (!(view instanceof VirtualLayout)) {
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                } else {
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                }
                                measuredWidth = view.getMeasuredWidth();
                                measuredHeight = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                                if (z) {
                                    i2 = 0;
                                    constraintWidget.wrapMeasure[0] = measuredWidth;
                                    constraintWidget.wrapMeasure[2] = measuredHeight;
                                } else {
                                    i2 = 0;
                                    constraintWidget.wrapMeasure[0] = 0;
                                    constraintWidget.wrapMeasure[2] = 0;
                                }
                                if (z2) {
                                    constraintWidget.wrapMeasure[1] = measuredHeight;
                                    constraintWidget.wrapMeasure[3] = measuredWidth;
                                } else {
                                    constraintWidget.wrapMeasure[1] = i2;
                                    constraintWidget.wrapMeasure[3] = i2;
                                }
                                if (constraintWidget.mMatchConstraintMinWidth > 0) {
                                    iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                                } else {
                                    iMin = measuredWidth;
                                }
                                if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                                    iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                                }
                                if (constraintWidget.mMatchConstraintMinHeight > 0) {
                                    iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                                } else {
                                    iMin2 = measuredHeight;
                                }
                                if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                                    iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                                }
                                if (!z7) {
                                    if (z8) {
                                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                    }
                                } else if (z8) {
                                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                }
                                if (measuredWidth == iMin) {
                                    if (measuredWidth != iMin) {
                                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                    }
                                    if (measuredHeight != iMin2) {
                                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                    }
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                    measuredWidth2 = view.getMeasuredWidth();
                                    measuredHeight2 = view.getMeasuredHeight();
                                    baseline = view.getBaseline();
                                } else {
                                    if (measuredWidth != iMin) {
                                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                    }
                                    if (measuredHeight != iMin2) {
                                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                    }
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                    measuredWidth2 = view.getMeasuredWidth();
                                    measuredHeight2 = view.getMeasuredHeight();
                                    baseline = view.getBaseline();
                                }
                                i3 = -1;
                            } else {
                                if (!(view instanceof VirtualLayout)) {
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                } else {
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                }
                                measuredWidth = view.getMeasuredWidth();
                                measuredHeight = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                                if (z) {
                                    i2 = 0;
                                    constraintWidget.wrapMeasure[0] = measuredWidth;
                                    constraintWidget.wrapMeasure[2] = measuredHeight;
                                } else {
                                    i2 = 0;
                                    constraintWidget.wrapMeasure[0] = 0;
                                    constraintWidget.wrapMeasure[2] = 0;
                                }
                                if (z2) {
                                    constraintWidget.wrapMeasure[1] = measuredHeight;
                                    constraintWidget.wrapMeasure[3] = measuredWidth;
                                } else {
                                    constraintWidget.wrapMeasure[1] = i2;
                                    constraintWidget.wrapMeasure[3] = i2;
                                }
                                if (constraintWidget.mMatchConstraintMinWidth > 0) {
                                    iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                                } else {
                                    iMin = measuredWidth;
                                }
                                if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                                    iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                                }
                                if (constraintWidget.mMatchConstraintMinHeight > 0) {
                                    iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                                } else {
                                    iMin2 = measuredHeight;
                                }
                                if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                                    iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                                }
                                if (!z7) {
                                    if (z8) {
                                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                    }
                                } else if (z8) {
                                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                }
                                if (measuredWidth == iMin) {
                                    if (measuredWidth != iMin) {
                                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                    }
                                    if (measuredHeight != iMin2) {
                                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                    }
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                    measuredWidth2 = view.getMeasuredWidth();
                                    measuredHeight2 = view.getMeasuredHeight();
                                    baseline = view.getBaseline();
                                } else {
                                    if (measuredWidth != iMin) {
                                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                    }
                                    if (measuredHeight != iMin2) {
                                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                    }
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                    measuredWidth2 = view.getMeasuredWidth();
                                    measuredHeight2 = view.getMeasuredHeight();
                                    baseline = view.getBaseline();
                                }
                                i3 = -1;
                            }
                            if (baseline != i3) {
                                z9 = true;
                            } else {
                                z9 = false;
                            }
                            if (measuredWidth2 == measure.horizontalDimension) {
                                z10 = true;
                            } else {
                                z10 = true;
                            }
                            measure.measuredNeedsSolverPass = z10;
                            if (layoutParams.needsBaseline) {
                                z11 = true;
                            } else {
                                z11 = z9;
                            }
                            if (z11) {
                                measure.measuredNeedsSolverPass = true;
                            }
                            measure.measuredWidth = measuredWidth2;
                            measure.measuredHeight = measuredHeight2;
                            measure.measuredHasBaseline = z11;
                            measure.measuredBaseline = baseline;
                        }
                        z2 = false;
                        if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                            z3 = true;
                        } else {
                            z3 = false;
                        }
                        if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                            z4 = true;
                        } else {
                            z4 = false;
                        }
                        if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                            z5 = true;
                        } else {
                            z5 = true;
                        }
                        if (dimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                            z6 = true;
                        } else {
                            z6 = true;
                        }
                        if (z3) {
                            z7 = false;
                        } else {
                            z7 = false;
                        }
                        if (z4) {
                            z8 = false;
                        } else {
                            z8 = false;
                        }
                        layoutParams = (LayoutParams) view.getLayoutParams();
                        if (measure.useCurrentDimensions) {
                            if (!(view instanceof VirtualLayout)) {
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            } else {
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            }
                            measuredWidth = view.getMeasuredWidth();
                            measuredHeight = view.getMeasuredHeight();
                            baseline = view.getBaseline();
                            if (z) {
                                i2 = 0;
                                constraintWidget.wrapMeasure[0] = measuredWidth;
                                constraintWidget.wrapMeasure[2] = measuredHeight;
                            } else {
                                i2 = 0;
                                constraintWidget.wrapMeasure[0] = 0;
                                constraintWidget.wrapMeasure[2] = 0;
                            }
                            if (z2) {
                                constraintWidget.wrapMeasure[1] = measuredHeight;
                                constraintWidget.wrapMeasure[3] = measuredWidth;
                            } else {
                                constraintWidget.wrapMeasure[1] = i2;
                                constraintWidget.wrapMeasure[3] = i2;
                            }
                            if (constraintWidget.mMatchConstraintMinWidth > 0) {
                                iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                            } else {
                                iMin = measuredWidth;
                            }
                            if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                                iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                            }
                            if (constraintWidget.mMatchConstraintMinHeight > 0) {
                                iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                            } else {
                                iMin2 = measuredHeight;
                            }
                            if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                                iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                            }
                            if (!z7) {
                                if (z8) {
                                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                }
                            } else if (z8) {
                                iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                            }
                            if (measuredWidth == iMin) {
                                if (measuredWidth != iMin) {
                                    iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                }
                                if (measuredHeight != iMin2) {
                                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                }
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                measuredWidth2 = view.getMeasuredWidth();
                                measuredHeight2 = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                            } else {
                                if (measuredWidth != iMin) {
                                    iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                }
                                if (measuredHeight != iMin2) {
                                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                }
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                measuredWidth2 = view.getMeasuredWidth();
                                measuredHeight2 = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                            }
                            i3 = -1;
                        } else {
                            if (!(view instanceof VirtualLayout)) {
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            } else {
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            }
                            measuredWidth = view.getMeasuredWidth();
                            measuredHeight = view.getMeasuredHeight();
                            baseline = view.getBaseline();
                            if (z) {
                                i2 = 0;
                                constraintWidget.wrapMeasure[0] = measuredWidth;
                                constraintWidget.wrapMeasure[2] = measuredHeight;
                            } else {
                                i2 = 0;
                                constraintWidget.wrapMeasure[0] = 0;
                                constraintWidget.wrapMeasure[2] = 0;
                            }
                            if (z2) {
                                constraintWidget.wrapMeasure[1] = measuredHeight;
                                constraintWidget.wrapMeasure[3] = measuredWidth;
                            } else {
                                constraintWidget.wrapMeasure[1] = i2;
                                constraintWidget.wrapMeasure[3] = i2;
                            }
                            if (constraintWidget.mMatchConstraintMinWidth > 0) {
                                iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                            } else {
                                iMin = measuredWidth;
                            }
                            if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                                iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                            }
                            if (constraintWidget.mMatchConstraintMinHeight > 0) {
                                iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                            } else {
                                iMin2 = measuredHeight;
                            }
                            if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                                iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                            }
                            if (!z7) {
                                if (z8) {
                                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                }
                            } else if (z8) {
                                iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                            }
                            if (measuredWidth == iMin) {
                                if (measuredWidth != iMin) {
                                    iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                }
                                if (measuredHeight != iMin2) {
                                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                }
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                measuredWidth2 = view.getMeasuredWidth();
                                measuredHeight2 = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                            } else {
                                if (measuredWidth != iMin) {
                                    iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                }
                                if (measuredHeight != iMin2) {
                                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                }
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                measuredWidth2 = view.getMeasuredWidth();
                                measuredHeight2 = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                            }
                            i3 = -1;
                        }
                        if (baseline != i3) {
                            z9 = true;
                        } else {
                            z9 = false;
                        }
                        if (measuredWidth2 == measure.horizontalDimension) {
                            z10 = true;
                        } else {
                            z10 = true;
                        }
                        measure.measuredNeedsSolverPass = z10;
                        if (layoutParams.needsBaseline) {
                            z11 = true;
                        } else {
                            z11 = z9;
                        }
                        if (z11) {
                            measure.measuredNeedsSolverPass = true;
                        }
                        measure.measuredWidth = measuredWidth2;
                        measure.measuredHeight = measuredHeight2;
                        measure.measuredHasBaseline = z11;
                        measure.measuredBaseline = baseline;
                    }
                }
                z = true;
                i = C00361.f373xdde91696[dimensionBehaviour2.ordinal()];
                if (i == 1) {
                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(i5, BasicMeasure.EXACTLY);
                    constraintWidget.wrapMeasure[3] = i5;
                } else {
                    if (i != 2) {
                        if (i == 3) {
                            childMeasureSpec2 = ViewGroup.getChildMeasureSpec(this.layoutHeightSpec, i6 + constraintWidget.getVerticalMargin(), -1);
                            constraintWidget.wrapMeasure[3] = -1;
                        } else {
                            if (i != 4) {
                                z2 = false;
                                iMakeMeasureSpec2 = 0;
                            } else {
                                childMeasureSpec = ViewGroup.getChildMeasureSpec(this.layoutHeightSpec, i6, -2);
                                if (constraintWidget.mMatchConstraintDefaultHeight == 1) {
                                    z12 = true;
                                } else {
                                    z12 = false;
                                }
                                constraintWidget.wrapMeasure[3] = 0;
                                if (measure.useCurrentDimensions) {
                                    if (z12) {
                                    }
                                    if (z12) {
                                    }
                                    childMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(constraintWidget.getHeight(), BasicMeasure.EXACTLY);
                                }
                            }
                            if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                z3 = true;
                            } else {
                                z3 = false;
                            }
                            if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                z4 = true;
                            } else {
                                z4 = false;
                            }
                            if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                                z5 = true;
                            } else {
                                z5 = true;
                            }
                            if (dimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                                z6 = true;
                            } else {
                                z6 = true;
                            }
                            if (z3) {
                                z7 = false;
                            } else {
                                z7 = false;
                            }
                            if (z4) {
                                z8 = false;
                            } else {
                                z8 = false;
                            }
                            layoutParams = (LayoutParams) view.getLayoutParams();
                            if (measure.useCurrentDimensions) {
                                if (!(view instanceof VirtualLayout)) {
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                } else {
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                }
                                measuredWidth = view.getMeasuredWidth();
                                measuredHeight = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                                if (z) {
                                    i2 = 0;
                                    constraintWidget.wrapMeasure[0] = measuredWidth;
                                    constraintWidget.wrapMeasure[2] = measuredHeight;
                                } else {
                                    i2 = 0;
                                    constraintWidget.wrapMeasure[0] = 0;
                                    constraintWidget.wrapMeasure[2] = 0;
                                }
                                if (z2) {
                                    constraintWidget.wrapMeasure[1] = measuredHeight;
                                    constraintWidget.wrapMeasure[3] = measuredWidth;
                                } else {
                                    constraintWidget.wrapMeasure[1] = i2;
                                    constraintWidget.wrapMeasure[3] = i2;
                                }
                                if (constraintWidget.mMatchConstraintMinWidth > 0) {
                                    iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                                } else {
                                    iMin = measuredWidth;
                                }
                                if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                                    iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                                }
                                if (constraintWidget.mMatchConstraintMinHeight > 0) {
                                    iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                                } else {
                                    iMin2 = measuredHeight;
                                }
                                if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                                    iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                                }
                                if (!z7) {
                                    if (z8) {
                                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                    }
                                } else if (z8) {
                                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                }
                                if (measuredWidth == iMin) {
                                    if (measuredWidth != iMin) {
                                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                    }
                                    if (measuredHeight != iMin2) {
                                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                    }
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                    measuredWidth2 = view.getMeasuredWidth();
                                    measuredHeight2 = view.getMeasuredHeight();
                                    baseline = view.getBaseline();
                                } else {
                                    if (measuredWidth != iMin) {
                                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                    }
                                    if (measuredHeight != iMin2) {
                                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                    }
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                    measuredWidth2 = view.getMeasuredWidth();
                                    measuredHeight2 = view.getMeasuredHeight();
                                    baseline = view.getBaseline();
                                }
                                i3 = -1;
                            } else {
                                if (!(view instanceof VirtualLayout)) {
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                } else {
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                }
                                measuredWidth = view.getMeasuredWidth();
                                measuredHeight = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                                if (z) {
                                    i2 = 0;
                                    constraintWidget.wrapMeasure[0] = measuredWidth;
                                    constraintWidget.wrapMeasure[2] = measuredHeight;
                                } else {
                                    i2 = 0;
                                    constraintWidget.wrapMeasure[0] = 0;
                                    constraintWidget.wrapMeasure[2] = 0;
                                }
                                if (z2) {
                                    constraintWidget.wrapMeasure[1] = measuredHeight;
                                    constraintWidget.wrapMeasure[3] = measuredWidth;
                                } else {
                                    constraintWidget.wrapMeasure[1] = i2;
                                    constraintWidget.wrapMeasure[3] = i2;
                                }
                                if (constraintWidget.mMatchConstraintMinWidth > 0) {
                                    iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                                } else {
                                    iMin = measuredWidth;
                                }
                                if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                                    iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                                }
                                if (constraintWidget.mMatchConstraintMinHeight > 0) {
                                    iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                                } else {
                                    iMin2 = measuredHeight;
                                }
                                if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                                    iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                                }
                                if (!z7) {
                                    if (z8) {
                                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                    }
                                } else if (z8) {
                                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                }
                                if (measuredWidth == iMin) {
                                    if (measuredWidth != iMin) {
                                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                    }
                                    if (measuredHeight != iMin2) {
                                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                    }
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                    measuredWidth2 = view.getMeasuredWidth();
                                    measuredHeight2 = view.getMeasuredHeight();
                                    baseline = view.getBaseline();
                                } else {
                                    if (measuredWidth != iMin) {
                                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                    }
                                    if (measuredHeight != iMin2) {
                                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                    }
                                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                    measuredWidth2 = view.getMeasuredWidth();
                                    measuredHeight2 = view.getMeasuredHeight();
                                    baseline = view.getBaseline();
                                }
                                i3 = -1;
                            }
                            if (baseline != i3) {
                                z9 = true;
                            } else {
                                z9 = false;
                            }
                            if (measuredWidth2 == measure.horizontalDimension) {
                                z10 = true;
                            } else {
                                z10 = true;
                            }
                            measure.measuredNeedsSolverPass = z10;
                            if (layoutParams.needsBaseline) {
                                z11 = true;
                            } else {
                                z11 = z9;
                            }
                            if (z11) {
                                measure.measuredNeedsSolverPass = true;
                            }
                            measure.measuredWidth = measuredWidth2;
                            measure.measuredHeight = measuredHeight2;
                            measure.measuredHasBaseline = z11;
                            measure.measuredBaseline = baseline;
                        }
                        iMakeMeasureSpec2 = childMeasureSpec2;
                    } else {
                        childMeasureSpec = ViewGroup.getChildMeasureSpec(this.layoutHeightSpec, i6, -2);
                        constraintWidget.wrapMeasure[3] = -2;
                    }
                    iMakeMeasureSpec2 = childMeasureSpec;
                    z2 = true;
                    if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                        z3 = true;
                    } else {
                        z3 = false;
                    }
                    if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                        z4 = true;
                    } else {
                        z4 = false;
                    }
                    if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                        z5 = true;
                    } else {
                        z5 = true;
                    }
                    if (dimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                        z6 = true;
                    } else {
                        z6 = true;
                    }
                    if (z3) {
                        z7 = false;
                    } else {
                        z7 = false;
                    }
                    if (z4) {
                        z8 = false;
                    } else {
                        z8 = false;
                    }
                    layoutParams = (LayoutParams) view.getLayoutParams();
                    if (measure.useCurrentDimensions) {
                        if (!(view instanceof VirtualLayout)) {
                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        } else {
                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        }
                        measuredWidth = view.getMeasuredWidth();
                        measuredHeight = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                        if (z) {
                            i2 = 0;
                            constraintWidget.wrapMeasure[0] = measuredWidth;
                            constraintWidget.wrapMeasure[2] = measuredHeight;
                        } else {
                            i2 = 0;
                            constraintWidget.wrapMeasure[0] = 0;
                            constraintWidget.wrapMeasure[2] = 0;
                        }
                        if (z2) {
                            constraintWidget.wrapMeasure[1] = measuredHeight;
                            constraintWidget.wrapMeasure[3] = measuredWidth;
                        } else {
                            constraintWidget.wrapMeasure[1] = i2;
                            constraintWidget.wrapMeasure[3] = i2;
                        }
                        if (constraintWidget.mMatchConstraintMinWidth > 0) {
                            iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                        } else {
                            iMin = measuredWidth;
                        }
                        if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                            iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                        }
                        if (constraintWidget.mMatchConstraintMinHeight > 0) {
                            iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                        } else {
                            iMin2 = measuredHeight;
                        }
                        if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                            iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                        }
                        if (!z7) {
                            if (z8) {
                                iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                            }
                        } else if (z8) {
                            iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                        }
                        if (measuredWidth == iMin) {
                            if (measuredWidth != iMin) {
                                iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                            }
                            if (measuredHeight != iMin2) {
                                iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                            }
                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            measuredWidth2 = view.getMeasuredWidth();
                            measuredHeight2 = view.getMeasuredHeight();
                            baseline = view.getBaseline();
                        } else {
                            if (measuredWidth != iMin) {
                                iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                            }
                            if (measuredHeight != iMin2) {
                                iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                            }
                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            measuredWidth2 = view.getMeasuredWidth();
                            measuredHeight2 = view.getMeasuredHeight();
                            baseline = view.getBaseline();
                        }
                        i3 = -1;
                    } else {
                        if (!(view instanceof VirtualLayout)) {
                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        } else {
                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        }
                        measuredWidth = view.getMeasuredWidth();
                        measuredHeight = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                        if (z) {
                            i2 = 0;
                            constraintWidget.wrapMeasure[0] = measuredWidth;
                            constraintWidget.wrapMeasure[2] = measuredHeight;
                        } else {
                            i2 = 0;
                            constraintWidget.wrapMeasure[0] = 0;
                            constraintWidget.wrapMeasure[2] = 0;
                        }
                        if (z2) {
                            constraintWidget.wrapMeasure[1] = measuredHeight;
                            constraintWidget.wrapMeasure[3] = measuredWidth;
                        } else {
                            constraintWidget.wrapMeasure[1] = i2;
                            constraintWidget.wrapMeasure[3] = i2;
                        }
                        if (constraintWidget.mMatchConstraintMinWidth > 0) {
                            iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                        } else {
                            iMin = measuredWidth;
                        }
                        if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                            iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                        }
                        if (constraintWidget.mMatchConstraintMinHeight > 0) {
                            iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                        } else {
                            iMin2 = measuredHeight;
                        }
                        if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                            iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                        }
                        if (!z7) {
                            if (z8) {
                                iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                            }
                        } else if (z8) {
                            iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                        }
                        if (measuredWidth == iMin) {
                            if (measuredWidth != iMin) {
                                iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                            }
                            if (measuredHeight != iMin2) {
                                iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                            }
                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            measuredWidth2 = view.getMeasuredWidth();
                            measuredHeight2 = view.getMeasuredHeight();
                            baseline = view.getBaseline();
                        } else {
                            if (measuredWidth != iMin) {
                                iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                            }
                            if (measuredHeight != iMin2) {
                                iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                            }
                            view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            measuredWidth2 = view.getMeasuredWidth();
                            measuredHeight2 = view.getMeasuredHeight();
                            baseline = view.getBaseline();
                        }
                        i3 = -1;
                    }
                    if (baseline != i3) {
                        z9 = true;
                    } else {
                        z9 = false;
                    }
                    if (measuredWidth2 == measure.horizontalDimension) {
                        z10 = true;
                    } else {
                        z10 = true;
                    }
                    measure.measuredNeedsSolverPass = z10;
                    if (layoutParams.needsBaseline) {
                        z11 = true;
                    } else {
                        z11 = z9;
                    }
                    if (z11) {
                        measure.measuredNeedsSolverPass = true;
                    }
                    measure.measuredWidth = measuredWidth2;
                    measure.measuredHeight = measuredHeight2;
                    measure.measuredHasBaseline = z11;
                    measure.measuredBaseline = baseline;
                }
                z2 = false;
                if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                    z3 = true;
                } else {
                    z3 = false;
                }
                if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                    z4 = true;
                } else {
                    z4 = false;
                }
                if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                    z5 = true;
                } else {
                    z5 = true;
                }
                if (dimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                    z6 = true;
                } else {
                    z6 = true;
                }
                if (z3) {
                    z7 = false;
                } else {
                    z7 = false;
                }
                if (z4) {
                    z8 = false;
                } else {
                    z8 = false;
                }
                layoutParams = (LayoutParams) view.getLayoutParams();
                if (measure.useCurrentDimensions) {
                    if (!(view instanceof VirtualLayout)) {
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    } else {
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    }
                    measuredWidth = view.getMeasuredWidth();
                    measuredHeight = view.getMeasuredHeight();
                    baseline = view.getBaseline();
                    if (z) {
                        i2 = 0;
                        constraintWidget.wrapMeasure[0] = measuredWidth;
                        constraintWidget.wrapMeasure[2] = measuredHeight;
                    } else {
                        i2 = 0;
                        constraintWidget.wrapMeasure[0] = 0;
                        constraintWidget.wrapMeasure[2] = 0;
                    }
                    if (z2) {
                        constraintWidget.wrapMeasure[1] = measuredHeight;
                        constraintWidget.wrapMeasure[3] = measuredWidth;
                    } else {
                        constraintWidget.wrapMeasure[1] = i2;
                        constraintWidget.wrapMeasure[3] = i2;
                    }
                    if (constraintWidget.mMatchConstraintMinWidth > 0) {
                        iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                    } else {
                        iMin = measuredWidth;
                    }
                    if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                        iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                    }
                    if (constraintWidget.mMatchConstraintMinHeight > 0) {
                        iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                    } else {
                        iMin2 = measuredHeight;
                    }
                    if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                        iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                    }
                    if (!z7) {
                        if (z8) {
                            iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                        }
                    } else if (z8) {
                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                    }
                    if (measuredWidth == iMin) {
                        if (measuredWidth != iMin) {
                            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                        }
                        if (measuredHeight != iMin2) {
                            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                        }
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        measuredWidth2 = view.getMeasuredWidth();
                        measuredHeight2 = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                    } else {
                        if (measuredWidth != iMin) {
                            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                        }
                        if (measuredHeight != iMin2) {
                            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                        }
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        measuredWidth2 = view.getMeasuredWidth();
                        measuredHeight2 = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                    }
                    i3 = -1;
                } else {
                    if (!(view instanceof VirtualLayout)) {
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    } else {
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    }
                    measuredWidth = view.getMeasuredWidth();
                    measuredHeight = view.getMeasuredHeight();
                    baseline = view.getBaseline();
                    if (z) {
                        i2 = 0;
                        constraintWidget.wrapMeasure[0] = measuredWidth;
                        constraintWidget.wrapMeasure[2] = measuredHeight;
                    } else {
                        i2 = 0;
                        constraintWidget.wrapMeasure[0] = 0;
                        constraintWidget.wrapMeasure[2] = 0;
                    }
                    if (z2) {
                        constraintWidget.wrapMeasure[1] = measuredHeight;
                        constraintWidget.wrapMeasure[3] = measuredWidth;
                    } else {
                        constraintWidget.wrapMeasure[1] = i2;
                        constraintWidget.wrapMeasure[3] = i2;
                    }
                    if (constraintWidget.mMatchConstraintMinWidth > 0) {
                        iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                    } else {
                        iMin = measuredWidth;
                    }
                    if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                        iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                    }
                    if (constraintWidget.mMatchConstraintMinHeight > 0) {
                        iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                    } else {
                        iMin2 = measuredHeight;
                    }
                    if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                        iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                    }
                    if (!z7) {
                        if (z8) {
                            iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                        }
                    } else if (z8) {
                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                    }
                    if (measuredWidth == iMin) {
                        if (measuredWidth != iMin) {
                            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                        }
                        if (measuredHeight != iMin2) {
                            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                        }
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        measuredWidth2 = view.getMeasuredWidth();
                        measuredHeight2 = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                    } else {
                        if (measuredWidth != iMin) {
                            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                        }
                        if (measuredHeight != iMin2) {
                            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                        }
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        measuredWidth2 = view.getMeasuredWidth();
                        measuredHeight2 = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                    }
                    i3 = -1;
                }
                if (baseline != i3) {
                    z9 = true;
                } else {
                    z9 = false;
                }
                if (measuredWidth2 == measure.horizontalDimension) {
                    z10 = true;
                } else {
                    z10 = true;
                }
                measure.measuredNeedsSolverPass = z10;
                if (layoutParams.needsBaseline) {
                    z11 = true;
                } else {
                    z11 = z9;
                }
                if (z11) {
                    measure.measuredNeedsSolverPass = true;
                }
                measure.measuredWidth = measuredWidth2;
                measure.measuredHeight = measuredHeight2;
                measure.measuredHasBaseline = z11;
                measure.measuredBaseline = baseline;
            }
            z = false;
            i = C00361.f373xdde91696[dimensionBehaviour2.ordinal()];
            if (i == 1) {
                iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(i5, BasicMeasure.EXACTLY);
                constraintWidget.wrapMeasure[3] = i5;
            } else {
                if (i != 2) {
                    if (i == 3) {
                        childMeasureSpec2 = ViewGroup.getChildMeasureSpec(this.layoutHeightSpec, i6 + constraintWidget.getVerticalMargin(), -1);
                        constraintWidget.wrapMeasure[3] = -1;
                    } else {
                        if (i != 4) {
                            z2 = false;
                            iMakeMeasureSpec2 = 0;
                        } else {
                            childMeasureSpec = ViewGroup.getChildMeasureSpec(this.layoutHeightSpec, i6, -2);
                            if (constraintWidget.mMatchConstraintDefaultHeight == 1) {
                                z12 = true;
                            } else {
                                z12 = false;
                            }
                            constraintWidget.wrapMeasure[3] = 0;
                            if (measure.useCurrentDimensions) {
                                if (z12) {
                                }
                                if (z12) {
                                }
                                childMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(constraintWidget.getHeight(), BasicMeasure.EXACTLY);
                            }
                        }
                        if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                            z3 = true;
                        } else {
                            z3 = false;
                        }
                        if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                            z4 = true;
                        } else {
                            z4 = false;
                        }
                        if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                            z5 = true;
                        } else {
                            z5 = true;
                        }
                        if (dimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                            z6 = true;
                        } else {
                            z6 = true;
                        }
                        if (z3) {
                            z7 = false;
                        } else {
                            z7 = false;
                        }
                        if (z4) {
                            z8 = false;
                        } else {
                            z8 = false;
                        }
                        layoutParams = (LayoutParams) view.getLayoutParams();
                        if (measure.useCurrentDimensions) {
                            if (!(view instanceof VirtualLayout)) {
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            } else {
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            }
                            measuredWidth = view.getMeasuredWidth();
                            measuredHeight = view.getMeasuredHeight();
                            baseline = view.getBaseline();
                            if (z) {
                                i2 = 0;
                                constraintWidget.wrapMeasure[0] = measuredWidth;
                                constraintWidget.wrapMeasure[2] = measuredHeight;
                            } else {
                                i2 = 0;
                                constraintWidget.wrapMeasure[0] = 0;
                                constraintWidget.wrapMeasure[2] = 0;
                            }
                            if (z2) {
                                constraintWidget.wrapMeasure[1] = measuredHeight;
                                constraintWidget.wrapMeasure[3] = measuredWidth;
                            } else {
                                constraintWidget.wrapMeasure[1] = i2;
                                constraintWidget.wrapMeasure[3] = i2;
                            }
                            if (constraintWidget.mMatchConstraintMinWidth > 0) {
                                iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                            } else {
                                iMin = measuredWidth;
                            }
                            if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                                iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                            }
                            if (constraintWidget.mMatchConstraintMinHeight > 0) {
                                iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                            } else {
                                iMin2 = measuredHeight;
                            }
                            if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                                iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                            }
                            if (!z7) {
                                if (z8) {
                                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                }
                            } else if (z8) {
                                iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                            }
                            if (measuredWidth == iMin) {
                                if (measuredWidth != iMin) {
                                    iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                }
                                if (measuredHeight != iMin2) {
                                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                }
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                measuredWidth2 = view.getMeasuredWidth();
                                measuredHeight2 = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                            } else {
                                if (measuredWidth != iMin) {
                                    iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                }
                                if (measuredHeight != iMin2) {
                                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                }
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                measuredWidth2 = view.getMeasuredWidth();
                                measuredHeight2 = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                            }
                            i3 = -1;
                        } else {
                            if (!(view instanceof VirtualLayout)) {
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            } else {
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                            }
                            measuredWidth = view.getMeasuredWidth();
                            measuredHeight = view.getMeasuredHeight();
                            baseline = view.getBaseline();
                            if (z) {
                                i2 = 0;
                                constraintWidget.wrapMeasure[0] = measuredWidth;
                                constraintWidget.wrapMeasure[2] = measuredHeight;
                            } else {
                                i2 = 0;
                                constraintWidget.wrapMeasure[0] = 0;
                                constraintWidget.wrapMeasure[2] = 0;
                            }
                            if (z2) {
                                constraintWidget.wrapMeasure[1] = measuredHeight;
                                constraintWidget.wrapMeasure[3] = measuredWidth;
                            } else {
                                constraintWidget.wrapMeasure[1] = i2;
                                constraintWidget.wrapMeasure[3] = i2;
                            }
                            if (constraintWidget.mMatchConstraintMinWidth > 0) {
                                iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                            } else {
                                iMin = measuredWidth;
                            }
                            if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                                iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                            }
                            if (constraintWidget.mMatchConstraintMinHeight > 0) {
                                iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                            } else {
                                iMin2 = measuredHeight;
                            }
                            if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                                iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                            }
                            if (!z7) {
                                if (z8) {
                                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                                }
                            } else if (z8) {
                                iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                            }
                            if (measuredWidth == iMin) {
                                if (measuredWidth != iMin) {
                                    iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                }
                                if (measuredHeight != iMin2) {
                                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                }
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                measuredWidth2 = view.getMeasuredWidth();
                                measuredHeight2 = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                            } else {
                                if (measuredWidth != iMin) {
                                    iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                                }
                                if (measuredHeight != iMin2) {
                                    iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                                }
                                view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                                measuredWidth2 = view.getMeasuredWidth();
                                measuredHeight2 = view.getMeasuredHeight();
                                baseline = view.getBaseline();
                            }
                            i3 = -1;
                        }
                        if (baseline != i3) {
                            z9 = true;
                        } else {
                            z9 = false;
                        }
                        if (measuredWidth2 == measure.horizontalDimension) {
                            z10 = true;
                        } else {
                            z10 = true;
                        }
                        measure.measuredNeedsSolverPass = z10;
                        if (layoutParams.needsBaseline) {
                            z11 = true;
                        } else {
                            z11 = z9;
                        }
                        if (z11) {
                            measure.measuredNeedsSolverPass = true;
                        }
                        measure.measuredWidth = measuredWidth2;
                        measure.measuredHeight = measuredHeight2;
                        measure.measuredHasBaseline = z11;
                        measure.measuredBaseline = baseline;
                    }
                    iMakeMeasureSpec2 = childMeasureSpec2;
                } else {
                    childMeasureSpec = ViewGroup.getChildMeasureSpec(this.layoutHeightSpec, i6, -2);
                    constraintWidget.wrapMeasure[3] = -2;
                }
                iMakeMeasureSpec2 = childMeasureSpec;
                z2 = true;
                if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                    z3 = true;
                } else {
                    z3 = false;
                }
                if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                    z4 = true;
                } else {
                    z4 = false;
                }
                if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                    z5 = true;
                } else {
                    z5 = true;
                }
                if (dimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                    z6 = true;
                } else {
                    z6 = true;
                }
                if (z3) {
                    z7 = false;
                } else {
                    z7 = false;
                }
                if (z4) {
                    z8 = false;
                } else {
                    z8 = false;
                }
                layoutParams = (LayoutParams) view.getLayoutParams();
                if (measure.useCurrentDimensions) {
                    if (!(view instanceof VirtualLayout)) {
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    } else {
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    }
                    measuredWidth = view.getMeasuredWidth();
                    measuredHeight = view.getMeasuredHeight();
                    baseline = view.getBaseline();
                    if (z) {
                        i2 = 0;
                        constraintWidget.wrapMeasure[0] = measuredWidth;
                        constraintWidget.wrapMeasure[2] = measuredHeight;
                    } else {
                        i2 = 0;
                        constraintWidget.wrapMeasure[0] = 0;
                        constraintWidget.wrapMeasure[2] = 0;
                    }
                    if (z2) {
                        constraintWidget.wrapMeasure[1] = measuredHeight;
                        constraintWidget.wrapMeasure[3] = measuredWidth;
                    } else {
                        constraintWidget.wrapMeasure[1] = i2;
                        constraintWidget.wrapMeasure[3] = i2;
                    }
                    if (constraintWidget.mMatchConstraintMinWidth > 0) {
                        iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                    } else {
                        iMin = measuredWidth;
                    }
                    if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                        iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                    }
                    if (constraintWidget.mMatchConstraintMinHeight > 0) {
                        iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                    } else {
                        iMin2 = measuredHeight;
                    }
                    if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                        iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                    }
                    if (!z7) {
                        if (z8) {
                            iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                        }
                    } else if (z8) {
                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                    }
                    if (measuredWidth == iMin) {
                        if (measuredWidth != iMin) {
                            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                        }
                        if (measuredHeight != iMin2) {
                            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                        }
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        measuredWidth2 = view.getMeasuredWidth();
                        measuredHeight2 = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                    } else {
                        if (measuredWidth != iMin) {
                            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                        }
                        if (measuredHeight != iMin2) {
                            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                        }
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        measuredWidth2 = view.getMeasuredWidth();
                        measuredHeight2 = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                    }
                    i3 = -1;
                } else {
                    if (!(view instanceof VirtualLayout)) {
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    } else {
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    }
                    measuredWidth = view.getMeasuredWidth();
                    measuredHeight = view.getMeasuredHeight();
                    baseline = view.getBaseline();
                    if (z) {
                        i2 = 0;
                        constraintWidget.wrapMeasure[0] = measuredWidth;
                        constraintWidget.wrapMeasure[2] = measuredHeight;
                    } else {
                        i2 = 0;
                        constraintWidget.wrapMeasure[0] = 0;
                        constraintWidget.wrapMeasure[2] = 0;
                    }
                    if (z2) {
                        constraintWidget.wrapMeasure[1] = measuredHeight;
                        constraintWidget.wrapMeasure[3] = measuredWidth;
                    } else {
                        constraintWidget.wrapMeasure[1] = i2;
                        constraintWidget.wrapMeasure[3] = i2;
                    }
                    if (constraintWidget.mMatchConstraintMinWidth > 0) {
                        iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                    } else {
                        iMin = measuredWidth;
                    }
                    if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                        iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                    }
                    if (constraintWidget.mMatchConstraintMinHeight > 0) {
                        iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                    } else {
                        iMin2 = measuredHeight;
                    }
                    if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                        iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                    }
                    if (!z7) {
                        if (z8) {
                            iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                        }
                    } else if (z8) {
                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                    }
                    if (measuredWidth == iMin) {
                        if (measuredWidth != iMin) {
                            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                        }
                        if (measuredHeight != iMin2) {
                            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                        }
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        measuredWidth2 = view.getMeasuredWidth();
                        measuredHeight2 = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                    } else {
                        if (measuredWidth != iMin) {
                            iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                        }
                        if (measuredHeight != iMin2) {
                            iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                        }
                        view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                        measuredWidth2 = view.getMeasuredWidth();
                        measuredHeight2 = view.getMeasuredHeight();
                        baseline = view.getBaseline();
                    }
                    i3 = -1;
                }
                if (baseline != i3) {
                    z9 = true;
                } else {
                    z9 = false;
                }
                if (measuredWidth2 == measure.horizontalDimension) {
                    z10 = true;
                } else {
                    z10 = true;
                }
                measure.measuredNeedsSolverPass = z10;
                if (layoutParams.needsBaseline) {
                    z11 = true;
                } else {
                    z11 = z9;
                }
                if (z11) {
                    measure.measuredNeedsSolverPass = true;
                }
                measure.measuredWidth = measuredWidth2;
                measure.measuredHeight = measuredHeight2;
                measure.measuredHasBaseline = z11;
                measure.measuredBaseline = baseline;
            }
            z2 = false;
            if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                z3 = true;
            } else {
                z3 = false;
            }
            if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                z4 = true;
            } else {
                z4 = false;
            }
            if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                z5 = true;
            } else {
                z5 = true;
            }
            if (dimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_PARENT) {
                z6 = true;
            } else {
                z6 = true;
            }
            if (z3) {
                z7 = false;
            } else {
                z7 = false;
            }
            if (z4) {
                z8 = false;
            } else {
                z8 = false;
            }
            layoutParams = (LayoutParams) view.getLayoutParams();
            if (measure.useCurrentDimensions) {
                if (!(view instanceof VirtualLayout)) {
                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                } else {
                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                }
                measuredWidth = view.getMeasuredWidth();
                measuredHeight = view.getMeasuredHeight();
                baseline = view.getBaseline();
                if (z) {
                    i2 = 0;
                    constraintWidget.wrapMeasure[0] = measuredWidth;
                    constraintWidget.wrapMeasure[2] = measuredHeight;
                } else {
                    i2 = 0;
                    constraintWidget.wrapMeasure[0] = 0;
                    constraintWidget.wrapMeasure[2] = 0;
                }
                if (z2) {
                    constraintWidget.wrapMeasure[1] = measuredHeight;
                    constraintWidget.wrapMeasure[3] = measuredWidth;
                } else {
                    constraintWidget.wrapMeasure[1] = i2;
                    constraintWidget.wrapMeasure[3] = i2;
                }
                if (constraintWidget.mMatchConstraintMinWidth > 0) {
                    iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                } else {
                    iMin = measuredWidth;
                }
                if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                    iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                }
                if (constraintWidget.mMatchConstraintMinHeight > 0) {
                    iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                } else {
                    iMin2 = measuredHeight;
                }
                if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                    iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                }
                if (!z7) {
                    if (z8) {
                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                    }
                } else if (z8) {
                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                }
                if (measuredWidth == iMin) {
                    if (measuredWidth != iMin) {
                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                    }
                    if (measuredHeight != iMin2) {
                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                    }
                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    measuredWidth2 = view.getMeasuredWidth();
                    measuredHeight2 = view.getMeasuredHeight();
                    baseline = view.getBaseline();
                } else {
                    if (measuredWidth != iMin) {
                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                    }
                    if (measuredHeight != iMin2) {
                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                    }
                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    measuredWidth2 = view.getMeasuredWidth();
                    measuredHeight2 = view.getMeasuredHeight();
                    baseline = view.getBaseline();
                }
                i3 = -1;
            } else {
                if (!(view instanceof VirtualLayout)) {
                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                } else {
                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                }
                measuredWidth = view.getMeasuredWidth();
                measuredHeight = view.getMeasuredHeight();
                baseline = view.getBaseline();
                if (z) {
                    i2 = 0;
                    constraintWidget.wrapMeasure[0] = measuredWidth;
                    constraintWidget.wrapMeasure[2] = measuredHeight;
                } else {
                    i2 = 0;
                    constraintWidget.wrapMeasure[0] = 0;
                    constraintWidget.wrapMeasure[2] = 0;
                }
                if (z2) {
                    constraintWidget.wrapMeasure[1] = measuredHeight;
                    constraintWidget.wrapMeasure[3] = measuredWidth;
                } else {
                    constraintWidget.wrapMeasure[1] = i2;
                    constraintWidget.wrapMeasure[3] = i2;
                }
                if (constraintWidget.mMatchConstraintMinWidth > 0) {
                    iMin = Math.max(constraintWidget.mMatchConstraintMinWidth, measuredWidth);
                } else {
                    iMin = measuredWidth;
                }
                if (constraintWidget.mMatchConstraintMaxWidth > 0) {
                    iMin = Math.min(constraintWidget.mMatchConstraintMaxWidth, iMin);
                }
                if (constraintWidget.mMatchConstraintMinHeight > 0) {
                    iMin2 = Math.max(constraintWidget.mMatchConstraintMinHeight, measuredHeight);
                } else {
                    iMin2 = measuredHeight;
                }
                if (constraintWidget.mMatchConstraintMaxHeight > 0) {
                    iMin2 = Math.min(constraintWidget.mMatchConstraintMaxHeight, iMin2);
                }
                if (!z7) {
                    if (z8) {
                        iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                    }
                } else if (z8) {
                    iMin2 = (int) ((iMin / constraintWidget.mDimensionRatio) + 0.5f);
                }
                if (measuredWidth == iMin) {
                    if (measuredWidth != iMin) {
                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                    }
                    if (measuredHeight != iMin2) {
                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                    }
                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    measuredWidth2 = view.getMeasuredWidth();
                    measuredHeight2 = view.getMeasuredHeight();
                    baseline = view.getBaseline();
                } else {
                    if (measuredWidth != iMin) {
                        iMakeMeasureSpec = View.MeasureSpec.makeMeasureSpec(iMin, BasicMeasure.EXACTLY);
                    }
                    if (measuredHeight != iMin2) {
                        iMakeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(iMin2, BasicMeasure.EXACTLY);
                    }
                    view.measure(iMakeMeasureSpec, iMakeMeasureSpec2);
                    measuredWidth2 = view.getMeasuredWidth();
                    measuredHeight2 = view.getMeasuredHeight();
                    baseline = view.getBaseline();
                }
                i3 = -1;
            }
            if (baseline != i3) {
                z9 = true;
            } else {
                z9 = false;
            }
            if (measuredWidth2 == measure.horizontalDimension) {
                z10 = true;
            } else {
                z10 = true;
            }
            measure.measuredNeedsSolverPass = z10;
            if (layoutParams.needsBaseline) {
                z11 = true;
            } else {
                z11 = z9;
            }
            if (z11) {
                measure.measuredNeedsSolverPass = true;
            }
            measure.measuredWidth = measuredWidth2;
            measure.measuredHeight = measuredHeight2;
            measure.measuredHasBaseline = z11;
            measure.measuredBaseline = baseline;
        }

        @Override // androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure.Measurer
        public final void didMeasures() {
            int childCount = this.layout.getChildCount();
            for (int i = 0; i < childCount; i++) {
                View childAt = this.layout.getChildAt(i);
                if (childAt instanceof Placeholder) {
                    ((Placeholder) childAt).updatePostMeasure(this.layout);
                }
            }
            int size = ConstraintLayout.access$000(this.layout).size();
            if (size > 0) {
                for (int i2 = 0; i2 < size; i2++) {
                    ((ConstraintHelper) ConstraintLayout.access$000(this.layout).get(i2)).updatePostMeasure(this.layout);
                }
            }
        }
    }

    /* JADX INFO: renamed from: androidx.constraintlayout.widget.ConstraintLayout$1 */
    static /* synthetic */ class C00361 {

        /* JADX INFO: renamed from: $SwitchMap$androidx$constraintlayout$solver$widgets$ConstraintWidget$DimensionBehaviour */
        static final /* synthetic */ int[] f373xdde91696;

        static {
            int[] iArr = new int[ConstraintWidget.DimensionBehaviour.values().length];
            f373xdde91696 = iArr;
            try {
                iArr[ConstraintWidget.DimensionBehaviour.FIXED.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f373xdde91696[ConstraintWidget.DimensionBehaviour.WRAP_CONTENT.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f373xdde91696[ConstraintWidget.DimensionBehaviour.MATCH_PARENT.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                f373xdde91696[ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
        }
    }
}
