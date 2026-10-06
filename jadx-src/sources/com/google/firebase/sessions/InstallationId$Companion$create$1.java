package com.google.firebase.sessions;

import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import androidx.constraintlayout.widget.ConstraintLayout;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import wakotl.Metadata;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.ContinuationImpl;
import wakotl.coroutines.jvm.internal.DebugMetadata;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.InstallationId$Companion", f = "InstallationId.kt", i = {0, 1}, l = {32, ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_TOP_CREATOR}, m = "create", n = {"firebaseInstallations", "authToken"}, s = {"L$0", "L$0"})
@Metadata(k = 3, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
final class InstallationId$Companion$create$1 extends ContinuationImpl {
    Object L$0;
    int label;
    /* synthetic */ Object result;
    final /* synthetic */ C0124n this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public InstallationId$Companion$create$1(C0124n c0124n, Continuation<? super InstallationId$Companion$create$1> continuation) {
        super(continuation);
        this.this$0 = c0124n;
    }

    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) {
        this.result = obj;
        this.label |= BasicMeasure.AT_MOST;
        return this.this$0.m339a(null, this);
    }
}
