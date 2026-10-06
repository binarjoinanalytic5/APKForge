package com.google.firebase.messaging;

import android.content.SharedPreferences;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;
import com.google.android.exoplayer2.a2;
import com.google.firebase.components.DependencyException;
import j$.util.DesugarCollections;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.ArrayDeque;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Executor;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import wakotl.collections.EmptyList;
import wakotl.jvm.internal.Intrinsics;
import wakotl.reflect.KClass;

/* JADX INFO: renamed from: com.google.firebase.messaging.v */
/* JADX INFO: loaded from: classes.dex */
public final class C0089v implements jf.c, jb.b {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ int f753a;

    /* JADX INFO: renamed from: b */
    public final Object f754b;

    /* JADX INFO: renamed from: c */
    public final Object f755c;

    /* JADX INFO: renamed from: d */
    public final Object f756d;

    /* JADX INFO: renamed from: e */
    public final Object f757e;

    /* JADX INFO: renamed from: f */
    public final Object f758f;

    public /* synthetic */ C0089v(Object obj, Object obj2, Object obj3, Object obj4, Object obj5, int i) {
        this.f753a = i;
        this.f754b = obj;
        this.f755c = obj2;
        this.f756d = obj3;
        this.f757e = obj4;
        this.f758f = obj5;
    }

    /* JADX INFO: renamed from: h */
    public static C0089v m295h(SharedPreferences sharedPreferences, ScheduledThreadPoolExecutor scheduledThreadPoolExecutor) {
        C0089v c0089v = new C0089v(sharedPreferences, scheduledThreadPoolExecutor);
        synchronized (((ArrayDeque) c0089v.f757e)) {
            try {
                ((ArrayDeque) c0089v.f757e).clear();
                String string = ((SharedPreferences) c0089v.f754b).getString((String) c0089v.f755c, "");
                if (!TextUtils.isEmpty(string) && string.contains((String) c0089v.f756d)) {
                    String[] strArrSplit = string.split((String) c0089v.f756d, -1);
                    if (strArrSplit.length == 0) {
                        Log.e("FirebaseMessaging", "Corrupted queue. Please check the queue contents and item separator provided");
                    }
                    for (String str : strArrSplit) {
                        if (!TextUtils.isEmpty(str)) {
                            ((ArrayDeque) c0089v.f757e).add(str);
                        }
                    }
                }
            } catch (Throwable th) {
                throw th;
            }
        }
        return c0089v;
    }

    /* JADX INFO: renamed from: j */
    public static void m296j(C0089v c0089v, KClass kClass) {
        c0089v.m304i(kClass, EmptyList.INSTANCE);
    }

    /* JADX INFO: renamed from: a */
    public Object m297a(Class cls) {
        if (!((Set) this.f754b).contains(jf.o.a(cls))) {
            throw new DependencyException("Attempting to request an undeclared dependency " + cls + ".");
        }
        Object objA = ((jf.c) this.f758f).a(cls);
        if (!cls.equals(hg.b.class)) {
            return objA;
        }
        return new jf.p();
    }

    /* JADX INFO: renamed from: b */
    public kg.b m298b(jf.o oVar) {
        if (((Set) this.f755c).contains(oVar)) {
            return ((jf.c) this.f758f).b(oVar);
        }
        throw new DependencyException("Attempting to request an undeclared dependency Provider<" + oVar + ">.");
    }

    /* JADX INFO: renamed from: c */
    public Object m299c(jf.o oVar) {
        if (((Set) this.f754b).contains(oVar)) {
            return ((jf.c) this.f758f).c(oVar);
        }
        throw new DependencyException("Attempting to request an undeclared dependency " + oVar + ".");
    }

    /* JADX INFO: renamed from: d */
    public Set m300d(jf.o oVar) {
        if (((Set) this.f757e).contains(oVar)) {
            return ((jf.c) this.f758f).d(oVar);
        }
        throw new DependencyException("Attempting to request an undeclared dependency Set<" + oVar + ">.");
    }

    /* JADX INFO: renamed from: e */
    public kg.b m301e(Class cls) {
        return m298b(jf.o.a(cls));
    }

    /* JADX INFO: renamed from: f */
    public jf.m m302f(jf.o oVar) {
        if (((Set) this.f756d).contains(oVar)) {
            return ((jf.c) this.f758f).f(oVar);
        }
        throw new DependencyException("Attempting to request an undeclared dependency Deferred<" + oVar + ">.");
    }

    /* JADX INFO: renamed from: g */
    public byte[] m303g(String str) throws BadPaddingException, NoSuchPaddingException, InvalidKeySpecException, IllegalBlockSizeException, NoSuchAlgorithmException, InvalidKeyException {
        Intrinsics.checkNotNullParameter(str, "rsaPublicKey");
        SecretKeySpec secretKeySpec = (SecretKeySpec) this.f757e;
        byte[] encoded = secretKeySpec.getEncoded();
        Intrinsics.checkNotNullExpressionValue(encoded, "getEncoded(...)");
        Intrinsics.checkNotNullParameter(encoded, "input");
        Intrinsics.checkNotNullParameter(str, "publicKey");
        Cipher cipher = Cipher.getInstance((String) ((op.i) this.f755c).getValue());
        PublicKey publicKeyGeneratePublic = KeyFactory.getInstance((String) ((op.i) this.f754b).getValue()).generatePublic(new X509EncodedKeySpec(Base64.decode(str, 0)));
        Intrinsics.checkNotNullExpressionValue(publicKeyGeneratePublic, "generatePublic(...)");
        cipher.init(1, publicKeyGeneratePublic);
        byte[] bArrDoFinal = cipher.doFinal(secretKeySpec.getEncoded());
        Intrinsics.checkNotNullExpressionValue(bArrDoFinal, "doFinal(...)");
        return bArrDoFinal;
    }

    public Object get() {
        return new nb.a((Executor) ((np.a) this.f754b).get(), (ib.g) ((np.a) this.f755c).get(), (ob.c) ((androidx.work.impl.model.v) this.f756d).get(), (pb.d) ((np.a) this.f757e).get(), (qb.b) ((np.a) this.f758f).get());
    }

    /* JADX INFO: renamed from: i */
    public void m304i(KClass kClass, List list) {
        Intrinsics.checkNotNullParameter(kClass, "kClass");
        Intrinsics.checkNotNullParameter(list, "typeArgumentsSerializers");
        an.q.z(((Map) this.f754b).get(kClass));
    }

    /* JADX INFO: renamed from: k */
    public jf.m m305k(Class cls) {
        return m302f(jf.o.a(cls));
    }

    /* JADX INFO: renamed from: l */
    public String m306l() {
        String str;
        synchronized (((ArrayDeque) this.f757e)) {
            str = (String) ((ArrayDeque) this.f757e).peek();
        }
        return str;
    }

    /* JADX INFO: renamed from: m */
    public boolean m307m(Object obj) {
        boolean zRemove;
        synchronized (((ArrayDeque) this.f757e)) {
            zRemove = ((ArrayDeque) this.f757e).remove(obj);
            if (zRemove) {
                ((ScheduledThreadPoolExecutor) this.f758f).execute(new a2(this, 8));
            }
        }
        return zRemove;
    }

    /* JADX INFO: renamed from: n */
    public void m308n(eb.a aVar, eb.g gVar) {
        hb.i iVar = (hb.i) this.f754b;
        String str = (String) this.f755c;
        eb.e eVar = (eb.e) this.f757e;
        if (eVar == null) {
            throw new NullPointerException("Null transformer");
        }
        eb.c cVar = (eb.c) this.f756d;
        hb.q qVar = (hb.q) this.f758f;
        hb.i iVarB = iVar.b(aVar.b);
        b6.i iVar2 = new b6.i();
        iVar2.f = new HashMap();
        iVar2.d = Long.valueOf(qVar.a.p());
        iVar2.e = Long.valueOf(qVar.b.p());
        iVar2.a = str;
        iVar2.c = new hb.l(cVar, (byte[]) eVar.apply(aVar.a));
        iVar2.b = null;
        eb.b bVar = aVar.c;
        if (bVar != null && bVar.a() != null) {
            iVar2.g = bVar.a();
        }
        hb.h hVarB = iVar2.b();
        nb.a aVar2 = qVar.c;
        aVar2.getClass();
        aVar2.b.execute(new androidx.work.impl.j(aVar2, iVarB, gVar, hVarB, 4));
    }

    /* JADX INFO: renamed from: o */
    public Set m309o(Class cls) {
        return m300d(jf.o.a(cls));
    }

    public String toString() {
        switch (this.f753a) {
            case 7:
                StringBuilder sb = new StringBuilder();
                sb.append("FontRequest {mProviderAuthority: " + ((String) this.f755c) + ", mProviderPackage: " + ((String) this.f756d) + ", mQuery: " + ((String) this.f754b) + ", mCertificates:");
                int i = 0;
                while (true) {
                    List list = (List) this.f757e;
                    if (i >= list.size()) {
                        sb.append("}mCertificatesArray: 0");
                        return sb.toString();
                    }
                    sb.append(" [");
                    List list2 = (List) list.get(i);
                    for (int i2 = 0; i2 < list2.size(); i2++) {
                        sb.append(" \"");
                        sb.append(Base64.encodeToString((byte[]) list2.get(i2), 0));
                        sb.append("\"");
                    }
                    sb.append(" ]");
                    i++;
                }
                break;
            default:
                return super.toString();
        }
    }

    public C0089v() throws NoSuchAlgorithmException {
        this.f753a = 1;
        this.f754b = wakotl.a.b(new am.a(11));
        this.f755c = wakotl.a.b(new am.a(12));
        op.i iVarB = wakotl.a.b(new am.a(13));
        this.f756d = wakotl.a.b(new am.a(14));
        KeyGenerator keyGenerator = KeyGenerator.getInstance((String) iVarB.getValue());
        keyGenerator.init(256);
        this.f757e = new SecretKeySpec(keyGenerator.generateKey().getEncoded(), (String) iVarB.getValue());
        this.f758f = wakotl.a.b(new am.a(15));
    }

    public C0089v(Map map, Map map2, Map map3, Map map4, Map map5) {
        this.f753a = 2;
        Intrinsics.checkNotNullParameter(map, "class2ContextualFactory");
        Intrinsics.checkNotNullParameter(map2, "polyBase2Serializers");
        Intrinsics.checkNotNullParameter(map3, "polyBase2DefaultSerializerProvider");
        Intrinsics.checkNotNullParameter(map4, "polyBase2NamedSerializers");
        Intrinsics.checkNotNullParameter(map5, "polyBase2DefaultDeserializerProvider");
        this.f754b = map;
        this.f755c = map2;
        this.f756d = map3;
        this.f757e = map4;
        this.f758f = map5;
    }

    public C0089v(jf.b bVar, jf.c cVar) {
        this.f753a = 4;
        HashSet hashSet = new HashSet();
        HashSet hashSet2 = new HashSet();
        HashSet hashSet3 = new HashSet();
        HashSet hashSet4 = new HashSet();
        HashSet hashSet5 = new HashSet();
        for (jf.i iVar : bVar.c) {
            int i = iVar.c;
            boolean z = i == 0;
            int i2 = iVar.b;
            jf.o oVar = iVar.a;
            if (z) {
                if (i2 == 2) {
                    hashSet4.add(oVar);
                } else {
                    hashSet.add(oVar);
                }
            } else if (i == 2) {
                hashSet3.add(oVar);
            } else if (i2 == 2) {
                hashSet5.add(oVar);
            } else {
                hashSet2.add(oVar);
            }
        }
        if (!bVar.g.isEmpty()) {
            hashSet.add(jf.o.a(hg.b.class));
        }
        this.f754b = DesugarCollections.unmodifiableSet(hashSet);
        this.f755c = DesugarCollections.unmodifiableSet(hashSet2);
        this.f756d = DesugarCollections.unmodifiableSet(hashSet3);
        this.f757e = DesugarCollections.unmodifiableSet(hashSet4);
        DesugarCollections.unmodifiableSet(hashSet5);
        this.f758f = cVar;
    }

    public C0089v(String str, String str2, String str3, List list) {
        this.f753a = 7;
        str.getClass();
        this.f755c = str;
        str2.getClass();
        this.f756d = str2;
        this.f754b = str3;
        list.getClass();
        this.f757e = list;
        this.f758f = str + "-" + str2 + "-" + str3;
    }

    public C0089v(SharedPreferences sharedPreferences, ScheduledThreadPoolExecutor scheduledThreadPoolExecutor) {
        this.f753a = 0;
        this.f757e = new ArrayDeque();
        this.f754b = sharedPreferences;
        this.f755c = "topic_operation_queue";
        this.f756d = ",";
        this.f758f = scheduledThreadPoolExecutor;
    }
}
