package com.google.firebase.messaging;

import android.content.Context;
import android.graphics.Typeface;
import androidx.core.view.r0;
import java.io.Serializable;
import java.lang.ref.ReferenceQueue;
import java.nio.ByteBuffer;
import java.util.ArrayDeque;
import java.util.HashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/* JADX INFO: renamed from: com.google.firebase.messaging.u */
/* JADX INFO: loaded from: classes.dex */
public final class C0088u {

    /* JADX INFO: renamed from: e */
    public static C0088u f748e;

    /* JADX INFO: renamed from: a */
    public Object f749a;

    /* JADX INFO: renamed from: b */
    public Serializable f750b;

    /* JADX INFO: renamed from: c */
    public Object f751c;

    /* JADX INFO: renamed from: d */
    public Object f752d;

    /* JADX WARN: Type inference failed for: r0v5, types: [char[], java.io.Serializable] */
    public C0088u(Typeface typeface, w2.b bVar) {
        int i;
        int i2;
        this.f752d = typeface;
        this.f749a = bVar;
        this.f751c = new v2.s(1024);
        int iA = bVar.a(6);
        if (iA != 0) {
            int i3 = iA + ((r0) bVar).a;
            i = ((ByteBuffer) ((r0) bVar).d).getInt(((ByteBuffer) ((r0) bVar).d).getInt(i3) + i3);
        } else {
            i = 0;
        }
        this.f750b = new char[i * 2];
        int iA2 = bVar.a(6);
        if (iA2 != 0) {
            int i4 = iA2 + ((r0) bVar).a;
            i2 = ((ByteBuffer) ((r0) bVar).d).getInt(((ByteBuffer) ((r0) bVar).d).getInt(i4) + i4);
        } else {
            i2 = 0;
        }
        for (int i5 = 0; i5 < i2; i5++) {
            v2.v vVar = new v2.v(this, i5);
            w2.a aVarC = vVar.c();
            int iA3 = aVarC.a(4);
            Character.toChars(iA3 != 0 ? ((ByteBuffer) ((r0) aVarC).d).getInt(iA3 + ((r0) aVarC).a) : 0, (char[]) this.f750b, i5 * 2);
            androidx.work.impl.model.f.e("invalid metadata codepoint length", vVar.b() > 0);
            ((v2.s) this.f751c).a(vVar, 0, vVar.b() - 1);
        }
    }

    /* JADX INFO: renamed from: c */
    public static synchronized C0088u m290c() {
        try {
            if (f748e == null) {
                f748e = new C0088u(0);
            }
        } catch (Throwable th) {
            throw th;
        }
        return f748e;
    }

    /* JADX INFO: renamed from: a */
    public synchronized void m291a(j6.n nVar, j6.o oVar) {
        j6.b bVar = (j6.b) ((HashMap) this.f750b).put(nVar, new j6.b(nVar, oVar, (ReferenceQueue) this.f751c));
        if (bVar != null) {
            bVar.c = null;
            bVar.clear();
        }
    }

    /* JADX INFO: renamed from: b */
    public void m292b(j6.b bVar) {
        j6.t tVar;
        synchronized (this) {
            ((HashMap) this.f750b).remove(bVar.a);
            if (bVar.b && (tVar = bVar.c) != null) {
                ((com.bumptech.glide.load.engine.c) this.f752d).e(bVar.a, new j6.o(tVar, true, false, bVar.a, (com.bumptech.glide.load.engine.c) this.f752d));
            }
        }
    }

    /* JADX INFO: renamed from: d */
    public boolean m293d(Context context) {
        if (((Boolean) this.f751c) == null) {
            this.f751c = Boolean.valueOf(context.checkCallingOrSelfPermission("android.permission.ACCESS_NETWORK_STATE") == 0);
        }
        ((Boolean) this.f750b).booleanValue();
        return ((Boolean) this.f751c).booleanValue();
    }

    /* JADX INFO: renamed from: e */
    public boolean m294e(Context context) {
        if (((Boolean) this.f750b) == null) {
            this.f750b = Boolean.valueOf(context.checkCallingOrSelfPermission("android.permission.WAKE_LOCK") == 0);
        }
        ((Boolean) this.f750b).booleanValue();
        return ((Boolean) this.f750b).booleanValue();
    }

    public C0088u(int i) {
        switch (i) {
            case 1:
                ExecutorService executorServiceNewSingleThreadExecutor = Executors.newSingleThreadExecutor(new j6.a());
                this.f750b = new HashMap();
                this.f751c = new ReferenceQueue();
                this.f749a = executorServiceNewSingleThreadExecutor;
                executorServiceNewSingleThreadExecutor.execute(new androidx.appcompat.app.u(this, 3));
                break;
            default:
                this.f749a = null;
                this.f750b = null;
                this.f751c = null;
                this.f752d = new ArrayDeque();
                break;
        }
    }
}
