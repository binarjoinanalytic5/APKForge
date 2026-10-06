package com.google.firebase.sessions.settings;

import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.datastore.preferences.core.g;
import kotlinx.coroutines.e0;
import kotlinx.coroutines.flow.i;
import kotlinx.coroutines.flow.k;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import wakotl.Metadata;
import wakotl.Unit;
import wakotl.collections.s0;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.DebugMetadata;
import wakotl.coroutines.jvm.internal.SuspendLambda;
import wakotl.jvm.functions.Function2;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.settings.SettingsCache$1", f = "SettingsCache.kt", i = {}, l = {ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_WEIGHT}, m = "invokeSuspend", n = {}, s = {})
@Metadata(d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\b\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\u008a@¢\u0006\u0004\b\u0002\u0010\u0003"}, d2 = {"Lkotlinx/coroutines/e0;", "", "<anonymous>", "(Lkotlinx/coroutines/e0;)V"}, k = 3, mv = {1, 8, 0})
final class SettingsCache$1 extends SuspendLambda implements Function2<e0, Continuation<? super Unit>, Object> {
    Object L$0;
    int label;
    final /* synthetic */ C0136f this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public SettingsCache$1(C0136f c0136f, Continuation<? super SettingsCache$1> continuation) {
        super(2, continuation);
        this.this$0 = c0136f;
    }

    @NotNull
    public final Continuation<Unit> create(@Nullable Object obj, @NotNull Continuation<?> continuation) {
        return new SettingsCache$1(this.this$0, continuation);
    }

    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) {
        C0136f c0136f;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i = this.label;
        if (i == 0) {
            wakotl.b.b(obj);
            C0136f c0136f2 = this.this$0;
            i data = c0136f2.f906a.getData();
            this.L$0 = c0136f2;
            this.label = 1;
            Object objQ = k.q(data, this);
            if (objQ == coroutine_suspended) {
                return coroutine_suspended;
            }
            c0136f = c0136f2;
            obj = objQ;
        } else {
            if (i != 1) {
                throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
            }
            c0136f = (C0136f) this.L$0;
            wakotl.b.b(obj);
        }
        C0136f.m346a(c0136f, new androidx.datastore.preferences.core.b(s0.s(((g) obj).a()), true));
        return Unit.a;
    }

    @Nullable
    public final Object invoke(@NotNull e0 e0Var, @Nullable Continuation<? super Unit> continuation) {
        return create(e0Var, continuation).invokeSuspend(Unit.a);
    }
}
