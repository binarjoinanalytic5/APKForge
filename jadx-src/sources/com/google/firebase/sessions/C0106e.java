package com.google.firebase.sessions;

/* JADX INFO: renamed from: com.google.firebase.sessions.e */
/* JADX INFO: loaded from: classes.dex */
public final class C0106e implements dg.c {

    /* JADX INFO: renamed from: a */
    public static final C0106e f825a = new C0106e();

    /* JADX INFO: renamed from: b */
    public static final dg.b f826b = dg.b.a("performance");

    /* JADX INFO: renamed from: c */
    public static final dg.b f827c = dg.b.a("crashlytics");

    /* JADX INFO: renamed from: d */
    public static final dg.b f828d = dg.b.a("sessionSamplingRate");

    /* JADX INFO: renamed from: a */
    public final void m329a(Object obj, Object obj2) {
        C0114i c0114i = (C0114i) obj;
        dg.d dVar = (dg.d) obj2;
        dVar.a(f826b, c0114i.f855a);
        dVar.a(f827c, c0114i.f856b);
        dVar.b(f828d, c0114i.f857c);
    }
}
