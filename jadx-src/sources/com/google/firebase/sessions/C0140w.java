package com.google.firebase.sessions;

import kotlinx.coroutines.flow.m1;
import wakotl.Unit;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.SuspendLambda;
import wakotl.jvm.functions.Function2;
import wakotl.jvm.internal.Ref;

/* JADX INFO: renamed from: com.google.firebase.sessions.w */
/* JADX INFO: loaded from: classes.dex */
public final class C0140w implements kotlinx.coroutines.flow.i {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ int f912a;

    /* JADX INFO: renamed from: b */
    public final /* synthetic */ kotlinx.coroutines.flow.i f913b;

    /* JADX INFO: renamed from: c */
    public final /* synthetic */ Object f914c;

    public /* synthetic */ C0140w(kotlinx.coroutines.flow.i iVar, Object obj, int i) {
        this.f912a = i;
        this.f913b = iVar;
        this.f914c = obj;
    }

    /* JADX WARN: Type inference failed for: r1v3, types: [java.lang.Object, wakotl.jvm.functions.Function2] */
    public final Object collect(kotlinx.coroutines.flow.j jVar, Continuation continuation) {
        switch (this.f912a) {
            case 0:
                Object objCollect = this.f913b.collect(new C0139v(jVar, (C0141x) this.f914c), continuation);
                return objCollect == wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED() ? objCollect : Unit.a;
            case 1:
                Object objCollect2 = this.f913b.collect(new kotlinx.coroutines.flow.h0(new Ref.BooleanRef(), jVar, (SuspendLambda) this.f914c), continuation);
                return objCollect2 == wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED() ? objCollect2 : Unit.a;
            default:
                Object objCollect3 = this.f913b.collect(new m1((Function2) this.f914c, jVar), continuation);
                return objCollect3 == wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED() ? objCollect3 : Unit.a;
        }
    }

    public C0140w(Function2 function2, kotlinx.coroutines.flow.i iVar) {
        this.f912a = 1;
        this.f913b = iVar;
        this.f914c = (SuspendLambda) function2;
    }
}
