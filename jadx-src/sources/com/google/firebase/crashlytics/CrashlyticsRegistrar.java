package com.google.firebase.crashlytics;

import com.bumptech.glide.e;
import com.google.firebase.components.ComponentRegistrar;
import com.google.firebase.sessions.api.C0097a;
import com.google.firebase.sessions.api.C0098b;
import com.google.firebase.sessions.api.SessionSubscriber$Name;
import ef.h;
import if.a;
import if.b;
import if.c;
import j$.util.Objects;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import jf.i;
import jf.o;
import lg.d;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: loaded from: classes.dex */
public class CrashlyticsRegistrar implements ComponentRegistrar {

    /* JADX INFO: renamed from: d */
    public static final /* synthetic */ int f582d = 0;

    /* JADX INFO: renamed from: a */
    public final o f583a = new o(a.class, ExecutorService.class);

    /* JADX INFO: renamed from: b */
    public final o f584b = new o(b.class, ExecutorService.class);

    /* JADX INFO: renamed from: c */
    public final o f585c = new o(c.class, ExecutorService.class);

    static {
        SessionSubscriber$Name sessionSubscriber$Name = SessionSubscriber$Name.CRASHLYTICS;
        C0098b c0098b = C0098b.f791a;
        Intrinsics.checkNotNullParameter(sessionSubscriber$Name, "subscriberName");
        if (sessionSubscriber$Name == SessionSubscriber$Name.PERFORMANCE) {
            throw new IllegalArgumentException("Incompatible versions of Firebase Perf and Firebase Sessions.\nA safe combination would be:\n  firebase-sessions:1.1.0\n  firebase-crashlytics:18.5.0\n  firebase-perf:20.5.0\nFor more information contact Firebase Support.");
        }
        Map map = C0098b.f792b;
        if (map.containsKey(sessionSubscriber$Name)) {
            Objects.toString(sessionSubscriber$Name);
            return;
        }
        Intrinsics.checkNotNullExpressionValue(map, "dependencies");
        map.put(sessionSubscriber$Name, new C0097a(new kotlinx.coroutines.sync.a(true)));
        Objects.toString(sessionSubscriber$Name);
    }

    @Override // com.google.firebase.components.ComponentRegistrar
    public final List getComponents() {
        jf.a aVarA = jf.b.a(FirebaseCrashlytics.class);
        aVarA.a = "fire-cls";
        aVarA.a(i.a(h.class));
        aVarA.a(i.a(d.class));
        aVarA.a(new i(this.f583a, 1, 0));
        aVarA.a(new i(this.f584b, 1, 0));
        aVarA.a(new i(this.f585c, 1, 0));
        aVarA.a(new i(mf.a.class, 0, 2));
        aVarA.a(new i(gf.a.class, 0, 2));
        aVarA.a(new i(tg.a.class, 0, 2));
        aVarA.f = new f(this, 15);
        aVarA.c(2);
        return Arrays.asList(aVarA.b(), e.K("fire-cls", "19.4.0"));
    }
}
