package com.google.firebase.sessions;

import android.app.Application;
import android.content.Context;
import android.util.Log;
import com.google.firebase.sessions.settings.C0135e;
import kotlinx.coroutines.CoroutineStart;
import wakotl.coroutines.CoroutineContext;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.k */
/* JADX INFO: loaded from: classes.dex */
public final class C0118k {

    /* JADX INFO: renamed from: a */
    public final ef.h f866a;

    /* JADX INFO: renamed from: b */
    public final C0135e f867b;

    public C0118k(ef.h hVar, C0135e c0135e, CoroutineContext coroutineContext, InterfaceC0119k0 interfaceC0119k0) {
        Intrinsics.checkNotNullParameter(hVar, "firebaseApp");
        Intrinsics.checkNotNullParameter(c0135e, "settings");
        Intrinsics.checkNotNullParameter(coroutineContext, "backgroundDispatcher");
        Intrinsics.checkNotNullParameter(interfaceC0119k0, "lifecycleServiceBinder");
        this.f866a = hVar;
        this.f867b = c0135e;
        hVar.a();
        Context applicationContext = hVar.a.getApplicationContext();
        if (applicationContext instanceof Application) {
            ((Application) applicationContext).registerActivityLifecycleCallbacks(C0123m0.f870a);
            kotlinx.coroutines.g0.A(kotlinx.coroutines.g0.a(coroutineContext), (CoroutineContext) null, (CoroutineStart) null, new FirebaseSessions$1(this, coroutineContext, interfaceC0119k0, null), 3);
        } else {
            Log.e("FirebaseSessions", "Failed to register lifecycle callbacks, unexpected context " + applicationContext.getClass() + '.');
        }
    }
}
