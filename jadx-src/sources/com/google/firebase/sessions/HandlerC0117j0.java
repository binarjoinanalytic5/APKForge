package com.google.firebase.sessions;

import android.os.Bundle;
import android.os.DeadObjectException;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import com.google.firebase.sessions.settings.C0133c;
import com.google.firebase.sessions.settings.C0135e;
import j$.util.Objects;
import java.util.ArrayList;
import kotlinx.coroutines.CoroutineStart;
import wakotl.coroutines.CoroutineContext;
import wakotl.jvm.internal.Intrinsics;
import wakotl.time.DurationUnit;

/* JADX INFO: renamed from: com.google.firebase.sessions.j0 */
/* JADX INFO: loaded from: classes.dex */
public final class HandlerC0117j0 extends Handler {

    /* JADX INFO: renamed from: a */
    public boolean f863a;

    /* JADX INFO: renamed from: b */
    public long f864b;

    /* JADX INFO: renamed from: c */
    public final ArrayList f865c;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public HandlerC0117j0(Looper looper) {
        super(looper);
        Intrinsics.checkNotNullParameter(looper, "looper");
        this.f865c = new ArrayList();
    }

    /* JADX INFO: renamed from: a */
    public final void m336a(Messenger messenger) {
        if (this.f863a) {
            Object objB = androidx.work.impl.model.f.k().b(C0105d0.class);
            Intrinsics.checkNotNullExpressionValue(objB, "Firebase.app[SessionGenerator::class.java]");
            C0142y c0142y = ((C0105d0) objB).f824e;
            if (c0142y != null) {
                m338c(messenger, c0142y.f921a);
                return;
            } else {
                Intrinsics.j("currentSession");
                throw null;
            }
        }
        Object objB2 = androidx.work.impl.model.f.k().b(InterfaceC0129r.class);
        Intrinsics.checkNotNullExpressionValue(objB2, "Firebase.app[SessionDatastore::class.java]");
        C0120l c0120l = (C0120l) ((C0141x) ((InterfaceC0129r) objB2)).f919c.get();
        String str = c0120l != null ? c0120l.f868a : null;
        if (str != null) {
            m338c(messenger, str);
        }
    }

    /* JADX INFO: renamed from: b */
    public final void m337b() {
        Object objB = androidx.work.impl.model.f.k().b(C0105d0.class);
        Intrinsics.checkNotNullExpressionValue(objB, "Firebase.app[SessionGenerator::class.java]");
        C0105d0 c0105d0 = (C0105d0) objB;
        int i = c0105d0.f823d + 1;
        c0105d0.f823d = i;
        String strM328a = i == 0 ? c0105d0.f822c : c0105d0.m328a();
        int i2 = c0105d0.f823d;
        c0105d0.f820a.getClass();
        c0105d0.f824e = new C0142y(i2, 1000 * System.currentTimeMillis(), strM328a, c0105d0.f822c);
        Object objB2 = androidx.work.impl.model.f.k().b(InterfaceC0101b0.class);
        Intrinsics.checkNotNullExpressionValue(objB2, "Firebase.app[SessionFirelogPublisher::class.java]");
        InterfaceC0101b0 interfaceC0101b0 = (InterfaceC0101b0) objB2;
        Object objB3 = androidx.work.impl.model.f.k().b(C0105d0.class);
        Intrinsics.checkNotNullExpressionValue(objB3, "Firebase.app[SessionGenerator::class.java]");
        C0142y c0142y = ((C0105d0) objB3).f824e;
        if (c0142y == null) {
            Intrinsics.j("currentSession");
            throw null;
        }
        C0103c0 c0103c0 = (C0103c0) interfaceC0101b0;
        c0103c0.getClass();
        Intrinsics.checkNotNullParameter(c0142y, "sessionDetails");
        kotlinx.coroutines.g0.A(kotlinx.coroutines.g0.a(c0103c0.f812e), (CoroutineContext) null, (CoroutineStart) null, new SessionFirelogPublisherImpl$logSession$1(c0103c0, c0142y, null), 3);
        for (Messenger messenger : new ArrayList(this.f865c)) {
            Intrinsics.checkNotNullExpressionValue(messenger, "it");
            m336a(messenger);
        }
        Object objB4 = androidx.work.impl.model.f.k().b(InterfaceC0129r.class);
        Intrinsics.checkNotNullExpressionValue(objB4, "Firebase.app[SessionDatastore::class.java]");
        InterfaceC0129r interfaceC0129r = (InterfaceC0129r) objB4;
        Object objB5 = androidx.work.impl.model.f.k().b(C0105d0.class);
        Intrinsics.checkNotNullExpressionValue(objB5, "Firebase.app[SessionGenerator::class.java]");
        C0142y c0142y2 = ((C0105d0) objB5).f824e;
        if (c0142y2 == null) {
            Intrinsics.j("currentSession");
            throw null;
        }
        C0141x c0141x = (C0141x) interfaceC0129r;
        c0141x.getClass();
        String str = c0142y2.f921a;
        Intrinsics.checkNotNullParameter(str, "sessionId");
        kotlinx.coroutines.g0.A(kotlinx.coroutines.g0.a(c0141x.f918b), (CoroutineContext) null, (CoroutineStart) null, new SessionDatastoreImpl$updateSessionId$1(c0141x, str, null), 3);
    }

    /* JADX INFO: renamed from: c */
    public final void m338c(Messenger messenger, String str) {
        try {
            Bundle bundle = new Bundle();
            bundle.putString("SessionUpdateExtra", str);
            Message messageObtain = Message.obtain(null, 3, 0, 0);
            messageObtain.setData(bundle);
            messenger.send(messageObtain);
        } catch (DeadObjectException unused) {
            Objects.toString(messenger);
            this.f865c.remove(messenger);
        } catch (Exception unused2) {
            Objects.toString(messenger);
        }
    }

    /* JADX WARN: Code duplicated, block: B:29:0x00ab  */
    /* JADX WARN: Code duplicated, block: B:31:0x00b5  */
    /* JADX WARN: Code duplicated, block: B:33:0x00b9  */
    /* JADX WARN: Code duplicated, block: B:35:0x00cc  */
    /* JADX WARN: Code duplicated, block: B:40:0x00db  */
    /* JADX WARN: Code duplicated, block: B:46:0x00f7  */
    @Override // android.os.Handler
    public final void handleMessage(Message message) {
        C0133c c0133c;
        Integer num;
        long jV0;
        iq.d dVar = null;
        Intrinsics.checkNotNullParameter(message, "msg");
        if (this.f864b > message.getWhen()) {
            message.getWhen();
            return;
        }
        int i = message.what;
        if (i != 1) {
            if (i == 2) {
                message.getWhen();
                this.f864b = message.getWhen();
                return;
            }
            if (i != 4) {
                message.toString();
                super.handleMessage(message);
                return;
            }
            ArrayList arrayList = this.f865c;
            arrayList.add(message.replyTo);
            Messenger messenger = message.replyTo;
            Intrinsics.checkNotNullExpressionValue(messenger, "msg.replyTo");
            m336a(messenger);
            Objects.toString(message.replyTo);
            message.getWhen();
            arrayList.size();
            return;
        }
        message.getWhen();
        if (this.f863a) {
            long when = message.getWhen() - this.f864b;
            C0135e.f897c.getClass();
            Object objB = androidx.work.impl.model.f.k().b(C0135e.class);
            Intrinsics.checkNotNullExpressionValue(objB, "Firebase.app[SessionsSettings::class.java]");
            C0135e c0135e = (C0135e) objB;
            Bundle bundle = c0135e.f899a.f741a;
            iq.d dVar2 = bundle.containsKey("firebase_sessions_sessions_restart_timeout") ? new iq.d(com.bumptech.glide.d.v0(bundle.getInt("firebase_sessions_sessions_restart_timeout"), DurationUnit.SECONDS)) : null;
            if (dVar2 != null) {
                iq.c cVar = iq.d.b;
                jV0 = dVar2.a;
                if (jV0 <= 0 || iq.d.h(jV0)) {
                    c0133c = c0135e.f900b.m341b().f907b;
                    if (c0133c != null) {
                        Intrinsics.j("sessionConfigs");
                        throw null;
                    }
                    num = c0133c.f893c;
                    if (num != null) {
                        iq.c cVar2 = iq.d.b;
                        dVar = new iq.d(com.bumptech.glide.d.v0(num.intValue(), DurationUnit.SECONDS));
                    }
                    if (dVar != null) {
                        iq.c cVar3 = iq.d.b;
                        jV0 = dVar.a;
                        if (jV0 > 0 || iq.d.h(jV0)) {
                            iq.c cVar4 = iq.d.b;
                            jV0 = com.bumptech.glide.d.v0(30, DurationUnit.MINUTES);
                        }
                    } else {
                        iq.c cVar5 = iq.d.b;
                        jV0 = com.bumptech.glide.d.v0(30, DurationUnit.MINUTES);
                    }
                }
            } else {
                c0133c = c0135e.f900b.m341b().f907b;
                if (c0133c != null) {
                    Intrinsics.j("sessionConfigs");
                    throw null;
                }
                num = c0133c.f893c;
                if (num != null) {
                    iq.c cVar6 = iq.d.b;
                    dVar = new iq.d(com.bumptech.glide.d.v0(num.intValue(), DurationUnit.SECONDS));
                }
                if (dVar != null) {
                    iq.c cVar7 = iq.d.b;
                    jV0 = dVar.a;
                    if (jV0 > 0) {
                        iq.c cVar8 = iq.d.b;
                        jV0 = com.bumptech.glide.d.v0(30, DurationUnit.MINUTES);
                    } else {
                        iq.c cVar9 = iq.d.b;
                        jV0 = com.bumptech.glide.d.v0(30, DurationUnit.MINUTES);
                    }
                } else {
                    iq.c cVar10 = iq.d.b;
                    jV0 = com.bumptech.glide.d.v0(30, DurationUnit.MINUTES);
                }
            }
            if (when > iq.d.f(jV0)) {
                m337b();
            }
        } else {
            this.f863a = true;
            m337b();
        }
        this.f864b = message.getWhen();
    }
}
