package com.google.firebase.sessions;

import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import com.google.firebase.sessions.api.C0098b;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.LinkedBlockingDeque;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import wakotl.Metadata;
import wakotl.Unit;
import wakotl.collections.CollectionsKt;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.DebugMetadata;
import wakotl.coroutines.jvm.internal.SuspendLambda;
import wakotl.jvm.functions.Function2;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.SessionLifecycleClient$sendLifecycleEvents$1", f = "SessionLifecycleClient.kt", i = {}, l = {151}, m = "invokeSuspend", n = {}, s = {})
@Metadata(d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\b\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\u008a@¢\u0006\u0004\b\u0002\u0010\u0003"}, d2 = {"Lkotlinx/coroutines/e0;", "", "<anonymous>", "(Lkotlinx/coroutines/e0;)V"}, k = 3, mv = {1, 8, 0})
final class SessionLifecycleClient$sendLifecycleEvents$1 extends SuspendLambda implements Function2<kotlinx.coroutines.e0, Continuation<? super Unit>, Object> {
    final /* synthetic */ List<Message> $messages;
    int label;
    final /* synthetic */ C0115i0 this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public SessionLifecycleClient$sendLifecycleEvents$1(C0115i0 c0115i0, List<Message> list, Continuation<? super SessionLifecycleClient$sendLifecycleEvents$1> continuation) {
        super(2, continuation);
        this.this$0 = c0115i0;
        this.$messages = list;
    }

    @NotNull
    public final Continuation<Unit> create(@Nullable Object obj, @NotNull Continuation<?> continuation) {
        return new SessionLifecycleClient$sendLifecycleEvents$1(this.this$0, this.$messages, continuation);
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
        Map map = (Map) obj;
        if (!map.isEmpty()) {
            Collection collectionValues = map.values();
            if (!(collectionValues instanceof Collection) || !collectionValues.isEmpty()) {
                Iterator it = collectionValues.iterator();
                while (it.hasNext()) {
                    if (((pf.j) it.next()).a.b()) {
                        List<Message> listD0 = CollectionsKt.d0(CollectionsKt.L(wakotl.collections.c0.m(new Message[]{C0115i0.m333a(this.this$0, this.$messages, 2), C0115i0.m333a(this.this$0, this.$messages, 1)})), new C0111g0());
                        C0115i0 c0115i0 = this.this$0;
                        for (Message message : listD0) {
                            Messenger messenger = c0115i0.f859b;
                            LinkedBlockingDeque linkedBlockingDeque = c0115i0.f860c;
                            if (messenger != null) {
                                try {
                                    int i2 = message.what;
                                    messenger.send(message);
                                } catch (RemoteException unused) {
                                    int i3 = message.what;
                                    if (linkedBlockingDeque.offer(message)) {
                                        linkedBlockingDeque.size();
                                    }
                                }
                            } else if (linkedBlockingDeque.offer(message)) {
                                int i4 = message.what;
                                linkedBlockingDeque.size();
                            } else {
                                int i5 = message.what;
                            }
                        }
                        break;
                    }
                }
            }
        }
        return Unit.a;
    }

    @Nullable
    public final Object invoke(@NotNull kotlinx.coroutines.e0 e0Var, @Nullable Continuation<? super Unit> continuation) {
        return create(e0Var, continuation).invokeSuspend(Unit.a);
    }
}
