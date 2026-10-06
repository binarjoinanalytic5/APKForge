package androidx.constraintlayout.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import j1.m;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public class Constraints extends ViewGroup {

    /* JADX INFO: renamed from: a */
    public C0041d f443a;

    public Constraints(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        super.setVisibility(8);
    }

    @Override // android.view.ViewGroup
    public final ViewGroup.LayoutParams generateDefaultLayoutParams() {
        return new LayoutParams();
    }

    @Override // android.view.ViewGroup
    public final ViewGroup.LayoutParams generateLayoutParams(AttributeSet attributeSet) {
        return new LayoutParams(getContext(), attributeSet);
    }

    public C0041d getConstraintSet() {
        if (this.f443a == null) {
            this.f443a = new C0041d();
        }
        C0041d c0041d = this.f443a;
        c0041d.getClass();
        int childCount = getChildCount();
        HashMap map = c0041d.f556f;
        map.clear();
        for (int i = 0; i < childCount; i++) {
            View childAt = getChildAt(i);
            LayoutParams layoutParams = (LayoutParams) childAt.getLayoutParams();
            int id = childAt.getId();
            if (c0041d.f555e && id == -1) {
                throw new RuntimeException("All children of ConstraintLayout must have ids to use ConstraintSet");
            }
            if (!map.containsKey(Integer.valueOf(id))) {
                map.put(Integer.valueOf(id), new C0040c());
            }
            C0040c c0040c = (C0040c) map.get(Integer.valueOf(id));
            if (c0040c != null) {
                if (childAt instanceof ConstraintHelper) {
                    C0040c.m122b(c0040c, (ConstraintHelper) childAt, id, layoutParams);
                }
                c0040c.m127g(id, layoutParams);
            }
        }
        return this.f443a;
    }

    @Override // android.view.ViewGroup, android.view.View
    public final void onLayout(boolean z, int i, int i2, int i3, int i4) {
    }

    @Override // android.view.ViewGroup
    public final ViewGroup.LayoutParams generateLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return new ConstraintLayout.LayoutParams(layoutParams);
    }

    public Constraints(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        super.setVisibility(8);
    }

    public static class LayoutParams extends ConstraintLayout.LayoutParams {

        /* JADX INFO: renamed from: A0 */
        public final float f444A0;

        /* JADX INFO: renamed from: B0 */
        public final float f445B0;

        /* JADX INFO: renamed from: C0 */
        public final float f446C0;

        /* JADX INFO: renamed from: D0 */
        public final float f447D0;

        /* JADX INFO: renamed from: r0 */
        public final float f448r0;

        /* JADX INFO: renamed from: s0 */
        public final boolean f449s0;

        /* JADX INFO: renamed from: t0 */
        public final float f450t0;

        /* JADX INFO: renamed from: u0 */
        public final float f451u0;

        /* JADX INFO: renamed from: v0 */
        public final float f452v0;

        /* JADX INFO: renamed from: w0 */
        public final float f453w0;

        /* JADX INFO: renamed from: x0 */
        public final float f454x0;

        /* JADX INFO: renamed from: y0 */
        public final float f455y0;

        /* JADX INFO: renamed from: z0 */
        public final float f456z0;

        public LayoutParams() {
            super(-2, -2);
            this.f448r0 = 1.0f;
            this.f449s0 = false;
            this.f450t0 = 0.0f;
            this.f451u0 = 0.0f;
            this.f452v0 = 0.0f;
            this.f453w0 = 0.0f;
            this.f454x0 = 1.0f;
            this.f455y0 = 1.0f;
            this.f456z0 = 0.0f;
            this.f444A0 = 0.0f;
            this.f445B0 = 0.0f;
            this.f446C0 = 0.0f;
            this.f447D0 = 0.0f;
        }

        public LayoutParams(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.f448r0 = 1.0f;
            this.f449s0 = false;
            this.f450t0 = 0.0f;
            this.f451u0 = 0.0f;
            this.f452v0 = 0.0f;
            this.f453w0 = 0.0f;
            this.f454x0 = 1.0f;
            this.f455y0 = 1.0f;
            this.f456z0 = 0.0f;
            this.f444A0 = 0.0f;
            this.f445B0 = 0.0f;
            this.f446C0 = 0.0f;
            this.f447D0 = 0.0f;
            TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, m.g);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 15) {
                    this.f448r0 = typedArrayObtainStyledAttributes.getFloat(index, this.f448r0);
                } else if (index == 28) {
                    this.f450t0 = typedArrayObtainStyledAttributes.getFloat(index, this.f450t0);
                    this.f449s0 = true;
                } else if (index == 23) {
                    this.f452v0 = typedArrayObtainStyledAttributes.getFloat(index, this.f452v0);
                } else if (index == 24) {
                    this.f453w0 = typedArrayObtainStyledAttributes.getFloat(index, this.f453w0);
                } else if (index == 22) {
                    this.f451u0 = typedArrayObtainStyledAttributes.getFloat(index, this.f451u0);
                } else if (index == 20) {
                    this.f454x0 = typedArrayObtainStyledAttributes.getFloat(index, this.f454x0);
                } else if (index == 21) {
                    this.f455y0 = typedArrayObtainStyledAttributes.getFloat(index, this.f455y0);
                } else if (index == 16) {
                    this.f456z0 = typedArrayObtainStyledAttributes.getFloat(index, this.f456z0);
                } else if (index == 17) {
                    this.f444A0 = typedArrayObtainStyledAttributes.getFloat(index, this.f444A0);
                } else if (index == 18) {
                    this.f445B0 = typedArrayObtainStyledAttributes.getFloat(index, this.f445B0);
                } else if (index == 19) {
                    this.f446C0 = typedArrayObtainStyledAttributes.getFloat(index, this.f446C0);
                } else if (index == 27) {
                    this.f447D0 = typedArrayObtainStyledAttributes.getFloat(index, this.f447D0);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
    }
}
