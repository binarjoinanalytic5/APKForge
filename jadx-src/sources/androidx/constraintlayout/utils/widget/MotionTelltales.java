package androidx.constraintlayout.utils.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.ViewParent;
import androidx.constraintlayout.motion.widget.MotionLayout;
import b1.b;
import g1.g;
import g1.l;
import h1.n;
import h1.o;
import h1.v;
import j1.m;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public class MotionTelltales extends MockView {

    /* JADX INFO: renamed from: l */
    public final Paint f336l;

    /* JADX INFO: renamed from: m */
    public MotionLayout f337m;

    /* JADX INFO: renamed from: n */
    public final float[] f338n;

    /* JADX INFO: renamed from: o */
    public final Matrix f339o;

    /* JADX INFO: renamed from: p */
    public int f340p;

    /* JADX INFO: renamed from: q */
    public int f341q;

    /* JADX INFO: renamed from: r */
    public float f342r;

    public MotionTelltales(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f336l = new Paint();
        this.f338n = new float[2];
        this.f339o = new Matrix();
        this.f340p = 0;
        this.f341q = -65281;
        this.f342r = 0.25f;
        m97b(context, attributeSet);
    }

    /* JADX INFO: renamed from: b */
    public final void m97b(Context context, AttributeSet attributeSet) {
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, m.t);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 0) {
                    this.f341q = typedArrayObtainStyledAttributes.getColor(index, this.f341q);
                } else if (index == 2) {
                    this.f340p = typedArrayObtainStyledAttributes.getInt(index, this.f340p);
                } else if (index == 1) {
                    this.f342r = typedArrayObtainStyledAttributes.getFloat(index, this.f342r);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
        int i2 = this.f341q;
        Paint paint = this.f336l;
        paint.setColor(i2);
        paint.setStrokeWidth(5.0f);
    }

    @Override // android.view.View
    public final void onAttachedToWindow() {
        super.onAttachedToWindow();
    }

    @Override // androidx.constraintlayout.utils.widget.MockView, android.view.View
    public final void onDraw(Canvas canvas) {
        int i;
        float[] fArr;
        int i2;
        float[] fArr2;
        int i3;
        float f;
        double[] dArr;
        MotionTelltales motionTelltales = this;
        int i4 = 5;
        super.onDraw(canvas);
        Matrix matrix = getMatrix();
        Matrix matrix2 = motionTelltales.f339o;
        matrix.invert(matrix2);
        if (motionTelltales.f337m == null) {
            ViewParent parent = getParent();
            if (parent instanceof MotionLayout) {
                motionTelltales.f337m = (MotionLayout) parent;
                return;
            }
            return;
        }
        int width = getWidth();
        int height = getHeight();
        float[] fArr3 = {0.1f, 0.25f, 0.5f, 0.75f, 0.9f};
        int i5 = 0;
        while (i5 < i4) {
            float f2 = fArr3[i5];
            int i6 = 0;
            while (i6 < i4) {
                float f3 = fArr3[i6];
                MotionLayout motionLayout = motionTelltales.f337m;
                int i7 = motionTelltales.f340p;
                float fA = motionLayout.f155v;
                float interpolation = motionLayout.f113G;
                if (motionLayout.f151t != null) {
                    float fSignum = Math.signum(motionLayout.f116I - interpolation);
                    float interpolation2 = motionLayout.f151t.getInterpolation(motionLayout.f113G + 1.0E-5f);
                    interpolation = motionLayout.f151t.getInterpolation(motionLayout.f113G);
                    fA = (((interpolation2 - interpolation) / 1.0E-5f) * fSignum) / motionLayout.f109E;
                }
                o oVar = motionLayout.f151t;
                if (oVar instanceof o) {
                    fA = oVar.a();
                }
                float f4 = fA;
                n nVar = (n) motionLayout.f105C.get(motionTelltales);
                int i8 = i7 & 1;
                float[] fArr4 = motionTelltales.f338n;
                if (i8 == 0) {
                    int width2 = getWidth();
                    int height2 = getHeight();
                    float[] fArr5 = nVar.v;
                    float fB = nVar.b(fArr5, interpolation);
                    HashMap map = nVar.y;
                    fArr = fArr3;
                    l lVar = map == null ? null : (l) map.get("translationX");
                    HashMap map2 = nVar.y;
                    l lVar2 = map2 == null ? null : (l) map2.get("translationY");
                    HashMap map3 = nVar.y;
                    i2 = i5;
                    l lVar3 = map3 == null ? null : (l) map3.get("rotation");
                    HashMap map4 = nVar.y;
                    i = width;
                    l lVar4 = map4 == null ? null : (l) map4.get("scaleX");
                    HashMap map5 = nVar.y;
                    l lVar5 = map5 == null ? null : (l) map5.get("scaleY");
                    HashMap map6 = nVar.z;
                    g gVar = map6 == null ? null : (g) map6.get("translationX");
                    HashMap map7 = nVar.z;
                    g gVar2 = map7 == null ? null : (g) map7.get("translationY");
                    HashMap map8 = nVar.z;
                    g gVar3 = map8 == null ? null : (g) map8.get("rotation");
                    HashMap map9 = nVar.z;
                    g gVar4 = map9 == null ? null : (g) map9.get("scaleX");
                    HashMap map10 = nVar.z;
                    g gVar5 = map10 != null ? (g) map10.get("scaleY") : null;
                    b1.n nVar2 = new b1.n();
                    nVar2.e = 0.0f;
                    nVar2.d = 0.0f;
                    nVar2.c = 0.0f;
                    nVar2.b = 0.0f;
                    nVar2.a = 0.0f;
                    if (lVar3 != null) {
                        nVar2.e = (float) lVar3.a.x(fB);
                        nVar2.f = lVar3.a(fB);
                    }
                    if (lVar != null) {
                        nVar2.c = (float) lVar.a.x(fB);
                    }
                    if (lVar2 != null) {
                        nVar2.d = (float) lVar2.a.x(fB);
                    }
                    if (lVar4 != null) {
                        nVar2.a = (float) lVar4.a.x(fB);
                    }
                    if (lVar5 != null) {
                        nVar2.b = (float) lVar5.a.x(fB);
                    }
                    if (gVar3 != null) {
                        nVar2.e = gVar3.b(fB);
                    }
                    if (gVar != null) {
                        nVar2.c = gVar.b(fB);
                    }
                    g gVar6 = gVar2;
                    if (gVar2 != null) {
                        nVar2.d = gVar6.b(fB);
                    }
                    if (gVar4 != null) {
                        nVar2.a = gVar4.b(fB);
                    }
                    if (gVar5 != null) {
                        nVar2.b = gVar5.b(fB);
                    }
                    b bVar = nVar.k;
                    if (bVar != null) {
                        double[] dArr2 = nVar.p;
                        if (dArr2.length > 0) {
                            double d = fB;
                            bVar.v(d, dArr2);
                            nVar.k.y(d, nVar.q);
                            int[] iArr = nVar.o;
                            double[] dArr3 = nVar.q;
                            double[] dArr4 = nVar.p;
                            nVar.f.getClass();
                            fArr2 = fArr4;
                            v.g(f3, f2, fArr2, iArr, dArr3, dArr4);
                        } else {
                            fArr2 = fArr4;
                        }
                        nVar2.a(f3, f2, width2, height2, fArr2);
                        f = f3;
                        i3 = i7;
                    } else {
                        fArr2 = fArr4;
                        i6 = i6;
                        if (nVar.j != null) {
                            double dB = nVar.b(fArr5, fB);
                            nVar.j[0].y(dB, nVar.q);
                            nVar.j[0].v(dB, nVar.p);
                            float f5 = fArr5[0];
                            int i9 = 0;
                            while (true) {
                                dArr = nVar.q;
                                if (i9 >= dArr.length) {
                                    break;
                                }
                                dArr[i9] = dArr[i9] * ((double) f5);
                                i9++;
                            }
                            int[] iArr2 = nVar.o;
                            double[] dArr5 = nVar.p;
                            nVar.f.getClass();
                            v.g(f3, f2, fArr2, iArr2, dArr, dArr5);
                            nVar2.a(f3, f2, width2, height2, fArr2);
                            i3 = i7;
                            f = f3;
                        } else {
                            v vVar = nVar.g;
                            float f6 = vVar.e;
                            v vVar2 = nVar.f;
                            g gVar7 = gVar4;
                            float f7 = f6 - vVar2.e;
                            float f8 = vVar.f - vVar2.f;
                            g gVar8 = gVar;
                            float f9 = vVar.g - vVar2.g;
                            float f10 = (vVar.h - vVar2.h) + f8;
                            fArr2[0] = ((f9 + f7) * f3) + ((1.0f - f3) * f7);
                            fArr2[1] = (f10 * f2) + ((1.0f - f2) * f8);
                            nVar2.e = 0.0f;
                            nVar2.d = 0.0f;
                            nVar2.c = 0.0f;
                            nVar2.b = 0.0f;
                            nVar2.a = 0.0f;
                            if (lVar3 != 0) {
                                nVar2.e = (float) lVar3.a.x(fB);
                                nVar2.f = lVar3.a(fB);
                            }
                            if (lVar != null) {
                                nVar2.c = (float) lVar.a.x(fB);
                            }
                            if (lVar2 != null) {
                                nVar2.d = (float) lVar2.a.x(fB);
                            }
                            if (lVar4 != null) {
                                nVar2.a = (float) lVar4.a.x(fB);
                            }
                            if (lVar5 != null) {
                                nVar2.b = (float) lVar5.a.x(fB);
                            }
                            if (gVar3 != null) {
                                nVar2.e = gVar3.b(fB);
                            }
                            if (gVar8 != null) {
                                nVar2.c = gVar8.b(fB);
                            }
                            if (gVar6 != null) {
                                nVar2.d = gVar6.b(fB);
                            }
                            if (gVar7 != null) {
                                nVar2.a = gVar7.b(fB);
                            }
                            if (gVar5 != null) {
                                nVar2.b = gVar5.b(fB);
                            }
                            i3 = i7;
                            f = f3;
                            nVar2.a(f3, f2, width2, height2, fArr2);
                        }
                    }
                    fArr2 = fArr2;
                } else {
                    f4 = f4;
                    i = width;
                    matrix2 = matrix2;
                    height = height;
                    fArr = fArr3;
                    i2 = i5;
                    fArr2 = fArr4;
                    i3 = i7;
                    f = f3;
                    i6 = i6;
                    f2 = f2;
                    nVar.d(interpolation, f, f2, fArr2);
                }
                if (i3 < 2) {
                    fArr2[0] = fArr2[0] * f4;
                    fArr2[1] = fArr2[1] * f4;
                }
                motionTelltales = this;
                float[] fArr6 = motionTelltales.f338n;
                Matrix matrix3 = matrix2;
                matrix3.mapVectors(fArr6);
                int i10 = i;
                float f11 = i10 * f;
                int i11 = height;
                float f12 = i11 * f2;
                float f13 = fArr6[0];
                float f14 = motionTelltales.f342r;
                float f15 = f12 - (fArr6[1] * f14);
                matrix3.mapVectors(fArr6);
                canvas.drawLine(f11, f12, f11 - (f13 * f14), f15, motionTelltales.f336l);
                i6++;
                height = i11;
                f2 = f2;
                fArr3 = fArr;
                i5 = i2;
                i4 = 5;
                matrix2 = matrix3;
                width = i10;
            }
            i5++;
            height = height;
            i4 = 5;
            matrix2 = matrix2;
            width = width;
        }
    }

    @Override // android.view.View
    public final void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        postInvalidate();
    }

    public void setText(CharSequence charSequence) {
        this.f279f = charSequence.toString();
        requestLayout();
    }

    public MotionTelltales(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f336l = new Paint();
        this.f338n = new float[2];
        this.f339o = new Matrix();
        this.f340p = 0;
        this.f341q = -65281;
        this.f342r = 0.25f;
        m97b(context, attributeSet);
    }
}
