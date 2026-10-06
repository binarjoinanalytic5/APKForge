package com.google.firebase.sessions;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import wakotl.Metadata;
import wakotl.Unit;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.DebugMetadata;
import wakotl.coroutines.jvm.internal.SuspendLambda;
import wakotl.jvm.functions.Function2;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.SessionDatastoreImpl$1", f = "SessionDatastore.kt", i = {}, l = {82}, m = "invokeSuspend", n = {}, s = {})
@Metadata(d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\b\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\u008a@¢\u0006\u0004\b\u0002\u0010\u0003"}, d2 = {"Lkotlinx/coroutines/e0;", "", "<anonymous>", "(Lkotlinx/coroutines/e0;)V"}, k = 3, mv = {1, 8, 0})
final class SessionDatastoreImpl$1 extends SuspendLambda implements Function2<kotlinx.coroutines.e0, Continuation<? super Unit>, Object> {
    int label;
    final /* synthetic */ C0141x this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public SessionDatastoreImpl$1(C0141x c0141x, Continuation<? super SessionDatastoreImpl$1> continuation) {
        super(2, continuation);
        this.this$0 = c0141x;
    }

    @NotNull
    public final Continuation<Unit> create(@Nullable Object obj, @NotNull Continuation<?> continuation) {
        return new SessionDatastoreImpl$1(this.this$0, continuation);
    }

    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) {
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i = this.label;
        if (i == 0) {
            wakotl.b.b(obj);
            C0141x c0141x = this.this$0;
            C0140w c0140w = c0141x.f920d;
            C0130s c0130s = new C0130s(c0141x);
            this.label = 1;
            if (c0140w.collect(c0130s, this) == coroutine_suspended) {
                return coroutine_suspended;
            }
        } else {
            if (i != 1) {
                throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
            }
            wakotl.b.b(obj);
        }
        return Unit.a;
    }

    @Nullable
    public final Object invoke(@NotNull kotlinx.coroutines.e0 e0Var, @Nullable Continuation<? super Unit> continuation) {
        return create(e0Var, continuation).invokeSuspend(Unit.a);
    }
}
