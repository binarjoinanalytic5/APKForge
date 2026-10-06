package com.google.firebase.sessions;

import android.content.Context;
import androidx.annotation.Keep;
import androidx.constraintlayout.widget.ConstraintLayout;
import com.google.firebase.components.ComponentRegistrar;
import com.google.firebase.sessions.settings.C0135e;
import java.util.List;
import org.jetbrains.annotations.NotNull;
import wakotl.Metadata;
import wakotl.coroutines.CoroutineContext;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: loaded from: classes.dex */
@Keep
@Metadata(d1 = {"\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0006\b\u0001\u0018\u0000 \n2\u00020\u0001:\u0001\u000bB\u0007¢\u0006\u0004\b\u0002\u0010\u0003J=\u0010\b\u001a0\u0012,\u0012*\u0012\u000e\b\u0001\u0012\n \u0007*\u0004\u0018\u00010\u00060\u0006 \u0007*\u0014\u0012\u000e\b\u0001\u0012\n \u0007*\u0004\u0018\u00010\u00060\u0006\u0018\u00010\u00050\u00050\u0004H\u0016¢\u0006\u0004\b\b\u0010\t¨\u0006\f"}, d2 = {"Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;", "Lcom/google/firebase/components/ComponentRegistrar;", "<init>", "()V", "", "Ljf/b;", "", "kotlin.jvm.PlatformType", "getComponents", "()Ljava/util/List;", "Companion", "com/google/firebase/sessions/m", "com.google.firebase-firebase-sessions"}, k = 1, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
public final class FirebaseSessionsRegistrar implements ComponentRegistrar {

    @NotNull
    private static final C0122m Companion = new C0122m();

    @NotNull
    private static final String LIBRARY_NAME = "fire-sessions";

    @NotNull
    private static final jf.o backgroundDispatcher;

    @NotNull
    private static final jf.o blockingDispatcher;

    @NotNull
    private static final jf.o firebaseApp;

    @NotNull
    private static final jf.o firebaseInstallationsApi;

    @NotNull
    private static final jf.o sessionLifecycleServiceBinder;

    @NotNull
    private static final jf.o sessionsSettings;

    @NotNull
    private static final jf.o transportFactory;

    static {
        jf.o oVarA = jf.o.a(ef.h.class);
        Intrinsics.checkNotNullExpressionValue(oVarA, "unqualified(FirebaseApp::class.java)");
        firebaseApp = oVarA;
        jf.o oVarA2 = jf.o.a(lg.d.class);
        Intrinsics.checkNotNullExpressionValue(oVarA2, "unqualified(FirebaseInstallationsApi::class.java)");
        firebaseInstallationsApi = oVarA2;
        jf.o oVar = new jf.o(if.a.class, kotlinx.coroutines.a0.class);
        Intrinsics.checkNotNullExpressionValue(oVar, "qualified(Background::cl…neDispatcher::class.java)");
        backgroundDispatcher = oVar;
        jf.o oVar2 = new jf.o(if.b.class, kotlinx.coroutines.a0.class);
        Intrinsics.checkNotNullExpressionValue(oVar2, "qualified(Blocking::clas…neDispatcher::class.java)");
        blockingDispatcher = oVar2;
        jf.o oVarA3 = jf.o.a(eb.f.class);
        Intrinsics.checkNotNullExpressionValue(oVarA3, "unqualified(TransportFactory::class.java)");
        transportFactory = oVarA3;
        jf.o oVarA4 = jf.o.a(C0135e.class);
        Intrinsics.checkNotNullExpressionValue(oVarA4, "unqualified(SessionsSettings::class.java)");
        sessionsSettings = oVarA4;
        jf.o oVarA5 = jf.o.a(InterfaceC0119k0.class);
        Intrinsics.checkNotNullExpressionValue(oVarA5, "unqualified(SessionLifec…erviceBinder::class.java)");
        sessionLifecycleServiceBinder = oVarA5;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static final C0118k getComponents$lambda$0(jf.c cVar) {
        Object objC = cVar.c(firebaseApp);
        Intrinsics.checkNotNullExpressionValue(objC, "container[firebaseApp]");
        Object objC2 = cVar.c(sessionsSettings);
        Intrinsics.checkNotNullExpressionValue(objC2, "container[sessionsSettings]");
        Object objC3 = cVar.c(backgroundDispatcher);
        Intrinsics.checkNotNullExpressionValue(objC3, "container[backgroundDispatcher]");
        Object objC4 = cVar.c(sessionLifecycleServiceBinder);
        Intrinsics.checkNotNullExpressionValue(objC4, "container[sessionLifecycleServiceBinder]");
        return new C0118k((ef.h) objC, (C0135e) objC2, (CoroutineContext) objC3, (InterfaceC0119k0) objC4);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static final C0105d0 getComponents$lambda$1(jf.c cVar) {
        return new C0105d0();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static final InterfaceC0101b0 getComponents$lambda$2(jf.c cVar) {
        Object objC = cVar.c(firebaseApp);
        Intrinsics.checkNotNullExpressionValue(objC, "container[firebaseApp]");
        ef.h hVar = (ef.h) objC;
        Object objC2 = cVar.c(firebaseInstallationsApi);
        Intrinsics.checkNotNullExpressionValue(objC2, "container[firebaseInstallationsApi]");
        lg.d dVar = (lg.d) objC2;
        Object objC3 = cVar.c(sessionsSettings);
        Intrinsics.checkNotNullExpressionValue(objC3, "container[sessionsSettings]");
        C0135e c0135e = (C0135e) objC3;
        kg.b bVarB = cVar.b(transportFactory);
        Intrinsics.checkNotNullExpressionValue(bVarB, "container.getProvider(transportFactory)");
        C0116j c0116j = new C0116j(bVarB);
        Object objC4 = cVar.c(backgroundDispatcher);
        Intrinsics.checkNotNullExpressionValue(objC4, "container[backgroundDispatcher]");
        return new C0103c0(hVar, dVar, c0135e, c0116j, (CoroutineContext) objC4);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static final C0135e getComponents$lambda$3(jf.c cVar) {
        Object objC = cVar.c(firebaseApp);
        Intrinsics.checkNotNullExpressionValue(objC, "container[firebaseApp]");
        Object objC2 = cVar.c(blockingDispatcher);
        Intrinsics.checkNotNullExpressionValue(objC2, "container[blockingDispatcher]");
        Object objC3 = cVar.c(backgroundDispatcher);
        Intrinsics.checkNotNullExpressionValue(objC3, "container[backgroundDispatcher]");
        Object objC4 = cVar.c(firebaseInstallationsApi);
        Intrinsics.checkNotNullExpressionValue(objC4, "container[firebaseInstallationsApi]");
        return new C0135e((ef.h) objC, (CoroutineContext) objC2, (CoroutineContext) objC3, (lg.d) objC4);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static final InterfaceC0129r getComponents$lambda$4(jf.c cVar) {
        ef.h hVar = (ef.h) cVar.c(firebaseApp);
        hVar.a();
        Context context = hVar.a;
        Intrinsics.checkNotNullExpressionValue(context, "container[firebaseApp].applicationContext");
        Object objC = cVar.c(backgroundDispatcher);
        Intrinsics.checkNotNullExpressionValue(objC, "container[backgroundDispatcher]");
        return new C0141x(context, (CoroutineContext) objC);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static final InterfaceC0119k0 getComponents$lambda$5(jf.c cVar) {
        Object objC = cVar.c(firebaseApp);
        Intrinsics.checkNotNullExpressionValue(objC, "container[firebaseApp]");
        return new C0121l0((ef.h) objC);
    }

    @Override // com.google.firebase.components.ComponentRegistrar
    @NotNull
    public List<jf.b> getComponents() {
        jf.a aVarA = jf.b.a(C0118k.class);
        aVarA.a = LIBRARY_NAME;
        jf.o oVar = firebaseApp;
        aVarA.a(jf.i.b(oVar));
        jf.o oVar2 = sessionsSettings;
        aVarA.a(jf.i.b(oVar2));
        jf.o oVar3 = backgroundDispatcher;
        aVarA.a(jf.i.b(oVar3));
        aVarA.a(jf.i.b(sessionLifecycleServiceBinder));
        aVarA.f = new androidx.core.view.h(17);
        aVarA.c(2);
        jf.b bVarB = aVarA.b();
        jf.a aVarA2 = jf.b.a(C0105d0.class);
        aVarA2.a = "session-generator";
        aVarA2.f = new androidx.core.view.h(18);
        jf.b bVarB2 = aVarA2.b();
        jf.a aVarA3 = jf.b.a(InterfaceC0101b0.class);
        aVarA3.a = "session-publisher";
        aVarA3.a(new jf.i(oVar, 1, 0));
        jf.o oVar4 = firebaseInstallationsApi;
        aVarA3.a(jf.i.b(oVar4));
        aVarA3.a(new jf.i(oVar2, 1, 0));
        aVarA3.a(new jf.i(transportFactory, 1, 1));
        aVarA3.a(new jf.i(oVar3, 1, 0));
        aVarA3.f = new androidx.core.view.h(19);
        jf.b bVarB3 = aVarA3.b();
        jf.a aVarA4 = jf.b.a(C0135e.class);
        aVarA4.a = "sessions-settings";
        aVarA4.a(new jf.i(oVar, 1, 0));
        aVarA4.a(jf.i.b(blockingDispatcher));
        aVarA4.a(new jf.i(oVar3, 1, 0));
        aVarA4.a(new jf.i(oVar4, 1, 0));
        aVarA4.f = new androidx.core.view.h(20);
        jf.b bVarB4 = aVarA4.b();
        jf.a aVarA5 = jf.b.a(InterfaceC0129r.class);
        aVarA5.a = "sessions-datastore";
        aVarA5.a(new jf.i(oVar, 1, 0));
        aVarA5.a(new jf.i(oVar3, 1, 0));
        aVarA5.f = new androidx.core.view.h(21);
        jf.b bVarB5 = aVarA5.b();
        jf.a aVarA6 = jf.b.a(InterfaceC0119k0.class);
        aVarA6.a = "sessions-service-binder";
        aVarA6.a(new jf.i(oVar, 1, 0));
        aVarA6.f = new androidx.core.view.h(22);
        return wakotl.collections.c0.l(new jf.b[]{bVarB, bVarB2, bVarB3, bVarB4, bVarB5, aVarA6.b(), com.bumptech.glide.e.K(LIBRARY_NAME, "2.0.8")});
    }
}
