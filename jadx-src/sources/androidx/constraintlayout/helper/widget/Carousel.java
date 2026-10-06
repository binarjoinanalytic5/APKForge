package androidx.constraintlayout.helper.widget;

import ai.g;
import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import androidx.constraintlayout.motion.widget.C0017d;
import androidx.constraintlayout.motion.widget.MotionHelper;
import androidx.constraintlayout.motion.widget.MotionLayout;
import f1.a;
import h1.x;
import j1.m;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class Carousel extends MotionHelper {

    /* JADX INFO: renamed from: m */
    public final ArrayList f30m;

    /* JADX INFO: renamed from: n */
    public int f31n;

    /* JADX INFO: renamed from: o */
    public MotionLayout f32o;

    /* JADX INFO: renamed from: p */
    public int f33p;

    /* JADX INFO: renamed from: q */
    public boolean f34q;

    /* JADX INFO: renamed from: r */
    public int f35r;

    /* JADX INFO: renamed from: s */
    public int f36s;

    /* JADX INFO: renamed from: t */
    public int f37t;

    /* JADX INFO: renamed from: u */
    public int f38u;

    /* JADX INFO: renamed from: v */
    public float f39v;

    /* JADX INFO: renamed from: w */
    public int f40w;

    /* JADX INFO: renamed from: x */
    public int f41x;

    /* JADX INFO: renamed from: y */
    public float f42y;

    public Carousel(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f30m = new ArrayList();
        this.f31n = 0;
        this.f33p = -1;
        this.f34q = false;
        this.f35r = -1;
        this.f36s = -1;
        this.f37t = -1;
        this.f38u = -1;
        this.f39v = 0.9f;
        this.f40w = 4;
        this.f41x = 1;
        this.f42y = 2.0f;
        new g(this, 26);
        m23s(context, attributeSet);
    }

    @Override // androidx.constraintlayout.motion.widget.MotionHelper
    /* JADX INFO: renamed from: a */
    public final void mo22a(int i) {
        int i2 = this.f31n;
        if (i == this.f38u) {
            this.f31n = i2 + 1;
        } else if (i == this.f37t) {
            this.f31n = i2 - 1;
        }
        if (!this.f34q) {
            throw null;
        }
        throw null;
    }

    public int getCount() {
        return 0;
    }

    public int getCurrentIndex() {
        return this.f31n;
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper, android.view.View
    public final void onAttachedToWindow() {
        C0017d c0017d;
        C0017d c0017d2;
        super.onAttachedToWindow();
        if (getParent() instanceof MotionLayout) {
            MotionLayout motionLayout = (MotionLayout) getParent();
            for (int i = 0; i < this.f348b; i++) {
                this.f30m.add(motionLayout.m109f(this.f347a[i]));
            }
            this.f32o = motionLayout;
            if (this.f41x == 2) {
                x xVarM63x = motionLayout.m63x(this.f36s);
                if (xVarM63x != null && (c0017d2 = xVarM63x.l) != null) {
                    c0017d2.f203c = 5;
                }
                x xVarM63x2 = this.f32o.m63x(this.f35r);
                if (xVarM63x2 == null || (c0017d = xVarM63x2.l) == null) {
                    return;
                }
                c0017d.f203c = 5;
            }
        }
    }

    /* JADX INFO: renamed from: s */
    public final void m23s(Context context, AttributeSet attributeSet) {
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, m.a);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 3) {
                    this.f33p = typedArrayObtainStyledAttributes.getResourceId(index, this.f33p);
                } else if (index == 1) {
                    this.f35r = typedArrayObtainStyledAttributes.getResourceId(index, this.f35r);
                } else if (index == 4) {
                    this.f36s = typedArrayObtainStyledAttributes.getResourceId(index, this.f36s);
                } else if (index == 2) {
                    this.f40w = typedArrayObtainStyledAttributes.getInt(index, this.f40w);
                } else if (index == 7) {
                    this.f37t = typedArrayObtainStyledAttributes.getResourceId(index, this.f37t);
                } else if (index == 6) {
                    this.f38u = typedArrayObtainStyledAttributes.getResourceId(index, this.f38u);
                } else if (index == 9) {
                    this.f39v = typedArrayObtainStyledAttributes.getFloat(index, this.f39v);
                } else if (index == 8) {
                    this.f41x = typedArrayObtainStyledAttributes.getInt(index, this.f41x);
                } else if (index == 10) {
                    this.f42y = typedArrayObtainStyledAttributes.getFloat(index, this.f42y);
                } else if (index == 5) {
                    this.f34q = typedArrayObtainStyledAttributes.getBoolean(index, this.f34q);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    public void setAdapter(a aVar) {
    }

    public Carousel(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f30m = new ArrayList();
        this.f31n = 0;
        this.f33p = -1;
        this.f34q = false;
        this.f35r = -1;
        this.f36s = -1;
        this.f37t = -1;
        this.f38u = -1;
        this.f39v = 0.9f;
        this.f40w = 4;
        this.f41x = 1;
        this.f42y = 2.0f;
        new g(this, 26);
        m23s(context, attributeSet);
    }
}
