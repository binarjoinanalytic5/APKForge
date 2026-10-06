package com.google.firebase.messaging;

import com.google.android.gms.cloudmessaging.CloudMessage;
import com.google.android.gms.cloudmessaging.Rpc;
import com.google.android.gms.tasks.OnSuccessListener;

/* JADX INFO: renamed from: com.google.firebase.messaging.l */
/* JADX INFO: loaded from: classes.dex */
public final /* synthetic */ class C0079l implements OnSuccessListener {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ int f729a;

    /* JADX INFO: renamed from: b */
    public final /* synthetic */ FirebaseMessaging f730b;

    public /* synthetic */ C0079l(FirebaseMessaging firebaseMessaging, int i) {
        this.f729a = i;
        this.f730b = firebaseMessaging;
    }

    public final void onSuccess(Object obj) {
        boolean z;
        switch (this.f729a) {
            case 0:
                C0063b0 c0063b0 = (C0063b0) obj;
                if (!this.f730b.f655e.f() || c0063b0.f693h.m313a() == null) {
                    return;
                }
                synchronized (c0063b0) {
                    z = c0063b0.f692g;
                }
                if (z) {
                    return;
                }
                c0063b0.m254g(0L);
                return;
            default:
                CloudMessage cloudMessage = (CloudMessage) obj;
                com.facebook.f fVar = FirebaseMessaging.f648k;
                FirebaseMessaging firebaseMessaging = this.f730b;
                firebaseMessaging.getClass();
                if (cloudMessage != null) {
                    com.bumptech.glide.e.d0(cloudMessage.getIntent());
                    ((Rpc) firebaseMessaging.f653c.c).getProxiedNotificationData().addOnSuccessListener(firebaseMessaging.f656f, new C0079l(firebaseMessaging, 1));
                    return;
                }
                return;
        }
    }
}
