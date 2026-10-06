package com.google.firebase.sessions.settings;

import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import androidx.constraintlayout.widget.ConstraintLayout;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import wakotl.Metadata;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.ContinuationImpl;
import wakotl.coroutines.jvm.internal.DebugMetadata;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.settings.SessionsSettings", f = "SessionsSettings.kt", i = {0}, l = {138, 139}, m = "updateSettings", n = {"this"}, s = {"L$0"})
@Metadata(k = 3, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
final class SessionsSettings$updateSettings$1 extends ContinuationImpl {
    Object L$0;
    int label;
    /* synthetic */ Object result;
    final /* synthetic */ C0135e this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public SessionsSettings$updateSettings$1(C0135e c0135e, Continuation<? super SessionsSettings$updateSettings$1> continuation) {
        super(continuation);
        this.this$0 = c0135e;
    }

    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) {
        this.result = obj;
        this.label |= BasicMeasure.AT_MOST;
        return this.this$0.m345b(this);
    }
}
