package androidx.constraintlayout.helper.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.view.View;
import androidx.constraintlayout.motion.widget.C0016c;
import androidx.constraintlayout.motion.widget.MotionHelper;
import androidx.constraintlayout.motion.widget.MotionLayout;
import androidx.constraintlayout.widget.ConstraintLayout;
import h1.a0;
import h1.e;
import h1.i;
import h1.n;
import h1.v;
import j1.m;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import so.c;

/* JADX INFO: loaded from: classes.dex */
public class MotionEffect extends MotionHelper {

    /* JADX INFO: renamed from: m */
    public float f74m;

    /* JADX INFO: renamed from: n */
    public int f75n;

    /* JADX INFO: renamed from: o */
    public int f76o;

    /* JADX INFO: renamed from: p */
    public int f77p;

    /* JADX INFO: renamed from: q */
    public int f78q;

    /* JADX INFO: renamed from: r */
    public boolean f79r;

    /* JADX INFO: renamed from: s */
    public int f80s;

    /* JADX INFO: renamed from: t */
    public int f81t;

    public MotionEffect(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f74m = 0.1f;
        this.f75n = 49;
        this.f76o = 50;
        this.f77p = 0;
        this.f78q = 0;
        this.f79r = true;
        this.f80s = -1;
        this.f81t = -1;
        m37s(context, attributeSet);
    }

    /* JADX WARN: Code duplicated, block: B:100:0x01d4  */
    /* JADX WARN: Code duplicated, block: B:101:0x01d7  */
    /* JADX WARN: Code duplicated, block: B:103:0x01df  */
    /* JADX WARN: Code duplicated, block: B:106:0x01ef  */
    /* JADX WARN: Code duplicated, block: B:110:0x020e  */
    /* JADX WARN: Code duplicated, block: B:111:0x0214 A[LOOP:3: B:104:0x01e9->B:111:0x0214, LOOP_END] */
    /* JADX WARN: Code duplicated, block: B:123:0x0219 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:125:0x01d0 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:126:0x01fd A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:48:0x0147  */
    /* JADX WARN: Code duplicated, block: B:92:0x01ac  */
    /* JADX WARN: Code duplicated, block: B:94:0x01bc  */
    /* JADX WARN: Code duplicated, block: B:97:0x01c6  */
    /* JADX WARN: Code restructure failed: missing block: B:57:0x016a, code lost:
    
        if (r14 == 0.0f) goto L60;
     */
    /* JADX WARN: Code restructure failed: missing block: B:68:0x0180, code lost:
    
        if (r14 == 0.0f) goto L60;
     */
    @Override // androidx.constraintlayout.motion.widget.MotionHelper
    /* JADX INFO: renamed from: r */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public final void mo36r(MotionLayout motionLayout, HashMap map) {
        e eVar;
        e eVar2;
        e eVar3;
        e eVar4;
        int i;
        e eVar5;
        C0016c c0016c;
        Iterator it;
        a0 a0Var;
        View[] viewArr;
        ArrayList arrayList;
        e eVar6;
        int i2;
        MotionEffect motionEffect = this;
        HashMap map2 = map;
        View[] viewArrM106j = motionEffect.m106j((ConstraintLayout) getParent());
        if (viewArrM106j == null) {
            c.u();
            return;
        }
        e eVar7 = new e();
        e eVar8 = new e();
        eVar7.f("alpha", Float.valueOf(motionEffect.f74m));
        eVar8.f("alpha", Float.valueOf(motionEffect.f74m));
        int i3 = motionEffect.f75n;
        ((h1.c) eVar7).a = i3;
        ((h1.c) eVar8).a = motionEffect.f76o;
        i iVar = new i();
        ((h1.c) iVar).a = i3;
        int i4 = 0;
        iVar.m = 0;
        iVar.f("percentX", 0);
        iVar.f("percentY", 0);
        i iVar2 = new i();
        ((h1.c) iVar2).a = motionEffect.f76o;
        iVar2.m = 0;
        iVar2.f("percentX", 1);
        iVar2.f("percentY", 1);
        e eVar9 = null;
        if (motionEffect.f77p > 0) {
            eVar = new e();
            eVar2 = new e();
            eVar.f("translationX", Integer.valueOf(motionEffect.f77p));
            ((h1.c) eVar).a = motionEffect.f76o;
            eVar2.f("translationX", 0);
            ((h1.c) eVar2).a = motionEffect.f76o - 1;
        } else {
            eVar = null;
            eVar2 = null;
        }
        if (motionEffect.f78q > 0) {
            eVar9 = new e();
            eVar3 = new e();
            eVar9.f("translationY", Integer.valueOf(motionEffect.f78q));
            ((h1.c) eVar9).a = motionEffect.f76o;
            eVar3.f("translationY", 0);
            ((h1.c) eVar3).a = motionEffect.f76o - 1;
        } else {
            eVar3 = null;
        }
        int i5 = motionEffect.f81t;
        if (i5 == -1) {
            int[] iArr = new int[4];
            int i6 = 0;
            while (i6 < viewArrM106j.length) {
                n nVar = (n) map2.get(viewArrM106j[i6]);
                if (nVar == null) {
                    eVar6 = eVar3;
                } else {
                    v vVar = nVar.g;
                    float f = vVar.e;
                    v vVar2 = nVar.f;
                    eVar6 = eVar3;
                    float f2 = f - vVar2.e;
                    float f3 = vVar.f - vVar2.f;
                    if (f3 < 0.0f) {
                        i2 = 1;
                        iArr[1] = iArr[1] + 1;
                    } else {
                        i2 = 1;
                    }
                    if (f3 > 0.0f) {
                        iArr[0] = iArr[0] + i2;
                    }
                    if (f2 > 0.0f) {
                        iArr[3] = iArr[3] + i2;
                    }
                    if (f2 < 0.0f) {
                        iArr[2] = iArr[2] + i2;
                    }
                }
                i6++;
                eVar3 = eVar6;
                i4 = 0;
            }
            eVar4 = eVar3;
            int i7 = iArr[i4];
            i5 = i4;
            for (int i8 = 1; i8 < 4; i8++) {
                int i9 = iArr[i8];
                if (i7 < i9) {
                    i7 = i9;
                    i5 = i8;
                }
            }
        } else {
            eVar4 = eVar3;
        }
        int i10 = 0;
        while (i10 < viewArrM106j.length) {
            n nVar2 = (n) map2.get(viewArrM106j[i10]);
            if (nVar2 == null) {
                viewArr = viewArrM106j;
                eVar5 = eVar4;
            } else {
                v vVar3 = nVar2.g;
                float f4 = vVar3.e;
                v vVar4 = nVar2.f;
                float f5 = f4 - vVar4.e;
                float f6 = vVar3.f - vVar4.f;
                if (i5 == 0) {
                    if (f6 > 0.0f) {
                        if (motionEffect.f79r) {
                        }
                        viewArr = viewArrM106j;
                        eVar5 = eVar4;
                    }
                    i = motionEffect.f80s;
                    if (i == -1) {
                        nVar2.a(eVar7);
                        nVar2.a(eVar8);
                        nVar2.a(iVar);
                        nVar2.a(iVar2);
                        if (motionEffect.f77p > 0) {
                            nVar2.a(eVar);
                            nVar2.a(eVar2);
                        }
                        if (motionEffect.f78q > 0) {
                            nVar2.a(eVar9);
                            eVar5 = eVar4;
                            nVar2.a(eVar5);
                        } else {
                            eVar5 = eVar4;
                        }
                    } else {
                        eVar5 = eVar4;
                        c0016c = motionLayout.f149s;
                        if (c0016c != null) {
                            it = ((ArrayList) c0016c.f192q.c).iterator();
                            while (true) {
                                if (it.hasNext()) {
                                    a0Var = (a0) it.next();
                                    viewArr = viewArrM106j;
                                    if (a0Var.a == i) {
                                        arrayList = (ArrayList) a0Var.f.a.get(-1);
                                        if (arrayList != null) {
                                            nVar2.w.addAll(arrayList);
                                        }
                                    } else {
                                        viewArrM106j = viewArr;
                                    }
                                }
                            }
                        }
                    }
                    viewArr = viewArrM106j;
                } else if (i5 == 1) {
                    if (f6 < 0.0f) {
                        if (motionEffect.f79r) {
                        }
                        viewArr = viewArrM106j;
                        eVar5 = eVar4;
                    }
                    i = motionEffect.f80s;
                    if (i == -1) {
                        nVar2.a(eVar7);
                        nVar2.a(eVar8);
                        nVar2.a(iVar);
                        nVar2.a(iVar2);
                        if (motionEffect.f77p > 0) {
                            nVar2.a(eVar);
                            nVar2.a(eVar2);
                        }
                        if (motionEffect.f78q > 0) {
                            nVar2.a(eVar9);
                            eVar5 = eVar4;
                            nVar2.a(eVar5);
                        } else {
                            eVar5 = eVar4;
                        }
                    } else {
                        eVar5 = eVar4;
                        c0016c = motionLayout.f149s;
                        if (c0016c != null) {
                            it = ((ArrayList) c0016c.f192q.c).iterator();
                            while (true) {
                                if (it.hasNext()) {
                                    a0Var = (a0) it.next();
                                    viewArr = viewArrM106j;
                                    if (a0Var.a == i) {
                                        arrayList = (ArrayList) a0Var.f.a.get(-1);
                                        if (arrayList != null) {
                                            nVar2.w.addAll(arrayList);
                                        }
                                    } else {
                                        viewArrM106j = viewArr;
                                    }
                                }
                            }
                        }
                    }
                    viewArr = viewArrM106j;
                } else if (i5 == 2) {
                    if (f5 >= 0.0f || (motionEffect.f79r && f6 != 0.0f)) {
                        i = motionEffect.f80s;
                        if (i == -1) {
                            nVar2.a(eVar7);
                            nVar2.a(eVar8);
                            nVar2.a(iVar);
                            nVar2.a(iVar2);
                            if (motionEffect.f77p > 0) {
                                nVar2.a(eVar);
                                nVar2.a(eVar2);
                            }
                            if (motionEffect.f78q > 0) {
                                nVar2.a(eVar9);
                                eVar5 = eVar4;
                                nVar2.a(eVar5);
                            } else {
                                eVar5 = eVar4;
                            }
                        } else {
                            eVar5 = eVar4;
                            c0016c = motionLayout.f149s;
                            if (c0016c != null) {
                                it = ((ArrayList) c0016c.f192q.c).iterator();
                                while (true) {
                                    if (it.hasNext()) {
                                        a0Var = (a0) it.next();
                                        viewArr = viewArrM106j;
                                        if (a0Var.a == i) {
                                            arrayList = (ArrayList) a0Var.f.a.get(-1);
                                            if (arrayList != null) {
                                                nVar2.w.addAll(arrayList);
                                            }
                                        } else {
                                            viewArrM106j = viewArr;
                                        }
                                    }
                                }
                            }
                        }
                        viewArr = viewArrM106j;
                    } else {
                        viewArr = viewArrM106j;
                        eVar5 = eVar4;
                    }
                } else if (i5 != 3 || f5 <= 0.0f || (motionEffect.f79r && f6 != 0.0f)) {
                    i = motionEffect.f80s;
                    if (i == -1) {
                        nVar2.a(eVar7);
                        nVar2.a(eVar8);
                        nVar2.a(iVar);
                        nVar2.a(iVar2);
                        if (motionEffect.f77p > 0) {
                            nVar2.a(eVar);
                            nVar2.a(eVar2);
                        }
                        if (motionEffect.f78q > 0) {
                            nVar2.a(eVar9);
                            eVar5 = eVar4;
                            nVar2.a(eVar5);
                        } else {
                            eVar5 = eVar4;
                        }
                    } else {
                        eVar5 = eVar4;
                        c0016c = motionLayout.f149s;
                        if (c0016c != null) {
                            it = ((ArrayList) c0016c.f192q.c).iterator();
                            while (true) {
                                if (it.hasNext()) {
                                    a0Var = (a0) it.next();
                                    viewArr = viewArrM106j;
                                    if (a0Var.a == i) {
                                        arrayList = (ArrayList) a0Var.f.a.get(-1);
                                        if (arrayList != null) {
                                            nVar2.w.addAll(arrayList);
                                        }
                                    } else {
                                        viewArrM106j = viewArr;
                                    }
                                }
                            }
                        }
                    }
                    viewArr = viewArrM106j;
                } else {
                    viewArr = viewArrM106j;
                    eVar5 = eVar4;
                }
            }
            i10++;
            motionEffect = this;
            map2 = map;
            eVar4 = eVar5;
            viewArrM106j = viewArr;
        }
    }

    /* JADX INFO: renamed from: s */
    public final void m37s(Context context, AttributeSet attributeSet) {
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, m.o);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 3) {
                    int i2 = typedArrayObtainStyledAttributes.getInt(index, this.f75n);
                    this.f75n = i2;
                    this.f75n = Math.max(Math.min(i2, 99), 0);
                } else if (index == 1) {
                    int i3 = typedArrayObtainStyledAttributes.getInt(index, this.f76o);
                    this.f76o = i3;
                    this.f76o = Math.max(Math.min(i3, 99), 0);
                } else if (index == 5) {
                    this.f77p = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f77p);
                } else if (index == 6) {
                    this.f78q = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, this.f78q);
                } else if (index == 0) {
                    this.f74m = typedArrayObtainStyledAttributes.getFloat(index, this.f74m);
                } else if (index == 2) {
                    this.f81t = typedArrayObtainStyledAttributes.getInt(index, this.f81t);
                } else if (index == 4) {
                    this.f79r = typedArrayObtainStyledAttributes.getBoolean(index, this.f79r);
                } else if (index == 7) {
                    this.f80s = typedArrayObtainStyledAttributes.getResourceId(index, this.f80s);
                }
            }
            int i4 = this.f75n;
            int i5 = this.f76o;
            if (i4 == i5) {
                if (i4 > 0) {
                    this.f75n = i4 - 1;
                } else {
                    this.f76o = i5 + 1;
                }
            }
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    public MotionEffect(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f74m = 0.1f;
        this.f75n = 49;
        this.f76o = 50;
        this.f77p = 0;
        this.f78q = 0;
        this.f79r = true;
        this.f80s = -1;
        this.f81t = -1;
        m37s(context, attributeSet);
    }
}
