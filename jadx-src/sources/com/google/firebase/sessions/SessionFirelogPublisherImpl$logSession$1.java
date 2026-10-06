package com.google.firebase.sessions;

import android.util.Log;
import androidx.constraintlayout.solver.widgets.Optimizer;
import com.google.firebase.sessions.api.C0098b;
import com.google.firebase.sessions.api.SessionSubscriber$Name;
import com.google.firebase.sessions.settings.C0135e;
import java.util.Map;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import wakotl.Metadata;
import wakotl.Unit;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.DebugMetadata;
import wakotl.coroutines.jvm.internal.SuspendLambda;
import wakotl.jvm.functions.Function2;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.SessionFirelogPublisherImpl$logSession$1", f = "SessionFirelogPublisher.kt", i = {2}, l = {63, Optimizer.OPTIMIZATION_GRAPH, 70}, m = "invokeSuspend", n = {"installationId"}, s = {"L$0"})
@Metadata(d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\b\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\u008a@¢\u0006\u0004\b\u0002\u0010\u0003"}, d2 = {"Lkotlinx/coroutines/e0;", "", "<anonymous>", "(Lkotlinx/coroutines/e0;)V"}, k = 3, mv = {1, 8, 0})
final class SessionFirelogPublisherImpl$logSession$1 extends SuspendLambda implements Function2<kotlinx.coroutines.e0, Continuation<? super Unit>, Object> {
    final /* synthetic */ C0142y $sessionDetails;
    Object L$0;
    Object L$1;
    Object L$2;
    Object L$3;
    Object L$4;
    Object L$5;
    int label;
    final /* synthetic */ C0103c0 this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public SessionFirelogPublisherImpl$logSession$1(C0103c0 c0103c0, C0142y c0142y, Continuation<? super SessionFirelogPublisherImpl$logSession$1> continuation) {
        super(2, continuation);
        this.this$0 = c0103c0;
        this.$sessionDetails = c0142y;
    }

    @NotNull
    public final Continuation<Unit> create(@Nullable Object obj, @NotNull Continuation<?> continuation) {
        return new SessionFirelogPublisherImpl$logSession$1(this.this$0, this.$sessionDetails, continuation);
    }

    /* JADX WARN: Code duplicated, block: B:22:0x0091 A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:23:0x0092  */
    /* JADX WARN: Code duplicated, block: B:26:0x00d6  */
    /* JADX WARN: Code duplicated, block: B:27:0x00d9  */
    /* JADX WARN: Code duplicated, block: B:29:0x00e1  */
    /* JADX WARN: Code duplicated, block: B:30:0x00e4  */
    /* JADX WARN: Code duplicated, block: B:33:0x00f0  */
    /* JADX WARN: Code duplicated, block: B:34:0x00f3  */
    /* JADX WARN: Code duplicated, block: B:36:0x00fb  */
    /* JADX WARN: Code duplicated, block: B:37:0x00fe  */
    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) {
        Object objM326a;
        Object objM339a;
        C0126o c0126o;
        C0103c0 c0103c0;
        C0096a0 c0096a0;
        ef.h hVar;
        C0142y c0142y;
        C0135e c0135e;
        Object objM324b;
        C0135e c0135e2;
        ef.h hVar2;
        C0142y c0142y2;
        C0126o c0126o2;
        C0103c0 c0103c1;
        C0096a0 c0096a1;
        pf.j jVar;
        DataCollectionState dataCollectionState;
        pf.j jVar2;
        DataCollectionState dataCollectionState2;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i = this.label;
        if (i != 0) {
            if (i == 1) {
                wakotl.b.b(obj);
                objM326a = obj;
            } else if (i == 2) {
                wakotl.b.b(obj);
                objM339a = obj;
                c0126o = (C0126o) objM339a;
                c0103c0 = this.this$0;
                c0096a0 = C0096a0.f787a;
                hVar = c0103c0.f808a;
                c0142y = this.$sessionDetails;
                C0098b c0098b = C0098b.f791a;
                this.L$0 = c0126o;
                this.L$1 = c0103c0;
                this.L$2 = c0096a0;
                this.L$3 = hVar;
                this.L$4 = c0142y;
                c0135e = c0103c0.f810c;
                this.L$5 = c0135e;
                this.label = 3;
                objM324b = c0098b.m324b(this);
                if (objM324b == coroutine_suspended) {
                    return coroutine_suspended;
                }
                c0135e2 = c0135e;
                hVar2 = hVar;
                c0142y2 = c0142y;
                c0126o2 = c0126o;
                c0103c1 = c0103c0;
                c0096a1 = c0096a0;
            } else {
                if (i != 3) {
                    throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
                }
                c0135e2 = (C0135e) this.L$5;
                c0142y2 = (C0142y) this.L$4;
                ef.h hVar3 = (ef.h) this.L$3;
                C0096a0 c0096a2 = (C0096a0) this.L$2;
                C0103c0 c0103c2 = (C0103c0) this.L$1;
                C0126o c0126o3 = (C0126o) this.L$0;
                wakotl.b.b(obj);
                c0126o2 = c0126o3;
                c0103c1 = c0103c2;
                c0096a1 = c0096a2;
                hVar2 = hVar3;
                objM324b = obj;
            }
            Map map = (Map) objM324b;
            String str = c0126o2.f875a;
            c0096a1.getClass();
            Intrinsics.checkNotNullParameter(hVar2, "firebaseApp");
            Intrinsics.checkNotNullParameter(c0142y2, "sessionDetails");
            Intrinsics.checkNotNullParameter(c0135e2, "sessionsSettings");
            Intrinsics.checkNotNullParameter(map, "subscribers");
            Intrinsics.checkNotNullParameter(str, "firebaseInstallationId");
            String str2 = c0126o2.f876b;
            Intrinsics.checkNotNullParameter(str2, "firebaseAuthenticationToken");
            EventType eventType = EventType.SESSION_START;
            String str3 = c0142y2.f921a;
            jVar = (pf.j) map.get(SessionSubscriber$Name.PERFORMANCE);
            if (jVar == null) {
                dataCollectionState = DataCollectionState.COLLECTION_SDK_NOT_INSTALLED;
            } else if (jVar.a.b()) {
                dataCollectionState = DataCollectionState.COLLECTION_ENABLED;
            } else {
                dataCollectionState = DataCollectionState.COLLECTION_DISABLED;
            }
            jVar2 = (pf.j) map.get(SessionSubscriber$Name.CRASHLYTICS);
            if (jVar2 == null) {
                dataCollectionState2 = DataCollectionState.COLLECTION_SDK_NOT_INSTALLED;
            } else if (jVar2.a.b()) {
                dataCollectionState2 = DataCollectionState.COLLECTION_ENABLED;
            } else {
                dataCollectionState2 = DataCollectionState.COLLECTION_DISABLED;
            }
            C0114i c0114i = new C0114i(dataCollectionState, dataCollectionState2, c0135e2.m344a());
            C0143z c0143z = new C0143z(eventType, new C0107e0(str3, c0142y2.f922b, c0142y2.f923c, c0142y2.f924d, c0114i, str, str2), C0096a0.m322a(hVar2));
            int i2 = C0103c0.f807g;
            c0103c1.getClass();
            try {
                c0103c1.f811d.m335a(c0143z);
            } catch (RuntimeException e) {
                Log.e("SessionFirelogPublisher", "Error logging Session Start event to DataTransport: ", e);
            }
            return Unit.a;
        }
        wakotl.b.b(obj);
        C0103c0 c0103c3 = this.this$0;
        this.label = 1;
        objM326a = C0103c0.m326a(c0103c3, this);
        if (objM326a == coroutine_suspended) {
            return coroutine_suspended;
        }
        if (((Boolean) objM326a).booleanValue()) {
            C0124n c0124n = C0126o.f874c;
            lg.d dVar = this.this$0.f809b;
            this.label = 2;
            objM339a = c0124n.m339a(dVar, this);
            if (objM339a == coroutine_suspended) {
                return coroutine_suspended;
            }
            c0126o = (C0126o) objM339a;
            c0103c0 = this.this$0;
            c0096a0 = C0096a0.f787a;
            hVar = c0103c0.f808a;
            c0142y = this.$sessionDetails;
            C0098b c0098b2 = C0098b.f791a;
            this.L$0 = c0126o;
            this.L$1 = c0103c0;
            this.L$2 = c0096a0;
            this.L$3 = hVar;
            this.L$4 = c0142y;
            c0135e = c0103c0.f810c;
            this.L$5 = c0135e;
            this.label = 3;
            objM324b = c0098b2.m324b(this);
            if (objM324b == coroutine_suspended) {
                return coroutine_suspended;
            }
            c0135e2 = c0135e;
            hVar2 = hVar;
            c0142y2 = c0142y;
            c0126o2 = c0126o;
            c0103c1 = c0103c0;
            c0096a1 = c0096a0;
            Map map2 = (Map) objM324b;
            String str4 = c0126o2.f875a;
            c0096a1.getClass();
            Intrinsics.checkNotNullParameter(hVar2, "firebaseApp");
            Intrinsics.checkNotNullParameter(c0142y2, "sessionDetails");
            Intrinsics.checkNotNullParameter(c0135e2, "sessionsSettings");
            Intrinsics.checkNotNullParameter(map2, "subscribers");
            Intrinsics.checkNotNullParameter(str4, "firebaseInstallationId");
            String str5 = c0126o2.f876b;
            Intrinsics.checkNotNullParameter(str5, "firebaseAuthenticationToken");
            EventType eventType2 = EventType.SESSION_START;
            String str6 = c0142y2.f921a;
            jVar = (pf.j) map2.get(SessionSubscriber$Name.PERFORMANCE);
            if (jVar == null) {
                dataCollectionState = DataCollectionState.COLLECTION_SDK_NOT_INSTALLED;
            } else if (jVar.a.b()) {
                dataCollectionState = DataCollectionState.COLLECTION_ENABLED;
            } else {
                dataCollectionState = DataCollectionState.COLLECTION_DISABLED;
            }
            jVar2 = (pf.j) map2.get(SessionSubscriber$Name.CRASHLYTICS);
            if (jVar2 == null) {
                dataCollectionState2 = DataCollectionState.COLLECTION_SDK_NOT_INSTALLED;
            } else if (jVar2.a.b()) {
                dataCollectionState2 = DataCollectionState.COLLECTION_ENABLED;
            } else {
                dataCollectionState2 = DataCollectionState.COLLECTION_DISABLED;
            }
            C0114i c0114i2 = new C0114i(dataCollectionState, dataCollectionState2, c0135e2.m344a());
            C0143z c0143z2 = new C0143z(eventType2, new C0107e0(str6, c0142y2.f922b, c0142y2.f923c, c0142y2.f924d, c0114i2, str4, str5), C0096a0.m322a(hVar2));
            int i3 = C0103c0.f807g;
            c0103c1.getClass();
            c0103c1.f811d.m335a(c0143z2);
        }
        return Unit.a;
    }

    @Nullable
    public final Object invoke(@NotNull kotlinx.coroutines.e0 e0Var, @Nullable Continuation<? super Unit> continuation) {
        return create(e0Var, continuation).invokeSuspend(Unit.a);
    }
}
