package com.google.firebase.crashlytics.internal.common;

import android.app.ActivityManager;
import android.app.ApplicationExitInfo;
import android.content.Context;
import android.os.Build;
import android.os.Environment;
import android.os.StatFs;
import android.text.TextUtils;
import android.util.Base64;
import android.util.JsonReader;
import android.util.Log;
import androidx.core.view.h0;
import androidx.work.impl.model.l;
import androidx.work.impl.w;
import com.applovin.impl.sdk.b0;
import com.facebook.appevents.p;
import com.facebook.internal.f1;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.crashlytics.internal.concurrency.C0054a;
import com.google.firebase.crashlytics.internal.settings.C0055a;
import com.moloco.sdk.xenoss.sdkdevkit.android.adrenderer.internal.vast.model.k;
import gc.i;
import j$.util.DesugarCollections;
import j$.util.Objects;
import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Serializable;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.NavigableSet;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicMarkableReference;
import pf.d;
import pf.g;
import pf.j;
import pf.m;
import pf.q;
import pf.r;
import pf.s;
import pf.x;
import rf.e;
import rf.f;
import rf.h;
import rf.n;
import sf.a0;
import sf.c0;
import sf.d0;
import sf.g0;
import sf.i0;
import sf.j0;
import sf.k0;
import sf.m0;
import sf.m1;
import sf.o0;
import sf.p0;
import sf.p1;
import sf.q0;
import sf.q1;
import sf.r1;
import sf.s1;
import sf.s2;
import sf.u1;
import sf.x0;
import vf.b;
import vf.c;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.crashlytics.internal.common.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0053a {

    /* JADX INFO: renamed from: s */
    public static final f1 f590s = new f1(2);

    /* JADX INFO: renamed from: a */
    public final Context f591a;

    /* JADX INFO: renamed from: b */
    public final s f592b;

    /* JADX INFO: renamed from: c */
    public final l f593c;

    /* JADX INFO: renamed from: d */
    public final c f594d;

    /* JADX INFO: renamed from: e */
    public final C0054a f595e;

    /* JADX INFO: renamed from: f */
    public final x f596f;

    /* JADX INFO: renamed from: g */
    public final c f597g;

    /* JADX INFO: renamed from: h */
    public final w f598h;

    /* JADX INFO: renamed from: i */
    public final f f599i;

    /* JADX INFO: renamed from: j */
    public final mf.c f600j;

    /* JADX INFO: renamed from: k */
    public final lf.a f601k;

    /* JADX INFO: renamed from: l */
    public final j f602l;

    /* JADX INFO: renamed from: m */
    public final c f603m;

    /* JADX INFO: renamed from: n */
    public r f604n;

    /* JADX INFO: renamed from: o */
    public final TaskCompletionSource f605o = new TaskCompletionSource();

    /* JADX INFO: renamed from: p */
    public final TaskCompletionSource f606p = new TaskCompletionSource();

    /* JADX INFO: renamed from: q */
    public final TaskCompletionSource f607q = new TaskCompletionSource();

    /* JADX INFO: renamed from: r */
    public final AtomicBoolean f608r = new AtomicBoolean(false);

    public C0053a(Context context, x xVar, s sVar, c cVar, l lVar, w wVar, c cVar2, f fVar, c cVar3, mf.c cVar4, lf.a aVar, j jVar, C0054a c0054a) {
        this.f591a = context;
        this.f596f = xVar;
        this.f592b = sVar;
        this.f597g = cVar;
        this.f593c = lVar;
        this.f598h = wVar;
        this.f594d = cVar2;
        this.f599i = fVar;
        this.f600j = cVar4;
        this.f601k = aVar;
        this.f602l = jVar;
        this.f603m = cVar3;
        this.f595e = c0054a;
    }

    /* JADX INFO: renamed from: a */
    public static Task m201a(C0053a c0053a) {
        Task taskCall;
        c0053a.getClass();
        ArrayList arrayList = new ArrayList();
        for (File file : c.l(((File) c0053a.f597g.c).listFiles(f590s))) {
            try {
                long j = Long.parseLong(file.getName().substring(3));
                try {
                    Class.forName("com.google.firebase.crash.FirebaseCrash");
                    taskCall = Tasks.forResult((Object) null);
                } catch (ClassNotFoundException unused) {
                    taskCall = Tasks.call(new ScheduledThreadPoolExecutor(1), new m(c0053a, j));
                }
                arrayList.add(taskCall);
            } catch (NumberFormatException unused2) {
                file.getName();
            }
            file.delete();
        }
        return Tasks.whenAll(arrayList);
    }

    /* JADX WARN: Code duplicated, block: B:174:0x05f6  */
    /* JADX WARN: Code duplicated, block: B:35:0x00f8  */
    /* JADX WARN: Code duplicated, block: B:77:0x0255  */
    /* JADX WARN: Code duplicated, block: B:85:0x030c  */
    /* JADX WARN: Instruction removed from duplicated block: B:35:0x00f8, please report this as an issue */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r14v29, types: [int] */
    /* JADX WARN: Type inference failed for: r14v30 */
    /* JADX WARN: Type inference failed for: r14v33 */
    /* JADX WARN: Type inference failed for: r14v35 */
    /* JADX WARN: Type inference failed for: r14v36 */
    /* JADX WARN: Type inference failed for: r23v0, types: [boolean] */
    /* JADX WARN: Type inference failed for: r7v11, types: [byte[], java.io.Serializable] */
    /* JADX WARN: Type inference failed for: r8v15 */
    /* JADX WARN: Type inference failed for: r8v16, types: [java.io.Closeable] */
    /* JADX WARN: Type inference failed for: r8v17 */
    /* JADX WARN: Type inference failed for: r9v14 */
    /* JADX WARN: Type inference failed for: r9v15, types: [int] */
    /* JADX WARN: Type inference failed for: r9v25 */
    /* JADX INFO: renamed from: b */
    public final void m202b(boolean z, C0055a c0055a, boolean z2) throws Throwable {
        ArrayList arrayList;
        boolean z3;
        String str;
        boolean z4;
        String[] list;
        List listEmptyList;
        ApplicationExitInfo applicationExitInfoD;
        String string;
        List listUnmodifiableList;
        ?? r8;
        FileInputStream fileInputStream;
        C0054a.m208a();
        ArrayList arrayList2 = new ArrayList(((vf.a) this.f603m.b).c());
        if (arrayList2.size() <= z) {
            return;
        }
        String str2 = (String) arrayList2.get(z == true ? 1 : 0);
        if (z2 && c0055a.m212b().b.b && Build.VERSION.SDK_INT >= 30) {
            List listL = h0.l((ActivityManager) this.f591a.getSystemService("activity"));
            if (listL.size() != 0) {
                c cVar = this.f597g;
                f fVar = new f(cVar);
                l3.c cVar2 = f.c;
                cVar2.a();
                fVar.b = cVar2;
                if (str2 != null) {
                    fVar.b = new n(cVar.g(str2, "userlog"));
                }
                c cVar3 = this.f597g;
                C0054a c0054a = this.f595e;
                h hVar = new h(cVar3);
                c cVar4 = new c(str2, cVar3, c0054a);
                ((e) ((AtomicMarkableReference) ((b6.j) cVar4.d).b).getReference()).d(hVar.c(str2, false));
                ((e) ((AtomicMarkableReference) ((b6.j) cVar4.e).b).getReference()).d(hVar.c(str2, true));
                ((AtomicMarkableReference) cVar4.g).set(hVar.d(str2), false);
                p pVar = (p) cVar4.f;
                File fileG = cVar3.g(str2, "rollouts-state");
                arrayList = arrayList2;
                if (fileG.exists()) {
                    ?? r14 = (fileG.length() > 0L ? 1 : (fileG.length() == 0L ? 0 : -1));
                    try {
                        if (r14 == 0) {
                            h.g(fileG, "The file has a length of zero for session: " + str2);
                            listEmptyList = Collections.emptyList();
                        } else {
                            try {
                                fileInputStream = new FileInputStream(fileG);
                                try {
                                    listEmptyList = h.b(g.j(fileInputStream));
                                    listEmptyList.toString();
                                    g.b(fileInputStream, "Failed to close rollouts state file.");
                                    r14 = fileInputStream;
                                } catch (Exception unused) {
                                    h.f(fileG);
                                    g.b(fileInputStream, "Failed to close rollouts state file.");
                                    listEmptyList = Collections.emptyList();
                                    r14 = fileInputStream;
                                }
                            } catch (Exception unused2) {
                                fileInputStream = null;
                            } catch (Throwable th) {
                                th = th;
                                r8 = 0;
                                g.b((Closeable) r8, "Failed to close rollouts state file.");
                                throw th;
                            }
                        }
                    } catch (Throwable th2) {
                        th = th2;
                        r8 = r14;
                    }
                } else {
                    h.g(fileG, "The file has a length of zero for session: " + str2);
                    listEmptyList = Collections.emptyList();
                }
                List list2 = listEmptyList;
                synchronized (pVar) {
                    ((ArrayList) pVar.c).clear();
                    int size = list2.size();
                    int i = pVar.b;
                    if (size > i) {
                        ((ArrayList) pVar.c).addAll(list2.subList(0, i));
                    } else {
                        ((ArrayList) pVar.c).addAll(list2);
                    }
                }
                c cVar5 = this.f603m;
                vf.a aVar = (vf.a) cVar5.b;
                long jLastModified = aVar.b.g(str2, "start-time").lastModified();
                Iterator it = listL.iterator();
                do {
                    if (it.hasNext()) {
                        applicationExitInfoD = h0.d(it.next());
                        if (h0.c(applicationExitInfoD) < jLastModified) {
                        }
                    }
                    applicationExitInfoD = null;
                    break;
                } while (h0.b(applicationExitInfoD) != 6);
                if (applicationExitInfoD != null) {
                    try {
                        InputStream inputStreamG = b0.g(applicationExitInfoD);
                        if (inputStreamG != null) {
                            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                            byte[] bArr = new byte[8192];
                            while (true) {
                                int i2 = inputStreamG.read(bArr);
                                if (i2 == -1) {
                                    break;
                                } else {
                                    byteArrayOutputStream.write(bArr, 0, i2);
                                }
                                string = null;
                            }
                            string = byteArrayOutputStream.toString(StandardCharsets.UTF_8.name());
                        } else {
                            string = null;
                        }
                    } catch (IOException e) {
                        com.google.android.gms.internal.ads.x.g(applicationExitInfoD);
                        e.toString();
                    }
                    c0 c0Var = new c0();
                    c0Var.c(b0.b(applicationExitInfoD));
                    c0Var.e(b0.h(applicationExitInfoD));
                    c0Var.g(h0.b(applicationExitInfoD));
                    c0Var.i(h0.c(applicationExitInfoD));
                    c0Var.d(b0.m(applicationExitInfoD));
                    c0Var.f(b0.c(applicationExitInfoD));
                    c0Var.h(b0.n(applicationExitInfoD));
                    c0Var.j(string);
                    d0 d0VarA = c0Var.a();
                    q qVar = (q) cVar5.a;
                    int i3 = qVar.a.getResources().getConfiguration().orientation;
                    o0 o0Var = new o0();
                    o0Var.g("anr");
                    long j = d0VarA.g;
                    o0Var.f(j);
                    if (qVar.e.m212b().b.c) {
                        w wVar = qVar.c;
                        if (wVar.a.size() > 0) {
                            ArrayList arrayList3 = new ArrayList();
                            for (Iterator it2 = wVar.a.iterator(); it2.hasNext(); it2 = it2) {
                                d dVar = (d) it2.next();
                                de.c cVar6 = new de.c(14, false);
                                cVar6.T(dVar.c());
                                cVar6.R(dVar.a());
                                cVar6.S(dVar.b());
                                arrayList3.add(cVar6.J());
                            }
                            listUnmodifiableList = DesugarCollections.unmodifiableList(arrayList3);
                        } else {
                            listUnmodifiableList = null;
                        }
                    } else {
                        listUnmodifiableList = null;
                    }
                    c0 c0Var2 = new c0();
                    c0Var2.c(d0VarA.d);
                    c0Var2.e(d0VarA.b);
                    c0Var2.g(d0VarA.c);
                    c0Var2.i(j);
                    c0Var2.d(d0VarA.a);
                    c0Var2.f(d0VarA.e);
                    c0Var2.h(d0VarA.f);
                    c0Var2.j(d0VarA.h);
                    c0Var2.b(listUnmodifiableList);
                    d0 d0VarA2 = c0Var2.a();
                    boolean z5 = d0VarA2.d != 100;
                    q0 q0Var = new q0();
                    q0Var.c(Boolean.valueOf(z5));
                    mf.f fVar2 = mf.f.a;
                    String str3 = d0VarA2.b;
                    Intrinsics.checkNotNullParameter(str3, "processName");
                    q0Var.d(mf.f.a(fVar2, str3, d0VarA2.a, d0VarA2.d, 8));
                    q0Var.h(i3);
                    as.c cVar7 = new as.c(12);
                    cVar7.m(d0VarA2);
                    x0 x0Var = new x0();
                    x0Var.d("0");
                    x0Var.c("0");
                    x0Var.b(0L);
                    cVar7.t(x0Var.a());
                    cVar7.n(qVar.a());
                    q0Var.f(cVar7.d());
                    o0Var.b(q0Var.a());
                    o0Var.c(qVar.b(i3));
                    aVar.d(c.b(c.a(o0Var.a(), fVar, cVar4, Collections.emptyMap()), cVar4), str2, true);
                }
            } else {
                arrayList = arrayList2;
            }
        } else {
            arrayList = arrayList2;
        }
        if (z2 && this.f600j.d(str2)) {
            mf.e eVarA = this.f600j.a(str2);
            File fileL = eVarA.l();
            u1 u1VarG = eVarA.g();
            if (fileL != null) {
                fileL.exists();
            }
            if (u1VarG == null) {
                Log.i("FirebaseCrashlytics", "No Tombstones data found for session " + str2, null);
            }
            if ((fileL != null && fileL.exists()) || u1VarG != null) {
                long jLastModified2 = fileL.lastModified();
                c cVar8 = this.f597g;
                rf.d nVar = f.c;
                if (str2 != null) {
                    nVar = new n(cVar8.g(str2, "userlog"));
                }
                File fileF = cVar8.f(str2);
                if (fileF.isDirectory()) {
                    m204d(jLastModified2);
                    ?? F = nVar.f();
                    File fileG2 = cVar8.g(str2, "user-data");
                    File fileG3 = cVar8.g(str2, "keys");
                    File fileG4 = cVar8.g(str2, "rollouts-state");
                    ArrayList arrayList4 = new ArrayList();
                    arrayList4.add(new pf.e("logs_file", "logs", (Serializable) F, 0));
                    arrayList4.add(new pf.e("crash_meta_file", "metadata", eVarA.o(), 1));
                    arrayList4.add(new pf.e("session_meta_file", "session", eVarA.E(), 1));
                    arrayList4.add(new pf.e("app_meta_file", "app", eVarA.r(), 1));
                    arrayList4.add(new pf.e("device_meta_file", "device", eVarA.c(), 1));
                    arrayList4.add(new pf.e("os_meta_file", "os", eVarA.s(), 1));
                    File fileL2 = eVarA.l();
                    arrayList4.add((fileL2 == null || !fileL2.exists()) ? new pf.e("minidump_file", "minidump", new byte[]{0}, 0) : new pf.e("minidump_file", "minidump", fileL2, 1));
                    arrayList4.add(new pf.e("user_meta_file", "user", fileG2, 1));
                    arrayList4.add(new pf.e("keys_file", "keys", fileG3, 1));
                    arrayList4.add(new pf.e("rollouts_file", "rollouts", fileG4, 1));
                    b4.a.K(fileF, arrayList4);
                    c cVar9 = this.f603m;
                    cVar9.getClass();
                    ArrayList arrayList5 = new ArrayList();
                    Iterator it3 = arrayList4.iterator();
                    while (it3.hasNext()) {
                        sf.h0 h0VarA = ((pf.e) it3.next()).a();
                        if (h0VarA != null) {
                            arrayList5.add(h0VarA);
                        }
                    }
                    k kVar = new k();
                    kVar.b(DesugarCollections.unmodifiableList(arrayList5));
                    g0 g0VarA = kVar.a();
                    vf.a aVar2 = (vf.a) cVar9.b;
                    c cVar10 = aVar2.b;
                    File fileG5 = cVar10.g(str2, "report");
                    fileG5.toString();
                    String strA = aVar2.d.a(str2);
                    try {
                        tf.a aVar3 = vf.a.g;
                        String strE = vf.a.e(fileG5);
                        aVar3.getClass();
                        a0 a0VarA = tf.a.i(strE).a();
                        a0VarA.j = null;
                        a0VarA.k = g0VarA;
                        sf.b0 b0VarA = a0VarA.a();
                        if (u1VarG != null) {
                            a0 a0VarA2 = b0VarA.a();
                            a0VarA2.l = u1VarG;
                            b0VarA = a0VarA2.a();
                        }
                        a0 a0VarA3 = b0VarA.a();
                        a0VarA3.g = strA;
                        j0 j0Var = b0VarA.k;
                        if (j0Var != null) {
                            i0 i0VarA = j0Var.a();
                            i0VarA.c = strA;
                            a0VarA3.j = i0VarA.a();
                        }
                        vf.a.f(new File((File) cVar10.g, str2), tf.a.a.j(a0VarA3.a()));
                    } catch (IOException unused3) {
                        Objects.toString(fileG5);
                    }
                    nVar.h();
                }
            }
        }
        if (z != 0) {
            z3 = false;
            str = (String) arrayList.get(0);
        } else {
            z3 = false;
            this.f602l.b((String) null);
            str = null;
        }
        c cVar11 = this.f603m;
        long jCurrentTimeMillis = System.currentTimeMillis() / 1000;
        vf.a aVar4 = (vf.a) cVar11.b;
        c cVar12 = aVar4.b;
        cVar12.d(".com.google.firebase.crashlytics");
        cVar12.d(".com.google.firebase.crashlytics-ndk");
        if (!((String) cVar12.a).isEmpty()) {
            cVar12.d(".com.google.firebase.crashlytics.files.v1");
            String str4 = ".com.google.firebase.crashlytics.files.v2" + File.pathSeparator;
            File file = (File) cVar12.b;
            if (file.exists() && (list = file.list(new b(str4))) != null) {
                int length = list.length;
                for (?? r9 = z3; r9 < length; r9++) {
                    cVar12.d(list[r9]);
                }
            }
        }
        NavigableSet<String> navigableSetC = aVar4.c();
        if (str != null) {
            navigableSetC.remove(str);
        }
        if (navigableSetC.size() > 8) {
            while (navigableSetC.size() > 8) {
                String str5 = (String) navigableSetC.last();
                c.k(new File((File) cVar12.d, str5));
                navigableSetC.remove(str5);
            }
        }
        for (String str6 : navigableSetC) {
            FilenameFilter filenameFilter = vf.a.i;
            File file2 = new File((File) cVar12.d, str6);
            file2.mkdirs();
            List listL2 = c.l(file2.listFiles(filenameFilter));
            if (!listL2.isEmpty()) {
                Collections.sort(listL2);
                ArrayList arrayList6 = new ArrayList();
                Iterator it4 = listL2.iterator();
                boolean z6 = z3;
                while (true) {
                    boolean zHasNext = it4.hasNext();
                    tf.a aVar5 = vf.a.g;
                    if (!zHasNext) {
                        if (!arrayList6.isEmpty()) {
                            String strD = new h(cVar12).d(str6);
                            String strA2 = aVar4.d.a(str6);
                            File fileG6 = cVar12.g(str6, "report");
                            try {
                                String strE2 = vf.a.e(fileG6);
                                aVar5.getClass();
                                sf.b0 b0VarB = tf.a.i(strE2).b(jCurrentTimeMillis, strD, z6);
                                a0 a0VarA4 = b0VarB.a();
                                a0VarA4.g = strA2;
                                j0 j0Var2 = b0VarB.k;
                                if (j0Var2 != null) {
                                    i0 i0VarA2 = j0Var2.a();
                                    i0VarA2.c = strA2;
                                    a0VarA4.j = i0VarA2.a();
                                }
                                sf.b0 b0VarA2 = a0VarA4.a();
                                j0 j0Var3 = b0VarA2.k;
                                if (j0Var3 == null) {
                                    throw new IllegalStateException("Reports without sessions cannot have events added to them.");
                                }
                                a0 a0VarA5 = b0VarA2.a();
                                i0 i0VarA3 = j0Var3.a();
                                i0VarA3.k = arrayList6;
                                a0VarA5.j = i0VarA3.a();
                                sf.b0 b0VarA3 = a0VarA5.a();
                                j0 j0Var4 = b0VarA3.k;
                                if (j0Var4 == null) {
                                    break;
                                }
                                vf.a.f(z6 ? new File((File) cVar12.f, j0Var4.b) : new File((File) cVar12.e, j0Var4.b), tf.a.a.j(b0VarA3));
                                break;
                            } catch (IOException unused4) {
                                Objects.toString(fileG6);
                                break;
                            }
                        }
                        break;
                    }
                    File file3 = (File) it4.next();
                    try {
                        String strE3 = vf.a.e(file3);
                        aVar5.getClass();
                        try {
                            JsonReader jsonReader = new JsonReader(new StringReader(strE3));
                            try {
                                p0 p0VarE = tf.a.e(jsonReader);
                                jsonReader.close();
                                arrayList6.add(p0VarE);
                                if (z6) {
                                    z4 = true;
                                } else {
                                    String name = file3.getName();
                                    if (name.startsWith("event") && name.endsWith("_")) {
                                        z4 = true;
                                    } else {
                                        z4 = z3;
                                    }
                                }
                                z6 = z4;
                            } catch (Throwable th3) {
                                try {
                                    jsonReader.close();
                                } catch (Throwable th4) {
                                    th3.addSuppressed(th4);
                                }
                                throw th3;
                            }
                        } catch (IllegalStateException e2) {
                            throw new IOException(e2);
                        }
                    } catch (IOException unused5) {
                        Objects.toString(file3);
                    }
                }
            }
            c.k(new File((File) cVar12.d, str6));
        }
        xf.a aVar6 = aVar4.c.m212b().a;
        ArrayList arrayListB = aVar4.b();
        int size2 = arrayListB.size();
        if (size2 <= 4) {
            return;
        }
        Iterator it5 = arrayListB.subList(4, size2).iterator();
        while (it5.hasNext()) {
            ((File) it5.next()).delete();
        }
    }

    /* JADX INFO: renamed from: c */
    public final void m203c(String str, Boolean bool) {
        Integer num;
        long jCurrentTimeMillis = System.currentTimeMillis() / 1000;
        Locale locale = Locale.US;
        x xVar = this.f596f;
        w wVar = this.f598h;
        q1 q1Var = new q1(xVar.c, (String) wVar.f, (String) wVar.g, xVar.c().a, DeliveryMechanism.determineFrom((String) wVar.d).getId(), (mf.d) wVar.h);
        String str2 = Build.VERSION.RELEASE;
        String str3 = Build.VERSION.CODENAME;
        s1 s1Var = new s1(str2, str3, g.h());
        Context context = this.f591a;
        StatFs statFs = new StatFs(Environment.getDataDirectory().getPath());
        long blockCount = ((long) statFs.getBlockCount()) * ((long) statFs.getBlockSize());
        int iOrdinal = CommonUtils$Architecture.getValue().ordinal();
        String str4 = Build.MODEL;
        int iAvailableProcessors = Runtime.getRuntime().availableProcessors();
        long jA = g.a(context);
        boolean zG = g.g();
        int iD = g.d();
        String str5 = Build.MANUFACTURER;
        String str6 = Build.PRODUCT;
        this.f600j.c(str, jCurrentTimeMillis, new p1(q1Var, s1Var, new r1(iOrdinal, str4, iAvailableProcessors, jA, blockCount, zG, iD, str5, str6)));
        if (bool.booleanValue() && str != null) {
            c cVar = this.f594d;
            synchronized (((String) cVar.a)) {
                cVar.a = str;
                ((C0054a) cVar.c).f611b.a(new ap.g(cVar, str, ((e) ((AtomicMarkableReference) ((b6.j) cVar.d).b).getReference()).a(), ((p) cVar.f).b(), 23));
            }
        }
        f fVar = this.f599i;
        fVar.b.a();
        fVar.b = f.c;
        if (str != null) {
            fVar.b = new n(fVar.a.g(str, "userlog"));
        }
        this.f602l.b(str);
        c cVar2 = this.f603m;
        q qVar = (q) cVar2.a;
        Charset charset = s2.a;
        a0 a0Var = new a0();
        a0Var.a = "19.4.0";
        w wVar2 = qVar.c;
        String str7 = (String) wVar2.b;
        if (str7 == null) {
            throw new NullPointerException("Null gmpAppId");
        }
        a0Var.b = str7;
        x xVar2 = qVar.b;
        String str8 = xVar2.c().a;
        if (str8 == null) {
            throw new NullPointerException("Null installationUuid");
        }
        a0Var.d = str8;
        a0Var.e = xVar2.c().b;
        a0Var.f = xVar2.c().c;
        String str9 = (String) wVar2.f;
        if (str9 == null) {
            throw new NullPointerException("Null buildVersion");
        }
        a0Var.h = str9;
        String str10 = (String) wVar2.g;
        if (str10 == null) {
            throw new NullPointerException("Null displayVersion");
        }
        a0Var.i = str10;
        a0Var.c = 4;
        a0Var.m = (byte) (a0Var.m | 1);
        i0 i0Var = new i0();
        i0Var.f = false;
        byte b = (byte) (i0Var.m | 2);
        i0Var.d = jCurrentTimeMillis;
        i0Var.m = (byte) (b | 1);
        if (str == null) {
            throw new NullPointerException("Null identifier");
        }
        i0Var.b = str;
        String str11 = q.g;
        if (str11 == null) {
            throw new NullPointerException("Null generator");
        }
        i0Var.a = str11;
        String str12 = xVar2.c;
        if (str12 == null) {
            throw new NullPointerException("Null identifier");
        }
        String str13 = xVar2.c().a;
        mf.d dVar = (mf.d) wVar2.h;
        i0Var.g = new k0(str12, str9, str10, str13, (String) dVar.a().a, (String) dVar.a().b);
        m1 m1Var = new m1();
        m1Var.a = 3;
        m1Var.e = (byte) (m1Var.e | 1);
        m1Var.b = str2;
        m1Var.c = str3;
        m1Var.d = g.h();
        m1Var.e = (byte) (m1Var.e | 2);
        i0Var.i = m1Var.a();
        StatFs statFs2 = new StatFs(Environment.getDataDirectory().getPath());
        String str14 = Build.CPU_ABI;
        int iIntValue = 7;
        if (!TextUtils.isEmpty(str14) && (num = (Integer) q.f.get(str14.toLowerCase(locale))) != null) {
            iIntValue = num.intValue();
        }
        int iAvailableProcessors2 = Runtime.getRuntime().availableProcessors();
        long jA2 = g.a(qVar.a);
        long blockCount2 = ((long) statFs2.getBlockCount()) * ((long) statFs2.getBlockSize());
        boolean zG2 = g.g();
        int iD2 = g.d();
        m0 m0Var = new m0();
        m0Var.a = iIntValue;
        byte b2 = (byte) (m0Var.j | 1);
        m0Var.b = str4;
        m0Var.c = iAvailableProcessors2;
        m0Var.d = jA2;
        m0Var.e = blockCount2;
        m0Var.f = zG2;
        m0Var.g = iD2;
        m0Var.j = (byte) (((byte) (((byte) (((byte) (((byte) (b2 | 2)) | 4)) | 8)) | 16)) | 32);
        m0Var.h = str5;
        m0Var.i = str6;
        i0Var.j = m0Var.a();
        i0Var.l = 3;
        i0Var.m = (byte) (i0Var.m | 4);
        a0Var.j = i0Var.a();
        sf.b0 b0VarA = a0Var.a();
        c cVar3 = ((vf.a) cVar2.b).b;
        j0 j0Var = b0VarA.k;
        if (j0Var == null) {
            return;
        }
        String str15 = j0Var.b;
        try {
            vf.a.g.getClass();
            vf.a.f(cVar3.g(str15, "report"), tf.a.a.j(b0VarA));
            File fileG = cVar3.g(str15, "start-time");
            long j = j0Var.d;
            OutputStreamWriter outputStreamWriter = new OutputStreamWriter(new FileOutputStream(fileG), vf.a.e);
            try {
                outputStreamWriter.write("");
                fileG.setLastModified(j * 1000);
                outputStreamWriter.close();
            } catch (Throwable th) {
                try {
                    outputStreamWriter.close();
                    throw th;
                } catch (Throwable th2) {
                    th.addSuppressed(th2);
                    throw th;
                }
            }
        } catch (IOException unused) {
        }
    }

    /* JADX INFO: renamed from: d */
    public final void m204d(long j) {
        try {
            c cVar = this.f597g;
            String str = ".ae" + j;
            cVar.getClass();
            if (new File((File) cVar.c, str).createNewFile()) {
            } else {
                throw new IOException("Create new file failed.");
            }
        } catch (IOException unused) {
        }
    }

    /* JADX INFO: renamed from: e */
    public final String m205e() {
        NavigableSet navigableSetC = ((vf.a) this.f603m.b).c();
        if (navigableSetC.isEmpty()) {
            return null;
        }
        return (String) navigableSetC.first();
    }

    /* JADX INFO: renamed from: f */
    public final void m206f() {
        InputStream resourceAsStream;
        String strEncodeToString;
        try {
            ClassLoader classLoader = C0053a.class.getClassLoader();
            if (classLoader != null) {
                resourceAsStream = classLoader.getResourceAsStream("META-INF/version-control-info.textproto");
                if (resourceAsStream == null) {
                    Log.i("FirebaseCrashlytics", "No version control information found", null);
                    resourceAsStream = null;
                }
            }
            resourceAsStream = null;
            if (resourceAsStream == null) {
                strEncodeToString = null;
            } else {
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                byte[] bArr = new byte[1024];
                while (true) {
                    int i = resourceAsStream.read(bArr);
                    if (i == -1) {
                        break;
                    } else {
                        byteArrayOutputStream.write(bArr, 0, i);
                    }
                }
                strEncodeToString = Base64.encodeToString(byteArrayOutputStream.toByteArray(), 0);
            }
            if (strEncodeToString != null) {
                try {
                    ((b6.j) this.f594d.e).h("com.crashlytics.version-control-info", strEncodeToString);
                } catch (IllegalArgumentException e) {
                    Context context = this.f591a;
                    if (context != null) {
                        if ((context.getApplicationInfo().flags & 2) != 0) {
                            throw e;
                        }
                    }
                    Log.e("FirebaseCrashlytics", "Attempting to set custom attribute with null key, ignoring.", null);
                }
                Log.i("FirebaseCrashlytics", "Saved version control info", null);
            }
        } catch (IOException unused) {
        }
    }

    /* JADX INFO: renamed from: g */
    public final void m207g(Task task) {
        Task task2;
        Task taskA;
        c cVar = ((vf.a) this.f603m.b).b;
        boolean zIsEmpty = c.l(((File) cVar.e).listFiles()).isEmpty();
        TaskCompletionSource taskCompletionSource = this.f605o;
        if (zIsEmpty && c.l(((File) cVar.f).listFiles()).isEmpty() && c.l(((File) cVar.g).listFiles()).isEmpty()) {
            taskCompletionSource.trySetResult(Boolean.FALSE);
            return;
        }
        s sVar = this.f592b;
        if (sVar.b()) {
            taskCompletionSource.trySetResult(Boolean.FALSE);
            taskA = Tasks.forResult(Boolean.TRUE);
        } else {
            taskCompletionSource.trySetResult(Boolean.TRUE);
            synchronized (sVar.c) {
                task2 = sVar.d.getTask();
            }
            taskA = qf.a.a(task2.onSuccessTask(new com.crazymaple.reelshort.novel.htmltext.f()), this.f606p.getTask());
        }
        taskA.onSuccessTask(this.f595e.f610a, new i(this, task));
    }
}
