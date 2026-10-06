package com.google.firebase;

import android.content.Context;
import android.os.Build;
import com.google.firebase.components.ComponentRegistrar;
import com.google.firebase.messaging.C0080m;
import ef.h;
import ig.c;
import ig.d;
import ig.e;
import ig.f;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executor;
import jf.a;
import jf.b;
import jf.i;
import jf.o;

/* JADX INFO: loaded from: classes.dex */
public class FirebaseCommonRegistrar implements ComponentRegistrar {
    /* JADX INFO: renamed from: a */
    public static String m198a(String str) {
        return str.replace(' ', '_').replace('/', '_');
    }

    @Override // com.google.firebase.components.ComponentRegistrar
    public final List getComponents() {
        String str;
        ArrayList arrayList = new ArrayList();
        a aVarA = b.a(sg.b.class);
        aVarA.a(new i(sg.a.class, 2, 0));
        aVarA.f = new ef.i(13);
        arrayList.add(aVarA.b());
        o oVar = new o(if.a.class, Executor.class);
        a aVar = new a(c.class, new Class[]{e.class, f.class});
        aVar.a(i.a(Context.class));
        aVar.a(i.a(h.class));
        aVar.a(new i(d.class, 2, 0));
        aVar.a(new i(sg.b.class, 1, 1));
        aVar.a(new i(oVar, 1, 0));
        aVar.f = new C0080m(oVar, 1);
        arrayList.add(aVar.b());
        arrayList.add(com.bumptech.glide.e.K("fire-android", String.valueOf(Build.VERSION.SDK_INT)));
        arrayList.add(com.bumptech.glide.e.K("fire-core", "21.0.0"));
        arrayList.add(com.bumptech.glide.e.K("device-name", m198a(Build.PRODUCT)));
        arrayList.add(com.bumptech.glide.e.K("device-model", m198a(Build.DEVICE)));
        arrayList.add(com.bumptech.glide.e.K("device-brand", m198a(Build.BRAND)));
        arrayList.add(com.bumptech.glide.e.S("android-target-sdk", new androidx.core.view.h(27)));
        arrayList.add(com.bumptech.glide.e.S("android-min-sdk", new androidx.core.view.h(28)));
        arrayList.add(com.bumptech.glide.e.S("android-platform", new androidx.core.view.h(29)));
        arrayList.add(com.bumptech.glide.e.S("android-installer", new ef.i(0)));
        try {
            op.h.c.getClass();
            str = "2.3.0";
        } catch (NoClassDefFoundError unused) {
            str = null;
        }
        if (str != null) {
            arrayList.add(com.bumptech.glide.e.K("kotlin", str));
        }
        return arrayList;
    }
}
