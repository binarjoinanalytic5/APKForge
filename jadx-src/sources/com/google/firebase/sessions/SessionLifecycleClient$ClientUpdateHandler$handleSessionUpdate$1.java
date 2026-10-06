package com.google.firebase.sessions;

import com.google.firebase.sessions.api.C0098b;
import com.google.firebase.sessions.api.C0099c;
import com.google.firebase.sessions.api.SessionSubscriber$Name;
import j$.util.Objects;
import java.io.IOException;
import java.util.Collection;
import java.util.Map;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import wakotl.Metadata;
import wakotl.Unit;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.DebugMetadata;
import wakotl.coroutines.jvm.internal.SuspendLambda;
import wakotl.jvm.functions.Function2;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.SessionLifecycleClient$ClientUpdateHandler$handleSessionUpdate$1", f = "SessionLifecycleClient.kt", i = {}, l = {74}, m = "invokeSuspend", n = {}, s = {})
@Metadata(d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\b\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\u008a@¢\u0006\u0004\b\u0002\u0010\u0003"}, d2 = {"Lkotlinx/coroutines/e0;", "", "<anonymous>", "(Lkotlinx/coroutines/e0;)V"}, k = 3, mv = {1, 8, 0})
final class SessionLifecycleClient$ClientUpdateHandler$handleSessionUpdate$1 extends SuspendLambda implements Function2<kotlinx.coroutines.e0, Continuation<? super Unit>, Object> {
    final /* synthetic */ String $sessionId;
    int label;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public SessionLifecycleClient$ClientUpdateHandler$handleSessionUpdate$1(String str, Continuation<? super SessionLifecycleClient$ClientUpdateHandler$handleSessionUpdate$1> continuation) {
        super(2, continuation);
        this.$sessionId = str;
    }

    @NotNull
    public final Continuation<Unit> create(@Nullable Object obj, @NotNull Continuation<?> continuation) {
        return new SessionLifecycleClient$ClientUpdateHandler$handleSessionUpdate$1(this.$sessionId, continuation);
    }

    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) {
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i = this.label;
        if (i == 0) {
            wakotl.b.b(obj);
            C0098b c0098b = C0098b.f791a;
            this.label = 1;
            obj = c0098b.m324b(this);
            if (obj == coroutine_suspended) {
                return coroutine_suspended;
            }
        } else {
            if (i != 1) {
                throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
            }
            wakotl.b.b(obj);
        }
        Collection<pf.j> collectionValues = ((Map) obj).values();
        String str = this.$sessionId;
        for (pf.j jVar : collectionValues) {
            C0099c c0099c = new C0099c(str);
            jVar.getClass();
            Objects.toString(c0099c);
            pf.i iVar = jVar.b;
            synchronized (iVar) {
                if (!Objects.equals(iVar.c, str)) {
                    vf.c cVar = iVar.a;
                    String str2 = iVar.b;
                    if (str2 != null) {
                        try {
                            cVar.g(str2, "aqs.".concat(str)).createNewFile();
                        } catch (IOException unused) {
                        }
                    }
                    iVar.c = str;
                }
            }
            Objects.toString(SessionSubscriber$Name.CRASHLYTICS);
        }
        return Unit.a;
    }

    @Nullable
    public final Object invoke(@NotNull kotlinx.coroutines.e0 e0Var, @Nullable Continuation<? super Unit> continuation) {
        return create(e0Var, continuation).invokeSuspend(Unit.a);
    }
}
