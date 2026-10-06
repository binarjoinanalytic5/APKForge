package com.google.firebase.sessions;

import android.os.Build;
import androidx.datastore.core.CorruptionException;
import com.google.android.gms.common.util.ProcessUtils;
import org.jetbrains.annotations.NotNull;
import wakotl.Metadata;
import wakotl.jvm.functions.Function1;
import wakotl.jvm.internal.Intrinsics;
import wakotl.jvm.internal.Lambda;

/* JADX INFO: loaded from: classes.dex */
@Metadata(d1 = {"\u0000\u000e\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0003\u0010\u0005\u001a\u00020\u00022\u0006\u0010\u0001\u001a\u00020\u0000H\n¢\u0006\u0004\b\u0003\u0010\u0004"}, d2 = {"Landroidx/datastore/core/CorruptionException;", "ex", "Landroidx/datastore/preferences/core/g;", "invoke", "(Landroidx/datastore/core/CorruptionException;)Landroidx/datastore/preferences/core/g;", "<anonymous>"}, k = 3, mv = {1, 8, 0})
final class SessionDatastoreImpl$Companion$dataStore$2 extends Lambda implements Function1<CorruptionException, androidx.datastore.preferences.core.g> {
    public static final SessionDatastoreImpl$Companion$dataStore$2 INSTANCE = new SessionDatastoreImpl$Companion$dataStore$2();

    public SessionDatastoreImpl$Companion$dataStore$2() {
        super(1);
    }

    @NotNull
    public final androidx.datastore.preferences.core.g invoke(@NotNull CorruptionException corruptionException) {
        Intrinsics.checkNotNullParameter(corruptionException, "ex");
        int i = Build.VERSION.SDK_INT;
        if (i >= 33) {
            Intrinsics.checkNotNullExpressionValue(androidx.appcompat.app.c0.l(), "myProcessName()");
        } else if (i < 28 || androidx.activity.z.i() == null) {
            ProcessUtils.getMyProcessName();
        }
        return new androidx.datastore.preferences.core.b(true);
    }
}
