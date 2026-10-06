package com.google.firebase.sessions.settings;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLConnection;
import java.util.Map;
import javax.net.ssl.HttpsURLConnection;
import kotlinx.coroutines.e0;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import org.json.JSONObject;
import wakotl.Metadata;
import wakotl.Unit;
import wakotl.coroutines.Continuation;
import wakotl.coroutines.jvm.internal.DebugMetadata;
import wakotl.coroutines.jvm.internal.SuspendLambda;
import wakotl.jvm.functions.Function2;
import wakotl.jvm.internal.Intrinsics;
import wakotl.jvm.internal.Ref;

/* JADX INFO: loaded from: classes.dex */
@DebugMetadata(c = "com.google.firebase.sessions.settings.RemoteSettingsFetcher$doConfigFetch$2", f = "RemoteSettingsFetcher.kt", i = {}, l = {68, 70, 73}, m = "invokeSuspend", n = {}, s = {})
@Metadata(d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\b\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\u008a@¢\u0006\u0004\b\u0002\u0010\u0003"}, d2 = {"Lkotlinx/coroutines/e0;", "", "<anonymous>", "(Lkotlinx/coroutines/e0;)V"}, k = 3, mv = {1, 8, 0})
final class RemoteSettingsFetcher$doConfigFetch$2 extends SuspendLambda implements Function2<e0, Continuation<? super Unit>, Object> {
    final /* synthetic */ Map<String, String> $headerOptions;
    final /* synthetic */ Function2<String, Continuation<? super Unit>, Object> $onFailure;
    final /* synthetic */ Function2<JSONObject, Continuation<? super Unit>, Object> $onSuccess;
    int label;
    final /* synthetic */ C0132b this$0;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    /* JADX WARN: Multi-variable type inference failed */
    public RemoteSettingsFetcher$doConfigFetch$2(C0132b c0132b, Map<String, String> map, Function2<? super JSONObject, ? super Continuation<? super Unit>, ? extends Object> function2, Function2<? super String, ? super Continuation<? super Unit>, ? extends Object> function3, Continuation<? super RemoteSettingsFetcher$doConfigFetch$2> continuation) {
        super(2, continuation);
        this.this$0 = c0132b;
        this.$headerOptions = map;
        this.$onSuccess = function2;
        this.$onFailure = function3;
    }

    @NotNull
    public final Continuation<Unit> create(@Nullable Object obj, @NotNull Continuation<?> continuation) {
        return new RemoteSettingsFetcher$doConfigFetch$2(this.this$0, this.$headerOptions, this.$onSuccess, this.$onFailure, continuation);
    }

    @Nullable
    public final Object invokeSuspend(@NotNull Object obj) {
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i = this.label;
        try {
            if (i == 0) {
                wakotl.b.b(obj);
                URLConnection uRLConnectionOpenConnection = C0132b.m343a(this.this$0).openConnection();
                Intrinsics.d(uRLConnectionOpenConnection, "null cannot be cast to non-null type javax.net.ssl.HttpsURLConnection");
                HttpsURLConnection httpsURLConnection = (HttpsURLConnection) uRLConnectionOpenConnection;
                httpsURLConnection.setRequestMethod("GET");
                httpsURLConnection.setRequestProperty("Accept", "application/json");
                for (Map.Entry<String, String> entry : this.$headerOptions.entrySet()) {
                    httpsURLConnection.setRequestProperty(entry.getKey(), entry.getValue());
                }
                int responseCode = httpsURLConnection.getResponseCode();
                if (responseCode == 200) {
                    InputStream inputStream = httpsURLConnection.getInputStream();
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                    StringBuilder sb = new StringBuilder();
                    Ref.ObjectRef objectRef = new Ref.ObjectRef();
                    while (true) {
                        String line = bufferedReader.readLine();
                        objectRef.element = line;
                        if (line == null) {
                            break;
                        }
                        sb.append(line);
                    }
                    bufferedReader.close();
                    inputStream.close();
                    JSONObject jSONObject = new JSONObject(sb.toString());
                    Function2<JSONObject, Continuation<? super Unit>, Object> function2 = this.$onSuccess;
                    this.label = 1;
                    if (function2.invoke(jSONObject, this) == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                } else {
                    Function2<String, Continuation<? super Unit>, Object> function3 = this.$onFailure;
                    String str = "Bad response code: " + responseCode;
                    this.label = 2;
                    if (function3.invoke(str, this) == coroutine_suspended) {
                        return coroutine_suspended;
                    }
                }
            } else {
                if (i != 1 && i != 2 && i != 3) {
                    throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
                }
                wakotl.b.b(obj);
            }
        } catch (Exception e) {
            Function2<String, Continuation<? super Unit>, Object> function4 = this.$onFailure;
            String message = e.getMessage();
            if (message == null) {
                message = e.toString();
            }
            this.label = 3;
            if (function4.invoke(message, this) == coroutine_suspended) {
                return coroutine_suspended;
            }
        }
        return Unit.a;
    }

    @Nullable
    public final Object invoke(@NotNull e0 e0Var, @Nullable Continuation<? super Unit> continuation) {
        return create(e0Var, continuation).invokeSuspend(Unit.a);
    }
}
