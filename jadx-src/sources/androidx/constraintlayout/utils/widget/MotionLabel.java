package androidx.constraintlayout.utils.widget;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Bitmap;
import android.graphics.BitmapShader;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Shader;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.text.TextPaint;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewOutlineProvider;
import androidx.annotation.Nullable;
import androidx.constraintlayout.solver.widgets.Optimizer;
import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import androidx.constraintlayout.widget.C0037R;
import h1.b;
import i1.e;
import j1.m;
import so.c;

/* JADX INFO: loaded from: classes.dex */
public class MotionLabel extends View implements b {

    /* JADX INFO: renamed from: A */
    public float f290A;

    /* JADX INFO: renamed from: B */
    public float f291B;

    /* JADX INFO: renamed from: C */
    public Drawable f292C;

    /* JADX INFO: renamed from: D */
    public Matrix f293D;

    /* JADX INFO: renamed from: E */
    public Bitmap f294E;

    /* JADX INFO: renamed from: F */
    public BitmapShader f295F;

    /* JADX INFO: renamed from: G */
    public Matrix f296G;

    /* JADX INFO: renamed from: H */
    public float f297H;

    /* JADX INFO: renamed from: I */
    public float f298I;

    /* JADX INFO: renamed from: J */
    public float f299J;

    /* JADX INFO: renamed from: K */
    public float f300K;

    /* JADX INFO: renamed from: L */
    public final Paint f301L;

    /* JADX INFO: renamed from: M */
    public int f302M;

    /* JADX INFO: renamed from: N */
    public Rect f303N;

    /* JADX INFO: renamed from: O */
    public Paint f304O;

    /* JADX INFO: renamed from: P */
    public float f305P;

    /* JADX INFO: renamed from: Q */
    public float f306Q;

    /* JADX INFO: renamed from: R */
    public float f307R;

    /* JADX INFO: renamed from: S */
    public float f308S;

    /* JADX INFO: renamed from: T */
    public float f309T;

    /* JADX INFO: renamed from: a */
    public final TextPaint f310a;

    /* JADX INFO: renamed from: b */
    public Path f311b;

    /* JADX INFO: renamed from: c */
    public int f312c;

    /* JADX INFO: renamed from: d */
    public int f313d;

    /* JADX INFO: renamed from: e */
    public boolean f314e;

    /* JADX INFO: renamed from: f */
    public float f315f;

    /* JADX INFO: renamed from: g */
    public float f316g;

    /* JADX INFO: renamed from: h */
    public ViewOutlineProvider f317h;

    /* JADX INFO: renamed from: i */
    public RectF f318i;

    /* JADX INFO: renamed from: j */
    public float f319j;

    /* JADX INFO: renamed from: k */
    public float f320k;

    /* JADX INFO: renamed from: l */
    public int f321l;

    /* JADX INFO: renamed from: m */
    public int f322m;

    /* JADX INFO: renamed from: n */
    public float f323n;

    /* JADX INFO: renamed from: o */
    public String f324o;

    /* JADX INFO: renamed from: p */
    public boolean f325p;

    /* JADX INFO: renamed from: q */
    public final Rect f326q;

    /* JADX INFO: renamed from: r */
    public int f327r;

    /* JADX INFO: renamed from: s */
    public int f328s;

    /* JADX INFO: renamed from: t */
    public int f329t;

    /* JADX INFO: renamed from: u */
    public int f330u;

    /* JADX INFO: renamed from: v */
    public String f331v;

    /* JADX INFO: renamed from: w */
    public int f332w;

    /* JADX INFO: renamed from: x */
    public int f333x;

    /* JADX INFO: renamed from: y */
    public boolean f334y;

    /* JADX INFO: renamed from: z */
    public float f335z;

    public MotionLabel(Context context, @Nullable AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f310a = new TextPaint();
        this.f311b = new Path();
        this.f312c = 65535;
        this.f313d = 65535;
        this.f314e = false;
        this.f315f = 0.0f;
        this.f316g = Float.NaN;
        this.f319j = 48.0f;
        this.f320k = Float.NaN;
        this.f323n = 0.0f;
        this.f324o = "Hello World";
        this.f325p = true;
        this.f326q = new Rect();
        this.f327r = 1;
        this.f328s = 1;
        this.f329t = 1;
        this.f330u = 1;
        this.f332w = 8388659;
        this.f333x = 0;
        this.f334y = false;
        this.f297H = Float.NaN;
        this.f298I = Float.NaN;
        this.f299J = 0.0f;
        this.f300K = 0.0f;
        this.f301L = new Paint();
        this.f302M = 0;
        this.f306Q = Float.NaN;
        this.f307R = Float.NaN;
        this.f308S = Float.NaN;
        this.f309T = Float.NaN;
        m94b(context, attributeSet);
    }

    private float getHorizontalOffset() {
        float f = Float.isNaN(this.f320k) ? 1.0f : this.f319j / this.f320k;
        String str = this.f324o;
        return ((this.f299J + 1.0f) * ((((Float.isNaN(this.f290A) ? getMeasuredWidth() : this.f290A) - getPaddingLeft()) - getPaddingRight()) - (this.f310a.measureText(str, 0, str.length()) * f))) / 2.0f;
    }

    private float getVerticalOffset() {
        float f = Float.isNaN(this.f320k) ? 1.0f : this.f319j / this.f320k;
        Paint.FontMetrics fontMetrics = this.f310a.getFontMetrics();
        float measuredHeight = ((Float.isNaN(this.f291B) ? getMeasuredHeight() : this.f291B) - getPaddingTop()) - getPaddingBottom();
        float f2 = fontMetrics.descent;
        float f3 = fontMetrics.ascent;
        return (((1.0f - this.f300K) * (measuredHeight - ((f2 - f3) * f))) / 2.0f) - (f * f3);
    }

    /* JADX INFO: renamed from: a */
    public final void m93a(float f) {
        if (this.f314e || f != 1.0f) {
            this.f311b.reset();
            String str = this.f324o;
            int length = str.length();
            TextPaint textPaint = this.f310a;
            Rect rect = this.f326q;
            textPaint.getTextBounds(str, 0, length, rect);
            this.f310a.getTextPath(str, 0, length, 0.0f, 0.0f, this.f311b);
            if (f != 1.0f) {
                c.u();
                Matrix matrix = new Matrix();
                matrix.postScale(f, f);
                this.f311b.transform(matrix);
            }
            rect.right--;
            rect.left++;
            rect.bottom++;
            rect.top--;
            RectF rectF = new RectF();
            rectF.bottom = getHeight();
            rectF.right = getWidth();
            this.f325p = false;
        }
    }

    /* JADX INFO: renamed from: b */
    public final void m94b(Context context, AttributeSet attributeSet) {
        Typeface typefaceCreate;
        TypedValue typedValue = new TypedValue();
        context.getTheme().resolveAttribute(C0037R.attr.colorPrimary, typedValue, true);
        int i = typedValue.data;
        this.f312c = i;
        TextPaint textPaint = this.f310a;
        textPaint.setColor(i);
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.q);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i2 = 0; i2 < indexCount; i2++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i2);
                if (index == 5) {
                    setText(typedArrayObtainStyledAttributes.getText(index));
                } else if (index == 7) {
                    this.f331v = typedArrayObtainStyledAttributes.getString(index);
                } else if (index == 11) {
                    this.f320k = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, (int) this.f320k);
                } else if (index == 0) {
                    this.f319j = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, (int) this.f319j);
                } else if (index == 2) {
                    this.f321l = typedArrayObtainStyledAttributes.getInt(index, this.f321l);
                } else if (index == 1) {
                    this.f322m = typedArrayObtainStyledAttributes.getInt(index, this.f322m);
                } else if (index == 3) {
                    this.f312c = typedArrayObtainStyledAttributes.getColor(index, this.f312c);
                } else if (index == 9) {
                    float dimension = typedArrayObtainStyledAttributes.getDimension(index, this.f316g);
                    this.f316g = dimension;
                    setRound(dimension);
                } else if (index == 10) {
                    float f = typedArrayObtainStyledAttributes.getFloat(index, this.f315f);
                    this.f315f = f;
                    setRoundPercent(f);
                } else if (index == 4) {
                    setGravity(typedArrayObtainStyledAttributes.getInt(index, -1));
                } else if (index == 8) {
                    this.f333x = typedArrayObtainStyledAttributes.getInt(index, 0);
                } else if (index == 17) {
                    this.f313d = typedArrayObtainStyledAttributes.getInt(index, this.f313d);
                    this.f314e = true;
                } else if (index == 18) {
                    this.f323n = typedArrayObtainStyledAttributes.getDimension(index, this.f323n);
                    this.f314e = true;
                } else if (index == 12) {
                    this.f292C = typedArrayObtainStyledAttributes.getDrawable(index);
                    this.f314e = true;
                } else if (index == 13) {
                    this.f306Q = typedArrayObtainStyledAttributes.getFloat(index, this.f306Q);
                } else if (index == 14) {
                    this.f307R = typedArrayObtainStyledAttributes.getFloat(index, this.f307R);
                } else if (index == 19) {
                    this.f299J = typedArrayObtainStyledAttributes.getFloat(index, this.f299J);
                } else if (index == 20) {
                    this.f300K = typedArrayObtainStyledAttributes.getFloat(index, this.f300K);
                } else if (index == 15) {
                    this.f309T = typedArrayObtainStyledAttributes.getFloat(index, this.f309T);
                } else if (index == 16) {
                    this.f308S = typedArrayObtainStyledAttributes.getFloat(index, this.f308S);
                } else if (index == 23) {
                    this.f297H = typedArrayObtainStyledAttributes.getDimension(index, this.f297H);
                } else if (index == 24) {
                    this.f298I = typedArrayObtainStyledAttributes.getDimension(index, this.f298I);
                } else if (index == 22) {
                    this.f302M = typedArrayObtainStyledAttributes.getInt(index, this.f302M);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
        if (this.f292C != null) {
            this.f296G = new Matrix();
            int intrinsicWidth = this.f292C.getIntrinsicWidth();
            int intrinsicHeight = this.f292C.getIntrinsicHeight();
            if (intrinsicWidth <= 0 && (intrinsicWidth = getWidth()) == 0) {
                intrinsicWidth = Float.isNaN(this.f298I) ? 128 : (int) this.f298I;
            }
            if (intrinsicHeight <= 0 && (intrinsicHeight = getHeight()) == 0) {
                intrinsicHeight = Float.isNaN(this.f297H) ? 128 : (int) this.f297H;
            }
            if (this.f302M != 0) {
                intrinsicWidth /= 2;
                intrinsicHeight /= 2;
            }
            this.f294E = Bitmap.createBitmap(intrinsicWidth, intrinsicHeight, Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(this.f294E);
            this.f292C.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
            this.f292C.setFilterBitmap(true);
            this.f292C.draw(canvas);
            if (this.f302M != 0) {
                Bitmap bitmap = this.f294E;
                System.nanoTime();
                int width = bitmap.getWidth() / 2;
                int height = bitmap.getHeight() / 2;
                Bitmap bitmapCreateScaledBitmap = Bitmap.createScaledBitmap(bitmap, width, height, true);
                for (int i3 = 0; i3 < 4 && width >= 32 && height >= 32; i3++) {
                    width /= 2;
                    height /= 2;
                    bitmapCreateScaledBitmap = Bitmap.createScaledBitmap(bitmapCreateScaledBitmap, width, height, true);
                }
                this.f294E = bitmapCreateScaledBitmap;
            }
            Bitmap bitmap2 = this.f294E;
            Shader.TileMode tileMode = Shader.TileMode.REPEAT;
            this.f295F = new BitmapShader(bitmap2, tileMode, tileMode);
        }
        this.f327r = getPaddingLeft();
        this.f328s = getPaddingRight();
        this.f329t = getPaddingTop();
        this.f330u = getPaddingBottom();
        String str = this.f331v;
        int i4 = this.f322m;
        int i5 = this.f321l;
        if (str != null) {
            typefaceCreate = Typeface.create(str, i5);
            if (typefaceCreate != null) {
                setTypeface(typefaceCreate);
            }
            textPaint.setColor(this.f312c);
            textPaint.setStrokeWidth(this.f323n);
            textPaint.setStyle(Paint.Style.FILL_AND_STROKE);
            textPaint.setFlags(Optimizer.OPTIMIZATION_GRAPH_WRAP);
            setTextSize(this.f319j);
            textPaint.setAntiAlias(true);
        }
        typefaceCreate = null;
        if (i4 == 1) {
            typefaceCreate = Typeface.SANS_SERIF;
        } else if (i4 == 2) {
            typefaceCreate = Typeface.SERIF;
        } else if (i4 == 3) {
            typefaceCreate = Typeface.MONOSPACE;
        }
        if (i5 > 0) {
            Typeface typefaceDefaultFromStyle = typefaceCreate == null ? Typeface.defaultFromStyle(i5) : Typeface.create(typefaceCreate, i5);
            setTypeface(typefaceDefaultFromStyle);
            int i6 = (~(typefaceDefaultFromStyle != null ? typefaceDefaultFromStyle.getStyle() : 0)) & i5;
            textPaint.setFakeBoldText((i6 & 1) != 0);
            textPaint.setTextSkewX((i6 & 2) != 0 ? -0.25f : 0.0f);
        } else {
            textPaint.setFakeBoldText(false);
            textPaint.setTextSkewX(0.0f);
            setTypeface(typefaceCreate);
        }
        textPaint.setColor(this.f312c);
        textPaint.setStrokeWidth(this.f323n);
        textPaint.setStyle(Paint.Style.FILL_AND_STROKE);
        textPaint.setFlags(Optimizer.OPTIMIZATION_GRAPH_WRAP);
        setTextSize(this.f319j);
        textPaint.setAntiAlias(true);
    }

    /* JADX INFO: renamed from: c */
    public final void m95c(float f, float f2, float f3, float f4) {
        int i = (int) (f + 0.5f);
        this.f335z = f - i;
        int i2 = (int) (f3 + 0.5f);
        int i3 = i2 - i;
        int i4 = (int) (f4 + 0.5f);
        int i5 = (int) (0.5f + f2);
        int i6 = i4 - i5;
        float f5 = f3 - f;
        this.f290A = f5;
        float f6 = f4 - f2;
        this.f291B = f6;
        if (this.f296G != null) {
            this.f290A = f5;
            this.f291B = f6;
            m96d();
        }
        if (getMeasuredHeight() == i6 && getMeasuredWidth() == i3) {
            super.layout(i, i5, i2, i4);
        } else {
            measure(View.MeasureSpec.makeMeasureSpec(i3, BasicMeasure.EXACTLY), View.MeasureSpec.makeMeasureSpec(i6, BasicMeasure.EXACTLY));
            super.layout(i, i5, i2, i4);
        }
        if (this.f334y) {
            Rect rect = this.f303N;
            TextPaint textPaint = this.f310a;
            if (rect == null) {
                this.f304O = new Paint();
                this.f303N = new Rect();
                this.f304O.set(textPaint);
                this.f305P = this.f304O.getTextSize();
            }
            this.f290A = f5;
            this.f291B = f6;
            Paint paint = this.f304O;
            String str = this.f324o;
            paint.getTextBounds(str, 0, str.length(), this.f303N);
            int iWidth = this.f303N.width();
            float fHeight = this.f303N.height() * 1.3f;
            float f7 = (f5 - this.f328s) - this.f327r;
            float f8 = (f6 - this.f330u) - this.f329t;
            float f9 = iWidth;
            if (f9 * f8 > fHeight * f7) {
                textPaint.setTextSize((this.f305P * f7) / f9);
            } else {
                textPaint.setTextSize((this.f305P * f8) / fHeight);
            }
            if (this.f314e || !Float.isNaN(this.f320k)) {
                m93a(Float.isNaN(this.f320k) ? 1.0f : this.f319j / this.f320k);
            }
        }
    }

    /* JADX INFO: renamed from: d */
    public final void m96d() {
        float f = Float.isNaN(this.f306Q) ? 0.0f : this.f306Q;
        float f2 = Float.isNaN(this.f307R) ? 0.0f : this.f307R;
        float f3 = Float.isNaN(this.f308S) ? 1.0f : this.f308S;
        float f4 = Float.isNaN(this.f309T) ? 0.0f : this.f309T;
        this.f296G.reset();
        float width = this.f294E.getWidth();
        float height = this.f294E.getHeight();
        float f5 = Float.isNaN(this.f298I) ? this.f290A : this.f298I;
        float f6 = Float.isNaN(this.f297H) ? this.f291B : this.f297H;
        float f7 = f3 * (width * f6 < height * f5 ? f5 / width : f6 / height);
        this.f296G.postScale(f7, f7);
        float f8 = width * f7;
        float f9 = f5 - f8;
        float f10 = f7 * height;
        float f11 = f6 - f10;
        if (!Float.isNaN(this.f297H)) {
            f11 = this.f297H / 2.0f;
        }
        if (!Float.isNaN(this.f298I)) {
            f9 = this.f298I / 2.0f;
        }
        this.f296G.postTranslate((((f * f9) + f5) - f8) * 0.5f, (((f2 * f11) + f6) - f10) * 0.5f);
        this.f296G.postRotate(f4, f5 / 2.0f, f6 / 2.0f);
        this.f295F.setLocalMatrix(this.f296G);
    }

    public float getRound() {
        return this.f316g;
    }

    public float getRoundPercent() {
        return this.f315f;
    }

    public float getScaleFromTextSize() {
        return this.f320k;
    }

    public float getTextBackgroundPanX() {
        return this.f306Q;
    }

    public float getTextBackgroundPanY() {
        return this.f307R;
    }

    public float getTextBackgroundRotate() {
        return this.f309T;
    }

    public float getTextBackgroundZoom() {
        return this.f308S;
    }

    public int getTextOutlineColor() {
        return this.f313d;
    }

    public float getTextPanX() {
        return this.f299J;
    }

    public float getTextPanY() {
        return this.f300K;
    }

    public float getTextureHeight() {
        return this.f297H;
    }

    public float getTextureWidth() {
        return this.f298I;
    }

    public Typeface getTypeface() {
        return this.f310a.getTypeface();
    }

    @Override // android.view.View
    public final void layout(int i, int i2, int i3, int i4) {
        super.layout(i, i2, i3, i4);
        boolean zIsNaN = Float.isNaN(this.f320k);
        float f = zIsNaN ? 1.0f : this.f319j / this.f320k;
        this.f290A = i3 - i;
        this.f291B = i4 - i2;
        if (this.f334y) {
            Rect rect = this.f303N;
            TextPaint textPaint = this.f310a;
            if (rect == null) {
                this.f304O = new Paint();
                this.f303N = new Rect();
                this.f304O.set(textPaint);
                this.f305P = this.f304O.getTextSize();
            }
            Paint paint = this.f304O;
            String str = this.f324o;
            paint.getTextBounds(str, 0, str.length(), this.f303N);
            int iWidth = this.f303N.width();
            int iHeight = (int) (this.f303N.height() * 1.3f);
            float f2 = (this.f290A - this.f328s) - this.f327r;
            float f3 = (this.f291B - this.f330u) - this.f329t;
            if (zIsNaN) {
                float f4 = iWidth;
                float f5 = iHeight;
                if (f4 * f3 > f5 * f2) {
                    textPaint.setTextSize((this.f305P * f2) / f4);
                } else {
                    textPaint.setTextSize((this.f305P * f3) / f5);
                }
            } else {
                float f6 = iWidth;
                float f7 = iHeight;
                f = f6 * f3 > f7 * f2 ? f2 / f6 : f3 / f7;
            }
        }
        if (this.f314e || !zIsNaN) {
            float f8 = i;
            float f9 = i2;
            float f10 = i3;
            float f11 = i4;
            if (this.f296G != null) {
                this.f290A = f10 - f8;
                this.f291B = f11 - f9;
                m96d();
            }
            m93a(f);
        }
    }

    @Override // android.view.View
    public final void onDraw(Canvas canvas) {
        float f = Float.isNaN(this.f320k) ? 1.0f : this.f319j / this.f320k;
        super.onDraw(canvas);
        boolean z = this.f314e;
        TextPaint textPaint = this.f310a;
        if (!z && f == 1.0f) {
            canvas.drawText(this.f324o, this.f335z + this.f327r + getHorizontalOffset(), this.f329t + getVerticalOffset(), textPaint);
            return;
        }
        if (this.f325p) {
            m93a(f);
        }
        if (this.f293D == null) {
            this.f293D = new Matrix();
        }
        if (!this.f314e) {
            float horizontalOffset = this.f327r + getHorizontalOffset();
            float verticalOffset = this.f329t + getVerticalOffset();
            this.f293D.reset();
            this.f293D.preTranslate(horizontalOffset, verticalOffset);
            this.f311b.transform(this.f293D);
            textPaint.setColor(this.f312c);
            textPaint.setStyle(Paint.Style.FILL_AND_STROKE);
            textPaint.setStrokeWidth(this.f323n);
            canvas.drawPath(this.f311b, textPaint);
            this.f293D.reset();
            this.f293D.preTranslate(-horizontalOffset, -verticalOffset);
            this.f311b.transform(this.f293D);
            return;
        }
        Paint paint = this.f301L;
        paint.set(textPaint);
        this.f293D.reset();
        float horizontalOffset2 = this.f327r + getHorizontalOffset();
        float verticalOffset2 = this.f329t + getVerticalOffset();
        this.f293D.postTranslate(horizontalOffset2, verticalOffset2);
        this.f293D.preScale(f, f);
        this.f311b.transform(this.f293D);
        if (this.f295F != null) {
            textPaint.setFilterBitmap(true);
            textPaint.setShader(this.f295F);
        } else {
            textPaint.setColor(this.f312c);
        }
        textPaint.setStyle(Paint.Style.FILL);
        textPaint.setStrokeWidth(this.f323n);
        canvas.drawPath(this.f311b, textPaint);
        if (this.f295F != null) {
            textPaint.setShader(null);
        }
        textPaint.setColor(this.f313d);
        textPaint.setStyle(Paint.Style.STROKE);
        textPaint.setStrokeWidth(this.f323n);
        canvas.drawPath(this.f311b, textPaint);
        this.f293D.reset();
        this.f293D.postTranslate(-horizontalOffset2, -verticalOffset2);
        this.f311b.transform(this.f293D);
        textPaint.set(paint);
    }

    @Override // android.view.View
    public final void onMeasure(int i, int i2) {
        int mode = View.MeasureSpec.getMode(i);
        int mode2 = View.MeasureSpec.getMode(i2);
        int size = View.MeasureSpec.getSize(i);
        int size2 = View.MeasureSpec.getSize(i2);
        this.f334y = false;
        this.f327r = getPaddingLeft();
        this.f328s = getPaddingRight();
        this.f329t = getPaddingTop();
        this.f330u = getPaddingBottom();
        if (mode != 1073741824 || mode2 != 1073741824) {
            String str = this.f324o;
            int length = str.length();
            TextPaint textPaint = this.f310a;
            Rect rect = this.f326q;
            textPaint.getTextBounds(str, 0, length, rect);
            if (mode != 1073741824) {
                size = (int) (rect.width() + 0.99999f);
            }
            size += this.f327r + this.f328s;
            if (mode2 != 1073741824) {
                int fontMetricsInt = (int) (textPaint.getFontMetricsInt(null) + 0.99999f);
                if (mode2 == Integer.MIN_VALUE) {
                    fontMetricsInt = Math.min(size2, fontMetricsInt);
                }
                size2 = this.f329t + this.f330u + fontMetricsInt;
            }
        } else if (this.f333x != 0) {
            this.f334y = true;
        }
        setMeasuredDimension(size, size2);
    }

    @SuppressLint({"RtlHardcoded"})
    public void setGravity(int i) {
        if ((i & 8388615) == 0) {
            i |= 8388611;
        }
        if ((i & 112) == 0) {
            i |= 48;
        }
        if (i != this.f332w) {
            invalidate();
        }
        this.f332w = i;
        int i2 = i & 112;
        if (i2 == 48) {
            this.f300K = -1.0f;
        } else if (i2 != 80) {
            this.f300K = 0.0f;
        } else {
            this.f300K = 1.0f;
        }
        int i3 = i & 8388615;
        if (i3 != 3) {
            if (i3 != 5) {
                if (i3 != 8388611) {
                    if (i3 != 8388613) {
                        this.f299J = 0.0f;
                        return;
                    }
                }
            }
            this.f299J = 1.0f;
            return;
        }
        this.f299J = -1.0f;
    }

    public void setRound(float f) {
        if (Float.isNaN(f)) {
            this.f316g = f;
            float f2 = this.f315f;
            this.f315f = -1.0f;
            setRoundPercent(f2);
            return;
        }
        boolean z = this.f316g != f;
        this.f316g = f;
        if (f != 0.0f) {
            if (this.f311b == null) {
                this.f311b = new Path();
            }
            if (this.f318i == null) {
                this.f318i = new RectF();
            }
            if (this.f317h == null) {
                e eVar = new e(this, 1);
                this.f317h = eVar;
                setOutlineProvider(eVar);
            }
            setClipToOutline(true);
            this.f318i.set(0.0f, 0.0f, getWidth(), getHeight());
            this.f311b.reset();
            Path path = this.f311b;
            RectF rectF = this.f318i;
            float f3 = this.f316g;
            path.addRoundRect(rectF, f3, f3, Path.Direction.CW);
        } else {
            setClipToOutline(false);
        }
        if (z) {
            invalidateOutline();
        }
    }

    public void setRoundPercent(float f) {
        boolean z = this.f315f != f;
        this.f315f = f;
        if (f != 0.0f) {
            if (this.f311b == null) {
                this.f311b = new Path();
            }
            if (this.f318i == null) {
                this.f318i = new RectF();
            }
            if (this.f317h == null) {
                e eVar = new e(this, 0);
                this.f317h = eVar;
                setOutlineProvider(eVar);
            }
            setClipToOutline(true);
            int width = getWidth();
            int height = getHeight();
            float fMin = (Math.min(width, height) * this.f315f) / 2.0f;
            this.f318i.set(0.0f, 0.0f, width, height);
            this.f311b.reset();
            this.f311b.addRoundRect(this.f318i, fMin, fMin, Path.Direction.CW);
        } else {
            setClipToOutline(false);
        }
        if (z) {
            invalidateOutline();
        }
    }

    public void setScaleFromTextSize(float f) {
        this.f320k = f;
    }

    public void setText(CharSequence charSequence) {
        this.f324o = charSequence.toString();
        invalidate();
    }

    public void setTextBackgroundPanX(float f) {
        this.f306Q = f;
        m96d();
        invalidate();
    }

    public void setTextBackgroundPanY(float f) {
        this.f307R = f;
        m96d();
        invalidate();
    }

    public void setTextBackgroundRotate(float f) {
        this.f309T = f;
        m96d();
        invalidate();
    }

    public void setTextBackgroundZoom(float f) {
        this.f308S = f;
        m96d();
        invalidate();
    }

    public void setTextFillColor(int i) {
        this.f312c = i;
        invalidate();
    }

    public void setTextOutlineColor(int i) {
        this.f313d = i;
        this.f314e = true;
        invalidate();
    }

    public void setTextOutlineThickness(float f) {
        this.f323n = f;
        this.f314e = true;
        if (Float.isNaN(f)) {
            this.f323n = 1.0f;
            this.f314e = false;
        }
        invalidate();
    }

    public void setTextPanX(float f) {
        this.f299J = f;
        invalidate();
    }

    public void setTextPanY(float f) {
        this.f300K = f;
        invalidate();
    }

    public void setTextSize(float f) {
        this.f319j = f;
        c.u();
        if (!Float.isNaN(this.f320k)) {
            f = this.f320k;
        }
        this.f310a.setTextSize(f);
        m93a(Float.isNaN(this.f320k) ? 1.0f : this.f319j / this.f320k);
        requestLayout();
        invalidate();
    }

    public void setTextureHeight(float f) {
        this.f297H = f;
        m96d();
        invalidate();
    }

    public void setTextureWidth(float f) {
        this.f298I = f;
        m96d();
        invalidate();
    }

    public void setTypeface(Typeface typeface) {
        TextPaint textPaint = this.f310a;
        if (textPaint.getTypeface() != typeface) {
            textPaint.setTypeface(typeface);
        }
    }

    public MotionLabel(Context context, @Nullable AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f310a = new TextPaint();
        this.f311b = new Path();
        this.f312c = 65535;
        this.f313d = 65535;
        this.f314e = false;
        this.f315f = 0.0f;
        this.f316g = Float.NaN;
        this.f319j = 48.0f;
        this.f320k = Float.NaN;
        this.f323n = 0.0f;
        this.f324o = "Hello World";
        this.f325p = true;
        this.f326q = new Rect();
        this.f327r = 1;
        this.f328s = 1;
        this.f329t = 1;
        this.f330u = 1;
        this.f332w = 8388659;
        this.f333x = 0;
        this.f334y = false;
        this.f297H = Float.NaN;
        this.f298I = Float.NaN;
        this.f299J = 0.0f;
        this.f300K = 0.0f;
        this.f301L = new Paint();
        this.f302M = 0;
        this.f306Q = Float.NaN;
        this.f307R = Float.NaN;
        this.f308S = Float.NaN;
        this.f309T = Float.NaN;
        m94b(context, attributeSet);
    }
}
