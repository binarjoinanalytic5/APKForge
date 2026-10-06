package com.google.firebase.sessions.settings;

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
@DebugMetadata(c = "com.google.firebase.sessions.settings.SettingsCache$updateConfigValue$2", f = "SettingsCache.kt", i = {}, l = {}, m = "invokeSuspend", n = {}, s = {})
@Metadata(d1 = {"\u0000\u0010\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\b\u0002\u0010\u0004\u001a\u00020\u0003\"\u0004\b\u0000\u0010\u00002\u0006\u0010\u0002\u001a\u00020\u0001H\u008a@¢\u0006\u0004\b\u0004\u0010\u0005"}, d2 = {"T", "Landroidx/datastore/preferences/core/b;", "preferences", "", "<anonymous>", "(Landroidx/datastore/preferences/core/b;)V"}, k = 3, mv = {1, 8, 0})
final class SettingsCache$updateConfigValue$2 extends SuspendLambda implements Function2<androidx.datastore.preferences.core.b, Continuation<? super Unit>, Object> {
    final /* synthetic */ androidx.datastore.preferences.core.e $key;
    final /* synthetic */ Object $value;
    /* synthetic */ Object L$0;
    int label;
    final /* synthetic */ C0136f this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public SettingsCache$updateConfigValue$2(Object obj, androidx.datastore.preferences.core.e eVar, C0136f c0136f, Continuation<? super SettingsCache$updateConfigValue$2> continuation) {
        super(2, continuation);
        this.$value = obj;
        this.$key = eVar;
        this.this$0 = c0136f;
    }

    @NotNull
    public final Continuation<Unit> create(@Nullable Object obj, @NotNull Continuation<?> continuation) {
        SettingsCache$updateConfigValue$2 settingsCache$updateConfigValue$2 = new SettingsCache$updateConfigValue$2(this.$value, this.$key, this.this$0, continuation);
        settingsCache$updateConfigValue$2.L$0 = obj;
        return settingsCache$updateConfigValue$2;
    }

    @Nullable
    public final Object invoke(@NotNull androidx.datastore.preferences.core.b bVar, @Nullable Continuation<? super Unit> continuation) {
        return create(bVar, continuation).invokeSuspend(Unit.a);
    }

    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) {
        wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        if (this.label != 0) {
            throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
        }
        wakotl.b.b(obj);
        androidx.datastore.preferences.core.b bVar = (androidx.datastore.preferences.core.b) this.L$0;
        Object obj2 = this.$value;
        if (obj2 != null) {
            androidx.datastore.preferences.core.e eVar = this.$key;
            bVar.getClass();
            Intrinsics.checkNotNullParameter(eVar, "key");
            bVar.d(eVar, obj2);
        } else {
            androidx.datastore.preferences.core.e eVar2 = this.$key;
            bVar.getClass();
            Intrinsics.checkNotNullParameter(eVar2, "key");
            bVar.c();
            bVar.a.remove(eVar2);
        }
        C0136f.m346a(this.this$0, bVar);
        return Unit.a;
    }
}
