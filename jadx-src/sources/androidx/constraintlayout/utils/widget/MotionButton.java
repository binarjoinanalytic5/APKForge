package androidx.constraintlayout.utils.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Path;
import android.graphics.RectF;
import android.util.AttributeSet;
import android.view.ViewOutlineProvider;
import androidx.appcompat.widget.AppCompatButton;
import i1.d;
import j1.m;

/* JADX INFO: loaded from: classes.dex */
public class MotionButton extends AppCompatButton {

    /* JADX INFO: renamed from: d */
    public float f285d;

    /* JADX INFO: renamed from: e */
    public float f286e;

    /* JADX INFO: renamed from: f */
    public Path f287f;

    /* JADX INFO: renamed from: g */
    public ViewOutlineProvider f288g;

    /* JADX INFO: renamed from: h */
    public RectF f289h;

    public MotionButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f285d = 0.0f;
        this.f286e = Float.NaN;
        m92a(attributeSet);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX INFO: renamed from: a */
    public final void m92a(AttributeSet attributeSet) {
        setPadding(0, 0, 0, 0);
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.i);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 10) {
                    setRound(typedArrayObtainStyledAttributes.getDimension(index, 0.0f));
                } else if (index == 11) {
                    setRoundPercent(typedArrayObtainStyledAttributes.getFloat(index, 0.0f));
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    public float getRound() {
        return this.f286e;
    }

    public float getRoundPercent() {
        return this.f285d;
    }

    /* JADX WARN: Multi-variable type inference failed */
    public void setRound(float f) {
        if (Float.isNaN(f)) {
            this.f286e = f;
            float f2 = this.f285d;
            this.f285d = -1.0f;
            setRoundPercent(f2);
            return;
        }
        boolean z = this.f286e != f;
        this.f286e = f;
        if (f != 0.0f) {
            if (this.f287f == null) {
                this.f287f = new Path();
            }
            if (this.f289h == null) {
                this.f289h = new RectF();
            }
            if (this.f288g == null) {
                d dVar = new d(this, 1);
                this.f288g = dVar;
                setOutlineProvider(dVar);
            }
            setClipToOutline(true);
            this.f289h.set(0.0f, 0.0f, getWidth(), getHeight());
            this.f287f.reset();
            Path path = this.f287f;
            RectF rectF = this.f289h;
            float f3 = this.f286e;
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
        boolean z = this.f285d != f;
        this.f285d = f;
        if (f != 0.0f) {
            if (this.f287f == null) {
                this.f287f = new Path();
            }
            if (this.f289h == null) {
                this.f289h = new RectF();
            }
            if (this.f288g == null) {
                d dVar = new d(this, 0);
                this.f288g = dVar;
                setOutlineProvider(dVar);
            }
            setClipToOutline(true);
            int width = getWidth();
            int height = getHeight();
            float fMin = (Math.min(width, height) * this.f285d) / 2.0f;
            this.f289h.set(0.0f, 0.0f, width, height);
            this.f287f.reset();
            this.f287f.addRoundRect(this.f289h, fMin, fMin, Path.Direction.CW);
        } else {
            setClipToOutline(false);
        }
        if (z) {
            invalidateOutline();
        }
    }

    public MotionButton(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f285d = 0.0f;
        this.f286e = Float.NaN;
        m92a(attributeSet);
    }
}
