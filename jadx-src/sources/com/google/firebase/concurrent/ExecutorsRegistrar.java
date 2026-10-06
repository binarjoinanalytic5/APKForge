package com.google.firebase.concurrent;

import android.annotation.SuppressLint;
import com.google.firebase.components.ComponentRegistrar;
import com.google.firebase.messaging.C0077j;
import ef.i;
import if.c;
import if.d;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.ScheduledExecutorService;
import jf.k;
import jf.o;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"ThreadPoolCreation"})
public class ExecutorsRegistrar implements ComponentRegistrar {

    /* JADX INFO: renamed from: a */
    public static final k f569a = new k(new C0077j(3));

    /* JADX INFO: renamed from: b */
    public static final k f570b = new k(new C0077j(4));

    /* JADX INFO: renamed from: c */
    public static final k f571c = new k(new C0077j(5));

    /* JADX INFO: renamed from: d */
    public static final k f572d = new k(new C0077j(6));

    @Override // com.google.firebase.components.ComponentRegistrar
    public final List getComponents() {
        o oVar = new o(if.a.class, ScheduledExecutorService.class);
        o[] oVarArr = {new o(if.a.class, ExecutorService.class), new o(if.a.class, Executor.class)};
        HashSet hashSet = new HashSet();
        HashSet hashSet2 = new HashSet();
        HashSet hashSet3 = new HashSet();
        hashSet.add(oVar);
        for (o oVar2 : oVarArr) {
            ef.b.m(oVar2, "Null interface");
        }
        Collections.addAll(hashSet, oVarArr);
        jf.b bVar = new jf.b((String) null, new HashSet(hashSet), new HashSet(hashSet2), 0, 0, new i(4), hashSet3);
        o oVar3 = new o(if.b.class, ScheduledExecutorService.class);
        o[] oVarArr2 = {new o(if.b.class, ExecutorService.class), new o(if.b.class, Executor.class)};
        HashSet hashSet4 = new HashSet();
        HashSet hashSet5 = new HashSet();
        HashSet hashSet6 = new HashSet();
        hashSet4.add(oVar3);
        for (o oVar4 : oVarArr2) {
            ef.b.m(oVar4, "Null interface");
        }
        Collections.addAll(hashSet4, oVarArr2);
        jf.b bVar2 = new jf.b((String) null, new HashSet(hashSet4), new HashSet(hashSet5), 0, 0, new i(5), hashSet6);
        o oVar5 = new o(c.class, ScheduledExecutorService.class);
        o[] oVarArr3 = {new o(c.class, ExecutorService.class), new o(c.class, Executor.class)};
        HashSet hashSet7 = new HashSet();
        HashSet hashSet8 = new HashSet();
        HashSet hashSet9 = new HashSet();
        hashSet7.add(oVar5);
        for (o oVar6 : oVarArr3) {
            ef.b.m(oVar6, "Null interface");
        }
        Collections.addAll(hashSet7, oVarArr3);
        jf.b bVar3 = new jf.b((String) null, new HashSet(hashSet7), new HashSet(hashSet8), 0, 0, new i(6), hashSet9);
        jf.a aVarB = jf.b.b(new o(d.class, Executor.class));
        aVarB.f = new i(7);
        return Arrays.asList(bVar, bVar2, bVar3, aVarB.b());
    }
}
