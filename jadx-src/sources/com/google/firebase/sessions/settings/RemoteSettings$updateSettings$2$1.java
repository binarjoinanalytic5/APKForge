package com.google.firebase.sessions.settings;

import android.util.Log;
import androidx.constraintlayout.solver.widgets.Optimizer;
import androidx.constraintlayout.widget.ConstraintLayout;
import j$.util.Objects;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import org.json.JSONException;
import org.json.JSONObject;
import wakotl.Metadata;
import wakotl.Unit;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.Boxing;
import wakotl.coroutines.jvm.internal.DebugMetadata;
import wakotl.coroutines.jvm.internal.SuspendLambda;
import wakotl.jvm.functions.Function2;
import wakotl.jvm.internal.Intrinsics;
import wakotl.jvm.internal.Ref;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.settings.RemoteSettings$updateSettings$2$1", f = "RemoteSettings.kt", i = {0, 0, 0, 1, 1, 2}, l = {125, Optimizer.OPTIMIZATION_GRAPH_WRAP, 131, 133, 134, 136}, m = "invokeSuspend", n = {"sessionSamplingRate", "sessionTimeoutSeconds", "cacheDuration", "sessionSamplingRate", "cacheDuration", "cacheDuration"}, s = {"L$0", "L$1", "L$2", "L$0", "L$1", "L$0"})
@Metadata(d1 = {"\u0000\f\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\u008a@"}, d2 = {"<anonymous>", "", "it", "Lorg/json/JSONObject;"}, k = 3, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
final class RemoteSettings$updateSettings$2$1 extends SuspendLambda implements Function2<JSONObject, Continuation<? super Unit>, Object> {
    /* synthetic */ Object L$0;
    Object L$1;
    Object L$2;
    int label;
    final /* synthetic */ C0131a this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    public RemoteSettings$updateSettings$2$1(C0131a c0131a, Continuation<? super RemoteSettings$updateSettings$2$1> continuation) {
        super(2, continuation);
        this.this$0 = c0131a;
    }

    @NotNull
    public final Continuation<Unit> create(@Nullable Object obj, @NotNull Continuation<?> continuation) {
        RemoteSettings$updateSettings$2$1 remoteSettings$updateSettings$2$1 = new RemoteSettings$updateSettings$2$1(this.this$0, continuation);
        remoteSettings$updateSettings$2$1.L$0 = obj;
        return remoteSettings$updateSettings$2$1;
    }

    /* JADX WARN: Code duplicated, block: B:48:0x00f5  */
    /* JADX WARN: Code duplicated, block: B:51:0x0115  */
    /* JADX WARN: Code duplicated, block: B:53:0x0119 A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:56:0x0120  */
    /* JADX WARN: Code duplicated, block: B:59:0x0140  */
    /* JADX WARN: Code duplicated, block: B:61:0x0144 A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:64:0x014b  */
    /* JADX WARN: Code duplicated, block: B:67:0x016b  */
    /* JADX WARN: Code duplicated, block: B:69:0x016f A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:71:0x0173  */
    /* JADX WARN: Code duplicated, block: B:73:0x0176  */
    /* JADX WARN: Code duplicated, block: B:76:0x0199  */
    /* JADX WARN: Code duplicated, block: B:78:0x019d A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:82:0x01c2  */
    /* JADX WARN: Code duplicated, block: B:84:0x01c6 A[RETURN] */
    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) throws JSONException {
        Ref.ObjectRef objectRef;
        Boolean bool;
        Ref.ObjectRef objectRef2;
        Ref.ObjectRef objectRef3;
        Ref.ObjectRef objectRef4;
        Ref.ObjectRef objectRef5;
        Object objM348c;
        Object objM348c2;
        Unit unit;
        Object objM348c3;
        Object objM348c4;
        Object objM348c5;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        switch (this.label) {
            case 0:
                wakotl.b.b(obj);
                JSONObject jSONObject = (JSONObject) this.L$0;
                Objects.toString(jSONObject);
                Ref.ObjectRef objectRef6 = new Ref.ObjectRef();
                objectRef = new Ref.ObjectRef();
                Ref.ObjectRef objectRef7 = new Ref.ObjectRef();
                if (jSONObject.has("app_quality")) {
                    Object obj2 = jSONObject.get("app_quality");
                    Intrinsics.d(obj2, "null cannot be cast to non-null type org.json.JSONObject");
                    JSONObject jSONObject2 = (JSONObject) obj2;
                    try {
                        bool = jSONObject2.has("sessions_enabled") ? (Boolean) jSONObject2.get("sessions_enabled") : null;
                        try {
                            if (jSONObject2.has("sampling_rate")) {
                                objectRef6.element = (Double) jSONObject2.get("sampling_rate");
                            }
                            if (jSONObject2.has("session_timeout_seconds")) {
                                objectRef.element = (Integer) jSONObject2.get("session_timeout_seconds");
                            }
                            if (jSONObject2.has("cache_duration")) {
                                objectRef7.element = (Integer) jSONObject2.get("cache_duration");
                            }
                        } catch (JSONException e) {
                            e = e;
                            Log.e("SessionConfigFetcher", "Error parsing the configs remotely fetched: ", e);
                        }
                    } catch (JSONException e2) {
                        e = e2;
                        bool = null;
                    }
                    break;
                } else {
                    bool = null;
                }
                if (bool != null) {
                    C0136f c0136fM341b = this.this$0.m341b();
                    this.L$0 = objectRef6;
                    this.L$1 = objectRef;
                    this.L$2 = objectRef7;
                    this.label = 1;
                    Object objM348c6 = c0136fM341b.m348c(C0136f.f901c, bool, this);
                    if (objM348c6 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c6 = Unit.a;
                    }
                    if (objM348c6 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                    objectRef4 = objectRef6;
                    objectRef5 = objectRef;
                    objectRef3 = objectRef7;
                    objectRef = objectRef5;
                    objectRef2 = objectRef4;
                } else {
                    objectRef2 = objectRef6;
                    objectRef3 = objectRef7;
                }
                if (((Integer) objectRef.element) != null) {
                    C0136f c0136fM341b2 = this.this$0.m341b();
                    Integer num = (Integer) objectRef.element;
                    this.L$0 = objectRef2;
                    this.L$1 = objectRef3;
                    this.L$2 = null;
                    this.label = 2;
                    objM348c = c0136fM341b2.m348c(C0136f.f903e, num, this);
                    if (objM348c != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c = Unit.a;
                    }
                    if (objM348c == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                if (((Double) objectRef2.element) != null) {
                    C0136f c0136fM341b3 = this.this$0.m341b();
                    Double d = (Double) objectRef2.element;
                    this.L$0 = objectRef3;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 3;
                    objM348c2 = c0136fM341b3.m348c(C0136f.f902d, d, this);
                    if (objM348c2 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c2 = Unit.a;
                    }
                    if (objM348c2 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                if (((Integer) objectRef3.element) != null) {
                    C0136f c0136fM341b4 = this.this$0.m341b();
                    Integer num2 = (Integer) objectRef3.element;
                    this.L$0 = null;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 4;
                    objM348c3 = c0136fM341b4.m348c(C0136f.f904f, num2, this);
                    if (objM348c3 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c3 = Unit.a;
                    }
                    if (objM348c3 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                    unit = Unit.a;
                } else {
                    unit = null;
                }
                if (unit == null) {
                    C0136f c0136fM341b5 = this.this$0.m341b();
                    Integer numBoxInt = Boxing.boxInt(86400);
                    this.L$0 = null;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 5;
                    objM348c4 = c0136fM341b5.m348c(C0136f.f904f, numBoxInt, this);
                    if (objM348c4 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c4 = Unit.a;
                    }
                    if (objM348c4 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                C0136f c0136fM341b6 = this.this$0.m341b();
                Long lBoxLong = Boxing.boxLong(System.currentTimeMillis());
                this.L$0 = null;
                this.L$1 = null;
                this.L$2 = null;
                this.label = 6;
                objM348c5 = c0136fM341b6.m348c(C0136f.f905g, lBoxLong, this);
                if (objM348c5 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                    objM348c5 = Unit.a;
                }
                if (objM348c5 == coroutine_suspended) {
                    return coroutine_suspended;
                }
                return Unit.a;
            case 1:
                objectRef3 = (Ref.ObjectRef) this.L$2;
                objectRef5 = (Ref.ObjectRef) this.L$1;
                objectRef4 = (Ref.ObjectRef) this.L$0;
                wakotl.b.b(obj);
                objectRef = objectRef5;
                objectRef2 = objectRef4;
                if (((Integer) objectRef.element) != null) {
                    C0136f c0136fM341b7 = this.this$0.m341b();
                    Integer num3 = (Integer) objectRef.element;
                    this.L$0 = objectRef2;
                    this.L$1 = objectRef3;
                    this.L$2 = null;
                    this.label = 2;
                    objM348c = c0136fM341b7.m348c(C0136f.f903e, num3, this);
                    if (objM348c != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c = Unit.a;
                    }
                    if (objM348c == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                if (((Double) objectRef2.element) != null) {
                    C0136f c0136fM341b8 = this.this$0.m341b();
                    Double d2 = (Double) objectRef2.element;
                    this.L$0 = objectRef3;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 3;
                    objM348c2 = c0136fM341b8.m348c(C0136f.f902d, d2, this);
                    if (objM348c2 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c2 = Unit.a;
                    }
                    if (objM348c2 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                if (((Integer) objectRef3.element) != null) {
                    C0136f c0136fM341b9 = this.this$0.m341b();
                    Integer num4 = (Integer) objectRef3.element;
                    this.L$0 = null;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 4;
                    objM348c3 = c0136fM341b9.m348c(C0136f.f904f, num4, this);
                    if (objM348c3 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c3 = Unit.a;
                    }
                    if (objM348c3 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                    unit = Unit.a;
                } else {
                    unit = null;
                }
                if (unit == null) {
                    C0136f c0136fM341b10 = this.this$0.m341b();
                    Integer numBoxInt2 = Boxing.boxInt(86400);
                    this.L$0 = null;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 5;
                    objM348c4 = c0136fM341b10.m348c(C0136f.f904f, numBoxInt2, this);
                    if (objM348c4 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c4 = Unit.a;
                    }
                    if (objM348c4 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                C0136f c0136fM341b11 = this.this$0.m341b();
                Long lBoxLong2 = Boxing.boxLong(System.currentTimeMillis());
                this.L$0 = null;
                this.L$1 = null;
                this.L$2 = null;
                this.label = 6;
                objM348c5 = c0136fM341b11.m348c(C0136f.f905g, lBoxLong2, this);
                if (objM348c5 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                    objM348c5 = Unit.a;
                }
                if (objM348c5 == coroutine_suspended) {
                    return coroutine_suspended;
                }
                return Unit.a;
            case 2:
                objectRef3 = (Ref.ObjectRef) this.L$1;
                objectRef2 = (Ref.ObjectRef) this.L$0;
                wakotl.b.b(obj);
                if (((Double) objectRef2.element) != null) {
                    C0136f c0136fM341b12 = this.this$0.m341b();
                    Double d3 = (Double) objectRef2.element;
                    this.L$0 = objectRef3;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 3;
                    objM348c2 = c0136fM341b12.m348c(C0136f.f902d, d3, this);
                    if (objM348c2 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c2 = Unit.a;
                    }
                    if (objM348c2 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                if (((Integer) objectRef3.element) != null) {
                    C0136f c0136fM341b13 = this.this$0.m341b();
                    Integer num5 = (Integer) objectRef3.element;
                    this.L$0 = null;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 4;
                    objM348c3 = c0136fM341b13.m348c(C0136f.f904f, num5, this);
                    if (objM348c3 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c3 = Unit.a;
                    }
                    if (objM348c3 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                    unit = Unit.a;
                } else {
                    unit = null;
                }
                if (unit == null) {
                    C0136f c0136fM341b14 = this.this$0.m341b();
                    Integer numBoxInt3 = Boxing.boxInt(86400);
                    this.L$0 = null;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 5;
                    objM348c4 = c0136fM341b14.m348c(C0136f.f904f, numBoxInt3, this);
                    if (objM348c4 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c4 = Unit.a;
                    }
                    if (objM348c4 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                C0136f c0136fM341b15 = this.this$0.m341b();
                Long lBoxLong3 = Boxing.boxLong(System.currentTimeMillis());
                this.L$0 = null;
                this.L$1 = null;
                this.L$2 = null;
                this.label = 6;
                objM348c5 = c0136fM341b15.m348c(C0136f.f905g, lBoxLong3, this);
                if (objM348c5 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                    objM348c5 = Unit.a;
                }
                if (objM348c5 == coroutine_suspended) {
                    return coroutine_suspended;
                }
                return Unit.a;
            case 3:
                objectRef3 = (Ref.ObjectRef) this.L$0;
                wakotl.b.b(obj);
                if (((Integer) objectRef3.element) != null) {
                    C0136f c0136fM341b16 = this.this$0.m341b();
                    Integer num6 = (Integer) objectRef3.element;
                    this.L$0 = null;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 4;
                    objM348c3 = c0136fM341b16.m348c(C0136f.f904f, num6, this);
                    if (objM348c3 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c3 = Unit.a;
                    }
                    if (objM348c3 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                    unit = Unit.a;
                } else {
                    unit = null;
                }
                if (unit == null) {
                    C0136f c0136fM341b17 = this.this$0.m341b();
                    Integer numBoxInt4 = Boxing.boxInt(86400);
                    this.L$0 = null;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 5;
                    objM348c4 = c0136fM341b17.m348c(C0136f.f904f, numBoxInt4, this);
                    if (objM348c4 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c4 = Unit.a;
                    }
                    if (objM348c4 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                C0136f c0136fM341b18 = this.this$0.m341b();
                Long lBoxLong4 = Boxing.boxLong(System.currentTimeMillis());
                this.L$0 = null;
                this.L$1 = null;
                this.L$2 = null;
                this.label = 6;
                objM348c5 = c0136fM341b18.m348c(C0136f.f905g, lBoxLong4, this);
                if (objM348c5 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                    objM348c5 = Unit.a;
                }
                if (objM348c5 == coroutine_suspended) {
                    return coroutine_suspended;
                }
                return Unit.a;
            case 4:
                wakotl.b.b(obj);
                unit = Unit.a;
                if (unit == null) {
                    C0136f c0136fM341b19 = this.this$0.m341b();
                    Integer numBoxInt5 = Boxing.boxInt(86400);
                    this.L$0 = null;
                    this.L$1 = null;
                    this.L$2 = null;
                    this.label = 5;
                    objM348c4 = c0136fM341b19.m348c(C0136f.f904f, numBoxInt5, this);
                    if (objM348c4 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                        objM348c4 = Unit.a;
                    }
                    if (objM348c4 == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
                C0136f c0136fM341b110 = this.this$0.m341b();
                Long lBoxLong5 = Boxing.boxLong(System.currentTimeMillis());
                this.L$0 = null;
                this.L$1 = null;
                this.L$2 = null;
                this.label = 6;
                objM348c5 = c0136fM341b110.m348c(C0136f.f905g, lBoxLong5, this);
                if (objM348c5 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                    objM348c5 = Unit.a;
                }
                if (objM348c5 == coroutine_suspended) {
                    return coroutine_suspended;
                }
                return Unit.a;
            case 5:
                wakotl.b.b(obj);
                C0136f c0136fM341b111 = this.this$0.m341b();
                Long lBoxLong6 = Boxing.boxLong(System.currentTimeMillis());
                this.L$0 = null;
                this.L$1 = null;
                this.L$2 = null;
                this.label = 6;
                objM348c5 = c0136fM341b111.m348c(C0136f.f905g, lBoxLong6, this);
                if (objM348c5 != wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED()) {
                    objM348c5 = Unit.a;
                }
                if (objM348c5 == coroutine_suspended) {
                    return coroutine_suspended;
                }
                return Unit.a;
            case 6:
                wakotl.b.b(obj);
                return Unit.a;
            default:
                throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
        }
    }

    @Nullable
    public final Object invoke(@NotNull JSONObject jSONObject, @Nullable Continuation<? super Unit> continuation) {
        return create(jSONObject, continuation).invokeSuspend(Unit.a);
    }
}
