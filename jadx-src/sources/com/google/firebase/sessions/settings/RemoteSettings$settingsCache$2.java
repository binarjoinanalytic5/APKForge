package com.google.firebase.sessions.settings;

import androidx.datastore.core.h;
import org.jetbrains.annotations.NotNull;
import wakotl.Metadata;
import wakotl.jvm.functions.Function0;
import wakotl.jvm.internal.Lambda;

/* JADX INFO: loaded from: classes.dex */
@Metadata(d1 = {"\u0000\b\n\u0002\u0018\u0002\n\u0002\b\u0003\u0010\u0003\u001a\u00020\u0000H\n¢\u0006\u0004\b\u0001\u0010\u0002"}, d2 = {"Lcom/google/firebase/sessions/settings/f;", "invoke", "()Lcom/google/firebase/sessions/settings/f;", "<anonymous>"}, k = 3, mv = {1, 8, 0})
final class RemoteSettings$settingsCache$2 extends Lambda implements Function0<C0136f> {
    final /* synthetic */ h $dataStore;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public RemoteSettings$settingsCache$2(h hVar) {
        super(0);
        this.$dataStore = hVar;
    }

    @NotNull
    /* JADX INFO: renamed from: invoke, reason: merged with bridge method [inline-methods] */
    public final C0136f m361invoke() {
        return new C0136f(this.$dataStore);
    }
}
