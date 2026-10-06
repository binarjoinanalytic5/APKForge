package com.google.firebase.sessions.settings;

import android.net.Uri;
import com.google.firebase.sessions.C0095a;
import com.google.firebase.sessions.C0100b;
import java.net.URL;
import wakotl.coroutines.CoroutineContext;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.settings.b */
/* JADX INFO: loaded from: classes.dex */
public final class C0132b {

    /* JADX INFO: renamed from: a */
    public final C0100b f889a;

    /* JADX INFO: renamed from: b */
    public final CoroutineContext f890b;

    public C0132b(C0100b c0100b, CoroutineContext coroutineContext) {
        Intrinsics.checkNotNullParameter(c0100b, "appInfo");
        Intrinsics.checkNotNullParameter(coroutineContext, "blockingDispatcher");
        Intrinsics.checkNotNullParameter("firebase-settings.crashlytics.com", "baseUrl");
        this.f889a = c0100b;
        this.f890b = coroutineContext;
    }

    /* JADX INFO: renamed from: a */
    public static final URL m343a(C0132b c0132b) {
        c0132b.getClass();
        Uri.Builder builderAppendPath = new Uri.Builder().scheme("https").authority("firebase-settings.crashlytics.com").appendPath("spi").appendPath("v2").appendPath("platforms").appendPath("android").appendPath("gmp");
        C0100b c0100b = c0132b.f889a;
        Uri.Builder builderAppendPath2 = builderAppendPath.appendPath(c0100b.f794a).appendPath("settings");
        C0095a c0095a = c0100b.f798e;
        return new URL(builderAppendPath2.appendQueryParameter("build_version", c0095a.f783c).appendQueryParameter("display_version", c0095a.f782b).build().toString());
    }
}
