package com.google.firebase.installations;

import androidx.annotation.Keep;
import com.google.firebase.components.ComponentRegistrar;
import com.google.firebase.concurrent.ExecutorC0052b;
import ef.h;
import if.b;
import ig.e;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import jf.c;
import jf.i;
import jf.o;
import lg.d;

/* JADX INFO: loaded from: classes.dex */
@Keep
public class FirebaseInstallationsRegistrar implements ComponentRegistrar {
    private static final String LIBRARY_NAME = "fire-installations";

    /* JADX INFO: Access modifiers changed from: private */
    public static d lambda$getComponents$0(c cVar) {
        return new C0059a((h) cVar.a(h.class), cVar.e(e.class), (ExecutorService) cVar.c(new o(if.a.class, ExecutorService.class)), new ExecutorC0052b((Executor) cVar.c(new o(b.class, Executor.class))));
    }

    @Override // com.google.firebase.components.ComponentRegistrar
    public List<jf.b> getComponents() {
        jf.a aVarA = jf.b.a(d.class);
        aVarA.a = LIBRARY_NAME;
        aVarA.a(i.a(h.class));
        aVarA.a(new i(e.class, 0, 1));
        aVarA.a(new i(new o(if.a.class, ExecutorService.class), 1, 0));
        aVarA.a(new i(new o(b.class, Executor.class), 1, 0));
        aVarA.f = new ef.i(9);
        jf.b bVarB = aVarA.b();
        ig.d dVar = new ig.d(0);
        jf.a aVarA2 = jf.b.a(ig.d.class);
        aVarA2.e = 1;
        aVarA2.f = new f(dVar, 14);
        return Arrays.asList(bVarB, aVarA2.b(), com.bumptech.glide.e.K(LIBRARY_NAME, "18.0.0"));
    }
}
