package com.google.firebase.sessions;

/* JADX INFO: renamed from: com.google.firebase.sessions.h */
/* JADX INFO: loaded from: classes.dex */
public final class C0112h implements dg.c {

    /* JADX INFO: renamed from: a */
    public static final C0112h f846a = new C0112h();

    /* JADX INFO: renamed from: b */
    public static final dg.b f847b = dg.b.a("sessionId");

    /* JADX INFO: renamed from: c */
    public static final dg.b f848c = dg.b.a("firstSessionId");

    /* JADX INFO: renamed from: d */
    public static final dg.b f849d = dg.b.a("sessionIndex");

    /* JADX INFO: renamed from: e */
    public static final dg.b f850e = dg.b.a("eventTimestampUs");

    /* JADX INFO: renamed from: f */
    public static final dg.b f851f = dg.b.a("dataCollectionStatus");

    /* JADX INFO: renamed from: g */
    public static final dg.b f852g = dg.b.a("firebaseInstallationId");

    /* JADX INFO: renamed from: h */
    public static final dg.b f853h = dg.b.a("firebaseAuthenticationToken");

    /* JADX INFO: renamed from: a */
    public final void m332a(Object obj, Object obj2) {
        C0107e0 c0107e0 = (C0107e0) obj;
        dg.d dVar = (dg.d) obj2;
        dVar.a(f847b, c0107e0.f829a);
        dVar.a(f848c, c0107e0.f830b);
        dVar.d(f849d, c0107e0.f831c);
        dVar.c(f850e, c0107e0.f832d);
        dVar.a(f851f, c0107e0.f833e);
        dVar.a(f852g, c0107e0.f834f);
        dVar.a(f853h, c0107e0.f835g);
    }
}
