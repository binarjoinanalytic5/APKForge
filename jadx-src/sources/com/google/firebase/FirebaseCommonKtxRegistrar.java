package com.google.firebase;

import androidx.annotation.Keep;
import androidx.constraintlayout.widget.ConstraintLayout;
import com.google.firebase.components.ComponentRegistrar;
import ef.c;
import if.d;
import java.util.List;
import java.util.concurrent.Executor;
import jf.a;
import jf.b;
import jf.i;
import jf.o;
import kotlinx.coroutines.a0;
import org.jetbrains.annotations.NotNull;
import wakotl.Metadata;
import wakotl.collections.c0;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: loaded from: classes.dex */
@Keep
@Metadata(d1 = {"\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\b\u0003\b\u0007\u0018\u00002\u00020\u0001B\u0007¢\u0006\u0004\b\u0002\u0010\u0003J\u0019\u0010\u0006\u001a\f\u0012\b\u0012\u0006\u0012\u0002\b\u00030\u00050\u0004H\u0016¢\u0006\u0004\b\u0006\u0010\u0007¨\u0006\b"}, d2 = {"Lcom/google/firebase/FirebaseCommonKtxRegistrar;", "Lcom/google/firebase/components/ComponentRegistrar;", "<init>", "()V", "", "Ljf/b;", "getComponents", "()Ljava/util/List;", "com.google.firebase-firebase-common"}, k = 1, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
public final class FirebaseCommonKtxRegistrar implements ComponentRegistrar {
    @Override // com.google.firebase.components.ComponentRegistrar
    @NotNull
    public List<b> getComponents() {
        a aVarB = b.b(new o(if.a.class, a0.class));
        aVarB.a(new i(new o(if.a.class, Executor.class), 1, 0));
        aVarB.f = c.c;
        b bVarB = aVarB.b();
        Intrinsics.checkNotNullExpressionValue(bVarB, "builder(Qualified.qualif…cher()\n    }\n    .build()");
        a aVarB2 = b.b(new o(if.c.class, a0.class));
        aVarB2.a(new i(new o(if.c.class, Executor.class), 1, 0));
        aVarB2.f = c.d;
        b bVarB2 = aVarB2.b();
        Intrinsics.checkNotNullExpressionValue(bVarB2, "builder(Qualified.qualif…cher()\n    }\n    .build()");
        a aVarB3 = b.b(new o(if.b.class, a0.class));
        aVarB3.a(new i(new o(if.b.class, Executor.class), 1, 0));
        aVarB3.f = c.e;
        b bVarB3 = aVarB3.b();
        Intrinsics.checkNotNullExpressionValue(bVarB3, "builder(Qualified.qualif…cher()\n    }\n    .build()");
        a aVarB4 = b.b(new o(d.class, a0.class));
        aVarB4.a(new i(new o(d.class, Executor.class), 1, 0));
        aVarB4.f = c.f;
        b bVarB4 = aVarB4.b();
        Intrinsics.checkNotNullExpressionValue(bVarB4, "builder(Qualified.qualif…cher()\n    }\n    .build()");
        return c0.l(new b[]{bVarB, bVarB2, bVarB3, bVarB4});
    }
}
