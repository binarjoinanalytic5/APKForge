package com.google.firebase.messaging;

import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.PowerManager;
import android.util.Log;
import com.google.android.gms.common.util.concurrent.NamedThreadFactory;
import java.io.IOException;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: renamed from: com.google.firebase.messaging.x */
/* JADX INFO: loaded from: classes.dex */
public final class RunnableC0091x implements Runnable {

    /* JADX INFO: renamed from: a */
    public final long f764a;

    /* JADX INFO: renamed from: b */
    public final PowerManager.WakeLock f765b;

    /* JADX INFO: renamed from: c */
    public final FirebaseMessaging f766c;

    /* JADX INFO: renamed from: d */
    public final ThreadPoolExecutor f767d = new ThreadPoolExecutor(0, 1, 30L, TimeUnit.SECONDS, (BlockingQueue<Runnable>) new LinkedBlockingQueue(), (ThreadFactory) new NamedThreadFactory("firebase-iid-executor"));

    public RunnableC0091x(FirebaseMessaging firebaseMessaging, long j) {
        this.f766c = firebaseMessaging;
        this.f764a = j;
        PowerManager.WakeLock wakeLockNewWakeLock = ((PowerManager) firebaseMessaging.f652b.getSystemService("power")).newWakeLock(1, "fiid-sync");
        this.f765b = wakeLockNewWakeLock;
        wakeLockNewWakeLock.setReferenceCounted(false);
    }

    /* JADX INFO: renamed from: a */
    public final boolean m311a() {
        ConnectivityManager connectivityManager = (ConnectivityManager) this.f766c.f652b.getSystemService("connectivity");
        NetworkInfo activeNetworkInfo = connectivityManager != null ? connectivityManager.getActiveNetworkInfo() : null;
        return activeNetworkInfo != null && activeNetworkInfo.isConnected();
    }

    /* JADX INFO: renamed from: b */
    public final boolean m312b() throws IOException {
        try {
            if (this.f766c.m239a() != null) {
                return true;
            }
            Log.e("FirebaseMessaging", "Token retrieval failed: null");
            return false;
        } catch (IOException e) {
            String message = e.getMessage();
            if ("SERVICE_NOT_AVAILABLE".equals(message) || "INTERNAL_SERVER_ERROR".equals(message) || "InternalServerError".equals(message)) {
                e.getMessage();
                return false;
            }
            if (e.getMessage() == null) {
                return false;
            }
            throw e;
        } catch (SecurityException unused) {
            return false;
        }
    }

    @Override // java.lang.Runnable
    public final void run() {
        C0088u c0088uM290c = C0088u.m290c();
        FirebaseMessaging firebaseMessaging = this.f766c;
        boolean zM294e = c0088uM290c.m294e(firebaseMessaging.f652b);
        PowerManager.WakeLock wakeLock = this.f765b;
        if (zM294e) {
            wakeLock.acquire();
        }
        try {
            try {
                synchronized (firebaseMessaging) {
                    firebaseMessaging.f659i = true;
                }
                if (!firebaseMessaging.f658h.m274d()) {
                    firebaseMessaging.m241e(false);
                    if (C0088u.m290c().m294e(firebaseMessaging.f652b)) {
                        wakeLock.release();
                        return;
                    }
                    return;
                }
                if (C0088u.m290c().m293d(firebaseMessaging.f652b) && !m311a()) {
                    new androidx.appcompat.app.g0(this).a();
                    if (C0088u.m290c().m294e(firebaseMessaging.f652b)) {
                        wakeLock.release();
                        return;
                    }
                    return;
                }
                if (m312b()) {
                    firebaseMessaging.m241e(false);
                } else {
                    firebaseMessaging.m243g(this.f764a);
                }
                if (!C0088u.m290c().m294e(firebaseMessaging.f652b)) {
                    return;
                }
                wakeLock.release();
            } catch (IOException e) {
                Log.e("FirebaseMessaging", "Topic sync or token retrieval failed on hard failure exceptions: " + e.getMessage() + ". Won't retry the operation.");
                firebaseMessaging.m241e(false);
                if (!C0088u.m290c().m294e(firebaseMessaging.f652b)) {
                }
            }
        } catch (Throwable th) {
            if (C0088u.m290c().m294e(firebaseMessaging.f652b)) {
                wakeLock.release();
            }
            throw th;
        }
    }
}
