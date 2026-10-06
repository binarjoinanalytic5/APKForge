package androidx.constraintlayout.helper.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.constraintlayout.widget.VirtualLayout;
import j1.m;
import java.util.Arrays;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public class CircularFlow extends VirtualLayout {

    /* JADX INFO: renamed from: u */
    public static int f43u;

    /* JADX INFO: renamed from: v */
    public static float f44v;

    /* JADX INFO: renamed from: k */
    public ConstraintLayout f45k;

    /* JADX INFO: renamed from: l */
    public int f46l;

    /* JADX INFO: renamed from: m */
    public float[] f47m;

    /* JADX INFO: renamed from: n */
    public int[] f48n;

    /* JADX INFO: renamed from: o */
    public int f49o;

    /* JADX INFO: renamed from: p */
    public int f50p;

    /* JADX INFO: renamed from: q */
    public String f51q;

    /* JADX INFO: renamed from: r */
    public String f52r;

    /* JADX INFO: renamed from: s */
    public Float f53s;

    /* JADX INFO: renamed from: t */
    public Integer f54t;

    public CircularFlow(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    private void setAngles(String str) {
        if (str == null) {
            return;
        }
        int i = 0;
        this.f50p = 0;
        while (true) {
            int iIndexOf = str.indexOf(44, i);
            if (iIndexOf == -1) {
                m25s(str.substring(i).trim());
                return;
            } else {
                m25s(str.substring(i, iIndexOf).trim());
                i = iIndexOf + 1;
            }
        }
    }

    private void setRadius(String str) {
        if (str == null) {
            return;
        }
        int i = 0;
        this.f49o = 0;
        while (true) {
            int iIndexOf = str.indexOf(44, i);
            if (iIndexOf == -1) {
                m26t(str.substring(i).trim());
                return;
            } else {
                m26t(str.substring(i, iIndexOf).trim());
                i = iIndexOf + 1;
            }
        }
    }

    public float[] getAngles() {
        return Arrays.copyOf(this.f47m, this.f50p);
    }

    public int[] getRadius() {
        return Arrays.copyOf(this.f48n, this.f49o);
    }

    @Override // androidx.constraintlayout.widget.VirtualLayout, androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: k */
    public final void mo24k(AttributeSet attributeSet) {
        super.mo24k(attributeSet);
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.c);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 33) {
                    this.f46l = typedArrayObtainStyledAttributes.getResourceId(index, 0);
                } else if (index == 29) {
                    String string = typedArrayObtainStyledAttributes.getString(index);
                    this.f51q = string;
                    setAngles(string);
                } else if (index == 32) {
                    String string2 = typedArrayObtainStyledAttributes.getString(index);
                    this.f52r = string2;
                    setRadius(string2);
                } else if (index == 30) {
                    Float fValueOf = Float.valueOf(typedArrayObtainStyledAttributes.getFloat(index, f44v));
                    this.f53s = fValueOf;
                    setDefaultAngle(fValueOf.floatValue());
                } else if (index == 31) {
                    Integer numValueOf = Integer.valueOf(typedArrayObtainStyledAttributes.getDimensionPixelSize(index, f43u));
                    this.f54t = numValueOf;
                    setDefaultRadius(numValueOf.intValue());
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    @Override // androidx.constraintlayout.widget.VirtualLayout, androidx.constraintlayout.widget.ConstraintHelper, android.view.View
    public final void onAttachedToWindow() {
        super.onAttachedToWindow();
        String str = this.f51q;
        if (str != null) {
            this.f47m = new float[1];
            setAngles(str);
        }
        String str2 = this.f52r;
        if (str2 != null) {
            this.f48n = new int[1];
            setRadius(str2);
        }
        Float f = this.f53s;
        if (f != null) {
            setDefaultAngle(f.floatValue());
        }
        Integer num = this.f54t;
        if (num != null) {
            setDefaultRadius(num.intValue());
        }
        this.f45k = (ConstraintLayout) getParent();
        for (int i = 0; i < this.f348b; i++) {
            View viewM109f = this.f45k.m109f(this.f347a[i]);
            if (viewM109f != null) {
                int i2 = f43u;
                float f2 = f44v;
                int[] iArr = this.f48n;
                HashMap map = this.f354h;
                if (iArr == null || i >= iArr.length) {
                    Integer num2 = this.f54t;
                    if (num2 == null || num2.intValue() == -1) {
                        Log.e("CircularFlow", "Added radius to view with id: " + ((String) map.get(Integer.valueOf(viewM109f.getId()))));
                    } else {
                        this.f49o++;
                        if (this.f48n == null) {
                            this.f48n = new int[1];
                        }
                        int[] radius = getRadius();
                        this.f48n = radius;
                        radius[this.f49o - 1] = i2;
                    }
                } else {
                    i2 = iArr[i];
                }
                float[] fArr = this.f47m;
                if (fArr == null || i >= fArr.length) {
                    Float f3 = this.f53s;
                    if (f3 == null || f3.floatValue() == -1.0f) {
                        Log.e("CircularFlow", "Added angle to view with id: " + ((String) map.get(Integer.valueOf(viewM109f.getId()))));
                    } else {
                        this.f50p++;
                        if (this.f47m == null) {
                            this.f47m = new float[1];
                        }
                        float[] angles = getAngles();
                        this.f47m = angles;
                        angles[this.f50p - 1] = f2;
                    }
                } else {
                    f2 = fArr[i];
                }
                ConstraintLayout.LayoutParams layoutParams = (ConstraintLayout.LayoutParams) viewM109f.getLayoutParams();
                layoutParams.f434r = f2;
                layoutParams.f430p = this.f46l;
                layoutParams.f432q = i2;
                viewM109f.setLayoutParams(layoutParams);
            }
        }
        m102e();
    }

    /* JADX INFO: renamed from: s */
    public final void m25s(String str) {
        float[] fArr;
        if (str == null || str.length() == 0 || this.f349c == null || (fArr = this.f47m) == null) {
            return;
        }
        if (this.f50p + 1 > fArr.length) {
            this.f47m = Arrays.copyOf(fArr, fArr.length + 1);
        }
        this.f47m[this.f50p] = Integer.parseInt(str);
        this.f50p++;
    }

    public void setDefaultAngle(float f) {
        f44v = f;
    }

    public void setDefaultRadius(int i) {
        f43u = i;
    }

    /* JADX INFO: renamed from: t */
    public final void m26t(String str) {
        Context context;
        int[] iArr;
        if (str == null || str.length() == 0 || (context = this.f349c) == null || (iArr = this.f48n) == null) {
            return;
        }
        if (this.f49o + 1 > iArr.length) {
            this.f48n = Arrays.copyOf(iArr, iArr.length + 1);
        }
        this.f48n[this.f49o] = (int) (Integer.parseInt(str) * context.getResources().getDisplayMetrics().density);
        this.f49o++;
    }

    public CircularFlow(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }
}
