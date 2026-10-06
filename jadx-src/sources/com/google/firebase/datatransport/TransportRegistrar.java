package com.google.firebase.datatransport;

import android.content.Context;
import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import androidx.core.view.h;
import com.bumptech.glide.e;
import com.google.firebase.components.ComponentRegistrar;
import eb.f;
import fb.a;
import hb.q;
import java.util.Arrays;
import java.util.List;
import jf.b;
import jf.c;
import jf.i;
import jf.o;

/* JADX INFO: loaded from: classes.dex */
@Keep
public class TransportRegistrar implements ComponentRegistrar {
    private static final String LIBRARY_NAME = "fire-transport";

    /* JADX INFO: Access modifiers changed from: private */
    public static /* synthetic */ f lambda$getComponents$0(c cVar) {
        q.b((Context) cVar.a(Context.class));
        return q.a().c(a.f);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static /* synthetic */ f lambda$getComponents$1(c cVar) {
        q.b((Context) cVar.a(Context.class));
        return q.a().c(a.f);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static /* synthetic */ f lambda$getComponents$2(c cVar) {
        q.b((Context) cVar.a(Context.class));
        return q.a().c(a.e);
    }

    @Override // com.google.firebase.components.ComponentRegistrar
    @NonNull
    public List<b> getComponents() {
        jf.a aVarA = b.a(f.class);
        aVarA.a = LIBRARY_NAME;
        aVarA.a(i.a(Context.class));
        aVarA.f = new h(2);
        b bVarB = aVarA.b();
        jf.a aVarB = b.b(new o(bg.a.class, f.class));
        aVarB.a(i.a(Context.class));
        aVarB.f = new h(3);
        b bVarB2 = aVarB.b();
        jf.a aVarB2 = b.b(new o(bg.b.class, f.class));
        aVarB2.a(i.a(Context.class));
        aVarB2.f = new h(4);
        return Arrays.asList(bVarB, bVarB2, aVarB2.b(), e.K(LIBRARY_NAME, "19.0.0"));
    }
}
