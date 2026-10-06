package com.google.firebase.sessions;

import androidx.constraintlayout.widget.ConstraintLayout;
import java.util.UUID;
import wakotl.Metadata;
import wakotl.jvm.functions.Function0;
import wakotl.jvm.internal.FunctionReferenceImpl;

/* JADX INFO: loaded from: classes.dex */
@Metadata(k = 3, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
final /* synthetic */ class SessionGenerator$1 extends FunctionReferenceImpl implements Function0<UUID> {
    public static final SessionGenerator$1 INSTANCE = new SessionGenerator$1();

    public SessionGenerator$1() {
        super(0, UUID.class, "randomUUID", "randomUUID()Ljava/util/UUID;", 0);
    }

    public final UUID invoke() {
        return UUID.randomUUID();
    }
}
