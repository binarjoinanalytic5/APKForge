package com.google.firebase.installations;

import android.net.TrafficStats;
import android.text.TextUtils;
import android.util.Log;
import androidx.work.impl.model.e;
import androidx.work.impl.model.l;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.concurrent.ExecutorC0052b;
import com.google.firebase.installations.local.PersistedInstallation$RegistrationStatus;
import com.google.firebase.installations.remote.InstallationResponse$ResponseCode;
import com.google.firebase.installations.remote.TokenResult$ResponseCode;
import ef.h;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Pattern;
import jf.k;
import kg.b;
import lg.d;
import lg.f;
import lg.g;
import lg.i;
import ng.c;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: renamed from: com.google.firebase.installations.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0059a implements d {

    /* JADX INFO: renamed from: m */
    public static final Object f631m = new Object();

    /* JADX INFO: renamed from: a */
    public final h f632a;

    /* JADX INFO: renamed from: b */
    public final c f633b;

    /* JADX INFO: renamed from: c */
    public final e f634c;

    /* JADX INFO: renamed from: d */
    public final i f635d;

    /* JADX INFO: renamed from: e */
    public final k f636e;

    /* JADX INFO: renamed from: f */
    public final g f637f;

    /* JADX INFO: renamed from: g */
    public final Object f638g;

    /* JADX INFO: renamed from: h */
    public final ExecutorService f639h;

    /* JADX INFO: renamed from: i */
    public final ExecutorC0052b f640i;

    /* JADX INFO: renamed from: j */
    public String f641j;

    /* JADX INFO: renamed from: k */
    public final HashSet f642k;

    /* JADX INFO: renamed from: l */
    public final ArrayList f643l;

    static {
        new AtomicInteger(1);
    }

    public C0059a(h hVar, b bVar, ExecutorService executorService, ExecutorC0052b executorC0052b) {
        hVar.a();
        c cVar = new c(hVar.a, bVar);
        e eVar = new e(hVar);
        if (l3.c.b == null) {
            l3.c.b = new l3.c(7);
        }
        l3.c cVar2 = l3.c.b;
        if (i.d == null) {
            i.d = new i(cVar2);
        }
        i iVar = i.d;
        k kVar = new k(new jf.d(hVar, 2));
        g gVar = new g();
        this.f638g = new Object();
        this.f642k = new HashSet();
        this.f643l = new ArrayList();
        this.f632a = hVar;
        this.f633b = cVar;
        this.f634c = eVar;
        this.f635d = iVar;
        this.f636e = kVar;
        this.f637f = gVar;
        this.f639h = executorService;
        this.f640i = executorC0052b;
    }

    /* JADX INFO: renamed from: a */
    public final void m222a(lg.h hVar) {
        synchronized (this.f638g) {
            this.f643l.add(hVar);
        }
    }

    /* JADX INFO: renamed from: b */
    public final void m223b() {
        mg.a aVarS;
        synchronized (f631m) {
            try {
                h hVar = this.f632a;
                hVar.a();
                l lVarE = l.e(hVar.a);
                try {
                    aVarS = this.f634c.s();
                    PersistedInstallation$RegistrationStatus persistedInstallation$RegistrationStatus = PersistedInstallation$RegistrationStatus.NOT_GENERATED;
                    PersistedInstallation$RegistrationStatus persistedInstallation$RegistrationStatus2 = aVarS.b;
                    if (persistedInstallation$RegistrationStatus2 == persistedInstallation$RegistrationStatus || persistedInstallation$RegistrationStatus2 == PersistedInstallation$RegistrationStatus.ATTEMPT_MIGRATION) {
                        String strM229h = m229h(aVarS);
                        e eVar = this.f634c;
                        vf.c cVarA = aVarS.a();
                        cVarA.a = strM229h;
                        cVarA.n(PersistedInstallation$RegistrationStatus.UNREGISTERED);
                        aVarS = cVarA.c();
                        eVar.p(aVarS);
                    }
                    if (lVarE != null) {
                        lVarE.o();
                    }
                } catch (Throwable th) {
                    if (lVarE != null) {
                        lVarE.o();
                    }
                    throw th;
                }
            } catch (Throwable th2) {
                throw th2;
            }
        }
        m232k(aVarS);
        this.f640i.execute(new lg.b(this, 2));
    }

    /* JADX INFO: renamed from: c */
    public final mg.a m224c(mg.a aVar) throws FirebaseInstallationsException {
        HttpURLConnection httpURLConnectionC;
        ng.b bVarF;
        h hVar = this.f632a;
        hVar.a();
        String str = hVar.c.a;
        hVar.a();
        String str2 = hVar.c.g;
        String str3 = aVar.d;
        c cVar = this.f633b;
        ng.d dVar = cVar.c;
        if (!dVar.b()) {
            throw new FirebaseInstallationsException("Firebase Installations Service is unavailable. Please try again later.", FirebaseInstallationsException.Status.UNAVAILABLE);
        }
        URL urlA = c.a("projects/" + str2 + "/installations/" + aVar.a + "/authTokens:generate");
        int i = 0;
        while (true) {
            if (i > 1) {
                throw new FirebaseInstallationsException("Firebase Installations Service is unavailable. Please try again later.", FirebaseInstallationsException.Status.UNAVAILABLE);
            }
            TrafficStats.setThreadStatsTag(32771);
            httpURLConnectionC = cVar.c(urlA, str);
            try {
                try {
                    httpURLConnectionC.setRequestMethod("POST");
                    httpURLConnectionC.addRequestProperty("Authorization", "FIS_v2 " + str3);
                    httpURLConnectionC.setDoOutput(true);
                    c.h(httpURLConnectionC);
                    int responseCode = httpURLConnectionC.getResponseCode();
                    dVar.d(responseCode);
                    if (responseCode >= 200 && responseCode < 300) {
                        bVarF = c.f(httpURLConnectionC);
                        break;
                    }
                    c.b(httpURLConnectionC, (String) null, str, str2);
                    if (responseCode == 401 || responseCode == 404) {
                        com.facebook.applinks.b bVarA = ng.b.a();
                        bVarA.c = TokenResult$ResponseCode.AUTH_ERROR;
                        bVarF = bVarA.c();
                        break;
                    }
                    if (responseCode == 429) {
                        throw new FirebaseInstallationsException("Firebase servers have received too many requests from this client in a short period of time. Please try again later.", FirebaseInstallationsException.Status.TOO_MANY_REQUESTS);
                    }
                    if (responseCode < 500 || responseCode >= 600) {
                        Log.e("Firebase-Installations", "Firebase Installations can not communicate with Firebase server APIs due to invalid configuration. Please update your Firebase initialization process and set valid Firebase options (API key, Project ID, Application ID) when initializing Firebase.");
                        com.facebook.applinks.b bVarA2 = ng.b.a();
                        bVarA2.c = TokenResult$ResponseCode.BAD_CONFIG;
                        bVarF = bVarA2.c();
                        break;
                    }
                    httpURLConnectionC.disconnect();
                    TrafficStats.clearThreadStatsTag();
                    i++;
                } catch (Throwable th) {
                    httpURLConnectionC.disconnect();
                    TrafficStats.clearThreadStatsTag();
                    throw th;
                }
            } catch (IOException | AssertionError unused) {
            }
        }
        httpURLConnectionC.disconnect();
        TrafficStats.clearThreadStatsTag();
        int i2 = lg.c.b[bVarF.c.ordinal()];
        if (i2 == 1) {
            i iVar = this.f635d;
            iVar.getClass();
            TimeUnit timeUnit = TimeUnit.MILLISECONDS;
            iVar.a.getClass();
            long seconds = timeUnit.toSeconds(System.currentTimeMillis());
            vf.c cVarA = aVar.a();
            cVarA.c = bVarF.a;
            cVarA.e = Long.valueOf(bVarF.b);
            cVarA.f = Long.valueOf(seconds);
            return cVarA.c();
        }
        if (i2 == 2) {
            vf.c cVarA2 = aVar.a();
            cVarA2.g = "BAD CONFIG";
            cVarA2.n(PersistedInstallation$RegistrationStatus.REGISTER_ERROR);
            return cVarA2.c();
        }
        if (i2 != 3) {
            throw new FirebaseInstallationsException("Firebase Installations Service is unavailable. Please try again later.", FirebaseInstallationsException.Status.UNAVAILABLE);
        }
        m233l(null);
        vf.c cVarA3 = aVar.a();
        cVarA3.n(PersistedInstallation$RegistrationStatus.NOT_GENERATED);
        return cVarA3.c();
    }

    /* JADX INFO: renamed from: d */
    public final Task m225d() {
        String str;
        m228g();
        synchronized (this) {
            str = this.f641j;
        }
        if (str != null) {
            return Tasks.forResult(str);
        }
        TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        m222a(new f(taskCompletionSource));
        Task task = taskCompletionSource.getTask();
        this.f639h.execute(new lg.b(this, 0));
        return task;
    }

    /* JADX INFO: renamed from: e */
    public final Task m226e() {
        m228g();
        TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        m222a(new lg.e(this.f635d, taskCompletionSource));
        Task task = taskCompletionSource.getTask();
        this.f639h.execute(new lg.b(this, 1));
        return task;
    }

    /* JADX INFO: renamed from: f */
    public final void m227f(mg.a aVar) {
        synchronized (f631m) {
            try {
                h hVar = this.f632a;
                hVar.a();
                l lVarE = l.e(hVar.a);
                try {
                    this.f634c.p(aVar);
                    if (lVarE != null) {
                        lVarE.o();
                    }
                } catch (Throwable th) {
                    if (lVarE != null) {
                        lVarE.o();
                    }
                    throw th;
                }
            } catch (Throwable th2) {
                throw th2;
            }
        }
    }

    /* JADX INFO: renamed from: g */
    public final void m228g() {
        h hVar = this.f632a;
        hVar.a();
        Preconditions.checkNotEmpty(hVar.c.b, "Please set your Application ID. A valid Firebase App ID is required to communicate with Firebase server APIs: It identifies your application with Firebase.Please refer to https://firebase.google.com/support/privacy/init-options.");
        hVar.a();
        Preconditions.checkNotEmpty(hVar.c.g, "Please set your Project ID. A valid Firebase Project ID is required to communicate with Firebase server APIs: It identifies your application with Firebase.Please refer to https://firebase.google.com/support/privacy/init-options.");
        hVar.a();
        Preconditions.checkNotEmpty(hVar.c.a, "Please set a valid API key. A Firebase API key is required to communicate with Firebase server APIs: It authenticates your project with Google.Please refer to https://firebase.google.com/support/privacy/init-options.");
        hVar.a();
        String str = hVar.c.b;
        Pattern pattern = i.c;
        Preconditions.checkArgument(str.contains(":"), "Please set your Application ID. A valid Firebase App ID is required to communicate with Firebase server APIs: It identifies your application with Firebase.Please refer to https://firebase.google.com/support/privacy/init-options.");
        hVar.a();
        Preconditions.checkArgument(i.c.matcher(hVar.c.a).matches(), "Please set a valid API key. A Firebase API key is required to communicate with Firebase server APIs: It authenticates your project with Google.Please refer to https://firebase.google.com/support/privacy/init-options.");
    }

    /* JADX WARN: Code duplicated, block: B:12:0x0035 A[Catch: all -> 0x0037, DONT_GENERATE, TryCatch #0 {all -> 0x0037, blocks: (B:10:0x002f, B:12:0x0035, B:16:0x0039, B:17:0x003d), top: B:26:0x002f }] */
    /* JADX WARN: Code duplicated, block: B:16:0x0039 A[Catch: all -> 0x0037, TryCatch #0 {all -> 0x0037, blocks: (B:10:0x002f, B:12:0x0035, B:16:0x0039, B:17:0x003d), top: B:26:0x002f }] */
    /* JADX WARN: Code duplicated, block: B:20:0x0044  */
    /* JADX WARN: Code duplicated, block: B:26:0x002f A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:27:? A[RETURN, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:6:0x001e  */
    /* JADX WARN: Code duplicated, block: B:8:0x0024  */
    /* JADX INFO: renamed from: h */
    public final String m229h(mg.a aVar) {
        mg.b bVar;
        String strA;
        h hVar = this.f632a;
        hVar.a();
        if (hVar.b.equals("CHIME_ANDROID_SDK")) {
            if (aVar.b == PersistedInstallation$RegistrationStatus.ATTEMPT_MIGRATION) {
                bVar = (mg.b) this.f636e.get();
                synchronized (bVar.a) {
                    strA = bVar.a();
                    if (strA != null) {
                        strA = bVar.b();
                    }
                    if (TextUtils.isEmpty(strA)) {
                        return strA;
                    }
                    this.f637f.getClass();
                    return g.a();
                }
            }
        } else {
            h hVar2 = this.f632a;
            hVar2.a();
            if ("[DEFAULT]".equals(hVar2.b)) {
                if (aVar.b == PersistedInstallation$RegistrationStatus.ATTEMPT_MIGRATION) {
                    bVar = (mg.b) this.f636e.get();
                    synchronized (bVar.a) {
                        try {
                            strA = bVar.a();
                            if (strA != null) {
                                strA = bVar.b();
                            }
                        } catch (Throwable th) {
                            throw th;
                        }
                    }
                    if (TextUtils.isEmpty(strA)) {
                        return strA;
                    }
                    this.f637f.getClass();
                    return g.a();
                }
            }
        }
        this.f637f.getClass();
        return g.a();
    }

    /* JADX INFO: renamed from: i */
    public final mg.a m230i(mg.a aVar) throws FirebaseInstallationsException {
        ng.a aVarE;
        String str = aVar.a;
        String string = null;
        if (str != null && str.length() == 11) {
            mg.b bVar = (mg.b) this.f636e.get();
            synchronized (bVar.a) {
                try {
                    String[] strArr = mg.b.c;
                    int i = 0;
                    while (true) {
                        if (i >= 4) {
                            break;
                        }
                        String str2 = strArr[i];
                        String string2 = bVar.a.getString("|T|" + bVar.b + "|" + str2, null);
                        if (string2 != null && !string2.isEmpty()) {
                            if (string2.startsWith("{")) {
                                try {
                                    string = new JSONObject(string2).getString("token");
                                } catch (JSONException unused) {
                                }
                            } else {
                                string = string2;
                            }
                            break;
                        }
                        i++;
                    }
                } catch (Throwable th) {
                    throw th;
                }
            }
        }
        c cVar = this.f633b;
        h hVar = this.f632a;
        hVar.a();
        String str3 = hVar.c.a;
        String str4 = aVar.a;
        h hVar2 = this.f632a;
        hVar2.a();
        String str5 = hVar2.c.g;
        h hVar3 = this.f632a;
        hVar3.a();
        String str6 = hVar3.c.b;
        ng.d dVar = cVar.c;
        if (!dVar.b()) {
            throw new FirebaseInstallationsException("Firebase Installations Service is unavailable. Please try again later.", FirebaseInstallationsException.Status.UNAVAILABLE);
        }
        URL urlA = c.a("projects/" + str5 + "/installations");
        int i2 = 0;
        while (true) {
            if (i2 > 1) {
                throw new FirebaseInstallationsException("Firebase Installations Service is unavailable. Please try again later.", FirebaseInstallationsException.Status.UNAVAILABLE);
            }
            TrafficStats.setThreadStatsTag(32769);
            HttpURLConnection httpURLConnectionC = cVar.c(urlA, str3);
            try {
                try {
                    httpURLConnectionC.setRequestMethod("POST");
                    httpURLConnectionC.setDoOutput(true);
                    if (string != null) {
                        httpURLConnectionC.addRequestProperty("x-goog-fis-android-iid-migration-auth", string);
                    }
                    c.g(httpURLConnectionC, str4, str6);
                    int responseCode = httpURLConnectionC.getResponseCode();
                    dVar.d(responseCode);
                    if (responseCode >= 200 && responseCode < 300) {
                        aVarE = c.e(httpURLConnectionC);
                        httpURLConnectionC.disconnect();
                        TrafficStats.clearThreadStatsTag();
                        break;
                    }
                    c.b(httpURLConnectionC, str6, str3, str5);
                    if (responseCode == 429) {
                        throw new FirebaseInstallationsException("Firebase servers have received too many requests from this client in a short period of time. Please try again later.", FirebaseInstallationsException.Status.TOO_MANY_REQUESTS);
                    }
                    if (responseCode < 500 || responseCode >= 600) {
                        Log.e("Firebase-Installations", "Firebase Installations can not communicate with Firebase server APIs due to invalid configuration. Please update your Firebase initialization process and set valid Firebase options (API key, Project ID, Application ID) when initializing Firebase.");
                        ng.a aVar2 = new ng.a((String) null, (String) null, (String) null, (ng.b) null, InstallationResponse$ResponseCode.BAD_CONFIG);
                        httpURLConnectionC.disconnect();
                        TrafficStats.clearThreadStatsTag();
                        aVarE = aVar2;
                        break;
                    }
                    httpURLConnectionC.disconnect();
                    TrafficStats.clearThreadStatsTag();
                    i2++;
                } catch (Throwable th2) {
                    httpURLConnectionC.disconnect();
                    TrafficStats.clearThreadStatsTag();
                    throw th2;
                }
            } catch (IOException | AssertionError unused2) {
            }
        }
        int i3 = lg.c.a[aVarE.e.ordinal()];
        if (i3 != 1) {
            if (i3 != 2) {
                throw new FirebaseInstallationsException("Firebase Installations Service is unavailable. Please try again later.", FirebaseInstallationsException.Status.UNAVAILABLE);
            }
            vf.c cVarA = aVar.a();
            cVarA.g = "BAD CONFIG";
            cVarA.n(PersistedInstallation$RegistrationStatus.REGISTER_ERROR);
            return cVarA.c();
        }
        String str7 = aVarE.b;
        String str8 = aVarE.c;
        i iVar = this.f635d;
        iVar.getClass();
        TimeUnit timeUnit = TimeUnit.MILLISECONDS;
        iVar.a.getClass();
        long seconds = timeUnit.toSeconds(System.currentTimeMillis());
        ng.b bVar2 = aVarE.d;
        String str9 = bVar2.a;
        long j = bVar2.b;
        vf.c cVarA2 = aVar.a();
        cVarA2.a = str7;
        cVarA2.n(PersistedInstallation$RegistrationStatus.REGISTERED);
        cVarA2.c = str9;
        cVarA2.d = str8;
        cVarA2.e = Long.valueOf(j);
        cVarA2.f = Long.valueOf(seconds);
        return cVarA2.c();
    }

    /* JADX INFO: renamed from: j */
    public final void m231j(Exception exc) {
        synchronized (this.f638g) {
            try {
                Iterator it = this.f643l.iterator();
                while (it.hasNext()) {
                    if (((lg.h) it.next()).a(exc)) {
                        it.remove();
                    }
                }
            } catch (Throwable th) {
                throw th;
            }
        }
    }

    /* JADX INFO: renamed from: k */
    public final void m232k(mg.a aVar) {
        synchronized (this.f638g) {
            try {
                Iterator it = this.f643l.iterator();
                while (it.hasNext()) {
                    if (((lg.h) it.next()).b(aVar)) {
                        it.remove();
                    }
                }
            } catch (Throwable th) {
                throw th;
            }
        }
    }

    /* JADX INFO: renamed from: l */
    public final synchronized void m233l(String str) {
        this.f641j = str;
    }

    /* JADX INFO: renamed from: m */
    public final synchronized void m234m(mg.a aVar, mg.a aVar2) {
        try {
            if (this.f642k.size() != 0 && !TextUtils.equals(aVar.a, aVar2.a)) {
                Iterator it = this.f642k.iterator();
                if (it.hasNext()) {
                    if (it.next() != null) {
                        throw new ClassCastException();
                    }
                    throw null;
                }
            }
        } catch (Throwable th) {
            throw th;
        }
    }
}
