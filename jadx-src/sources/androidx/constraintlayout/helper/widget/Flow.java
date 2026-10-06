package androidx.constraintlayout.helper.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.util.SparseArray;
import android.view.View;
import androidx.constraintlayout.widget.C0040c;
import androidx.constraintlayout.widget.Constraints;
import androidx.constraintlayout.widget.VirtualLayout;
import d1.f;
import d1.i;
import d1.l;
import d1.o;
import j1.m;

/* JADX INFO: loaded from: classes.dex */
public class Flow extends VirtualLayout {

    /* JADX INFO: renamed from: k */
    public i f55k;

    public Flow(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    @Override // androidx.constraintlayout.widget.VirtualLayout, androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: k */
    public final void mo24k(AttributeSet attributeSet) {
        super.mo24k(attributeSet);
        this.f55k = new i();
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.c);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 0) {
                    this.f55k.Z0 = typedArrayObtainStyledAttributes.getInt(index, 0);
                } else if (index == 1) {
                    i iVar = this.f55k;
                    int dimensionPixelSize = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                    ((o) iVar).w0 = dimensionPixelSize;
                    ((o) iVar).x0 = dimensionPixelSize;
                    ((o) iVar).y0 = dimensionPixelSize;
                    ((o) iVar).z0 = dimensionPixelSize;
                } else if (index == 18) {
                    i iVar2 = this.f55k;
                    int dimensionPixelSize2 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                    ((o) iVar2).y0 = dimensionPixelSize2;
                    ((o) iVar2).A0 = dimensionPixelSize2;
                    ((o) iVar2).B0 = dimensionPixelSize2;
                } else if (index == 19) {
                    ((o) this.f55k).z0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                } else if (index == 2) {
                    ((o) this.f55k).A0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                } else if (index == 3) {
                    ((o) this.f55k).w0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                } else if (index == 4) {
                    ((o) this.f55k).B0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                } else if (index == 5) {
                    ((o) this.f55k).x0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                } else if (index == 54) {
                    this.f55k.X0 = typedArrayObtainStyledAttributes.getInt(index, 0);
                } else if (index == 44) {
                    this.f55k.H0 = typedArrayObtainStyledAttributes.getInt(index, 0);
                } else if (index == 53) {
                    this.f55k.I0 = typedArrayObtainStyledAttributes.getInt(index, 0);
                } else if (index == 38) {
                    this.f55k.J0 = typedArrayObtainStyledAttributes.getInt(index, 0);
                } else if (index == 46) {
                    this.f55k.L0 = typedArrayObtainStyledAttributes.getInt(index, 0);
                } else if (index == 40) {
                    this.f55k.K0 = typedArrayObtainStyledAttributes.getInt(index, 0);
                } else if (index == 48) {
                    this.f55k.M0 = typedArrayObtainStyledAttributes.getInt(index, 0);
                } else if (index == 42) {
                    this.f55k.N0 = typedArrayObtainStyledAttributes.getFloat(index, 0.5f);
                } else if (index == 37) {
                    this.f55k.P0 = typedArrayObtainStyledAttributes.getFloat(index, 0.5f);
                } else if (index == 45) {
                    this.f55k.R0 = typedArrayObtainStyledAttributes.getFloat(index, 0.5f);
                } else if (index == 39) {
                    this.f55k.Q0 = typedArrayObtainStyledAttributes.getFloat(index, 0.5f);
                } else if (index == 47) {
                    this.f55k.S0 = typedArrayObtainStyledAttributes.getFloat(index, 0.5f);
                } else if (index == 51) {
                    this.f55k.O0 = typedArrayObtainStyledAttributes.getFloat(index, 0.5f);
                } else if (index == 41) {
                    this.f55k.V0 = typedArrayObtainStyledAttributes.getInt(index, 2);
                } else if (index == 50) {
                    this.f55k.W0 = typedArrayObtainStyledAttributes.getInt(index, 2);
                } else if (index == 43) {
                    this.f55k.T0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                } else if (index == 52) {
                    this.f55k.U0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, 0);
                } else if (index == 49) {
                    this.f55k.Y0 = typedArrayObtainStyledAttributes.getInt(index, -1);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
        this.f350d = this.f55k;
        m107q();
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: l */
    public final void mo27l(C0040c c0040c, l lVar, Constraints.LayoutParams layoutParams, SparseArray sparseArray) {
        super.mo27l(c0040c, lVar, layoutParams, sparseArray);
        if (lVar instanceof i) {
            i iVar = (i) lVar;
            int i = layoutParams.f395V;
            if (i != -1) {
                iVar.Z0 = i;
            }
        }
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper
    /* JADX INFO: renamed from: m */
    public final void mo28m(f fVar, boolean z) {
        i iVar = this.f55k;
        int i = ((o) iVar).y0;
        if (i > 0 || ((o) iVar).z0 > 0) {
            if (z) {
                ((o) iVar).A0 = ((o) iVar).z0;
                ((o) iVar).B0 = i;
            } else {
                ((o) iVar).A0 = i;
                ((o) iVar).B0 = ((o) iVar).z0;
            }
        }
    }

    @Override // androidx.constraintlayout.widget.ConstraintHelper, android.view.View
    public final void onMeasure(int i, int i2) {
        mo29r(this.f55k, i, i2);
    }

    @Override // androidx.constraintlayout.widget.VirtualLayout
    /* JADX INFO: renamed from: r */
    public final void mo29r(o oVar, int i, int i2) {
        int mode = View.MeasureSpec.getMode(i);
        int size = View.MeasureSpec.getSize(i);
        int mode2 = View.MeasureSpec.getMode(i2);
        int size2 = View.MeasureSpec.getSize(i2);
        if (oVar == null) {
            setMeasuredDimension(0, 0);
        } else {
            oVar.V(mode, size, mode2, size2);
            setMeasuredDimension(oVar.D0, oVar.E0);
        }
    }

    public void setFirstHorizontalBias(float f) {
        this.f55k.P0 = f;
        requestLayout();
    }

    public void setFirstHorizontalStyle(int i) {
        this.f55k.J0 = i;
        requestLayout();
    }

    public void setFirstVerticalBias(float f) {
        this.f55k.Q0 = f;
        requestLayout();
    }

    public void setFirstVerticalStyle(int i) {
        this.f55k.K0 = i;
        requestLayout();
    }

    public void setHorizontalAlign(int i) {
        this.f55k.V0 = i;
        requestLayout();
    }

    public void setHorizontalBias(float f) {
        this.f55k.N0 = f;
        requestLayout();
    }

    public void setHorizontalGap(int i) {
        this.f55k.T0 = i;
        requestLayout();
    }

    public void setHorizontalStyle(int i) {
        this.f55k.H0 = i;
        requestLayout();
    }

    public void setLastHorizontalBias(float f) {
        this.f55k.R0 = f;
        requestLayout();
    }

    public void setLastHorizontalStyle(int i) {
        this.f55k.L0 = i;
        requestLayout();
    }

    public void setLastVerticalBias(float f) {
        this.f55k.S0 = f;
        requestLayout();
    }

    public void setLastVerticalStyle(int i) {
        this.f55k.M0 = i;
        requestLayout();
    }

    public void setMaxElementsWrap(int i) {
        this.f55k.Y0 = i;
        requestLayout();
    }

    public void setOrientation(int i) {
        this.f55k.Z0 = i;
        requestLayout();
    }

    public void setPadding(int i) {
        i iVar = this.f55k;
        ((o) iVar).w0 = i;
        ((o) iVar).x0 = i;
        ((o) iVar).y0 = i;
        ((o) iVar).z0 = i;
        requestLayout();
    }

    public void setPaddingBottom(int i) {
        ((o) this.f55k).x0 = i;
        requestLayout();
    }

    public void setPaddingLeft(int i) {
        ((o) this.f55k).A0 = i;
        requestLayout();
    }

    public void setPaddingRight(int i) {
        ((o) this.f55k).B0 = i;
        requestLayout();
    }

    public void setPaddingTop(int i) {
        ((o) this.f55k).w0 = i;
        requestLayout();
    }

    public void setVerticalAlign(int i) {
        this.f55k.W0 = i;
        requestLayout();
    }

    public void setVerticalBias(float f) {
        this.f55k.O0 = f;
        requestLayout();
    }

    public void setVerticalGap(int i) {
        this.f55k.U0 = i;
        requestLayout();
    }

    public void setVerticalStyle(int i) {
        this.f55k.I0 = i;
        requestLayout();
    }

    public void setWrapMode(int i) {
        this.f55k.X0 = i;
        requestLayout();
    }

    public Flow(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }
}
