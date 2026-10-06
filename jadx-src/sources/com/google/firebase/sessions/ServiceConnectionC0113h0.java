package com.google.firebase.sessions;

import android.content.ComponentName;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.Messenger;
import java.util.ArrayList;
import kotlinx.coroutines.CoroutineStart;
import wakotl.coroutines.CoroutineContext;

/* JADX INFO: renamed from: com.google.firebase.sessions.h0 */
/* JADX INFO: loaded from: classes.dex */
public final class ServiceConnectionC0113h0 implements ServiceConnection {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ C0115i0 f854a;

    public ServiceConnectionC0113h0(C0115i0 c0115i0) {
        this.f854a = c0115i0;
    }

    @Override // android.content.ServiceConnection
    public final void onServiceConnected(ComponentName componentName, IBinder iBinder) {
        C0115i0 c0115i0 = this.f854a;
        c0115i0.f860c.size();
        c0115i0.f859b = new Messenger(iBinder);
        ArrayList arrayList = new ArrayList();
        c0115i0.f860c.drainTo(arrayList);
        kotlinx.coroutines.g0.A(kotlinx.coroutines.g0.a(c0115i0.f858a), (CoroutineContext) null, (CoroutineStart) null, new SessionLifecycleClient$sendLifecycleEvents$1(c0115i0, arrayList, null), 3);
    }

    @Override // android.content.ServiceConnection
    public final void onServiceDisconnected(ComponentName componentName) {
        C0115i0 c0115i0 = this.f854a;
        c0115i0.f859b = null;
        c0115i0.getClass();
    }
}
