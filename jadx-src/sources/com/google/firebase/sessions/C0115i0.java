package com.google.firebase.sessions;

import android.os.Message;
import android.os.Messenger;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.LinkedBlockingDeque;
import kotlinx.coroutines.CoroutineStart;
import wakotl.coroutines.CoroutineContext;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.i0 */
/* JADX INFO: loaded from: classes.dex */
public final class C0115i0 {

    /* JADX INFO: renamed from: a */
    public final CoroutineContext f858a;

    /* JADX INFO: renamed from: b */
    public Messenger f859b;

    /* JADX INFO: renamed from: c */
    public final LinkedBlockingDeque f860c;

    /* JADX INFO: renamed from: d */
    public final ServiceConnectionC0113h0 f861d;

    public C0115i0(CoroutineContext coroutineContext) {
        Intrinsics.checkNotNullParameter(coroutineContext, "backgroundDispatcher");
        this.f858a = coroutineContext;
        this.f860c = new LinkedBlockingDeque(20);
        this.f861d = new ServiceConnectionC0113h0(this);
    }

    /* JADX INFO: renamed from: a */
    public static final Message m333a(C0115i0 c0115i0, List list, int i) {
        Object obj;
        c0115i0.getClass();
        ArrayList arrayList = new ArrayList();
        for (Object obj2 : list) {
            if (((Message) obj2).what == i) {
                arrayList.add(obj2);
            }
        }
        Iterator it = arrayList.iterator();
        if (it.hasNext()) {
            Object next = it.next();
            if (it.hasNext()) {
                long when = ((Message) next).getWhen();
                do {
                    Object next2 = it.next();
                    long when2 = ((Message) next2).getWhen();
                    if (when < when2) {
                        next = next2;
                        when = when2;
                    }
                } while (it.hasNext());
            }
            obj = next;
        } else {
            obj = null;
        }
        return (Message) obj;
    }

    /* JADX INFO: renamed from: b */
    public final void m334b(int i) {
        ArrayList arrayList = new ArrayList();
        this.f860c.drainTo(arrayList);
        Message messageObtain = Message.obtain(null, i, 0, 0);
        Intrinsics.checkNotNullExpressionValue(messageObtain, "obtain(null, messageCode, 0, 0)");
        arrayList.add(messageObtain);
        kotlinx.coroutines.g0.A(kotlinx.coroutines.g0.a(this.f858a), (CoroutineContext) null, (CoroutineStart) null, new SessionLifecycleClient$sendLifecycleEvents$1(this, arrayList, null), 3);
    }
}
