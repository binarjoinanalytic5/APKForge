package com.google.firebase.messaging;

import android.content.Context;
import android.content.SharedPreferences;
import com.google.android.gms.tasks.OnSuccessListener;

/* JADX INFO: renamed from: com.google.firebase.messaging.s */
/* JADX INFO: loaded from: classes.dex */
public final /* synthetic */ class C0086s implements OnSuccessListener {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ Context f746a;

    /* JADX INFO: renamed from: b */
    public final /* synthetic */ boolean f747b;

    public /* synthetic */ C0086s(Context context, boolean z) {
        this.f746a = context;
        this.f747b = z;
    }

    public final void onSuccess(Object obj) {
        SharedPreferences.Editor editorEdit = com.facebook.appevents.g.n(this.f746a).edit();
        editorEdit.putBoolean("proxy_retention", this.f747b);
        editorEdit.apply();
    }
}
