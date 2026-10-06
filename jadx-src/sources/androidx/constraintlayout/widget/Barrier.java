package androidx.constraintlayout.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.util.SparseArray;
import d1.f;
import d1.l;
import j1.g;
import j1.m;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public class Barrier extends ConstraintHelper {

    /* JADX INFO: renamed from: i */
    public int f343i;

    /* JADX INFO: renamed from: j */
    public int f344j;

    /* JADX INFO: renamed from: k */
    public d1.a f345k;

    public Barrier(Context context) {
        super(context);
        this.f347a = new int[32];
        this.f353g = null;
        this.f354h = new HashMap();
        this.f349c = context;
        mo24k(null);
        super.setVisibility(8);
    }

    public boolean getAllowsGoneWidget() {
        return this.f345k.x0;
    }

    public int getMargin() {
        return this.f345k.y0;
    }

    public int getType() {
        return this.f343i;
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: k */
    public final void mo24k(AttributeSet attributeSet) {
        super.mo24k(attributeSet);
        this.f345k = new d1.a();
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.c);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 26) {
                    setType(typedArrayObtainStyledAttributes.getInt(index, 0));
                } else if (index == 25) {
                    this.f345k.x0 = typedArrayObtainStyledAttributes.getBoolean(index, true);
                } else if (index == 27) {
                    this.f345k.y0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
        this.f350d = this.f345k;
        m107q();
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: l */
    public final void mo27l(C0040c c0040c, l lVar, Constraints.LayoutParams layoutParams, SparseArray sparseArray) {
        super.mo27l(c0040c, lVar, layoutParams, sparseArray);
        if (lVar instanceof d1.a) {
            d1.a aVar = (d1.a) lVar;
            boolean z = ((f) lVar).V.z0;
            g gVar = c0040c.f544e;
            m98r(aVar, gVar.g0, z);
            aVar.x0 = gVar.o0;
            aVar.y0 = gVar.h0;
        }
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: m */
    public final void mo28m(f fVar, boolean z) {
        m98r(fVar, this.f343i, z);
    }

    /* JADX INFO: renamed from: r */
    public final void m98r(f fVar, int i, boolean z) {
        this.f344j = i;
        if (z) {
            int i2 = this.f343i;
            if (i2 == 5) {
                this.f344j = 1;
            } else if (i2 == 6) {
                this.f344j = 0;
            }
        } else {
            int i3 = this.f343i;
            if (i3 == 5) {
                this.f344j = 0;
            } else if (i3 == 6) {
                this.f344j = 1;
            }
        }
        if (fVar instanceof d1.a) {
            ((d1.a) fVar).w0 = this.f344j;
        }
    }

    public void setAllowsGoneWidget(boolean z) {
        this.f345k.x0 = z;
    }

    public void setDpMargin(int i) {
        this.f345k.y0 = (int) ((i * getResources().getDisplayMetrics().density) + 0.5f);
    }

    public void setMargin(int i) {
        this.f345k.y0 = i;
    }

    public void setType(int i) {
        this.f343i = i;
    }

    public Barrier(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        super.setVisibility(8);
    }

    public Barrier(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        super.setVisibility(8);
    }
}
