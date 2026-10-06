package com.google.firebase.messaging;

/* JADX INFO: renamed from: com.google.firebase.messaging.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0060a implements dg.c {

    /* JADX INFO: renamed from: a */
    public static final C0060a f661a = new C0060a();

    /* JADX INFO: renamed from: b */
    public static final dg.b f662b;

    /* JADX INFO: renamed from: c */
    public static final dg.b f663c;

    /* JADX INFO: renamed from: d */
    public static final dg.b f664d;

    /* JADX INFO: renamed from: e */
    public static final dg.b f665e;

    /* JADX INFO: renamed from: f */
    public static final dg.b f666f;

    /* JADX INFO: renamed from: g */
    public static final dg.b f667g;

    /* JADX INFO: renamed from: h */
    public static final dg.b f668h;

    /* JADX INFO: renamed from: i */
    public static final dg.b f669i;

    /* JADX INFO: renamed from: j */
    public static final dg.b f670j;

    /* JADX INFO: renamed from: k */
    public static final dg.b f671k;

    /* JADX INFO: renamed from: l */
    public static final dg.b f672l;

    /* JADX INFO: renamed from: m */
    public static final dg.b f673m;

    /* JADX INFO: renamed from: n */
    public static final dg.b f674n;

    /* JADX INFO: renamed from: o */
    public static final dg.b f675o;

    /* JADX INFO: renamed from: p */
    public static final dg.b f676p;

    static {
        androidx.compose.animation.core.u uVarN = androidx.compose.animation.core.u.n();
        uVarN.a = 1;
        f662b = new dg.b("projectNumber", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN.m())));
        androidx.compose.animation.core.u uVarN2 = androidx.compose.animation.core.u.n();
        uVarN2.a = 2;
        f663c = new dg.b("messageId", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN2.m())));
        androidx.compose.animation.core.u uVarN3 = androidx.compose.animation.core.u.n();
        uVarN3.a = 3;
        f664d = new dg.b("instanceId", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN3.m())));
        androidx.compose.animation.core.u uVarN4 = androidx.compose.animation.core.u.n();
        uVarN4.a = 4;
        f665e = new dg.b("messageType", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN4.m())));
        androidx.compose.animation.core.u uVarN5 = androidx.compose.animation.core.u.n();
        uVarN5.a = 5;
        f666f = new dg.b("sdkPlatform", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN5.m())));
        androidx.compose.animation.core.u uVarN6 = androidx.compose.animation.core.u.n();
        uVarN6.a = 6;
        f667g = new dg.b("packageName", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN6.m())));
        androidx.compose.animation.core.u uVarN7 = androidx.compose.animation.core.u.n();
        uVarN7.a = 7;
        f668h = new dg.b("collapseKey", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN7.m())));
        androidx.compose.animation.core.u uVarN8 = androidx.compose.animation.core.u.n();
        uVarN8.a = 8;
        f669i = new dg.b("priority", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN8.m())));
        androidx.compose.animation.core.u uVarN9 = androidx.compose.animation.core.u.n();
        uVarN9.a = 9;
        f670j = new dg.b("ttl", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN9.m())));
        androidx.compose.animation.core.u uVarN10 = androidx.compose.animation.core.u.n();
        uVarN10.a = 10;
        f671k = new dg.b("topic", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN10.m())));
        androidx.compose.animation.core.u uVarN11 = androidx.compose.animation.core.u.n();
        uVarN11.a = 11;
        f672l = new dg.b("bulkId", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN11.m())));
        androidx.compose.animation.core.u uVarN12 = androidx.compose.animation.core.u.n();
        uVarN12.a = 12;
        f673m = new dg.b("event", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN12.m())));
        androidx.compose.animation.core.u uVarN13 = androidx.compose.animation.core.u.n();
        uVarN13.a = 13;
        f674n = new dg.b("analyticsLabel", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN13.m())));
        androidx.compose.animation.core.u uVarN14 = androidx.compose.animation.core.u.n();
        uVarN14.a = 14;
        f675o = new dg.b("campaignId", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN14.m())));
        androidx.compose.animation.core.u uVarN15 = androidx.compose.animation.core.u.n();
        uVarN15.a = 15;
        f676p = new dg.b("composerLabel", com.mbridge.msdk.advanced.manager.e.A(com.mbridge.msdk.advanced.manager.e.z(gg.c.class, uVarN15.m())));
    }

    /* JADX INFO: renamed from: a */
    public final void m246a(Object obj, Object obj2) {
        rg.b bVar = (rg.b) obj;
        dg.d dVar = (dg.d) obj2;
        dVar.c(f662b, bVar.a);
        dVar.a(f663c, bVar.b);
        dVar.a(f664d, bVar.c);
        dVar.a(f665e, bVar.d);
        dVar.a(f666f, bVar.e);
        dVar.a(f667g, bVar.f);
        dVar.a(f668h, bVar.g);
        dVar.d(f669i, bVar.h);
        dVar.d(f670j, bVar.i);
        dVar.a(f671k, bVar.j);
        dVar.c(f672l, 0L);
        dVar.a(f673m, bVar.k);
        dVar.a(f674n, bVar.l);
        dVar.c(f675o, 0L);
        dVar.a(f676p, bVar.m);
    }
}
