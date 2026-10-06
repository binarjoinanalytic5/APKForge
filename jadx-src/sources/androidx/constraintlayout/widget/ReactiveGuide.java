package androidx.constraintlayout.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.util.AttributeSet;
import android.view.View;
import j1.m;
import j1.n;
import j1.o;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashSet;

/* JADX INFO: loaded from: classes.dex */
public class ReactiveGuide extends View implements n {

    /* JADX INFO: renamed from: a */
    public int f525a;

    /* JADX INFO: renamed from: b */
    public boolean f526b;

    /* JADX INFO: renamed from: c */
    public int f527c;

    /* JADX INFO: renamed from: d */
    public boolean f528d;

    public ReactiveGuide(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f525a = -1;
        this.f526b = false;
        this.f527c = 0;
        this.f528d = true;
        super.setVisibility(8);
        m118a(attributeSet);
    }

    /* JADX INFO: renamed from: a */
    public final void m118a(AttributeSet attributeSet) {
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.d);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 3) {
                    this.f525a = typedArrayObtainStyledAttributes.getResourceId(index, this.f525a);
                } else if (index == 0) {
                    this.f526b = typedArrayObtainStyledAttributes.getBoolean(index, this.f526b);
                } else if (index == 2) {
                    this.f527c = typedArrayObtainStyledAttributes.getResourceId(index, this.f527c);
                } else if (index == 1) {
                    this.f528d = typedArrayObtainStyledAttributes.getBoolean(index, this.f528d);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
        if (this.f525a != -1) {
            ConstraintLayout.getSharedValues().a(this.f525a, this);
        }
    }

    @Override // android.view.View
    public final void draw(Canvas canvas) {
    }

    public int getApplyToConstraintSetId() {
        return this.f527c;
    }

    public int getAttributeId() {
        return this.f525a;
    }

    @Override // android.view.View
    public final void onMeasure(int i, int i2) {
        setMeasuredDimension(0, 0);
    }

    public void setAnimateChange(boolean z) {
        this.f526b = z;
    }

    public void setApplyToConstraintSetId(int i) {
        this.f527c = i;
    }

    public void setAttributeId(int i) {
        HashSet<WeakReference> hashSet;
        o sharedValues = ConstraintLayout.getSharedValues();
        int i2 = this.f525a;
        if (i2 != -1 && (hashSet = (HashSet) sharedValues.a.get(Integer.valueOf(i2))) != null) {
            ArrayList arrayList = new ArrayList();
            for (WeakReference weakReference : hashSet) {
                n nVar = (n) weakReference.get();
                if (nVar == null || nVar == this) {
                    arrayList.add(weakReference);
                }
            }
            hashSet.removeAll(arrayList);
        }
        this.f525a = i;
        if (i != -1) {
            sharedValues.a(i, this);
        }
    }

    public void setGuidelineBegin(int i) {
        ConstraintLayout.LayoutParams layoutParams = (ConstraintLayout.LayoutParams) getLayoutParams();
        layoutParams.f400a = i;
        setLayoutParams(layoutParams);
    }

    public void setGuidelineEnd(int i) {
        ConstraintLayout.LayoutParams layoutParams = (ConstraintLayout.LayoutParams) getLayoutParams();
        layoutParams.f402b = i;
        setLayoutParams(layoutParams);
    }

    public void setGuidelinePercent(float f) {
        ConstraintLayout.LayoutParams layoutParams = (ConstraintLayout.LayoutParams) getLayoutParams();
        layoutParams.f404c = f;
        setLayoutParams(layoutParams);
    }

    @Override // android.view.View
    public void setVisibility(int i) {
    }

    public ReactiveGuide(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f525a = -1;
        this.f526b = false;
        this.f527c = 0;
        this.f528d = true;
        super.setVisibility(8);
        m118a(attributeSet);
    }
}
