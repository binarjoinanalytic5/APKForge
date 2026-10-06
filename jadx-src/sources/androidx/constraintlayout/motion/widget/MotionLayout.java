package androidx.constraintlayout.motion.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.DashPathEffect;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.RectF;
import android.os.Bundle;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.view.Display;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.AccelerateDecelerateInterpolator;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.AnimationUtils;
import android.view.animation.AnticipateInterpolator;
import android.view.animation.BounceInterpolator;
import android.view.animation.Interpolator;
import android.view.animation.OvershootInterpolator;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.helper.widget.MotionEffect;
import androidx.constraintlayout.solver.widgets.Barrier;
import androidx.constraintlayout.solver.widgets.ConstraintAnchor;
import androidx.constraintlayout.solver.widgets.ConstraintWidget;
import androidx.constraintlayout.solver.widgets.ConstraintWidgetContainer;
import androidx.constraintlayout.solver.widgets.Flow;
import androidx.constraintlayout.solver.widgets.Guideline;
import androidx.constraintlayout.solver.widgets.Helper;
import androidx.constraintlayout.solver.widgets.HelperWidget;
import androidx.constraintlayout.solver.widgets.VirtualLayout;
import androidx.constraintlayout.widget.C0037R;
import androidx.constraintlayout.widget.C0040c;
import androidx.constraintlayout.widget.C0041d;
import androidx.constraintlayout.widget.ConstraintHelper;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.constraintlayout.widget.ConstraintSet;
import androidx.constraintlayout.widget.Constraints;
import androidx.core.view.x;
import androidx.core.widget.NestedScrollView;
import b1.e;
import b1.j;
import com.google.firebase.messaging.C0082o;
import d1.f;
import g1.g;
import h1.a0;
import h1.l;
import h1.m;
import h1.n;
import h1.o;
import h1.q;
import h1.r;
import h1.s;
import h1.t;
import h1.u;
import h1.v;
import h1.w;
import h1.y;
import h1.z;
import j1.p;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.concurrent.CopyOnWriteArrayList;

/* JADX INFO: loaded from: classes.dex */
public class MotionLayout extends ConstraintLayout implements x {

    /* JADX INFO: renamed from: H0 */
    public static boolean f100H0;

    /* JADX INFO: renamed from: A */
    public int f101A;

    /* JADX INFO: renamed from: A0 */
    public TransitionState f102A0;

    /* JADX INFO: renamed from: B */
    public boolean f103B;

    /* JADX INFO: renamed from: B0 */
    public final s f104B0;

    /* JADX INFO: renamed from: C */
    public final HashMap f105C;

    /* JADX INFO: renamed from: C0 */
    public boolean f106C0;

    /* JADX INFO: renamed from: D */
    public long f107D;

    /* JADX INFO: renamed from: D0 */
    public final RectF f108D0;

    /* JADX INFO: renamed from: E */
    public float f109E;

    /* JADX INFO: renamed from: E0 */
    public View f110E0;

    /* JADX INFO: renamed from: F */
    public float f111F;

    /* JADX INFO: renamed from: F0 */
    public Matrix f112F0;

    /* JADX INFO: renamed from: G */
    public float f113G;

    /* JADX INFO: renamed from: G0 */
    public final ArrayList f114G0;

    /* JADX INFO: renamed from: H */
    public long f115H;

    /* JADX INFO: renamed from: I */
    public float f116I;

    /* JADX INFO: renamed from: J */
    public boolean f117J;

    /* JADX INFO: renamed from: K */
    public boolean f118K;

    /* JADX INFO: renamed from: L */
    public u f119L;

    /* JADX INFO: renamed from: M */
    public int f120M;

    /* JADX INFO: renamed from: N */
    public r f121N;

    /* JADX INFO: renamed from: O */
    public boolean f122O;

    /* JADX INFO: renamed from: P */
    public final g1.b f123P;

    /* JADX INFO: renamed from: Q */
    public final q f124Q;

    /* JADX INFO: renamed from: R */
    public h1.a f125R;

    /* JADX INFO: renamed from: S */
    public int f126S;

    /* JADX INFO: renamed from: T */
    public int f127T;

    /* JADX INFO: renamed from: U */
    public boolean f128U;

    /* JADX INFO: renamed from: V */
    public float f129V;

    /* JADX INFO: renamed from: W */
    public float f130W;

    /* JADX INFO: renamed from: a0 */
    public long f131a0;

    /* JADX INFO: renamed from: b0 */
    public float f132b0;

    /* JADX INFO: renamed from: c0 */
    public boolean f133c0;

    /* JADX INFO: renamed from: d0 */
    public ArrayList f134d0;

    /* JADX INFO: renamed from: e0 */
    public ArrayList f135e0;

    /* JADX INFO: renamed from: f0 */
    public ArrayList f136f0;

    /* JADX INFO: renamed from: g0 */
    public CopyOnWriteArrayList f137g0;

    /* JADX INFO: renamed from: h0 */
    public int f138h0;

    /* JADX INFO: renamed from: i0 */
    public long f139i0;

    /* JADX INFO: renamed from: j0 */
    public float f140j0;

    /* JADX INFO: renamed from: k0 */
    public int f141k0;

    /* JADX INFO: renamed from: l0 */
    public float f142l0;

    /* JADX INFO: renamed from: m0 */
    public boolean f143m0;

    /* JADX INFO: renamed from: n0 */
    public int f144n0;

    /* JADX INFO: renamed from: o0 */
    public int f145o0;

    /* JADX INFO: renamed from: p0 */
    public int f146p0;

    /* JADX INFO: renamed from: q0 */
    public int f147q0;

    /* JADX INFO: renamed from: r0 */
    public int f148r0;

    /* JADX INFO: renamed from: s */
    public C0016c f149s;

    /* JADX INFO: renamed from: s0 */
    public int f150s0;

    /* JADX INFO: renamed from: t */
    public o f151t;

    /* JADX INFO: renamed from: t0 */
    public float f152t0;

    /* JADX INFO: renamed from: u */
    public Interpolator f153u;

    /* JADX INFO: renamed from: u0 */
    public final e f154u0;

    /* JADX INFO: renamed from: v */
    public float f155v;

    /* JADX INFO: renamed from: v0 */
    public boolean f156v0;

    /* JADX INFO: renamed from: w */
    public int f157w;

    /* JADX INFO: renamed from: w0 */
    public C0015b f158w0;

    /* JADX INFO: renamed from: x */
    public int f159x;

    /* JADX INFO: renamed from: x0 */
    public com.vungle.ads.internal.util.d f160x0;

    /* JADX INFO: renamed from: y */
    public int f161y;

    /* JADX INFO: renamed from: y0 */
    public final Rect f162y0;

    /* JADX INFO: renamed from: z */
    public int f163z;

    /* JADX INFO: renamed from: z0 */
    public boolean f164z0;

    protected interface MotionTracker {
        void addMovement(MotionEvent motionEvent);

        void clear();

        void computeCurrentVelocity(int i);

        void computeCurrentVelocity(int i, float f);

        float getXVelocity();

        float getXVelocity(int i);

        float getYVelocity();

        float getYVelocity(int i);

        void recycle();
    }

    public interface TransitionListener {
        void onTransitionChange(MotionLayout motionLayout, int i, int i2, float f);

        void onTransitionCompleted(MotionLayout motionLayout, int i);

        void onTransitionStarted(MotionLayout motionLayout, int i, int i2);

        void onTransitionTrigger(MotionLayout motionLayout, int i, boolean z, float f);
    }

    /* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
    /* JADX WARN: Unknown enum class pattern. Please report as an issue! */
    public static final class TransitionState {
        public static final TransitionState FINISHED;
        public static final TransitionState MOVING;
        public static final TransitionState SETUP;
        public static final TransitionState UNDEFINED;

        /* JADX INFO: renamed from: a */
        public static final /* synthetic */ TransitionState[] f167a;

        static {
            TransitionState transitionState = new TransitionState("UNDEFINED", 0);
            UNDEFINED = transitionState;
            TransitionState transitionState2 = new TransitionState("SETUP", 1);
            SETUP = transitionState2;
            TransitionState transitionState3 = new TransitionState("MOVING", 2);
            MOVING = transitionState3;
            TransitionState transitionState4 = new TransitionState("FINISHED", 3);
            FINISHED = transitionState4;
            f167a = new TransitionState[]{transitionState, transitionState2, transitionState3, transitionState4};
        }

        public static TransitionState valueOf(String str) {
            return (TransitionState) Enum.valueOf(TransitionState.class, str);
        }

        public static TransitionState[] values() {
            return (TransitionState[]) f167a.clone();
        }
    }

    public MotionLayout(@NonNull Context context, @Nullable AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f153u = null;
        this.f155v = 0.0f;
        this.f157w = -1;
        this.f159x = -1;
        this.f161y = -1;
        this.f163z = 0;
        this.f101A = 0;
        this.f103B = true;
        this.f105C = new HashMap();
        this.f107D = 0L;
        this.f109E = 1.0f;
        this.f111F = 0.0f;
        this.f113G = 0.0f;
        this.f116I = 0.0f;
        this.f118K = false;
        this.f120M = 0;
        this.f122O = false;
        this.f123P = new g1.b();
        this.f124Q = new q(this);
        this.f128U = false;
        this.f133c0 = false;
        this.f134d0 = null;
        this.f135e0 = null;
        this.f136f0 = null;
        this.f137g0 = null;
        this.f138h0 = 0;
        this.f139i0 = -1L;
        this.f140j0 = 0.0f;
        this.f141k0 = 0;
        this.f142l0 = 0.0f;
        this.f143m0 = false;
        this.f154u0 = new e(1);
        this.f156v0 = false;
        this.f160x0 = null;
        new HashMap();
        this.f162y0 = new Rect();
        this.f164z0 = false;
        this.f102A0 = TransitionState.UNDEFINED;
        this.f104B0 = new s(this);
        this.f106C0 = false;
        this.f108D0 = new RectF();
        this.f110E0 = null;
        this.f112F0 = null;
        this.f114G0 = new ArrayList();
        m65z(attributeSet);
    }

    /* JADX INFO: renamed from: q */
    public static Rect m39q(MotionLayout motionLayout, f fVar) {
        int iT = fVar.t();
        Rect rect = motionLayout.f162y0;
        rect.top = iT;
        rect.left = fVar.s();
        rect.right = fVar.r() + rect.left;
        rect.bottom = fVar.l() + rect.top;
        return rect;
    }

    /* JADX INFO: renamed from: A */
    public final void m40A() {
        h1.x xVar;
        C0017d c0017d;
        View viewFindViewById;
        C0016c c0016c = this.f149s;
        if (c0016c == null) {
            return;
        }
        if (c0016c.m67a(this.f159x, this)) {
            requestLayout();
            return;
        }
        int i = this.f159x;
        if (i != -1) {
            C0016c c0016c2 = this.f149s;
            ArrayList<h1.x> arrayList = c0016c2.f179d;
            for (h1.x xVar2 : arrayList) {
                if (xVar2.m.size() > 0) {
                    Iterator it = xVar2.m.iterator();
                    while (it.hasNext()) {
                        ((w) it.next()).b(this);
                    }
                }
            }
            ArrayList<h1.x> arrayList2 = c0016c2.f181f;
            for (h1.x xVar3 : arrayList2) {
                if (xVar3.m.size() > 0) {
                    Iterator it2 = xVar3.m.iterator();
                    while (it2.hasNext()) {
                        ((w) it2.next()).b(this);
                    }
                }
            }
            for (h1.x xVar4 : arrayList) {
                if (xVar4.m.size() > 0) {
                    Iterator it3 = xVar4.m.iterator();
                    while (it3.hasNext()) {
                        ((w) it3.next()).a(this, i, xVar4);
                    }
                }
            }
            for (h1.x xVar5 : arrayList2) {
                if (xVar5.m.size() > 0) {
                    Iterator it4 = xVar5.m.iterator();
                    while (it4.hasNext()) {
                        ((w) it4.next()).a(this, i, xVar5);
                    }
                }
            }
        }
        if (!this.f149s.m81o() || (xVar = this.f149s.f178c) == null || (c0017d = xVar.l) == null) {
            return;
        }
        int i2 = c0017d.f204d;
        if (i2 != -1) {
            MotionLayout motionLayout = c0017d.f218r;
            viewFindViewById = motionLayout.findViewById(i2);
            if (viewFindViewById == null) {
                Log.e("TouchResponse", "cannot find TouchAnchorId @id/" + so.c.w(motionLayout.getContext(), c0017d.f204d));
            }
        } else {
            viewFindViewById = null;
        }
        if (viewFindViewById instanceof NestedScrollView) {
            NestedScrollView nestedScrollView = (NestedScrollView) viewFindViewById;
            nestedScrollView.setOnTouchListener(new y(0));
            nestedScrollView.setOnScrollChangeListener(new com.crazymaple.reelshort.novel.htmltext.e());
        }
    }

    /* JADX INFO: renamed from: B */
    public final void m41B() {
        CopyOnWriteArrayList copyOnWriteArrayList;
        if (this.f119L == null && ((copyOnWriteArrayList = this.f137g0) == null || copyOnWriteArrayList.isEmpty())) {
            return;
        }
        ArrayList<Integer> arrayList = this.f114G0;
        for (Integer num : arrayList) {
            u uVar = this.f119L;
            if (uVar != null) {
                uVar.a(num.intValue());
            }
            CopyOnWriteArrayList copyOnWriteArrayList2 = this.f137g0;
            if (copyOnWriteArrayList2 != null) {
                Iterator it = copyOnWriteArrayList2.iterator();
                while (it.hasNext()) {
                    ((u) it.next()).a(num.intValue());
                }
            }
        }
        arrayList.clear();
    }

    /* JADX INFO: renamed from: C */
    public final void m42C() {
        this.f104B0.f();
        invalidate();
    }

    /* JADX INFO: renamed from: D */
    public final void m43D(float f, float f2) {
        if (!super.isAttachedToWindow()) {
            if (this.f158w0 == null) {
                this.f158w0 = new C0015b(this);
            }
            C0015b c0015b = this.f158w0;
            c0015b.f171a = f;
            c0015b.f172b = f2;
            return;
        }
        setProgress(f);
        setState(TransitionState.MOVING);
        this.f155v = f2;
        if (f2 != 0.0f) {
            m57r(f2 > 0.0f ? 1.0f : 0.0f);
        } else {
            if (f == 0.0f || f == 1.0f) {
                return;
            }
            m57r(f > 0.5f ? 1.0f : 0.0f);
        }
    }

    /* JADX INFO: renamed from: E */
    public final void m44E(int i) {
        int iB;
        setState(TransitionState.SETUP);
        this.f159x = i;
        this.f157w = -1;
        this.f161y = -1;
        C0082o c0082o = this.f366k;
        if (c0082o == null) {
            C0016c c0016c = this.f149s;
            if (c0016c != null) {
                c0016c.m68b(i).m137b(this);
                return;
            }
            return;
        }
        float f = -1;
        int i2 = c0082o.f736a;
        SparseArray sparseArray = (SparseArray) c0082o.f739d;
        ConstraintLayout constraintLayout = (ConstraintLayout) c0082o.f738c;
        if (i2 != i) {
            c0082o.f736a = i;
            j1.d dVar = (j1.d) sparseArray.get(i);
            int iB2 = dVar.b(f, f);
            ArrayList arrayList = dVar.b;
            C0041d c0041d = iB2 == -1 ? dVar.d : ((j1.e) arrayList.get(iB2)).f;
            if (iB2 != -1) {
                int i3 = ((j1.e) arrayList.get(iB2)).e;
            }
            if (c0041d == null) {
                return;
            }
            c0082o.f737b = iB2;
            c0041d.m137b(constraintLayout);
            return;
        }
        j1.d dVar2 = i == -1 ? (j1.d) sparseArray.valueAt(0) : (j1.d) sparseArray.get(i2);
        int i4 = c0082o.f737b;
        if ((i4 == -1 || !((j1.e) dVar2.b.get(i4)).a(f, f)) && c0082o.f737b != (iB = dVar2.b(f, f))) {
            ArrayList arrayList2 = dVar2.b;
            C0041d c0041d2 = iB == -1 ? null : ((j1.e) arrayList2.get(iB)).f;
            if (iB != -1) {
                int i5 = ((j1.e) arrayList2.get(iB)).e;
            }
            if (c0041d2 == null) {
                return;
            }
            c0082o.f737b = iB;
            c0041d2.m137b(constraintLayout);
        }
    }

    /* JADX INFO: renamed from: F */
    public final void m45F(int i, int i2) {
        if (!super.isAttachedToWindow()) {
            if (this.f158w0 == null) {
                this.f158w0 = new C0015b(this);
            }
            C0015b c0015b = this.f158w0;
            c0015b.f173c = i;
            c0015b.f174d = i2;
            return;
        }
        C0016c c0016c = this.f149s;
        if (c0016c != null) {
            this.f157w = i;
            this.f161y = i2;
            c0016c.m80n(i, i2);
            this.f104B0.e(this.f149s.m68b(i), this.f149s.m68b(i2));
            m42C();
            this.f113G = 0.0f;
            m57r(0.0f);
        }
    }

    /* JADX WARN: Code duplicated, block: B:26:0x0073  */
    /* JADX WARN: Code duplicated, block: B:27:0x0085  */
    /* JADX WARN: Code duplicated, block: B:32:0x009d  */
    /* JADX WARN: Code duplicated, block: B:35:0x00c5  */
    /* JADX WARN: Code duplicated, block: B:41:0x00d0  */
    /* JADX WARN: Code duplicated, block: B:47:0x00de  */
    /* JADX WARN: Code duplicated, block: B:49:0x00e1  */
    /* JADX WARN: Code duplicated, block: B:54:0x00f5  */
    /* JADX WARN: Code duplicated, block: B:56:0x00ff  */
    /* JADX WARN: Code duplicated, block: B:61:0x010a  */
    /* JADX WARN: Code duplicated, block: B:66:0x0114  */
    /* JADX WARN: Code duplicated, block: B:71:0x011e  */
    /* JADX WARN: Code duplicated, block: B:76:0x0128  */
    /* JADX WARN: Code duplicated, block: B:81:0x0132  */
    /* JADX WARN: Code duplicated, block: B:84:0x0137  */
    /* JADX INFO: renamed from: G */
    public final void m46G(int i, float f, float f2) {
        C0016c c0016c;
        h1.x xVar;
        int i2;
        float f3;
        float f4;
        float f5;
        float f6;
        int i3;
        C0017d c0017d;
        C0017d c0017d2;
        C0017d c0017d3;
        C0017d c0017d4;
        C0017d c0017d5;
        h1.x xVar2;
        float f7;
        C0017d c0017d6;
        C0017d c0017d7;
        h1.x xVar3;
        float f8;
        C0017d c0017d8;
        float f9 = f;
        if (this.f149s == null || this.f113G == f9) {
            return;
        }
        this.f122O = true;
        this.f107D = getNanoTime();
        float fM69c = this.f149s.m69c() / 1000.0f;
        this.f109E = fM69c;
        this.f116I = f9;
        this.f118K = true;
        g1.b bVar = this.f123P;
        if (i == 0 || i == 1 || i == 2) {
            if (i != 1 || i == 7) {
                f9 = 0.0f;
            } else if (i == 2 || i == 6) {
                f9 = 1.0f;
            }
            c0016c = this.f149s;
            xVar = c0016c.f178c;
            if (xVar != null || (c0017d7 = xVar.l) == null) {
                i2 = 0;
            } else {
                i2 = c0017d7.f200D;
            }
            if (i2 == 0) {
                float f10 = this.f113G;
                float fM73g = c0016c.m73g();
                xVar2 = this.f149s.f178c;
                if (xVar2 != null || (c0017d6 = xVar2.l) == null) {
                    f7 = 0.0f;
                } else {
                    f7 = c0017d6.f219s;
                }
                this.f123P.b(f10, f9, f2, fM69c, fM73g, f7);
            } else {
                float f11 = this.f113G;
                if (xVar != null || (c0017d5 = xVar.l) == null) {
                    f3 = 0.0f;
                } else {
                    f3 = c0017d5.f226z;
                }
                if (xVar != null || (c0017d4 = xVar.l) == null) {
                    f4 = 0.0f;
                } else {
                    f4 = c0017d4.f197A;
                }
                if (xVar != null || (c0017d3 = xVar.l) == null) {
                    f5 = 0.0f;
                } else {
                    f5 = c0017d3.f225y;
                }
                if (xVar != null || (c0017d2 = xVar.l) == null) {
                    f6 = 0.0f;
                } else {
                    f6 = c0017d2.f198B;
                }
                if (xVar != null || (c0017d = xVar.l) == null) {
                    i3 = 0;
                } else {
                    i3 = c0017d.f199C;
                }
                if (bVar.b == null) {
                    j jVar = new j();
                    jVar.a = 0.5d;
                    jVar.i = 0;
                    bVar.b = jVar;
                }
                j jVar2 = bVar.b;
                bVar.c = jVar2;
                jVar2.c = f9;
                jVar2.a = f5;
                jVar2.e = f11;
                jVar2.b = f4;
                jVar2.g = f3;
                jVar2.h = f6;
                jVar2.i = i3;
                jVar2.d = 0.0f;
            }
            int i4 = this.f159x;
            this.f116I = f9;
            this.f159x = i4;
            this.f151t = bVar;
        } else {
            q qVar = this.f124Q;
            if (i == 4) {
                float f12 = this.f113G;
                float fM73g2 = this.f149s.m73g();
                qVar.a = f2;
                qVar.b = f12;
                qVar.c = fM73g2;
                this.f151t = qVar;
            } else if (i == 5) {
                float f13 = this.f113G;
                float fM73g3 = this.f149s.m73g();
                if (f2 > 0.0f) {
                    float f14 = f2 / fM73g3;
                    if (((f2 * f14) - (((fM73g3 * f14) * f14) / 2.0f)) + f13 > 1.0f) {
                        float f15 = this.f113G;
                        float fM73g4 = this.f149s.m73g();
                        qVar.a = f2;
                        qVar.b = f15;
                        qVar.c = fM73g4;
                        this.f151t = qVar;
                    } else {
                        float f16 = this.f113G;
                        float f17 = this.f109E;
                        float fM73g5 = this.f149s.m73g();
                        xVar3 = this.f149s.f178c;
                        if (xVar3 != null || (c0017d8 = xVar3.l) == null) {
                            f8 = 0.0f;
                        } else {
                            f8 = c0017d8.f219s;
                        }
                        this.f123P.b(f16, f, f2, f17, fM73g5, f8);
                        this.f155v = 0.0f;
                        int i5 = this.f159x;
                        this.f116I = f9;
                        this.f159x = i5;
                        this.f151t = bVar;
                    }
                } else {
                    float f18 = (-f2) / fM73g3;
                    if ((((fM73g3 * f18) * f18) / 2.0f) + (f2 * f18) + f13 < 0.0f) {
                        float f19 = this.f113G;
                        float fM73g6 = this.f149s.m73g();
                        qVar.a = f2;
                        qVar.b = f19;
                        qVar.c = fM73g6;
                        this.f151t = qVar;
                    } else {
                        float f110 = this.f113G;
                        float f111 = this.f109E;
                        float fM73g7 = this.f149s.m73g();
                        xVar3 = this.f149s.f178c;
                        if (xVar3 != null) {
                            f8 = 0.0f;
                        } else {
                            f8 = 0.0f;
                        }
                        this.f123P.b(f110, f, f2, f111, fM73g7, f8);
                        this.f155v = 0.0f;
                        int i6 = this.f159x;
                        this.f116I = f9;
                        this.f159x = i6;
                        this.f151t = bVar;
                    }
                }
            } else if (i == 6 || i == 7) {
                if (i != 1) {
                    f9 = 0.0f;
                } else {
                    f9 = 0.0f;
                }
                c0016c = this.f149s;
                xVar = c0016c.f178c;
                if (xVar != null) {
                    i2 = 0;
                } else {
                    i2 = 0;
                }
                if (i2 == 0) {
                    float f112 = this.f113G;
                    float fM73g8 = c0016c.m73g();
                    xVar2 = this.f149s.f178c;
                    if (xVar2 != null) {
                        f7 = 0.0f;
                    } else {
                        f7 = 0.0f;
                    }
                    this.f123P.b(f112, f9, f2, fM69c, fM73g8, f7);
                } else {
                    float f113 = this.f113G;
                    if (xVar != null) {
                        f3 = 0.0f;
                    } else {
                        f3 = 0.0f;
                    }
                    if (xVar != null) {
                        f4 = 0.0f;
                    } else {
                        f4 = 0.0f;
                    }
                    if (xVar != null) {
                        f5 = 0.0f;
                    } else {
                        f5 = 0.0f;
                    }
                    if (xVar != null) {
                        f6 = 0.0f;
                    } else {
                        f6 = 0.0f;
                    }
                    if (xVar != null) {
                        i3 = 0;
                    } else {
                        i3 = 0;
                    }
                    if (bVar.b == null) {
                        j jVar3 = new j();
                        jVar3.a = 0.5d;
                        jVar3.i = 0;
                        bVar.b = jVar3;
                    }
                    j jVar4 = bVar.b;
                    bVar.c = jVar4;
                    jVar4.c = f9;
                    jVar4.a = f5;
                    jVar4.e = f113;
                    jVar4.b = f4;
                    jVar4.g = f3;
                    jVar4.h = f6;
                    jVar4.i = i3;
                    jVar4.d = 0.0f;
                }
                int i7 = this.f159x;
                this.f116I = f9;
                this.f159x = i7;
                this.f151t = bVar;
            }
        }
        this.f117J = false;
        this.f107D = getNanoTime();
        invalidate();
    }

    /* JADX INFO: renamed from: H */
    public final void m47H() {
        m57r(1.0f);
        this.f160x0 = null;
    }

    /* JADX INFO: renamed from: I */
    public final void m48I(int i) {
        androidx.compose.animation.core.u uVar;
        if (!super.isAttachedToWindow()) {
            if (this.f158w0 == null) {
                this.f158w0 = new C0015b(this);
            }
            this.f158w0.f174d = i;
            return;
        }
        C0016c c0016c = this.f149s;
        if (c0016c != null && (uVar = c0016c.f177b) != null) {
            int i2 = this.f159x;
            float f = -1;
            p pVar = (p) ((SparseArray) uVar.b).get(i);
            if (pVar != null) {
                ArrayList arrayList = pVar.b;
                int i3 = pVar.c;
                if (f != -1.0f && f != -1.0f) {
                    Iterator it = arrayList.iterator();
                    j1.q qVar = null;
                    while (true) {
                        if (!it.hasNext()) {
                            if (qVar != null) {
                                i2 = qVar.e;
                                break;
                            } else {
                                i2 = i3;
                                break;
                            }
                        }
                        j1.q qVar2 = (j1.q) it.next();
                        if (qVar2.a(f, f)) {
                            if (i2 == qVar2.e) {
                                break;
                            } else {
                                qVar = qVar2;
                            }
                        }
                    }
                } else if (i3 != i2) {
                    Iterator it2 = arrayList.iterator();
                    do {
                        if (!it2.hasNext()) {
                            i2 = i3;
                            break;
                        }
                    } while (i2 != ((j1.q) it2.next()).e);
                }
            } else {
                i2 = i;
            }
            if (i2 != -1) {
                i = i2;
            }
        }
        int i4 = this.f159x;
        if (i4 == i) {
            return;
        }
        if (this.f157w == i) {
            m57r(0.0f);
            return;
        }
        if (this.f161y == i) {
            m57r(1.0f);
            return;
        }
        this.f161y = i;
        if (i4 != -1) {
            m45F(i4, i);
            m57r(1.0f);
            this.f113G = 0.0f;
            m47H();
            return;
        }
        this.f122O = false;
        this.f116I = 1.0f;
        this.f111F = 0.0f;
        this.f113G = 0.0f;
        this.f115H = getNanoTime();
        this.f107D = getNanoTime();
        this.f117J = false;
        this.f151t = null;
        this.f109E = this.f149s.m69c() / 1000.0f;
        this.f157w = -1;
        this.f149s.m80n(-1, this.f161y);
        SparseArray sparseArray = new SparseArray();
        int childCount = getChildCount();
        HashMap map = this.f105C;
        map.clear();
        for (int i5 = 0; i5 < childCount; i5++) {
            View childAt = getChildAt(i5);
            map.put(childAt, new n(childAt));
            sparseArray.put(childAt.getId(), (n) map.get(childAt));
        }
        this.f118K = true;
        C0041d c0041dM68b = this.f149s.m68b(i);
        s sVar = this.f104B0;
        sVar.e((C0041d) null, c0041dM68b);
        m42C();
        sVar.a();
        int childCount2 = getChildCount();
        for (int i6 = 0; i6 < childCount2; i6++) {
            View childAt2 = getChildAt(i6);
            n nVar = (n) map.get(childAt2);
            if (nVar != null) {
                v vVar = nVar.f;
                vVar.c = 0.0f;
                vVar.d = 0.0f;
                vVar.f(childAt2.getX(), childAt2.getY(), childAt2.getWidth(), childAt2.getHeight());
                l lVar = nVar.h;
                lVar.getClass();
                childAt2.getX();
                childAt2.getY();
                childAt2.getWidth();
                childAt2.getHeight();
                lVar.c = childAt2.getVisibility();
                lVar.a = childAt2.getVisibility() != 0 ? 0.0f : childAt2.getAlpha();
                lVar.d = childAt2.getElevation();
                lVar.e = childAt2.getRotation();
                lVar.f = childAt2.getRotationX();
                lVar.g = childAt2.getRotationY();
                lVar.h = childAt2.getScaleX();
                lVar.i = childAt2.getScaleY();
                lVar.j = childAt2.getPivotX();
                lVar.k = childAt2.getPivotY();
                lVar.l = childAt2.getTranslationX();
                lVar.m = childAt2.getTranslationY();
                lVar.n = childAt2.getTranslationZ();
            }
        }
        int width = getWidth();
        int height = getHeight();
        if (this.f136f0 != null) {
            for (int i7 = 0; i7 < childCount; i7++) {
                n nVar2 = (n) map.get(getChildAt(i7));
                if (nVar2 != null) {
                    this.f149s.m72f(nVar2);
                }
            }
            Iterator it3 = this.f136f0.iterator();
            while (it3.hasNext()) {
                ((MotionHelper) it3.next()).mo36r(this, map);
            }
            for (int i8 = 0; i8 < childCount; i8++) {
                n nVar3 = (n) map.get(getChildAt(i8));
                if (nVar3 != null) {
                    nVar3.h(width, height, getNanoTime());
                }
            }
        } else {
            for (int i9 = 0; i9 < childCount; i9++) {
                n nVar4 = (n) map.get(getChildAt(i9));
                if (nVar4 != null) {
                    this.f149s.m72f(nVar4);
                    nVar4.h(width, height, getNanoTime());
                }
            }
        }
        h1.x xVar = this.f149s.f178c;
        float f2 = xVar != null ? xVar.i : 0.0f;
        if (f2 != 0.0f) {
            float fMin = Float.MAX_VALUE;
            float fMax = -3.4028235E38f;
            for (int i10 = 0; i10 < childCount; i10++) {
                v vVar2 = ((n) map.get(getChildAt(i10))).g;
                float f3 = vVar2.f + vVar2.e;
                fMin = Math.min(fMin, f3);
                fMax = Math.max(fMax, f3);
            }
            for (int i11 = 0; i11 < childCount; i11++) {
                n nVar5 = (n) map.get(getChildAt(i11));
                v vVar3 = nVar5.g;
                float f4 = vVar3.e;
                float f5 = vVar3.f;
                nVar5.n = 1.0f / (1.0f - f2);
                nVar5.m = f2 - ((((f4 + f5) - fMin) * f2) / (fMax - fMin));
            }
        }
        this.f111F = 0.0f;
        this.f113G = 0.0f;
        this.f118K = true;
        invalidate();
    }

    /* JADX INFO: renamed from: J */
    public final void m49J(int i, C0041d c0041d) {
        C0016c c0016c = this.f149s;
        if (c0016c != null) {
            c0016c.f182g.put(i, c0041d);
        }
        this.f104B0.e(this.f149s.m68b(this.f157w), this.f149s.m68b(this.f161y));
        m42C();
        if (this.f159x == i) {
            c0041d.m137b(this);
        }
    }

    /* JADX INFO: renamed from: b */
    public final void m50b(int i, View view) {
        C0017d c0017d;
        C0016c c0016c = this.f149s;
        if (c0016c != null) {
            float f = this.f132b0;
            if (f == 0.0f) {
                return;
            }
            float f2 = this.f129V / f;
            float f3 = this.f130W / f;
            h1.x xVar = c0016c.f178c;
            if (xVar == null || (c0017d = xVar.l) == null) {
                return;
            }
            c0017d.f213m = false;
            MotionLayout motionLayout = c0017d.f218r;
            float progress = motionLayout.getProgress();
            c0017d.f218r.m62w(c0017d.f204d, progress, c0017d.f208h, c0017d.f207g, c0017d.f214n);
            float f4 = c0017d.f211k;
            float[] fArr = c0017d.f214n;
            float f5 = f4 != 0.0f ? (f2 * f4) / fArr[0] : (f3 * c0017d.f212l) / fArr[1];
            if (!Float.isNaN(f5)) {
                progress += f5 / 3.0f;
            }
            if (progress != 0.0f) {
                boolean z = progress != 1.0f;
                int i2 = c0017d.f203c;
                if ((i2 != 3) && z) {
                    motionLayout.m46G(i2, ((double) progress) >= 0.5d ? 1.0f : 0.0f, f5);
                }
            }
        }
    }

    /* JADX INFO: renamed from: c */
    public final void m51c(View view, View view2, int i, int i2) {
        this.f131a0 = getNanoTime();
        this.f132b0 = 0.0f;
        this.f129V = 0.0f;
        this.f130W = 0.0f;
    }

    /* JADX WARN: Type inference failed for: r1v3 */
    /* JADX WARN: Type inference failed for: r1v4, types: [boolean] */
    /* JADX WARN: Type inference failed for: r1v5 */
    /* JADX INFO: renamed from: d */
    public final void m52d(View view, int i, int i2, int[] iArr, int i3) {
        h1.x xVar;
        boolean z;
        ?? r1;
        C0017d c0017d;
        float f;
        C0017d c0017d2;
        C0017d c0017d3;
        C0017d c0017d4;
        int i4;
        C0016c c0016c = this.f149s;
        if (c0016c == null || (xVar = c0016c.f178c) == null || (z = xVar.o)) {
            return;
        }
        int i5 = -1;
        if (z || (c0017d4 = xVar.l) == null || (i4 = c0017d4.f205e) == -1 || view.getId() == i4) {
            h1.x xVar2 = c0016c.f178c;
            if ((xVar2 == null || (c0017d3 = xVar2.l) == null) ? false : c0017d3.f221u) {
                C0017d c0017d5 = xVar.l;
                if (c0017d5 != null && (c0017d5.f223w & 4) != 0) {
                    i5 = i2;
                }
                float f2 = this.f111F;
                if ((f2 == 1.0f || f2 == 0.0f) && view.canScrollVertically(i5)) {
                    return;
                }
            }
            C0017d c0017d6 = xVar.l;
            if (c0017d6 != null && (c0017d6.f223w & 1) != 0) {
                float f3 = i;
                float f4 = i2;
                h1.x xVar3 = c0016c.f178c;
                if (xVar3 == null || (c0017d2 = xVar3.l) == null) {
                    f = 0.0f;
                } else {
                    c0017d2.f218r.m62w(c0017d2.f204d, c0017d2.f218r.getProgress(), c0017d2.f208h, c0017d2.f207g, c0017d2.f214n);
                    float f5 = c0017d2.f211k;
                    float[] fArr = c0017d2.f214n;
                    if (f5 != 0.0f) {
                        if (fArr[0] == 0.0f) {
                            fArr[0] = 1.0E-7f;
                        }
                        f = (f3 * f5) / fArr[0];
                    } else {
                        if (fArr[1] == 0.0f) {
                            fArr[1] = 1.0E-7f;
                        }
                        f = (f4 * c0017d2.f212l) / fArr[1];
                    }
                }
                float f6 = this.f113G;
                if ((f6 <= 0.0f && f < 0.0f) || (f6 >= 1.0f && f > 0.0f)) {
                    view.setNestedScrollingEnabled(false);
                    view.post(new h1.p((ViewGroup) view, 0));
                    return;
                }
            }
            float f7 = this.f111F;
            long nanoTime = getNanoTime();
            float f8 = i;
            this.f129V = f8;
            float f9 = i2;
            this.f130W = f9;
            this.f132b0 = (float) ((nanoTime - this.f131a0) * 1.0E-9d);
            this.f131a0 = nanoTime;
            h1.x xVar4 = c0016c.f178c;
            if (xVar4 != null && (c0017d = xVar4.l) != null) {
                MotionLayout motionLayout = c0017d.f218r;
                float progress = motionLayout.getProgress();
                if (!c0017d.f213m) {
                    c0017d.f213m = true;
                    motionLayout.setProgress(progress);
                }
                c0017d.f218r.m62w(c0017d.f204d, progress, c0017d.f208h, c0017d.f207g, c0017d.f214n);
                float f10 = c0017d.f211k;
                float[] fArr2 = c0017d.f214n;
                if (Math.abs((c0017d.f212l * fArr2[1]) + (f10 * fArr2[0])) < 0.01d) {
                    fArr2[0] = 0.01f;
                    fArr2[1] = 0.01f;
                }
                float f11 = c0017d.f211k;
                float fMax = Math.max(Math.min(progress + (f11 != 0.0f ? (f8 * f11) / fArr2[0] : (f9 * c0017d.f212l) / fArr2[1]), 1.0f), 0.0f);
                if (fMax != motionLayout.getProgress()) {
                    motionLayout.setProgress(fMax);
                }
            }
            if (f7 != this.f111F) {
                iArr[0] = i;
                r1 = 1;
                iArr[1] = i2;
            } else {
                r1 = 1;
            }
            m59t(false);
            if (iArr[0] == 0 && iArr[r1] == 0) {
                return;
            }
            this.f128U = r1;
        }
    }

    /* JADX WARN: Code duplicated, block: B:123:0x0314  */
    /* JADX WARN: Code duplicated, block: B:125:0x0322  */
    /* JADX WARN: Code duplicated, block: B:127:0x0328  */
    /* JADX WARN: Code duplicated, block: B:128:0x032c  */
    /* JADX WARN: Code duplicated, block: B:130:0x0332  */
    /* JADX WARN: Code duplicated, block: B:134:0x033f  */
    /* JADX WARN: Code duplicated, block: B:136:0x0345  */
    /* JADX WARN: Code duplicated, block: B:137:0x0348  */
    /* JADX WARN: Code duplicated, block: B:139:0x035c  */
    /* JADX WARN: Code duplicated, block: B:142:0x036c  */
    /* JADX WARN: Code duplicated, block: B:144:0x0371  */
    /* JADX WARN: Code duplicated, block: B:147:0x038f  */
    /* JADX WARN: Code duplicated, block: B:148:0x0399 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:149:0x039b  */
    /* JADX WARN: Code duplicated, block: B:151:0x03a6  */
    /* JADX WARN: Code duplicated, block: B:153:0x03b4 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:154:0x03b6  */
    /* JADX WARN: Code duplicated, block: B:209:0x0336 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:211:0x0336 A[SYNTHETIC] */
    @Override // androidx.constraintlayout.widget.ConstraintLayout, android.view.ViewGroup, android.view.View
    public final void dispatchDraw(Canvas canvas) {
        Iterator it;
        int i;
        Canvas canvas2;
        int i2;
        int i3;
        int i4;
        int i5;
        v vVar;
        Paint paint;
        g1.l lVar;
        float f;
        double d;
        e eVar;
        float f2;
        double d2;
        double dA;
        b1.b bVar;
        int i6;
        g1.l lVar2;
        double[] dArr;
        float f3;
        e eVar2;
        float f4;
        as.c cVar;
        ArrayList arrayList;
        Canvas canvas3 = canvas;
        ArrayList arrayList2 = this.f136f0;
        if (arrayList2 != null) {
            Iterator it2 = arrayList2.iterator();
            while (it2.hasNext()) {
                ((MotionHelper) it2.next()).getClass();
            }
        }
        int i7 = 0;
        m59t(false);
        C0016c c0016c = this.f149s;
        if (c0016c != null && (cVar = c0016c.f192q) != null && (arrayList = (ArrayList) cVar.e) != null) {
            Iterator it3 = arrayList.iterator();
            while (it3.hasNext()) {
                ((z) it3.next()).a();
            }
            ArrayList arrayList3 = (ArrayList) cVar.e;
            ArrayList arrayList4 = (ArrayList) cVar.f;
            arrayList3.removeAll(arrayList4);
            arrayList4.clear();
            if (((ArrayList) cVar.e).isEmpty()) {
                cVar.e = null;
            }
        }
        super.dispatchDraw(canvas);
        if (this.f149s == null) {
            return;
        }
        int i8 = 1;
        if ((this.f120M & 1) == 1 && !isInEditMode()) {
            this.f138h0++;
            long nanoTime = getNanoTime();
            long j = this.f139i0;
            if (j != -1) {
                long j2 = nanoTime - j;
                if (j2 > 200000000) {
                    this.f140j0 = ((int) ((this.f138h0 / (j2 * 1.0E-9f)) * 100.0f)) / 100.0f;
                    this.f138h0 = 0;
                    this.f139i0 = nanoTime;
                }
            } else {
                this.f139i0 = nanoTime;
            }
            Paint paint2 = new Paint();
            paint2.setTextSize(42.0f);
            float progress = ((int) (getProgress() * 1000.0f)) / 10.0f;
            StringBuilder sbY = a1.a.y(this.f140j0 + " fps " + so.c.y(this.f157w, this) + " -> ");
            sbY.append(so.c.y(this.f161y, this));
            sbY.append(" (progress: ");
            sbY.append(progress);
            sbY.append(" ) state=");
            int i9 = this.f159x;
            sbY.append(i9 == -1 ? "undefined" : so.c.y(i9, this));
            String string = sbY.toString();
            paint2.setColor(-16777216);
            canvas3.drawText(string, 11.0f, getHeight() - 29, paint2);
            paint2.setColor(-7864184);
            canvas3.drawText(string, 10.0f, getHeight() - 30, paint2);
        }
        if (this.f120M > 1) {
            if (this.f121N == null) {
                this.f121N = new r(this);
            }
            r rVar = this.f121N;
            HashMap map = this.f105C;
            int iM69c = this.f149s.m69c();
            int i10 = this.f120M;
            rVar.getClass();
            if (map != null && map.size() != 0) {
                canvas.save();
                MotionLayout motionLayout = rVar.n;
                boolean zIsInEditMode = motionLayout.isInEditMode();
                Paint paint3 = rVar.e;
                if (!zIsInEditMode && (i10 & 1) == 2) {
                    String str = motionLayout.getContext().getResources().getResourceName(motionLayout.f161y) + ":" + motionLayout.getProgress();
                    canvas3.drawText(str, 10.0f, motionLayout.getHeight() - 30, rVar.h);
                    canvas3.drawText(str, 11.0f, motionLayout.getHeight() - 29, paint3);
                }
                Iterator it4 = map.values().iterator();
                while (it4.hasNext()) {
                    n nVar = (n) it4.next();
                    int iMax = nVar.f.b;
                    ArrayList<v> arrayList5 = nVar.u;
                    Iterator it5 = arrayList5.iterator();
                    while (it5.hasNext()) {
                        iMax = Math.max(iMax, ((v) it5.next()).b);
                    }
                    int iMax2 = Math.max(iMax, nVar.g.b);
                    if (i10 > 0 && iMax2 == 0) {
                        iMax2 = i8;
                    }
                    if (iMax2 != 0) {
                        float[] fArr = rVar.c;
                        if (fArr != null) {
                            double[] dArrZ = nVar.j[i7].z();
                            int[] iArr = rVar.b;
                            if (iArr != null) {
                                Iterator it6 = arrayList5.iterator();
                                int i11 = i7;
                                while (it6.hasNext()) {
                                    iArr[i11] = ((v) it6.next()).o;
                                    i11++;
                                }
                            }
                            int i12 = i7;
                            int i13 = i12;
                            while (i12 < dArrZ.length) {
                                nVar.j[i7].v(dArrZ[i12], nVar.p);
                                nVar.f.d(dArrZ[i12], nVar.o, nVar.p, fArr, i13);
                                i13 += 2;
                                i12++;
                                rVar = rVar;
                                it4 = it4;
                                i7 = 0;
                            }
                            it = it4;
                            i = i13 / 2;
                        } else {
                            it = it4;
                            i = 0;
                        }
                        rVar.k = i;
                        if (iMax2 >= 1) {
                            int i14 = iM69c / 16;
                            float[] fArr2 = rVar.a;
                            if (fArr2 == null || fArr2.length != i14 * 2) {
                                rVar.a = new float[i14 * 2];
                                rVar.d = new Path();
                            }
                            int i15 = rVar.m;
                            float f5 = i15;
                            canvas3.translate(f5, f5);
                            paint3.setColor(1996488704);
                            Paint paint4 = rVar.i;
                            paint4.setColor(1996488704);
                            Paint paint5 = rVar.f;
                            paint5.setColor(1996488704);
                            Paint paint6 = rVar.g;
                            paint6.setColor(1996488704);
                            float[] fArr3 = rVar.a;
                            i3 = iM69c;
                            float f6 = 1.0f / (i14 - 1);
                            HashMap map2 = nVar.y;
                            i4 = i10;
                            g1.l lVar3 = map2 == null ? null : (g1.l) map2.get("translationX");
                            HashMap map3 = nVar.y;
                            g1.l lVar4 = map3 == null ? null : (g1.l) map3.get("translationY");
                            HashMap map4 = nVar.z;
                            g gVar = map4 == null ? null : (g) map4.get("translationX");
                            HashMap map5 = nVar.z;
                            g gVar2 = map5 == null ? null : (g) map5.get("translationY");
                            int i16 = 0;
                            while (true) {
                                vVar = nVar.f;
                                float f7 = Float.NaN;
                                paint = paint5;
                                if (i16 >= i14) {
                                    break;
                                }
                                float fMin = i16 * f6;
                                int i17 = i14;
                                float f8 = nVar.n;
                                if (f8 != 1.0f) {
                                    f = f6;
                                    float f9 = nVar.m;
                                    if (fMin < f9) {
                                        fMin = 0.0f;
                                    }
                                    lVar = lVar4;
                                    if (fMin > f9 && fMin < 1.0d) {
                                        fMin = Math.min((fMin - f9) * f8, 1.0f);
                                    }
                                    d = fMin;
                                    eVar = vVar.a;
                                    f2 = 0.0f;
                                    for (v vVar2 : arrayList5) {
                                        double d3 = d;
                                        eVar2 = vVar2.a;
                                        if (eVar2 != null) {
                                            f4 = vVar2.c;
                                            if (f4 < fMin) {
                                                eVar = eVar2;
                                                f2 = f4;
                                            } else if (Float.isNaN(f7)) {
                                                f7 = vVar2.c;
                                            }
                                        }
                                        d = d3;
                                    }
                                    d2 = d;
                                    if (eVar != null) {
                                        if (Float.isNaN(f7)) {
                                            f3 = 1.0f;
                                        } else {
                                            f3 = f7;
                                        }
                                        float f10 = f3 - f2;
                                        dA = (((float) eVar.a((fMin - f2) / f10)) * f10) + f2;
                                    } else {
                                        dA = d2;
                                    }
                                    nVar.j[0].v(dA, nVar.p);
                                    bVar = nVar.k;
                                    if (bVar != null) {
                                        dArr = nVar.p;
                                        if (dArr.length > 0) {
                                            bVar.v(dA, dArr);
                                        }
                                    }
                                    i6 = i16 * 2;
                                    ArrayList arrayList6 = arrayList5;
                                    nVar.f.d(dA, nVar.o, nVar.p, fArr3, i6);
                                    if (gVar != null) {
                                        fArr3[i6] = gVar.a(fMin) + fArr3[i6];
                                    } else if (lVar3 != null) {
                                        fArr3[i6] = lVar3.a(fMin) + fArr3[i6];
                                    }
                                    if (gVar2 != null) {
                                        int i18 = i6 + 1;
                                        fArr3[i18] = gVar2.a(fMin) + fArr3[i18];
                                    } else {
                                        if (lVar != null) {
                                            int i19 = i6 + 1;
                                            lVar2 = lVar;
                                            fArr3[i19] = lVar2.a(fMin) + fArr3[i19];
                                        }
                                        i16++;
                                        lVar4 = lVar2;
                                        paint5 = paint;
                                        i14 = i17;
                                        f6 = f;
                                        arrayList5 = arrayList6;
                                    }
                                    lVar2 = lVar;
                                    i16++;
                                    lVar4 = lVar2;
                                    paint5 = paint;
                                    i14 = i17;
                                    f6 = f;
                                    arrayList5 = arrayList6;
                                } else {
                                    lVar = lVar4;
                                    f = f6;
                                }
                                d = fMin;
                                eVar = vVar.a;
                                f2 = 0.0f;
                                while (r15.hasNext()) {
                                    double d4 = d;
                                    eVar2 = vVar2.a;
                                    if (eVar2 != null) {
                                        f4 = vVar2.c;
                                        if (f4 < fMin) {
                                            eVar = eVar2;
                                            f2 = f4;
                                        } else if (Float.isNaN(f7)) {
                                            f7 = vVar2.c;
                                        }
                                    }
                                    d = d4;
                                }
                                d2 = d;
                                if (eVar != null) {
                                    if (Float.isNaN(f7)) {
                                        f3 = 1.0f;
                                    } else {
                                        f3 = f7;
                                    }
                                    float f11 = f3 - f2;
                                    dA = (((float) eVar.a((fMin - f2) / f11)) * f11) + f2;
                                } else {
                                    dA = d2;
                                }
                                nVar.j[0].v(dA, nVar.p);
                                bVar = nVar.k;
                                if (bVar != null) {
                                    dArr = nVar.p;
                                    if (dArr.length > 0) {
                                        bVar.v(dA, dArr);
                                    }
                                }
                                i6 = i16 * 2;
                                ArrayList arrayList7 = arrayList5;
                                nVar.f.d(dA, nVar.o, nVar.p, fArr3, i6);
                                if (gVar != null) {
                                    fArr3[i6] = gVar.a(fMin) + fArr3[i6];
                                } else if (lVar3 != null) {
                                    fArr3[i6] = lVar3.a(fMin) + fArr3[i6];
                                }
                                if (gVar2 != null) {
                                    int i110 = i6 + 1;
                                    fArr3[i110] = gVar2.a(fMin) + fArr3[i110];
                                } else {
                                    if (lVar != null) {
                                        int i111 = i6 + 1;
                                        lVar2 = lVar;
                                        fArr3[i111] = lVar2.a(fMin) + fArr3[i111];
                                    }
                                    i16++;
                                    lVar4 = lVar2;
                                    paint5 = paint;
                                    i14 = i17;
                                    f6 = f;
                                    arrayList5 = arrayList7;
                                }
                                lVar2 = lVar;
                                i16++;
                                lVar4 = lVar2;
                                paint5 = paint;
                                i14 = i17;
                                f6 = f;
                                arrayList5 = arrayList7;
                            }
                            rVar.a(canvas, iMax2, rVar.k, nVar);
                            paint3.setColor(-21965);
                            paint.setColor(-2067046);
                            paint4.setColor(-2067046);
                            paint6.setColor(-13391360);
                            float f12 = -i15;
                            canvas.translate(f12, f12);
                            rVar.a(canvas, iMax2, rVar.k, nVar);
                            if (iMax2 == 5) {
                                rVar.d.reset();
                                for (int i20 = 0; i20 <= 50; i20++) {
                                    nVar.j[0].v(nVar.b((float[]) null, i20 / 50), nVar.p);
                                    int[] iArr2 = nVar.o;
                                    double[] dArr2 = nVar.p;
                                    float f13 = vVar.e;
                                    float f14 = vVar.f;
                                    float f15 = vVar.g;
                                    float f16 = vVar.h;
                                    float f17 = f15;
                                    float fCos = f14;
                                    float f18 = f13;
                                    for (int i21 = 0; i21 < iArr2.length; i21++) {
                                        float f19 = (float) dArr2[i21];
                                        int i22 = iArr2[i21];
                                        if (i22 == 1) {
                                            f18 = f19;
                                        } else if (i22 == 2) {
                                            fCos = f19;
                                        } else if (i22 == 3) {
                                            f17 = f19;
                                        } else if (i22 == 4) {
                                            f16 = f19;
                                        }
                                    }
                                    if (vVar.m != null) {
                                        double d5 = 0.0f;
                                        double d6 = f18;
                                        double d7 = fCos;
                                        float fSin = (float) (((Math.sin(d7) * d6) + d5) - ((double) (f17 / 2.0f)));
                                        fCos = (float) ((d5 - (Math.cos(d7) * d6)) - ((double) (f16 / 2.0f)));
                                        f18 = fSin;
                                    }
                                    float f20 = f17 + f18;
                                    float f21 = f16 + fCos;
                                    Float.isNaN(Float.NaN);
                                    Float.isNaN(Float.NaN);
                                    float f22 = f18 + 0.0f;
                                    float f23 = fCos + 0.0f;
                                    float f24 = f20 + 0.0f;
                                    float f25 = f21 + 0.0f;
                                    float[] fArr4 = rVar.j;
                                    fArr4[0] = f22;
                                    fArr4[1] = f23;
                                    fArr4[2] = f24;
                                    fArr4[3] = f23;
                                    fArr4[4] = f24;
                                    fArr4[5] = f25;
                                    fArr4[6] = f22;
                                    fArr4[7] = f25;
                                    rVar.d.moveTo(f22, f23);
                                    rVar.d.lineTo(fArr4[2], fArr4[3]);
                                    rVar.d.lineTo(fArr4[4], fArr4[5]);
                                    rVar.d.lineTo(fArr4[6], fArr4[7]);
                                    rVar.d.close();
                                }
                                i5 = 0;
                                i2 = 1;
                                paint3.setColor(1140850688);
                                canvas2 = canvas;
                                canvas2.translate(2.0f, 2.0f);
                                canvas2.drawPath(rVar.d, paint3);
                                canvas2.translate(-2.0f, -2.0f);
                                paint3.setColor(-65536);
                                canvas2.drawPath(rVar.d, paint3);
                            } else {
                                canvas2 = canvas;
                                i5 = 0;
                                i2 = 1;
                            }
                            canvas3 = canvas2;
                            i7 = i5;
                            i8 = i2;
                            iM69c = i3;
                            it4 = it;
                            i10 = i4;
                        } else {
                            canvas2 = canvas3;
                            i2 = 1;
                            i3 = iM69c;
                            i4 = i10;
                            i5 = 0;
                        }
                        canvas3 = canvas2;
                        i7 = i5;
                        i8 = i2;
                        iM69c = i3;
                        it4 = it;
                        i10 = i4;
                    }
                }
                canvas.restore();
            }
        }
        ArrayList arrayList8 = this.f136f0;
        if (arrayList8 != null) {
            Iterator it7 = arrayList8.iterator();
            while (it7.hasNext()) {
                ((MotionHelper) it7.next()).getClass();
            }
        }
    }

    /* JADX INFO: renamed from: g */
    public final void m53g(View view, int i, int i2, int i3, int i4, int i5, int[] iArr) {
        if (this.f128U || i != 0 || i2 != 0) {
            iArr[0] = iArr[0] + i3;
            iArr[1] = iArr[1] + i4;
        }
        this.f128U = false;
    }

    public int[] getConstraintSetIds() {
        C0016c c0016c = this.f149s;
        if (c0016c == null) {
            return null;
        }
        SparseArray sparseArray = c0016c.f182g;
        int size = sparseArray.size();
        int[] iArr = new int[size];
        for (int i = 0; i < size; i++) {
            iArr[i] = sparseArray.keyAt(i);
        }
        return iArr;
    }

    public int getCurrentState() {
        return this.f159x;
    }

    public ArrayList<h1.x> getDefinedTransitions() {
        C0016c c0016c = this.f149s;
        if (c0016c == null) {
            return null;
        }
        return c0016c.f179d;
    }

    public h1.a getDesignTool() {
        if (this.f125R == null) {
            this.f125R = new h1.a();
        }
        return this.f125R;
    }

    public int getEndState() {
        return this.f161y;
    }

    public long getNanoTime() {
        return System.nanoTime();
    }

    public float getProgress() {
        return this.f113G;
    }

    public C0016c getScene() {
        return this.f149s;
    }

    public int getStartState() {
        return this.f157w;
    }

    public float getTargetPosition() {
        return this.f116I;
    }

    public Bundle getTransitionState() {
        if (this.f158w0 == null) {
            this.f158w0 = new C0015b(this);
        }
        C0015b c0015b = this.f158w0;
        MotionLayout motionLayout = c0015b.f175e;
        c0015b.f174d = motionLayout.f161y;
        c0015b.f173c = motionLayout.f157w;
        c0015b.f172b = motionLayout.getVelocity();
        c0015b.f171a = motionLayout.getProgress();
        C0015b c0015b2 = this.f158w0;
        c0015b2.getClass();
        Bundle bundle = new Bundle();
        bundle.putFloat("motion.progress", c0015b2.f171a);
        bundle.putFloat("motion.velocity", c0015b2.f172b);
        bundle.putInt("motion.StartState", c0015b2.f173c);
        bundle.putInt("motion.EndState", c0015b2.f174d);
        return bundle;
    }

    public long getTransitionTimeMs() {
        C0016c c0016c = this.f149s;
        if (c0016c != null) {
            this.f109E = c0016c.m69c() / 1000.0f;
        }
        return (long) (this.f109E * 1000.0f);
    }

    public float getVelocity() {
        return this.f155v;
    }

    /* JADX INFO: renamed from: h */
    public final void m54h(View view, int i, int i2, int i3, int i4, int i5) {
    }

    /* JADX INFO: renamed from: i */
    public final boolean m55i(View view, View view2, int i, int i2) {
        h1.x xVar;
        C0017d c0017d;
        C0016c c0016c = this.f149s;
        return (c0016c == null || (xVar = c0016c.f178c) == null || (c0017d = xVar.l) == null || (c0017d.f223w & 2) != 0) ? false : true;
    }

    @Override // androidx.constraintlayout.widget.ConstraintLayout
    /* JADX INFO: renamed from: m */
    public final void mo56m(int i) {
        this.f366k = null;
    }

    @Override // android.view.ViewGroup, android.view.View
    public final void onAttachedToWindow() {
        h1.x xVar;
        int i;
        super.onAttachedToWindow();
        Display display = getDisplay();
        if (display != null) {
            display.getRotation();
        }
        C0016c c0016c = this.f149s;
        if (c0016c != null && (i = this.f159x) != -1) {
            C0041d c0041dM68b = c0016c.m68b(i);
            C0016c c0016c2 = this.f149s;
            int i2 = 0;
            loop0: while (true) {
                SparseArray sparseArray = c0016c2.f182g;
                if (i2 >= sparseArray.size()) {
                    break;
                }
                int iKeyAt = sparseArray.keyAt(i2);
                SparseIntArray sparseIntArray = c0016c2.f184i;
                int i3 = sparseIntArray.get(iKeyAt);
                int size = sparseIntArray.size();
                while (true) {
                    if (i3 > 0) {
                        if (i3 != iKeyAt) {
                            int i4 = size - 1;
                            if (size >= 0) {
                                i3 = sparseIntArray.get(i3);
                                size = i4;
                            }
                        }
                        Log.e(MotionScene.TAG, "Cannot be derived from yourself");
                        break loop0;
                    }
                    c0016c2.m79m(iKeyAt, this);
                    i2++;
                }
            }
            ArrayList arrayList = this.f136f0;
            if (arrayList != null) {
                Iterator it = arrayList.iterator();
                while (it.hasNext()) {
                    ((MotionHelper) it.next()).getClass();
                }
            }
            if (c0041dM68b != null) {
                c0041dM68b.m137b(this);
            }
            this.f157w = this.f159x;
        }
        m40A();
        C0015b c0015b = this.f158w0;
        if (c0015b != null) {
            if (this.f164z0) {
                post(new h1.p(this, 1));
                return;
            } else {
                c0015b.m66a();
                return;
            }
        }
        C0016c c0016c3 = this.f149s;
        if (c0016c3 == null || (xVar = c0016c3.f178c) == null || xVar.n != 4) {
            return;
        }
        m47H();
        setState(TransitionState.SETUP);
        setState(TransitionState.MOVING);
    }

    /* JADX WARN: Code duplicated, block: B:100:0x0279  */
    /* JADX WARN: Code duplicated, block: B:102:0x027c  */
    /* JADX WARN: Code duplicated, block: B:104:0x027f  */
    /* JADX WARN: Code duplicated, block: B:105:0x0285  */
    /* JADX WARN: Code duplicated, block: B:106:0x028b  */
    /* JADX WARN: Code duplicated, block: B:107:0x0291  */
    /* JADX WARN: Code duplicated, block: B:108:0x0297  */
    /* JADX WARN: Code duplicated, block: B:109:0x029d  */
    /* JADX WARN: Code duplicated, block: B:110:0x02a3  */
    /* JADX WARN: Code duplicated, block: B:111:0x02b1  */
    /* JADX WARN: Code duplicated, block: B:113:0x02da  */
    /* JADX WARN: Code duplicated, block: B:115:0x02ed  */
    /* JADX WARN: Code duplicated, block: B:118:0x02f5  */
    /* JADX WARN: Code duplicated, block: B:121:0x02fb  */
    /* JADX WARN: Code duplicated, block: B:123:0x02ff  */
    /* JADX WARN: Code duplicated, block: B:125:0x0302  */
    /* JADX WARN: Code duplicated, block: B:128:0x0313  */
    /* JADX WARN: Code duplicated, block: B:130:0x0317  */
    /* JADX WARN: Code duplicated, block: B:134:0x0326  */
    /* JADX WARN: Code duplicated, block: B:138:0x0341  */
    /* JADX WARN: Code duplicated, block: B:144:0x0367  */
    /* JADX WARN: Code duplicated, block: B:146:0x036b  */
    /* JADX WARN: Code duplicated, block: B:150:0x0390  */
    /* JADX WARN: Code duplicated, block: B:153:0x03ae  */
    /* JADX WARN: Code duplicated, block: B:156:0x03d1 A[LOOP:7: B:154:0x03cb->B:156:0x03d1, LOOP_END] */
    /* JADX WARN: Code duplicated, block: B:159:0x03f7  */
    /* JADX WARN: Code duplicated, block: B:210:0x0107 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:212:0x00f4 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:216:0x0352 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:218:0x033b A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:63:0x00ec  */
    /* JADX WARN: Code duplicated, block: B:66:0x00fa  */
    /* JADX WARN: Code duplicated, block: B:71:0x0112  */
    /* JADX WARN: Code duplicated, block: B:74:0x011d  */
    /* JADX WARN: Code duplicated, block: B:76:0x0123  */
    /* JADX WARN: Code duplicated, block: B:78:0x0183  */
    /* JADX WARN: Code duplicated, block: B:79:0x0185  */
    /* JADX WARN: Code duplicated, block: B:82:0x01ea  */
    /* JADX WARN: Code duplicated, block: B:83:0x01ec  */
    /* JADX WARN: Code duplicated, block: B:86:0x0243  */
    /* JADX WARN: Code duplicated, block: B:89:0x0268  */
    /* JADX WARN: Code duplicated, block: B:91:0x026b A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:92:0x026d  */
    /* JADX WARN: Code duplicated, block: B:94:0x0270  */
    /* JADX WARN: Code duplicated, block: B:96:0x0273  */
    /* JADX WARN: Code duplicated, block: B:98:0x0276  */
    @Override // android.view.ViewGroup
    public final boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        C0017d c0017d;
        int i;
        RectF rectFM83b;
        MotionLayout motionLayout;
        int currentState;
        a0 a0Var;
        int i2;
        Rect rect;
        int i3;
        MotionLayout motionLayout2;
        int i4;
        View[] viewArr;
        int i5;
        h1.g gVar;
        C0040c c0040c;
        HashMap map;
        C0040c c0040cM144l;
        h1.x xVar;
        int i6;
        int id;
        h1.g gVar2;
        Iterator it;
        j1.f fVar;
        C0040c c0040c2;
        int i7;
        C0016c c0016c;
        C0041d c0041dM68b;
        C0040c c0040cM144l2;
        j1.f fVar2;
        View view;
        n nVar;
        float alpha;
        float alpha2;
        ArrayList arrayList;
        Context context;
        int i8;
        Interpolator interpolatorLoadInterpolator;
        int i9 = 2;
        int i10 = 1;
        C0016c c0016c2 = this.f149s;
        if (c0016c2 == null || !this.f103B) {
            return false;
        }
        as.c cVar = c0016c2.f192q;
        if (cVar != null && (currentState = (motionLayout = (MotionLayout) cVar.b).getCurrentState()) != -1) {
            HashSet hashSet = (HashSet) cVar.d;
            ArrayList<a0> arrayList2 = (ArrayList) cVar.c;
            if (hashSet == null) {
                cVar.d = new HashSet();
                for (a0 a0Var2 : arrayList2) {
                    int childCount = motionLayout.getChildCount();
                    for (int i11 = 0; i11 < childCount; i11++) {
                        View childAt = motionLayout.getChildAt(i11);
                        if (a0Var2.a(childAt)) {
                            childAt.getId();
                            ((HashSet) cVar.d).add(childAt);
                        }
                    }
                }
            }
            float x = motionEvent.getX();
            float y = motionEvent.getY();
            Rect rect2 = new Rect();
            int action = motionEvent.getAction();
            ArrayList arrayList3 = (ArrayList) cVar.e;
            if (arrayList3 != null && !arrayList3.isEmpty()) {
                for (z zVar : (ArrayList) cVar.e) {
                    if (action != 1) {
                        if (action != 2) {
                            zVar.getClass();
                        } else {
                            View view2 = zVar.c.b;
                            Rect rect3 = zVar.l;
                            view2.getHitRect(rect3);
                            if (!rect3.contains((int) x, (int) y) && !zVar.h) {
                                zVar.b();
                            }
                        }
                    } else if (!zVar.h) {
                        zVar.b();
                    }
                }
            }
            if (action == 0 || action == 1) {
                C0016c c0016c3 = motionLayout.f149s;
                C0041d c0041dM68b2 = c0016c3 == null ? null : c0016c3.m68b(currentState);
                Iterator it2 = arrayList2.iterator();
                while (it2.hasNext()) {
                    a0 a0Var3 = (a0) it2.next();
                    int i12 = a0Var3.b;
                    if (i12 == i10) {
                        if (action == 0) {
                            for (View view3 : (HashSet) cVar.d) {
                                if (a0Var3.a(view3)) {
                                    view3.getHitRect(rect2);
                                    if (rect2.contains((int) x, (int) y)) {
                                        viewArr = new View[i10];
                                        viewArr[0] = view3;
                                        if (a0Var3.c) {
                                            a0Var = a0Var3;
                                            i2 = action;
                                            rect = rect2;
                                            i3 = currentState;
                                            motionLayout2 = motionLayout;
                                            i4 = i10;
                                        } else {
                                            i5 = a0Var3.e;
                                            gVar = a0Var3.f;
                                            if (i5 == i9) {
                                                view = viewArr[0];
                                                nVar = new n(view);
                                                v vVar = nVar.f;
                                                vVar.c = 0.0f;
                                                vVar.d = 0.0f;
                                                nVar.G = true;
                                                int i13 = action;
                                                Rect rect4 = rect2;
                                                vVar.f(view.getX(), view.getY(), view.getWidth(), view.getHeight());
                                                nVar.g.f(view.getX(), view.getY(), view.getWidth(), view.getHeight());
                                                l lVar = nVar.h;
                                                lVar.getClass();
                                                view.getX();
                                                view.getY();
                                                view.getWidth();
                                                view.getHeight();
                                                lVar.c = view.getVisibility();
                                                if (view.getVisibility() != 0) {
                                                    alpha = 0.0f;
                                                } else {
                                                    alpha = view.getAlpha();
                                                }
                                                lVar.a = alpha;
                                                lVar.d = view.getElevation();
                                                lVar.e = view.getRotation();
                                                lVar.f = view.getRotationX();
                                                lVar.g = view.getRotationY();
                                                lVar.h = view.getScaleX();
                                                lVar.i = view.getScaleY();
                                                lVar.j = view.getPivotX();
                                                lVar.k = view.getPivotY();
                                                lVar.l = view.getTranslationX();
                                                lVar.m = view.getTranslationY();
                                                lVar.n = view.getTranslationZ();
                                                l lVar2 = nVar.i;
                                                lVar2.getClass();
                                                view.getX();
                                                view.getY();
                                                view.getWidth();
                                                view.getHeight();
                                                lVar2.c = view.getVisibility();
                                                if (view.getVisibility() != 0) {
                                                    alpha2 = 0.0f;
                                                } else {
                                                    alpha2 = view.getAlpha();
                                                }
                                                lVar2.a = alpha2;
                                                lVar2.d = view.getElevation();
                                                lVar2.e = view.getRotation();
                                                lVar2.f = view.getRotationX();
                                                lVar2.g = view.getRotationY();
                                                lVar2.h = view.getScaleX();
                                                lVar2.i = view.getScaleY();
                                                lVar2.j = view.getPivotX();
                                                lVar2.k = view.getPivotY();
                                                lVar2.l = view.getTranslationX();
                                                lVar2.m = view.getTranslationY();
                                                lVar2.n = view.getTranslationZ();
                                                arrayList = (ArrayList) gVar.a.get(-1);
                                                if (arrayList != null) {
                                                    nVar.w.addAll(arrayList);
                                                }
                                                nVar.h(motionLayout.getWidth(), motionLayout.getHeight(), System.nanoTime());
                                                int i14 = a0Var3.h;
                                                int i15 = a0Var3.i;
                                                int i16 = a0Var3.b;
                                                context = motionLayout.getContext();
                                                i8 = a0Var3.l;
                                                if (i8 == -2) {
                                                    interpolatorLoadInterpolator = AnimationUtils.loadInterpolator(context, a0Var3.n);
                                                } else if (i8 == -1) {
                                                    interpolatorLoadInterpolator = new m(e.d(a0Var3.m), 2);
                                                } else if (i8 == 0) {
                                                    interpolatorLoadInterpolator = new AccelerateDecelerateInterpolator();
                                                } else if (i8 == 1) {
                                                    interpolatorLoadInterpolator = new AccelerateInterpolator();
                                                } else if (i8 == 2) {
                                                    interpolatorLoadInterpolator = new android.view.animation.DecelerateInterpolator();
                                                } else if (i8 == 4) {
                                                    interpolatorLoadInterpolator = new BounceInterpolator();
                                                } else if (i8 == 5) {
                                                    interpolatorLoadInterpolator = new OvershootInterpolator();
                                                } else if (i8 != 6) {
                                                    interpolatorLoadInterpolator = null;
                                                } else {
                                                    interpolatorLoadInterpolator = new AnticipateInterpolator();
                                                }
                                                as.c cVar2 = cVar;
                                                a0Var = a0Var3;
                                                i2 = i13;
                                                rect = rect4;
                                                new z(cVar2, nVar, i14, i15, i16, interpolatorLoadInterpolator, a0Var3.p, a0Var3.q);
                                                i3 = currentState;
                                                motionLayout2 = motionLayout;
                                                i4 = 1;
                                            } else {
                                                a0Var = a0Var3;
                                                i2 = action;
                                                rect = rect2;
                                                i3 = currentState;
                                                motionLayout2 = motionLayout;
                                                c0040c = a0Var.g;
                                                if (i5 == 1) {
                                                    for (int i17 : motionLayout2.getConstraintSetIds()) {
                                                        if (i17 != i3) {
                                                            c0016c = motionLayout2.f149s;
                                                            if (c0016c == null) {
                                                                c0041dM68b = null;
                                                            } else {
                                                                c0041dM68b = c0016c.m68b(i17);
                                                            }
                                                            c0040cM144l2 = c0041dM68b.m144l(viewArr[0].getId());
                                                            if (c0040c != null) {
                                                                fVar2 = c0040c.f547h;
                                                                if (fVar2 != null) {
                                                                    fVar2.e(c0040cM144l2);
                                                                }
                                                                c0040cM144l2.f546g.putAll(c0040c.f546g);
                                                            }
                                                        }
                                                    }
                                                    i4 = 1;
                                                } else {
                                                    i4 = 1;
                                                }
                                                C0041d c0041d = new C0041d();
                                                map = c0041d.f556f;
                                                map.clear();
                                                for (Integer num : c0041dM68b2.f556f.keySet()) {
                                                    c0040c2 = (C0040c) c0041dM68b2.f556f.get(num);
                                                    if (c0040c2 != null) {
                                                        map.put(num, c0040c2.clone());
                                                    }
                                                }
                                                c0040cM144l = c0041d.m144l(viewArr[0].getId());
                                                if (c0040c != null) {
                                                    fVar = c0040c.f547h;
                                                    if (fVar != null) {
                                                        fVar.e(c0040cM144l);
                                                    }
                                                    c0040cM144l.f546g.putAll(c0040c.f546g);
                                                }
                                                motionLayout2.m49J(i3, c0041d);
                                                motionLayout2.m49J(C0037R.id.view_transition, c0041dM68b2);
                                                motionLayout2.m44E(C0037R.id.view_transition);
                                                xVar = new h1.x(motionLayout2.f149s, i3);
                                                View view4 = viewArr[0];
                                                i6 = a0Var.h;
                                                if (i6 != -1) {
                                                    xVar.h = Math.max(i6, 8);
                                                }
                                                xVar.p = a0Var.d;
                                                int i18 = a0Var.l;
                                                String str = a0Var.m;
                                                int i19 = a0Var.n;
                                                xVar.e = i18;
                                                xVar.f = str;
                                                xVar.g = i19;
                                                id = view4.getId();
                                                if (gVar != null) {
                                                    ArrayList arrayList4 = (ArrayList) gVar.a.get(-1);
                                                    gVar2 = new h1.g();
                                                    gVar2.a = new HashMap();
                                                    it = arrayList4.iterator();
                                                    while (it.hasNext()) {
                                                        h1.c cVarA = ((h1.c) it.next()).a();
                                                        cVarA.b = id;
                                                        gVar2.b(cVarA);
                                                    }
                                                    xVar.k.add(gVar2);
                                                }
                                                motionLayout2.setTransition(xVar);
                                                com.vungle.ads.internal.util.d dVar = new com.vungle.ads.internal.util.d(4, a0Var, viewArr);
                                                motionLayout2.m57r(1.0f);
                                                motionLayout2.f160x0 = dVar;
                                            }
                                        }
                                    } else {
                                        a0Var = a0Var3;
                                        i2 = action;
                                        rect = rect2;
                                        i3 = currentState;
                                        motionLayout2 = motionLayout;
                                        i4 = i10;
                                    }
                                    x = x;
                                    a0Var3 = a0Var;
                                    motionLayout = motionLayout2;
                                    currentState = i3;
                                    i10 = i4;
                                    action = i2;
                                    it2 = it2;
                                    rect2 = rect;
                                    y = y;
                                    cVar = cVar;
                                    i9 = 2;
                                }
                            }
                        }
                    } else if (i12 == i9) {
                        if (action == i10) {
                            while (r16.hasNext()) {
                                if (a0Var3.a(view3)) {
                                    view3.getHitRect(rect2);
                                    if (rect2.contains((int) x, (int) y)) {
                                        viewArr = new View[i10];
                                        viewArr[0] = view3;
                                        if (a0Var3.c) {
                                            a0Var = a0Var3;
                                            i2 = action;
                                            rect = rect2;
                                            i3 = currentState;
                                            motionLayout2 = motionLayout;
                                            i4 = i10;
                                        } else {
                                            i5 = a0Var3.e;
                                            gVar = a0Var3.f;
                                            if (i5 == i9) {
                                                view = viewArr[0];
                                                nVar = new n(view);
                                                v vVar2 = nVar.f;
                                                vVar2.c = 0.0f;
                                                vVar2.d = 0.0f;
                                                nVar.G = true;
                                                int i110 = action;
                                                Rect rect5 = rect2;
                                                vVar2.f(view.getX(), view.getY(), view.getWidth(), view.getHeight());
                                                nVar.g.f(view.getX(), view.getY(), view.getWidth(), view.getHeight());
                                                l lVar3 = nVar.h;
                                                lVar3.getClass();
                                                view.getX();
                                                view.getY();
                                                view.getWidth();
                                                view.getHeight();
                                                lVar3.c = view.getVisibility();
                                                if (view.getVisibility() != 0) {
                                                    alpha = 0.0f;
                                                } else {
                                                    alpha = view.getAlpha();
                                                }
                                                lVar3.a = alpha;
                                                lVar3.d = view.getElevation();
                                                lVar3.e = view.getRotation();
                                                lVar3.f = view.getRotationX();
                                                lVar3.g = view.getRotationY();
                                                lVar3.h = view.getScaleX();
                                                lVar3.i = view.getScaleY();
                                                lVar3.j = view.getPivotX();
                                                lVar3.k = view.getPivotY();
                                                lVar3.l = view.getTranslationX();
                                                lVar3.m = view.getTranslationY();
                                                lVar3.n = view.getTranslationZ();
                                                l lVar4 = nVar.i;
                                                lVar4.getClass();
                                                view.getX();
                                                view.getY();
                                                view.getWidth();
                                                view.getHeight();
                                                lVar4.c = view.getVisibility();
                                                if (view.getVisibility() != 0) {
                                                    alpha2 = 0.0f;
                                                } else {
                                                    alpha2 = view.getAlpha();
                                                }
                                                lVar4.a = alpha2;
                                                lVar4.d = view.getElevation();
                                                lVar4.e = view.getRotation();
                                                lVar4.f = view.getRotationX();
                                                lVar4.g = view.getRotationY();
                                                lVar4.h = view.getScaleX();
                                                lVar4.i = view.getScaleY();
                                                lVar4.j = view.getPivotX();
                                                lVar4.k = view.getPivotY();
                                                lVar4.l = view.getTranslationX();
                                                lVar4.m = view.getTranslationY();
                                                lVar4.n = view.getTranslationZ();
                                                arrayList = (ArrayList) gVar.a.get(-1);
                                                if (arrayList != null) {
                                                    nVar.w.addAll(arrayList);
                                                }
                                                nVar.h(motionLayout.getWidth(), motionLayout.getHeight(), System.nanoTime());
                                                int i111 = a0Var3.h;
                                                int i112 = a0Var3.i;
                                                int i113 = a0Var3.b;
                                                context = motionLayout.getContext();
                                                i8 = a0Var3.l;
                                                if (i8 == -2) {
                                                    interpolatorLoadInterpolator = AnimationUtils.loadInterpolator(context, a0Var3.n);
                                                } else if (i8 == -1) {
                                                    interpolatorLoadInterpolator = new m(e.d(a0Var3.m), 2);
                                                } else if (i8 == 0) {
                                                    interpolatorLoadInterpolator = new AccelerateDecelerateInterpolator();
                                                } else if (i8 == 1) {
                                                    interpolatorLoadInterpolator = new AccelerateInterpolator();
                                                } else if (i8 == 2) {
                                                    interpolatorLoadInterpolator = new android.view.animation.DecelerateInterpolator();
                                                } else if (i8 == 4) {
                                                    interpolatorLoadInterpolator = new BounceInterpolator();
                                                } else if (i8 == 5) {
                                                    interpolatorLoadInterpolator = new OvershootInterpolator();
                                                } else if (i8 != 6) {
                                                    interpolatorLoadInterpolator = null;
                                                } else {
                                                    interpolatorLoadInterpolator = new AnticipateInterpolator();
                                                }
                                                as.c cVar3 = cVar;
                                                a0Var = a0Var3;
                                                i2 = i110;
                                                rect = rect5;
                                                new z(cVar3, nVar, i111, i112, i113, interpolatorLoadInterpolator, a0Var3.p, a0Var3.q);
                                                i3 = currentState;
                                                motionLayout2 = motionLayout;
                                                i4 = 1;
                                            } else {
                                                a0Var = a0Var3;
                                                i2 = action;
                                                rect = rect2;
                                                i3 = currentState;
                                                motionLayout2 = motionLayout;
                                                c0040c = a0Var.g;
                                                if (i5 == 1) {
                                                    while (i7 < r7.length) {
                                                        if (i17 != i3) {
                                                            c0016c = motionLayout2.f149s;
                                                            if (c0016c == null) {
                                                                c0041dM68b = null;
                                                            } else {
                                                                c0041dM68b = c0016c.m68b(i17);
                                                            }
                                                            c0040cM144l2 = c0041dM68b.m144l(viewArr[0].getId());
                                                            if (c0040c != null) {
                                                                fVar2 = c0040c.f547h;
                                                                if (fVar2 != null) {
                                                                    fVar2.e(c0040cM144l2);
                                                                }
                                                                c0040cM144l2.f546g.putAll(c0040c.f546g);
                                                            }
                                                        }
                                                    }
                                                    i4 = 1;
                                                } else {
                                                    i4 = 1;
                                                }
                                                C0041d c0041d2 = new C0041d();
                                                map = c0041d2.f556f;
                                                map.clear();
                                                while (r12.hasNext()) {
                                                    c0040c2 = (C0040c) c0041dM68b2.f556f.get(num);
                                                    if (c0040c2 != null) {
                                                        map.put(num, c0040c2.clone());
                                                    }
                                                }
                                                c0040cM144l = c0041d2.m144l(viewArr[0].getId());
                                                if (c0040c != null) {
                                                    fVar = c0040c.f547h;
                                                    if (fVar != null) {
                                                        fVar.e(c0040cM144l);
                                                    }
                                                    c0040cM144l.f546g.putAll(c0040c.f546g);
                                                }
                                                motionLayout2.m49J(i3, c0041d2);
                                                motionLayout2.m49J(C0037R.id.view_transition, c0041dM68b2);
                                                motionLayout2.m44E(C0037R.id.view_transition);
                                                xVar = new h1.x(motionLayout2.f149s, i3);
                                                View view5 = viewArr[0];
                                                i6 = a0Var.h;
                                                if (i6 != -1) {
                                                    xVar.h = Math.max(i6, 8);
                                                }
                                                xVar.p = a0Var.d;
                                                int i114 = a0Var.l;
                                                String str2 = a0Var.m;
                                                int i115 = a0Var.n;
                                                xVar.e = i114;
                                                xVar.f = str2;
                                                xVar.g = i115;
                                                id = view5.getId();
                                                if (gVar != null) {
                                                    ArrayList arrayList5 = (ArrayList) gVar.a.get(-1);
                                                    gVar2 = new h1.g();
                                                    gVar2.a = new HashMap();
                                                    it = arrayList5.iterator();
                                                    while (it.hasNext()) {
                                                        h1.c cVarA2 = ((h1.c) it.next()).a();
                                                        cVarA2.b = id;
                                                        gVar2.b(cVarA2);
                                                    }
                                                    xVar.k.add(gVar2);
                                                }
                                                motionLayout2.setTransition(xVar);
                                                com.vungle.ads.internal.util.d dVar2 = new com.vungle.ads.internal.util.d(4, a0Var, viewArr);
                                                motionLayout2.m57r(1.0f);
                                                motionLayout2.f160x0 = dVar2;
                                            }
                                        }
                                    } else {
                                        a0Var = a0Var3;
                                        i2 = action;
                                        rect = rect2;
                                        i3 = currentState;
                                        motionLayout2 = motionLayout;
                                        i4 = i10;
                                    }
                                    x = x;
                                    a0Var3 = a0Var;
                                    motionLayout = motionLayout2;
                                    currentState = i3;
                                    i10 = i4;
                                    action = i2;
                                    it2 = it2;
                                    rect2 = rect;
                                    y = y;
                                    cVar = cVar;
                                    i9 = 2;
                                }
                            }
                        }
                    } else if (i12 == 3 && action == 0) {
                        while (r16.hasNext()) {
                            if (a0Var3.a(view3)) {
                                view3.getHitRect(rect2);
                                if (rect2.contains((int) x, (int) y)) {
                                    viewArr = new View[i10];
                                    viewArr[0] = view3;
                                    if (a0Var3.c) {
                                        a0Var = a0Var3;
                                        i2 = action;
                                        rect = rect2;
                                        i3 = currentState;
                                        motionLayout2 = motionLayout;
                                        i4 = i10;
                                    } else {
                                        i5 = a0Var3.e;
                                        gVar = a0Var3.f;
                                        if (i5 == i9) {
                                            view = viewArr[0];
                                            nVar = new n(view);
                                            v vVar3 = nVar.f;
                                            vVar3.c = 0.0f;
                                            vVar3.d = 0.0f;
                                            nVar.G = true;
                                            int i116 = action;
                                            Rect rect6 = rect2;
                                            vVar3.f(view.getX(), view.getY(), view.getWidth(), view.getHeight());
                                            nVar.g.f(view.getX(), view.getY(), view.getWidth(), view.getHeight());
                                            l lVar5 = nVar.h;
                                            lVar5.getClass();
                                            view.getX();
                                            view.getY();
                                            view.getWidth();
                                            view.getHeight();
                                            lVar5.c = view.getVisibility();
                                            if (view.getVisibility() != 0) {
                                                alpha = 0.0f;
                                            } else {
                                                alpha = view.getAlpha();
                                            }
                                            lVar5.a = alpha;
                                            lVar5.d = view.getElevation();
                                            lVar5.e = view.getRotation();
                                            lVar5.f = view.getRotationX();
                                            lVar5.g = view.getRotationY();
                                            lVar5.h = view.getScaleX();
                                            lVar5.i = view.getScaleY();
                                            lVar5.j = view.getPivotX();
                                            lVar5.k = view.getPivotY();
                                            lVar5.l = view.getTranslationX();
                                            lVar5.m = view.getTranslationY();
                                            lVar5.n = view.getTranslationZ();
                                            l lVar6 = nVar.i;
                                            lVar6.getClass();
                                            view.getX();
                                            view.getY();
                                            view.getWidth();
                                            view.getHeight();
                                            lVar6.c = view.getVisibility();
                                            if (view.getVisibility() != 0) {
                                                alpha2 = 0.0f;
                                            } else {
                                                alpha2 = view.getAlpha();
                                            }
                                            lVar6.a = alpha2;
                                            lVar6.d = view.getElevation();
                                            lVar6.e = view.getRotation();
                                            lVar6.f = view.getRotationX();
                                            lVar6.g = view.getRotationY();
                                            lVar6.h = view.getScaleX();
                                            lVar6.i = view.getScaleY();
                                            lVar6.j = view.getPivotX();
                                            lVar6.k = view.getPivotY();
                                            lVar6.l = view.getTranslationX();
                                            lVar6.m = view.getTranslationY();
                                            lVar6.n = view.getTranslationZ();
                                            arrayList = (ArrayList) gVar.a.get(-1);
                                            if (arrayList != null) {
                                                nVar.w.addAll(arrayList);
                                            }
                                            nVar.h(motionLayout.getWidth(), motionLayout.getHeight(), System.nanoTime());
                                            int i117 = a0Var3.h;
                                            int i118 = a0Var3.i;
                                            int i119 = a0Var3.b;
                                            context = motionLayout.getContext();
                                            i8 = a0Var3.l;
                                            if (i8 == -2) {
                                                interpolatorLoadInterpolator = AnimationUtils.loadInterpolator(context, a0Var3.n);
                                            } else if (i8 == -1) {
                                                interpolatorLoadInterpolator = new m(e.d(a0Var3.m), 2);
                                            } else if (i8 == 0) {
                                                interpolatorLoadInterpolator = new AccelerateDecelerateInterpolator();
                                            } else if (i8 == 1) {
                                                interpolatorLoadInterpolator = new AccelerateInterpolator();
                                            } else if (i8 == 2) {
                                                interpolatorLoadInterpolator = new android.view.animation.DecelerateInterpolator();
                                            } else if (i8 == 4) {
                                                interpolatorLoadInterpolator = new BounceInterpolator();
                                            } else if (i8 == 5) {
                                                interpolatorLoadInterpolator = new OvershootInterpolator();
                                            } else if (i8 != 6) {
                                                interpolatorLoadInterpolator = null;
                                            } else {
                                                interpolatorLoadInterpolator = new AnticipateInterpolator();
                                            }
                                            as.c cVar4 = cVar;
                                            a0Var = a0Var3;
                                            i2 = i116;
                                            rect = rect6;
                                            new z(cVar4, nVar, i117, i118, i119, interpolatorLoadInterpolator, a0Var3.p, a0Var3.q);
                                            i3 = currentState;
                                            motionLayout2 = motionLayout;
                                            i4 = 1;
                                        } else {
                                            a0Var = a0Var3;
                                            i2 = action;
                                            rect = rect2;
                                            i3 = currentState;
                                            motionLayout2 = motionLayout;
                                            c0040c = a0Var.g;
                                            if (i5 == 1) {
                                                while (i7 < r7.length) {
                                                    if (i17 != i3) {
                                                        c0016c = motionLayout2.f149s;
                                                        if (c0016c == null) {
                                                            c0041dM68b = null;
                                                        } else {
                                                            c0041dM68b = c0016c.m68b(i17);
                                                        }
                                                        c0040cM144l2 = c0041dM68b.m144l(viewArr[0].getId());
                                                        if (c0040c != null) {
                                                            fVar2 = c0040c.f547h;
                                                            if (fVar2 != null) {
                                                                fVar2.e(c0040cM144l2);
                                                            }
                                                            c0040cM144l2.f546g.putAll(c0040c.f546g);
                                                        }
                                                    }
                                                }
                                                i4 = 1;
                                            } else {
                                                i4 = 1;
                                            }
                                            C0041d c0041d3 = new C0041d();
                                            map = c0041d3.f556f;
                                            map.clear();
                                            while (r12.hasNext()) {
                                                c0040c2 = (C0040c) c0041dM68b2.f556f.get(num);
                                                if (c0040c2 != null) {
                                                    map.put(num, c0040c2.clone());
                                                }
                                            }
                                            c0040cM144l = c0041d3.m144l(viewArr[0].getId());
                                            if (c0040c != null) {
                                                fVar = c0040c.f547h;
                                                if (fVar != null) {
                                                    fVar.e(c0040cM144l);
                                                }
                                                c0040cM144l.f546g.putAll(c0040c.f546g);
                                            }
                                            motionLayout2.m49J(i3, c0041d3);
                                            motionLayout2.m49J(C0037R.id.view_transition, c0041dM68b2);
                                            motionLayout2.m44E(C0037R.id.view_transition);
                                            xVar = new h1.x(motionLayout2.f149s, i3);
                                            View view6 = viewArr[0];
                                            i6 = a0Var.h;
                                            if (i6 != -1) {
                                                xVar.h = Math.max(i6, 8);
                                            }
                                            xVar.p = a0Var.d;
                                            int i1110 = a0Var.l;
                                            String str3 = a0Var.m;
                                            int i1111 = a0Var.n;
                                            xVar.e = i1110;
                                            xVar.f = str3;
                                            xVar.g = i1111;
                                            id = view6.getId();
                                            if (gVar != null) {
                                                ArrayList arrayList6 = (ArrayList) gVar.a.get(-1);
                                                gVar2 = new h1.g();
                                                gVar2.a = new HashMap();
                                                it = arrayList6.iterator();
                                                while (it.hasNext()) {
                                                    h1.c cVarA3 = ((h1.c) it.next()).a();
                                                    cVarA3.b = id;
                                                    gVar2.b(cVarA3);
                                                }
                                                xVar.k.add(gVar2);
                                            }
                                            motionLayout2.setTransition(xVar);
                                            com.vungle.ads.internal.util.d dVar3 = new com.vungle.ads.internal.util.d(4, a0Var, viewArr);
                                            motionLayout2.m57r(1.0f);
                                            motionLayout2.f160x0 = dVar3;
                                        }
                                    }
                                } else {
                                    a0Var = a0Var3;
                                    i2 = action;
                                    rect = rect2;
                                    i3 = currentState;
                                    motionLayout2 = motionLayout;
                                    i4 = i10;
                                }
                                x = x;
                                a0Var3 = a0Var;
                                motionLayout = motionLayout2;
                                currentState = i3;
                                i10 = i4;
                                action = i2;
                                it2 = it2;
                                rect2 = rect;
                                y = y;
                                cVar = cVar;
                                i9 = 2;
                            }
                        }
                    }
                    x = x;
                    motionLayout = motionLayout;
                    currentState = currentState;
                    i10 = i10;
                    action = action;
                    it2 = it2;
                    rect2 = rect2;
                    y = y;
                    cVar = cVar;
                    i9 = 2;
                }
            }
        }
        h1.x xVar2 = this.f149s.f178c;
        if (xVar2 != null && !xVar2.o && (c0017d = xVar2.l) != null && ((motionEvent.getAction() != 0 || (rectFM83b = c0017d.m83b(this, new RectF())) == null || rectFM83b.contains(motionEvent.getX(), motionEvent.getY())) && (i = c0017d.f205e) != -1)) {
            View view7 = this.f110E0;
            if (view7 == null || view7.getId() != i) {
                this.f110E0 = findViewById(i);
            }
            View view8 = this.f110E0;
            if (view8 != null) {
                RectF rectF = this.f108D0;
                rectF.set(view8.getLeft(), this.f110E0.getTop(), this.f110E0.getRight(), this.f110E0.getBottom());
                if (rectF.contains(motionEvent.getX(), motionEvent.getY()) && !m64y(this.f110E0.getLeft(), this.f110E0.getTop(), this.f110E0, motionEvent)) {
                    return onTouchEvent(motionEvent);
                }
            }
        }
        return false;
    }

    @Override // androidx.constraintlayout.widget.ConstraintLayout, android.view.ViewGroup, android.view.View
    public final void onLayout(boolean z, int i, int i2, int i3, int i4) {
        this.f156v0 = true;
        try {
            if (this.f149s == null) {
                super.onLayout(z, i, i2, i3, i4);
                return;
            }
            int i5 = i3 - i;
            int i6 = i4 - i2;
            if (this.f126S != i5 || this.f127T != i6) {
                m42C();
                m59t(true);
            }
            this.f126S = i5;
            this.f127T = i6;
        } finally {
            this.f156v0 = false;
        }
    }

    @Override // androidx.constraintlayout.widget.ConstraintLayout, android.view.View
    public final void onMeasure(int i, int i2) {
        boolean z;
        if (this.f149s == null) {
            super.onMeasure(i, i2);
            return;
        }
        boolean z2 = true;
        boolean z3 = (this.f163z == i && this.f101A == i2) ? false : true;
        if (this.f106C0) {
            this.f106C0 = false;
            m40A();
            m41B();
            z3 = true;
        }
        if (this.f363h) {
            z3 = true;
        }
        this.f163z = i;
        this.f101A = i2;
        int iM74h = this.f149s.m74h();
        h1.x xVar = this.f149s.f178c;
        int i3 = xVar == null ? -1 : xVar.c;
        d1.g gVar = this.f358c;
        s sVar = this.f104B0;
        if ((!z3 && iM74h == sVar.e && i3 == sVar.f) || this.f157w == -1) {
            if (z3) {
                super.onMeasure(i, i2);
            }
            z = true;
        } else {
            super.onMeasure(i, i2);
            sVar.e(this.f149s.m68b(iM74h), this.f149s.m68b(i3));
            sVar.f();
            sVar.e = iM74h;
            sVar.f = i3;
            z = false;
        }
        if (this.f143m0 || z) {
            int paddingBottom = getPaddingBottom() + getPaddingTop();
            int iR = gVar.r() + getPaddingRight() + getPaddingLeft();
            int iL = gVar.l() + paddingBottom;
            int i4 = this.f148r0;
            if (i4 == Integer.MIN_VALUE || i4 == 0) {
                int i5 = this.f144n0;
                iR = (int) ((this.f152t0 * (this.f146p0 - i5)) + i5);
                requestLayout();
            }
            int i6 = this.f150s0;
            if (i6 == Integer.MIN_VALUE || i6 == 0) {
                int i7 = this.f145o0;
                iL = (int) ((this.f152t0 * (this.f147q0 - i7)) + i7);
                requestLayout();
            }
            setMeasuredDimension(iR, iL);
        }
        float fSignum = Math.signum(this.f116I - this.f113G);
        long nanoTime = getNanoTime();
        o oVar = this.f151t;
        float interpolation = this.f113G + (!(oVar instanceof g1.b) ? (((nanoTime - this.f115H) * fSignum) * 1.0E-9f) / this.f109E : 0.0f);
        if (this.f117J) {
            interpolation = this.f116I;
        }
        if ((fSignum <= 0.0f || interpolation < this.f116I) && (fSignum > 0.0f || interpolation > this.f116I)) {
            z2 = false;
        } else {
            interpolation = this.f116I;
        }
        if (oVar != null && !z2) {
            interpolation = this.f122O ? oVar.getInterpolation((nanoTime - this.f107D) * 1.0E-9f) : oVar.getInterpolation(interpolation);
        }
        if ((fSignum > 0.0f && interpolation >= this.f116I) || (fSignum <= 0.0f && interpolation <= this.f116I)) {
            interpolation = this.f116I;
        }
        this.f152t0 = interpolation;
        int childCount = getChildCount();
        long nanoTime2 = getNanoTime();
        Interpolator interpolator = this.f153u;
        if (interpolator != null) {
            interpolation = interpolator.getInterpolation(interpolation);
        }
        for (int i8 = 0; i8 < childCount; i8++) {
            View childAt = getChildAt(i8);
            n nVar = (n) this.f105C.get(childAt);
            if (nVar != null) {
                nVar.e(interpolation, nanoTime2, childAt, this.f154u0);
            }
        }
        if (this.f143m0) {
            requestLayout();
        }
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public final boolean onNestedFling(View view, float f, float f2, boolean z) {
        return false;
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public final boolean onNestedPreFling(View view, float f, float f2) {
        return false;
    }

    @Override // android.view.View
    public final void onRtlPropertiesChanged(int i) {
        C0017d c0017d;
        C0016c c0016c = this.f149s;
        if (c0016c != null) {
            boolean zM112l = m112l();
            c0016c.f191p = zM112l;
            h1.x xVar = c0016c.f178c;
            if (xVar == null || (c0017d = xVar.l) == null) {
                return;
            }
            c0017d.m84c(zM112l);
        }
    }

    /* JADX WARN: Code duplicated, block: B:110:0x022a  */
    /* JADX WARN: Code duplicated, block: B:113:0x0230  */
    /* JADX WARN: Code duplicated, block: B:115:0x0234  */
    /* JADX WARN: Code duplicated, block: B:199:0x04bf  */
    /* JADX WARN: Code duplicated, block: B:200:0x04e2  */
    /* JADX WARN: Code duplicated, block: B:203:0x04fe  */
    /* JADX WARN: Code duplicated, block: B:205:0x050c  */
    /* JADX WARN: Code duplicated, block: B:233:0x056d  */
    /* JADX WARN: Code duplicated, block: B:235:0x0572  */
    /* JADX WARN: Code duplicated, block: B:237:0x0578  */
    /* JADX WARN: Code duplicated, block: B:356:0x079c  */
    /* JADX WARN: Code duplicated, block: B:359:0x07b3  */
    /* JADX WARN: Code duplicated, block: B:368:0x07d0  */
    @Override // android.view.View
    public final boolean onTouchEvent(MotionEvent motionEvent) {
        h1.x xVar;
        t tVar;
        t tVar2;
        C0017d c0017d;
        char c;
        char c2;
        int i;
        char c3;
        char c4;
        char c5;
        float right;
        float f;
        int top;
        int bottom;
        int i2;
        float degrees;
        float f2;
        int i3;
        MotionLayout motionLayout;
        char c6;
        MotionEvent motionEvent2;
        RectF rectF;
        h1.x xVar2;
        int iT;
        Iterator it;
        MotionLayout motionLayout2 = this;
        C0016c c0016c = motionLayout2.f149s;
        if (c0016c == null || !motionLayout2.f103B || !c0016c.m81o()) {
            return super.onTouchEvent(motionEvent);
        }
        C0016c c0016c2 = motionLayout2.f149s;
        h1.x xVar3 = c0016c2.f178c;
        if (xVar3 != null && xVar3.o) {
            return super.onTouchEvent(motionEvent);
        }
        int currentState = getCurrentState();
        RectF rectF2 = new RectF();
        t tVar3 = c0016c2.f190o;
        MotionLayout motionLayout3 = c0016c2.f176a;
        if (tVar3 == null) {
            motionLayout3.getClass();
            t tVar4 = t.b;
            tVar4.a = VelocityTracker.obtain();
            c0016c2.f190o = tVar4;
        }
        VelocityTracker velocityTracker = c0016c2.f190o.a;
        if (velocityTracker != null) {
            velocityTracker.addMovement(motionEvent);
        }
        if (currentState != -1) {
            int action = motionEvent.getAction();
            if (action == 0) {
                c0016c2.f193r = motionEvent.getRawX();
                c0016c2.f194s = motionEvent.getRawY();
                c0016c2.f187l = motionEvent;
                c0016c2.f188m = false;
                C0017d c0017d2 = c0016c2.f178c.l;
                if (c0017d2 != null) {
                    RectF rectFM82a = c0017d2.m82a(motionLayout3, rectF2);
                    if (rectFM82a == null || rectFM82a.contains(c0016c2.f187l.getX(), c0016c2.f187l.getY())) {
                        RectF rectFM83b = c0016c2.f178c.l.m83b(motionLayout3, rectF2);
                        if (rectFM83b == null || rectFM83b.contains(c0016c2.f187l.getX(), c0016c2.f187l.getY())) {
                            c0016c2.f189n = false;
                        } else {
                            c0016c2.f189n = true;
                        }
                        C0017d c0017d3 = c0016c2.f178c.l;
                        float f3 = c0016c2.f193r;
                        float f4 = c0016c2.f194s;
                        c0017d3.f216p = f3;
                        c0017d3.f217q = f4;
                    } else {
                        c0016c2.f187l = null;
                        c0016c2.f188m = true;
                    }
                }
            } else if (action == 2 && !c0016c2.f188m) {
                float rawY = motionEvent.getRawY() - c0016c2.f194s;
                float rawX = motionEvent.getRawX() - c0016c2.f193r;
                if ((rawX != 0.0d || rawY != 0.0d) && (motionEvent2 = c0016c2.f187l) != null) {
                    if (currentState != -1) {
                        androidx.compose.animation.core.u uVar = c0016c2.f177b;
                        if (uVar == null || (iT = uVar.t(currentState)) == -1) {
                            iT = currentState;
                        }
                        ArrayList arrayList = new ArrayList();
                        for (h1.x xVar4 : c0016c2.f179d) {
                            if (xVar4.d == iT || xVar4.c == iT) {
                                arrayList.add(xVar4);
                            }
                        }
                        RectF rectF3 = new RectF();
                        Iterator it2 = arrayList.iterator();
                        float f5 = 0.0f;
                        xVar2 = null;
                        while (it2.hasNext()) {
                            h1.x xVar5 = (h1.x) it2.next();
                            if (xVar5.o) {
                                it = it2;
                            } else {
                                C0017d c0017d4 = xVar5.l;
                                if (c0017d4 != null) {
                                    c0017d4.m84c(c0016c2.f191p);
                                    RectF rectFM83b2 = xVar5.l.m83b(motionLayout3, rectF3);
                                    if (rectFM83b2 != null) {
                                        it = it2;
                                        if (!rectFM83b2.contains(motionEvent2.getX(), motionEvent2.getY())) {
                                        }
                                    } else {
                                        it = it2;
                                    }
                                    RectF rectFM82a2 = xVar5.l.m82a(motionLayout3, rectF3);
                                    if (rectFM82a2 == null || rectFM82a2.contains(motionEvent2.getX(), motionEvent2.getY())) {
                                        C0017d c0017d5 = xVar5.l;
                                        float fAtan2 = (c0017d5.f212l * rawY) + (c0017d5.f211k * rawX);
                                        if (c0017d5.f210j) {
                                            float x = motionEvent2.getX();
                                            xVar5.l.getClass();
                                            float f6 = x - 0.5f;
                                            float y = motionEvent2.getY();
                                            xVar5.l.getClass();
                                            float f7 = y - 0.5f;
                                            fAtan2 = ((float) (Math.atan2(rawY + f7, rawX + f6) - Math.atan2(f6, f7))) * 10.0f;
                                        }
                                        float f8 = fAtan2 * (xVar5.c == currentState ? -1.0f : 1.1f);
                                        if (f8 > f5) {
                                            f5 = f8;
                                            xVar2 = xVar5;
                                        }
                                        it2 = it;
                                        rectF3 = rectF3;
                                        rawY = rawY;
                                        rawX = rawX;
                                        rectF2 = rectF2;
                                    }
                                } else {
                                    rectF2 = rectF2;
                                    it = it2;
                                    rectF3 = rectF3;
                                    xVar2 = xVar2;
                                    rawY = rawY;
                                    rawX = rawX;
                                }
                                xVar2 = xVar2;
                                it2 = it;
                                rectF3 = rectF3;
                                rawY = rawY;
                                rawX = rawX;
                                rectF2 = rectF2;
                            }
                            it2 = it;
                        }
                        rectF = rectF2;
                    } else {
                        rectF = rectF2;
                        xVar2 = c0016c2.f178c;
                    }
                    if (xVar2 != null) {
                        motionLayout2.setTransition(xVar2);
                        RectF rectFM83b3 = c0016c2.f178c.l.m83b(motionLayout3, rectF);
                        c0016c2.f189n = (rectFM83b3 == null || rectFM83b3.contains(c0016c2.f187l.getX(), c0016c2.f187l.getY())) ? false : true;
                        C0017d c0017d6 = c0016c2.f178c.l;
                        float f9 = c0016c2.f193r;
                        float f10 = c0016c2.f194s;
                        c0017d6.f216p = f9;
                        c0017d6.f217q = f10;
                        c0017d6.f213m = false;
                    }
                    if (!c0016c2.f188m) {
                        xVar = c0016c2.f178c;
                        if (xVar != null) {
                            c0016c2 = c0016c2;
                        } else {
                            c0016c2 = c0016c2;
                        }
                        C0016c c0016c3 = c0016c2;
                        c0016c3.f193r = motionEvent.getRawX();
                        c0016c3.f194s = motionEvent.getRawY();
                        if (motionEvent.getAction() == 1) {
                            motionLayout2 = this;
                        } else {
                            motionLayout2 = this;
                        }
                    }
                }
            } else if (!c0016c2.f188m) {
                xVar = c0016c2.f178c;
                if (xVar != null) {
                    c0016c2 = c0016c2;
                } else {
                    c0016c2 = c0016c2;
                }
                C0016c c0016c4 = c0016c2;
                c0016c4.f193r = motionEvent.getRawX();
                c0016c4.f194s = motionEvent.getRawY();
                if (motionEvent.getAction() == 1) {
                    motionLayout2 = this;
                } else {
                    motionLayout2 = this;
                }
            }
        } else if (!c0016c2.f188m) {
            xVar = c0016c2.f178c;
            if (xVar != null || (c0017d = xVar.l) == null || c0016c2.f189n) {
                c0016c2 = c0016c2;
            } else {
                t tVar5 = c0016c2.f190o;
                boolean z = c0017d.f210j;
                float[] fArr = c0017d.f214n;
                MotionLayout motionLayout4 = c0017d.f218r;
                if (z) {
                    VelocityTracker velocityTracker2 = tVar5.a;
                    if (velocityTracker2 != null) {
                        velocityTracker2.addMovement(motionEvent);
                    }
                    int action2 = motionEvent.getAction();
                    if (action2 != 0) {
                        int[] iArr = c0017d.f215o;
                        if (action2 == 1) {
                            c0016c2 = c0016c2;
                            c0017d.f213m = false;
                            VelocityTracker velocityTracker3 = tVar5.a;
                            if (velocityTracker3 != null) {
                                velocityTracker3.computeCurrentVelocity(16);
                            }
                            VelocityTracker velocityTracker4 = tVar5.a;
                            float xVelocity = velocityTracker4 != null ? velocityTracker4.getXVelocity() : 0.0f;
                            VelocityTracker velocityTracker5 = tVar5.a;
                            float yVelocity = velocityTracker5 != null ? velocityTracker5.getYVelocity() : 0.0f;
                            float progress = motionLayout4.getProgress();
                            float width = motionLayout4.getWidth() / 2.0f;
                            float height = motionLayout4.getHeight() / 2.0f;
                            int i4 = c0017d.f209i;
                            if (i4 != -1) {
                                View viewFindViewById = motionLayout4.findViewById(i4);
                                motionLayout4.getLocationOnScreen(iArr);
                                right = iArr[0] + ((viewFindViewById.getRight() + viewFindViewById.getLeft()) / 2.0f);
                                f = iArr[1];
                                top = viewFindViewById.getTop();
                                bottom = viewFindViewById.getBottom();
                            } else {
                                int i5 = c0017d.f204d;
                                if (i5 != -1) {
                                    View viewFindViewById2 = motionLayout4.findViewById(((n) motionLayout4.f105C.get(motionLayout4.findViewById(i5))).f.k);
                                    motionLayout4.getLocationOnScreen(iArr);
                                    right = iArr[0] + ((viewFindViewById2.getRight() + viewFindViewById2.getLeft()) / 2.0f);
                                    f = iArr[1];
                                    top = viewFindViewById2.getTop();
                                    bottom = viewFindViewById2.getBottom();
                                } else {
                                    float rawX2 = motionEvent.getRawX() - width;
                                    float rawY2 = motionEvent.getRawY() - height;
                                    double degrees2 = Math.toDegrees(Math.atan2(rawY2, rawX2));
                                    i2 = c0017d.f204d;
                                    if (i2 != -1) {
                                        c0017d.f218r.m62w(i2, progress, c0017d.f208h, c0017d.f207g, c0017d.f214n);
                                        fArr[1] = (float) Math.toDegrees(fArr[1]);
                                    } else {
                                        fArr[1] = 360.0f;
                                    }
                                    degrees = ((float) (Math.toDegrees(Math.atan2(yVelocity + rawY2, xVelocity + rawX2)) - degrees2)) * 62.5f;
                                    if (Float.isNaN(degrees)) {
                                        f2 = progress;
                                    } else {
                                        f2 = (((degrees * 3.0f) * c0017d.f222v) / fArr[1]) + progress;
                                    }
                                    if (f2 == 0.0f && f2 != 1.0f && (i3 = c0017d.f203c) != 3) {
                                        float fAbs = (degrees * c0017d.f222v) / fArr[1];
                                        float f11 = ((double) f2) < 0.5d ? 0.0f : 1.0f;
                                        if (i3 == 6) {
                                            if (progress + fAbs < 0.0f) {
                                                fAbs = Math.abs(fAbs);
                                            }
                                            f11 = 1.0f;
                                        }
                                        if (c0017d.f203c == 7) {
                                            if (progress + fAbs > 1.0f) {
                                                fAbs = -Math.abs(fAbs);
                                            }
                                            f11 = 0.0f;
                                        }
                                        motionLayout4.m46G(c0017d.f203c, f11, fAbs * 3.0f);
                                        if (0.0f >= progress || 1.0f <= progress) {
                                            motionLayout4.setState(TransitionState.FINISHED);
                                        }
                                    } else if (0.0f < f2 || 1.0f <= f2) {
                                        motionLayout4.setState(TransitionState.FINISHED);
                                    }
                                }
                            }
                            float f12 = f + ((bottom + top) / 2.0f);
                            width = right;
                            height = f12;
                            float rawX3 = motionEvent.getRawX() - width;
                            float rawY3 = motionEvent.getRawY() - height;
                            double degrees3 = Math.toDegrees(Math.atan2(rawY3, rawX3));
                            i2 = c0017d.f204d;
                            if (i2 != -1) {
                                c0017d.f218r.m62w(i2, progress, c0017d.f208h, c0017d.f207g, c0017d.f214n);
                                fArr[1] = (float) Math.toDegrees(fArr[1]);
                            } else {
                                fArr[1] = 360.0f;
                            }
                            degrees = ((float) (Math.toDegrees(Math.atan2(yVelocity + rawY3, xVelocity + rawX3)) - degrees3)) * 62.5f;
                            if (Float.isNaN(degrees)) {
                                f2 = (((degrees * 3.0f) * c0017d.f222v) / fArr[1]) + progress;
                            } else {
                                f2 = progress;
                            }
                            if (f2 == 0.0f) {
                                if (0.0f < f2) {
                                    motionLayout4.setState(TransitionState.FINISHED);
                                } else {
                                    motionLayout4.setState(TransitionState.FINISHED);
                                }
                            } else if (0.0f < f2) {
                                motionLayout4.setState(TransitionState.FINISHED);
                            } else {
                                motionLayout4.setState(TransitionState.FINISHED);
                            }
                        } else if (action2 != 2) {
                            c0016c2 = c0016c2;
                        } else {
                            motionEvent.getRawY();
                            motionEvent.getRawX();
                            float width2 = motionLayout4.getWidth() / 2.0f;
                            float height2 = motionLayout4.getHeight() / 2.0f;
                            int i6 = c0017d.f209i;
                            if (i6 != -1) {
                                View viewFindViewById3 = motionLayout4.findViewById(i6);
                                motionLayout4.getLocationOnScreen(iArr);
                                float right2 = iArr[0] + ((viewFindViewById3.getRight() + viewFindViewById3.getLeft()) / 2.0f);
                                height2 = ((viewFindViewById3.getBottom() + viewFindViewById3.getTop()) / 2.0f) + iArr[1];
                                width2 = right2;
                            } else {
                                int i7 = c0017d.f204d;
                                if (i7 != -1) {
                                    View viewFindViewById4 = motionLayout4.findViewById(((n) motionLayout4.f105C.get(motionLayout4.findViewById(i7))).f.k);
                                    if (viewFindViewById4 == null) {
                                        Log.e("TouchResponse", "could not find view to animate to");
                                    } else {
                                        motionLayout4.getLocationOnScreen(iArr);
                                        width2 = iArr[0] + ((viewFindViewById4.getRight() + viewFindViewById4.getLeft()) / 2.0f);
                                        height2 = ((viewFindViewById4.getBottom() + viewFindViewById4.getTop()) / 2.0f) + iArr[1];
                                    }
                                }
                            }
                            float rawX4 = motionEvent.getRawX() - width2;
                            float rawY4 = motionEvent.getRawY() - height2;
                            double dAtan2 = Math.atan2(motionEvent.getRawY() - height2, motionEvent.getRawX() - width2);
                            float fAtan3 = (float) (((dAtan2 - Math.atan2(c0017d.f217q - height2, c0017d.f216p - width2)) * 180.0d) / 3.141592653589793d);
                            if (fAtan3 > 330.0f) {
                                fAtan3 -= 360.0f;
                            } else if (fAtan3 < -330.0f) {
                                fAtan3 += 360.0f;
                            }
                            if (Math.abs(fAtan3) > 0.01d || c0017d.f213m) {
                                float progress2 = motionLayout4.getProgress();
                                if (c0017d.f213m) {
                                    motionLayout = motionLayout4;
                                } else {
                                    c0017d.f213m = true;
                                    motionLayout = motionLayout4;
                                    motionLayout.setProgress(progress2);
                                }
                                int i8 = c0017d.f204d;
                                if (i8 != -1) {
                                    c0017d.f218r.m62w(i8, progress2, c0017d.f208h, c0017d.f207g, c0017d.f214n);
                                    c6 = 1;
                                    fArr[1] = (float) Math.toDegrees(fArr[1]);
                                } else {
                                    c6 = 1;
                                    fArr[1] = 360.0f;
                                }
                                float fMax = Math.max(Math.min(((fAtan3 * c0017d.f222v) / fArr[c6]) + progress2, 1.0f), 0.0f);
                                float progress3 = motionLayout.getProgress();
                                if (fMax != progress3) {
                                    if (progress3 == 0.0f || progress3 == 1.0f) {
                                        motionLayout.m58s();
                                    }
                                    motionLayout.setProgress(fMax);
                                    VelocityTracker velocityTracker6 = tVar5.a;
                                    if (velocityTracker6 != null) {
                                        velocityTracker6.computeCurrentVelocity(1000);
                                    }
                                    VelocityTracker velocityTracker7 = tVar5.a;
                                    float xVelocity2 = velocityTracker7 != null ? velocityTracker7.getXVelocity() : 0.0f;
                                    VelocityTracker velocityTracker8 = tVar5.a;
                                    double yVelocity2 = velocityTracker8 != null ? velocityTracker8.getYVelocity() : 0.0f;
                                    double d = xVelocity2;
                                    motionLayout.f155v = (float) Math.toDegrees((float) ((Math.sin(Math.atan2(yVelocity2, d) - dAtan2) * Math.hypot(yVelocity2, d)) / Math.hypot(rawX4, rawY4)));
                                } else {
                                    motionLayout.f155v = 0.0f;
                                }
                                c0017d.f216p = motionEvent.getRawX();
                                c0017d.f217q = motionEvent.getRawY();
                            } else {
                                c0016c2 = c0016c2;
                            }
                        }
                    } else {
                        c0016c2 = c0016c2;
                        c0017d.f216p = motionEvent.getRawX();
                        c0017d.f217q = motionEvent.getRawY();
                        c0017d.f213m = false;
                    }
                } else {
                    c0016c2 = c0016c2;
                    VelocityTracker velocityTracker9 = tVar5.a;
                    if (velocityTracker9 != null) {
                        velocityTracker9.addMovement(motionEvent);
                    }
                    int action3 = motionEvent.getAction();
                    if (action3 == 0) {
                        c0017d.f216p = motionEvent.getRawX();
                        c0017d.f217q = motionEvent.getRawY();
                        c0017d.f213m = false;
                    } else if (action3 == 1) {
                        c0017d.f213m = false;
                        VelocityTracker velocityTracker10 = tVar5.a;
                        if (velocityTracker10 != null) {
                            velocityTracker10.computeCurrentVelocity(1000);
                        }
                        VelocityTracker velocityTracker11 = tVar5.a;
                        float xVelocity3 = velocityTracker11 != null ? velocityTracker11.getXVelocity() : 0.0f;
                        VelocityTracker velocityTracker12 = tVar5.a;
                        float yVelocity3 = velocityTracker12 != null ? velocityTracker12.getYVelocity() : 0.0f;
                        float progress4 = motionLayout4.getProgress();
                        int i9 = c0017d.f204d;
                        if (i9 != -1) {
                            c0017d.f218r.m62w(i9, progress4, c0017d.f208h, c0017d.f207g, c0017d.f214n);
                            c2 = 0;
                            c = 1;
                        } else {
                            float fMin = Math.min(motionLayout4.getWidth(), motionLayout4.getHeight());
                            c = 1;
                            fArr[1] = c0017d.f212l * fMin;
                            c2 = 0;
                            fArr[0] = fMin * c0017d.f211k;
                        }
                        float fAbs2 = c0017d.f211k != 0.0f ? xVelocity3 / fArr[c2] : yVelocity3 / fArr[c];
                        float f13 = !Float.isNaN(fAbs2) ? (fAbs2 / 3.0f) + progress4 : progress4;
                        if (f13 != 0.0f && f13 != 1.0f && (i = c0017d.f203c) != 3) {
                            float f14 = ((double) f13) < 0.5d ? 0.0f : 1.0f;
                            if (i == 6) {
                                if (progress4 + fAbs2 < 0.0f) {
                                    fAbs2 = Math.abs(fAbs2);
                                }
                                f14 = 1.0f;
                            }
                            if (c0017d.f203c == 7) {
                                if (progress4 + fAbs2 > 1.0f) {
                                    fAbs2 = -Math.abs(fAbs2);
                                }
                                f14 = 0.0f;
                            }
                            motionLayout4.m46G(c0017d.f203c, f14, fAbs2);
                            if (0.0f >= progress4 || 1.0f <= progress4) {
                                motionLayout4.setState(TransitionState.FINISHED);
                            }
                        } else if (0.0f >= f13 || 1.0f <= f13) {
                            motionLayout4.setState(TransitionState.FINISHED);
                        }
                    } else if (action3 == 2) {
                        float rawY5 = motionEvent.getRawY() - c0017d.f217q;
                        float rawX5 = motionEvent.getRawX() - c0017d.f216p;
                        if (Math.abs((c0017d.f212l * rawY5) + (c0017d.f211k * rawX5)) > c0017d.f224x || c0017d.f213m) {
                            float progress5 = motionLayout4.getProgress();
                            if (!c0017d.f213m) {
                                c0017d.f213m = true;
                                motionLayout4.setProgress(progress5);
                            }
                            int i10 = c0017d.f204d;
                            if (i10 != -1) {
                                c0017d.f218r.m62w(i10, progress5, c0017d.f208h, c0017d.f207g, c0017d.f214n);
                                c4 = 0;
                                c3 = 1;
                            } else {
                                float fMin2 = Math.min(motionLayout4.getWidth(), motionLayout4.getHeight());
                                c3 = 1;
                                fArr[1] = c0017d.f212l * fMin2;
                                c4 = 0;
                                fArr[0] = fMin2 * c0017d.f211k;
                            }
                            if (Math.abs(((c0017d.f212l * fArr[c3]) + (c0017d.f211k * fArr[c4])) * c0017d.f222v) < 0.01d) {
                                c5 = 0;
                                fArr[0] = 0.01f;
                                fArr[c3] = 0.01f;
                            } else {
                                c5 = 0;
                            }
                            float fMax2 = Math.max(Math.min(progress5 + (c0017d.f211k != 0.0f ? rawX5 / fArr[c5] : rawY5 / fArr[c3]), 1.0f), 0.0f);
                            if (c0017d.f203c == 6) {
                                fMax2 = Math.max(fMax2, 0.01f);
                            }
                            if (c0017d.f203c == 7) {
                                fMax2 = Math.min(fMax2, 0.99f);
                            }
                            float progress6 = motionLayout4.getProgress();
                            if (fMax2 != progress6) {
                                if (progress6 == 0.0f || progress6 == 1.0f) {
                                    motionLayout4.m58s();
                                }
                                motionLayout4.setProgress(fMax2);
                                VelocityTracker velocityTracker13 = tVar5.a;
                                if (velocityTracker13 != null) {
                                    velocityTracker13.computeCurrentVelocity(1000);
                                }
                                VelocityTracker velocityTracker14 = tVar5.a;
                                float xVelocity4 = velocityTracker14 != null ? velocityTracker14.getXVelocity() : 0.0f;
                                VelocityTracker velocityTracker15 = tVar5.a;
                                motionLayout4.f155v = c0017d.f211k != 0.0f ? xVelocity4 / fArr[0] : (velocityTracker15 != null ? velocityTracker15.getYVelocity() : 0.0f) / fArr[1];
                            } else {
                                motionLayout4.f155v = 0.0f;
                            }
                            c0017d.f216p = motionEvent.getRawX();
                            c0017d.f217q = motionEvent.getRawY();
                        }
                    }
                }
            }
            C0016c c0016c5 = c0016c2;
            c0016c5.f193r = motionEvent.getRawX();
            c0016c5.f194s = motionEvent.getRawY();
            if (motionEvent.getAction() == 1 || (tVar = c0016c5.f190o) == null) {
                motionLayout2 = this;
            } else {
                VelocityTracker velocityTracker16 = tVar.a;
                if (velocityTracker16 != null) {
                    velocityTracker16.recycle();
                    tVar2 = null;
                    tVar.a = null;
                } else {
                    tVar2 = null;
                }
                c0016c5.f190o = tVar2;
                motionLayout2 = this;
                int i11 = motionLayout2.f159x;
                if (i11 != -1) {
                    c0016c5.m67a(i11, motionLayout2);
                }
            }
        }
        h1.x xVar6 = motionLayout2.f149s.f178c;
        if ((xVar6.r & 4) != 0) {
            return xVar6.l.f213m;
        }
        return true;
    }

    @Override // androidx.constraintlayout.widget.ConstraintLayout, android.view.ViewGroup
    public final void onViewAdded(View view) {
        super.onViewAdded(view);
        if (view instanceof MotionHelper) {
            MotionHelper motionHelper = (MotionHelper) view;
            if (this.f137g0 == null) {
                this.f137g0 = new CopyOnWriteArrayList();
            }
            this.f137g0.add(motionHelper);
            if (motionHelper.f96i) {
                if (this.f134d0 == null) {
                    this.f134d0 = new ArrayList();
                }
                this.f134d0.add(motionHelper);
            }
            if (motionHelper.f97j) {
                if (this.f135e0 == null) {
                    this.f135e0 = new ArrayList();
                }
                this.f135e0.add(motionHelper);
            }
            if (motionHelper instanceof MotionEffect) {
                if (this.f136f0 == null) {
                    this.f136f0 = new ArrayList();
                }
                this.f136f0.add(motionHelper);
            }
        }
    }

    @Override // androidx.constraintlayout.widget.ConstraintLayout, android.view.ViewGroup
    public final void onViewRemoved(View view) {
        super.onViewRemoved(view);
        ArrayList arrayList = this.f134d0;
        if (arrayList != null) {
            arrayList.remove(view);
        }
        ArrayList arrayList2 = this.f135e0;
        if (arrayList2 != null) {
            arrayList2.remove(view);
        }
    }

    /* JADX INFO: renamed from: r */
    public final void m57r(float f) {
        C0016c c0016c = this.f149s;
        if (c0016c == null) {
            return;
        }
        float f2 = this.f113G;
        float f3 = this.f111F;
        if (f2 != f3 && this.f117J) {
            this.f113G = f3;
        }
        float f4 = this.f113G;
        if (f4 == f) {
            return;
        }
        this.f122O = false;
        this.f116I = f;
        this.f109E = c0016c.m69c() / 1000.0f;
        setProgress(this.f116I);
        this.f151t = null;
        this.f153u = this.f149s.m71e();
        this.f117J = false;
        this.f107D = getNanoTime();
        this.f118K = true;
        this.f111F = f4;
        this.f113G = f4;
        invalidate();
    }

    @Override // androidx.constraintlayout.widget.ConstraintLayout, android.view.View, android.view.ViewParent
    public final void requestLayout() {
        C0016c c0016c;
        h1.x xVar;
        if (!this.f143m0 && this.f159x == -1 && (c0016c = this.f149s) != null && (xVar = c0016c.f178c) != null) {
            int i = xVar.q;
            if (i == 0) {
                return;
            }
            if (i == 2) {
                int childCount = getChildCount();
                for (int i2 = 0; i2 < childCount; i2++) {
                    ((n) this.f105C.get(getChildAt(i2))).d = true;
                }
                return;
            }
        }
        super.requestLayout();
    }

    /* JADX INFO: renamed from: s */
    public final void m58s() {
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            n nVar = (n) this.f105C.get(getChildAt(i));
            if (nVar != null) {
                "button".equals(so.c.x(nVar.b));
            }
        }
    }

    public void setDebugMode(int i) {
        this.f120M = i;
        invalidate();
    }

    public void setDelayedApplicationOfInitialState(boolean z) {
        this.f164z0 = z;
    }

    public void setInteractionEnabled(boolean z) {
        this.f103B = z;
    }

    public void setInterpolatedProgress(float f) {
        if (this.f149s != null) {
            setState(TransitionState.MOVING);
            Interpolator interpolatorM71e = this.f149s.m71e();
            if (interpolatorM71e != null) {
                setProgress(interpolatorM71e.getInterpolation(f));
                return;
            }
        }
        setProgress(f);
    }

    public void setOnHide(float f) {
        ArrayList arrayList = this.f135e0;
        if (arrayList != null) {
            int size = arrayList.size();
            for (int i = 0; i < size; i++) {
                ((MotionHelper) this.f135e0.get(i)).setProgress(f);
            }
        }
    }

    public void setOnShow(float f) {
        ArrayList arrayList = this.f134d0;
        if (arrayList != null) {
            int size = arrayList.size();
            for (int i = 0; i < size; i++) {
                ((MotionHelper) this.f134d0.get(i)).setProgress(f);
            }
        }
    }

    public void setProgress(float f) {
        if (f >= 0.0f) {
            int i = (f > 1.0f ? 1 : (f == 1.0f ? 0 : -1));
        }
        if (!super.isAttachedToWindow()) {
            if (this.f158w0 == null) {
                this.f158w0 = new C0015b(this);
            }
            this.f158w0.f171a = f;
            return;
        }
        if (f <= 0.0f) {
            if (this.f113G == 1.0f && this.f159x == this.f161y) {
                setState(TransitionState.MOVING);
            }
            this.f159x = this.f157w;
            if (this.f113G == 0.0f) {
                setState(TransitionState.FINISHED);
            }
        } else if (f >= 1.0f) {
            if (this.f113G == 0.0f && this.f159x == this.f157w) {
                setState(TransitionState.MOVING);
            }
            this.f159x = this.f161y;
            if (this.f113G == 1.0f) {
                setState(TransitionState.FINISHED);
            }
        } else {
            this.f159x = -1;
            setState(TransitionState.MOVING);
        }
        if (this.f149s == null) {
            return;
        }
        this.f117J = true;
        this.f116I = f;
        this.f111F = f;
        this.f115H = -1L;
        this.f107D = -1L;
        this.f151t = null;
        this.f118K = true;
        invalidate();
    }

    public void setScene(C0016c c0016c) {
        C0017d c0017d;
        this.f149s = c0016c;
        boolean zM112l = m112l();
        c0016c.f191p = zM112l;
        h1.x xVar = c0016c.f178c;
        if (xVar != null && (c0017d = xVar.l) != null) {
            c0017d.m84c(zM112l);
        }
        m42C();
    }

    public void setStartState(int i) {
        if (super.isAttachedToWindow()) {
            this.f159x = i;
            return;
        }
        if (this.f158w0 == null) {
            this.f158w0 = new C0015b(this);
        }
        C0015b c0015b = this.f158w0;
        c0015b.f173c = i;
        c0015b.f174d = i;
    }

    public void setState(TransitionState transitionState) {
        TransitionState transitionState2 = TransitionState.FINISHED;
        if (transitionState == transitionState2 && this.f159x == -1) {
            return;
        }
        TransitionState transitionState3 = this.f102A0;
        this.f102A0 = transitionState;
        TransitionState transitionState4 = TransitionState.MOVING;
        if (transitionState3 == transitionState4 && transitionState == transitionState4) {
            m60u();
        }
        int i = AbstractC0014a.f170a[transitionState3.ordinal()];
        if (i != 1 && i != 2) {
            if (i == 3 && transitionState == transitionState2) {
                m61v();
                return;
            }
            return;
        }
        if (transitionState == transitionState4) {
            m60u();
        }
        if (transitionState == transitionState2) {
            m61v();
        }
    }

    public void setTransition(int i) {
        float f;
        if (this.f149s != null) {
            h1.x xVarM63x = m63x(i);
            this.f157w = xVarM63x.d;
            this.f161y = xVarM63x.c;
            if (!super.isAttachedToWindow()) {
                if (this.f158w0 == null) {
                    this.f158w0 = new C0015b(this);
                }
                C0015b c0015b = this.f158w0;
                c0015b.f173c = this.f157w;
                c0015b.f174d = this.f161y;
                return;
            }
            int i2 = this.f159x;
            if (i2 == this.f157w) {
                f = 0.0f;
            } else {
                f = i2 == this.f161y ? 1.0f : Float.NaN;
            }
            C0016c c0016c = this.f149s;
            c0016c.f178c = xVarM63x;
            C0017d c0017d = xVarM63x.l;
            if (c0017d != null) {
                c0017d.m84c(c0016c.f191p);
            }
            this.f104B0.e(this.f149s.m68b(this.f157w), this.f149s.m68b(this.f161y));
            m42C();
            if (this.f113G != f) {
                if (f == 0.0f) {
                    m58s();
                    this.f149s.m68b(this.f157w).m137b(this);
                } else if (f == 1.0f) {
                    m58s();
                    this.f149s.m68b(this.f161y).m137b(this);
                }
            }
            this.f113G = Float.isNaN(f) ? 0.0f : f;
            if (!Float.isNaN(f)) {
                setProgress(f);
            } else {
                so.c.v();
                m57r(0.0f);
            }
        }
    }

    public void setTransitionDuration(int i) {
        C0016c c0016c = this.f149s;
        if (c0016c == null) {
            Log.e("MotionLayout", "MotionScene not defined");
            return;
        }
        h1.x xVar = c0016c.f178c;
        if (xVar != null) {
            xVar.h = Math.max(i, 8);
        } else {
            c0016c.f185j = i;
        }
    }

    public void setTransitionListener(u uVar) {
        this.f119L = uVar;
    }

    public void setTransitionState(Bundle bundle) {
        if (this.f158w0 == null) {
            this.f158w0 = new C0015b(this);
        }
        C0015b c0015b = this.f158w0;
        c0015b.getClass();
        c0015b.f171a = bundle.getFloat("motion.progress");
        c0015b.f172b = bundle.getFloat("motion.velocity");
        c0015b.f173c = bundle.getInt("motion.StartState");
        c0015b.f174d = bundle.getInt("motion.EndState");
        if (super.isAttachedToWindow()) {
            this.f158w0.m66a();
        }
    }

    /* JADX WARN: Code duplicated, block: B:117:0x01bc  */
    /* JADX WARN: Code duplicated, block: B:127:0x01ea  */
    /* JADX WARN: Code duplicated, block: B:129:0x01f0  */
    /* JADX WARN: Code duplicated, block: B:143:0x0220  */
    /* JADX WARN: Code duplicated, block: B:180:0x0191 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:62:0x00e2 A[PHI: r3
      0x00e2: PHI (r3v50 float) = (r3v49 float), (r3v51 float), (r3v51 float) binds: [B:47:0x00ad, B:58:0x00d6, B:60:0x00da] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Code duplicated, block: B:72:0x010f  */
    /* JADX WARN: Code duplicated, block: B:74:0x0116  */
    /* JADX WARN: Code duplicated, block: B:86:0x0136  */
    /* JADX WARN: Code duplicated, block: B:89:0x014d  */
    /* JADX WARN: Code duplicated, block: B:90:0x014f  */
    /* JADX WARN: Code duplicated, block: B:93:0x0157  */
    /* JADX WARN: Code duplicated, block: B:96:0x016e  */
    /* JADX WARN: Code duplicated, block: B:98:0x017e  */
    /* JADX INFO: renamed from: t */
    public final void m59t(boolean z) {
        boolean z2;
        char c;
        int childCount;
        long nanoTime;
        Interpolator interpolator;
        float interpolation;
        Interpolator interpolator2;
        int i;
        int i2;
        int i3;
        int i4;
        View childAt;
        n nVar;
        boolean z3;
        if (this.f115H == -1) {
            this.f115H = getNanoTime();
        }
        float f = this.f113G;
        if (f > 0.0f && f < 1.0f) {
            this.f159x = -1;
        }
        boolean z4 = false;
        if (this.f133c0 || (this.f118K && (z || this.f116I != f))) {
            float fSignum = Math.signum(this.f116I - f);
            long nanoTime2 = getNanoTime();
            o oVar = this.f151t;
            float f2 = !(oVar instanceof o) ? (((nanoTime2 - this.f115H) * fSignum) * 1.0E-9f) / this.f109E : 0.0f;
            float f3 = this.f113G + f2;
            if (this.f117J) {
                f3 = this.f116I;
            }
            if ((fSignum <= 0.0f || f3 < this.f116I) && (fSignum > 0.0f || f3 > this.f116I)) {
                z2 = false;
            } else {
                f3 = this.f116I;
                this.f118K = false;
                z2 = true;
            }
            this.f113G = f3;
            this.f111F = f3;
            this.f115H = nanoTime2;
            if (oVar == null || z2) {
                this.f155v = f2;
            } else {
                if (this.f122O) {
                    float interpolation2 = oVar.getInterpolation((nanoTime2 - this.f107D) * 1.0E-9f);
                    g1.b bVar = this.f151t;
                    g1.b bVar2 = this.f123P;
                    c = bVar == bVar2 ? bVar2.c.b() ? (char) 2 : (char) 1 : (char) 0;
                    this.f113G = interpolation2;
                    this.f115H = nanoTime2;
                    o oVar2 = this.f151t;
                    if (oVar2 instanceof o) {
                        float fA = oVar2.a();
                        this.f155v = fA;
                        if (Math.abs(fA) * this.f109E <= 1.0E-5f && c == 2) {
                            this.f118K = false;
                        }
                        if (fA > 0.0f && interpolation2 >= 1.0f) {
                            this.f113G = 1.0f;
                            this.f118K = false;
                            interpolation2 = 1.0f;
                        }
                        if (fA >= 0.0f || interpolation2 > 0.0f) {
                            f3 = interpolation2;
                        } else {
                            this.f113G = 0.0f;
                            this.f118K = false;
                            f3 = 0.0f;
                        }
                    } else {
                        f3 = interpolation2;
                    }
                } else {
                    float interpolation3 = oVar.getInterpolation(f3);
                    o oVar3 = this.f151t;
                    if (oVar3 instanceof o) {
                        this.f155v = oVar3.a();
                    } else {
                        this.f155v = ((oVar3.getInterpolation(f3 + f2) - interpolation3) * fSignum) / f2;
                    }
                    f3 = interpolation3;
                }
                if (Math.abs(this.f155v) > 1.0E-5f) {
                    setState(TransitionState.MOVING);
                }
                if (c != 1) {
                    if ((fSignum <= 0.0f && f3 >= this.f116I) || (fSignum <= 0.0f && f3 <= this.f116I)) {
                        f3 = this.f116I;
                        this.f118K = false;
                    }
                    if (f3 < 1.0f || f3 <= 0.0f) {
                        this.f118K = false;
                        setState(TransitionState.FINISHED);
                    }
                }
                childCount = getChildCount();
                this.f133c0 = false;
                nanoTime = getNanoTime();
                this.f152t0 = f3;
                interpolator = this.f153u;
                if (interpolator == null) {
                    interpolation = f3;
                } else {
                    interpolation = interpolator.getInterpolation(f3);
                }
                interpolator2 = this.f153u;
                if (interpolator2 != null) {
                    float interpolation4 = interpolator2.getInterpolation((fSignum / this.f109E) + f3);
                    this.f155v = interpolation4;
                    this.f155v = interpolation4 - this.f153u.getInterpolation(f3);
                }
                for (i = 0; i < childCount; i++) {
                    childAt = getChildAt(i);
                    nVar = (n) this.f105C.get(childAt);
                    if (nVar != null) {
                        this.f133c0 = nVar.e(interpolation, nanoTime, childAt, this.f154u0) | this.f133c0;
                    }
                }
                boolean z5 = (fSignum <= 0.0f && f3 >= this.f116I) || (fSignum <= 0.0f && f3 <= this.f116I);
                if (!this.f133c0 && !this.f118K && z5) {
                    setState(TransitionState.FINISHED);
                }
                if (this.f143m0) {
                    requestLayout();
                }
                this.f133c0 = (!z5) | this.f133c0;
                if (f3 <= 0.0f && (i4 = this.f157w) != -1 && this.f159x != i4) {
                    this.f159x = i4;
                    this.f149s.m68b(i4).m136a(this);
                    setState(TransitionState.FINISHED);
                    z4 = true;
                }
                if (f3 >= 1.0d) {
                    i2 = this.f159x;
                    i3 = this.f161y;
                    if (i2 != i3) {
                        this.f159x = i3;
                        this.f149s.m68b(i3).m136a(this);
                        setState(TransitionState.FINISHED);
                        z4 = true;
                    }
                }
                if (!this.f133c0 || this.f118K) {
                    invalidate();
                } else if ((fSignum > 0.0f && f3 == 1.0f) || (fSignum < 0.0f && f3 == 0.0f)) {
                    setState(TransitionState.FINISHED);
                }
                if (!this.f133c0 && !this.f118K && ((fSignum > 0.0f && f3 == 1.0f) || (fSignum < 0.0f && f3 == 0.0f))) {
                    m40A();
                }
            }
            c = 0;
            if (Math.abs(this.f155v) > 1.0E-5f) {
                setState(TransitionState.MOVING);
            }
            if (c != 1) {
                if (fSignum <= 0.0f) {
                    f3 = this.f116I;
                    this.f118K = false;
                } else {
                    f3 = this.f116I;
                    this.f118K = false;
                }
                if (f3 < 1.0f) {
                    this.f118K = false;
                    setState(TransitionState.FINISHED);
                } else {
                    this.f118K = false;
                    setState(TransitionState.FINISHED);
                }
            }
            childCount = getChildCount();
            this.f133c0 = false;
            nanoTime = getNanoTime();
            this.f152t0 = f3;
            interpolator = this.f153u;
            if (interpolator == null) {
                interpolation = f3;
            } else {
                interpolation = interpolator.getInterpolation(f3);
            }
            interpolator2 = this.f153u;
            if (interpolator2 != null) {
                float interpolation5 = interpolator2.getInterpolation((fSignum / this.f109E) + f3);
                this.f155v = interpolation5;
                this.f155v = interpolation5 - this.f153u.getInterpolation(f3);
            }
            while (i < childCount) {
                childAt = getChildAt(i);
                nVar = (n) this.f105C.get(childAt);
                if (nVar != null) {
                    this.f133c0 = nVar.e(interpolation, nanoTime, childAt, this.f154u0) | this.f133c0;
                }
            }
            if (fSignum <= 0.0f) {
            }
            if (!this.f133c0) {
                setState(TransitionState.FINISHED);
            }
            if (this.f143m0) {
                requestLayout();
            }
            this.f133c0 = (!z5) | this.f133c0;
            if (f3 <= 0.0f) {
                this.f159x = i4;
                this.f149s.m68b(i4).m136a(this);
                setState(TransitionState.FINISHED);
                z4 = true;
            }
            if (f3 >= 1.0d) {
                i2 = this.f159x;
                i3 = this.f161y;
                if (i2 != i3) {
                    this.f159x = i3;
                    this.f149s.m68b(i3).m136a(this);
                    setState(TransitionState.FINISHED);
                    z4 = true;
                }
            }
            if (this.f133c0) {
                invalidate();
            } else {
                invalidate();
            }
            if (!this.f133c0) {
                m40A();
            }
        }
        float f4 = this.f113G;
        if (f4 < 1.0f) {
            if (f4 <= 0.0f) {
                int i5 = this.f159x;
                int i6 = this.f157w;
                z3 = i5 == i6 ? z4 : true;
                this.f159x = i6;
            }
            this.f106C0 |= z4;
            if (z4 && !this.f156v0) {
                requestLayout();
            }
            this.f111F = this.f113G;
        }
        int i7 = this.f159x;
        int i8 = this.f161y;
        z3 = i7 == i8 ? z4 : true;
        this.f159x = i8;
        z4 = z3;
        this.f106C0 |= z4;
        if (z4) {
            requestLayout();
        }
        this.f111F = this.f113G;
    }

    @Override // android.view.View
    public final String toString() {
        Context context = getContext();
        return so.c.w(context, this.f157w) + "->" + so.c.w(context, this.f161y) + " (pos:" + this.f113G + " Dpos/Dt:" + this.f155v;
    }

    /* JADX INFO: renamed from: u */
    public final void m60u() {
        CopyOnWriteArrayList copyOnWriteArrayList;
        CopyOnWriteArrayList copyOnWriteArrayList2;
        if ((this.f119L == null && ((copyOnWriteArrayList2 = this.f137g0) == null || copyOnWriteArrayList2.isEmpty())) || this.f142l0 == this.f111F) {
            return;
        }
        if (this.f141k0 != -1 && (copyOnWriteArrayList = this.f137g0) != null) {
            Iterator it = copyOnWriteArrayList.iterator();
            while (it.hasNext()) {
                ((u) it.next()).getClass();
            }
        }
        this.f141k0 = -1;
        this.f142l0 = this.f111F;
        CopyOnWriteArrayList copyOnWriteArrayList3 = this.f137g0;
        if (copyOnWriteArrayList3 != null) {
            Iterator it2 = copyOnWriteArrayList3.iterator();
            while (it2.hasNext()) {
                ((u) it2.next()).getClass();
            }
        }
    }

    /* JADX INFO: renamed from: v */
    public final void m61v() {
        CopyOnWriteArrayList copyOnWriteArrayList;
        if ((this.f119L != null || ((copyOnWriteArrayList = this.f137g0) != null && !copyOnWriteArrayList.isEmpty())) && this.f141k0 == -1) {
            this.f141k0 = this.f159x;
            ArrayList arrayList = this.f114G0;
            int iIntValue = !arrayList.isEmpty() ? ((Integer) com.newleaf.app.android.victor.common.m.i(1, arrayList)).intValue() : -1;
            int i = this.f159x;
            if (iIntValue != i && i != -1) {
                arrayList.add(Integer.valueOf(i));
            }
        }
        m41B();
        com.vungle.ads.internal.util.d dVar = this.f160x0;
        if (dVar != null) {
            dVar.run();
        }
    }

    /* JADX INFO: renamed from: w */
    public final void m62w(int i, float f, float f2, float f3, float[] fArr) {
        View viewM109f = m109f(i);
        n nVar = (n) this.f105C.get(viewM109f);
        if (nVar != null) {
            nVar.d(f, f2, f3, fArr);
            viewM109f.getY();
        } else {
            if (viewM109f == null) {
                return;
            }
            viewM109f.getContext().getResources().getResourceName(i);
        }
    }

    /* JADX INFO: renamed from: x */
    public final h1.x m63x(int i) {
        for (h1.x xVar : this.f149s.f179d) {
            if (xVar.a == i) {
                return xVar;
            }
        }
        return null;
    }

    /* JADX INFO: renamed from: y */
    public final boolean m64y(float f, float f2, View view, MotionEvent motionEvent) {
        boolean z;
        boolean zOnTouchEvent;
        if (!(view instanceof ViewGroup)) {
            z = false;
            break;
        }
        ViewGroup viewGroup = (ViewGroup) view;
        int childCount = viewGroup.getChildCount() - 1;
        while (true) {
            if (childCount < 0) {
                z = false;
                break;
            }
            View childAt = viewGroup.getChildAt(childCount);
            if (m64y((childAt.getLeft() + f) - view.getScrollX(), (childAt.getTop() + f2) - view.getScrollY(), childAt, motionEvent)) {
                z = true;
                break;
            }
            childCount--;
        }
        if (!z) {
            float right = (view.getRight() + f) - view.getLeft();
            float bottom = (view.getBottom() + f2) - view.getTop();
            RectF rectF = this.f108D0;
            rectF.set(f, f2, right, bottom);
            if (motionEvent.getAction() != 0 || rectF.contains(motionEvent.getX(), motionEvent.getY())) {
                float f3 = -f;
                float f4 = -f2;
                Matrix matrix = view.getMatrix();
                if (matrix.isIdentity()) {
                    motionEvent.offsetLocation(f3, f4);
                    zOnTouchEvent = view.onTouchEvent(motionEvent);
                    motionEvent.offsetLocation(-f3, -f4);
                } else {
                    MotionEvent motionEventObtain = MotionEvent.obtain(motionEvent);
                    motionEventObtain.offsetLocation(f3, f4);
                    if (this.f112F0 == null) {
                        this.f112F0 = new Matrix();
                    }
                    matrix.invert(this.f112F0);
                    motionEventObtain.transform(this.f112F0);
                    zOnTouchEvent = view.onTouchEvent(motionEventObtain);
                    motionEventObtain.recycle();
                }
                if (zOnTouchEvent) {
                    return true;
                }
            }
        }
        return z;
    }

    /* JADX INFO: renamed from: z */
    public final void m65z(AttributeSet attributeSet) {
        C0016c c0016c;
        f100H0 = isInEditMode();
        if (attributeSet != null) {
            TypedArray typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, j1.m.r);
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            boolean z = true;
            for (int i = 0; i < indexCount; i++) {
                int index = typedArrayObtainStyledAttributes.getIndex(i);
                if (index == 2) {
                    this.f149s = new C0016c(getContext(), this, typedArrayObtainStyledAttributes.getResourceId(index, -1));
                } else if (index == 1) {
                    this.f159x = typedArrayObtainStyledAttributes.getResourceId(index, -1);
                } else if (index == 4) {
                    this.f116I = typedArrayObtainStyledAttributes.getFloat(index, 0.0f);
                    this.f118K = true;
                } else if (index == 0) {
                    z = typedArrayObtainStyledAttributes.getBoolean(index, z);
                } else if (index == 5) {
                    if (this.f120M == 0) {
                        this.f120M = typedArrayObtainStyledAttributes.getBoolean(index, false) ? 2 : 0;
                    }
                } else if (index == 3) {
                    this.f120M = typedArrayObtainStyledAttributes.getInt(index, 0);
                }
            }
            typedArrayObtainStyledAttributes.recycle();
            if (this.f149s == null) {
                Log.e("MotionLayout", "WARNING NO app:layoutDescription tag");
            }
            if (!z) {
                this.f149s = null;
            }
        }
        if (this.f120M != 0) {
            C0016c c0016c2 = this.f149s;
            if (c0016c2 == null) {
                Log.e("MotionLayout", "CHECK: motion scene not set! set \"app:layoutDescription=\"@xml/file\"");
            } else {
                int iM74h = c0016c2.m74h();
                C0016c c0016c3 = this.f149s;
                C0041d c0041dM68b = c0016c3.m68b(c0016c3.m74h());
                so.c.w(getContext(), iM74h);
                int childCount = getChildCount();
                for (int i2 = 0; i2 < childCount; i2++) {
                    View childAt = getChildAt(i2);
                    if (c0041dM68b.m144l(childAt.getId()) == null) {
                        so.c.x(childAt);
                    }
                }
                Integer[] numArr = (Integer[]) c0041dM68b.f556f.keySet().toArray(new Integer[0]);
                int length = numArr.length;
                int[] iArr = new int[length];
                for (int i3 = 0; i3 < length; i3++) {
                    iArr[i3] = numArr[i3].intValue();
                }
                for (int i4 = 0; i4 < length; i4++) {
                    int i5 = iArr[i4];
                    so.c.w(getContext(), i5);
                    findViewById(iArr[i4]);
                    int i6 = c0041dM68b.m143k(i5).f544e.d;
                    int i7 = c0041dM68b.m143k(i5).f544e.c;
                }
                SparseIntArray sparseIntArray = new SparseIntArray();
                SparseIntArray sparseIntArray2 = new SparseIntArray();
                for (h1.x xVar : this.f149s.f179d) {
                    h1.x xVar2 = this.f149s.f178c;
                    if (xVar.d == xVar.c) {
                        Log.e("MotionLayout", "CHECK: start and end constraint set should not be the same!");
                    }
                    int i8 = xVar.d;
                    int i9 = xVar.c;
                    String strW = so.c.w(getContext(), i8);
                    String strW2 = so.c.w(getContext(), i9);
                    if (sparseIntArray.get(i8) == i9) {
                        Log.e("MotionLayout", "CHECK: two transitions with the same start and end " + strW + "->" + strW2);
                    }
                    if (sparseIntArray2.get(i9) == i8) {
                        Log.e("MotionLayout", "CHECK: you can't have reverse transitions" + strW + "->" + strW2);
                    }
                    sparseIntArray.put(i8, i9);
                    sparseIntArray2.put(i9, i8);
                    if (this.f149s.m68b(i8) == null) {
                        Log.e("MotionLayout", " no such constraintSetStart " + strW);
                    }
                    if (this.f149s.m68b(i9) == null) {
                        Log.e("MotionLayout", " no such constraintSetEnd " + strW);
                    }
                }
            }
        }
        if (this.f159x != -1 || (c0016c = this.f149s) == null) {
            return;
        }
        this.f159x = c0016c.m74h();
        this.f157w = this.f149s.m74h();
        h1.x xVar3 = this.f149s.f178c;
        this.f161y = xVar3 != null ? xVar3.c : -1;
    }

    public void setTransition(h1.x xVar) {
        C0017d c0017d;
        C0016c c0016c = this.f149s;
        c0016c.f178c = xVar;
        if (xVar != null && (c0017d = xVar.l) != null) {
            c0017d.m84c(c0016c.f191p);
        }
        setState(TransitionState.SETUP);
        int i = this.f159x;
        h1.x xVar2 = this.f149s.f178c;
        if (i == (xVar2 == null ? -1 : xVar2.c)) {
            this.f113G = 1.0f;
            this.f111F = 1.0f;
            this.f116I = 1.0f;
        } else {
            this.f113G = 0.0f;
            this.f111F = 0.0f;
            this.f116I = 0.0f;
        }
        this.f115H = (xVar.r & 1) != 0 ? -1L : getNanoTime();
        int iM74h = this.f149s.m74h();
        C0016c c0016c2 = this.f149s;
        h1.x xVar3 = c0016c2.f178c;
        int i2 = xVar3 != null ? xVar3.c : -1;
        if (iM74h == this.f157w && i2 == this.f161y) {
            return;
        }
        this.f157w = iM74h;
        this.f161y = i2;
        c0016c2.m80n(iM74h, i2);
        C0041d c0041dM68b = this.f149s.m68b(this.f157w);
        C0041d c0041dM68b2 = this.f149s.m68b(this.f161y);
        s sVar = this.f104B0;
        sVar.e(c0041dM68b, c0041dM68b2);
        int i3 = this.f157w;
        int i4 = this.f161y;
        sVar.e = i3;
        sVar.f = i4;
        sVar.f();
        m42C();
    }

    public MotionLayout(@NonNull Context context, @Nullable AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f153u = null;
        this.f155v = 0.0f;
        this.f157w = -1;
        this.f159x = -1;
        this.f161y = -1;
        this.f163z = 0;
        this.f101A = 0;
        this.f103B = true;
        this.f105C = new HashMap();
        this.f107D = 0L;
        this.f109E = 1.0f;
        this.f111F = 0.0f;
        this.f113G = 0.0f;
        this.f116I = 0.0f;
        this.f118K = false;
        this.f120M = 0;
        this.f122O = false;
        this.f123P = new g1.b();
        this.f124Q = new q(this);
        this.f128U = false;
        this.f133c0 = false;
        this.f134d0 = null;
        this.f135e0 = null;
        this.f136f0 = null;
        this.f137g0 = null;
        this.f138h0 = 0;
        this.f139i0 = -1L;
        this.f140j0 = 0.0f;
        this.f141k0 = 0;
        this.f142l0 = 0.0f;
        this.f143m0 = false;
        this.f154u0 = new e(1);
        this.f156v0 = false;
        this.f160x0 = null;
        new HashMap();
        this.f162y0 = new Rect();
        this.f164z0 = false;
        this.f102A0 = TransitionState.UNDEFINED;
        this.f104B0 = new s(this);
        this.f106C0 = false;
        this.f108D0 = new RectF();
        this.f110E0 = null;
        this.f112F0 = null;
        this.f114G0 = new ArrayList();
        m65z(attributeSet);
    }

    /* JADX INFO: renamed from: androidx.constraintlayout.motion.widget.MotionLayout$2 */
    static /* synthetic */ class C00102 {

        /* JADX INFO: renamed from: $SwitchMap$androidx$constraintlayout$motion$widget$MotionLayout$TransitionState */
        static final /* synthetic */ int[] f165xabc7e4ac;

        static {
            int[] iArr = new int[TransitionState.values().length];
            f165xabc7e4ac = iArr;
            try {
                iArr[TransitionState.UNDEFINED.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f165xabc7e4ac[TransitionState.SETUP.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f165xabc7e4ac[TransitionState.MOVING.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                f165xabc7e4ac[TransitionState.FINISHED.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
        }
    }

    private static class MyTracker implements MotionTracker {

        /* JADX INFO: renamed from: me */
        private static MyTracker f166me = new MyTracker();
        VelocityTracker tracker;

        private MyTracker() {
        }

        public static MyTracker obtain() {
            f166me.tracker = VelocityTracker.obtain();
            return f166me;
        }

        @Override // androidx.constraintlayout.motion.widget.MotionLayout.MotionTracker
        public void recycle() {
            this.tracker.recycle();
            this.tracker = null;
        }

        @Override // androidx.constraintlayout.motion.widget.MotionLayout.MotionTracker
        public void clear() {
            this.tracker.clear();
        }

        @Override // androidx.constraintlayout.motion.widget.MotionLayout.MotionTracker
        public void addMovement(MotionEvent motionEvent) {
            VelocityTracker velocityTracker = this.tracker;
            if (velocityTracker != null) {
                velocityTracker.addMovement(motionEvent);
            }
        }

        @Override // androidx.constraintlayout.motion.widget.MotionLayout.MotionTracker
        public void computeCurrentVelocity(int i) {
            this.tracker.computeCurrentVelocity(i);
        }

        @Override // androidx.constraintlayout.motion.widget.MotionLayout.MotionTracker
        public void computeCurrentVelocity(int i, float f) {
            this.tracker.computeCurrentVelocity(i, f);
        }

        @Override // androidx.constraintlayout.motion.widget.MotionLayout.MotionTracker
        public float getXVelocity() {
            return this.tracker.getXVelocity();
        }

        @Override // androidx.constraintlayout.motion.widget.MotionLayout.MotionTracker
        public float getYVelocity() {
            return this.tracker.getYVelocity();
        }

        @Override // androidx.constraintlayout.motion.widget.MotionLayout.MotionTracker
        public float getXVelocity(int i) {
            return this.tracker.getXVelocity(i);
        }

        @Override // androidx.constraintlayout.motion.widget.MotionLayout.MotionTracker
        public float getYVelocity(int i) {
            return getYVelocity(i);
        }
    }

    class StateCache {
        float mProgress = Float.NaN;
        float mVelocity = Float.NaN;
        int startState = -1;
        int endState = -1;
        final String KeyProgress = "motion.progress";
        final String KeyVelocity = "motion.velocity";
        final String KeyStartState = "motion.StartState";
        final String KeyEndState = "motion.EndState";

        StateCache() {
        }

        void apply() {
            int i = this.startState;
            if (i != -1 || this.endState != -1) {
                if (i == -1) {
                    MotionLayout.this.transitionToState(this.endState);
                } else {
                    int i2 = this.endState;
                    if (i2 == -1) {
                        MotionLayout.this.setState(i, -1, -1);
                    } else {
                        MotionLayout.this.setTransition(i, i2);
                    }
                }
                MotionLayout.this.setState(TransitionState.SETUP);
            }
            if (Float.isNaN(this.mVelocity)) {
                if (Float.isNaN(this.mProgress)) {
                    return;
                }
                MotionLayout.this.setProgress(this.mProgress);
            } else {
                MotionLayout.this.setProgress(this.mProgress, this.mVelocity);
                this.mProgress = Float.NaN;
                this.mVelocity = Float.NaN;
                this.startState = -1;
                this.endState = -1;
            }
        }

        public Bundle getTransitionState() {
            Bundle bundle = new Bundle();
            bundle.putFloat("motion.progress", this.mProgress);
            bundle.putFloat("motion.velocity", this.mVelocity);
            bundle.putInt("motion.StartState", this.startState);
            bundle.putInt("motion.EndState", this.endState);
            return bundle;
        }

        public void setTransitionState(Bundle bundle) {
            this.mProgress = bundle.getFloat("motion.progress");
            this.mVelocity = bundle.getFloat("motion.velocity");
            this.startState = bundle.getInt("motion.StartState");
            this.endState = bundle.getInt("motion.EndState");
        }

        public void setProgress(float f) {
            this.mProgress = f;
        }

        public void setEndState(int i) {
            this.endState = i;
        }

        public void setVelocity(float f) {
            this.mVelocity = f;
        }

        public void setStartState(int i) {
            this.startState = i;
        }

        public void recordState() {
            this.endState = MotionLayout.access$000(MotionLayout.this);
            this.startState = MotionLayout.access$100(MotionLayout.this);
            this.mVelocity = MotionLayout.this.getVelocity();
            this.mProgress = MotionLayout.this.getProgress();
        }
    }

    class DecelerateInterpolator extends MotionInterpolator {
        float maxA;
        float initalV = 0.0f;
        float currentP = 0.0f;

        DecelerateInterpolator() {
        }

        public void config(float f, float f2, float f3) {
            this.initalV = f;
            this.currentP = f2;
            this.maxA = f3;
        }

        @Override // androidx.constraintlayout.motion.widget.MotionInterpolator, android.animation.TimeInterpolator
        public float getInterpolation(float f) {
            float f2;
            float f3;
            float f4 = this.initalV;
            if (f4 > 0.0f) {
                float f5 = this.maxA;
                if (f4 / f5 < f) {
                    f = f4 / f5;
                }
                MotionLayout.this.mLastVelocity = f4 - (f5 * f);
                f2 = (this.initalV * f) - (((this.maxA * f) * f) / 2.0f);
                f3 = this.currentP;
            } else {
                float f6 = this.maxA;
                if ((-f4) / f6 < f) {
                    f = (-f4) / f6;
                }
                MotionLayout.this.mLastVelocity = f4 + (f6 * f);
                f2 = (this.initalV * f) + (((this.maxA * f) * f) / 2.0f);
                f3 = this.currentP;
            }
            return f2 + f3;
        }

        @Override // androidx.constraintlayout.motion.widget.MotionInterpolator
        public float getVelocity() {
            return MotionLayout.this.mLastVelocity;
        }
    }

    class Model {
        int mEndId;
        int mStartId;
        ConstraintWidgetContainer mLayoutStart = new ConstraintWidgetContainer();
        ConstraintWidgetContainer mLayoutEnd = new ConstraintWidgetContainer();
        ConstraintSet mStart = null;
        ConstraintSet mEnd = null;

        Model() {
        }

        void copy(ConstraintWidgetContainer constraintWidgetContainer, ConstraintWidgetContainer constraintWidgetContainer2) {
            ConstraintWidget constraintWidget;
            ArrayList<ConstraintWidget> children = constraintWidgetContainer.getChildren();
            HashMap<ConstraintWidget, ConstraintWidget> map = new HashMap<>();
            map.put(constraintWidgetContainer, constraintWidgetContainer2);
            constraintWidgetContainer2.getChildren().clear();
            constraintWidgetContainer2.copy(constraintWidgetContainer, map);
            for (ConstraintWidget constraintWidget2 : children) {
                if (constraintWidget2 instanceof Barrier) {
                    constraintWidget = new Barrier();
                } else if (constraintWidget2 instanceof Guideline) {
                    constraintWidget = new Guideline();
                } else if (constraintWidget2 instanceof Flow) {
                    constraintWidget = new Flow();
                } else if (constraintWidget2 instanceof Helper) {
                    constraintWidget = new HelperWidget();
                } else {
                    constraintWidget = new ConstraintWidget();
                }
                constraintWidgetContainer2.add(constraintWidget);
                map.put(constraintWidget2, constraintWidget);
            }
            for (ConstraintWidget constraintWidget3 : children) {
                map.get(constraintWidget3).copy(constraintWidget3, map);
            }
        }

        void initFrom(ConstraintWidgetContainer constraintWidgetContainer, ConstraintSet constraintSet, ConstraintSet constraintSet2) {
            this.mStart = constraintSet;
            this.mEnd = constraintSet2;
            this.mLayoutStart = new ConstraintWidgetContainer();
            this.mLayoutEnd = new ConstraintWidgetContainer();
            this.mLayoutStart.setMeasurer(MotionLayout.access$200(MotionLayout.this).getMeasurer());
            this.mLayoutEnd.setMeasurer(MotionLayout.access$300(MotionLayout.this).getMeasurer());
            this.mLayoutStart.removeAllChildren();
            this.mLayoutEnd.removeAllChildren();
            copy(MotionLayout.access$400(MotionLayout.this), this.mLayoutStart);
            copy(MotionLayout.access$500(MotionLayout.this), this.mLayoutEnd);
            if (MotionLayout.this.mTransitionLastPosition > 0.5d) {
                if (constraintSet != null) {
                    setupConstraintWidget(this.mLayoutStart, constraintSet);
                }
                setupConstraintWidget(this.mLayoutEnd, constraintSet2);
            } else {
                setupConstraintWidget(this.mLayoutEnd, constraintSet2);
                if (constraintSet != null) {
                    setupConstraintWidget(this.mLayoutStart, constraintSet);
                }
            }
            this.mLayoutStart.setRtl(MotionLayout.access$600(MotionLayout.this));
            this.mLayoutStart.updateHierarchy();
            this.mLayoutEnd.setRtl(MotionLayout.access$700(MotionLayout.this));
            this.mLayoutEnd.updateHierarchy();
            ViewGroup.LayoutParams layoutParams = MotionLayout.this.getLayoutParams();
            if (layoutParams != null) {
                if (layoutParams.width == -2) {
                    this.mLayoutStart.setHorizontalDimensionBehaviour(ConstraintWidget.DimensionBehaviour.WRAP_CONTENT);
                    this.mLayoutEnd.setHorizontalDimensionBehaviour(ConstraintWidget.DimensionBehaviour.WRAP_CONTENT);
                }
                if (layoutParams.height == -2) {
                    this.mLayoutStart.setVerticalDimensionBehaviour(ConstraintWidget.DimensionBehaviour.WRAP_CONTENT);
                    this.mLayoutEnd.setVerticalDimensionBehaviour(ConstraintWidget.DimensionBehaviour.WRAP_CONTENT);
                }
            }
        }

        /* JADX WARN: Multi-variable type inference failed */
        private void setupConstraintWidget(ConstraintWidgetContainer constraintWidgetContainer, ConstraintSet constraintSet) {
            SparseArray<ConstraintWidget> sparseArray = new SparseArray<>();
            Constraints.LayoutParams layoutParams = new Constraints.LayoutParams(-2, -2);
            sparseArray.clear();
            sparseArray.put(0, constraintWidgetContainer);
            sparseArray.put(MotionLayout.this.getId(), constraintWidgetContainer);
            for (ConstraintWidget constraintWidget : constraintWidgetContainer.getChildren()) {
                sparseArray.put(((View) constraintWidget.getCompanionWidget()).getId(), constraintWidget);
            }
            for (ConstraintWidget constraintWidget2 : constraintWidgetContainer.getChildren()) {
                View view = (View) constraintWidget2.getCompanionWidget();
                constraintSet.applyToLayoutParams(view.getId(), layoutParams);
                constraintWidget2.setWidth(constraintSet.getWidth(view.getId()));
                constraintWidget2.setHeight(constraintSet.getHeight(view.getId()));
                if (view instanceof ConstraintHelper) {
                    constraintSet.applyToHelper((ConstraintHelper) view, constraintWidget2, layoutParams, sparseArray);
                    if (view instanceof androidx.constraintlayout.widget.Barrier) {
                        ((androidx.constraintlayout.widget.Barrier) view).validateParams();
                    }
                }
                layoutParams.resolveLayoutDirection(MotionLayout.this.getLayoutDirection());
                MotionLayout.access$800(MotionLayout.this, false, view, constraintWidget2, layoutParams, sparseArray);
                if (constraintSet.getVisibilityMode(view.getId()) == 1) {
                    constraintWidget2.setVisibility(view.getVisibility());
                } else {
                    constraintWidget2.setVisibility(constraintSet.getVisibility(view.getId()));
                }
            }
            for (ConstraintWidget constraintWidget3 : constraintWidgetContainer.getChildren()) {
                if (constraintWidget3 instanceof VirtualLayout) {
                    ConstraintHelper constraintHelper = (ConstraintHelper) constraintWidget3.getCompanionWidget();
                    Helper helper = (Helper) constraintWidget3;
                    constraintHelper.updatePreLayout(constraintWidgetContainer, helper, sparseArray);
                    ((VirtualLayout) helper).captureWidgets();
                }
            }
        }

        ConstraintWidget getWidget(ConstraintWidgetContainer constraintWidgetContainer, View view) {
            if (constraintWidgetContainer.getCompanionWidget() == view) {
                return constraintWidgetContainer;
            }
            ArrayList<ConstraintWidget> children = constraintWidgetContainer.getChildren();
            int size = children.size();
            for (int i = 0; i < size; i++) {
                ConstraintWidget constraintWidget = children.get(i);
                if (constraintWidget.getCompanionWidget() == view) {
                    return constraintWidget;
                }
            }
            return null;
        }

        private void debugLayoutParam(String str, ConstraintLayout.LayoutParams layoutParams) {
            String strConcat = " ".concat(layoutParams.startToStart != -1 ? "SS" : "__");
            StringBuilder sb = new StringBuilder();
            sb.append(strConcat);
            sb.append(layoutParams.startToEnd != -1 ? "|SE" : "|__");
            String string = sb.toString();
            StringBuilder sb2 = new StringBuilder();
            sb2.append(string);
            sb2.append(layoutParams.endToStart != -1 ? "|ES" : "|__");
            String string2 = sb2.toString();
            StringBuilder sb3 = new StringBuilder();
            sb3.append(string2);
            sb3.append(layoutParams.endToEnd != -1 ? "|EE" : "|__");
            String string3 = sb3.toString();
            StringBuilder sb4 = new StringBuilder();
            sb4.append(string3);
            sb4.append(layoutParams.leftToLeft != -1 ? "|LL" : "|__");
            String string4 = sb4.toString();
            StringBuilder sb5 = new StringBuilder();
            sb5.append(string4);
            sb5.append(layoutParams.leftToRight != -1 ? "|LR" : "|__");
            String string5 = sb5.toString();
            StringBuilder sb6 = new StringBuilder();
            sb6.append(string5);
            sb6.append(layoutParams.rightToLeft != -1 ? "|RL" : "|__");
            String string6 = sb6.toString();
            StringBuilder sb7 = new StringBuilder();
            sb7.append(string6);
            sb7.append(layoutParams.rightToRight != -1 ? "|RR" : "|__");
            String string7 = sb7.toString();
            StringBuilder sb8 = new StringBuilder();
            sb8.append(string7);
            sb8.append(layoutParams.topToTop != -1 ? "|TT" : "|__");
            String string8 = sb8.toString();
            StringBuilder sb9 = new StringBuilder();
            sb9.append(string8);
            sb9.append(layoutParams.topToBottom != -1 ? "|TB" : "|__");
            String string9 = sb9.toString();
            StringBuilder sb10 = new StringBuilder();
            sb10.append(string9);
            sb10.append(layoutParams.bottomToTop != -1 ? "|BT" : "|__");
            String string10 = sb10.toString();
            StringBuilder sb11 = new StringBuilder();
            sb11.append(string10);
            sb11.append(layoutParams.bottomToBottom != -1 ? "|BB" : "|__");
            Log.v("MotionLayout", str + sb11.toString());
        }

        private void debugWidget(String str, ConstraintWidget constraintWidget) {
            String strConcat;
            String strConcat2;
            String strConcat3;
            StringBuilder sb = new StringBuilder(" ");
            String strConcat4 = "__";
            if (constraintWidget.mTop.mTarget != null) {
                strConcat = "T".concat(constraintWidget.mTop.mTarget.mType == ConstraintAnchor.Type.TOP ? "T" : "B");
            } else {
                strConcat = "__";
            }
            sb.append(strConcat);
            String string = sb.toString();
            StringBuilder sb2 = new StringBuilder();
            sb2.append(string);
            if (constraintWidget.mBottom.mTarget != null) {
                strConcat2 = "B".concat(constraintWidget.mBottom.mTarget.mType != ConstraintAnchor.Type.TOP ? "B" : "T");
            } else {
                strConcat2 = "__";
            }
            sb2.append(strConcat2);
            String string2 = sb2.toString();
            StringBuilder sb3 = new StringBuilder();
            sb3.append(string2);
            if (constraintWidget.mLeft.mTarget != null) {
                strConcat3 = "L".concat(constraintWidget.mLeft.mTarget.mType == ConstraintAnchor.Type.LEFT ? "L" : "R");
            } else {
                strConcat3 = "__";
            }
            sb3.append(strConcat3);
            String string3 = sb3.toString();
            StringBuilder sb4 = new StringBuilder();
            sb4.append(string3);
            if (constraintWidget.mRight.mTarget != null) {
                strConcat4 = "R".concat(constraintWidget.mRight.mTarget.mType != ConstraintAnchor.Type.LEFT ? "R" : "L");
            }
            sb4.append(strConcat4);
            Log.v("MotionLayout", str + sb4.toString() + " ---  " + constraintWidget);
        }

        private void debugLayout(String str, ConstraintWidgetContainer constraintWidgetContainer) {
            String str2 = str + " " + Debug.getName((View) constraintWidgetContainer.getCompanionWidget());
            Log.v("MotionLayout", str2 + "  ========= " + constraintWidgetContainer);
            int size = constraintWidgetContainer.getChildren().size();
            for (int i = 0; i < size; i++) {
                String str3 = str2 + "[" + i + "] ";
                ConstraintWidget constraintWidget = constraintWidgetContainer.getChildren().get(i);
                String str4 = constraintWidget.mTop.mTarget != null ? "T" : "_";
                StringBuilder sb = new StringBuilder();
                sb.append(str4);
                sb.append(constraintWidget.mBottom.mTarget != null ? "B" : "_");
                String string = sb.toString();
                StringBuilder sb2 = new StringBuilder();
                sb2.append(string);
                sb2.append(constraintWidget.mLeft.mTarget != null ? "L" : "_");
                String string2 = sb2.toString();
                StringBuilder sb3 = new StringBuilder();
                sb3.append(string2);
                sb3.append(constraintWidget.mRight.mTarget != null ? "R" : "_");
                String string3 = sb3.toString();
                View view = (View) constraintWidget.getCompanionWidget();
                String name = Debug.getName(view);
                if (view instanceof TextView) {
                    name = name + "(" + ((Object) ((TextView) view).getText()) + ")";
                }
                Log.v("MotionLayout", str3 + "  " + name + " " + constraintWidget + " " + string3);
            }
            Log.v("MotionLayout", str2 + " done. ");
        }

        public void reEvaluateState() {
            measure(MotionLayout.access$900(MotionLayout.this), MotionLayout.access$1000(MotionLayout.this));
            MotionLayout.access$1100(MotionLayout.this);
        }

        public void measure(int i, int i2) {
            int mode = View.MeasureSpec.getMode(i);
            int mode2 = View.MeasureSpec.getMode(i2);
            MotionLayout.this.mWidthMeasureMode = mode;
            MotionLayout.this.mHeightMeasureMode = mode2;
            int optimizationLevel = MotionLayout.this.getOptimizationLevel();
            if (MotionLayout.this.mCurrentState == MotionLayout.this.getStartState()) {
                MotionLayout.access$1200(MotionLayout.this, this.mLayoutEnd, optimizationLevel, i, i2);
                if (this.mStart != null) {
                    MotionLayout.access$1300(MotionLayout.this, this.mLayoutStart, optimizationLevel, i, i2);
                }
            } else {
                if (this.mStart != null) {
                    MotionLayout.access$1400(MotionLayout.this, this.mLayoutStart, optimizationLevel, i, i2);
                }
                MotionLayout.access$1500(MotionLayout.this, this.mLayoutEnd, optimizationLevel, i, i2);
            }
            if (((MotionLayout.this.getParent() instanceof MotionLayout) && mode == 1073741824 && mode2 == 1073741824) ? false : true) {
                MotionLayout.this.mWidthMeasureMode = mode;
                MotionLayout.this.mHeightMeasureMode = mode2;
                if (MotionLayout.this.mCurrentState == MotionLayout.this.getStartState()) {
                    MotionLayout.access$1600(MotionLayout.this, this.mLayoutEnd, optimizationLevel, i, i2);
                    if (this.mStart != null) {
                        MotionLayout.access$1700(MotionLayout.this, this.mLayoutStart, optimizationLevel, i, i2);
                    }
                } else {
                    if (this.mStart != null) {
                        MotionLayout.access$1800(MotionLayout.this, this.mLayoutStart, optimizationLevel, i, i2);
                    }
                    MotionLayout.access$1900(MotionLayout.this, this.mLayoutEnd, optimizationLevel, i, i2);
                }
                MotionLayout.this.mStartWrapWidth = this.mLayoutStart.getWidth();
                MotionLayout.this.mStartWrapHeight = this.mLayoutStart.getHeight();
                MotionLayout.this.mEndWrapWidth = this.mLayoutEnd.getWidth();
                MotionLayout.this.mEndWrapHeight = this.mLayoutEnd.getHeight();
                MotionLayout motionLayout = MotionLayout.this;
                motionLayout.mMeasureDuringTransition = (motionLayout.mStartWrapWidth == MotionLayout.this.mEndWrapWidth && MotionLayout.this.mStartWrapHeight == MotionLayout.this.mEndWrapHeight) ? false : true;
            }
            int i3 = MotionLayout.this.mStartWrapWidth;
            int i4 = MotionLayout.this.mStartWrapHeight;
            if (MotionLayout.this.mWidthMeasureMode == Integer.MIN_VALUE || MotionLayout.this.mWidthMeasureMode == 0) {
                i3 = (int) (MotionLayout.this.mStartWrapWidth + (MotionLayout.this.mPostInterpolationPosition * (MotionLayout.this.mEndWrapWidth - MotionLayout.this.mStartWrapWidth)));
            }
            int i5 = i3;
            if (MotionLayout.this.mHeightMeasureMode == Integer.MIN_VALUE || MotionLayout.this.mHeightMeasureMode == 0) {
                i4 = (int) (MotionLayout.this.mStartWrapHeight + (MotionLayout.this.mPostInterpolationPosition * (MotionLayout.this.mEndWrapHeight - MotionLayout.this.mStartWrapHeight)));
            }
            MotionLayout.access$2000(MotionLayout.this, i, i2, i5, i4, this.mLayoutStart.isWidthMeasuredTooSmall() || this.mLayoutEnd.isWidthMeasuredTooSmall(), this.mLayoutStart.isHeightMeasuredTooSmall() || this.mLayoutEnd.isHeightMeasuredTooSmall());
        }

        public void build() {
            int childCount = MotionLayout.this.getChildCount();
            MotionLayout.this.mFrameArrayList.clear();
            for (int i = 0; i < childCount; i++) {
                View childAt = MotionLayout.this.getChildAt(i);
                MotionLayout.this.mFrameArrayList.put(childAt, new MotionController(childAt));
            }
            for (int i2 = 0; i2 < childCount; i2++) {
                View childAt2 = MotionLayout.this.getChildAt(i2);
                MotionController motionController = (MotionController) MotionLayout.this.mFrameArrayList.get(childAt2);
                if (motionController != null) {
                    if (this.mStart != null) {
                        ConstraintWidget widget = getWidget(this.mLayoutStart, childAt2);
                        if (widget != null) {
                            motionController.setStartState(widget, this.mStart);
                        } else if (MotionLayout.this.mDebugPath != 0) {
                            Log.e("MotionLayout", Debug.getLocation() + "no widget for  " + Debug.getName(childAt2) + " (" + childAt2.getClass().getName() + ")");
                        }
                    }
                    if (this.mEnd != null) {
                        ConstraintWidget widget2 = getWidget(this.mLayoutEnd, childAt2);
                        if (widget2 != null) {
                            motionController.setEndState(widget2, this.mEnd);
                        } else if (MotionLayout.this.mDebugPath != 0) {
                            Log.e("MotionLayout", Debug.getLocation() + "no widget for  " + Debug.getName(childAt2) + " (" + childAt2.getClass().getName() + ")");
                        }
                    }
                }
            }
        }

        public void setMeasuredId(int i, int i2) {
            this.mStartId = i;
            this.mEndId = i2;
        }

        public boolean isNotConfiguredWith(int i, int i2) {
            return (i == this.mStartId && i2 == this.mEndId) ? false : true;
        }
    }

    /* JADX INFO: renamed from: androidx.constraintlayout.motion.widget.MotionLayout$1 */
    class RunnableC00091 implements Runnable {
        final /* synthetic */ View val$target;

        RunnableC00091(View view) {
            this.val$target = view;
        }

        @Override // java.lang.Runnable
        public void run() {
            this.val$target.setNestedScrollingEnabled(true);
        }
    }

    private class DevModeDraw {
        private static final int DEBUG_PATH_TICKS_PER_MS = 16;
        DashPathEffect mDashPathEffect;
        Paint mFillPaint;
        int mKeyFrameCount;
        float[] mKeyFramePoints;
        Paint mPaint;
        Paint mPaintGraph;
        Paint mPaintKeyframes;
        Path mPath;
        int[] mPathMode;
        float[] mPoints;
        private float[] mRectangle;
        int mShadowTranslate;
        Paint mTextPaint;
        final int RED_COLOR = -21965;
        final int KEYFRAME_COLOR = -2067046;
        final int GRAPH_COLOR = -13391360;
        final int SHADOW_COLOR = 1996488704;
        final int DIAMOND_SIZE = 10;
        Rect mBounds = new Rect();
        boolean mPresentationMode = false;

        public DevModeDraw() {
            this.mShadowTranslate = 1;
            Paint paint = new Paint();
            this.mPaint = paint;
            paint.setAntiAlias(true);
            this.mPaint.setColor(-21965);
            this.mPaint.setStrokeWidth(2.0f);
            this.mPaint.setStyle(Paint.Style.STROKE);
            Paint paint2 = new Paint();
            this.mPaintKeyframes = paint2;
            paint2.setAntiAlias(true);
            this.mPaintKeyframes.setColor(-2067046);
            this.mPaintKeyframes.setStrokeWidth(2.0f);
            this.mPaintKeyframes.setStyle(Paint.Style.STROKE);
            Paint paint3 = new Paint();
            this.mPaintGraph = paint3;
            paint3.setAntiAlias(true);
            this.mPaintGraph.setColor(-13391360);
            this.mPaintGraph.setStrokeWidth(2.0f);
            this.mPaintGraph.setStyle(Paint.Style.STROKE);
            Paint paint4 = new Paint();
            this.mTextPaint = paint4;
            paint4.setAntiAlias(true);
            this.mTextPaint.setColor(-13391360);
            this.mTextPaint.setTextSize(MotionLayout.this.getContext().getResources().getDisplayMetrics().density * 12.0f);
            this.mRectangle = new float[8];
            Paint paint5 = new Paint();
            this.mFillPaint = paint5;
            paint5.setAntiAlias(true);
            DashPathEffect dashPathEffect = new DashPathEffect(new float[]{4.0f, 8.0f}, 0.0f);
            this.mDashPathEffect = dashPathEffect;
            this.mPaintGraph.setPathEffect(dashPathEffect);
            this.mKeyFramePoints = new float[100];
            this.mPathMode = new int[50];
            if (this.mPresentationMode) {
                this.mPaint.setStrokeWidth(8.0f);
                this.mFillPaint.setStrokeWidth(8.0f);
                this.mPaintKeyframes.setStrokeWidth(8.0f);
                this.mShadowTranslate = 4;
            }
        }

        public void draw(Canvas canvas, HashMap<View, MotionController> map, int i, int i2) {
            if (map == null || map.size() == 0) {
                return;
            }
            canvas.save();
            if (!MotionLayout.this.isInEditMode() && (i2 & 1) == 2) {
                String str = MotionLayout.this.getContext().getResources().getResourceName(MotionLayout.access$000(MotionLayout.this)) + ":" + MotionLayout.this.getProgress();
                canvas.drawText(str, 10.0f, MotionLayout.this.getHeight() - 30, this.mTextPaint);
                canvas.drawText(str, 11.0f, MotionLayout.this.getHeight() - 29, this.mPaint);
            }
            for (MotionController motionController : map.values()) {
                int drawPath = motionController.getDrawPath();
                if (i2 > 0 && drawPath == 0) {
                    drawPath = 1;
                }
                if (drawPath != 0) {
                    this.mKeyFrameCount = motionController.buildKeyFrames(this.mKeyFramePoints, this.mPathMode);
                    if (drawPath >= 1) {
                        int i3 = i / 16;
                        float[] fArr = this.mPoints;
                        if (fArr == null || fArr.length != i3 * 2) {
                            this.mPoints = new float[i3 * 2];
                            this.mPath = new Path();
                        }
                        int i4 = this.mShadowTranslate;
                        canvas.translate(i4, i4);
                        this.mPaint.setColor(1996488704);
                        this.mFillPaint.setColor(1996488704);
                        this.mPaintKeyframes.setColor(1996488704);
                        this.mPaintGraph.setColor(1996488704);
                        motionController.buildPath(this.mPoints, i3);
                        drawAll(canvas, drawPath, this.mKeyFrameCount, motionController);
                        this.mPaint.setColor(-21965);
                        this.mPaintKeyframes.setColor(-2067046);
                        this.mFillPaint.setColor(-2067046);
                        this.mPaintGraph.setColor(-13391360);
                        int i5 = this.mShadowTranslate;
                        canvas.translate(-i5, -i5);
                        drawAll(canvas, drawPath, this.mKeyFrameCount, motionController);
                        if (drawPath == 5) {
                            drawRectangle(canvas, motionController);
                        }
                    }
                }
            }
            canvas.restore();
        }

        public void drawAll(Canvas canvas, int i, int i2, MotionController motionController) {
            if (i == 4) {
                drawPathAsConfigured(canvas);
            }
            if (i == 2) {
                drawPathRelative(canvas);
            }
            if (i == 3) {
                drawPathCartesian(canvas);
            }
            drawBasicPath(canvas);
            drawTicks(canvas, i, i2, motionController);
        }

        private void drawBasicPath(Canvas canvas) {
            canvas.drawLines(this.mPoints, this.mPaint);
        }

        private void drawTicks(Canvas canvas, int i, int i2, MotionController motionController) {
            int width;
            int height;
            int i3;
            if (motionController.mView != null) {
                width = motionController.mView.getWidth();
                height = motionController.mView.getHeight();
            } else {
                width = 0;
                height = 0;
            }
            for (int i4 = 1; i4 < i2 - 1; i4++) {
                if (i != 4 || this.mPathMode[i4 - 1] != 0) {
                    float[] fArr = this.mKeyFramePoints;
                    int i5 = i4 * 2;
                    float f = fArr[i5];
                    float f2 = fArr[i5 + 1];
                    this.mPath.reset();
                    this.mPath.moveTo(f, f2 + 10.0f);
                    this.mPath.lineTo(f + 10.0f, f2);
                    this.mPath.lineTo(f, f2 - 10.0f);
                    this.mPath.lineTo(f - 10.0f, f2);
                    this.mPath.close();
                    int i6 = i4 - 1;
                    motionController.getKeyFrame(i6);
                    if (i == 4) {
                        int i7 = this.mPathMode[i6];
                        if (i7 == 1) {
                            drawPathRelativeTicks(canvas, f - 0.0f, f2 - 0.0f);
                        } else if (i7 == 2) {
                            drawPathCartesianTicks(canvas, f - 0.0f, f2 - 0.0f);
                        } else {
                            if (i7 == 3) {
                                i3 = 3;
                                drawPathScreenTicks(canvas, f - 0.0f, f2 - 0.0f, width, height);
                            }
                            canvas.drawPath(this.mPath, this.mFillPaint);
                        }
                        i3 = 3;
                        canvas.drawPath(this.mPath, this.mFillPaint);
                    } else {
                        f2 = f2;
                        f = f;
                        i3 = 3;
                    }
                    if (i == 2) {
                        drawPathRelativeTicks(canvas, f - 0.0f, f2 - 0.0f);
                    }
                    if (i == i3) {
                        drawPathCartesianTicks(canvas, f - 0.0f, f2 - 0.0f);
                    }
                    if (i == 6) {
                        drawPathScreenTicks(canvas, f - 0.0f, f2 - 0.0f, width, height);
                    }
                    canvas.drawPath(this.mPath, this.mFillPaint);
                }
            }
            float[] fArr2 = this.mPoints;
            if (fArr2.length > 1) {
                canvas.drawCircle(fArr2[0], fArr2[1], 8.0f, this.mPaintKeyframes);
                float[] fArr3 = this.mPoints;
                canvas.drawCircle(fArr3[fArr3.length - 2], fArr3[fArr3.length - 1], 8.0f, this.mPaintKeyframes);
            }
        }

        private void drawTranslation(Canvas canvas, float f, float f2, float f3, float f4) {
            canvas.drawRect(f, f2, f3, f4, this.mPaintGraph);
            canvas.drawLine(f, f2, f3, f4, this.mPaintGraph);
        }

        private void drawPathRelative(Canvas canvas) {
            float[] fArr = this.mPoints;
            canvas.drawLine(fArr[0], fArr[1], fArr[fArr.length - 2], fArr[fArr.length - 1], this.mPaintGraph);
        }

        private void drawPathAsConfigured(Canvas canvas) {
            boolean z = false;
            boolean z2 = false;
            for (int i = 0; i < this.mKeyFrameCount; i++) {
                int i2 = this.mPathMode[i];
                if (i2 == 1) {
                    z = true;
                }
                if (i2 == 2) {
                    z2 = true;
                }
            }
            if (z) {
                drawPathRelative(canvas);
            }
            if (z2) {
                drawPathCartesian(canvas);
            }
        }

        private void drawPathRelativeTicks(Canvas canvas, float f, float f2) {
            float[] fArr = this.mPoints;
            float f3 = fArr[0];
            float f4 = fArr[1];
            float f5 = fArr[fArr.length - 2];
            float f6 = fArr[fArr.length - 1];
            float fHypot = (float) Math.hypot(f3 - f5, f4 - f6);
            float f7 = f5 - f3;
            float f8 = f6 - f4;
            float f9 = (((f - f3) * f7) + ((f2 - f4) * f8)) / (fHypot * fHypot);
            float f10 = f3 + (f7 * f9);
            float f11 = f4 + (f9 * f8);
            Path path = new Path();
            path.moveTo(f, f2);
            path.lineTo(f10, f11);
            float fHypot2 = (float) Math.hypot(f10 - f, f11 - f2);
            String str = "" + (((int) ((fHypot2 * 100.0f) / fHypot)) / 100.0f);
            getTextBounds(str, this.mTextPaint);
            canvas.drawTextOnPath(str, path, (fHypot2 / 2.0f) - (this.mBounds.width() / 2), -20.0f, this.mTextPaint);
            canvas.drawLine(f, f2, f10, f11, this.mPaintGraph);
        }

        void getTextBounds(String str, Paint paint) {
            paint.getTextBounds(str, 0, str.length(), this.mBounds);
        }

        private void drawPathCartesian(Canvas canvas) {
            float[] fArr = this.mPoints;
            float f = fArr[0];
            float f2 = fArr[1];
            float f3 = fArr[fArr.length - 2];
            float f4 = fArr[fArr.length - 1];
            canvas.drawLine(Math.min(f, f3), Math.max(f2, f4), Math.max(f, f3), Math.max(f2, f4), this.mPaintGraph);
            canvas.drawLine(Math.min(f, f3), Math.min(f2, f4), Math.min(f, f3), Math.max(f2, f4), this.mPaintGraph);
        }

        private void drawPathCartesianTicks(Canvas canvas, float f, float f2) {
            float[] fArr = this.mPoints;
            float f3 = fArr[0];
            float f4 = fArr[1];
            float f5 = fArr[fArr.length - 2];
            float f6 = fArr[fArr.length - 1];
            float fMin = Math.min(f3, f5);
            float fMax = Math.max(f4, f6);
            float fMin2 = f - Math.min(f3, f5);
            float fMax2 = Math.max(f4, f6) - f2;
            String str = "" + (((int) (((double) ((fMin2 * 100.0f) / Math.abs(f5 - f3))) + 0.5d)) / 100.0f);
            getTextBounds(str, this.mTextPaint);
            canvas.drawText(str, ((fMin2 / 2.0f) - (this.mBounds.width() / 2)) + fMin, f2 - 20.0f, this.mTextPaint);
            canvas.drawLine(f, f2, Math.min(f3, f5), f2, this.mPaintGraph);
            String str2 = "" + (((int) (((double) ((fMax2 * 100.0f) / Math.abs(f6 - f4))) + 0.5d)) / 100.0f);
            getTextBounds(str2, this.mTextPaint);
            canvas.drawText(str2, f + 5.0f, fMax - ((fMax2 / 2.0f) - (this.mBounds.height() / 2)), this.mTextPaint);
            canvas.drawLine(f, f2, f, Math.max(f4, f6), this.mPaintGraph);
        }

        private void drawPathScreenTicks(Canvas canvas, float f, float f2, int i, int i2) {
            String str = "" + (((int) (((double) (((f - (i / 2)) * 100.0f) / (MotionLayout.this.getWidth() - i))) + 0.5d)) / 100.0f);
            getTextBounds(str, this.mTextPaint);
            canvas.drawText(str, ((f / 2.0f) - (this.mBounds.width() / 2)) + 0.0f, f2 - 20.0f, this.mTextPaint);
            canvas.drawLine(f, f2, Math.min(0.0f, 1.0f), f2, this.mPaintGraph);
            String str2 = "" + (((int) (((double) (((f2 - (i2 / 2)) * 100.0f) / (MotionLayout.this.getHeight() - i2))) + 0.5d)) / 100.0f);
            getTextBounds(str2, this.mTextPaint);
            canvas.drawText(str2, f + 5.0f, 0.0f - ((f2 / 2.0f) - (this.mBounds.height() / 2)), this.mTextPaint);
            canvas.drawLine(f, f2, f, Math.max(0.0f, 1.0f), this.mPaintGraph);
        }

        private void drawRectangle(Canvas canvas, MotionController motionController) {
            this.mPath.reset();
            for (int i = 0; i <= 50; i++) {
                motionController.buildRect(i / 50, this.mRectangle, 0);
                Path path = this.mPath;
                float[] fArr = this.mRectangle;
                path.moveTo(fArr[0], fArr[1]);
                Path path2 = this.mPath;
                float[] fArr2 = this.mRectangle;
                path2.lineTo(fArr2[2], fArr2[3]);
                Path path3 = this.mPath;
                float[] fArr3 = this.mRectangle;
                path3.lineTo(fArr3[4], fArr3[5]);
                Path path4 = this.mPath;
                float[] fArr4 = this.mRectangle;
                path4.lineTo(fArr4[6], fArr4[7]);
                this.mPath.close();
            }
            this.mPaint.setColor(1140850688);
            canvas.translate(2.0f, 2.0f);
            canvas.drawPath(this.mPath, this.mPaint);
            canvas.translate(-2.0f, -2.0f);
            this.mPaint.setColor(-65536);
            canvas.drawPath(this.mPath, this.mPaint);
        }
    }
}
