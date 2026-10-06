package androidx.constraintlayout.widget;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.util.AttributeSet;
import android.util.SparseArray;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import d1.f;
import d1.l;
import j1.g;
import j1.m;
import java.util.Arrays;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public abstract class ConstraintHelper extends View {

    /* JADX INFO: renamed from: a */
    public int[] f347a;

    /* JADX INFO: renamed from: b */
    public int f348b;

    /* JADX INFO: renamed from: c */
    public Context f349c;

    /* JADX INFO: renamed from: d */
    public l f350d;

    /* JADX INFO: renamed from: e */
    public String f351e;

    /* JADX INFO: renamed from: f */
    public String f352f;

    /* JADX INFO: renamed from: g */
    public View[] f353g;

    /* JADX INFO: renamed from: h */
    public HashMap f354h;

    public ConstraintHelper(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f347a = new int[32];
        this.f353g = null;
        this.f354h = new HashMap();
        this.f349c = context;
        mo24k(attributeSet);
    }

    /* JADX INFO: renamed from: b */
    public final void m99b(String str) {
        if (str == null || str.length() == 0 || this.f349c == null) {
            return;
        }
        String strTrim = str.trim();
        if (getParent() instanceof ConstraintLayout) {
        }
        int iM105i = m105i(strTrim);
        if (iM105i != 0) {
            this.f354h.put(Integer.valueOf(iM105i), strTrim);
            m100c(iM105i);
        }
    }

    /* JADX INFO: renamed from: c */
    public final void m100c(int i) {
        if (i == getId()) {
            return;
        }
        int i2 = this.f348b + 1;
        int[] iArr = this.f347a;
        if (i2 > iArr.length) {
            this.f347a = Arrays.copyOf(iArr, iArr.length * 2);
        }
        int[] iArr2 = this.f347a;
        int i3 = this.f348b;
        iArr2[i3] = i;
        this.f348b = i3 + 1;
    }

    /* JADX INFO: renamed from: d */
    public final void m101d(String str) {
        if (str == null || str.length() == 0 || this.f349c == null) {
            return;
        }
        String strTrim = str.trim();
        ConstraintLayout constraintLayout = getParent() instanceof ConstraintLayout ? (ConstraintLayout) getParent() : null;
        if (constraintLayout == null) {
            return;
        }
        int childCount = constraintLayout.getChildCount();
        for (int i = 0; i < childCount; i++) {
            View childAt = constraintLayout.getChildAt(i);
            ViewGroup.LayoutParams layoutParams = childAt.getLayoutParams();
            if ((layoutParams instanceof ConstraintLayout.LayoutParams) && strTrim.equals(((ConstraintLayout.LayoutParams) layoutParams).f398Y) && childAt.getId() != -1) {
                m100c(childAt.getId());
            }
        }
    }

    /* JADX INFO: renamed from: e */
    public final void m102e() {
        ViewParent parent = getParent();
        if (parent == null || !(parent instanceof ConstraintLayout)) {
            return;
        }
        m103f((ConstraintLayout) parent);
    }

    /* JADX INFO: renamed from: f */
    public final void m103f(ConstraintLayout constraintLayout) {
        int visibility = getVisibility();
        float elevation = getElevation();
        for (int i = 0; i < this.f348b; i++) {
            View viewM109f = constraintLayout.m109f(this.f347a[i]);
            if (viewM109f != null) {
                viewM109f.setVisibility(visibility);
                if (elevation > 0.0f) {
                    viewM109f.setTranslationZ(viewM109f.getTranslationZ() + elevation);
                }
            }
        }
    }

    /* JADX INFO: renamed from: g */
    public void mo30g(ConstraintLayout constraintLayout) {
    }

    public int[] getReferencedIds() {
        return Arrays.copyOf(this.f347a, this.f348b);
    }

    /* JADX INFO: renamed from: h */
    public final int m104h(ConstraintLayout constraintLayout, String str) {
        Resources resources;
        String resourceEntryName;
        if (str == null || (resources = this.f349c.getResources()) == null) {
            return 0;
        }
        int childCount = constraintLayout.getChildCount();
        for (int i = 0; i < childCount; i++) {
            View childAt = constraintLayout.getChildAt(i);
            if (childAt.getId() != -1) {
                try {
                    resourceEntryName = resources.getResourceEntryName(childAt.getId());
                } catch (Resources.NotFoundException unused) {
                    resourceEntryName = null;
                }
                if (str.equals(resourceEntryName)) {
                    return childAt.getId();
                }
            }
        }
        return 0;
    }

    /* JADX WARN: Code duplicated, block: B:20:0x003a  */
    /* JADX INFO: renamed from: i */
    public final int m105i(String str) {
        int iM104h;
        HashMap map;
        ConstraintLayout constraintLayout = getParent() instanceof ConstraintLayout ? (ConstraintLayout) getParent() : null;
        if (!isInEditMode() || constraintLayout == null) {
            iM104h = 0;
        } else {
            Object obj = ((str instanceof String) && (map = constraintLayout.f368m) != null && map.containsKey(str)) ? constraintLayout.f368m.get(str) : null;
            if (obj instanceof Integer) {
                iM104h = ((Integer) obj).intValue();
            } else {
                iM104h = 0;
            }
        }
        if (iM104h == 0 && constraintLayout != null) {
            iM104h = m104h(constraintLayout, str);
        }
        if (iM104h == 0) {
            try {
                iM104h = j1.l.class.getField(str).getInt(null);
            } catch (Exception unused) {
            }
        }
        if (iM104h != 0) {
            return iM104h;
        }
        Context context = this.f349c;
        return context.getResources().getIdentifier(str, "id", context.getPackageName());
    }

    /* JADX INFO: renamed from: j */
    public final View[] m106j(ConstraintLayout constraintLayout) {
        View[] viewArr = this.f353g;
        if (viewArr == null || viewArr.length != this.f348b) {
            this.f353g = new View[this.f348b];
        }
        for (int i = 0; i < this.f348b; i++) {
            this.f353g[i] = constraintLayout.m109f(this.f347a[i]);
        }
        return this.f353g;
    }

    /* JADX INFO: renamed from: k */
    public void mo24k(AttributeSet attributeSet) {
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, m.c);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 35) {
                    String string = typedArrayObtainStyledAttributes.getString(index);
                    this.f351e = string;
                    setIds(string);
                } else if (index == 36) {
                    String string2 = typedArrayObtainStyledAttributes.getString(index);
                    this.f352f = string2;
                    setReferenceTags(string2);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    /* JADX INFO: renamed from: l */
    public void mo27l(C0040c c0040c, l lVar, Constraints.LayoutParams layoutParams, SparseArray sparseArray) {
        g gVar = c0040c.f544e;
        int[] iArr = gVar.j0;
        int i = 0;
        if (iArr != null) {
            setReferencedIds(iArr);
        } else {
            String str = gVar.k0;
            if (str != null) {
                if (str.length() > 0) {
                    String[] strArrSplit = gVar.k0.split(",");
                    getContext();
                    int[] iArrCopyOf = new int[strArrSplit.length];
                    int i2 = 0;
                    for (String str2 : strArrSplit) {
                        int iM105i = m105i(str2.trim());
                        if (iM105i != 0) {
                            iArrCopyOf[i2] = iM105i;
                            i2++;
                        }
                    }
                    if (i2 != strArrSplit.length) {
                        iArrCopyOf = Arrays.copyOf(iArrCopyOf, i2);
                    }
                    gVar.j0 = iArrCopyOf;
                } else {
                    gVar.j0 = null;
                }
            }
        }
        lVar.v0 = 0;
        Arrays.fill(lVar.u0, (Object) null);
        if (gVar.j0 == null) {
            return;
        }
        while (true) {
            int[] iArr2 = gVar.j0;
            if (i >= iArr2.length) {
                return;
            }
            f fVar = (f) sparseArray.get(iArr2[i]);
            if (fVar != null) {
                lVar.S(fVar);
            }
            i++;
        }
    }

    /* JADX INFO: renamed from: m */
    public void mo28m(f fVar, boolean z) {
    }

    /* JADX INFO: renamed from: n */
    public void mo31n() {
    }

    /* JADX INFO: renamed from: o */
    public void mo32o(ConstraintLayout constraintLayout) {
    }

    @Override // android.view.View
    public void onAttachedToWindow() {
        super.onAttachedToWindow();
        String str = this.f351e;
        if (str != null) {
            setIds(str);
        }
        String str2 = this.f352f;
        if (str2 != null) {
            setReferenceTags(str2);
        }
    }

    @Override // android.view.View
    public final void onDraw(Canvas canvas) {
    }

    @Override // android.view.View
    public void onMeasure(int i, int i2) {
        setMeasuredDimension(0, 0);
    }

    /* JADX INFO: renamed from: p */
    public void mo38p(l lVar, SparseArray sparseArray) {
        lVar.v0 = 0;
        Arrays.fill(lVar.u0, (Object) null);
        for (int i = 0; i < this.f348b; i++) {
            lVar.S((f) sparseArray.get(this.f347a[i]));
        }
    }

    /* JADX INFO: renamed from: q */
    public final void m107q() {
        if (this.f350d == null) {
            return;
        }
        ViewGroup.LayoutParams layoutParams = getLayoutParams();
        if (layoutParams instanceof ConstraintLayout.LayoutParams) {
            ((ConstraintLayout.LayoutParams) layoutParams).f433q0 = this.f350d;
        }
    }

    public void setIds(String str) {
        this.f351e = str;
        if (str == null) {
            return;
        }
        int i = 0;
        this.f348b = 0;
        while (true) {
            int iIndexOf = str.indexOf(44, i);
            if (iIndexOf == -1) {
                m99b(str.substring(i));
                return;
            } else {
                m99b(str.substring(i, iIndexOf));
                i = iIndexOf + 1;
            }
        }
    }

    public void setReferenceTags(String str) {
        this.f352f = str;
        if (str == null) {
            return;
        }
        int i = 0;
        this.f348b = 0;
        while (true) {
            int iIndexOf = str.indexOf(44, i);
            if (iIndexOf == -1) {
                m101d(str.substring(i));
                return;
            } else {
                m101d(str.substring(i, iIndexOf));
                i = iIndexOf + 1;
            }
        }
    }

    public void setReferencedIds(int[] iArr) {
        this.f351e = null;
        this.f348b = 0;
        for (int i : iArr) {
            m100c(i);
        }
    }

    @Override // android.view.View
    public final void setTag(int i, Object obj) {
        super.setTag(i, obj);
        if (obj == null && this.f351e == null) {
            m100c(i);
        }
    }

    public ConstraintHelper(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f347a = new int[32];
        this.f353g = null;
        this.f354h = new HashMap();
        this.f349c = context;
        mo24k(attributeSet);
    }
}
