package androidx.constraintlayout.utils.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.View;
import j1.m;

/* JADX INFO: loaded from: classes.dex */
public class MockView extends View {

    /* JADX INFO: renamed from: a */
    public final Paint f274a;

    /* JADX INFO: renamed from: b */
    public final Paint f275b;

    /* JADX INFO: renamed from: c */
    public final Paint f276c;

    /* JADX INFO: renamed from: d */
    public boolean f277d;

    /* JADX INFO: renamed from: e */
    public boolean f278e;

    /* JADX INFO: renamed from: f */
    public String f279f;

    /* JADX INFO: renamed from: g */
    public final Rect f280g;

    /* JADX INFO: renamed from: h */
    public int f281h;

    /* JADX INFO: renamed from: i */
    public int f282i;

    /* JADX INFO: renamed from: j */
    public int f283j;

    /* JADX INFO: renamed from: k */
    public int f284k;

    public MockView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f274a = new Paint();
        this.f275b = new Paint();
        this.f276c = new Paint();
        this.f277d = true;
        this.f278e = true;
        this.f279f = null;
        this.f280g = new Rect();
        this.f281h = Color.argb(255, 0, 0, 0);
        this.f282i = Color.argb(255, 200, 200, 200);
        this.f283j = Color.argb(255, 50, 50, 50);
        this.f284k = 4;
        m91a(context, attributeSet);
    }

    /* JADX INFO: renamed from: a */
    public final void m91a(Context context, AttributeSet attributeSet) {
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, m.m);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 1) {
                    this.f279f = typedArrayObtainStyledAttributes.getString(index);
                } else if (index == 4) {
                    this.f277d = typedArrayObtainStyledAttributes.getBoolean(index, this.f277d);
                } else if (index == 0) {
                    this.f281h = typedArrayObtainStyledAttributes.getColor(index, this.f281h);
                } else if (index == 2) {
                    this.f283j = typedArrayObtainStyledAttributes.getColor(index, this.f283j);
                } else if (index == 3) {
                    this.f282i = typedArrayObtainStyledAttributes.getColor(index, this.f282i);
                } else if (index == 5) {
                    this.f278e = typedArrayObtainStyledAttributes.getBoolean(index, this.f278e);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
        if (this.f279f == null) {
            try {
                this.f279f = context.getResources().getResourceEntryName(getId());
            } catch (Exception unused) {
            }
        }
        int i2 = this.f281h;
        Paint paint = this.f274a;
        paint.setColor(i2);
        paint.setAntiAlias(true);
        int i3 = this.f282i;
        Paint paint2 = this.f275b;
        paint2.setColor(i3);
        paint2.setAntiAlias(true);
        this.f276c.setColor(this.f283j);
        this.f284k = Math.round((getResources().getDisplayMetrics().xdpi / 160.0f) * this.f284k);
    }

    @Override // android.view.View
    public void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        int width = getWidth();
        int height = getHeight();
        if (this.f277d) {
            width--;
            height--;
            float f = width;
            float f2 = height;
            canvas.drawLine(0.0f, 0.0f, f, f2, this.f274a);
            canvas.drawLine(0.0f, f2, f, 0.0f, this.f274a);
            canvas.drawLine(0.0f, 0.0f, f, 0.0f, this.f274a);
            canvas.drawLine(f, 0.0f, f, f2, this.f274a);
            canvas.drawLine(f, f2, 0.0f, f2, this.f274a);
            canvas.drawLine(0.0f, f2, 0.0f, 0.0f, this.f274a);
        }
        String str = this.f279f;
        if (str == null || !this.f278e) {
            return;
        }
        int length = str.length();
        Paint paint = this.f275b;
        Rect rect = this.f280g;
        paint.getTextBounds(str, 0, length, rect);
        float fWidth = (width - rect.width()) / 2.0f;
        float fHeight = ((height - rect.height()) / 2.0f) + rect.height();
        rect.offset((int) fWidth, (int) fHeight);
        int i = rect.left;
        int i2 = this.f284k;
        rect.set(i - i2, rect.top - i2, rect.right + i2, rect.bottom + i2);
        canvas.drawRect(rect, this.f276c);
        canvas.drawText(this.f279f, fWidth, fHeight, paint);
    }

    public MockView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f274a = new Paint();
        this.f275b = new Paint();
        this.f276c = new Paint();
        this.f277d = true;
        this.f278e = true;
        this.f279f = null;
        this.f280g = new Rect();
        this.f281h = Color.argb(255, 0, 0, 0);
        this.f282i = Color.argb(255, 200, 200, 200);
        this.f283j = Color.argb(255, 50, 50, 50);
        this.f284k = 4;
        m91a(context, attributeSet);
    }
}
