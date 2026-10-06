package androidx.constraintlayout.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewParent;
import d1.o;
import j1.m;

/* JADX INFO: loaded from: classes.dex */
public abstract class VirtualLayout extends ConstraintHelper {

    /* JADX INFO: renamed from: i */
    public boolean f529i;

    /* JADX INFO: renamed from: j */
    public boolean f530j;

    public VirtualLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: g */
    public final void mo30g(ConstraintLayout constraintLayout) {
        m103f(constraintLayout);
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: k */
    public void mo24k(AttributeSet attributeSet) {
        super.mo24k(attributeSet);
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.c);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 6) {
                    this.f529i = true;
                } else if (index == 22) {
                    this.f530j = true;
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper, android.view.View
    public void onAttachedToWindow() {
        super.onAttachedToWindow();
        if (this.f529i || this.f530j) {
            ViewParent parent = getParent();
            if (parent instanceof ConstraintLayout) {
                ConstraintLayout constraintLayout = (ConstraintLayout) parent;
                int visibility = getVisibility();
                float elevation = getElevation();
                for (int i = 0; i < this.f348b; i++) {
                    View viewM109f = constraintLayout.m109f(this.f347a[i]);
                    if (viewM109f != null) {
                        if (this.f529i) {
                            viewM109f.setVisibility(visibility);
                        }
                        if (this.f530j && elevation > 0.0f) {
                            viewM109f.setTranslationZ(viewM109f.getTranslationZ() + elevation);
                        }
                    }
                }
            }
        }
    }

    /* JADX INFO: renamed from: r */
    public void mo29r(o oVar, int i, int i2) {
    }

    @Override // android.view.View
    public void setElevation(float f) {
        super.setElevation(f);
        m102e();
    }

    @Override // android.view.View
    public void setVisibility(int i) {
        super.setVisibility(i);
        m102e();
    }

    public VirtualLayout(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }
}
