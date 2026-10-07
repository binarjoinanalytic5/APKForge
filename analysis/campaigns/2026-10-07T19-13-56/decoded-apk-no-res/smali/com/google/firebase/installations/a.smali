.class public final Lcom/google/firebase/installations/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Llg/d;


# static fields
.field public static final m:Ljava/lang/Object;


# instance fields
.field public final a:Lef/h;

.field public final b:Lng/c;

.field public final c:Landroidx/work/impl/model/e;

.field public final d:Llg/i;

.field public final e:Ljf/k;

.field public final f:Llg/g;

.field public final g:Ljava/lang/Object;

.field public final h:Ljava/util/concurrent/ExecutorService;

.field public final i:Lcom/google/firebase/concurrent/b;

.field public j:Ljava/lang/String;

.field public final k:Ljava/util/HashSet;

.field public final l:Ljava/util/ArrayList;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/Object;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/installations/a;->m:Ljava/lang/Object;

    .line 7
    .line 8
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    .line 9
    .line 10
    const/4 v1, 0x1

    .line 11
    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    .line 12
    .line 13
    .line 14
    return-void
.end method

.method public constructor <init>(Lef/h;Lkg/b;Ljava/util/concurrent/ExecutorService;Lcom/google/firebase/concurrent/b;)V
    .locals 5

    .line 1
    new-instance v0, Lng/c;

    .line 2
    .line 3
    invoke-virtual {p1}, Lef/h;->a()V

    .line 4
    .line 5
    .line 6
    iget-object v1, p1, Lef/h;->a:Landroid/content/Context;

    .line 7
    .line 8
    invoke-direct {v0, v1, p2}, Lng/c;-><init>(Landroid/content/Context;Lkg/b;)V

    .line 9
    .line 10
    .line 11
    new-instance p2, Landroidx/work/impl/model/e;

    .line 12
    .line 13
    invoke-direct {p2, p1}, Landroidx/work/impl/model/e;-><init>(Lef/h;)V

    .line 14
    .line 15
    .line 16
    sget-object v1, Ll3/c;->b:Ll3/c;

    .line 17
    .line 18
    if-nez v1, :cond_0

    .line 19
    .line 20
    new-instance v1, Ll3/c;

    .line 21
    .line 22
    const/4 v2, 0x7

    .line 23
    invoke-direct {v1, v2}, Ll3/c;-><init>(I)V

    .line 24
    .line 25
    .line 26
    sput-object v1, Ll3/c;->b:Ll3/c;

    .line 27
    .line 28
    :cond_0
    sget-object v1, Ll3/c;->b:Ll3/c;

    .line 29
    .line 30
    sget-object v2, Llg/i;->d:Llg/i;

    .line 31
    .line 32
    if-nez v2, :cond_1

    .line 33
    .line 34
    new-instance v2, Llg/i;

    .line 35
    .line 36
    invoke-direct {v2, v1}, Llg/i;-><init>(Ll3/c;)V

    .line 37
    .line 38
    .line 39
    sput-object v2, Llg/i;->d:Llg/i;

    .line 40
    .line 41
    :cond_1
    sget-object v1, Llg/i;->d:Llg/i;

    .line 42
    .line 43
    new-instance v2, Ljf/k;

    .line 44
    .line 45
    new-instance v3, Ljf/d;

    .line 46
    .line 47
    const/4 v4, 0x2

    .line 48
    invoke-direct {v3, p1, v4}, Ljf/d;-><init>(Ljava/lang/Object;I)V

    .line 49
    .line 50
    .line 51
    invoke-direct {v2, v3}, Ljf/k;-><init>(Lkg/b;)V

    .line 52
    .line 53
    .line 54
    new-instance v3, Llg/g;

    .line 55
    .line 56
    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    .line 57
    .line 58
    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 60
    .line 61
    .line 62
    new-instance v4, Ljava/lang/Object;

    .line 63
    .line 64
    invoke-direct {v4}, Ljava/lang/Object;-><init>()V

    .line 65
    .line 66
    .line 67
    iput-object v4, p0, Lcom/google/firebase/installations/a;->g:Ljava/lang/Object;

    .line 68
    .line 69
    new-instance v4, Ljava/util/HashSet;

    .line 70
    .line 71
    invoke-direct {v4}, Ljava/util/HashSet;-><init>()V

    .line 72
    .line 73
    .line 74
    iput-object v4, p0, Lcom/google/firebase/installations/a;->k:Ljava/util/HashSet;

    .line 75
    .line 76
    new-instance v4, Ljava/util/ArrayList;

    .line 77
    .line 78
    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 79
    .line 80
    .line 81
    iput-object v4, p0, Lcom/google/firebase/installations/a;->l:Ljava/util/ArrayList;

    .line 82
    .line 83
    iput-object p1, p0, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 84
    .line 85
    iput-object v0, p0, Lcom/google/firebase/installations/a;->b:Lng/c;

    .line 86
    .line 87
    iput-object p2, p0, Lcom/google/firebase/installations/a;->c:Landroidx/work/impl/model/e;

    .line 88
    .line 89
    iput-object v1, p0, Lcom/google/firebase/installations/a;->d:Llg/i;

    .line 90
    .line 91
    iput-object v2, p0, Lcom/google/firebase/installations/a;->e:Ljf/k;

    .line 92
    .line 93
    iput-object v3, p0, Lcom/google/firebase/installations/a;->f:Llg/g;

    .line 94
    .line 95
    iput-object p3, p0, Lcom/google/firebase/installations/a;->h:Ljava/util/concurrent/ExecutorService;

    .line 96
    .line 97
    iput-object p4, p0, Lcom/google/firebase/installations/a;->i:Lcom/google/firebase/concurrent/b;

    .line 98
    .line 99
    return-void
.end method


# virtual methods
.method public final a(Llg/h;)V
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/google/firebase/installations/a;->g:Ljava/lang/Object;

    .line 2
    .line 3
    monitor-enter v0

    .line 4
    :try_start_0
    iget-object v1, p0, Lcom/google/firebase/installations/a;->l:Ljava/util/ArrayList;

    .line 5
    .line 6
    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 7
    .line 8
    .line 9
    monitor-exit v0

    .line 10
    return-void

    .line 11
    :catchall_0
    move-exception p1

    .line 12
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 13
    throw p1
.end method

.method public final b()V
    .locals 5

    .line 1
    sget-object v0, Lcom/google/firebase/installations/a;->m:Ljava/lang/Object;

    .line 2
    .line 3
    monitor-enter v0

    .line 4
    :try_start_0
    iget-object v1, p0, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 5
    .line 6
    invoke-virtual {v1}, Lef/h;->a()V

    .line 7
    .line 8
    .line 9
    iget-object v1, v1, Lef/h;->a:Landroid/content/Context;

    .line 10
    .line 11
    invoke-static {v1}, Landroidx/work/impl/model/l;->e(Landroid/content/Context;)Landroidx/work/impl/model/l;

    .line 12
    .line 13
    .line 14
    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 15
    :try_start_1
    iget-object v2, p0, Lcom/google/firebase/installations/a;->c:Landroidx/work/impl/model/e;

    .line 16
    .line 17
    invoke-virtual {v2}, Landroidx/work/impl/model/e;->s()Lmg/a;

    .line 18
    .line 19
    .line 20
    move-result-object v2

    .line 21
    sget-object v3, Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;->NOT_GENERATED:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 22
    .line 23
    iget-object v4, v2, Lmg/a;->b:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 24
    .line 25
    if-eq v4, v3, :cond_1

    .line 26
    .line 27
    sget-object v3, Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;->ATTEMPT_MIGRATION:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 28
    .line 29
    if-ne v4, v3, :cond_0

    .line 30
    .line 31
    goto :goto_0

    .line 32
    :cond_0
    const/4 v3, 0x0

    .line 33
    goto :goto_1

    .line 34
    :cond_1
    :goto_0
    const/4 v3, 0x1

    .line 35
    :goto_1
    if-eqz v3, :cond_2

    .line 36
    .line 37
    invoke-virtual {p0, v2}, Lcom/google/firebase/installations/a;->h(Lmg/a;)Ljava/lang/String;

    .line 38
    .line 39
    .line 40
    move-result-object v3

    .line 41
    iget-object v4, p0, Lcom/google/firebase/installations/a;->c:Landroidx/work/impl/model/e;

    .line 42
    .line 43
    invoke-virtual {v2}, Lmg/a;->a()Lvf/c;

    .line 44
    .line 45
    .line 46
    move-result-object v2

    .line 47
    iput-object v3, v2, Lvf/c;->a:Ljava/lang/Object;

    .line 48
    .line 49
    sget-object v3, Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;->UNREGISTERED:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 50
    .line 51
    invoke-virtual {v2, v3}, Lvf/c;->n(Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;)V

    .line 52
    .line 53
    .line 54
    invoke-virtual {v2}, Lvf/c;->c()Lmg/a;

    .line 55
    .line 56
    .line 57
    move-result-object v2

    .line 58
    invoke-virtual {v4, v2}, Landroidx/work/impl/model/e;->p(Lmg/a;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 59
    .line 60
    .line 61
    goto :goto_2

    .line 62
    :catchall_0
    move-exception v2

    .line 63
    goto :goto_4

    .line 64
    :cond_2
    :goto_2
    if-eqz v1, :cond_3

    .line 65
    .line 66
    :try_start_2
    invoke-virtual {v1}, Landroidx/work/impl/model/l;->o()V

    .line 67
    .line 68
    .line 69
    goto :goto_3

    .line 70
    :catchall_1
    move-exception v1

    .line 71
    goto :goto_5

    .line 72
    :cond_3
    :goto_3
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 73
    invoke-virtual {p0, v2}, Lcom/google/firebase/installations/a;->k(Lmg/a;)V

    .line 74
    .line 75
    .line 76
    iget-object v0, p0, Lcom/google/firebase/installations/a;->i:Lcom/google/firebase/concurrent/b;

    .line 77
    .line 78
    new-instance v1, Llg/b;

    .line 79
    .line 80
    const/4 v2, 0x2

    .line 81
    invoke-direct {v1, p0, v2}, Llg/b;-><init>(Lcom/google/firebase/installations/a;I)V

    .line 82
    .line 83
    .line 84
    invoke-virtual {v0, v1}, Lcom/google/firebase/concurrent/b;->execute(Ljava/lang/Runnable;)V

    .line 85
    .line 86
    .line 87
    return-void

    .line 88
    :goto_4
    if-eqz v1, :cond_4

    .line 89
    .line 90
    :try_start_3
    invoke-virtual {v1}, Landroidx/work/impl/model/l;->o()V

    .line 91
    .line 92
    .line 93
    :cond_4
    throw v2

    .line 94
    :goto_5
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 95
    throw v1
.end method

.method public final c(Lmg/a;)Lmg/a;
    .locals 14

    .line 1
    iget-object v0, p0, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 2
    .line 3
    invoke-virtual {v0}, Lef/h;->a()V

    .line 4
    .line 5
    .line 6
    iget-object v1, v0, Lef/h;->c:Lef/j;

    .line 7
    .line 8
    iget-object v1, v1, Lef/j;->a:Ljava/lang/String;

    .line 9
    .line 10
    invoke-virtual {v0}, Lef/h;->a()V

    .line 11
    .line 12
    .line 13
    iget-object v0, v0, Lef/h;->c:Lef/j;

    .line 14
    .line 15
    iget-object v0, v0, Lef/j;->g:Ljava/lang/String;

    .line 16
    .line 17
    iget-object v2, p1, Lmg/a;->d:Ljava/lang/String;

    .line 18
    .line 19
    iget-object v3, p0, Lcom/google/firebase/installations/a;->b:Lng/c;

    .line 20
    .line 21
    iget-object v4, v3, Lng/c;->c:Lng/d;

    .line 22
    .line 23
    invoke-virtual {v4}, Lng/d;->b()Z

    .line 24
    .line 25
    .line 26
    move-result v5

    .line 27
    const-string v6, "Firebase Installations Service is unavailable. Please try again later."

    .line 28
    .line 29
    if-eqz v5, :cond_a

    .line 30
    .line 31
    new-instance v5, Ljava/lang/StringBuilder;

    .line 32
    .line 33
    const-string v7, "projects/"

    .line 34
    .line 35
    invoke-direct {v5, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 36
    .line 37
    .line 38
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 39
    .line 40
    .line 41
    const-string v7, "/installations/"

    .line 42
    .line 43
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 44
    .line 45
    .line 46
    iget-object v7, p1, Lmg/a;->a:Ljava/lang/String;

    .line 47
    .line 48
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 49
    .line 50
    .line 51
    const-string v7, "/authTokens:generate"

    .line 52
    .line 53
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 54
    .line 55
    .line 56
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 57
    .line 58
    .line 59
    move-result-object v5

    .line 60
    invoke-static {v5}, Lng/c;->a(Ljava/lang/String;)Ljava/net/URL;

    .line 61
    .line 62
    .line 63
    move-result-object v5

    .line 64
    const/4 v7, 0x0

    .line 65
    move v8, v7

    .line 66
    :goto_0
    const/4 v9, 0x1

    .line 67
    if-gt v8, v9, :cond_9

    .line 68
    .line 69
    const v10, 0x8003

    .line 70
    .line 71
    .line 72
    invoke-static {v10}, Landroid/net/TrafficStats;->setThreadStatsTag(I)V

    .line 73
    .line 74
    .line 75
    invoke-virtual {v3, v5, v1}, Lng/c;->c(Ljava/net/URL;Ljava/lang/String;)Ljava/net/HttpURLConnection;

    .line 76
    .line 77
    .line 78
    move-result-object v10

    .line 79
    :try_start_0
    const-string v11, "POST"

    .line 80
    .line 81
    invoke-virtual {v10, v11}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 82
    .line 83
    .line 84
    const-string v11, "Authorization"

    .line 85
    .line 86
    new-instance v12, Ljava/lang/StringBuilder;

    .line 87
    .line 88
    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    .line 89
    .line 90
    .line 91
    const-string v13, "FIS_v2 "

    .line 92
    .line 93
    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 94
    .line 95
    .line 96
    invoke-virtual {v12, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 97
    .line 98
    .line 99
    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 100
    .line 101
    .line 102
    move-result-object v12

    .line 103
    invoke-virtual {v10, v11, v12}, Ljava/net/URLConnection;->addRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 104
    .line 105
    .line 106
    invoke-virtual {v10, v9}, Ljava/net/URLConnection;->setDoOutput(Z)V

    .line 107
    .line 108
    .line 109
    invoke-static {v10}, Lng/c;->h(Ljava/net/HttpURLConnection;)V

    .line 110
    .line 111
    .line 112
    invoke-virtual {v10}, Ljava/net/HttpURLConnection;->getResponseCode()I

    .line 113
    .line 114
    .line 115
    move-result v11

    .line 116
    invoke-virtual {v4, v11}, Lng/d;->d(I)V

    .line 117
    .line 118
    .line 119
    const/16 v12, 0xc8

    .line 120
    .line 121
    if-lt v11, v12, :cond_0

    .line 122
    .line 123
    const/16 v12, 0x12c

    .line 124
    .line 125
    if-ge v11, v12, :cond_0

    .line 126
    .line 127
    move v12, v9

    .line 128
    goto :goto_1

    .line 129
    :cond_0
    move v12, v7

    .line 130
    :goto_1
    const/4 v13, 0x0

    .line 131
    if-eqz v12, :cond_1

    .line 132
    .line 133
    invoke-static {v10}, Lng/c;->f(Ljava/net/HttpURLConnection;)Lng/b;

    .line 134
    .line 135
    .line 136
    move-result-object v0
    :try_end_0
    .catch Ljava/lang/AssertionError; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 137
    :goto_2
    invoke-virtual {v10}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 138
    .line 139
    .line 140
    invoke-static {}, Landroid/net/TrafficStats;->clearThreadStatsTag()V

    .line 141
    .line 142
    .line 143
    goto :goto_4

    .line 144
    :cond_1
    :try_start_1
    invoke-static {v10, v13, v1, v0}, Lng/c;->b(Ljava/net/HttpURLConnection;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/AssertionError; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 145
    .line 146
    .line 147
    const/16 v12, 0x191

    .line 148
    .line 149
    if-eq v11, v12, :cond_5

    .line 150
    .line 151
    const/16 v12, 0x194

    .line 152
    .line 153
    if-ne v11, v12, :cond_2

    .line 154
    .line 155
    goto :goto_3

    .line 156
    :cond_2
    const/16 v12, 0x1ad

    .line 157
    .line 158
    if-eq v11, v12, :cond_4

    .line 159
    .line 160
    const/16 v12, 0x1f4

    .line 161
    .line 162
    if-lt v11, v12, :cond_3

    .line 163
    .line 164
    const/16 v12, 0x258

    .line 165
    .line 166
    if-ge v11, v12, :cond_3

    .line 167
    .line 168
    :catch_0
    invoke-virtual {v10}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 169
    .line 170
    .line 171
    invoke-static {}, Landroid/net/TrafficStats;->clearThreadStatsTag()V

    .line 172
    .line 173
    .line 174
    goto/16 :goto_6

    .line 175
    .line 176
    :cond_3
    :try_start_2
    const-string v11, "Firebase-Installations"

    .line 177
    .line 178
    const-string v12, "Firebase Installations can not communicate with Firebase server APIs due to invalid configuration. Please update your Firebase initialization process and set valid Firebase options (API key, Project ID, Application ID) when initializing Firebase."

    .line 179
    .line 180
    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 181
    .line 182
    .line 183
    invoke-static {}, Lng/b;->a()Lcom/facebook/applinks/b;

    .line 184
    .line 185
    .line 186
    move-result-object v11

    .line 187
    sget-object v12, Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;->BAD_CONFIG:Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;

    .line 188
    .line 189
    iput-object v12, v11, Lcom/facebook/applinks/b;->c:Ljava/lang/Object;

    .line 190
    .line 191
    invoke-virtual {v11}, Lcom/facebook/applinks/b;->c()Lng/b;

    .line 192
    .line 193
    .line 194
    move-result-object v0

    .line 195
    goto :goto_2

    .line 196
    :catchall_0
    move-exception p1

    .line 197
    goto/16 :goto_5

    .line 198
    .line 199
    :cond_4
    new-instance v9, Lcom/google/firebase/installations/FirebaseInstallationsException;

    .line 200
    .line 201
    const-string v11, "Firebase servers have received too many requests from this client in a short period of time. Please try again later."

    .line 202
    .line 203
    sget-object v12, Lcom/google/firebase/installations/FirebaseInstallationsException$Status;->TOO_MANY_REQUESTS:Lcom/google/firebase/installations/FirebaseInstallationsException$Status;

    .line 204
    .line 205
    invoke-direct {v9, v11, v12}, Lcom/google/firebase/installations/FirebaseInstallationsException;-><init>(Ljava/lang/String;Lcom/google/firebase/installations/FirebaseInstallationsException$Status;)V

    .line 206
    .line 207
    .line 208
    throw v9

    .line 209
    :cond_5
    :goto_3
    invoke-static {}, Lng/b;->a()Lcom/facebook/applinks/b;

    .line 210
    .line 211
    .line 212
    move-result-object v11

    .line 213
    sget-object v12, Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;->AUTH_ERROR:Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;

    .line 214
    .line 215
    iput-object v12, v11, Lcom/facebook/applinks/b;->c:Ljava/lang/Object;

    .line 216
    .line 217
    invoke-virtual {v11}, Lcom/facebook/applinks/b;->c()Lng/b;

    .line 218
    .line 219
    .line 220
    move-result-object v0
    :try_end_2
    .catch Ljava/lang/AssertionError; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 221
    goto :goto_2

    .line 222
    :goto_4
    sget-object v1, Llg/c;->b:[I

    .line 223
    .line 224
    iget-object v2, v0, Lng/b;->c:Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;

    .line 225
    .line 226
    invoke-virtual {v2}, Ljava/lang/Enum;->ordinal()I

    .line 227
    .line 228
    .line 229
    move-result v2

    .line 230
    aget v1, v1, v2

    .line 231
    .line 232
    if-eq v1, v9, :cond_8

    .line 233
    .line 234
    const/4 v0, 0x2

    .line 235
    if-eq v1, v0, :cond_7

    .line 236
    .line 237
    const/4 v0, 0x3

    .line 238
    if-ne v1, v0, :cond_6

    .line 239
    .line 240
    invoke-virtual {p0, v13}, Lcom/google/firebase/installations/a;->l(Ljava/lang/String;)V

    .line 241
    .line 242
    .line 243
    invoke-virtual {p1}, Lmg/a;->a()Lvf/c;

    .line 244
    .line 245
    .line 246
    move-result-object p1

    .line 247
    sget-object v0, Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;->NOT_GENERATED:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 248
    .line 249
    invoke-virtual {p1, v0}, Lvf/c;->n(Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;)V

    .line 250
    .line 251
    .line 252
    invoke-virtual {p1}, Lvf/c;->c()Lmg/a;

    .line 253
    .line 254
    .line 255
    move-result-object p1

    .line 256
    return-object p1

    .line 257
    :cond_6
    new-instance p1, Lcom/google/firebase/installations/FirebaseInstallationsException;

    .line 258
    .line 259
    sget-object v0, Lcom/google/firebase/installations/FirebaseInstallationsException$Status;->UNAVAILABLE:Lcom/google/firebase/installations/FirebaseInstallationsException$Status;

    .line 260
    .line 261
    invoke-direct {p1, v6, v0}, Lcom/google/firebase/installations/FirebaseInstallationsException;-><init>(Ljava/lang/String;Lcom/google/firebase/installations/FirebaseInstallationsException$Status;)V

    .line 262
    .line 263
    .line 264
    throw p1

    .line 265
    :cond_7
    invoke-virtual {p1}, Lmg/a;->a()Lvf/c;

    .line 266
    .line 267
    .line 268
    move-result-object p1

    .line 269
    const-string v0, "BAD CONFIG"

    .line 270
    .line 271
    iput-object v0, p1, Lvf/c;->g:Ljava/lang/Object;

    .line 272
    .line 273
    sget-object v0, Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;->REGISTER_ERROR:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 274
    .line 275
    invoke-virtual {p1, v0}, Lvf/c;->n(Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;)V

    .line 276
    .line 277
    .line 278
    invoke-virtual {p1}, Lvf/c;->c()Lmg/a;

    .line 279
    .line 280
    .line 281
    move-result-object p1

    .line 282
    return-object p1

    .line 283
    :cond_8
    iget-object v1, p0, Lcom/google/firebase/installations/a;->d:Llg/i;

    .line 284
    .line 285
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 286
    .line 287
    .line 288
    sget-object v2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    .line 289
    .line 290
    iget-object v1, v1, Llg/i;->a:Ll3/c;

    .line 291
    .line 292
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 293
    .line 294
    .line 295
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 296
    .line 297
    .line 298
    move-result-wide v3

    .line 299
    invoke-virtual {v2, v3, v4}, Ljava/util/concurrent/TimeUnit;->toSeconds(J)J

    .line 300
    .line 301
    .line 302
    move-result-wide v1

    .line 303
    invoke-virtual {p1}, Lmg/a;->a()Lvf/c;

    .line 304
    .line 305
    .line 306
    move-result-object p1

    .line 307
    iget-object v3, v0, Lng/b;->a:Ljava/lang/String;

    .line 308
    .line 309
    iput-object v3, p1, Lvf/c;->c:Ljava/lang/Object;

    .line 310
    .line 311
    iget-wide v3, v0, Lng/b;->b:J

    .line 312
    .line 313
    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    .line 314
    .line 315
    .line 316
    move-result-object v0

    .line 317
    iput-object v0, p1, Lvf/c;->e:Ljava/lang/Object;

    .line 318
    .line 319
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    .line 320
    .line 321
    .line 322
    move-result-object v0

    .line 323
    iput-object v0, p1, Lvf/c;->f:Ljava/lang/Object;

    .line 324
    .line 325
    invoke-virtual {p1}, Lvf/c;->c()Lmg/a;

    .line 326
    .line 327
    .line 328
    move-result-object p1

    .line 329
    return-object p1

    .line 330
    :goto_5
    invoke-virtual {v10}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 331
    .line 332
    .line 333
    invoke-static {}, Landroid/net/TrafficStats;->clearThreadStatsTag()V

    .line 334
    .line 335
    .line 336
    throw p1

    .line 337
    :goto_6
    add-int/lit8 v8, v8, 0x1

    .line 338
    .line 339
    goto/16 :goto_0

    .line 340
    .line 341
    :cond_9
    new-instance p1, Lcom/google/firebase/installations/FirebaseInstallationsException;

    .line 342
    .line 343
    sget-object v0, Lcom/google/firebase/installations/FirebaseInstallationsException$Status;->UNAVAILABLE:Lcom/google/firebase/installations/FirebaseInstallationsException$Status;

    .line 344
    .line 345
    invoke-direct {p1, v6, v0}, Lcom/google/firebase/installations/FirebaseInstallationsException;-><init>(Ljava/lang/String;Lcom/google/firebase/installations/FirebaseInstallationsException$Status;)V

    .line 346
    .line 347
    .line 348
    throw p1

    .line 349
    :cond_a
    new-instance p1, Lcom/google/firebase/installations/FirebaseInstallationsException;

    .line 350
    .line 351
    sget-object v0, Lcom/google/firebase/installations/FirebaseInstallationsException$Status;->UNAVAILABLE:Lcom/google/firebase/installations/FirebaseInstallationsException$Status;

    .line 352
    .line 353
    invoke-direct {p1, v6, v0}, Lcom/google/firebase/installations/FirebaseInstallationsException;-><init>(Ljava/lang/String;Lcom/google/firebase/installations/FirebaseInstallationsException$Status;)V

    .line 354
    .line 355
    .line 356
    throw p1
.end method

.method public final d()Lcom/google/android/gms/tasks/Task;
    .locals 4

    .line 1
    invoke-virtual {p0}, Lcom/google/firebase/installations/a;->g()V

    .line 2
    .line 3
    .line 4
    monitor-enter p0

    .line 5
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/installations/a;->j:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 6
    .line 7
    monitor-exit p0

    .line 8
    if-eqz v0, :cond_0

    .line 9
    .line 10
    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    .line 11
    .line 12
    .line 13
    move-result-object v0

    .line 14
    return-object v0

    .line 15
    :cond_0
    new-instance v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 16
    .line 17
    invoke-direct {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    .line 18
    .line 19
    .line 20
    new-instance v1, Llg/f;

    .line 21
    .line 22
    invoke-direct {v1, v0}, Llg/f;-><init>(Lcom/google/android/gms/tasks/TaskCompletionSource;)V

    .line 23
    .line 24
    .line 25
    invoke-virtual {p0, v1}, Lcom/google/firebase/installations/a;->a(Llg/h;)V

    .line 26
    .line 27
    .line 28
    invoke-virtual {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    .line 29
    .line 30
    .line 31
    move-result-object v0

    .line 32
    iget-object v1, p0, Lcom/google/firebase/installations/a;->h:Ljava/util/concurrent/ExecutorService;

    .line 33
    .line 34
    new-instance v2, Llg/b;

    .line 35
    .line 36
    const/4 v3, 0x0

    .line 37
    invoke-direct {v2, p0, v3}, Llg/b;-><init>(Lcom/google/firebase/installations/a;I)V

    .line 38
    .line 39
    .line 40
    invoke-interface {v1, v2}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 41
    .line 42
    .line 43
    return-object v0

    .line 44
    :catchall_0
    move-exception v0

    .line 45
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 46
    throw v0
.end method

.method public final e()Lcom/google/android/gms/tasks/Task;
    .locals 3

    .line 1
    invoke-virtual {p0}, Lcom/google/firebase/installations/a;->g()V

    .line 2
    .line 3
    .line 4
    new-instance v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 5
    .line 6
    invoke-direct {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    .line 7
    .line 8
    .line 9
    new-instance v1, Llg/e;

    .line 10
    .line 11
    iget-object v2, p0, Lcom/google/firebase/installations/a;->d:Llg/i;

    .line 12
    .line 13
    invoke-direct {v1, v2, v0}, Llg/e;-><init>(Llg/i;Lcom/google/android/gms/tasks/TaskCompletionSource;)V

    .line 14
    .line 15
    .line 16
    invoke-virtual {p0, v1}, Lcom/google/firebase/installations/a;->a(Llg/h;)V

    .line 17
    .line 18
    .line 19
    invoke-virtual {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    .line 20
    .line 21
    .line 22
    move-result-object v0

    .line 23
    new-instance v1, Llg/b;

    .line 24
    .line 25
    const/4 v2, 0x1

    .line 26
    invoke-direct {v1, p0, v2}, Llg/b;-><init>(Lcom/google/firebase/installations/a;I)V

    .line 27
    .line 28
    .line 29
    iget-object v2, p0, Lcom/google/firebase/installations/a;->h:Ljava/util/concurrent/ExecutorService;

    .line 30
    .line 31
    invoke-interface {v2, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 32
    .line 33
    .line 34
    return-object v0
.end method

.method public final f(Lmg/a;)V
    .locals 3

    .line 1
    sget-object v0, Lcom/google/firebase/installations/a;->m:Ljava/lang/Object;

    .line 2
    .line 3
    monitor-enter v0

    .line 4
    :try_start_0
    iget-object v1, p0, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 5
    .line 6
    invoke-virtual {v1}, Lef/h;->a()V

    .line 7
    .line 8
    .line 9
    iget-object v1, v1, Lef/h;->a:Landroid/content/Context;

    .line 10
    .line 11
    invoke-static {v1}, Landroidx/work/impl/model/l;->e(Landroid/content/Context;)Landroidx/work/impl/model/l;

    .line 12
    .line 13
    .line 14
    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 15
    :try_start_1
    iget-object v2, p0, Lcom/google/firebase/installations/a;->c:Landroidx/work/impl/model/e;

    .line 16
    .line 17
    invoke-virtual {v2, p1}, Landroidx/work/impl/model/e;->p(Lmg/a;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 18
    .line 19
    .line 20
    if-eqz v1, :cond_0

    .line 21
    .line 22
    :try_start_2
    invoke-virtual {v1}, Landroidx/work/impl/model/l;->o()V

    .line 23
    .line 24
    .line 25
    goto :goto_0

    .line 26
    :catchall_0
    move-exception p1

    .line 27
    goto :goto_1

    .line 28
    :cond_0
    :goto_0
    monitor-exit v0

    .line 29
    return-void

    .line 30
    :catchall_1
    move-exception p1

    .line 31
    if-eqz v1, :cond_1

    .line 32
    .line 33
    invoke-virtual {v1}, Landroidx/work/impl/model/l;->o()V

    .line 34
    .line 35
    .line 36
    :cond_1
    throw p1

    .line 37
    :goto_1
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 38
    throw p1
.end method

.method public final g()V
    .locals 5

    .line 1
    iget-object v0, p0, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 2
    .line 3
    invoke-virtual {v0}, Lef/h;->a()V

    .line 4
    .line 5
    .line 6
    iget-object v1, v0, Lef/h;->c:Lef/j;

    .line 7
    .line 8
    iget-object v1, v1, Lef/j;->b:Ljava/lang/String;

    .line 9
    .line 10
    const-string v2, "Please set your Application ID. A valid Firebase App ID is required to communicate with Firebase server APIs: It identifies your application with Firebase.Please refer to https://firebase.google.com/support/privacy/init-options."

    .line 11
    .line 12
    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    .line 13
    .line 14
    .line 15
    invoke-virtual {v0}, Lef/h;->a()V

    .line 16
    .line 17
    .line 18
    iget-object v1, v0, Lef/h;->c:Lef/j;

    .line 19
    .line 20
    iget-object v1, v1, Lef/j;->g:Ljava/lang/String;

    .line 21
    .line 22
    const-string v3, "Please set your Project ID. A valid Firebase Project ID is required to communicate with Firebase server APIs: It identifies your application with Firebase.Please refer to https://firebase.google.com/support/privacy/init-options."

    .line 23
    .line 24
    invoke-static {v1, v3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    .line 25
    .line 26
    .line 27
    invoke-virtual {v0}, Lef/h;->a()V

    .line 28
    .line 29
    .line 30
    iget-object v1, v0, Lef/h;->c:Lef/j;

    .line 31
    .line 32
    iget-object v1, v1, Lef/j;->a:Ljava/lang/String;

    .line 33
    .line 34
    const-string v3, "Please set a valid API key. A Firebase API key is required to communicate with Firebase server APIs: It authenticates your project with Google.Please refer to https://firebase.google.com/support/privacy/init-options."

    .line 35
    .line 36
    invoke-static {v1, v3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    .line 37
    .line 38
    .line 39
    invoke-virtual {v0}, Lef/h;->a()V

    .line 40
    .line 41
    .line 42
    iget-object v1, v0, Lef/h;->c:Lef/j;

    .line 43
    .line 44
    iget-object v1, v1, Lef/j;->b:Ljava/lang/String;

    .line 45
    .line 46
    sget-object v4, Llg/i;->c:Ljava/util/regex/Pattern;

    .line 47
    .line 48
    const-string v4, ":"

    .line 49
    .line 50
    invoke-virtual {v1, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    .line 51
    .line 52
    .line 53
    move-result v1

    .line 54
    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Preconditions;->checkArgument(ZLjava/lang/Object;)V

    .line 55
    .line 56
    .line 57
    invoke-virtual {v0}, Lef/h;->a()V

    .line 58
    .line 59
    .line 60
    iget-object v0, v0, Lef/h;->c:Lef/j;

    .line 61
    .line 62
    iget-object v0, v0, Lef/j;->a:Ljava/lang/String;

    .line 63
    .line 64
    sget-object v1, Llg/i;->c:Ljava/util/regex/Pattern;

    .line 65
    .line 66
    invoke-virtual {v1, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    .line 67
    .line 68
    .line 69
    move-result-object v0

    .line 70
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    .line 71
    .line 72
    .line 73
    move-result v0

    .line 74
    invoke-static {v0, v3}, Lcom/google/android/gms/common/internal/Preconditions;->checkArgument(ZLjava/lang/Object;)V

    .line 75
    .line 76
    .line 77
    return-void
.end method

.method public final h(Lmg/a;)Ljava/lang/String;
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 2
    .line 3
    invoke-virtual {v0}, Lef/h;->a()V

    .line 4
    .line 5
    .line 6
    iget-object v0, v0, Lef/h;->b:Ljava/lang/String;

    .line 7
    .line 8
    const-string v1, "CHIME_ANDROID_SDK"

    .line 9
    .line 10
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 11
    .line 12
    .line 13
    move-result v0

    .line 14
    if-nez v0, :cond_0

    .line 15
    .line 16
    iget-object v0, p0, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 17
    .line 18
    invoke-virtual {v0}, Lef/h;->a()V

    .line 19
    .line 20
    .line 21
    const-string v1, "[DEFAULT]"

    .line 22
    .line 23
    iget-object v0, v0, Lef/h;->b:Ljava/lang/String;

    .line 24
    .line 25
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 26
    .line 27
    .line 28
    move-result v0

    .line 29
    if-eqz v0, :cond_3

    .line 30
    .line 31
    :cond_0
    sget-object v0, Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;->ATTEMPT_MIGRATION:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 32
    .line 33
    iget-object p1, p1, Lmg/a;->b:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 34
    .line 35
    if-ne p1, v0, :cond_3

    .line 36
    .line 37
    iget-object p1, p0, Lcom/google/firebase/installations/a;->e:Ljf/k;

    .line 38
    .line 39
    invoke-virtual {p1}, Ljf/k;->get()Ljava/lang/Object;

    .line 40
    .line 41
    .line 42
    move-result-object p1

    .line 43
    check-cast p1, Lmg/b;

    .line 44
    .line 45
    iget-object v0, p1, Lmg/b;->a:Landroid/content/SharedPreferences;

    .line 46
    .line 47
    monitor-enter v0

    .line 48
    :try_start_0
    invoke-virtual {p1}, Lmg/b;->a()Ljava/lang/String;

    .line 49
    .line 50
    .line 51
    move-result-object v1

    .line 52
    if-eqz v1, :cond_1

    .line 53
    .line 54
    monitor-exit v0

    .line 55
    goto :goto_0

    .line 56
    :catchall_0
    move-exception p1

    .line 57
    goto :goto_1

    .line 58
    :cond_1
    invoke-virtual {p1}, Lmg/b;->b()Ljava/lang/String;

    .line 59
    .line 60
    .line 61
    move-result-object v1

    .line 62
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 63
    :goto_0
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    .line 64
    .line 65
    .line 66
    move-result p1

    .line 67
    if-eqz p1, :cond_2

    .line 68
    .line 69
    iget-object p1, p0, Lcom/google/firebase/installations/a;->f:Llg/g;

    .line 70
    .line 71
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 72
    .line 73
    .line 74
    invoke-static {}, Llg/g;->a()Ljava/lang/String;

    .line 75
    .line 76
    .line 77
    move-result-object v1

    .line 78
    :cond_2
    return-object v1

    .line 79
    :goto_1
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 80
    throw p1

    .line 81
    :cond_3
    iget-object p1, p0, Lcom/google/firebase/installations/a;->f:Llg/g;

    .line 82
    .line 83
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 84
    .line 85
    .line 86
    invoke-static {}, Llg/g;->a()Ljava/lang/String;

    .line 87
    .line 88
    .line 89
    move-result-object p1

    .line 90
    return-object p1
.end method

.method public final i(Lmg/a;)Lmg/a;
    .locals 22

    .line 1
    move-object/from16 v1, p0

    .line 2
    .line 3
    move-object/from16 v0, p1

    .line 4
    .line 5
    iget-object v2, v0, Lmg/a;->a:Ljava/lang/String;

    .line 6
    .line 7
    const/4 v4, 0x0

    .line 8
    if-eqz v2, :cond_3

    .line 9
    .line 10
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    .line 11
    .line 12
    .line 13
    move-result v2

    .line 14
    const/16 v5, 0xb

    .line 15
    .line 16
    if-ne v2, v5, :cond_3

    .line 17
    .line 18
    iget-object v2, v1, Lcom/google/firebase/installations/a;->e:Ljf/k;

    .line 19
    .line 20
    invoke-virtual {v2}, Ljf/k;->get()Ljava/lang/Object;

    .line 21
    .line 22
    .line 23
    move-result-object v2

    .line 24
    check-cast v2, Lmg/b;

    .line 25
    .line 26
    iget-object v5, v2, Lmg/b;->a:Landroid/content/SharedPreferences;

    .line 27
    .line 28
    monitor-enter v5

    .line 29
    :try_start_0
    sget-object v6, Lmg/b;->c:[Ljava/lang/String;

    .line 30
    .line 31
    const/4 v7, 0x0

    .line 32
    :goto_0
    const/4 v8, 0x4

    .line 33
    if-ge v7, v8, :cond_2

    .line 34
    .line 35
    aget-object v8, v6, v7

    .line 36
    .line 37
    iget-object v9, v2, Lmg/b;->b:Ljava/lang/String;

    .line 38
    .line 39
    new-instance v10, Ljava/lang/StringBuilder;

    .line 40
    .line 41
    const-string v11, "|T|"

    .line 42
    .line 43
    invoke-direct {v10, v11}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 44
    .line 45
    .line 46
    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 47
    .line 48
    .line 49
    const-string v9, "|"

    .line 50
    .line 51
    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 52
    .line 53
    .line 54
    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 55
    .line 56
    .line 57
    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 58
    .line 59
    .line 60
    move-result-object v8

    .line 61
    iget-object v9, v2, Lmg/b;->a:Landroid/content/SharedPreferences;

    .line 62
    .line 63
    invoke-interface {v9, v8, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 64
    .line 65
    .line 66
    move-result-object v8

    .line 67
    if-eqz v8, :cond_1

    .line 68
    .line 69
    invoke-virtual {v8}, Ljava/lang/String;->isEmpty()Z

    .line 70
    .line 71
    .line 72
    move-result v9

    .line 73
    if-nez v9, :cond_1

    .line 74
    .line 75
    const-string v2, "{"

    .line 76
    .line 77
    invoke-virtual {v8, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    .line 78
    .line 79
    .line 80
    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 81
    if-eqz v2, :cond_0

    .line 82
    .line 83
    :try_start_1
    new-instance v2, Lorg/json/JSONObject;

    .line 84
    .line 85
    invoke-direct {v2, v8}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 86
    .line 87
    .line 88
    const-string v6, "token"

    .line 89
    .line 90
    invoke-virtual {v2, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    .line 91
    .line 92
    .line 93
    move-result-object v4
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 94
    goto :goto_1

    .line 95
    :cond_0
    move-object v4, v8

    .line 96
    :catch_0
    :goto_1
    :try_start_2
    monitor-exit v5

    .line 97
    goto :goto_3

    .line 98
    :catchall_0
    move-exception v0

    .line 99
    goto :goto_2

    .line 100
    :cond_1
    add-int/lit8 v7, v7, 0x1

    .line 101
    .line 102
    goto :goto_0

    .line 103
    :cond_2
    monitor-exit v5

    .line 104
    goto :goto_3

    .line 105
    :goto_2
    monitor-exit v5
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 106
    throw v0

    .line 107
    :cond_3
    :goto_3
    iget-object v2, v1, Lcom/google/firebase/installations/a;->b:Lng/c;

    .line 108
    .line 109
    iget-object v5, v1, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 110
    .line 111
    invoke-virtual {v5}, Lef/h;->a()V

    .line 112
    .line 113
    .line 114
    iget-object v5, v5, Lef/h;->c:Lef/j;

    .line 115
    .line 116
    iget-object v5, v5, Lef/j;->a:Ljava/lang/String;

    .line 117
    .line 118
    iget-object v6, v0, Lmg/a;->a:Ljava/lang/String;

    .line 119
    .line 120
    iget-object v7, v1, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 121
    .line 122
    invoke-virtual {v7}, Lef/h;->a()V

    .line 123
    .line 124
    .line 125
    iget-object v7, v7, Lef/h;->c:Lef/j;

    .line 126
    .line 127
    iget-object v7, v7, Lef/j;->g:Ljava/lang/String;

    .line 128
    .line 129
    iget-object v8, v1, Lcom/google/firebase/installations/a;->a:Lef/h;

    .line 130
    .line 131
    invoke-virtual {v8}, Lef/h;->a()V

    .line 132
    .line 133
    .line 134
    iget-object v8, v8, Lef/h;->c:Lef/j;

    .line 135
    .line 136
    iget-object v8, v8, Lef/j;->b:Ljava/lang/String;

    .line 137
    .line 138
    iget-object v9, v2, Lng/c;->c:Lng/d;

    .line 139
    .line 140
    invoke-virtual {v9}, Lng/d;->b()Z

    .line 141
    .line 142
    .line 143
    move-result v10

    .line 144
    const-string v11, "Firebase Installations Service is unavailable. Please try again later."

    .line 145
    .line 146
    if-eqz v10, :cond_c

    .line 147
    .line 148
    new-instance v10, Ljava/lang/StringBuilder;

    .line 149
    .line 150
    const-string v12, "projects/"

    .line 151
    .line 152
    invoke-direct {v10, v12}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 153
    .line 154
    .line 155
    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 156
    .line 157
    .line 158
    const-string v12, "/installations"

    .line 159
    .line 160
    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 161
    .line 162
    .line 163
    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 164
    .line 165
    .line 166
    move-result-object v10

    .line 167
    invoke-static {v10}, Lng/c;->a(Ljava/lang/String;)Ljava/net/URL;

    .line 168
    .line 169
    .line 170
    move-result-object v10

    .line 171
    const/4 v12, 0x0

    .line 172
    :goto_4
    const/4 v13, 0x1

    .line 173
    if-gt v12, v13, :cond_b

    .line 174
    .line 175
    const v14, 0x8001

    .line 176
    .line 177
    .line 178
    invoke-static {v14}, Landroid/net/TrafficStats;->setThreadStatsTag(I)V

    .line 179
    .line 180
    .line 181
    invoke-virtual {v2, v10, v5}, Lng/c;->c(Ljava/net/URL;Ljava/lang/String;)Ljava/net/HttpURLConnection;

    .line 182
    .line 183
    .line 184
    move-result-object v14

    .line 185
    :try_start_3
    const-string v15, "POST"

    .line 186
    .line 187
    invoke-virtual {v14, v15}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 188
    .line 189
    .line 190
    invoke-virtual {v14, v13}, Ljava/net/URLConnection;->setDoOutput(Z)V

    .line 191
    .line 192
    .line 193
    if-eqz v4, :cond_4

    .line 194
    .line 195
    const-string v15, "x-goog-fis-android-iid-migration-auth"

    .line 196
    .line 197
    invoke-virtual {v14, v15, v4}, Ljava/net/URLConnection;->addRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 198
    .line 199
    .line 200
    goto :goto_5

    .line 201
    :catchall_1
    move-exception v0

    .line 202
    goto/16 :goto_8

    .line 203
    .line 204
    :cond_4
    :goto_5
    invoke-static {v14, v6, v8}, Lng/c;->g(Ljava/net/HttpURLConnection;Ljava/lang/String;Ljava/lang/String;)V

    .line 205
    .line 206
    .line 207
    invoke-virtual {v14}, Ljava/net/HttpURLConnection;->getResponseCode()I

    .line 208
    .line 209
    .line 210
    move-result v15

    .line 211
    invoke-virtual {v9, v15}, Lng/d;->d(I)V

    .line 212
    .line 213
    .line 214
    const/16 v3, 0xc8

    .line 215
    .line 216
    if-lt v15, v3, :cond_5

    .line 217
    .line 218
    const/16 v3, 0x12c

    .line 219
    .line 220
    if-ge v15, v3, :cond_5

    .line 221
    .line 222
    move v3, v13

    .line 223
    goto :goto_6

    .line 224
    :cond_5
    const/4 v3, 0x0

    .line 225
    :goto_6
    if-eqz v3, :cond_6

    .line 226
    .line 227
    invoke-static {v14}, Lng/c;->e(Ljava/net/HttpURLConnection;)Lng/a;

    .line 228
    .line 229
    .line 230
    move-result-object v2
    :try_end_3
    .catch Ljava/lang/AssertionError; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 231
    invoke-virtual {v14}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 232
    .line 233
    .line 234
    invoke-static {}, Landroid/net/TrafficStats;->clearThreadStatsTag()V

    .line 235
    .line 236
    .line 237
    goto :goto_7

    .line 238
    :cond_6
    :try_start_4
    invoke-static {v14, v8, v5, v7}, Lng/c;->b(Ljava/net/HttpURLConnection;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/lang/AssertionError; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 239
    .line 240
    .line 241
    const/16 v3, 0x1ad

    .line 242
    .line 243
    if-eq v15, v3, :cond_a

    .line 244
    .line 245
    const/16 v3, 0x1f4

    .line 246
    .line 247
    if-lt v15, v3, :cond_7

    .line 248
    .line 249
    const/16 v3, 0x258

    .line 250
    .line 251
    if-ge v15, v3, :cond_7

    .line 252
    .line 253
    :catch_1
    invoke-virtual {v14}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 254
    .line 255
    .line 256
    invoke-static {}, Landroid/net/TrafficStats;->clearThreadStatsTag()V

    .line 257
    .line 258
    .line 259
    goto/16 :goto_9

    .line 260
    .line 261
    :cond_7
    :try_start_5
    const-string v3, "Firebase-Installations"

    .line 262
    .line 263
    const-string v15, "Firebase Installations can not communicate with Firebase server APIs due to invalid configuration. Please update your Firebase initialization process and set valid Firebase options (API key, Project ID, Application ID) when initializing Firebase."

    .line 264
    .line 265
    invoke-static {v3, v15}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 266
    .line 267
    .line 268
    sget-object v21, Lcom/google/firebase/installations/remote/InstallationResponse$ResponseCode;->BAD_CONFIG:Lcom/google/firebase/installations/remote/InstallationResponse$ResponseCode;

    .line 269
    .line 270
    new-instance v3, Lng/a;

    .line 271
    .line 272
    const/16 v20, 0x0

    .line 273
    .line 274
    const/16 v19, 0x0

    .line 275
    .line 276
    const/16 v18, 0x0

    .line 277
    .line 278
    const/16 v17, 0x0

    .line 279
    .line 280
    move-object/from16 v16, v3

    .line 281
    .line 282
    invoke-direct/range {v16 .. v21}, Lng/a;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lng/b;Lcom/google/firebase/installations/remote/InstallationResponse$ResponseCode;)V
    :try_end_5
    .catch Ljava/lang/AssertionError; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 283
    .line 284
    .line 285
    invoke-virtual {v14}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 286
    .line 287
    .line 288
    invoke-static {}, Landroid/net/TrafficStats;->clearThreadStatsTag()V

    .line 289
    .line 290
    .line 291
    move-object v2, v3

    .line 292
    :goto_7
    sget-object v3, Llg/c;->a:[I

    .line 293
    .line 294
    iget-object v4, v2, Lng/a;->e:Lcom/google/firebase/installations/remote/InstallationResponse$ResponseCode;

    .line 295
    .line 296
    invoke-virtual {v4}, Ljava/lang/Enum;->ordinal()I

    .line 297
    .line 298
    .line 299
    move-result v4

    .line 300
    aget v3, v3, v4

    .line 301
    .line 302
    if-eq v3, v13, :cond_9

    .line 303
    .line 304
    const/4 v2, 0x2

    .line 305
    if-ne v3, v2, :cond_8

    .line 306
    .line 307
    invoke-virtual/range {p1 .. p1}, Lmg/a;->a()Lvf/c;

    .line 308
    .line 309
    .line 310
    move-result-object v0

    .line 311
    const-string v2, "BAD CONFIG"

    .line 312
    .line 313
    iput-object v2, v0, Lvf/c;->g:Ljava/lang/Object;

    .line 314
    .line 315
    sget-object v2, Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;->REGISTER_ERROR:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 316
    .line 317
    invoke-virtual {v0, v2}, Lvf/c;->n(Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;)V

    .line 318
    .line 319
    .line 320
    invoke-virtual {v0}, Lvf/c;->c()Lmg/a;

    .line 321
    .line 322
    .line 323
    move-result-object v0

    .line 324
    return-object v0

    .line 325
    :cond_8
    new-instance v0, Lcom/google/firebase/installations/FirebaseInstallationsException;

    .line 326
    .line 327
    const-string v2, "Firebase Installations Service is unavailable. Please try again later."

    .line 328
    .line 329
    sget-object v3, Lcom/google/firebase/installations/FirebaseInstallationsException$Status;->UNAVAILABLE:Lcom/google/firebase/installations/FirebaseInstallationsException$Status;

    .line 330
    .line 331
    invoke-direct {v0, v2, v3}, Lcom/google/firebase/installations/FirebaseInstallationsException;-><init>(Ljava/lang/String;Lcom/google/firebase/installations/FirebaseInstallationsException$Status;)V

    .line 332
    .line 333
    .line 334
    throw v0

    .line 335
    :cond_9
    iget-object v3, v2, Lng/a;->b:Ljava/lang/String;

    .line 336
    .line 337
    iget-object v4, v2, Lng/a;->c:Ljava/lang/String;

    .line 338
    .line 339
    iget-object v5, v1, Lcom/google/firebase/installations/a;->d:Llg/i;

    .line 340
    .line 341
    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 342
    .line 343
    .line 344
    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    .line 345
    .line 346
    iget-object v5, v5, Llg/i;->a:Ll3/c;

    .line 347
    .line 348
    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 349
    .line 350
    .line 351
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 352
    .line 353
    .line 354
    move-result-wide v7

    .line 355
    invoke-virtual {v6, v7, v8}, Ljava/util/concurrent/TimeUnit;->toSeconds(J)J

    .line 356
    .line 357
    .line 358
    move-result-wide v5

    .line 359
    iget-object v2, v2, Lng/a;->d:Lng/b;

    .line 360
    .line 361
    iget-object v7, v2, Lng/b;->a:Ljava/lang/String;

    .line 362
    .line 363
    iget-wide v8, v2, Lng/b;->b:J

    .line 364
    .line 365
    invoke-virtual/range {p1 .. p1}, Lmg/a;->a()Lvf/c;

    .line 366
    .line 367
    .line 368
    move-result-object v0

    .line 369
    iput-object v3, v0, Lvf/c;->a:Ljava/lang/Object;

    .line 370
    .line 371
    sget-object v2, Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;->REGISTERED:Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;

    .line 372
    .line 373
    invoke-virtual {v0, v2}, Lvf/c;->n(Lcom/google/firebase/installations/local/PersistedInstallation$RegistrationStatus;)V

    .line 374
    .line 375
    .line 376
    iput-object v7, v0, Lvf/c;->c:Ljava/lang/Object;

    .line 377
    .line 378
    iput-object v4, v0, Lvf/c;->d:Ljava/lang/Object;

    .line 379
    .line 380
    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    .line 381
    .line 382
    .line 383
    move-result-object v2

    .line 384
    iput-object v2, v0, Lvf/c;->e:Ljava/lang/Object;

    .line 385
    .line 386
    invoke-static {v5, v6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    .line 387
    .line 388
    .line 389
    move-result-object v2

    .line 390
    iput-object v2, v0, Lvf/c;->f:Ljava/lang/Object;

    .line 391
    .line 392
    invoke-virtual {v0}, Lvf/c;->c()Lmg/a;

    .line 393
    .line 394
    .line 395
    move-result-object v0

    .line 396
    return-object v0

    .line 397
    :cond_a
    :try_start_6
    new-instance v3, Lcom/google/firebase/installations/FirebaseInstallationsException;

    .line 398
    .line 399
    const-string v13, "Firebase servers have received too many requests from this client in a short period of time. Please try again later."

    .line 400
    .line 401
    sget-object v15, Lcom/google/firebase/installations/FirebaseInstallationsException$Status;->TOO_MANY_REQUESTS:Lcom/google/firebase/installations/FirebaseInstallationsException$Status;

    .line 402
    .line 403
    invoke-direct {v3, v13, v15}, Lcom/google/firebase/installations/FirebaseInstallationsException;-><init>(Ljava/lang/String;Lcom/google/firebase/installations/FirebaseInstallationsException$Status;)V

    .line 404
    .line 405
    .line 406
    throw v3
    :try_end_6
    .catch Ljava/lang/AssertionError; {:try_start_6 .. :try_end_6} :catch_1
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 407
    :goto_8
    invoke-virtual {v14}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 408
    .line 409
    .line 410
    invoke-static {}, Landroid/net/TrafficStats;->clearThreadStatsTag()V

    .line 411
    .line 412
    .line 413
    throw v0

    .line 414
    :goto_9
    add-int/lit8 v12, v12, 0x1

    .line 415
    .line 416
    goto/16 :goto_4

    .line 417
    .line 418
    :cond_b
    new-instance v0, Lcom/google/firebase/installations/FirebaseInstallationsException;

    .line 419
    .line 420
    sget-object v2, Lcom/google/firebase/installations/FirebaseInstallationsException$Status;->UNAVAILABLE:Lcom/google/firebase/installations/FirebaseInstallationsException$Status;

    .line 421
    .line 422
    invoke-direct {v0, v11, v2}, Lcom/google/firebase/installations/FirebaseInstallationsException;-><init>(Ljava/lang/String;Lcom/google/firebase/installations/FirebaseInstallationsException$Status;)V

    .line 423
    .line 424
    .line 425
    throw v0

    .line 426
    :cond_c
    new-instance v0, Lcom/google/firebase/installations/FirebaseInstallationsException;

    .line 427
    .line 428
    sget-object v2, Lcom/google/firebase/installations/FirebaseInstallationsException$Status;->UNAVAILABLE:Lcom/google/firebase/installations/FirebaseInstallationsException$Status;

    .line 429
    .line 430
    invoke-direct {v0, v11, v2}, Lcom/google/firebase/installations/FirebaseInstallationsException;-><init>(Ljava/lang/String;Lcom/google/firebase/installations/FirebaseInstallationsException$Status;)V

    .line 431
    .line 432
    .line 433
    throw v0
.end method

.method public final j(Ljava/lang/Exception;)V
    .locals 3

    .line 1
    iget-object v0, p0, Lcom/google/firebase/installations/a;->g:Ljava/lang/Object;

    .line 2
    .line 3
    monitor-enter v0

    .line 4
    :try_start_0
    iget-object v1, p0, Lcom/google/firebase/installations/a;->l:Ljava/util/ArrayList;

    .line 5
    .line 6
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 7
    .line 8
    .line 9
    move-result-object v1

    .line 10
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    .line 11
    .line 12
    .line 13
    move-result v2

    .line 14
    if-eqz v2, :cond_1

    .line 15
    .line 16
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 17
    .line 18
    .line 19
    move-result-object v2

    .line 20
    check-cast v2, Llg/h;

    .line 21
    .line 22
    invoke-interface {v2, p1}, Llg/h;->a(Ljava/lang/Exception;)Z

    .line 23
    .line 24
    .line 25
    move-result v2

    .line 26
    if-eqz v2, :cond_0

    .line 27
    .line 28
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    .line 29
    .line 30
    .line 31
    goto :goto_0

    .line 32
    :catchall_0
    move-exception p1

    .line 33
    goto :goto_1

    .line 34
    :cond_1
    monitor-exit v0

    .line 35
    return-void

    .line 36
    :goto_1
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 37
    throw p1
.end method

.method public final k(Lmg/a;)V
    .locals 3

    .line 1
    iget-object v0, p0, Lcom/google/firebase/installations/a;->g:Ljava/lang/Object;

    .line 2
    .line 3
    monitor-enter v0

    .line 4
    :try_start_0
    iget-object v1, p0, Lcom/google/firebase/installations/a;->l:Ljava/util/ArrayList;

    .line 5
    .line 6
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 7
    .line 8
    .line 9
    move-result-object v1

    .line 10
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    .line 11
    .line 12
    .line 13
    move-result v2

    .line 14
    if-eqz v2, :cond_1

    .line 15
    .line 16
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 17
    .line 18
    .line 19
    move-result-object v2

    .line 20
    check-cast v2, Llg/h;

    .line 21
    .line 22
    invoke-interface {v2, p1}, Llg/h;->b(Lmg/a;)Z

    .line 23
    .line 24
    .line 25
    move-result v2

    .line 26
    if-eqz v2, :cond_0

    .line 27
    .line 28
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    .line 29
    .line 30
    .line 31
    goto :goto_0

    .line 32
    :catchall_0
    move-exception p1

    .line 33
    goto :goto_1

    .line 34
    :cond_1
    monitor-exit v0

    .line 35
    return-void

    .line 36
    :goto_1
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 37
    throw p1
.end method

.method public final declared-synchronized l(Ljava/lang/String;)V
    .locals 0

    .line 1
    monitor-enter p0

    .line 2
    :try_start_0
    iput-object p1, p0, Lcom/google/firebase/installations/a;->j:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3
    .line 4
    monitor-exit p0

    .line 5
    return-void

    .line 6
    :catchall_0
    move-exception p1

    .line 7
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 8
    throw p1
.end method

.method public final declared-synchronized m(Lmg/a;Lmg/a;)V
    .locals 1

    .line 1
    monitor-enter p0

    .line 2
    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/installations/a;->k:Ljava/util/HashSet;

    .line 3
    .line 4
    invoke-virtual {v0}, Ljava/util/HashSet;->size()I

    .line 5
    .line 6
    .line 7
    move-result v0

    .line 8
    if-eqz v0, :cond_2

    .line 9
    .line 10
    iget-object p1, p1, Lmg/a;->a:Ljava/lang/String;

    .line 11
    .line 12
    iget-object p2, p2, Lmg/a;->a:Ljava/lang/String;

    .line 13
    .line 14
    invoke-static {p1, p2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    .line 15
    .line 16
    .line 17
    move-result p1

    .line 18
    if-nez p1, :cond_2

    .line 19
    .line 20
    iget-object p1, p0, Lcom/google/firebase/installations/a;->k:Ljava/util/HashSet;

    .line 21
    .line 22
    invoke-virtual {p1}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    .line 23
    .line 24
    .line 25
    move-result-object p1

    .line 26
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    .line 27
    .line 28
    .line 29
    move-result p2

    .line 30
    if-nez p2, :cond_0

    .line 31
    .line 32
    goto :goto_0

    .line 33
    :cond_0
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 34
    .line 35
    .line 36
    move-result-object p1

    .line 37
    if-nez p1, :cond_1

    .line 38
    .line 39
    const/4 p1, 0x0

    .line 40
    throw p1

    .line 41
    :catchall_0
    move-exception p1

    .line 42
    goto :goto_1

    .line 43
    :cond_1
    new-instance p1, Ljava/lang/ClassCastException;

    .line 44
    .line 45
    invoke-direct {p1}, Ljava/lang/ClassCastException;-><init>()V

    .line 46
    .line 47
    .line 48
    throw p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 49
    :cond_2
    :goto_0
    monitor-exit p0

    .line 50
    return-void

    .line 51
    :goto_1
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 52
    throw p1
.end method
