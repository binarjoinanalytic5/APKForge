package com.google.firebase.messaging;

import android.text.TextUtils;
import java.util.concurrent.TimeUnit;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: renamed from: com.google.firebase.messaging.w */
/* JADX INFO: loaded from: classes.dex */
public final class C0090w {

    /* JADX INFO: renamed from: d */
    public static final long f759d = TimeUnit.DAYS.toMillis(7);

    /* JADX INFO: renamed from: e */
    public static final /* synthetic */ int f760e = 0;

    /* JADX INFO: renamed from: a */
    public final String f761a;

    /* JADX INFO: renamed from: b */
    public final String f762b;

    /* JADX INFO: renamed from: c */
    public final long f763c;

    public C0090w(String str, String str2, long j) {
        this.f761a = str;
        this.f762b = str2;
        this.f763c = j;
    }

    /* JADX INFO: renamed from: a */
    public static C0090w m310a(String str) {
        if (TextUtils.isEmpty(str)) {
            return null;
        }
        if (!str.startsWith("{")) {
            return new C0090w(str, null, 0L);
        }
        try {
            JSONObject jSONObject = new JSONObject(str);
            return new C0090w(jSONObject.getString("token"), jSONObject.getString("appVersion"), jSONObject.getLong("timestamp"));
        } catch (JSONException e) {
            e.toString();
            return null;
        }
    }
}
