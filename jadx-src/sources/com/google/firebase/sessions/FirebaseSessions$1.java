package com.google.firebase.sessions;

import android.content.Context;
import android.content.Intent;
import android.os.Messenger;
import android.os.Process;
import android.util.Log;
import androidx.constraintlayout.widget.ConstraintLayout;
import com.google.android.gms.common.internal.Preconditions;
import com.google.firebase.sessions.api.C0098b;
import com.google.firebase.sessions.settings.C0135e;
import java.util.Collection;
import java.util.Iterator;
import java.util.Map;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import wakotl.Metadata;
import wakotl.Unit;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.CoroutineContext;
import wakotl.coroutines.jvm.internal.DebugMetadata;
import wakotl.coroutines.jvm.internal.SuspendLambda;
import wakotl.jvm.functions.Function2;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.FirebaseSessions$1", f = "FirebaseSessions.kt", i = {}, l = {ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HORIZONTAL_WEIGHT, ConstraintLayout.LayoutParams.Table.LAYOUT_EDITOR_ABSOLUTEX}, m = "invokeSuspend", n = {}, s = {})
@Metadata(d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\b\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\u008a@¢\u0006\u0004\b\u0002\u0010\u0003"}, d2 = {"Lkotlinx/coroutines/e0;", "", "<anonymous>", "(Lkotlinx/coroutines/e0;)V"}, k = 3, mv = {1, 8, 0})
final class FirebaseSessions$1 extends SuspendLambda implements Function2<kotlinx.coroutines.e0, Continuation<? super Unit>, Object> {
    final /* synthetic */ CoroutineContext $backgroundDispatcher;
    final /* synthetic */ InterfaceC0119k0 $lifecycleServiceBinder;
    int label;
    final /* synthetic */ C0118k this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public FirebaseSessions$1(C0118k c0118k, CoroutineContext coroutineContext, InterfaceC0119k0 interfaceC0119k0, Continuation<? super FirebaseSessions$1> continuation) {
        super(2, continuation);
        this.this$0 = c0118k;
        this.$backgroundDispatcher = coroutineContext;
        this.$lifecycleServiceBinder = interfaceC0119k0;
    }

    @NotNull
    public final Continuation<Unit> create(@Nullable Object obj, @NotNull Continuation<?> continuation) {
        return new FirebaseSessions$1(this.this$0, this.$backgroundDispatcher, this.$lifecycleServiceBinder, continuation);
    }

    /* JADX WARN: Code duplicated, block: B:28:0x0074  */
    /* JADX WARN: Code duplicated, block: B:29:0x0079  */
    /* JADX WARN: Code duplicated, block: B:31:0x0081  */
    /* JADX WARN: Code duplicated, block: B:32:0x0086  */
    /* JADX WARN: Code duplicated, block: B:35:0x008b  */
    /* JADX WARN: Code duplicated, block: B:44:0x00ff  */
    /* JADX WARN: Code duplicated, block: B:49:0x00ed A[EXC_TOP_SPLITTER, SYNTHETIC] */
    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) {
        C0135e c0135e;
        Boolean boolM286h;
        Boolean boolM340a;
        boolean zBooleanValue;
        C0115i0 c0115i0;
        ServiceConnectionC0113h0 serviceConnectionC0113h0;
        Context applicationContext;
        boolean zBindService;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i = this.label;
        if (i != 0) {
            if (i == 1) {
                wakotl.b.b(obj);
            } else {
                if (i != 2) {
                    throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
                }
                wakotl.b.b(obj);
            }
            c0135e = this.this$0.f867b;
            boolM286h = c0135e.f899a.m286h();
            if (boolM286h != null) {
                zBooleanValue = boolM286h.booleanValue();
            } else {
                boolM340a = c0135e.f900b.m340a();
                if (boolM340a != null) {
                    zBooleanValue = boolM340a.booleanValue();
                } else {
                    zBooleanValue = true;
                }
            }
            if (zBooleanValue) {
                CoroutineContext coroutineContext = this.$backgroundDispatcher;
                c0115i0 = new C0115i0(coroutineContext);
                InterfaceC0119k0 interfaceC0119k0 = this.$lifecycleServiceBinder;
                Intrinsics.checkNotNullParameter(interfaceC0119k0, "sessionLifecycleServiceBinder");
                Messenger messenger = new Messenger(new HandlerC0109f0(coroutineContext));
                C0121l0 c0121l0 = (C0121l0) interfaceC0119k0;
                c0121l0.getClass();
                Intrinsics.checkNotNullParameter(messenger, "callback");
                serviceConnectionC0113h0 = c0115i0.f861d;
                Intrinsics.checkNotNullParameter(serviceConnectionC0113h0, "serviceConnection");
                ef.h hVar = c0121l0.f869a;
                hVar.a();
                applicationContext = hVar.a.getApplicationContext();
                Intrinsics.checkNotNullExpressionValue(applicationContext, "firebaseApp.applicationContext.applicationContext");
                Intent intent = new Intent(applicationContext, (Class<?>) SessionLifecycleService.class);
                intent.setAction(String.valueOf(Process.myPid()));
                intent.putExtra("ClientCallbackMessenger", messenger);
                intent.setPackage(applicationContext.getPackageName());
                try {
                    zBindService = applicationContext.bindService(intent, serviceConnectionC0113h0, 65);
                } catch (SecurityException unused) {
                    zBindService = false;
                }
                if (!zBindService) {
                    try {
                        applicationContext.unbindService(serviceConnectionC0113h0);
                        Unit unit = Unit.a;
                    } catch (IllegalArgumentException unused2) {
                    }
                    Log.i("LifecycleServiceBinder", "Session lifecycle service binding failed.");
                }
                C0123m0.f872c = c0115i0;
                if (C0123m0.f871b) {
                    C0123m0.f871b = false;
                    c0115i0.m334b(1);
                }
                ef.h hVar2 = this.this$0.f866a;
                androidx.core.view.h hVar3 = new androidx.core.view.h(16);
                hVar2.a();
                Preconditions.checkNotNull(hVar3);
                hVar2.j.add(hVar3);
            }
            return Unit.a;
        }
        wakotl.b.b(obj);
        C0098b c0098b = C0098b.f791a;
        this.label = 1;
        obj = c0098b.m324b(this);
        if (obj == coroutine_suspended) {
            return coroutine_suspended;
        }
        Collection collectionValues = ((Map) obj).values();
        if (!(collectionValues instanceof Collection) || !collectionValues.isEmpty()) {
            Iterator it = collectionValues.iterator();
            do {
                if (it.hasNext()) {
                }
            } while (!((pf.j) it.next()).a.b());
            C0135e c0135e2 = this.this$0.f867b;
            this.label = 2;
            if (c0135e2.m345b(this) == coroutine_suspended) {
                return coroutine_suspended;
            }
            c0135e = this.this$0.f867b;
            boolM286h = c0135e.f899a.m286h();
            if (boolM286h != null) {
                zBooleanValue = boolM286h.booleanValue();
            } else {
                boolM340a = c0135e.f900b.m340a();
                if (boolM340a != null) {
                    zBooleanValue = boolM340a.booleanValue();
                } else {
                    zBooleanValue = true;
                }
            }
            if (zBooleanValue) {
                CoroutineContext coroutineContext2 = this.$backgroundDispatcher;
                c0115i0 = new C0115i0(coroutineContext2);
                InterfaceC0119k0 interfaceC0119k1 = this.$lifecycleServiceBinder;
                Intrinsics.checkNotNullParameter(interfaceC0119k1, "sessionLifecycleServiceBinder");
                Messenger messenger2 = new Messenger(new HandlerC0109f0(coroutineContext2));
                C0121l0 c0121l1 = (C0121l0) interfaceC0119k1;
                c0121l1.getClass();
                Intrinsics.checkNotNullParameter(messenger2, "callback");
                serviceConnectionC0113h0 = c0115i0.f861d;
                Intrinsics.checkNotNullParameter(serviceConnectionC0113h0, "serviceConnection");
                ef.h hVar4 = c0121l1.f869a;
                hVar4.a();
                applicationContext = hVar4.a.getApplicationContext();
                Intrinsics.checkNotNullExpressionValue(applicationContext, "firebaseApp.applicationContext.applicationContext");
                Intent intent2 = new Intent(applicationContext, (Class<?>) SessionLifecycleService.class);
                intent2.setAction(String.valueOf(Process.myPid()));
                intent2.putExtra("ClientCallbackMessenger", messenger2);
                intent2.setPackage(applicationContext.getPackageName());
                zBindService = applicationContext.bindService(intent2, serviceConnectionC0113h0, 65);
                if (!zBindService) {
                    applicationContext.unbindService(serviceConnectionC0113h0);
                    Unit unit2 = Unit.a;
                    Log.i("LifecycleServiceBinder", "Session lifecycle service binding failed.");
                }
                C0123m0.f872c = c0115i0;
                if (C0123m0.f871b) {
                    C0123m0.f871b = false;
                    c0115i0.m334b(1);
                }
                ef.h hVar5 = this.this$0.f866a;
                androidx.core.view.h hVar6 = new androidx.core.view.h(16);
                hVar5.a();
                Preconditions.checkNotNull(hVar6);
                hVar5.j.add(hVar6);
            }
        }
        return Unit.a;
    }

    @Nullable
    public final Object invoke(@NotNull kotlinx.coroutines.e0 e0Var, @Nullable Continuation<? super Unit> continuation) {
        return create(e0Var, continuation).invokeSuspend(Unit.a);
    }
}
