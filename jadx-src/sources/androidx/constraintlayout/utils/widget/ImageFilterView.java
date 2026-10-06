package androidx.constraintlayout.utils.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Matrix;
import android.graphics.Outline;
import android.graphics.Path;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.LayerDrawable;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewOutlineProvider;
import android.widget.ImageView;
import androidx.appcompat.widget.AppCompatImageView;
import com.bumptech.glide.d;
import i1.b;
import i1.c;
import j1.m;

/* JADX INFO: loaded from: classes.dex */
public class ImageFilterView extends AppCompatImageView {

    /* JADX INFO: renamed from: a */
    public final c f257a;

    /* JADX INFO: renamed from: b */
    public boolean f258b;

    /* JADX INFO: renamed from: c */
    public Drawable f259c;

    /* JADX INFO: renamed from: d */
    public Drawable f260d;

    /* JADX INFO: renamed from: e */
    public float f261e;

    /* JADX INFO: renamed from: f */
    public float f262f;

    /* JADX INFO: renamed from: g */
    public float f263g;

    /* JADX INFO: renamed from: h */
    public Path f264h;

    /* JADX INFO: renamed from: i */
    public ViewOutlineProvider f265i;

    /* JADX INFO: renamed from: j */
    public RectF f266j;

    /* JADX INFO: renamed from: k */
    public final Drawable[] f267k;

    /* JADX INFO: renamed from: l */
    public LayerDrawable f268l;

    /* JADX INFO: renamed from: m */
    public float f269m;

    /* JADX INFO: renamed from: n */
    public float f270n;

    /* JADX INFO: renamed from: o */
    public float f271o;

    /* JADX INFO: renamed from: p */
    public float f272p;

    public ImageFilterView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f257a = new c();
        this.f258b = true;
        this.f259c = null;
        this.f260d = null;
        this.f261e = 0.0f;
        this.f262f = 0.0f;
        this.f263g = Float.NaN;
        this.f267k = new Drawable[2];
        this.f269m = Float.NaN;
        this.f270n = Float.NaN;
        this.f271o = Float.NaN;
        this.f272p = Float.NaN;
        m88c(attributeSet);
    }

    private void setOverlay(boolean z) {
        this.f258b = z;
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX INFO: renamed from: c */
    public final void m88c(AttributeSet attributeSet) {
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.i);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            this.f259c = typedArrayObtainStyledAttributes.getDrawable(0);
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 4) {
                    this.f261e = typedArrayObtainStyledAttributes.getFloat(index, 0.0f);
                } else if (index == 13) {
                    setWarmth(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                } else if (index == 12) {
                    setSaturation(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                } else if (index == 3) {
                    setContrast(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                } else if (index == 2) {
                    setBrightness(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                } else if (index == 10) {
                    setRound(typedArrayObtainStyledAttributes.getDimension(index, 0.0f));
                } else if (index == 11) {
                    setRoundPercent(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                } else if (index == 9) {
                    setOverlay(typedArrayObtainStyledAttributes.getBoolean(index, this.f258b));
                } else if (index == 5) {
                    setImagePanX(typedArrayObtainStyledAttributes.getFloat(index, this.f269m));
                } else if (index == 6) {
                    setImagePanY(typedArrayObtainStyledAttributes.getFloat(index, this.f270n));
                } else if (index == 7) {
                    setImageRotate(typedArrayObtainStyledAttributes.getFloat(index, this.f272p));
                } else if (index == 8) {
                    setImageZoom(typedArrayObtainStyledAttributes.getFloat(index, this.f271o));
                }
            }
            typedArrayObtainStyledAttributes.recycle();
            Drawable drawable = getDrawable();
            this.f260d = drawable;
            Drawable drawable2 = this.f259c;
            Drawable[] drawableArr = this.f267k;
            if (drawable2 == null || drawable == null) {
                Drawable drawable3 = getDrawable();
                this.f260d = drawable3;
                if (drawable3 != null) {
                    Drawable drawableMutate = drawable3.mutate();
                    this.f260d = drawableMutate;
                    drawableArr[0] = drawableMutate;
                    return;
                }
                return;
            }
            Drawable drawableMutate2 = getDrawable().mutate();
            this.f260d = drawableMutate2;
            drawableArr[0] = drawableMutate2;
            drawableArr[1] = this.f259c.mutate();
            LayerDrawable layerDrawable = new LayerDrawable(drawableArr);
            this.f268l = layerDrawable;
            layerDrawable.getDrawable(1).setAlpha((int) (this.f261e * 255.0f));
            if (!this.f258b) {
                this.f268l.getDrawable(0).setAlpha((int) ((1.0f - this.f261e) * 255.0f));
            }
            super.setImageDrawable(this.f268l);
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX INFO: renamed from: d */
    public final void m89d() {
        if (Float.isNaN(this.f269m) && Float.isNaN(this.f270n) && Float.isNaN(this.f271o) && Float.isNaN(this.f272p)) {
            return;
        }
        float f = Float.isNaN(this.f269m) ? 0.0f : this.f269m;
        float f2 = Float.isNaN(this.f270n) ? 0.0f : this.f270n;
        float f3 = Float.isNaN(this.f271o) ? 1.0f : this.f271o;
        float f4 = Float.isNaN(this.f272p) ? 0.0f : this.f272p;
        Matrix matrix = new Matrix();
        matrix.reset();
        float intrinsicWidth = getDrawable().getIntrinsicWidth();
        float intrinsicHeight = getDrawable().getIntrinsicHeight();
        float width = getWidth();
        float height = getHeight();
        float f5 = f3 * (intrinsicWidth * height < intrinsicHeight * width ? width / intrinsicWidth : height / intrinsicHeight);
        matrix.postScale(f5, f5);
        float f6 = intrinsicWidth * f5;
        float f7 = f5 * intrinsicHeight;
        matrix.postTranslate(((((width - f6) * f) + width) - f6) * 0.5f, ((((height - f7) * f2) + height) - f7) * 0.5f);
        matrix.postRotate(f4, width / 2.0f, height / 2.0f);
        setImageMatrix(matrix);
        setScaleType(ImageView.ScaleType.MATRIX);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX INFO: renamed from: e */
    public final void m90e() {
        if (Float.isNaN(this.f269m) && Float.isNaN(this.f270n) && Float.isNaN(this.f271o) && Float.isNaN(this.f272p)) {
            setScaleType(ImageView.ScaleType.FIT_CENTER);
        } else {
            m89d();
        }
    }

    public float getBrightness() {
        return this.f257a.d;
    }

    public float getContrast() {
        return this.f257a.f;
    }

    public float getCrossfade() {
        return this.f261e;
    }

    public float getImagePanX() {
        return this.f269m;
    }

    public float getImagePanY() {
        return this.f270n;
    }

    public float getImageRotate() {
        return this.f272p;
    }

    public float getImageZoom() {
        return this.f271o;
    }

    public float getRound() {
        return this.f263g;
    }

    public float getRoundPercent() {
        return this.f262f;
    }

    public float getSaturation() {
        return this.f257a.e;
    }

    public float getWarmth() {
        return this.f257a.g;
    }

    /* JADX WARN: Multi-variable type inference failed */
    public final void layout(int i, int i2, int i3, int i4) {
        super/*android.widget.ImageView*/.layout(i, i2, i3, i4);
        m89d();
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setAltImageResource(int i) {
        Drawable drawableMutate = d.c0(getContext(), i).mutate();
        this.f259c = drawableMutate;
        Drawable drawable = this.f260d;
        Drawable[] drawableArr = this.f267k;
        drawableArr[0] = drawable;
        drawableArr[1] = drawableMutate;
        LayerDrawable layerDrawable = new LayerDrawable(drawableArr);
        this.f268l = layerDrawable;
        super.setImageDrawable(layerDrawable);
        setCrossfade(this.f261e);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setBrightness(float f) {
        c cVar = this.f257a;
        cVar.d = f;
        cVar.a(this);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setContrast(float f) {
        c cVar = this.f257a;
        cVar.f = f;
        cVar.a(this);
    }

    public void setCrossfade(float f) {
        this.f261e = f;
        if (this.f267k != null) {
            if (!this.f258b) {
                this.f268l.getDrawable(0).setAlpha((int) ((1.0f - this.f261e) * 255.0f));
            }
            this.f268l.getDrawable(1).setAlpha((int) (this.f261e * 255.0f));
            super.setImageDrawable(this.f268l);
        }
    }

    public void setImageDrawable(Drawable drawable) {
        if (this.f259c == null || drawable == null) {
            super.setImageDrawable(drawable);
            return;
        }
        Drawable drawableMutate = drawable.mutate();
        this.f260d = drawableMutate;
        Drawable[] drawableArr = this.f267k;
        drawableArr[0] = drawableMutate;
        drawableArr[1] = this.f259c;
        LayerDrawable layerDrawable = new LayerDrawable(drawableArr);
        this.f268l = layerDrawable;
        super.setImageDrawable(layerDrawable);
        setCrossfade(this.f261e);
    }

    public void setImagePanX(float f) {
        this.f269m = f;
        m90e();
    }

    public void setImagePanY(float f) {
        this.f270n = f;
        m90e();
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setImageResource(int i) {
        if (this.f259c == null) {
            super.setImageResource(i);
            return;
        }
        Drawable drawableMutate = d.c0(getContext(), i).mutate();
        this.f260d = drawableMutate;
        Drawable[] drawableArr = this.f267k;
        drawableArr[0] = drawableMutate;
        drawableArr[1] = this.f259c;
        LayerDrawable layerDrawable = new LayerDrawable(drawableArr);
        this.f268l = layerDrawable;
        super.setImageDrawable(layerDrawable);
        setCrossfade(this.f261e);
    }

    public void setImageRotate(float f) {
        this.f272p = f;
        m90e();
    }

    public void setImageZoom(float f) {
        this.f271o = f;
        m90e();
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setRound(float f) {
        if (Float.isNaN(f)) {
            this.f263g = f;
            float f2 = this.f262f;
            this.f262f = -1.0f;
            setRoundPercent(f2);
            return;
        }
        boolean z = this.f263g != f;
        this.f263g = f;
        if (f != 0.0f) {
            if (this.f264h == null) {
                this.f264h = new Path();
            }
            if (this.f266j == null) {
                this.f266j = new RectF();
            }
            if (this.f265i == null) {
                b bVar = new b(this, 1);
                this.f265i = bVar;
                setOutlineProvider(bVar);
            }
            setClipToOutline(true);
            this.f266j.set(0.0f, 0.0f, getWidth(), getHeight());
            this.f264h.reset();
            Path path = this.f264h;
            RectF rectF = this.f266j;
            float f3 = this.f263g;
            path.addRoundRect(rectF, f3, f3, Path.Direction.CW);
        } else {
            setClipToOutline(false);
        }
        if (z) {
            invalidateOutline();
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setRoundPercent(float f) {
        boolean z = this.f262f != f;
        this.f262f = f;
        if (f != 0.0f) {
            if (this.f264h == null) {
                this.f264h = new Path();
            }
            if (this.f266j == null) {
                this.f266j = new RectF();
            }
            if (this.f265i == null) {
                b bVar = new b(this, 0);
                this.f265i = bVar;
                setOutlineProvider(bVar);
            }
            setClipToOutline(true);
            int width = getWidth();
            int height = getHeight();
            float fMin = (Math.min(width, height) * this.f262f) / 2.0f;
            this.f266j.set(0.0f, 0.0f, width, height);
            this.f264h.reset();
            this.f264h.addRoundRect(this.f266j, fMin, fMin, Path.Direction.CW);
        } else {
            setClipToOutline(false);
        }
        if (z) {
            invalidateOutline();
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setSaturation(float f) {
        c cVar = this.f257a;
        cVar.e = f;
        cVar.a(this);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setWarmth(float f) {
        c cVar = this.f257a;
        cVar.g = f;
        cVar.a(this);
    }

    public ImageFilterView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f257a = new c();
        this.f258b = true;
        this.f259c = null;
        this.f260d = null;
        this.f261e = 0.0f;
        this.f262f = 0.0f;
        this.f263g = Float.NaN;
        this.f267k = new Drawable[2];
        this.f269m = Float.NaN;
        this.f270n = Float.NaN;
        this.f271o = Float.NaN;
        this.f272p = Float.NaN;
        m88c(attributeSet);
    }

    static class ImageMatrix {

        /* JADX INFO: renamed from: m */
        float[] f273m = new float[20];
        ColorMatrix mColorMatrix = new ColorMatrix();
        ColorMatrix mTmpColorMatrix = new ColorMatrix();
        float mBrightness = 1.0f;
        float mSaturation = 1.0f;
        float mContrast = 1.0f;
        float mWarmth = 1.0f;

        ImageMatrix() {
        }

        private void saturation(float f) {
            float f2 = 1.0f - f;
            float f3 = 0.2999f * f2;
            float f4 = 0.587f * f2;
            float f5 = f2 * 0.114f;
            float[] fArr = this.f273m;
            fArr[0] = f3 + f;
            fArr[1] = f4;
            fArr[2] = f5;
            fArr[3] = 0.0f;
            fArr[4] = 0.0f;
            fArr[5] = f3;
            fArr[6] = f4 + f;
            fArr[7] = f5;
            fArr[8] = 0.0f;
            fArr[9] = 0.0f;
            fArr[10] = f3;
            fArr[11] = f4;
            fArr[12] = f5 + f;
            fArr[13] = 0.0f;
            fArr[14] = 0.0f;
            fArr[15] = 0.0f;
            fArr[16] = 0.0f;
            fArr[17] = 0.0f;
            fArr[18] = 1.0f;
            fArr[19] = 0.0f;
        }

        private void warmth(float f) {
            float fLog;
            float fPow;
            float fLog2;
            if (f <= 0.0f) {
                f = 0.01f;
            }
            float f2 = (5000.0f / f) / 100.0f;
            if (f2 > 66.0f) {
                double d = f2 - 60.0f;
                fPow = ((float) Math.pow(d, -0.13320475816726685d)) * 329.69873f;
                fLog = ((float) Math.pow(d, 0.07551484555006027d)) * 288.12216f;
            } else {
                fLog = (((float) Math.log(f2)) * 99.4708f) - 161.11957f;
                fPow = 255.0f;
            }
            if (f2 < 66.0f) {
                fLog2 = f2 > 19.0f ? (((float) Math.log(f2 - 10.0f)) * 138.51773f) - 305.0448f : 0.0f;
            } else {
                fLog2 = 255.0f;
            }
            float fMin = Math.min(255.0f, Math.max(fPow, 0.0f));
            float fMin2 = Math.min(255.0f, Math.max(fLog, 0.0f));
            float fMin3 = Math.min(255.0f, Math.max(fLog2, 0.0f));
            float fLog3 = (((float) Math.log(50.0f)) * 99.4708f) - 161.11957f;
            float fLog4 = (((float) Math.log(40.0f)) * 138.51773f) - 305.0448f;
            float fMin4 = Math.min(255.0f, Math.max(255.0f, 0.0f));
            float fMin5 = Math.min(255.0f, Math.max(fLog3, 0.0f));
            float fMin6 = fMin3 / Math.min(255.0f, Math.max(fLog4, 0.0f));
            float[] fArr = this.f273m;
            fArr[0] = fMin / fMin4;
            fArr[1] = 0.0f;
            fArr[2] = 0.0f;
            fArr[3] = 0.0f;
            fArr[4] = 0.0f;
            fArr[5] = 0.0f;
            fArr[6] = fMin2 / fMin5;
            fArr[7] = 0.0f;
            fArr[8] = 0.0f;
            fArr[9] = 0.0f;
            fArr[10] = 0.0f;
            fArr[11] = 0.0f;
            fArr[12] = fMin6;
            fArr[13] = 0.0f;
            fArr[14] = 0.0f;
            fArr[15] = 0.0f;
            fArr[16] = 0.0f;
            fArr[17] = 0.0f;
            fArr[18] = 1.0f;
            fArr[19] = 0.0f;
        }

        private void brightness(float f) {
            float[] fArr = this.f273m;
            fArr[0] = f;
            fArr[1] = 0.0f;
            fArr[2] = 0.0f;
            fArr[3] = 0.0f;
            fArr[4] = 0.0f;
            fArr[5] = 0.0f;
            fArr[6] = f;
            fArr[7] = 0.0f;
            fArr[8] = 0.0f;
            fArr[9] = 0.0f;
            fArr[10] = 0.0f;
            fArr[11] = 0.0f;
            fArr[12] = f;
            fArr[13] = 0.0f;
            fArr[14] = 0.0f;
            fArr[15] = 0.0f;
            fArr[16] = 0.0f;
            fArr[17] = 0.0f;
            fArr[18] = 1.0f;
            fArr[19] = 0.0f;
        }

        void updateMatrix(ImageView imageView) {
            boolean z;
            this.mColorMatrix.reset();
            float f = this.mSaturation;
            boolean z2 = true;
            if (f != 1.0f) {
                saturation(f);
                this.mColorMatrix.set(this.f273m);
                z = true;
            } else {
                z = false;
            }
            float f2 = this.mContrast;
            if (f2 != 1.0f) {
                this.mTmpColorMatrix.setScale(f2, f2, f2, 1.0f);
                this.mColorMatrix.postConcat(this.mTmpColorMatrix);
                z = true;
            }
            float f3 = this.mWarmth;
            if (f3 != 1.0f) {
                warmth(f3);
                this.mTmpColorMatrix.set(this.f273m);
                this.mColorMatrix.postConcat(this.mTmpColorMatrix);
                z = true;
            }
            float f4 = this.mBrightness;
            if (f4 != 1.0f) {
                brightness(f4);
                this.mTmpColorMatrix.set(this.f273m);
                this.mColorMatrix.postConcat(this.mTmpColorMatrix);
            } else {
                z2 = z;
            }
            if (z2) {
                imageView.setColorFilter(new ColorMatrixColorFilter(this.mColorMatrix));
            } else {
                imageView.clearColorFilter();
            }
        }
    }

    /* JADX INFO: renamed from: androidx.constraintlayout.utils.widget.ImageFilterView$1 */
    class C00331 extends ViewOutlineProvider {
        C00331() {
        }

        @Override // android.view.ViewOutlineProvider
        public void getOutline(View view, Outline outline) {
            int width = ImageFilterView.this.getWidth();
            int height = ImageFilterView.this.getHeight();
            outline.setRoundRect(0, 0, width, height, (Math.min(width, height) * ImageFilterView.access$000(ImageFilterView.this)) / 2.0f);
        }
    }

    /* JADX INFO: renamed from: androidx.constraintlayout.utils.widget.ImageFilterView$2 */
    class C00342 extends ViewOutlineProvider {
        C00342() {
        }

        @Override // android.view.ViewOutlineProvider
        public void getOutline(View view, Outline outline) {
            outline.setRoundRect(0, 0, ImageFilterView.this.getWidth(), ImageFilterView.this.getHeight(), ImageFilterView.access$100(ImageFilterView.this));
        }
    }
}
