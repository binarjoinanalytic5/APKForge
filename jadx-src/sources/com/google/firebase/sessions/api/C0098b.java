package com.google.firebase.sessions.api;

import j$.util.DesugarCollections;
import java.util.LinkedHashMap;
import java.util.Map;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.api.b */
/* JADX INFO: loaded from: classes.dex */
public final class C0098b {

    /* JADX INFO: renamed from: a */
    public static final C0098b f791a = new C0098b();

    /* JADX INFO: renamed from: b */
    public static final Map f792b = DesugarCollections.synchronizedMap(new LinkedHashMap());

    /* JADX INFO: renamed from: a */
    public static C0097a m323a(SessionSubscriber$Name sessionSubscriber$Name) {
        Map map = f792b;
        Intrinsics.checkNotNullExpressionValue(map, "dependencies");
        Object obj = map.get(sessionSubscriber$Name);
        if (obj != null) {
            Intrinsics.checkNotNullExpressionValue(obj, "dependencies.getOrElse(s…load time.\"\n      )\n    }");
            return (C0097a) obj;
        }
        throw new IllegalStateException("Cannot get dependency " + sessionSubscriber$Name + ". Dependencies should be added at class load time.");
    }

    /* JADX WARN: Code duplicated, block: B:17:0x0070  */
    /* JADX WARN: Code duplicated, block: B:19:0x009d A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:20:0x009e  */
    /* JADX WARN: Code duplicated, block: B:24:0x00ad  */
    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:20:0x009e -> B:21:0x009f). Please report as a decompilation issue!!! */
    /*  JADX ERROR: JadxOverflowException in pass: RegionMakerVisitor
        jadx.core.utils.exceptions.JadxOverflowException: Regions stack size limit reached
        	at jadx.core.utils.ErrorsCounter.addError(ErrorsCounter.java:59)
        	at jadx.core.utils.ErrorsCounter.error(ErrorsCounter.java:31)
        	at jadx.core.dex.attributes.nodes.NotificationAttrNode.addError(NotificationAttrNode.java:19)
        */
    /* JADX INFO: renamed from: b */
    public final java.lang.Object m324b(wakotl.coroutines.jvm.internal.ContinuationImpl r11) {
        /*
            Method dump skipped, instruction units count: 212
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.firebase.sessions.api.C0098b.m324b(wakotl.coroutines.jvm.internal.ContinuationImpl):java.lang.Object");
    }
}
