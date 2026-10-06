package com.google.firebase.crashlytics.ndk;

import android.content.Context;
import com.google.firebase.components.ComponentRegistrar;
import com.google.firebase.messaging.C0089v;
import java.util.Arrays;
import java.util.List;
import jf.e;
import jf.i;
import pf.g;

/* JADX INFO: loaded from: classes.dex */
public class CrashlyticsNdkRegistrar implements ComponentRegistrar {
    @Override // com.google.firebase.components.ComponentRegistrar
    public final List getComponents() {
        jf.a aVarA = jf.b.a(mf.a.class);
        aVarA.a = "fire-cls-ndk";
        aVarA.a(i.a(Context.class));
        aVarA.f = new e() { // from class: com.google.firebase.crashlytics.ndk.a
            /* JADX INFO: renamed from: f */
            public final Object m216f(C0089v c0089v) {
                this.f626a.getClass();
                Context context = (Context) c0089v.m297a(Context.class);
                return new ag.b(new ag.a(context, new JniNativeApi(context), new vf.c(context)), !(g.e(context, "com.google.firebase.crashlytics.unity_version", "string") != 0));
            }
        };
        aVarA.c(2);
        return Arrays.asList(aVarA.b(), com.bumptech.glide.e.K("fire-cls-ndk", "19.4.0"));
    }
}
