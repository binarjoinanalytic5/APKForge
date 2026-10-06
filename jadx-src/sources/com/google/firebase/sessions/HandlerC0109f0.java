package com.google.firebase.sessions;

import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import kotlinx.coroutines.CoroutineStart;
import wakotl.coroutines.CoroutineContext;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.f0 */
/* JADX INFO: loaded from: classes.dex */
public final class HandlerC0109f0 extends Handler {

    /* JADX INFO: renamed from: a */
    public final CoroutineContext f841a;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public HandlerC0109f0(CoroutineContext coroutineContext) {
        super(Looper.getMainLooper());
        Intrinsics.checkNotNullParameter(coroutineContext, "backgroundDispatcher");
        this.f841a = coroutineContext;
    }

    @Override // android.os.Handler
    public final void handleMessage(Message message) {
        String string;
        Intrinsics.checkNotNullParameter(message, "msg");
        if (message.what != 3) {
            message.toString();
            super.handleMessage(message);
            return;
        }
        Bundle data = message.getData();
        if (data == null || (string = data.getString("SessionUpdateExtra")) == null) {
            string = "";
        }
        kotlinx.coroutines.g0.A(kotlinx.coroutines.g0.a(this.f841a), (CoroutineContext) null, (CoroutineStart) null, new SessionLifecycleClient$ClientUpdateHandler$handleSessionUpdate$1(string, null), 3);
    }
}
