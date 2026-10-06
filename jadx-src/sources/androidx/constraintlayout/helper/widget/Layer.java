package androidx.constraintlayout.helper.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.view.View;
import androidx.constraintlayout.widget.ConstraintHelper;
import androidx.constraintlayout.widget.ConstraintLayout;
import d1.f;
import j1.m;

/* JADX INFO: loaded from: classes.dex */
public class Layer extends ConstraintHelper {

    /* JADX INFO: renamed from: i */
    public float f56i;

    /* JADX INFO: renamed from: j */
    public float f57j;

    /* JADX INFO: renamed from: k */
    public float f58k;

    /* JADX INFO: renamed from: l */
    public ConstraintLayout f59l;

    /* JADX INFO: renamed from: m */
    public float f60m;

    /* JADX INFO: renamed from: n */
    public float f61n;

    /* JADX INFO: renamed from: o */
    public float f62o;

    /* JADX INFO: renamed from: p */
    public float f63p;

    /* JADX INFO: renamed from: q */
    public float f64q;

    /* JADX INFO: renamed from: r */
    public float f65r;

    /* JADX INFO: renamed from: s */
    public float f66s;

    /* JADX INFO: renamed from: t */
    public float f67t;

    /* JADX INFO: renamed from: u */
    public final boolean f68u;

    /* JADX INFO: renamed from: v */
    public View[] f69v;

    /* JADX INFO: renamed from: w */
    public float f70w;

    /* JADX INFO: renamed from: x */
    public float f71x;

    /* JADX INFO: renamed from: y */
    public boolean f72y;

    /* JADX INFO: renamed from: z */
    public boolean f73z;

    public Layer(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f56i = Float.NaN;
        this.f57j = Float.NaN;
        this.f58k = Float.NaN;
        this.f60m = 1.0f;
        this.f61n = 1.0f;
        this.f62o = Float.NaN;
        this.f63p = Float.NaN;
        this.f64q = Float.NaN;
        this.f65r = Float.NaN;
        this.f66s = Float.NaN;
        this.f67t = Float.NaN;
        this.f68u = true;
        this.f69v = null;
        this.f70w = 0.0f;
        this.f71x = 0.0f;
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: g */
    public final void mo30g(ConstraintLayout constraintLayout) {
        m103f(constraintLayout);
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: k */
    public final void mo24k(AttributeSet attributeSet) {
        super.mo24k(attributeSet);
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.c);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 6) {
                    this.f72y = true;
                } else if (index == 22) {
                    this.f73z = true;
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: n */
    public final void mo31n() {
        m34s();
        this.f62o = Float.NaN;
        this.f63p = Float.NaN;
        f fVar = ((ConstraintLayout.LayoutParams) getLayoutParams()).f433q0;
        fVar.P(0);
        fVar.M(0);
        m33r();
        layout(((int) this.f66s) - getPaddingLeft(), ((int) this.f67t) - getPaddingTop(), getPaddingRight() + ((int) this.f64q), getPaddingBottom() + ((int) this.f65r));
        m35t();
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: o */
    public final void mo32o(ConstraintLayout constraintLayout) {
        this.f59l = constraintLayout;
        float rotation = getRotation();
        if (rotation != 0.0f) {
            this.f58k = rotation;
        } else {
            if (Float.isNaN(this.f58k)) {
                return;
            }
            this.f58k = rotation;
        }
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper, android.view.View
    public final void onAttachedToWindow() {
        super.onAttachedToWindow();
        this.f59l = (ConstraintLayout) getParent();
        if (this.f72y || this.f73z) {
            int visibility = getVisibility();
            float elevation = getElevation();
            for (int i = 0; i < this.f348b; i++) {
                View viewM109f = this.f59l.m109f(this.f347a[i]);
                if (viewM109f != null) {
                    if (this.f72y) {
                        viewM109f.setVisibility(visibility);
                    }
                    if (this.f73z && elevation > 0.0f) {
                        viewM109f.setTranslationZ(viewM109f.getTranslationZ() + elevation);
                    }
                }
            }
        }
    }

    /* JADX INFO: renamed from: r */
    public final void m33r() {
        if (this.f59l == null) {
            return;
        }
        if (this.f68u || Float.isNaN(this.f62o) || Float.isNaN(this.f63p)) {
            if (!Float.isNaN(this.f56i) && !Float.isNaN(this.f57j)) {
                this.f63p = this.f57j;
                this.f62o = this.f56i;
                return;
            }
            View[] viewArrM106j = m106j(this.f59l);
            int left = viewArrM106j[0].getLeft();
            int top = viewArrM106j[0].getTop();
            int right = viewArrM106j[0].getRight();
            int bottom = viewArrM106j[0].getBottom();
            for (int i = 0; i < this.f348b; i++) {
                View view = viewArrM106j[i];
                left = Math.min(left, view.getLeft());
                top = Math.min(top, view.getTop());
                right = Math.max(right, view.getRight());
                bottom = Math.max(bottom, view.getBottom());
            }
            this.f64q = right;
            this.f65r = bottom;
            this.f66s = left;
            this.f67t = top;
            if (Float.isNaN(this.f56i)) {
                this.f62o = (left + right) / 2;
            } else {
                this.f62o = this.f56i;
            }
            if (Float.isNaN(this.f57j)) {
                this.f63p = (top + bottom) / 2;
            } else {
                this.f63p = this.f57j;
            }
        }
    }

    /* JADX INFO: renamed from: s */
    public final void m34s() {
        int i;
        if (this.f59l == null || (i = this.f348b) == 0) {
            return;
        }
        View[] viewArr = this.f69v;
        if (viewArr == null || viewArr.length != i) {
            this.f69v = new View[i];
        }
        for (int i2 = 0; i2 < this.f348b; i2++) {
            this.f69v[i2] = this.f59l.m109f(this.f347a[i2]);
        }
    }

    @Override // android.view.View
    public void setElevation(float f) {
        super.setElevation(f);
        m102e();
    }

    @Override // android.view.View
    public void setPivotX(float f) {
        this.f56i = f;
        m35t();
    }

    @Override // android.view.View
    public void setPivotY(float f) {
        this.f57j = f;
        m35t();
    }

    @Override // android.view.View
    public void setRotation(float f) {
        this.f58k = f;
        m35t();
    }

    @Override // android.view.View
    public void setScaleX(float f) {
        this.f60m = f;
        m35t();
    }

    @Override // android.view.View
    public void setScaleY(float f) {
        this.f61n = f;
        m35t();
    }

    @Override // android.view.View
    public void setTranslationX(float f) {
        this.f70w = f;
        m35t();
    }

    @Override // android.view.View
    public void setTranslationY(float f) {
        this.f71x = f;
        m35t();
    }

    @Override // android.view.View
    public void setVisibility(int i) {
        super.setVisibility(i);
        m102e();
    }

    /* JADX INFO: renamed from: t */
    public final void m35t() {
        if (this.f59l == null) {
            return;
        }
        if (this.f69v == null) {
            m34s();
        }
        m33r();
        double radians = Float.isNaN(this.f58k) ? 0.0d : Math.toRadians(this.f58k);
        float fSin = (float) Math.sin(radians);
        float fCos = (float) Math.cos(radians);
        float f = this.f60m;
        float f2 = f * fCos;
        float f3 = this.f61n;
        float f4 = (-f3) * fSin;
        float f5 = f * fSin;
        float f6 = f3 * fCos;
        for (int i = 0; i < this.f348b; i++) {
            View view = this.f69v[i];
            int right = (view.getRight() + view.getLeft()) / 2;
            int bottom = (view.getBottom() + view.getTop()) / 2;
            float f7 = right - this.f62o;
            float f8 = bottom - this.f63p;
            float f9 = (((f4 * f8) + (f2 * f7)) - f7) + this.f70w;
            float f10 = (((f6 * f8) + (f7 * f5)) - f8) + this.f71x;
            view.setTranslationX(f9);
            view.setTranslationY(f10);
            view.setScaleY(this.f61n);
            view.setScaleX(this.f60m);
            if (!Float.isNaN(this.f58k)) {
                view.setRotation(this.f58k);
            }
        }
    }

    public Layer(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f56i = Float.NaN;
        this.f57j = Float.NaN;
        this.f58k = Float.NaN;
        this.f60m = 1.0f;
        this.f61n = 1.0f;
        this.f62o = Float.NaN;
        this.f63p = Float.NaN;
        this.f64q = Float.NaN;
        this.f65r = Float.NaN;
        this.f66s = Float.NaN;
        this.f67t = Float.NaN;
        this.f68u = true;
        this.f69v = null;
        this.f70w = 0.0f;
        this.f71x = 0.0f;
    }
}
