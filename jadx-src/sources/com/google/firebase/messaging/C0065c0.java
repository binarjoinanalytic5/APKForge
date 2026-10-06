package com.google.firebase.messaging;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import java.util.concurrent.TimeUnit;

/* JADX INFO: renamed from: com.google.firebase.messaging.c0 */
/* JADX INFO: loaded from: classes.dex */
public final class C0065c0 extends BroadcastReceiver {

    /* JADX INFO: renamed from: a */
    public RunnableC0067d0 f695a;

    @Override // android.content.BroadcastReceiver
    public final synchronized void onReceive(Context context, Intent intent) {
        RunnableC0067d0 runnableC0067d0 = this.f695a;
        if (runnableC0067d0 == null) {
            return;
        }
        if (runnableC0067d0.m259c()) {
            RunnableC0067d0 runnableC0067d1 = this.f695a;
            runnableC0067d1.f703d.f691f.schedule(runnableC0067d1, 0L, TimeUnit.SECONDS);
            context.unregisterReceiver(this);
            this.f695a = null;
        }
    }
}
