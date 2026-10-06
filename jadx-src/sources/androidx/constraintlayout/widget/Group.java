package androidx.constraintlayout.widget;

import android.content.Context;
import android.util.AttributeSet;

/* JADX INFO: loaded from: classes.dex */
public class Group extends ConstraintHelper {
    public Group(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: g */
    public final void mo30g(ConstraintLayout constraintLayout) {
        m103f(constraintLayout);
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: n */
    public final void mo31n() {
        ConstraintLayout.LayoutParams layoutParams = (ConstraintLayout.LayoutParams) getLayoutParams();
        layoutParams.f433q0.P(0);
        layoutParams.f433q0.M(0);
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper, android.view.View
    public final void onAttachedToWindow() {
        super.onAttachedToWindow();
        m102e();
    }

    @Override // android.view.View
    public void setElevation(float f) {
        super.setElevation(f);
        m102e();
    }

    @Override // android.view.View
    public void setVisibility(int i) {
        super.setVisibility(i);
        m102e();
    }

    public Group(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }
}
