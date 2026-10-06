package com.google.firebase.sessions;

import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import com.google.android.gms.tasks.Task;
import com.google.firebase.installations.C0059a;
import wakotl.coroutines.jvm.internal.ContinuationImpl;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.n */
/* JADX INFO: loaded from: classes.dex */
public final class C0124n {
    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    /* JADX INFO: renamed from: a */
    public final Object m339a(lg.d dVar, ContinuationImpl continuationImpl) {
        InstallationId$Companion$create$1 installationId$Companion$create$1;
        lg.d dVar2;
        if (continuationImpl instanceof InstallationId$Companion$create$1) {
            installationId$Companion$create$1 = (InstallationId$Companion$create$1) continuationImpl;
            int i = installationId$Companion$create$1.label;
            if ((i & BasicMeasure.AT_MOST) != 0) {
                installationId$Companion$create$1.label = i - BasicMeasure.AT_MOST;
            } else {
                installationId$Companion$create$1 = new InstallationId$Companion$create$1(this, continuationImpl);
            }
        } else {
            installationId$Companion$create$1 = new InstallationId$Companion$create$1(this, continuationImpl);
        }
        Object objI = installationId$Companion$create$1.result;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i2 = installationId$Companion$create$1.label;
        String str = "";
        try {
            try {
                if (i2 != 0) {
                    if (i2 == 1) {
                        dVar = (lg.d) installationId$Companion$create$1.L$0;
                        wakotl.b.b(objI);
                    } else {
                        if (i2 != 2) {
                            throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
                        }
                        dVar = (String) installationId$Companion$create$1.L$0;
                        wakotl.b.b(objI);
                    }
                    Intrinsics.checkNotNullExpressionValue(objI, "{\n          firebaseInst…ions.id.await()\n        }");
                    str = (String) objI;
                    return new C0126o(str, dVar);
                }
                wakotl.b.b(objI);
                C0059a c0059a = (C0059a) dVar;
                Task taskM226e = c0059a.m226e();
                try {
                    Intrinsics.checkNotNullExpressionValue(taskM226e, "firebaseInstallations.getToken(false)");
                    installationId$Companion$create$1.L$0 = c0059a;
                    installationId$Companion$create$1.label = 1;
                    Object objI2 = k9.d.i(taskM226e, installationId$Companion$create$1);
                    if (objI2 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                    objI = objI2;
                    dVar = c0059a;
                } catch (Exception unused) {
                    dVar = c0059a;
                    dVar2 = dVar;
                    dVar = "";
                }
                lg.d dVar3 = ((lg.a) objI).a;
                Intrinsics.checkNotNullExpressionValue(dVar3, "{\n          firebaseInst…).await().token\n        }");
                dVar2 = dVar;
                dVar = dVar3;
            } catch (Exception unused2) {
            }
            Task taskM225d = ((C0059a) dVar2).m225d();
            Intrinsics.checkNotNullExpressionValue(taskM225d, "firebaseInstallations.id");
            installationId$Companion$create$1.L$0 = dVar;
            installationId$Companion$create$1.label = 2;
            objI = k9.d.i(taskM225d, installationId$Companion$create$1);
            if (objI == coroutine_suspended) {
                return coroutine_suspended;
            }
            Intrinsics.checkNotNullExpressionValue(objI, "{\n          firebaseInst…ions.id.await()\n        }");
            str = (String) objI;
        } catch (Exception unused3) {
        }
        return new C0126o(str, dVar);
    }
}
