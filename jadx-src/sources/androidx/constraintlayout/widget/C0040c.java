package androidx.constraintlayout.widget;

import android.view.ViewGroup;
import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import j1.f;
import j1.g;
import j1.h;
import j1.i;
import j1.j;
import java.util.HashMap;

/* JADX INFO: renamed from: androidx.constraintlayout.widget.c */
/* JADX INFO: loaded from: classes.dex */
public final class C0040c {

    /* JADX INFO: renamed from: a */
    public int f540a;

    /* JADX INFO: renamed from: b */
    public String f541b;

    /* JADX INFO: renamed from: c */
    public final i f542c;

    /* JADX INFO: renamed from: d */
    public final h f543d;

    /* JADX INFO: renamed from: e */
    public final g f544e;

    /* JADX INFO: renamed from: f */
    public final j f545f;

    /* JADX INFO: renamed from: g */
    public HashMap f546g;

    /* JADX INFO: renamed from: h */
    public f f547h;

    public C0040c() {
        i iVar = new i();
        iVar.a = false;
        iVar.b = 0;
        iVar.c = 0;
        iVar.d = 1.0f;
        iVar.e = Float.NaN;
        this.f542c = iVar;
        h hVar = new h();
        hVar.a = false;
        hVar.b = -1;
        hVar.c = 0;
        hVar.d = null;
        hVar.e = -1;
        hVar.f = 0;
        hVar.g = Float.NaN;
        hVar.h = Float.NaN;
        hVar.i = Float.NaN;
        hVar.j = -1;
        hVar.k = null;
        hVar.l = -3;
        hVar.m = -1;
        this.f543d = hVar;
        g gVar = new g();
        gVar.a = false;
        gVar.b = false;
        gVar.e = -1;
        gVar.f = -1;
        gVar.g = -1.0f;
        gVar.h = true;
        gVar.i = -1;
        gVar.j = -1;
        gVar.k = -1;
        gVar.l = -1;
        gVar.m = -1;
        gVar.n = -1;
        gVar.o = -1;
        gVar.p = -1;
        gVar.q = -1;
        gVar.r = -1;
        gVar.s = -1;
        gVar.t = -1;
        gVar.u = -1;
        gVar.v = -1;
        gVar.w = -1;
        gVar.x = 0.5f;
        gVar.y = 0.5f;
        gVar.z = null;
        gVar.A = -1;
        gVar.B = 0;
        gVar.C = 0.0f;
        gVar.D = -1;
        gVar.E = -1;
        gVar.F = -1;
        gVar.G = 0;
        gVar.H = 0;
        gVar.I = 0;
        gVar.J = 0;
        gVar.K = 0;
        gVar.L = 0;
        gVar.M = 0;
        gVar.N = BasicMeasure.AT_MOST;
        gVar.O = BasicMeasure.AT_MOST;
        gVar.P = BasicMeasure.AT_MOST;
        gVar.Q = BasicMeasure.AT_MOST;
        gVar.R = BasicMeasure.AT_MOST;
        gVar.S = BasicMeasure.AT_MOST;
        gVar.T = BasicMeasure.AT_MOST;
        gVar.U = -1.0f;
        gVar.V = -1.0f;
        gVar.W = 0;
        gVar.X = 0;
        gVar.Y = 0;
        gVar.Z = 0;
        gVar.a0 = 0;
        gVar.b0 = 0;
        gVar.c0 = 0;
        gVar.d0 = 0;
        gVar.e0 = 1.0f;
        gVar.f0 = 1.0f;
        gVar.g0 = -1;
        gVar.h0 = 0;
        gVar.i0 = -1;
        gVar.m0 = false;
        gVar.n0 = false;
        gVar.o0 = true;
        gVar.p0 = 0;
        this.f544e = gVar;
        j jVar = new j();
        jVar.a = false;
        jVar.b = 0.0f;
        jVar.c = 0.0f;
        jVar.d = 0.0f;
        jVar.e = 1.0f;
        jVar.f = 1.0f;
        jVar.g = Float.NaN;
        jVar.h = Float.NaN;
        jVar.i = -1;
        jVar.j = 0.0f;
        jVar.k = 0.0f;
        jVar.l = 0.0f;
        jVar.m = false;
        jVar.n = 0.0f;
        this.f545f = jVar;
        this.f546g = new HashMap();
    }

    /* JADX INFO: renamed from: b */
    public static void m122b(C0040c c0040c, ConstraintHelper constraintHelper, int i, Constraints.LayoutParams layoutParams) {
        c0040c.m127g(i, layoutParams);
        if (constraintHelper instanceof Barrier) {
            g gVar = c0040c.f544e;
            gVar.i0 = 1;
            Barrier barrier = (Barrier) constraintHelper;
            gVar.g0 = barrier.getType();
            gVar.j0 = barrier.getReferencedIds();
            gVar.h0 = barrier.getMargin();
        }
    }

    /* JADX INFO: renamed from: d */
    public final void m124d(ConstraintLayout.LayoutParams layoutParams) {
        g gVar = this.f544e;
        layoutParams.f408e = gVar.i;
        layoutParams.f410f = gVar.j;
        layoutParams.f412g = gVar.k;
        layoutParams.f414h = gVar.l;
        layoutParams.f416i = gVar.m;
        layoutParams.f418j = gVar.n;
        layoutParams.f420k = gVar.o;
        layoutParams.f422l = gVar.p;
        layoutParams.f424m = gVar.q;
        layoutParams.f426n = gVar.r;
        layoutParams.f428o = gVar.s;
        layoutParams.f435s = gVar.t;
        layoutParams.f436t = gVar.u;
        layoutParams.f437u = gVar.v;
        layoutParams.f438v = gVar.w;
        ((ViewGroup.MarginLayoutParams) layoutParams).leftMargin = gVar.G;
        ((ViewGroup.MarginLayoutParams) layoutParams).rightMargin = gVar.H;
        ((ViewGroup.MarginLayoutParams) layoutParams).topMargin = gVar.I;
        ((ViewGroup.MarginLayoutParams) layoutParams).bottomMargin = gVar.J;
        layoutParams.f374A = gVar.S;
        layoutParams.f375B = gVar.R;
        layoutParams.f440x = gVar.O;
        layoutParams.f442z = gVar.Q;
        layoutParams.f378E = gVar.x;
        layoutParams.f379F = gVar.y;
        layoutParams.f430p = gVar.A;
        layoutParams.f432q = gVar.B;
        layoutParams.f434r = gVar.C;
        layoutParams.f380G = gVar.z;
        layoutParams.f393T = gVar.D;
        layoutParams.f394U = gVar.E;
        layoutParams.f382I = gVar.U;
        layoutParams.f381H = gVar.V;
        layoutParams.f384K = gVar.X;
        layoutParams.f383J = gVar.W;
        layoutParams.f396W = gVar.m0;
        layoutParams.f397X = gVar.n0;
        layoutParams.f385L = gVar.Y;
        layoutParams.f386M = gVar.Z;
        layoutParams.f389P = gVar.a0;
        layoutParams.f390Q = gVar.b0;
        layoutParams.f387N = gVar.c0;
        layoutParams.f388O = gVar.d0;
        layoutParams.f391R = gVar.e0;
        layoutParams.f392S = gVar.f0;
        layoutParams.f395V = gVar.F;
        layoutParams.f404c = gVar.g;
        layoutParams.f400a = gVar.e;
        layoutParams.f402b = gVar.f;
        ((ViewGroup.MarginLayoutParams) layoutParams).width = gVar.c;
        ((ViewGroup.MarginLayoutParams) layoutParams).height = gVar.d;
        String str = gVar.l0;
        if (str != null) {
            layoutParams.f398Y = str;
        }
        layoutParams.f399Z = gVar.p0;
        layoutParams.setMarginStart(gVar.L);
        layoutParams.setMarginEnd(gVar.K);
        layoutParams.m116a();
    }

    /* JADX INFO: renamed from: e, reason: merged with bridge method [inline-methods] */
    public final C0040c clone() {
        C0040c c0040c = new C0040c();
        c0040c.f544e.a(this.f544e);
        c0040c.f543d.a(this.f543d);
        c0040c.f542c.a(this.f542c);
        c0040c.f545f.a(this.f545f);
        c0040c.f540a = this.f540a;
        c0040c.f547h = this.f547h;
        return c0040c;
    }

    /* JADX INFO: renamed from: f */
    public final void m126f(int i, ConstraintLayout.LayoutParams layoutParams) {
        this.f540a = i;
        int i2 = layoutParams.f408e;
        g gVar = this.f544e;
        gVar.i = i2;
        gVar.j = layoutParams.f410f;
        gVar.k = layoutParams.f412g;
        gVar.l = layoutParams.f414h;
        gVar.m = layoutParams.f416i;
        gVar.n = layoutParams.f418j;
        gVar.o = layoutParams.f420k;
        gVar.p = layoutParams.f422l;
        gVar.q = layoutParams.f424m;
        gVar.r = layoutParams.f426n;
        gVar.s = layoutParams.f428o;
        gVar.t = layoutParams.f435s;
        gVar.u = layoutParams.f436t;
        gVar.v = layoutParams.f437u;
        gVar.w = layoutParams.f438v;
        gVar.x = layoutParams.f378E;
        gVar.y = layoutParams.f379F;
        gVar.z = layoutParams.f380G;
        gVar.A = layoutParams.f430p;
        gVar.B = layoutParams.f432q;
        gVar.C = layoutParams.f434r;
        gVar.D = layoutParams.f393T;
        gVar.E = layoutParams.f394U;
        gVar.F = layoutParams.f395V;
        gVar.g = layoutParams.f404c;
        gVar.e = layoutParams.f400a;
        gVar.f = layoutParams.f402b;
        gVar.c = ((ViewGroup.MarginLayoutParams) layoutParams).width;
        gVar.d = ((ViewGroup.MarginLayoutParams) layoutParams).height;
        gVar.G = ((ViewGroup.MarginLayoutParams) layoutParams).leftMargin;
        gVar.H = ((ViewGroup.MarginLayoutParams) layoutParams).rightMargin;
        gVar.I = ((ViewGroup.MarginLayoutParams) layoutParams).topMargin;
        gVar.J = ((ViewGroup.MarginLayoutParams) layoutParams).bottomMargin;
        gVar.M = layoutParams.f377D;
        gVar.U = layoutParams.f382I;
        gVar.V = layoutParams.f381H;
        gVar.X = layoutParams.f384K;
        gVar.W = layoutParams.f383J;
        gVar.m0 = layoutParams.f396W;
        gVar.n0 = layoutParams.f397X;
        gVar.Y = layoutParams.f385L;
        gVar.Z = layoutParams.f386M;
        gVar.a0 = layoutParams.f389P;
        gVar.b0 = layoutParams.f390Q;
        gVar.c0 = layoutParams.f387N;
        gVar.d0 = layoutParams.f388O;
        gVar.e0 = layoutParams.f391R;
        gVar.f0 = layoutParams.f392S;
        gVar.l0 = layoutParams.f398Y;
        gVar.O = layoutParams.f440x;
        gVar.Q = layoutParams.f442z;
        gVar.N = layoutParams.f439w;
        gVar.P = layoutParams.f441y;
        gVar.S = layoutParams.f374A;
        gVar.R = layoutParams.f375B;
        gVar.T = layoutParams.f376C;
        gVar.p0 = layoutParams.f399Z;
        gVar.K = layoutParams.getMarginEnd();
        gVar.L = layoutParams.getMarginStart();
    }

    /* JADX INFO: renamed from: g */
    public final void m127g(int i, Constraints.LayoutParams layoutParams) {
        m126f(i, layoutParams);
        this.f542c.d = layoutParams.f448r0;
        float f = layoutParams.f451u0;
        j jVar = this.f545f;
        jVar.b = f;
        jVar.c = layoutParams.f452v0;
        jVar.d = layoutParams.f453w0;
        jVar.e = layoutParams.f454x0;
        jVar.f = layoutParams.f455y0;
        jVar.g = layoutParams.f456z0;
        jVar.h = layoutParams.f444A0;
        jVar.j = layoutParams.f445B0;
        jVar.k = layoutParams.f446C0;
        jVar.l = layoutParams.f447D0;
        jVar.n = layoutParams.f450t0;
        jVar.m = layoutParams.f449s0;
    }
}
