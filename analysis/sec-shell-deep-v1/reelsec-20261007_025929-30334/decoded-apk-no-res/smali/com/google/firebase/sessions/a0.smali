.class public final Lcom/google/firebase/sessions/a0;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Lcom/google/firebase/sessions/a0;

.field public static final b:Landroidx/appcompat/widget/w0;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/a0;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/sessions/a0;->a:Lcom/google/firebase/sessions/a0;

    .line 7
    .line 8
    new-instance v0, Lfg/d;

    .line 9
    .line 10
    invoke-direct {v0}, Lfg/d;-><init>()V

    .line 11
    .line 12
    .line 13
    sget-object v1, Lcom/google/firebase/sessions/g;->a:Lcom/google/firebase/sessions/g;

    .line 14
    .line 15
    const-class v2, Lcom/google/firebase/sessions/z;

    .line 16
    .line 17
    invoke-virtual {v0, v2, v1}, Lfg/d;->a(Ljava/lang/Class;Ldg/c;)Leg/a;

    .line 18
    .line 19
    .line 20
    sget-object v1, Lcom/google/firebase/sessions/h;->a:Lcom/google/firebase/sessions/h;

    .line 21
    .line 22
    const-class v2, Lcom/google/firebase/sessions/e0;

    .line 23
    .line 24
    invoke-virtual {v0, v2, v1}, Lfg/d;->a(Ljava/lang/Class;Ldg/c;)Leg/a;

    .line 25
    .line 26
    .line 27
    sget-object v1, Lcom/google/firebase/sessions/e;->a:Lcom/google/firebase/sessions/e;

    .line 28
    .line 29
    const-class v2, Lcom/google/firebase/sessions/i;

    .line 30
    .line 31
    invoke-virtual {v0, v2, v1}, Lfg/d;->a(Ljava/lang/Class;Ldg/c;)Leg/a;

    .line 32
    .line 33
    .line 34
    sget-object v1, Lcom/google/firebase/sessions/d;->a:Lcom/google/firebase/sessions/d;

    .line 35
    .line 36
    const-class v2, Lcom/google/firebase/sessions/b;

    .line 37
    .line 38
    invoke-virtual {v0, v2, v1}, Lfg/d;->a(Ljava/lang/Class;Ldg/c;)Leg/a;

    .line 39
    .line 40
    .line 41
    sget-object v1, Lcom/google/firebase/sessions/c;->a:Lcom/google/firebase/sessions/c;

    .line 42
    .line 43
    const-class v2, Lcom/google/firebase/sessions/a;

    .line 44
    .line 45
    invoke-virtual {v0, v2, v1}, Lfg/d;->a(Ljava/lang/Class;Ldg/c;)Leg/a;

    .line 46
    .line 47
    .line 48
    sget-object v1, Lcom/google/firebase/sessions/f;->a:Lcom/google/firebase/sessions/f;

    .line 49
    .line 50
    const-class v2, Lcom/google/firebase/sessions/p;

    .line 51
    .line 52
    invoke-virtual {v0, v2, v1}, Lfg/d;->a(Ljava/lang/Class;Ldg/c;)Leg/a;

    .line 53
    .line 54
    .line 55
    const/4 v1, 0x1

    .line 56
    iput-boolean v1, v0, Lfg/d;->d:Z

    .line 57
    .line 58
    new-instance v1, Landroidx/appcompat/widget/w0;

    .line 59
    .line 60
    const/16 v2, 0x17

    .line 61
    .line 62
    invoke-direct {v1, v0, v2}, Landroidx/appcompat/widget/w0;-><init>(Ljava/lang/Object;I)V

    .line 63
    .line 64
    .line 65
    const-string v0, "JsonDataEncoderBuilder()\u2026lues(true)\n      .build()"

    .line 66
    .line 67
    invoke-static {v1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 68
    .line 69
    .line 70
    sput-object v1, Lcom/google/firebase/sessions/a0;->b:Landroidx/appcompat/widget/w0;

    .line 71
    .line 72
    return-void
.end method

.method public static a(Lef/h;)Lcom/google/firebase/sessions/b;
    .locals 18

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    const-string v1, "firebaseApp"

    .line 4
    .line 5
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 6
    .line 7
    .line 8
    invoke-virtual/range {p0 .. p0}, Lef/h;->a()V

    .line 9
    .line 10
    .line 11
    iget-object v1, v0, Lef/h;->a:Landroid/content/Context;

    .line 12
    .line 13
    const-string v2, "firebaseApp.applicationContext"

    .line 14
    .line 15
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    .line 17
    .line 18
    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    .line 19
    .line 20
    .line 21
    move-result-object v4

    .line 22
    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    .line 23
    .line 24
    .line 25
    move-result-object v3

    .line 26
    const/4 v5, 0x0

    .line 27
    invoke-virtual {v3, v4, v5}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    .line 28
    .line 29
    .line 30
    move-result-object v3

    .line 31
    sget v6, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 32
    .line 33
    const/16 v7, 0x1c

    .line 34
    .line 35
    if-lt v6, v7, :cond_0

    .line 36
    .line 37
    invoke-static {v3}, Landroidx/credentials/playservices/controllers/CreatePublicKeyCredential/PublicKeyCredentialControllerUtility$GetGMSVersion$$ExternalSyntheticApiModelOutline0;->m(Landroid/content/pm/PackageInfo;)J

    .line 38
    .line 39
    .line 40
    move-result-wide v8

    .line 41
    invoke-static {v8, v9}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    .line 42
    .line 43
    .line 44
    move-result-object v6

    .line 45
    goto :goto_0

    .line 46
    :cond_0
    iget v6, v3, Landroid/content/pm/PackageInfo;->versionCode:I

    .line 47
    .line 48
    invoke-static {v6}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    .line 49
    .line 50
    .line 51
    move-result-object v6

    .line 52
    :goto_0
    new-instance v14, Lcom/google/firebase/sessions/b;

    .line 53
    .line 54
    invoke-virtual/range {p0 .. p0}, Lef/h;->a()V

    .line 55
    .line 56
    .line 57
    iget-object v8, v0, Lef/h;->c:Lef/j;

    .line 58
    .line 59
    iget-object v10, v8, Lef/j;->b:Ljava/lang/String;

    .line 60
    .line 61
    const-string v8, "firebaseApp.options.applicationId"

    .line 62
    .line 63
    invoke-static {v10, v8}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 64
    .line 65
    .line 66
    sget-object v11, Landroid/os/Build;->MODEL:Ljava/lang/String;

    .line 67
    .line 68
    const-string v8, "MODEL"

    .line 69
    .line 70
    invoke-static {v11, v8}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    .line 72
    .line 73
    sget-object v12, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    .line 74
    .line 75
    const-string v8, "RELEASE"

    .line 76
    .line 77
    invoke-static {v12, v8}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 78
    .line 79
    .line 80
    sget-object v13, Lcom/google/firebase/sessions/LogEnvironment;->LOG_ENVIRONMENT_PROD:Lcom/google/firebase/sessions/LogEnvironment;

    .line 81
    .line 82
    new-instance v15, Lcom/google/firebase/sessions/a;

    .line 83
    .line 84
    const-string v8, "packageName"

    .line 85
    .line 86
    invoke-static {v4, v8}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 87
    .line 88
    .line 89
    iget-object v3, v3, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    .line 90
    .line 91
    if-nez v3, :cond_1

    .line 92
    .line 93
    move-object v8, v6

    .line 94
    goto :goto_1

    .line 95
    :cond_1
    move-object v8, v3

    .line 96
    :goto_1
    sget-object v9, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    .line 97
    .line 98
    const-string v3, "MANUFACTURER"

    .line 99
    .line 100
    invoke-static {v9, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 101
    .line 102
    .line 103
    invoke-virtual/range {p0 .. p0}, Lef/h;->a()V

    .line 104
    .line 105
    .line 106
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 107
    .line 108
    .line 109
    const-string v3, "context"

    .line 110
    .line 111
    invoke-static {v1, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 112
    .line 113
    .line 114
    invoke-static {}, Landroid/os/Process;->myPid()I

    .line 115
    .line 116
    .line 117
    move-result v3

    .line 118
    invoke-static {v1}, Lcom/facebook/internal/h1;->E(Landroid/content/Context;)Ljava/util/ArrayList;

    .line 119
    .line 120
    .line 121
    move-result-object v16

    .line 122
    invoke-virtual/range {v16 .. v16}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 123
    .line 124
    .line 125
    move-result-object v16

    .line 126
    :goto_2
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->hasNext()Z

    .line 127
    .line 128
    .line 129
    move-result v17

    .line 130
    if-eqz v17, :cond_3

    .line 131
    .line 132
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 133
    .line 134
    .line 135
    move-result-object v17

    .line 136
    move-object/from16 v5, v17

    .line 137
    .line 138
    check-cast v5, Lcom/google/firebase/sessions/p;

    .line 139
    .line 140
    iget v5, v5, Lcom/google/firebase/sessions/p;->b:I

    .line 141
    .line 142
    if-ne v5, v3, :cond_2

    .line 143
    .line 144
    goto :goto_3

    .line 145
    :cond_2
    const/4 v5, 0x0

    .line 146
    goto :goto_2

    .line 147
    :cond_3
    const/16 v17, 0x0

    .line 148
    .line 149
    :goto_3
    check-cast v17, Lcom/google/firebase/sessions/p;

    .line 150
    .line 151
    if-nez v17, :cond_7

    .line 152
    .line 153
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 154
    .line 155
    const/16 v7, 0x21

    .line 156
    .line 157
    if-lt v5, v7, :cond_4

    .line 158
    .line 159
    invoke-static {}, Landroidx/appcompat/app/c0;->l()Ljava/lang/String;

    .line 160
    .line 161
    .line 162
    move-result-object v5

    .line 163
    const-string v7, "myProcessName()"

    .line 164
    .line 165
    invoke-static {v5, v7}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 166
    .line 167
    .line 168
    goto :goto_4

    .line 169
    :cond_4
    const/16 v7, 0x1c

    .line 170
    .line 171
    if-lt v5, v7, :cond_5

    .line 172
    .line 173
    invoke-static {}, Landroidx/activity/z;->i()Ljava/lang/String;

    .line 174
    .line 175
    .line 176
    move-result-object v5

    .line 177
    if-eqz v5, :cond_5

    .line 178
    .line 179
    goto :goto_4

    .line 180
    :cond_5
    invoke-static {}, Lcom/google/android/gms/common/util/ProcessUtils;->getMyProcessName()Ljava/lang/String;

    .line 181
    .line 182
    .line 183
    move-result-object v5

    .line 184
    if-eqz v5, :cond_6

    .line 185
    .line 186
    goto :goto_4

    .line 187
    :cond_6
    const-string v5, ""

    .line 188
    .line 189
    :goto_4
    new-instance v7, Lcom/google/firebase/sessions/p;

    .line 190
    .line 191
    const/4 v0, 0x0

    .line 192
    invoke-direct {v7, v3, v0, v5, v0}, Lcom/google/firebase/sessions/p;-><init>(IILjava/lang/String;Z)V

    .line 193
    .line 194
    .line 195
    move-object/from16 v17, v7

    .line 196
    .line 197
    :cond_7
    invoke-virtual/range {p0 .. p0}, Lef/h;->a()V

    .line 198
    .line 199
    .line 200
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 201
    .line 202
    .line 203
    invoke-static {v1}, Lcom/facebook/internal/h1;->E(Landroid/content/Context;)Ljava/util/ArrayList;

    .line 204
    .line 205
    .line 206
    move-result-object v0

    .line 207
    move-object v3, v15

    .line 208
    move-object v5, v8

    .line 209
    move-object v7, v9

    .line 210
    move-object/from16 v8, v17

    .line 211
    .line 212
    move-object v9, v0

    .line 213
    invoke-direct/range {v3 .. v9}, Lcom/google/firebase/sessions/a;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/sessions/p;Ljava/util/ArrayList;)V

    .line 214
    .line 215
    .line 216
    move-object v8, v14

    .line 217
    move-object v9, v10

    .line 218
    move-object v10, v11

    .line 219
    move-object v11, v12

    .line 220
    move-object v12, v13

    .line 221
    move-object v13, v15

    .line 222
    invoke-direct/range {v8 .. v13}, Lcom/google/firebase/sessions/b;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/sessions/LogEnvironment;Lcom/google/firebase/sessions/a;)V

    .line 223
    .line 224
    .line 225
    return-object v14
.end method
