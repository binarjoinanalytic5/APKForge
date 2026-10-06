.class public final synthetic Lcom/google/firebase/crashlytics/ndk/b;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final synthetic a:Lag/b;

.field public final synthetic b:Ljava/lang/String;

.field public final synthetic c:J

.field public final synthetic d:Lsf/p1;


# direct methods
.method public synthetic constructor <init>(Lag/b;Ljava/lang/String;JLsf/p1;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/firebase/crashlytics/ndk/b;->a:Lag/b;

    iput-object p2, p0, Lcom/google/firebase/crashlytics/ndk/b;->b:Ljava/lang/String;

    iput-wide p3, p0, Lcom/google/firebase/crashlytics/ndk/b;->c:J

    iput-object p5, p0, Lcom/google/firebase/crashlytics/ndk/b;->d:Lsf/p1;

    return-void
.end method


# virtual methods
.method public final a()V
    .locals 8

    .line 1
    iget-wide v0, p0, Lcom/google/firebase/crashlytics/ndk/b;->c:J

    .line 2
    .line 3
    iget-object v2, p0, Lcom/google/firebase/crashlytics/ndk/b;->d:Lsf/p1;

    .line 4
    .line 5
    iget-object v3, p0, Lcom/google/firebase/crashlytics/ndk/b;->a:Lag/b;

    .line 6
    .line 7
    iget-object v3, v3, Lag/b;->a:Lag/a;

    .line 8
    .line 9
    iget-object v4, v3, Lag/a;->c:Lvf/c;

    .line 10
    .line 11
    iget-object v5, p0, Lcom/google/firebase/crashlytics/ndk/b;->b:Ljava/lang/String;

    .line 12
    .line 13
    invoke-virtual {v4, v5}, Lvf/c;->f(Ljava/lang/String;)Ljava/io/File;

    .line 14
    .line 15
    .line 16
    move-result-object v4

    .line 17
    :try_start_0
    invoke-virtual {v4}, Ljava/io/File;->getCanonicalPath()Ljava/lang/String;

    .line 18
    .line 19
    .line 20
    move-result-object v4

    .line 21
    iget-object v6, v3, Lag/a;->b:Lag/c;

    .line 22
    .line 23
    iget-object v7, v3, Lag/a;->a:Landroid/content/Context;

    .line 24
    .line 25
    invoke-virtual {v7}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    .line 26
    .line 27
    .line 28
    move-result-object v7

    .line 29
    check-cast v6, Lcom/google/firebase/crashlytics/ndk/JniNativeApi;

    .line 30
    .line 31
    invoke-virtual {v6, v7, v4}, Lcom/google/firebase/crashlytics/ndk/JniNativeApi;->b(Landroid/content/res/AssetManager;Ljava/lang/String;)Z

    .line 32
    .line 33
    .line 34
    move-result v4

    .line 35
    if-eqz v4, :cond_0

    .line 36
    .line 37
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 38
    .line 39
    .line 40
    const-string v4, "session_id"

    .line 41
    .line 42
    const-string v6, "generator"

    .line 43
    .line 44
    const-string v7, "Crashlytics Android SDK/19.4.0"

    .line 45
    .line 46
    invoke-static {v4, v5, v6, v7}, Landroidx/datastore/preferences/core/h;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/util/HashMap;

    .line 47
    .line 48
    .line 49
    move-result-object v4

    .line 50
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    .line 51
    .line 52
    .line 53
    move-result-object v0

    .line 54
    const-string v1, "started_at_seconds"

    .line 55
    .line 56
    invoke-virtual {v4, v1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 57
    .line 58
    .line 59
    new-instance v0, Lorg/json/JSONObject;

    .line 60
    .line 61
    invoke-direct {v0, v4}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    .line 62
    .line 63
    .line 64
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    .line 65
    .line 66
    .line 67
    move-result-object v0

    .line 68
    iget-object v1, v3, Lag/a;->c:Lvf/c;

    .line 69
    .line 70
    const-string v4, "session.json"

    .line 71
    .line 72
    invoke-static {v1, v5, v0, v4}, Lag/a;->f(Lvf/c;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 73
    .line 74
    .line 75
    iget-object v0, v2, Lsf/p1;->a:Lsf/q1;

    .line 76
    .line 77
    invoke-virtual {v3, v5, v0}, Lag/a;->d(Ljava/lang/String;Lsf/q1;)V

    .line 78
    .line 79
    .line 80
    iget-object v0, v2, Lsf/p1;->b:Lsf/s1;

    .line 81
    .line 82
    invoke-virtual {v3, v5, v0}, Lag/a;->g(Ljava/lang/String;Lsf/s1;)V

    .line 83
    .line 84
    .line 85
    iget-object v0, v2, Lsf/p1;->c:Lsf/r1;

    .line 86
    .line 87
    invoke-virtual {v3, v5, v0}, Lag/a;->e(Ljava/lang/String;Lsf/r1;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    .line 89
    .line 90
    goto :goto_0

    .line 91
    :catch_0
    move-exception v0

    .line 92
    const-string v1, "FirebaseCrashlytics"

    .line 93
    .line 94
    const-string v2, "Error initializing Crashlytics NDK"

    .line 95
    .line 96
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 97
    .line 98
    .line 99
    :cond_0
    :goto_0
    return-void
.end method
