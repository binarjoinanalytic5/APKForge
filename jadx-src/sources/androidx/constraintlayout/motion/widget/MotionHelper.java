package androidx.constraintlayout.motion.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import androidx.constraintlayout.widget.ConstraintHelper;
import androidx.constraintlayout.widget.ConstraintLayout;
import h1.u;
import j1.m;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public class MotionHelper extends ConstraintHelper implements u {

    /* JADX INFO: renamed from: i */
    public boolean f96i;

    /* JADX INFO: renamed from: j */
    public boolean f97j;

    /* JADX INFO: renamed from: k */
    public float f98k;

    /* JADX INFO: renamed from: l */
    public View[] f99l;

    public MotionHelper(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f96i = false;
        this.f97j = false;
        mo24k(attributeSet);
    }

    /* JADX INFO: renamed from: a */
    public void mo22a(int i) {
    }

    public float getProgress() {
        return this.f98k;
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: k */
    public final void mo24k(AttributeSet attributeSet) {
        super.mo24k(attributeSet);
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.p);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 1) {
                    this.f96i = typedArrayObtainStyledAttributes.getBoolean(index, this.f96i);
                } else if (index == 0) {
                    this.f97j = typedArrayObtainStyledAttributes.getBoolean(index, this.f97j);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    /* JADX INFO: renamed from: r */
    public void mo36r(MotionLayout motionLayout, HashMap map) {
    }

    public void setProgress(float f) {
        this.f98k = f;
        int i = 0;
        if (this.f348b > 0) {
            this.f99l = m106j((ConstraintLayout) getParent());
            while (i < this.f348b) {
                View view = this.f99l[i];
                i++;
            }
            return;
        }
        ViewGroup viewGroup = (ViewGroup) getParent();
        int childCount = viewGroup.getChildCount();
        while (i < childCount) {
            boolean z = viewGroup.getChildAt(i) instanceof MotionHelper;
            i++;
        }
    }

    public MotionHelper(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f96i = false;
        this.f97j = false;
        mo24k(attributeSet);
    }
}
