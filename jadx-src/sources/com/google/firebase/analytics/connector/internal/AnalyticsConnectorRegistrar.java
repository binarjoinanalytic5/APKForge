package com.google.firebase.analytics.connector.internal;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Bundle;
import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import androidx.appcompat.app.s;
import com.bumptech.glide.e;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.internal.measurement.zzed;
import com.google.firebase.components.ComponentRegistrar;
import ef.h;
import gf.a;
import gf.b;
import java.util.Arrays;
import java.util.List;
import jf.c;
import jf.i;
import jf.j;

/* JADX INFO: loaded from: classes.dex */
@Keep
@KeepForSdk
public class AnalyticsConnectorRegistrar implements ComponentRegistrar {
    public static a lambda$getComponents$0(c cVar) {
        h hVar = (h) cVar.a(h.class);
        Context context = (Context) cVar.a(Context.class);
        j jVar = (hg.c) cVar.a(hg.c.class);
        Preconditions.checkNotNull(hVar);
        Preconditions.checkNotNull(context);
        Preconditions.checkNotNull(jVar);
        Preconditions.checkNotNull(context.getApplicationContext());
        if (b.c == null) {
            synchronized (b.class) {
                try {
                    if (b.c == null) {
                        Bundle bundle = new Bundle(1);
                        hVar.a();
                        if ("[DEFAULT]".equals(hVar.b)) {
                            jVar.a(new s(3), new com.moloco.sdk.acm.db.a(17));
                            bundle.putBoolean("dataCollectionDefaultEnabled", hVar.g());
                        }
                        b.c = new b(zzed.zza(context, (String) null, (String) null, (String) null, bundle).zzb());
                    }
                } catch (Throwable th) {
                    throw th;
                }
            }
        }
        return b.c;
    }

    @Override // com.google.firebase.components.ComponentRegistrar
    @NonNull
    @Keep
    @SuppressLint({"MissingPermission"})
    @KeepForSdk
    public List<jf.b> getComponents() {
        jf.a aVarA = jf.b.a(a.class);
        aVarA.a(i.a(h.class));
        aVarA.a(i.a(Context.class));
        aVarA.a(i.a(hg.c.class));
        aVarA.f = new com.moloco.sdk.acm.db.a(20);
        aVarA.c(2);
        return Arrays.asList(aVarA.b(), e.K("fire-analytics", "22.2.0"));
    }
}
