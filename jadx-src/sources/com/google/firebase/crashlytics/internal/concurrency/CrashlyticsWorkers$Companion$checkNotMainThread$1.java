package com.google.firebase.crashlytics.internal.concurrency;

import android.os.Looper;
import androidx.constraintlayout.widget.ConstraintLayout;
import org.jetbrains.annotations.NotNull;
import qf.c;
import wakotl.Metadata;
import wakotl.jvm.functions.Function0;
import wakotl.jvm.internal.CallableReference;
import wakotl.jvm.internal.FunctionReferenceImpl;

/* JADX INFO: loaded from: classes.dex */
@Metadata(k = 3, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
final /* synthetic */ class CrashlyticsWorkers$Companion$checkNotMainThread$1 extends FunctionReferenceImpl implements Function0<Boolean> {
    public CrashlyticsWorkers$Companion$checkNotMainThread$1(Object obj) {
        super(0, obj, c.class, "isNotMainThread", "isNotMainThread()Z", 0);
    }

    @NotNull
    /* JADX INFO: renamed from: invoke, reason: merged with bridge method [inline-methods] */
    public final Boolean m358invoke() {
        ((c) ((CallableReference) this).receiver).getClass();
        return Boolean.valueOf(!Looper.getMainLooper().isCurrentThread());
    }
}
