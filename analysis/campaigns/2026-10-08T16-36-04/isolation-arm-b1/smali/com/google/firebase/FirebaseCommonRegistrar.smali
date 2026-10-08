.class public Lcom/google/firebase/FirebaseCommonRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/components/ComponentRegistrar;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    return-void
.end method

.method public static a(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 1
    const/16 v0, 0x20

    .line 2
    .line 3
    const/16 v1, 0x5f

    .line 4
    .line 5
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    .line 6
    .line 7
    .line 8
    move-result-object p0

    .line 9
    const/16 v0, 0x2f

    .line 10
    .line 11
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    .line 12
    .line 13
    .line 14
    move-result-object p0

    .line 15
    return-object p0
.end method


# virtual methods
.method public final getComponents()Ljava/util/List;
    .locals 9

    .line 1
    const/4 v0, 0x2

    .line 2
    const/4 v1, 0x1

    .line 3
    const/4 v2, 0x0

    .line 4
    new-instance v3, Ljava/util/ArrayList;

    .line 5
    .line 6
    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 7
    .line 8
    .line 9
    const-class v4, Lsg/b;

    .line 10
    .line 11
    invoke-static {v4}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 12
    .line 13
    .line 14
    move-result-object v5

    .line 15
    new-instance v6, Ljf/i;

    .line 16
    .line 17
    const-class v7, Lsg/a;

    .line 18
    .line 19
    invoke-direct {v6, v7, v0, v2}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 20
    .line 21
    .line 22
    invoke-virtual {v5, v6}, Ljf/a;->a(Ljf/i;)V

    .line 23
    .line 24
    .line 25
    new-instance v6, Lef/i;

    .line 26
    .line 27
    const/16 v7, 0xd

    .line 28
    .line 29
    invoke-direct {v6, v7}, Lef/i;-><init>(I)V

    .line 30
    .line 31
    .line 32
    iput-object v6, v5, Ljf/a;->f:Ljf/e;

    .line 33
    .line 34
    invoke-virtual {v5}, Ljf/a;->b()Ljf/b;

    .line 35
    .line 36
    .line 37
    move-result-object v5

    .line 38
    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 39
    .line 40
    .line 41
    new-instance v5, Ljf/o;

    .line 42
    .line 43
    const-class v6, Lif/a;

    .line 44
    .line 45
    const-class v7, Ljava/util/concurrent/Executor;

    .line 46
    .line 47
    invoke-direct {v5, v6, v7}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 48
    .line 49
    .line 50
    new-array v6, v0, [Ljava/lang/Class;

    .line 51
    .line 52
    const-class v7, Lig/e;

    .line 53
    .line 54
    aput-object v7, v6, v2

    .line 55
    .line 56
    const-class v7, Lig/f;

    .line 57
    .line 58
    aput-object v7, v6, v1

    .line 59
    .line 60
    new-instance v7, Ljf/a;

    .line 61
    .line 62
    const-class v8, Lig/c;

    .line 63
    .line 64
    invoke-direct {v7, v8, v6}, Ljf/a;-><init>(Ljava/lang/Class;[Ljava/lang/Class;)V

    .line 65
    .line 66
    .line 67
    const-class v6, Landroid/content/Context;

    .line 68
    .line 69
    invoke-static {v6}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 70
    .line 71
    .line 72
    move-result-object v6

    .line 73
    invoke-virtual {v7, v6}, Ljf/a;->a(Ljf/i;)V

    .line 74
    .line 75
    .line 76
    const-class v6, Lef/h;

    .line 77
    .line 78
    invoke-static {v6}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 79
    .line 80
    .line 81
    move-result-object v6

    .line 82
    invoke-virtual {v7, v6}, Ljf/a;->a(Ljf/i;)V

    .line 83
    .line 84
    .line 85
    new-instance v6, Ljf/i;

    .line 86
    .line 87
    const-class v8, Lig/d;

    .line 88
    .line 89
    invoke-direct {v6, v8, v0, v2}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 90
    .line 91
    .line 92
    invoke-virtual {v7, v6}, Ljf/a;->a(Ljf/i;)V

    .line 93
    .line 94
    .line 95
    new-instance v0, Ljf/i;

    .line 96
    .line 97
    invoke-direct {v0, v4, v1, v1}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 98
    .line 99
    .line 100
    invoke-virtual {v7, v0}, Ljf/a;->a(Ljf/i;)V

    .line 101
    .line 102
    .line 103
    new-instance v0, Ljf/i;

    .line 104
    .line 105
    invoke-direct {v0, v5, v1, v2}, Ljf/i;-><init>(Ljf/o;II)V

    .line 106
    .line 107
    .line 108
    invoke-virtual {v7, v0}, Ljf/a;->a(Ljf/i;)V

    .line 109
    .line 110
    .line 111
    new-instance v0, Lcom/google/firebase/messaging/m;

    .line 112
    .line 113
    invoke-direct {v0, v5, v1}, Lcom/google/firebase/messaging/m;-><init>(Ljf/o;I)V

    .line 114
    .line 115
    .line 116
    iput-object v0, v7, Ljf/a;->f:Ljf/e;

    .line 117
    .line 118
    invoke-virtual {v7}, Ljf/a;->b()Ljf/b;

    .line 119
    .line 120
    .line 121
    move-result-object v0

    .line 122
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 123
    .line 124
    .line 125
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 126
    .line 127
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    .line 128
    .line 129
    .line 130
    move-result-object v0

    .line 131
    const-string v1, "fire-android"

    .line 132
    .line 133
    invoke-static {v1, v0}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 134
    .line 135
    .line 136
    move-result-object v0

    .line 137
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 138
    .line 139
    .line 140
    const-string v0, "fire-core"

    .line 141
    .line 142
    const-string v1, "21.0.0"

    .line 143
    .line 144
    invoke-static {v0, v1}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 145
    .line 146
    .line 147
    move-result-object v0

    .line 148
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 149
    .line 150
    .line 151
    sget-object v0, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    .line 152
    .line 153
    invoke-static {v0}, Lcom/google/firebase/FirebaseCommonRegistrar;->a(Ljava/lang/String;)Ljava/lang/String;

    .line 154
    .line 155
    .line 156
    move-result-object v0

    .line 157
    const-string v1, "device-name"

    .line 158
    .line 159
    invoke-static {v1, v0}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 160
    .line 161
    .line 162
    move-result-object v0

    .line 163
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 164
    .line 165
    .line 166
    sget-object v0, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    .line 167
    .line 168
    invoke-static {v0}, Lcom/google/firebase/FirebaseCommonRegistrar;->a(Ljava/lang/String;)Ljava/lang/String;

    .line 169
    .line 170
    .line 171
    move-result-object v0

    .line 172
    const-string v1, "device-model"

    .line 173
    .line 174
    invoke-static {v1, v0}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 175
    .line 176
    .line 177
    move-result-object v0

    .line 178
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 179
    .line 180
    .line 181
    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    .line 182
    .line 183
    invoke-static {v0}, Lcom/google/firebase/FirebaseCommonRegistrar;->a(Ljava/lang/String;)Ljava/lang/String;

    .line 184
    .line 185
    .line 186
    move-result-object v0

    .line 187
    const-string v1, "device-brand"

    .line 188
    .line 189
    invoke-static {v1, v0}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 190
    .line 191
    .line 192
    move-result-object v0

    .line 193
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 194
    .line 195
    .line 196
    new-instance v0, Landroidx/core/view/h;

    .line 197
    .line 198
    const/16 v1, 0x1b

    .line 199
    .line 200
    invoke-direct {v0, v1}, Landroidx/core/view/h;-><init>(I)V

    .line 201
    .line 202
    .line 203
    const-string v1, "android-target-sdk"

    .line 204
    .line 205
    invoke-static {v1, v0}, Lcom/bumptech/glide/e;->S(Ljava/lang/String;Lsg/d;)Ljf/b;

    .line 206
    .line 207
    .line 208
    move-result-object v0

    .line 209
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 210
    .line 211
    .line 212
    new-instance v0, Landroidx/core/view/h;

    .line 213
    .line 214
    const/16 v1, 0x1c

    .line 215
    .line 216
    invoke-direct {v0, v1}, Landroidx/core/view/h;-><init>(I)V

    .line 217
    .line 218
    .line 219
    const-string v1, "android-min-sdk"

    .line 220
    .line 221
    invoke-static {v1, v0}, Lcom/bumptech/glide/e;->S(Ljava/lang/String;Lsg/d;)Ljf/b;

    .line 222
    .line 223
    .line 224
    move-result-object v0

    .line 225
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 226
    .line 227
    .line 228
    new-instance v0, Landroidx/core/view/h;

    .line 229
    .line 230
    const/16 v1, 0x1d

    .line 231
    .line 232
    invoke-direct {v0, v1}, Landroidx/core/view/h;-><init>(I)V

    .line 233
    .line 234
    .line 235
    const-string v1, "android-platform"

    .line 236
    .line 237
    invoke-static {v1, v0}, Lcom/bumptech/glide/e;->S(Ljava/lang/String;Lsg/d;)Ljf/b;

    .line 238
    .line 239
    .line 240
    move-result-object v0

    .line 241
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 242
    .line 243
    .line 244
    new-instance v0, Lef/i;

    .line 245
    .line 246
    invoke-direct {v0, v2}, Lef/i;-><init>(I)V

    .line 247
    .line 248
    .line 249
    const-string v1, "android-installer"

    .line 250
    .line 251
    invoke-static {v1, v0}, Lcom/bumptech/glide/e;->S(Ljava/lang/String;Lsg/d;)Ljf/b;

    .line 252
    .line 253
    .line 254
    move-result-object v0

    .line 255
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 256
    .line 257
    .line 258
    :try_start_0
    sget-object v0, Lop/h;->c:Lop/h;

    .line 259
    .line 260
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 261
    .line 262
    .line 263
    const-string v0, "2.3.0"
    :try_end_0
    .catch Ljava/lang/NoClassDefFoundError; {:try_start_0 .. :try_end_0} :catch_0

    .line 264
    .line 265
    goto :goto_0

    .line 266
    :catch_0
    const/4 v0, 0x0

    .line 267
    :goto_0
    if-eqz v0, :cond_0

    .line 268
    .line 269
    const-string v1, "kotlin"

    .line 270
    .line 271
    invoke-static {v1, v0}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 272
    .line 273
    .line 274
    move-result-object v0

    .line 275
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 276
    .line 277
    .line 278
    :cond_0
    return-object v3
.end method
