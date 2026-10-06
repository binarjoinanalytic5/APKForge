package com.google.firebase.messaging;

import android.os.Build;
import android.os.StrictMode;
import com.google.firebase.concurrent.ExecutorsRegistrar;
import java.util.Collections;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;

/* JADX INFO: renamed from: com.google.firebase.messaging.j */
/* JADX INFO: loaded from: classes.dex */
public final /* synthetic */ class C0077j implements kg.b {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ int f726a;

    public final Object get() {
        switch (this.f726a) {
            case 0:
                com.facebook.f fVar = FirebaseMessaging.f648k;
                return null;
            case 1:
                return Collections.emptySet();
            case 2:
                return null;
            case 3:
                jf.k kVar = ExecutorsRegistrar.f569a;
                StrictMode.ThreadPolicy.Builder builderDetectNetwork = new StrictMode.ThreadPolicy.Builder().detectNetwork();
                int i = Build.VERSION.SDK_INT;
                builderDetectNetwork.detectResourceMismatches();
                if (i >= 26) {
                    com.newleaf.app.android.victor.notification.s.k(builderDetectNetwork);
                }
                return new kf.f(Executors.newFixedThreadPool(4, new kf.a("Firebase Background", 10, builderDetectNetwork.penaltyLog().build())), (ScheduledExecutorService) ExecutorsRegistrar.f572d.get());
            case 4:
                jf.k kVar2 = ExecutorsRegistrar.f569a;
                return new kf.f(Executors.newFixedThreadPool(Math.max(2, Runtime.getRuntime().availableProcessors()), new kf.a("Firebase Lite", 0, new StrictMode.ThreadPolicy.Builder().detectAll().penaltyLog().build())), (ScheduledExecutorService) ExecutorsRegistrar.f572d.get());
            case 5:
                jf.k kVar3 = ExecutorsRegistrar.f569a;
                return new kf.f(Executors.newCachedThreadPool(new kf.a("Firebase Blocking", 11, (StrictMode.ThreadPolicy) null)), (ScheduledExecutorService) ExecutorsRegistrar.f572d.get());
            default:
                jf.k kVar4 = ExecutorsRegistrar.f569a;
                return Executors.newSingleThreadScheduledExecutor(new kf.a("Firebase Scheduler", 0, (StrictMode.ThreadPolicy) null));
        }
    }
}
