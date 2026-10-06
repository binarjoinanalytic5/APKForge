package androidx.constraintlayout.motion.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.util.Log;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.util.Xml;
import android.view.MotionEvent;
import android.view.View;
import android.view.animation.AccelerateDecelerateInterpolator;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.AnimationUtils;
import android.view.animation.AnticipateInterpolator;
import android.view.animation.BounceInterpolator;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.Interpolator;
import android.view.animation.OvershootInterpolator;
import androidx.compose.animation.core.u;
import androidx.constraintlayout.widget.Barrier;
import androidx.constraintlayout.widget.C0037R;
import androidx.constraintlayout.widget.C0040c;
import androidx.constraintlayout.widget.C0041d;
import androidx.constraintlayout.widget.ConstraintHelper;
import androidx.constraintlayout.widget.ConstraintLayout;
import b1.e;
import h1.a0;
import h1.b0;
import h1.g;
import h1.m;
import h1.n;
import h1.t;
import h1.w;
import h1.x;
import j1.h;
import j1.i;
import j1.j;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import org.xmlpull.v1.XmlPullParserException;

/* JADX INFO: renamed from: androidx.constraintlayout.motion.widget.c */
/* JADX INFO: loaded from: classes.dex */
public final class C0016c {

    /* JADX INFO: renamed from: a */
    public final MotionLayout f176a;

    /* JADX INFO: renamed from: b */
    public final u f177b;

    /* JADX INFO: renamed from: c */
    public x f178c;

    /* JADX INFO: renamed from: d */
    public final ArrayList f179d;

    /* JADX INFO: renamed from: e */
    public final x f180e;

    /* JADX INFO: renamed from: f */
    public final ArrayList f181f;

    /* JADX INFO: renamed from: g */
    public final SparseArray f182g;

    /* JADX INFO: renamed from: h */
    public final HashMap f183h;

    /* JADX INFO: renamed from: i */
    public final SparseIntArray f184i;

    /* JADX INFO: renamed from: j */
    public int f185j;

    /* JADX INFO: renamed from: k */
    public int f186k;

    /* JADX INFO: renamed from: l */
    public MotionEvent f187l;

    /* JADX INFO: renamed from: m */
    public boolean f188m;

    /* JADX INFO: renamed from: n */
    public boolean f189n;

    /* JADX INFO: renamed from: o */
    public t f190o;

    /* JADX INFO: renamed from: p */
    public boolean f191p;

    /* JADX INFO: renamed from: q */
    public final as.c f192q;

    /* JADX INFO: renamed from: r */
    public float f193r;

    /* JADX INFO: renamed from: s */
    public float f194s;

    /* JADX WARN: Code duplicated, block: B:47:0x00d4  */
    public C0016c(Context context, MotionLayout motionLayout, int i) {
        this.f177b = null;
        this.f178c = null;
        ArrayList arrayList = new ArrayList();
        this.f179d = arrayList;
        this.f180e = null;
        this.f181f = new ArrayList();
        this.f182g = new SparseArray();
        this.f183h = new HashMap();
        this.f184i = new SparseIntArray();
        this.f185j = 400;
        this.f186k = 0;
        this.f188m = false;
        this.f189n = false;
        this.f176a = motionLayout;
        this.f192q = new as.c(motionLayout);
        XmlResourceParser xml = context.getResources().getXml(i);
        try {
            int eventType = xml.getEventType();
            x xVar = null;
            while (true) {
                if (eventType != 1) {
                    if (eventType == 0) {
                        xml.getName();
                    } else if (eventType == 2) {
                        switch (xml.getName()) {
                            case "MotionScene":
                                m78l(context, xml);
                                break;
                            case "Transition":
                                xVar = new x(this, context, xml);
                                arrayList.add(xVar);
                                if (this.f178c == null && !xVar.b) {
                                    this.f178c = xVar;
                                    C0017d c0017d = xVar.l;
                                    if (c0017d != null) {
                                        c0017d.m84c(this.f191p);
                                    }
                                }
                                if (xVar.b) {
                                    if (xVar.c == -1) {
                                        this.f180e = xVar;
                                    } else {
                                        this.f181f.add(xVar);
                                    }
                                    arrayList.remove(xVar);
                                    break;
                                } else {
                                    break;
                                }
                                break;
                            case "OnSwipe":
                                if (xVar == null) {
                                    context.getResources().getResourceEntryName(i);
                                    xml.getLineNumber();
                                }
                                if (xVar != null) {
                                    xVar.l = new C0017d(context, this.f176a, xml);
                                    break;
                                } else {
                                    break;
                                }
                                break;
                            case "OnClick":
                                if (xVar != null) {
                                    xVar.m.add(new w(context, xVar, xml));
                                    break;
                                } else {
                                    break;
                                }
                                break;
                            case "StateSet":
                                this.f177b = new u(context, xml);
                                break;
                            case "ConstraintSet":
                                m75i(context, xml);
                                break;
                            case "include":
                            case "Include":
                                m77k(context, xml);
                                break;
                            case "KeyFrameSet":
                                g gVar = new g(context, xml);
                                if (xVar != null) {
                                    xVar.k.add(gVar);
                                    break;
                                } else {
                                    break;
                                }
                                break;
                            case "ViewTransition":
                                a0 a0Var = new a0(context, xml);
                                as.c cVar = this.f192q;
                                ((ArrayList) cVar.c).add(a0Var);
                                cVar.d = null;
                                int i2 = a0Var.b;
                                if (i2 == 4) {
                                    ConstraintLayout.getSharedValues().a(a0Var.u, new b0());
                                    break;
                                } else {
                                    if (i2 == 5) {
                                        ConstraintLayout.getSharedValues().a(a0Var.u, new b0());
                                    }
                                    break;
                                }
                                break;
                        }
                    }
                    eventType = xml.next();
                }
                this.f182g.put(C0037R.id.motion_base, new C0041d());
                this.f183h.put("motion_base", Integer.valueOf(C0037R.id.motion_base));
                return;
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (XmlPullParserException e2) {
            e2.printStackTrace();
        }
    }

    /* JADX INFO: renamed from: a */
    public final boolean m67a(int i, MotionLayout motionLayout) {
        x xVar;
        if (this.f190o != null) {
            return false;
        }
        for (x xVar2 : this.f179d) {
            int i2 = xVar2.n;
            if (i2 != 0 && ((xVar = this.f178c) != xVar2 || (xVar.r & 2) == 0)) {
                if (i == xVar2.d && (i2 == 4 || i2 == 2)) {
                    MotionLayout.TransitionState transitionState = MotionLayout.TransitionState.FINISHED;
                    motionLayout.setState(transitionState);
                    motionLayout.setTransition(xVar2);
                    if (xVar2.n == 4) {
                        motionLayout.m47H();
                        motionLayout.setState(MotionLayout.TransitionState.SETUP);
                        motionLayout.setState(MotionLayout.TransitionState.MOVING);
                    } else {
                        motionLayout.setProgress(1.0f);
                        motionLayout.m59t(true);
                        motionLayout.setState(MotionLayout.TransitionState.SETUP);
                        motionLayout.setState(MotionLayout.TransitionState.MOVING);
                        motionLayout.setState(transitionState);
                        motionLayout.m40A();
                    }
                    return true;
                }
                if (i == xVar2.c && (i2 == 3 || i2 == 1)) {
                    MotionLayout.TransitionState transitionState2 = MotionLayout.TransitionState.FINISHED;
                    motionLayout.setState(transitionState2);
                    motionLayout.setTransition(xVar2);
                    if (xVar2.n == 3) {
                        motionLayout.m57r(0.0f);
                        motionLayout.setState(MotionLayout.TransitionState.SETUP);
                        motionLayout.setState(MotionLayout.TransitionState.MOVING);
                    } else {
                        motionLayout.setProgress(0.0f);
                        motionLayout.m59t(true);
                        motionLayout.setState(MotionLayout.TransitionState.SETUP);
                        motionLayout.setState(MotionLayout.TransitionState.MOVING);
                        motionLayout.setState(transitionState2);
                        motionLayout.m40A();
                    }
                    return true;
                }
            }
        }
        return false;
    }

    /* JADX INFO: renamed from: b */
    public final C0041d m68b(int i) {
        int iT;
        SparseArray sparseArray = this.f182g;
        u uVar = this.f177b;
        if (uVar != null && (iT = uVar.t(i)) != -1) {
            i = iT;
        }
        if (sparseArray.get(i) != null) {
            return (C0041d) sparseArray.get(i);
        }
        Log.e(MotionScene.TAG, "Warning could not find ConstraintSet id/" + so.c.w(this.f176a.getContext(), i) + " In MotionScene");
        return (C0041d) sparseArray.get(sparseArray.keyAt(0));
    }

    /* JADX INFO: renamed from: c */
    public final int m69c() {
        x xVar = this.f178c;
        return xVar != null ? xVar.h : this.f185j;
    }

    /* JADX INFO: renamed from: d */
    public final int m70d(Context context, String str) {
        int identifier;
        if (str.contains("/")) {
            identifier = context.getResources().getIdentifier(str.substring(str.indexOf(47) + 1), "id", context.getPackageName());
        } else {
            identifier = -1;
        }
        if (identifier != -1) {
            return identifier;
        }
        if (str.length() > 1) {
            return Integer.parseInt(str.substring(1));
        }
        Log.e(MotionScene.TAG, "error in parsing id");
        return identifier;
    }

    /* JADX INFO: renamed from: e */
    public final Interpolator m71e() {
        x xVar = this.f178c;
        int i = xVar.e;
        if (i == -2) {
            return AnimationUtils.loadInterpolator(this.f176a.getContext(), this.f178c.g);
        }
        if (i == -1) {
            return new m(e.d(xVar.f), 1);
        }
        if (i == 0) {
            return new AccelerateDecelerateInterpolator();
        }
        if (i == 1) {
            return new AccelerateInterpolator();
        }
        if (i == 2) {
            return new DecelerateInterpolator();
        }
        if (i == 4) {
            return new BounceInterpolator();
        }
        if (i == 5) {
            return new OvershootInterpolator();
        }
        if (i != 6) {
            return null;
        }
        return new AnticipateInterpolator();
    }

    /* JADX INFO: renamed from: f */
    public final void m72f(n nVar) {
        x xVar = this.f178c;
        if (xVar != null) {
            Iterator it = xVar.k.iterator();
            while (it.hasNext()) {
                ((g) it.next()).a(nVar);
            }
        } else {
            x xVar2 = this.f180e;
            if (xVar2 != null) {
                Iterator it2 = xVar2.k.iterator();
                while (it2.hasNext()) {
                    ((g) it2.next()).a(nVar);
                }
            }
        }
    }

    /* JADX INFO: renamed from: g */
    public final float m73g() {
        C0017d c0017d;
        x xVar = this.f178c;
        if (xVar == null || (c0017d = xVar.l) == null) {
            return 0.0f;
        }
        return c0017d.f220t;
    }

    /* JADX INFO: renamed from: h */
    public final int m74h() {
        x xVar = this.f178c;
        if (xVar == null) {
            return -1;
        }
        return xVar.d;
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Code duplicated, block: B:30:0x0089  */
    /* JADX WARN: Code duplicated, block: B:6:0x002d  */
    /* JADX INFO: renamed from: i */
    public final int m75i(Context context, XmlResourceParser xmlResourceParser) {
        C0041d c0041d = new C0041d();
        c0041d.f555e = false;
        int attributeCount = xmlResourceParser.getAttributeCount();
        int iM70d = -1;
        int iM70d2 = -1;
        for (int i = 0; i < attributeCount; i++) {
            String attributeName = xmlResourceParser.getAttributeName(i);
            String attributeValue = xmlResourceParser.getAttributeValue(i);
            attributeName.getClass();
            switch (attributeName) {
                case "deriveConstraintsFrom":
                    iM70d2 = m70d(context, attributeValue);
                    break;
                case "constraintRotate":
                    try {
                        c0041d.f553c = Integer.parseInt(attributeValue);
                        break;
                    } catch (NumberFormatException unused) {
                        attributeValue.getClass();
                        switch (attributeValue) {
                            case "x_left":
                                c0041d.f553c = 4;
                                break;
                            case "left":
                                c0041d.f553c = 2;
                                break;
                            case "none":
                                c0041d.f553c = 0;
                                break;
                            case "right":
                                c0041d.f553c = 1;
                                break;
                            case "x_right":
                                c0041d.f553c = 3;
                                break;
                        }
                    }
                    break;
                case "id":
                    iM70d = m70d(context, attributeValue);
                    int iIndexOf = attributeValue.indexOf(47);
                    if (iIndexOf >= 0) {
                        attributeValue = attributeValue.substring(iIndexOf + 1);
                    }
                    this.f183h.put(attributeValue, Integer.valueOf(iM70d));
                    c0041d.f551a = so.c.w(context, iM70d);
                    break;
            }
        }
        if (iM70d != -1) {
            int i2 = this.f176a.f120M;
            c0041d.m146n(context, xmlResourceParser);
            if (iM70d2 != -1) {
                this.f184i.put(iM70d, iM70d2);
            }
            this.f182g.put(iM70d, c0041d);
        }
        return iM70d;
    }

    /* JADX INFO: renamed from: j */
    public final int m76j(Context context, int i) {
        XmlResourceParser xml = context.getResources().getXml(i);
        try {
            for (int eventType = xml.getEventType(); eventType != 1; eventType = xml.next()) {
                String name = xml.getName();
                if (2 == eventType && "ConstraintSet".equals(name)) {
                    return m75i(context, xml);
                }
            }
            return -1;
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        } catch (XmlPullParserException e2) {
            e2.printStackTrace();
            return -1;
        }
    }

    /* JADX INFO: renamed from: k */
    public final void m77k(Context context, XmlResourceParser xmlResourceParser) {
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(Xml.asAttributeSet(xmlResourceParser), j1.m.D);
        int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
        for (int i = 0; i < indexCount; i++) {
            int index = typedArrayObtainStyledAttributes.getIndex(i);
            if (index == 0) {
                m76j(context, typedArrayObtainStyledAttributes.getResourceId(index, -1));
            }
        }
        typedArrayObtainStyledAttributes.recycle();
    }

    /* JADX INFO: renamed from: l */
    public final void m78l(Context context, XmlResourceParser xmlResourceParser) {
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(Xml.asAttributeSet(xmlResourceParser), j1.m.s);
        int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
        for (int i = 0; i < indexCount; i++) {
            int index = typedArrayObtainStyledAttributes.getIndex(i);
            if (index == 0) {
                int i2 = typedArrayObtainStyledAttributes.getInt(index, this.f185j);
                this.f185j = i2;
                if (i2 < 8) {
                    this.f185j = 8;
                }
            } else if (index == 1) {
                this.f186k = typedArrayObtainStyledAttributes.getInteger(index, 0);
            }
        }
        typedArrayObtainStyledAttributes.recycle();
    }

    /* JADX INFO: renamed from: m */
    public final void m79m(int i, MotionLayout motionLayout) {
        SparseArray sparseArray = this.f182g;
        C0041d c0041d = (C0041d) sparseArray.get(i);
        c0041d.f552b = c0041d.f551a;
        int i2 = this.f184i.get(i);
        HashMap map = c0041d.f556f;
        if (i2 > 0) {
            m79m(i2, motionLayout);
            C0041d c0041d2 = (C0041d) sparseArray.get(i2);
            if (c0041d2 == null) {
                Log.e(MotionScene.TAG, "ERROR! invalid deriveConstraintsFrom: @id/" + so.c.w(this.f176a.getContext(), i2));
                return;
            }
            c0041d.f552b += "/" + c0041d2.f552b;
            HashMap map2 = c0041d2.f556f;
            for (Integer num : map2.keySet()) {
                num.getClass();
                C0040c c0040c = (C0040c) map2.get(num);
                if (!map.containsKey(num)) {
                    map.put(num, new C0040c());
                }
                C0040c c0040c2 = (C0040c) map.get(num);
                if (c0040c2 != null) {
                    j1.g gVar = c0040c2.f544e;
                    if (!gVar.b) {
                        gVar.a(c0040c.f544e);
                    }
                    i iVar = c0040c2.f542c;
                    if (!iVar.a) {
                        iVar.a(c0040c.f542c);
                    }
                    j jVar = c0040c2.f545f;
                    if (!jVar.a) {
                        jVar.a(c0040c.f545f);
                    }
                    h hVar = c0040c2.f543d;
                    if (!hVar.a) {
                        hVar.a(c0040c.f543d);
                    }
                    for (String str : c0040c.f546g.keySet()) {
                        if (!c0040c2.f546g.containsKey(str)) {
                            c0040c2.f546g.put(str, (j1.b) c0040c.f546g.get(str));
                        }
                    }
                }
            }
        } else {
            c0041d.f552b = a1.a.t(new StringBuilder(), c0041d.f552b, "  layout");
            int childCount = motionLayout.getChildCount();
            for (int i3 = 0; i3 < childCount; i3++) {
                View childAt = motionLayout.getChildAt(i3);
                ConstraintLayout.LayoutParams layoutParams = (ConstraintLayout.LayoutParams) childAt.getLayoutParams();
                int id = childAt.getId();
                if (c0041d.f555e && id == -1) {
                    throw new RuntimeException("All children of ConstraintLayout must have ids to use ConstraintSet");
                }
                if (!map.containsKey(Integer.valueOf(id))) {
                    map.put(Integer.valueOf(id), new C0040c());
                }
                C0040c c0040c3 = (C0040c) map.get(Integer.valueOf(id));
                if (c0040c3 != null) {
                    j1.g gVar2 = c0040c3.f544e;
                    if (!gVar2.b) {
                        c0040c3.m126f(id, layoutParams);
                        if (childAt instanceof ConstraintHelper) {
                            gVar2.j0 = ((ConstraintHelper) childAt).getReferencedIds();
                            if (childAt instanceof Barrier) {
                                Barrier barrier = (Barrier) childAt;
                                gVar2.o0 = barrier.getAllowsGoneWidget();
                                gVar2.g0 = barrier.getType();
                                gVar2.h0 = barrier.getMargin();
                            }
                        }
                        gVar2.b = true;
                    }
                    i iVar2 = c0040c3.f542c;
                    if (!iVar2.a) {
                        iVar2.b = childAt.getVisibility();
                        iVar2.d = childAt.getAlpha();
                        iVar2.a = true;
                    }
                    j jVar2 = c0040c3.f545f;
                    if (!jVar2.a) {
                        jVar2.a = true;
                        jVar2.b = childAt.getRotation();
                        jVar2.c = childAt.getRotationX();
                        jVar2.d = childAt.getRotationY();
                        jVar2.e = childAt.getScaleX();
                        jVar2.f = childAt.getScaleY();
                        float pivotX = childAt.getPivotX();
                        float pivotY = childAt.getPivotY();
                        if (pivotX != 0.0d || pivotY != 0.0d) {
                            jVar2.g = pivotX;
                            jVar2.h = pivotY;
                        }
                        jVar2.j = childAt.getTranslationX();
                        jVar2.k = childAt.getTranslationY();
                        jVar2.l = childAt.getTranslationZ();
                        if (jVar2.m) {
                            jVar2.n = childAt.getElevation();
                        }
                    }
                }
            }
        }
        for (C0040c c0040c4 : map.values()) {
            if (c0040c4.f547h != null) {
                if (c0040c4.f541b != null) {
                    Iterator it = map.keySet().iterator();
                    while (it.hasNext()) {
                        C0040c c0040cM144l = c0041d.m144l(((Integer) it.next()).intValue());
                        String str2 = c0040cM144l.f544e.l0;
                        if (str2 != null && c0040c4.f541b.matches(str2)) {
                            c0040c4.f547h.e(c0040cM144l);
                            c0040cM144l.f546g.putAll((HashMap) c0040c4.f546g.clone());
                        }
                    }
                } else {
                    c0040c4.f547h.e(c0041d.m144l(c0040c4.f540a));
                }
            }
        }
    }

    /* JADX WARN: Code duplicated, block: B:23:0x0033  */
    /* JADX WARN: Code duplicated, block: B:32:0x004d  */
    /* JADX WARN: Code duplicated, block: B:37:0x0061  */
    /* JADX WARN: Code duplicated, block: B:42:0x0078  */
    /* JADX WARN: Code duplicated, block: B:45:0x0053 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:53:0x006b A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:55:0x005b A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:57:? A[RETURN, SYNTHETIC] */
    /* JADX INFO: renamed from: n */
    public final void m80n(int i, int i2) {
        int iT;
        int iT2;
        x xVar;
        ArrayList arrayList;
        Iterator it;
        x xVar2;
        x xVar3;
        x xVar4;
        int i3;
        C0017d c0017d;
        u uVar = this.f177b;
        if (uVar != null) {
            iT = uVar.t(i);
            if (iT == -1) {
                iT = i;
            }
            iT2 = this.f177b.t(i2);
            if (iT2 == -1) {
            }
            xVar = this.f178c;
            if (xVar == null && xVar.c == i2 && xVar.d == i) {
                return;
            }
            arrayList = this.f179d;
            it = arrayList.iterator();
            while (true) {
                if (it.hasNext()) {
                    xVar2 = this.f180e;
                    for (x xVar5 : this.f181f) {
                        if (xVar5.c == i2) {
                            xVar2 = xVar5;
                        }
                    }
                    xVar3 = new x(this, xVar2);
                    xVar3.d = iT;
                    xVar3.c = iT2;
                    if (iT != -1) {
                        arrayList.add(xVar3);
                    }
                    this.f178c = xVar3;
                    return;
                }
                xVar4 = (x) it.next();
                i3 = xVar4.c;
                if ((i3 != iT2 && xVar4.d == iT) || (i3 == i2 && xVar4.d == i)) {
                    break;
                }
            }
            this.f178c = xVar4;
            c0017d = xVar4.l;
            if (c0017d != null) {
                c0017d.m84c(this.f191p);
            }
        }
        iT = i;
        iT2 = i2;
        xVar = this.f178c;
        if (xVar == null) {
        }
        arrayList = this.f179d;
        it = arrayList.iterator();
        while (true) {
            if (it.hasNext()) {
                xVar2 = this.f180e;
                while (r4.hasNext()) {
                    if (xVar5.c == i2) {
                        xVar2 = xVar5;
                    }
                }
                xVar3 = new x(this, xVar2);
                xVar3.d = iT;
                xVar3.c = iT2;
                if (iT != -1) {
                    arrayList.add(xVar3);
                }
                this.f178c = xVar3;
                return;
            }
            xVar4 = (x) it.next();
            i3 = xVar4.c;
            if (i3 != iT2) {
            }
        }
        this.f178c = xVar4;
        c0017d = xVar4.l;
        if (c0017d != null) {
            c0017d.m84c(this.f191p);
        }
    }

    /* JADX INFO: renamed from: o */
    public final boolean m81o() {
        Iterator it = this.f179d.iterator();
        while (it.hasNext()) {
            if (((x) it.next()).l != null) {
                return true;
            }
        }
        x xVar = this.f178c;
        return (xVar == null || xVar.l == null) ? false : true;
    }
}
