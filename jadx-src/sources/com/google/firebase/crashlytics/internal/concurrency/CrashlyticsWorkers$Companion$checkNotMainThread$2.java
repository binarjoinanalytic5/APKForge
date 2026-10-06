package com.google.firebase.crashlytics.internal.concurrency;

import androidx.constraintlayout.widget.ConstraintLayout;
import org.jetbrains.annotations.NotNull;
import wakotl.Metadata;
import wakotl.jvm.functions.Function0;
import wakotl.jvm.internal.Lambda;

/* JADX INFO: loaded from: classes.dex */
@Metadata(d1 = {"\u0000\b\n\u0000\n\u0002\u0010\u000e\n\u0000\u0010\u0000\u001a\u00020\u0001H\n¢\u0006\u0002\b\u0002"}, d2 = {"<anonymous>", "", "invoke"}, k = 3, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
final class CrashlyticsWorkers$Companion$checkNotMainThread$2 extends Lambda implements Function0<String> {
    public static final CrashlyticsWorkers$Companion$checkNotMainThread$2 INSTANCE = new CrashlyticsWorkers$Companion$checkNotMainThread$2();

    public CrashlyticsWorkers$Companion$checkNotMainThread$2() {
        super(0);
    }

    @NotNull
    public final String invoke() {
        return "Must not be called on a main thread, was called on " + Thread.currentThread().getName() + '.';
    }
}
