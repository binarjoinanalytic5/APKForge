package com.google.firebase.crashlytics.internal.settings;

import android.content.Context;
import android.util.Log;
import androidx.work.impl.model.l;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.crashlytics.internal.concurrency.C0054a;
import java.util.concurrent.atomic.AtomicReference;
import kotlinx.serialization.json.internal.c0;
import kotlinx.serialization.json.internal.o;
import org.json.JSONObject;
import pf.s;
import t3.h;
import xf.b;
import xf.c;

/* JADX INFO: renamed from: com.google.firebase.crashlytics.internal.settings.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0055a {

    /* JADX INFO: renamed from: a */
    public final Context f614a;

    /* JADX INFO: renamed from: b */
    public final c f615b;

    /* JADX INFO: renamed from: c */
    public final o f616c;

    /* JADX INFO: renamed from: d */
    public final l3.c f617d;

    /* JADX INFO: renamed from: e */
    public final o f618e;

    /* JADX INFO: renamed from: f */
    public final c0 f619f;

    /* JADX INFO: renamed from: g */
    public final s f620g;

    /* JADX INFO: renamed from: h */
    public final AtomicReference f621h;

    /* JADX INFO: renamed from: i */
    public final AtomicReference f622i;

    public C0055a(Context context, c cVar, l3.c cVar2, o oVar, o oVar2, c0 c0Var, s sVar) {
        AtomicReference atomicReference = new AtomicReference();
        this.f621h = atomicReference;
        this.f622i = new AtomicReference(new TaskCompletionSource());
        this.f614a = context;
        this.f615b = cVar;
        this.f617d = cVar2;
        this.f616c = oVar;
        this.f618e = oVar2;
        this.f619f = c0Var;
        this.f620g = sVar;
        atomicReference.set(h.c(cVar2));
    }

    /* JADX INFO: renamed from: a */
    public final b m211a(SettingsCacheBehavior settingsCacheBehavior) {
        JSONObject jSONObjectO;
        try {
            if (SettingsCacheBehavior.SKIP_CACHE_LOOKUP.equals(settingsCacheBehavior) || (jSONObjectO = this.f618e.O()) == null) {
                return null;
            }
            b bVarN = this.f616c.N(jSONObjectO);
            jSONObjectO.toString();
            this.f617d.getClass();
            long jCurrentTimeMillis = System.currentTimeMillis();
            if (SettingsCacheBehavior.IGNORE_CACHE_EXPIRATION.equals(settingsCacheBehavior) || bVarN.c >= jCurrentTimeMillis) {
                return bVarN;
            }
            return null;
        } catch (Exception e) {
            Log.e("FirebaseCrashlytics", "Failed to get cached settings", e);
            return null;
        }
    }

    /* JADX INFO: renamed from: b */
    public final b m212b() {
        return (b) this.f621h.get();
    }

    /* JADX INFO: renamed from: c */
    public final Task m213c(C0054a c0054a) {
        Task task;
        b bVarM211a;
        SettingsCacheBehavior settingsCacheBehavior = SettingsCacheBehavior.USE_CACHE;
        boolean zEquals = this.f614a.getSharedPreferences("com.google.firebase.crashlytics", 0).getString("existing_instance_identifier", "").equals(this.f615b.f);
        AtomicReference atomicReference = this.f622i;
        AtomicReference atomicReference2 = this.f621h;
        if (zEquals && (bVarM211a = m211a(settingsCacheBehavior)) != null) {
            atomicReference2.set(bVarM211a);
            ((TaskCompletionSource) atomicReference.get()).trySetResult(bVarM211a);
            return Tasks.forResult((Object) null);
        }
        b bVarM211a2 = m211a(SettingsCacheBehavior.IGNORE_CACHE_EXPIRATION);
        if (bVarM211a2 != null) {
            atomicReference2.set(bVarM211a2);
            ((TaskCompletionSource) atomicReference.get()).trySetResult(bVarM211a2);
        }
        s sVar = this.f620g;
        Task task2 = sVar.g.getTask();
        synchronized (sVar.c) {
            task = sVar.d.getTask();
        }
        return qf.a.a(task2, task).onSuccessTask(c0054a.f610a, new l(this, c0054a, false));
    }
}
