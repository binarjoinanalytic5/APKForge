package com.google.firebase.sessions;

import android.content.Context;
import java.util.concurrent.atomic.AtomicReference;
import kotlinx.coroutines.CoroutineStart;
import wakotl.coroutines.CoroutineContext;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.x */
/* JADX INFO: loaded from: classes.dex */
public final class C0141x implements InterfaceC0129r {

    /* JADX INFO: renamed from: e */
    public static final C0137t f915e = new C0137t();

    /* JADX INFO: renamed from: f */
    public static final androidx.datastore.preferences.b f916f = androidx.datastore.preferences.a.a(AbstractC0128q.f881a, new kotlinx.serialization.json.internal.o(SessionDatastoreImpl$Companion$dataStore$2.INSTANCE), 12);

    /* JADX INFO: renamed from: a */
    public final Context f917a;

    /* JADX INFO: renamed from: b */
    public final CoroutineContext f918b;

    /* JADX INFO: renamed from: c */
    public final AtomicReference f919c;

    /* JADX INFO: renamed from: d */
    public final C0140w f920d;

    public C0141x(Context context, CoroutineContext coroutineContext) {
        Intrinsics.checkNotNullParameter(context, "context");
        Intrinsics.checkNotNullParameter(coroutineContext, "backgroundDispatcher");
        this.f917a = context;
        this.f918b = coroutineContext;
        this.f919c = new AtomicReference();
        f915e.getClass();
        this.f920d = new C0140w(new kotlinx.coroutines.flow.d0(((androidx.datastore.core.h) f916f.getValue(context, C0137t.f908a[0])).getData(), new SessionDatastoreImpl$firebaseSessionDataFlow$1(null)), this, 0);
        kotlinx.coroutines.g0.A(kotlinx.coroutines.g0.a(coroutineContext), (CoroutineContext) null, (CoroutineStart) null, new SessionDatastoreImpl$1(this, null), 3);
    }
}
