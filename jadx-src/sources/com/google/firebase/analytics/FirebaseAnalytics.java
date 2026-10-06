package com.google.firebase.analytics;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.internal.measurement.zzed;
import com.google.android.gms.measurement.internal.zzlm;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.installations.C0059a;
import ef.h;
import ff.a;
import ff.b;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import lg.d;

/* JADX INFO: loaded from: classes.dex */
public final class FirebaseAnalytics {

    /* JADX INFO: renamed from: c */
    public static volatile FirebaseAnalytics f566c;

    /* JADX INFO: renamed from: a */
    public final zzed f567a;

    /* JADX INFO: renamed from: b */
    public a f568b;

    public enum ConsentStatus {
        GRANTED,
        DENIED
    }

    public enum ConsentType {
        AD_STORAGE,
        ANALYTICS_STORAGE,
        AD_USER_DATA,
        AD_PERSONALIZATION
    }

    public FirebaseAnalytics(zzed zzedVar) {
        Preconditions.checkNotNull(zzedVar);
        this.f567a = zzedVar;
    }

    @NonNull
    @Keep
    public static FirebaseAnalytics getInstance(@NonNull Context context) {
        if (f566c == null) {
            synchronized (FirebaseAnalytics.class) {
                try {
                    if (f566c == null) {
                        f566c = new FirebaseAnalytics(zzed.zza(context));
                    }
                } catch (Throwable th) {
                    throw th;
                }
            }
        }
        return f566c;
    }

    @Nullable
    @Keep
    public static zzlm getScionFrontendApiImplementation(Context context, @Nullable Bundle bundle) {
        zzed zzedVarZza = zzed.zza(context, (String) null, (String) null, (String) null, bundle);
        if (zzedVarZza == null) {
            return null;
        }
        return new b(zzedVarZza);
    }

    /* JADX WARN: Unreachable blocks removed: 2, instructions: 3 */
    /* JADX INFO: renamed from: a */
    public final void m199a(Bundle bundle, String str) {
    }

    @NonNull
    @Keep
    public final String getFirebaseInstanceId() {
        try {
            Object obj = C0059a.f631m;
            h hVarC = h.c();
            Preconditions.checkArgument(true, "Null is not a valid value of FirebaseApp.");
            return (String) Tasks.await(((C0059a) hVarC.b(d.class)).m225d(), 30000L, TimeUnit.MILLISECONDS);
        } catch (InterruptedException e) {
            throw new IllegalStateException(e);
        } catch (ExecutionException e2) {
            throw new IllegalStateException(e2.getCause());
        } catch (TimeoutException unused) {
            throw new IllegalThreadStateException("Firebase Installations getId Task has timed out.");
        }
    }

    @Keep
    @Deprecated
    public final void setCurrentScreen(@NonNull Activity activity, @Nullable String str, @Nullable String str2) {
        this.f567a.zza(activity, str, str2);
    }
}
