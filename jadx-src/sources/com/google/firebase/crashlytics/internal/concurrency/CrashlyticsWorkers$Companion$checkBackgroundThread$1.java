package com.google.firebase.crashlytics.internal.concurrency;

import androidx.constraintlayout.widget.ConstraintLayout;
import org.jetbrains.annotations.NotNull;
import qf.c;
import wakotl.Metadata;
import wakotl.jvm.functions.Function0;
import wakotl.jvm.internal.CallableReference;
import wakotl.jvm.internal.FunctionReferenceImpl;
import wakotl.jvm.internal.Intrinsics;
import wakotl.text.StringsKt;

/* JADX INFO: loaded from: classes.dex */
@Metadata(k = 3, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
final /* synthetic */ class CrashlyticsWorkers$Companion$checkBackgroundThread$1 extends FunctionReferenceImpl implements Function0<Boolean> {
    public CrashlyticsWorkers$Companion$checkBackgroundThread$1(Object obj) {
        super(0, obj, c.class, "isBackgroundThread", "isBackgroundThread()Z", 0);
    }

    @NotNull
    /* JADX INFO: renamed from: invoke, reason: merged with bridge method [inline-methods] */
    public final Boolean m354invoke() {
        ((c) ((CallableReference) this).receiver).getClass();
        String name = Thread.currentThread().getName();
        Intrinsics.checkNotNullExpressionValue(name, "threadName");
        return Boolean.valueOf(StringsKt.K(name, "Firebase Background Thread #", false));
    }
}
