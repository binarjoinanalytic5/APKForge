package com.google.firebase.messaging;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Color;
import android.os.Bundle;
import android.text.TextUtils;
import androidx.constraintlayout.solver.widgets.Optimizer;
import java.util.Arrays;
import java.util.MissingFormatArgumentException;
import org.json.JSONArray;
import org.json.JSONException;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.messaging.p */
/* JADX INFO: loaded from: classes.dex */
public final class C0083p {

    /* JADX INFO: renamed from: a */
    public final Bundle f741a;

    public C0083p(Context context) {
        Intrinsics.checkNotNullParameter(context, "context");
        Bundle bundle = context.getPackageManager().getApplicationInfo(context.getPackageName(), Optimizer.OPTIMIZATION_GRAPH_WRAP).metaData;
        this.f741a = bundle == null ? Bundle.EMPTY : bundle;
    }

    /* JADX INFO: renamed from: k */
    public static boolean m277k(Bundle bundle) {
        return "1".equals(bundle.getString("gcm.n.e")) || "1".equals(bundle.getString("gcm.n.e".replace("gcm.n.", "gcm.notification.")));
    }

    /* JADX INFO: renamed from: m */
    public static void m278m(String str) {
        if (str.startsWith("gcm.n.")) {
            str.substring(6);
        }
    }

    /* JADX INFO: renamed from: a */
    public boolean m279a(String str) {
        String strM287i = m287i(str);
        return "1".equals(strM287i) || Boolean.parseBoolean(strM287i);
    }

    /* JADX INFO: renamed from: b */
    public Integer m280b(String str) {
        String strM287i = m287i(str);
        if (TextUtils.isEmpty(strM287i)) {
            return null;
        }
        try {
            return Integer.valueOf(Integer.parseInt(strM287i));
        } catch (NumberFormatException unused) {
            m278m(str);
            return null;
        }
    }

    /* JADX INFO: renamed from: c */
    public JSONArray m281c(String str) {
        String strM287i = m287i(str);
        if (TextUtils.isEmpty(strM287i)) {
            return null;
        }
        try {
            return new JSONArray(strM287i);
        } catch (JSONException unused) {
            m278m(str);
            return null;
        }
    }

    /* JADX INFO: renamed from: d */
    public int[] m282d() {
        JSONArray jSONArrayM281c = m281c("gcm.n.light_settings");
        if (jSONArrayM281c == null) {
            return null;
        }
        int[] iArr = new int[3];
        try {
            if (jSONArrayM281c.length() != 3) {
                throw new JSONException("lightSettings don't have all three fields");
            }
            int color = Color.parseColor(jSONArrayM281c.optString(0));
            if (color == -16777216) {
                throw new IllegalArgumentException("Transparent color is invalid");
            }
            iArr[0] = color;
            iArr[1] = jSONArrayM281c.optInt(1);
            iArr[2] = jSONArrayM281c.optInt(2);
            return iArr;
        } catch (IllegalArgumentException e) {
            jSONArrayM281c.toString();
            e.getMessage();
            return null;
        } catch (JSONException unused) {
            jSONArrayM281c.toString();
            return null;
        }
    }

    /* JADX INFO: renamed from: e */
    public Object[] m283e(String str) {
        JSONArray jSONArrayM281c = m281c(str.concat("_loc_args"));
        if (jSONArrayM281c == null) {
            return null;
        }
        int length = jSONArrayM281c.length();
        String[] strArr = new String[length];
        for (int i = 0; i < length; i++) {
            strArr[i] = jSONArrayM281c.optString(i);
        }
        return strArr;
    }

    /* JADX INFO: renamed from: f */
    public String m284f(String str) {
        return m287i(str.concat("_loc_key"));
    }

    /* JADX INFO: renamed from: g */
    public String m285g(Resources resources, String str, String str2) {
        String strM287i = m287i(str2);
        if (!TextUtils.isEmpty(strM287i)) {
            return strM287i;
        }
        String strM284f = m284f(str2);
        if (TextUtils.isEmpty(strM284f)) {
            return null;
        }
        int identifier = resources.getIdentifier(strM284f, "string", str);
        if (identifier == 0) {
            m278m(str2.concat("_loc_key"));
            return null;
        }
        Object[] objArrM283e = m283e(str2);
        if (objArrM283e == null) {
            return resources.getString(identifier);
        }
        try {
            return resources.getString(identifier, objArrM283e);
        } catch (MissingFormatArgumentException unused) {
            m278m(str2);
            Arrays.toString(objArrM283e);
            return null;
        }
    }

    /* JADX INFO: renamed from: h */
    public Boolean m286h() {
        Bundle bundle = this.f741a;
        if (bundle.containsKey("firebase_sessions_enabled")) {
            return Boolean.valueOf(bundle.getBoolean("firebase_sessions_enabled"));
        }
        return null;
    }

    /* JADX INFO: renamed from: i */
    public String m287i(String str) {
        Bundle bundle = this.f741a;
        if (!bundle.containsKey(str) && str.startsWith("gcm.n.")) {
            String strReplace = !str.startsWith("gcm.n.") ? str : str.replace("gcm.n.", "gcm.notification.");
            if (bundle.containsKey(strReplace)) {
                str = strReplace;
            }
        }
        return bundle.getString(str);
    }

    /* JADX INFO: renamed from: j */
    public long[] m288j() {
        JSONArray jSONArrayM281c = m281c("gcm.n.vibrate_timings");
        if (jSONArrayM281c == null) {
            return null;
        }
        try {
            if (jSONArrayM281c.length() <= 1) {
                throw new JSONException("vibrateTimings have invalid length");
            }
            int length = jSONArrayM281c.length();
            long[] jArr = new long[length];
            for (int i = 0; i < length; i++) {
                jArr[i] = jSONArrayM281c.optLong(i);
            }
            return jArr;
        } catch (NumberFormatException | JSONException unused) {
            jSONArrayM281c.toString();
            return null;
        }
    }

    /* JADX INFO: renamed from: l */
    public Bundle m289l() {
        Bundle bundle = this.f741a;
        Bundle bundle2 = new Bundle(bundle);
        for (String str : bundle.keySet()) {
            if (!str.startsWith("google.c.a.") && !str.equals("from")) {
                bundle2.remove(str);
            }
        }
        return bundle2;
    }

    public C0083p(Bundle bundle) {
        if (bundle != null) {
            this.f741a = new Bundle(bundle);
            return;
        }
        throw new NullPointerException("data");
    }
}
