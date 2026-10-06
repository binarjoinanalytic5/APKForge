package com.google.firebase.messaging;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.util.Log;
import com.google.android.gms.common.stats.ConnectionTracker;
import com.google.android.gms.tasks.Task;
import j$.util.Objects;
import java.util.ArrayDeque;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: renamed from: com.google.firebase.messaging.h0 */
/* JADX INFO: loaded from: classes.dex */
public final class ServiceConnectionC0075h0 implements ServiceConnection {

    /* JADX INFO: renamed from: a */
    public final Context f719a;

    /* JADX INFO: renamed from: b */
    public final Intent f720b;

    /* JADX INFO: renamed from: c */
    public final ScheduledThreadPoolExecutor f721c;

    /* JADX INFO: renamed from: d */
    public final ArrayDeque f722d;

    /* JADX INFO: renamed from: e */
    public BinderC0071f0 f723e;

    /* JADX INFO: renamed from: f */
    public boolean f724f;

    public ServiceConnectionC0075h0(Context context) {
        ScheduledThreadPoolExecutor scheduledThreadPoolExecutor = new ScheduledThreadPoolExecutor(1);
        scheduledThreadPoolExecutor.setKeepAliveTime(40L, TimeUnit.SECONDS);
        scheduledThreadPoolExecutor.allowCoreThreadTimeOut(true);
        this.f722d = new ArrayDeque();
        this.f724f = false;
        Context applicationContext = context.getApplicationContext();
        this.f719a = applicationContext;
        this.f720b = new Intent("com.google.firebase.MESSAGING_EVENT").setPackage(applicationContext.getPackageName());
        this.f721c = scheduledThreadPoolExecutor;
    }

    /* JADX INFO: renamed from: a */
    public final synchronized void m266a() {
        while (!this.f722d.isEmpty()) {
            try {
                BinderC0071f0 binderC0071f0 = this.f723e;
                if (binderC0071f0 == null || !binderC0071f0.isBinderAlive()) {
                    if (!this.f724f) {
                        this.f724f = true;
                        try {
                            if (!ConnectionTracker.getInstance().bindService(this.f719a, this.f720b, this, 65)) {
                                Log.e("FirebaseMessaging", "binding to the service failed");
                                this.f724f = false;
                                while (true) {
                                    ArrayDeque arrayDeque = this.f722d;
                                    if (arrayDeque.isEmpty()) {
                                        break;
                                    } else {
                                        ((C0073g0) arrayDeque.poll()).f714b.trySetResult((Object) null);
                                    }
                                }
                            }
                        } catch (SecurityException e) {
                            Log.e("FirebaseMessaging", "Exception while binding the service", e);
                        }
                    }
                    return;
                }
                this.f723e.m263a((C0073g0) this.f722d.poll());
            } catch (Throwable th) {
                throw th;
            }
        }
    }

    /* JADX INFO: renamed from: b */
    public final synchronized Task m267b(Intent intent) {
        C0073g0 c0073g0;
        c0073g0 = new C0073g0(intent);
        ScheduledThreadPoolExecutor scheduledThreadPoolExecutor = this.f721c;
        c0073g0.f714b.getTask().addOnCompleteListener(scheduledThreadPoolExecutor, new f(scheduledThreadPoolExecutor.schedule((Runnable) new androidx.activity.r(c0073g0, 12), 20L, TimeUnit.SECONDS), 5));
        this.f722d.add(c0073g0);
        m266a();
        return c0073g0.f714b.getTask();
    }

    @Override // android.content.ServiceConnection
    public final synchronized void onServiceConnected(ComponentName componentName, IBinder iBinder) {
        try {
            if (Log.isLoggable("FirebaseMessaging", 3)) {
                Objects.toString(componentName);
            }
            this.f724f = false;
            if (iBinder instanceof BinderC0071f0) {
                this.f723e = (BinderC0071f0) iBinder;
                m266a();
                return;
            }
            Log.e("FirebaseMessaging", "Invalid service connection: " + iBinder);
            while (true) {
                ArrayDeque arrayDeque = this.f722d;
                if (arrayDeque.isEmpty()) {
                    return;
                } else {
                    ((C0073g0) arrayDeque.poll()).f714b.trySetResult((Object) null);
                }
            }
        } catch (Throwable th) {
            throw th;
        }
    }

    @Override // android.content.ServiceConnection
    public final void onServiceDisconnected(ComponentName componentName) {
        if (Log.isLoggable("FirebaseMessaging", 3)) {
            Objects.toString(componentName);
        }
        m266a();
    }
}
