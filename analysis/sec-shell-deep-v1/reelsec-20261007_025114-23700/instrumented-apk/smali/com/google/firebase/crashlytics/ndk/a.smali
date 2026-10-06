.class public final synthetic Lcom/google/firebase/crashlytics/ndk/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljf/e;


# instance fields
.field public final synthetic a:Lcom/google/firebase/crashlytics/ndk/CrashlyticsNdkRegistrar;


# direct methods
.method public synthetic constructor <init>(Lcom/google/firebase/crashlytics/ndk/CrashlyticsNdkRegistrar;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/firebase/crashlytics/ndk/a;->a:Lcom/google/firebase/crashlytics/ndk/CrashlyticsNdkRegistrar;

    return-void
.end method


# virtual methods
.method public final f(Lcom/google/firebase/messaging/v;)Ljava/lang/Object;
    .locals 4

    .line 1
    iget-object v0, p0, Lcom/google/firebase/crashlytics/ndk/a;->a:Lcom/google/firebase/crashlytics/ndk/CrashlyticsNdkRegistrar;

    .line 2
    .line 3
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 4
    .line 5
    .line 6
    const-class v0, Landroid/content/Context;

    .line 7
    .line 8
    invoke-virtual {p1, v0}, Lcom/google/firebase/messaging/v;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 9
    .line 10
    .line 11
    move-result-object p1

    .line 12
    check-cast p1, Landroid/content/Context;

    .line 13
    .line 14
    const-string v0, "com.google.firebase.crashlytics.unity_version"

    .line 15
    .line 16
    const-string v1, "string"

    .line 17
    .line 18
    invoke-static {p1, v0, v1}, Lpf/g;->e(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    .line 19
    .line 20
    .line 21
    move-result v0

    .line 22
    const/4 v1, 0x1

    .line 23
    if-eqz v0, :cond_0

    .line 24
    .line 25
    move v0, v1

    .line 26
    goto :goto_0

    .line 27
    :cond_0
    const/4 v0, 0x0

    .line 28
    :goto_0
    xor-int/2addr v0, v1

    .line 29
    new-instance v1, Lag/a;

    .line 30
    .line 31
    new-instance v2, Lcom/google/firebase/crashlytics/ndk/JniNativeApi;

    .line 32
    .line 33
    invoke-direct {v2, p1}, Lcom/google/firebase/crashlytics/ndk/JniNativeApi;-><init>(Landroid/content/Context;)V

    .line 34
    .line 35
    .line 36
    new-instance v3, Lvf/c;

    .line 37
    .line 38
    invoke-direct {v3, p1}, Lvf/c;-><init>(Landroid/content/Context;)V

    .line 39
    .line 40
    .line 41
    invoke-direct {v1, p1, v2, v3}, Lag/a;-><init>(Landroid/content/Context;Lag/c;Lvf/c;)V

    .line 42
    .line 43
    .line 44
    new-instance p1, Lag/b;

    .line 45
    .line 46
    invoke-direct {p1, v1, v0}, Lag/b;-><init>(Lag/a;Z)V

    .line 47
    .line 48
    .line 49
    return-object p1
.end method
