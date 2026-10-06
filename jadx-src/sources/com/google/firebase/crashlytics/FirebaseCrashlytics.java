package com.google.firebase.crashlytics;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.applovin.impl.o9;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.crashlytics.internal.common.C0053a;
import ef.h;
import lf.c;
import pf.n;
import pf.p;

/* JADX INFO: loaded from: classes.dex */
public class FirebaseCrashlytics {

    /* JADX INFO: renamed from: a */
    public final p f586a;

    public FirebaseCrashlytics(p pVar) {
        this.f586a = pVar;
    }

    @NonNull
    public static FirebaseCrashlytics getInstance() {
        FirebaseCrashlytics firebaseCrashlytics = (FirebaseCrashlytics) h.c().b(FirebaseCrashlytics.class);
        if (firebaseCrashlytics != null) {
            return firebaseCrashlytics;
        }
        throw new NullPointerException("FirebaseCrashlytics component is not present.");
    }

    @NonNull
    public Task<Boolean> checkForUnsentReports() {
        C0053a c0053a = this.f586a.h;
        return !c0053a.f608r.compareAndSet(false, true) ? Tasks.forResult(Boolean.FALSE) : c0053a.f605o.getTask();
    }

    public void deleteUnsentReports() {
        C0053a c0053a = this.f586a.h;
        c0053a.f606p.trySetResult(Boolean.FALSE);
        c0053a.f607q.getTask();
    }

    public boolean didCrashOnPreviousExecution() {
        return this.f586a.g;
    }

    /* JADX WARN: Unreachable blocks removed: 2, instructions: 4 */
    public boolean isCrashlyticsCollectionEnabled() {
        return false;
    }

    public void log(@NonNull String str) {
        p pVar = this.f586a;
        pVar.p.f610a.a(new o9(pVar, System.currentTimeMillis() - pVar.d, str));
    }

    /* JADX WARN: Unreachable blocks removed: 4, instructions: 11 */
    public void recordException(@NonNull Throwable th) {
    }

    /* JADX WARN: Unreachable blocks removed: 2, instructions: 8 */
    public void sendUnsentReports() {
    }

    public void setCrashlyticsCollectionEnabled(boolean z) {
        this.f586a.d(false);
    }

    public void setCustomKey(@NonNull String str, boolean z) {
        this.f586a.e(str, Boolean.toString(z));
    }

    public void setCustomKeys(@NonNull c cVar) {
        throw null;
    }

    public void setUserId(@NonNull String str) {
        p pVar = this.f586a;
        pVar.p.f610a.a(new n(1, pVar, str));
    }

    public void setCrashlyticsCollectionEnabled(@Nullable Boolean bool) {
        this.f586a.d(Boolean.FALSE);
    }

    public void setCustomKey(@NonNull String str, double d) {
        this.f586a.e(str, Double.toString(d));
    }

    public void setCustomKey(@NonNull String str, float f) {
        this.f586a.e(str, Float.toString(f));
    }

    /* JADX WARN: Unreachable blocks removed: 4, instructions: 4 */
    public void recordException(@NonNull Throwable th, @NonNull c cVar) {
    }

    public void setCustomKey(@NonNull String str, int i) {
        this.f586a.e(str, Integer.toString(i));
    }

    public void setCustomKey(@NonNull String str, long j) {
        this.f586a.e(str, Long.toString(j));
    }

    public void setCustomKey(@NonNull String str, @NonNull String str2) {
        this.f586a.e(str, str2);
    }
}
