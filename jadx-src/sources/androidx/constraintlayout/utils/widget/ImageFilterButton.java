package androidx.constraintlayout.utils.widget;

import android.content.Context;
import android.content.res.TypedArray;
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
import androidx.appcompat.widget.AppCompatImageButton;
import com.bumptech.glide.d;
import i1.a;
import i1.c;
import j1.m;

/* JADX INFO: loaded from: classes.dex */
public class ImageFilterButton extends AppCompatImageButton {

    /* JADX INFO: renamed from: d */
    public final c f241d;

    /* JADX INFO: renamed from: e */
    public float f242e;

    /* JADX INFO: renamed from: f */
    public float f243f;

    /* JADX INFO: renamed from: g */
    public float f244g;

    /* JADX INFO: renamed from: h */
    public Path f245h;

    /* JADX INFO: renamed from: i */
    public ViewOutlineProvider f246i;

    /* JADX INFO: renamed from: j */
    public RectF f247j;

    /* JADX INFO: renamed from: k */
    public final Drawable[] f248k;

    /* JADX INFO: renamed from: l */
    public LayerDrawable f249l;

    /* JADX INFO: renamed from: m */
    public boolean f250m;

    /* JADX INFO: renamed from: n */
    public Drawable f251n;

    /* JADX INFO: renamed from: o */
    public Drawable f252o;

    /* JADX INFO: renamed from: p */
    public float f253p;

    /* JADX INFO: renamed from: q */
    public float f254q;

    /* JADX INFO: renamed from: r */
    public float f255r;

    /* JADX INFO: renamed from: s */
    public float f256s;

    public ImageFilterButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f241d = new c();
        this.f242e = 0.0f;
        this.f243f = 0.0f;
        this.f244g = Float.NaN;
        this.f248k = new Drawable[2];
        this.f250m = true;
        this.f251n = null;
        this.f252o = null;
        this.f253p = Float.NaN;
        this.f254q = Float.NaN;
        this.f255r = Float.NaN;
        this.f256s = Float.NaN;
        m85a(attributeSet);
    }

    private void setOverlay(boolean z) {
        this.f250m = z;
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX INFO: renamed from: a */
    public final void m85a(AttributeSet attributeSet) {
        setPadding(0, 0, 0, 0);
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.i);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            this.f251n = typedArrayObtainStyledAttributes.getDrawable(0);
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 4) {
                    this.f242e = typedArrayObtainStyledAttributes.getFloat(index, 0.0f);
                } else if (index == 13) {
                    setWarmth(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                } else if (index == 12) {
                    setSaturation(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                } else if (index == 3) {
                    setContrast(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                } else if (index == 10) {
                    setRound(typedArrayObtainStyledAttributes.getDimension(index, 0.0f));
                } else if (index == 11) {
                    setRoundPercent(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                } else if (index == 9) {
                    setOverlay(typedArrayObtainStyledAttributes.getBoolean(index, this.f250m));
                } else if (index == 5) {
                    setImagePanX(typedArrayObtainStyledAttributes.getFloat(index, this.f253p));
                } else if (index == 6) {
                    setImagePanY(typedArrayObtainStyledAttributes.getFloat(index, this.f254q));
                } else if (index == 7) {
                    setImageRotate(typedArrayObtainStyledAttributes.getFloat(index, this.f256s));
                } else if (index == 8) {
                    setImageZoom(typedArrayObtainStyledAttributes.getFloat(index, this.f255r));
                }
            }
            typedArrayObtainStyledAttributes.recycle();
            Drawable drawable = getDrawable();
            this.f252o = drawable;
            Drawable drawable2 = this.f251n;
            Drawable[] drawableArr = this.f248k;
            if (drawable2 == null || drawable == null) {
                Drawable drawable3 = getDrawable();
                this.f252o = drawable3;
                if (drawable3 != null) {
                    Drawable drawableMutate = drawable3.mutate();
                    this.f252o = drawableMutate;
                    drawableArr[0] = drawableMutate;
                    return;
                }
                return;
            }
            Drawable drawableMutate2 = getDrawable().mutate();
            this.f252o = drawableMutate2;
            drawableArr[0] = drawableMutate2;
            drawableArr[1] = this.f251n.mutate();
            LayerDrawable layerDrawable = new LayerDrawable(drawableArr);
            this.f249l = layerDrawable;
            layerDrawable.getDrawable(1).setAlpha((int) (this.f242e * 255.0f));
            if (!this.f250m) {
                this.f249l.getDrawable(0).setAlpha((int) ((1.0f - this.f242e) * 255.0f));
            }
            super.setImageDrawable(this.f249l);
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX INFO: renamed from: b */
    public final void m86b() {
        if (Float.isNaN(this.f253p) && Float.isNaN(this.f254q) && Float.isNaN(this.f255r) && Float.isNaN(this.f256s)) {
            return;
        }
        float f = Float.isNaN(this.f253p) ? 0.0f : this.f253p;
        float f2 = Float.isNaN(this.f254q) ? 0.0f : this.f254q;
        float f3 = Float.isNaN(this.f255r) ? 1.0f : this.f255r;
        float f4 = Float.isNaN(this.f256s) ? 0.0f : this.f256s;
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
    /* JADX INFO: renamed from: c */
    public final void m87c() {
        if (Float.isNaN(this.f253p) && Float.isNaN(this.f254q) && Float.isNaN(this.f255r) && Float.isNaN(this.f256s)) {
            setScaleType(ImageView.ScaleType.FIT_CENTER);
        } else {
            m86b();
        }
    }

    public float getContrast() {
        return this.f241d.f;
    }

    public float getCrossfade() {
        return this.f242e;
    }

    public float getImagePanX() {
        return this.f253p;
    }

    public float getImagePanY() {
        return this.f254q;
    }

    public float getImageRotate() {
        return this.f256s;
    }

    public float getImageZoom() {
        return this.f255r;
    }

    public float getRound() {
        return this.f244g;
    }

    public float getRoundPercent() {
        return this.f243f;
    }

    public float getSaturation() {
        return this.f241d.e;
    }

    public float getWarmth() {
        return this.f241d.g;
    }

    /* JADX WARN: Multi-variable type inference failed */
    public final void layout(int i, int i2, int i3, int i4) {
        super/*android.widget.ImageButton*/.layout(i, i2, i3, i4);
        m86b();
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setAltImageResource(int i) {
        Drawable drawableMutate = d.c0(getContext(), i).mutate();
        this.f251n = drawableMutate;
        Drawable drawable = this.f252o;
        Drawable[] drawableArr = this.f248k;
        drawableArr[0] = drawable;
        drawableArr[1] = drawableMutate;
        LayerDrawable layerDrawable = new LayerDrawable(drawableArr);
        this.f249l = layerDrawable;
        super.setImageDrawable(layerDrawable);
        setCrossfade(this.f242e);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setBrightness(float f) {
        c cVar = this.f241d;
        cVar.d = f;
        cVar.a(this);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setContrast(float f) {
        c cVar = this.f241d;
        cVar.f = f;
        cVar.a(this);
    }

    public void setCrossfade(float f) {
        this.f242e = f;
        if (this.f248k != null) {
            if (!this.f250m) {
                this.f249l.getDrawable(0).setAlpha((int) ((1.0f - this.f242e) * 255.0f));
            }
            this.f249l.getDrawable(1).setAlpha((int) (this.f242e * 255.0f));
            super.setImageDrawable(this.f249l);
        }
    }

    public void setImageDrawable(Drawable drawable) {
        if (this.f251n == null || drawable == null) {
            super.setImageDrawable(drawable);
            return;
        }
        Drawable drawableMutate = drawable.mutate();
        this.f252o = drawableMutate;
        Drawable[] drawableArr = this.f248k;
        drawableArr[0] = drawableMutate;
        drawableArr[1] = this.f251n;
        LayerDrawable layerDrawable = new LayerDrawable(drawableArr);
        this.f249l = layerDrawable;
        super.setImageDrawable(layerDrawable);
        setCrossfade(this.f242e);
    }

    public void setImagePanX(float f) {
        this.f253p = f;
        m87c();
    }

    public void setImagePanY(float f) {
        this.f254q = f;
        m87c();
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setImageResource(int i) {
        if (this.f251n == null) {
            super.setImageResource(i);
            return;
        }
        Drawable drawableMutate = d.c0(getContext(), i).mutate();
        this.f252o = drawableMutate;
        Drawable[] drawableArr = this.f248k;
        drawableArr[0] = drawableMutate;
        drawableArr[1] = this.f251n;
        LayerDrawable layerDrawable = new LayerDrawable(drawableArr);
        this.f249l = layerDrawable;
        super.setImageDrawable(layerDrawable);
        setCrossfade(this.f242e);
    }

    public void setImageRotate(float f) {
        this.f256s = f;
        m87c();
    }

    public void setImageZoom(float f) {
        this.f255r = f;
        m87c();
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setRound(float f) {
        if (Float.isNaN(f)) {
            this.f244g = f;
            float f2 = this.f243f;
            this.f243f = -1.0f;
            setRoundPercent(f2);
            return;
        }
        boolean z = this.f244g != f;
        this.f244g = f;
        if (f != 0.0f) {
            if (this.f245h == null) {
                this.f245h = new Path();
            }
            if (this.f247j == null) {
                this.f247j = new RectF();
            }
            if (this.f246i == null) {
                a aVar = new a(this, 1);
                this.f246i = aVar;
                setOutlineProvider(aVar);
            }
            setClipToOutline(true);
            this.f247j.set(0.0f, 0.0f, getWidth(), getHeight());
            this.f245h.reset();
            Path path = this.f245h;
            RectF rectF = this.f247j;
            float f3 = this.f244g;
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
        boolean z = this.f243f != f;
        this.f243f = f;
        if (f != 0.0f) {
            if (this.f245h == null) {
                this.f245h = new Path();
            }
            if (this.f247j == null) {
                this.f247j = new RectF();
            }
            if (this.f246i == null) {
                a aVar = new a(this, 0);
                this.f246i = aVar;
                setOutlineProvider(aVar);
            }
            setClipToOutline(true);
            int width = getWidth();
            int height = getHeight();
            float fMin = (Math.min(width, height) * this.f243f) / 2.0f;
            this.f247j.set(0.0f, 0.0f, width, height);
            this.f245h.reset();
            this.f245h.addRoundRect(this.f247j, fMin, fMin, Path.Direction.CW);
        } else {
            setClipToOutline(false);
        }
        if (z) {
            invalidateOutline();
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setSaturation(float f) {
        c cVar = this.f241d;
        cVar.e = f;
        cVar.a(this);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setWarmth(float f) {
        c cVar = this.f241d;
        cVar.g = f;
        cVar.a(this);
    }

    public ImageFilterButton(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f241d = new c();
        this.f242e = 0.0f;
        this.f243f = 0.0f;
        this.f244g = Float.NaN;
        this.f248k = new Drawable[2];
        this.f250m = true;
        this.f251n = null;
        this.f252o = null;
        this.f253p = Float.NaN;
        this.f254q = Float.NaN;
        this.f255r = Float.NaN;
        this.f256s = Float.NaN;
        m85a(attributeSet);
    }

    /* JADX INFO: renamed from: androidx.constraintlayout.utils.widget.ImageFilterButton$1 */
    class C00311 extends ViewOutlineProvider {
        C00311() {
        }

        @Override // android.view.ViewOutlineProvider
        public void getOutline(View view, Outline outline) {
            int width = ImageFilterButton.this.getWidth();
            int height = ImageFilterButton.this.getHeight();
            outline.setRoundRect(0, 0, width, height, (Math.min(width, height) * ImageFilterButton.access$000(ImageFilterButton.this)) / 2.0f);
        }
    }

    /* JADX INFO: renamed from: androidx.constraintlayout.utils.widget.ImageFilterButton$2 */
    class C00322 extends ViewOutlineProvider {
        C00322() {
        }

        @Override // android.view.ViewOutlineProvider
        public void getOutline(View view, Outline outline) {
            outline.setRoundRect(0, 0, ImageFilterButton.this.getWidth(), ImageFilterButton.this.getHeight(), ImageFilterButton.access$100(ImageFilterButton.this));
        }
    }
}
