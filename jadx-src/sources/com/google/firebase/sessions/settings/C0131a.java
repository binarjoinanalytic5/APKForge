package com.google.firebase.sessions.settings;

import android.os.Build;
import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import androidx.datastore.core.h;
import com.google.firebase.sessions.C0100b;
import com.google.firebase.sessions.C0124n;
import com.google.firebase.sessions.C0126o;
import java.util.Arrays;
import java.util.Map;
import kotlinx.coroutines.g0;
import op.i;
import wakotl.Pair;
import wakotl.Unit;
import wakotl.collections.s0;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.CoroutineContext;
import wakotl.jvm.internal.Intrinsics;
import wakotl.text.Regex;

/* JADX INFO: renamed from: com.google.firebase.sessions.settings.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0131a {

    /* JADX INFO: renamed from: a */
    public final CoroutineContext f884a;

    /* JADX INFO: renamed from: b */
    public final lg.d f885b;

    /* JADX INFO: renamed from: c */
    public final C0132b f886c;

    /* JADX INFO: renamed from: d */
    public final i f887d;

    /* JADX INFO: renamed from: e */
    public final kotlinx.coroutines.sync.a f888e;

    public C0131a(CoroutineContext coroutineContext, lg.d dVar, C0100b c0100b, C0132b c0132b, h hVar) {
        Intrinsics.checkNotNullParameter(coroutineContext, "backgroundDispatcher");
        Intrinsics.checkNotNullParameter(dVar, "firebaseInstallationsApi");
        Intrinsics.checkNotNullParameter(c0100b, "appInfo");
        Intrinsics.checkNotNullParameter(c0132b, "configsFetcher");
        Intrinsics.checkNotNullParameter(hVar, "dataStore");
        this.f884a = coroutineContext;
        this.f885b = dVar;
        this.f886c = c0132b;
        this.f887d = wakotl.a.b(new RemoteSettings$settingsCache$2(hVar));
        this.f888e = qq.d.a();
    }

    /* JADX INFO: renamed from: a */
    public final Boolean m340a() {
        C0133c c0133c = m341b().f907b;
        if (c0133c != null) {
            return c0133c.f891a;
        }
        Intrinsics.j("sessionConfigs");
        throw null;
    }

    /* JADX INFO: renamed from: b */
    public final C0136f m341b() {
        return (C0136f) this.f887d.getValue();
    }

    /* JADX WARN: Code duplicated, block: B:46:0x00b7 A[Catch: all -> 0x0056, TRY_ENTER, TRY_LEAVE, TryCatch #0 {all -> 0x0056, blocks: (B:21:0x0052, B:46:0x00b7, B:38:0x0096), top: B:66:0x002d }] */
    /* JADX WARN: Code duplicated, block: B:49:0x00bd A[Catch: all -> 0x017e, TRY_ENTER, TryCatch #2 {all -> 0x017e, blocks: (B:44:0x00ad, B:49:0x00bd, B:52:0x016a, B:36:0x008c, B:41:0x009c), top: B:69:0x008c }] */
    /* JADX WARN: Code duplicated, block: B:51:0x0169  */
    /* JADX WARN: Code duplicated, block: B:52:0x016a A[Catch: all -> 0x017e, TRY_LEAVE, TryCatch #2 {all -> 0x017e, blocks: (B:44:0x00ad, B:49:0x00bd, B:52:0x016a, B:36:0x008c, B:41:0x009c), top: B:69:0x008c }] */
    /* JADX WARN: Code duplicated, block: B:54:0x016e A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:55:0x016f  */
    /* JADX WARN: Code duplicated, block: B:7:0x001f  */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r10v0, types: [int] */
    /* JADX WARN: Type inference failed for: r2v1 */
    /* JADX WARN: Type inference failed for: r2v10 */
    /* JADX WARN: Type inference failed for: r2v11, types: [qq.a] */
    /* JADX WARN: Type inference failed for: r2v14, types: [qq.a] */
    /* JADX WARN: Type inference failed for: r2v15 */
    /* JADX WARN: Type inference failed for: r2v16 */
    /* JADX WARN: Type inference failed for: r2v17 */
    /* JADX WARN: Type inference failed for: r2v2 */
    /* JADX WARN: Type inference failed for: r2v3, types: [qq.a] */
    /* JADX WARN: Type inference failed for: r2v4 */
    /* JADX WARN: Type inference failed for: r2v9 */
    /* JADX INFO: renamed from: c */
    public final Object m342c(Continuation continuation) throws Throwable {
        RemoteSettings$updateSettings$1 remoteSettings$updateSettings$1;
        ?? r2;
        Object obj;
        ?? r3;
        qq.a aVar;
        C0131a c0131a;
        ?? r4;
        String str;
        Object objK;
        if (continuation instanceof RemoteSettings$updateSettings$1) {
            remoteSettings$updateSettings$1 = (RemoteSettings$updateSettings$1) continuation;
            int i = remoteSettings$updateSettings$1.label;
            if ((i & BasicMeasure.AT_MOST) != 0) {
                remoteSettings$updateSettings$1.label = i - BasicMeasure.AT_MOST;
            } else {
                remoteSettings$updateSettings$1 = new RemoteSettings$updateSettings$1(this, continuation);
            }
        } else {
            remoteSettings$updateSettings$1 = new RemoteSettings$updateSettings$1(this, continuation);
        }
        Object objM339a = remoteSettings$updateSettings$1.result;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        ?? r10 = remoteSettings$updateSettings$1.label;
        try {
            try {
                if (r10 != 0) {
                    if (r10 == 1) {
                        aVar = (qq.a) remoteSettings$updateSettings$1.L$1;
                        c0131a = (C0131a) remoteSettings$updateSettings$1.L$0;
                        wakotl.b.b(objM339a);
                    } else if (r10 == 2) {
                        aVar = (qq.a) remoteSettings$updateSettings$1.L$1;
                        c0131a = (C0131a) remoteSettings$updateSettings$1.L$0;
                        wakotl.b.b(objM339a);
                        str = ((C0126o) objM339a).f875a;
                        if (Intrinsics.a(str, "")) {
                            Unit unit = Unit.a;
                            aVar.b((Object) null);
                            return unit;
                        }
                        Pair pair = new Pair("X-Crashlytics-Installation-ID", str);
                        String str2 = String.format("%s/%s", Arrays.copyOf(new Object[]{Build.MANUFACTURER, Build.MODEL}, 2));
                        Intrinsics.checkNotNullExpressionValue(str2, "format(format, *args)");
                        c0131a.getClass();
                        Pair pair2 = new Pair("X-Crashlytics-Device-Model", new Regex("/").replace(str2, ""));
                        String str3 = Build.VERSION.INCREMENTAL;
                        Intrinsics.checkNotNullExpressionValue(str3, "INCREMENTAL");
                        Pair pair3 = new Pair("X-Crashlytics-OS-Build-Version", new Regex("/").replace(str3, ""));
                        String str4 = Build.VERSION.RELEASE;
                        Intrinsics.checkNotNullExpressionValue(str4, "RELEASE");
                        Map mapI = s0.i(new Pair[]{pair, pair2, pair3, new Pair("X-Crashlytics-OS-Display-Version", new Regex("/").replace(str4, "")), new Pair("X-Crashlytics-API-Client-Version", "2.0.8")});
                        C0132b c0132b = c0131a.f886c;
                        RemoteSettings$updateSettings$2$1 remoteSettings$updateSettings$2$1 = new RemoteSettings$updateSettings$2$1(c0131a, null);
                        RemoteSettings$updateSettings$2$2 remoteSettings$updateSettings$2$2 = new RemoteSettings$updateSettings$2$2(null);
                        remoteSettings$updateSettings$1.L$0 = aVar;
                        remoteSettings$updateSettings$1.L$1 = null;
                        remoteSettings$updateSettings$1.label = 3;
                        objK = g0.K(c0132b.f890b, new RemoteSettingsFetcher$doConfigFetch$2(c0132b, mapI, remoteSettings$updateSettings$2$1, remoteSettings$updateSettings$2$2, null), remoteSettings$updateSettings$1);
                        if (objK == wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                            objK = Unit.a;
                        }
                        if (objK == coroutine_suspended) {
                            return coroutine_suspended;
                        }
                        r4 = aVar;
                    } else {
                        if (r10 != 3) {
                            throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
                        }
                        r2 = (qq.a) remoteSettings$updateSettings$1.L$0;
                        try {
                            wakotl.b.b(objM339a);
                            r4 = r2;
                        } catch (Throwable th) {
                            th = th;
                            obj = null;
                            r3 = r2;
                            r3.b(obj);
                            throw th;
                        }
                    }
                    try {
                        Unit unit2 = Unit.a;
                        r4.b((Object) null);
                        return Unit.a;
                    } catch (Throwable th2) {
                        th = th2;
                        obj = null;
                        r3 = r4;
                        r3.b(obj);
                        throw th;
                    }
                }
                wakotl.b.b(objM339a);
                qq.a aVar2 = this.f888e;
                if (!aVar2.f() && !m341b().m347b()) {
                    return Unit.a;
                }
                remoteSettings$updateSettings$1.L$0 = this;
                remoteSettings$updateSettings$1.L$1 = aVar2;
                remoteSettings$updateSettings$1.label = 1;
                if (aVar2.a(remoteSettings$updateSettings$1) == coroutine_suspended) {
                    return coroutine_suspended;
                }
                aVar = aVar2;
                c0131a = this;
                if (!c0131a.m341b().m347b()) {
                    Unit unit3 = Unit.a;
                    aVar.b((Object) null);
                    return unit3;
                }
                C0124n c0124n = C0126o.f874c;
                lg.d dVar = c0131a.f885b;
                remoteSettings$updateSettings$1.L$0 = c0131a;
                remoteSettings$updateSettings$1.L$1 = aVar;
                remoteSettings$updateSettings$1.label = 2;
                objM339a = c0124n.m339a(dVar, remoteSettings$updateSettings$1);
                if (objM339a == coroutine_suspended) {
                    return coroutine_suspended;
                }
                str = ((C0126o) objM339a).f875a;
                if (Intrinsics.a(str, "")) {
                    Unit unit4 = Unit.a;
                    aVar.b((Object) null);
                    return unit4;
                }
                Pair pair4 = new Pair("X-Crashlytics-Installation-ID", str);
                String str5 = String.format("%s/%s", Arrays.copyOf(new Object[]{Build.MANUFACTURER, Build.MODEL}, 2));
                Intrinsics.checkNotNullExpressionValue(str5, "format(format, *args)");
                c0131a.getClass();
                Pair pair5 = new Pair("X-Crashlytics-Device-Model", new Regex("/").replace(str5, ""));
                String str6 = Build.VERSION.INCREMENTAL;
                Intrinsics.checkNotNullExpressionValue(str6, "INCREMENTAL");
                Pair pair6 = new Pair("X-Crashlytics-OS-Build-Version", new Regex("/").replace(str6, ""));
                String str7 = Build.VERSION.RELEASE;
                Intrinsics.checkNotNullExpressionValue(str7, "RELEASE");
                Map mapI2 = s0.i(new Pair[]{pair4, pair5, pair6, new Pair("X-Crashlytics-OS-Display-Version", new Regex("/").replace(str7, "")), new Pair("X-Crashlytics-API-Client-Version", "2.0.8")});
                C0132b c0132b2 = c0131a.f886c;
                RemoteSettings$updateSettings$2$1 remoteSettings$updateSettings$2$3 = new RemoteSettings$updateSettings$2$1(c0131a, null);
                RemoteSettings$updateSettings$2$2 remoteSettings$updateSettings$2$4 = new RemoteSettings$updateSettings$2$2(null);
                remoteSettings$updateSettings$1.L$0 = aVar;
                remoteSettings$updateSettings$1.L$1 = null;
                remoteSettings$updateSettings$1.label = 3;
                objK = g0.K(c0132b2.f890b, new RemoteSettingsFetcher$doConfigFetch$2(c0132b2, mapI2, remoteSettings$updateSettings$2$3, remoteSettings$updateSettings$2$4, null), remoteSettings$updateSettings$1);
                if (objK == wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                    objK = Unit.a;
                }
                if (objK == coroutine_suspended) {
                    return coroutine_suspended;
                }
                r4 = aVar;
                Unit unit5 = Unit.a;
                r4.b((Object) null);
                return Unit.a;
            } catch (Throwable th3) {
                th = th3;
                r4 = aVar;
                obj = null;
                r3 = r4;
                r3.b(obj);
                throw th;
            }
        } catch (Throwable th4) {
            th = th4;
            r2 = r10;
        }
    }
}
