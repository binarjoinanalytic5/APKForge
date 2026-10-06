package com.google.firebase.messaging;

import android.content.Context;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.PowerManager;
import android.util.Log;
import java.io.IOException;

/* JADX INFO: renamed from: com.google.firebase.messaging.d0 */
/* JADX INFO: loaded from: classes.dex */
public final class RunnableC0067d0 implements Runnable {

    /* JADX INFO: renamed from: f */
    public static final Object f697f = new Object();

    /* JADX INFO: renamed from: g */
    public static Boolean f698g;

    /* JADX INFO: renamed from: h */
    public static Boolean f699h;

    /* JADX INFO: renamed from: a */
    public final Context f700a;

    /* JADX INFO: renamed from: b */
    public final C0082o f701b;

    /* JADX INFO: renamed from: c */
    public final PowerManager.WakeLock f702c;

    /* JADX INFO: renamed from: d */
    public final C0063b0 f703d;

    /* JADX INFO: renamed from: e */
    public final long f704e;

    public RunnableC0067d0(C0063b0 c0063b0, Context context, C0082o c0082o, long j) {
        this.f703d = c0063b0;
        this.f700a = context;
        this.f704e = j;
        this.f701b = c0082o;
        this.f702c = ((PowerManager) context.getSystemService("power")).newWakeLock(1, "wake:com.google.firebase.messaging");
    }

    /* JADX INFO: renamed from: a */
    public static boolean m257a(Context context) {
        boolean zBooleanValue;
        synchronized (f697f) {
            try {
                Boolean bool = f699h;
                if (bool == null && bool == null) {
                    zBooleanValue = context.checkCallingOrSelfPermission("android.permission.ACCESS_NETWORK_STATE") == 0;
                } else {
                    zBooleanValue = bool.booleanValue();
                }
                f699h = Boolean.valueOf(zBooleanValue);
            } catch (Throwable th) {
                throw th;
            }
        }
        return zBooleanValue;
    }

    /* JADX INFO: renamed from: b */
    public static boolean m258b(Context context) {
        boolean zBooleanValue;
        synchronized (f697f) {
            try {
                Boolean bool = f698g;
                if (bool == null && bool == null) {
                    zBooleanValue = context.checkCallingOrSelfPermission("android.permission.WAKE_LOCK") == 0;
                } else {
                    zBooleanValue = bool.booleanValue();
                }
                f698g = Boolean.valueOf(zBooleanValue);
            } catch (Throwable th) {
                throw th;
            }
        }
        return zBooleanValue;
    }

    /* JADX INFO: renamed from: c */
    public final synchronized boolean m259c() {
        NetworkInfo activeNetworkInfo;
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager) this.f700a.getSystemService("connectivity");
            activeNetworkInfo = connectivityManager != null ? connectivityManager.getActiveNetworkInfo() : null;
        } catch (Throwable th) {
            throw th;
        }
        return activeNetworkInfo != null && activeNetworkInfo.isConnected();
    }

    @Override // java.lang.Runnable
    public final void run() {
        boolean zM258b;
        C0063b0 c0063b0 = this.f703d;
        Context context = this.f700a;
        boolean zM258b2 = m258b(context);
        PowerManager.WakeLock wakeLock = this.f702c;
        if (zM258b2) {
            wakeLock.acquire(AbstractC0068e.f705a);
        }
        try {
            c0063b0.m252e(true);
            if (!this.f701b.m274d()) {
                c0063b0.m252e(false);
            } else {
                if (!m257a(context) || m259c()) {
                    if (c0063b0.m253f()) {
                        c0063b0.m252e(false);
                    } else {
                        c0063b0.m254g(this.f704e);
                    }
                    if (!zM258b) {
                        return;
                    }
                    try {
                        return;
                    } catch (RuntimeException unused) {
                        return;
                    }
                }
                C0065c0 c0065c0 = new C0065c0();
                c0065c0.f695a = this;
                context.registerReceiver(c0065c0, new IntentFilter("android.net.conn.CONNECTIVITY_CHANGE"));
            }
        } catch (IOException e) {
            Log.e("FirebaseMessaging", "Failed to sync topics. Won't retry sync. " + e.getMessage());
            c0063b0.m252e(false);
        } finally {
            if (m258b(context)) {
                try {
                    wakeLock.release();
                } catch (RuntimeException unused2) {
                    Log.i("FirebaseMessaging", "TopicsSyncTask's wakelock was already released due to timeout.");
                }
            }
        }
    }
}
