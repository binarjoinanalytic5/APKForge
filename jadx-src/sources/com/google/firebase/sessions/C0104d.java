package com.google.firebase.sessions;

/* JADX INFO: renamed from: com.google.firebase.sessions.d */
/* JADX INFO: loaded from: classes.dex */
public final class C0104d implements dg.c {

    /* JADX INFO: renamed from: a */
    public static final C0104d f813a = new C0104d();

    /* JADX INFO: renamed from: b */
    public static final dg.b f814b = dg.b.a("appId");

    /* JADX INFO: renamed from: c */
    public static final dg.b f815c = dg.b.a("deviceModel");

    /* JADX INFO: renamed from: d */
    public static final dg.b f816d = dg.b.a("sessionSdkVersion");

    /* JADX INFO: renamed from: e */
    public static final dg.b f817e = dg.b.a("osVersion");

    /* JADX INFO: renamed from: f */
    public static final dg.b f818f = dg.b.a("logEnvironment");

    /* JADX INFO: renamed from: g */
    public static final dg.b f819g = dg.b.a("androidAppInfo");

    /* JADX INFO: renamed from: a */
    public final void m327a(Object obj, Object obj2) {
        C0100b c0100b = (C0100b) obj;
        dg.d dVar = (dg.d) obj2;
        dVar.a(f814b, c0100b.f794a);
        dVar.a(f815c, c0100b.f795b);
        dVar.a(f816d, "2.0.8");
        dVar.a(f817e, c0100b.f796c);
        dVar.a(f818f, c0100b.f797d);
        dVar.a(f819g, c0100b.f798e);
    }
}
