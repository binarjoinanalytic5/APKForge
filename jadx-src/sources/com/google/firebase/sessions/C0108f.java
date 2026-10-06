package com.google.firebase.sessions;

/* JADX INFO: renamed from: com.google.firebase.sessions.f */
/* JADX INFO: loaded from: classes.dex */
public final class C0108f implements dg.c {

    /* JADX INFO: renamed from: a */
    public static final C0108f f836a = new C0108f();

    /* JADX INFO: renamed from: b */
    public static final dg.b f837b = dg.b.a("processName");

    /* JADX INFO: renamed from: c */
    public static final dg.b f838c = dg.b.a("pid");

    /* JADX INFO: renamed from: d */
    public static final dg.b f839d = dg.b.a("importance");

    /* JADX INFO: renamed from: e */
    public static final dg.b f840e = dg.b.a("defaultProcess");

    /* JADX INFO: renamed from: a */
    public final void m330a(Object obj, Object obj2) {
        C0127p c0127p = (C0127p) obj;
        dg.d dVar = (dg.d) obj2;
        dVar.a(f837b, c0127p.f877a);
        dVar.d(f838c, c0127p.f878b);
        dVar.d(f839d, c0127p.f879c);
        dVar.e(f840e, c0127p.f880d);
    }
}
