package androidx.constraintlayout.motion.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.graphics.RectF;
import android.util.Xml;
import android.view.View;
import android.view.ViewGroup;
import j1.m;

/* JADX INFO: renamed from: androidx.constraintlayout.motion.widget.d */
/* JADX INFO: loaded from: classes.dex */
public final class C0017d {

    /* JADX INFO: renamed from: E */
    public static final float[][] f195E = {new float[]{0.5f, 0.0f}, new float[]{0.0f, 0.5f}, new float[]{1.0f, 0.5f}, new float[]{0.5f, 1.0f}, new float[]{0.5f, 0.5f}, new float[]{0.0f, 0.5f}, new float[]{1.0f, 0.5f}};

    /* JADX INFO: renamed from: F */
    public static final float[][] f196F = {new float[]{0.0f, -1.0f}, new float[]{0.0f, 1.0f}, new float[]{-1.0f, 0.0f}, new float[]{1.0f, 0.0f}, new float[]{-1.0f, 0.0f}, new float[]{1.0f, 0.0f}};

    /* JADX INFO: renamed from: A */
    public final float f197A;

    /* JADX INFO: renamed from: B */
    public final float f198B;

    /* JADX INFO: renamed from: C */
    public final int f199C;

    /* JADX INFO: renamed from: D */
    public final int f200D;

    /* JADX INFO: renamed from: a */
    public final int f201a;

    /* JADX INFO: renamed from: b */
    public final int f202b;

    /* JADX INFO: renamed from: c */
    public int f203c;

    /* JADX INFO: renamed from: d */
    public final int f204d;

    /* JADX INFO: renamed from: e */
    public final int f205e;

    /* JADX INFO: renamed from: f */
    public final int f206f;

    /* JADX INFO: renamed from: g */
    public float f207g;

    /* JADX INFO: renamed from: h */
    public float f208h;

    /* JADX INFO: renamed from: i */
    public final int f209i;

    /* JADX INFO: renamed from: j */
    public final boolean f210j;

    /* JADX INFO: renamed from: k */
    public float f211k;

    /* JADX INFO: renamed from: l */
    public float f212l;

    /* JADX INFO: renamed from: m */
    public boolean f213m = false;

    /* JADX INFO: renamed from: n */
    public final float[] f214n = new float[2];

    /* JADX INFO: renamed from: o */
    public final int[] f215o = new int[2];

    /* JADX INFO: renamed from: p */
    public float f216p;

    /* JADX INFO: renamed from: q */
    public float f217q;

    /* JADX INFO: renamed from: r */
    public final MotionLayout f218r;

    /* JADX INFO: renamed from: s */
    public final float f219s;

    /* JADX INFO: renamed from: t */
    public final float f220t;

    /* JADX INFO: renamed from: u */
    public final boolean f221u;

    /* JADX INFO: renamed from: v */
    public final float f222v;

    /* JADX INFO: renamed from: w */
    public final int f223w;

    /* JADX INFO: renamed from: x */
    public final float f224x;

    /* JADX INFO: renamed from: y */
    public final float f225y;

    /* JADX INFO: renamed from: z */
    public final float f226z;

    public C0017d(Context context, MotionLayout motionLayout, XmlResourceParser xmlResourceParser) {
        this.f201a = 0;
        this.f202b = 0;
        this.f203c = 0;
        this.f204d = -1;
        this.f205e = -1;
        this.f206f = -1;
        this.f207g = 0.5f;
        this.f208h = 0.5f;
        this.f209i = -1;
        this.f210j = false;
        this.f211k = 0.0f;
        this.f212l = 1.0f;
        this.f219s = 4.0f;
        this.f220t = 1.2f;
        this.f221u = true;
        this.f222v = 1.0f;
        this.f223w = 0;
        this.f224x = 10.0f;
        this.f225y = 10.0f;
        this.f226z = 1.0f;
        this.f197A = Float.NaN;
        this.f198B = Float.NaN;
        this.f199C = 0;
        this.f200D = 0;
        this.f218r = motionLayout;
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(Xml.asAttributeSet(xmlResourceParser), m.v);
        int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
        for (int i = 0; i < indexCount; i++) {
            int index = typedArrayObtainStyledAttributes.getIndex(i);
            if (index == 16) {
                this.f204d = typedArrayObtainStyledAttributes.getResourceId(index, this.f204d);
            } else if (index == 17) {
                int i2 = typedArrayObtainStyledAttributes.getInt(index, this.f201a);
                this.f201a = i2;
                float[] fArr = f195E[i2];
                this.f208h = fArr[0];
                this.f207g = fArr[1];
            } else if (index == 1) {
                int i3 = typedArrayObtainStyledAttributes.getInt(index, this.f202b);
                this.f202b = i3;
                if (i3 < 6) {
                    float[] fArr2 = f196F[i3];
                    this.f211k = fArr2[0];
                    this.f212l = fArr2[1];
                } else {
                    this.f212l = Float.NaN;
                    this.f211k = Float.NaN;
                    this.f210j = true;
                }
            } else if (index == 6) {
                this.f219s = typedArrayObtainStyledAttributes.getFloat(index, this.f219s);
            } else if (index == 5) {
                this.f220t = typedArrayObtainStyledAttributes.getFloat(index, this.f220t);
            } else if (index == 7) {
                this.f221u = typedArrayObtainStyledAttributes.getBoolean(index, this.f221u);
            } else if (index == 2) {
                this.f222v = typedArrayObtainStyledAttributes.getFloat(index, this.f222v);
            } else if (index == 3) {
                this.f224x = typedArrayObtainStyledAttributes.getFloat(index, this.f224x);
            } else if (index == 18) {
                this.f205e = typedArrayObtainStyledAttributes.getResourceId(index, this.f205e);
            } else if (index == 9) {
                this.f203c = typedArrayObtainStyledAttributes.getInt(index, this.f203c);
            } else if (index == 8) {
                this.f223w = typedArrayObtainStyledAttributes.getInteger(index, 0);
            } else if (index == 4) {
                this.f206f = typedArrayObtainStyledAttributes.getResourceId(index, 0);
            } else if (index == 10) {
                this.f209i = typedArrayObtainStyledAttributes.getResourceId(index, this.f209i);
            } else if (index == 12) {
                this.f225y = typedArrayObtainStyledAttributes.getFloat(index, this.f225y);
            } else if (index == 13) {
                this.f226z = typedArrayObtainStyledAttributes.getFloat(index, this.f226z);
            } else if (index == 14) {
                this.f197A = typedArrayObtainStyledAttributes.getFloat(index, this.f197A);
            } else if (index == 15) {
                this.f198B = typedArrayObtainStyledAttributes.getFloat(index, this.f198B);
            } else if (index == 11) {
                this.f199C = typedArrayObtainStyledAttributes.getInt(index, this.f199C);
            } else if (index == 0) {
                this.f200D = typedArrayObtainStyledAttributes.getInt(index, this.f200D);
            }
        }
        typedArrayObtainStyledAttributes.recycle();
    }

    /* JADX INFO: renamed from: a */
    public final RectF m82a(ViewGroup viewGroup, RectF rectF) {
        View viewFindViewById;
        int i = this.f206f;
        if (i == -1 || (viewFindViewById = viewGroup.findViewById(i)) == null) {
            return null;
        }
        rectF.set(viewFindViewById.getLeft(), viewFindViewById.getTop(), viewFindViewById.getRight(), viewFindViewById.getBottom());
        return rectF;
    }

    /* JADX INFO: renamed from: b */
    public final RectF m83b(ViewGroup viewGroup, RectF rectF) {
        View viewFindViewById;
        int i = this.f205e;
        if (i == -1 || (viewFindViewById = viewGroup.findViewById(i)) == null) {
            return null;
        }
        rectF.set(viewFindViewById.getLeft(), viewFindViewById.getTop(), viewFindViewById.getRight(), viewFindViewById.getBottom());
        return rectF;
    }

    /* JADX INFO: renamed from: c */
    public final void m84c(boolean z) {
        float[][] fArr = f195E;
        float[][] fArr2 = f196F;
        if (z) {
            fArr2[4] = fArr2[3];
            fArr2[5] = fArr2[2];
            fArr[5] = fArr[2];
            fArr[6] = fArr[1];
        } else {
            fArr2[4] = fArr2[2];
            fArr2[5] = fArr2[3];
            fArr[5] = fArr[1];
            fArr[6] = fArr[2];
        }
        float[] fArr3 = fArr[this.f201a];
        this.f208h = fArr3[0];
        this.f207g = fArr3[1];
        int i = this.f202b;
        if (i >= 6) {
            return;
        }
        float[] fArr4 = fArr2[i];
        this.f211k = fArr4[0];
        this.f212l = fArr4[1];
    }

    public final String toString() {
        if (Float.isNaN(this.f211k)) {
            return "rotation";
        }
        return this.f211k + " , " + this.f212l;
    }
}
