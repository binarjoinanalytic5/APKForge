package com.google.firebase.messaging;

import androidx.annotation.Keep;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.firebase.components.ComponentRegistrar;
import java.util.Arrays;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@Keep
@KeepForSdk
public class FirebaseMessagingRegistrar implements ComponentRegistrar {
    private static final String LIBRARY_NAME = "fire-fcm";

    /* JADX INFO: Access modifiers changed from: private */
    public static /* synthetic */ FirebaseMessaging lambda$getComponents$0(jf.o oVar, jf.c cVar) {
        ef.h hVar = (ef.h) cVar.a(ef.h.class);
        if (cVar.a(jg.a.class) == null) {
            return new FirebaseMessaging(hVar, cVar.e(sg.b.class), cVar.e(ig.f.class), (lg.d) cVar.a(lg.d.class), cVar.b(oVar), (hg.c) cVar.a(hg.c.class));
        }
        throw new ClassCastException();
    }

    @Override // com.google.firebase.components.ComponentRegistrar
    @Keep
    public List<jf.b> getComponents() {
        jf.o oVar = new jf.o(bg.b.class, eb.f.class);
        jf.a aVarA = jf.b.a(FirebaseMessaging.class);
        aVarA.a = LIBRARY_NAME;
        aVarA.a(jf.i.a(ef.h.class));
        aVarA.a(new jf.i(jg.a.class, 0, 0));
        aVarA.a(new jf.i(sg.b.class, 0, 1));
        aVarA.a(new jf.i(ig.f.class, 0, 1));
        aVarA.a(jf.i.a(lg.d.class));
        aVarA.a(new jf.i(oVar, 0, 1));
        aVarA.a(jf.i.a(hg.c.class));
        aVarA.f = new C0080m(oVar, 0);
        aVarA.c(1);
        return Arrays.asList(aVarA.b(), com.bumptech.glide.e.K(LIBRARY_NAME, "24.1.0"));
    }
}
