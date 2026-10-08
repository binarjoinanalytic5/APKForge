.class public final enum Landroidx/constraintlayout/core/state/State$Helper;
.super Ljava/lang/Enum;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Landroidx/constraintlayout/core/state/State$Helper;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Landroidx/constraintlayout/core/state/State$Helper;

.field public static final enum ALIGN_HORIZONTALLY:Landroidx/constraintlayout/core/state/State$Helper;

.field public static final enum ALIGN_VERTICALLY:Landroidx/constraintlayout/core/state/State$Helper;

.field public static final enum BARRIER:Landroidx/constraintlayout/core/state/State$Helper;

.field public static final enum FLOW:Landroidx/constraintlayout/core/state/State$Helper;

.field public static final enum HORIZONTAL_CHAIN:Landroidx/constraintlayout/core/state/State$Helper;

.field public static final enum LAYER:Landroidx/constraintlayout/core/state/State$Helper;

.field public static final enum VERTICAL_CHAIN:Landroidx/constraintlayout/core/state/State$Helper;


# direct methods
.method static constructor <clinit>()V
    .locals 15

    .line 1
    new-instance v0, Landroidx/constraintlayout/core/state/State$Helper;

    .line 2
    .line 3
    const-string v1, "HORIZONTAL_CHAIN"

    .line 4
    .line 5
    const/4 v2, 0x0

    .line 6
    invoke-direct {v0, v1, v2}, Landroidx/constraintlayout/core/state/State$Helper;-><init>(Ljava/lang/String;I)V

    .line 7
    .line 8
    .line 9
    sput-object v0, Landroidx/constraintlayout/core/state/State$Helper;->HORIZONTAL_CHAIN:Landroidx/constraintlayout/core/state/State$Helper;

    .line 10
    .line 11
    new-instance v1, Landroidx/constraintlayout/core/state/State$Helper;

    .line 12
    .line 13
    const-string v3, "VERTICAL_CHAIN"

    .line 14
    .line 15
    const/4 v4, 0x1

    .line 16
    invoke-direct {v1, v3, v4}, Landroidx/constraintlayout/core/state/State$Helper;-><init>(Ljava/lang/String;I)V

    .line 17
    .line 18
    .line 19
    sput-object v1, Landroidx/constraintlayout/core/state/State$Helper;->VERTICAL_CHAIN:Landroidx/constraintlayout/core/state/State$Helper;

    .line 20
    .line 21
    new-instance v3, Landroidx/constraintlayout/core/state/State$Helper;

    .line 22
    .line 23
    const-string v5, "ALIGN_HORIZONTALLY"

    .line 24
    .line 25
    const/4 v6, 0x2

    .line 26
    invoke-direct {v3, v5, v6}, Landroidx/constraintlayout/core/state/State$Helper;-><init>(Ljava/lang/String;I)V

    .line 27
    .line 28
    .line 29
    sput-object v3, Landroidx/constraintlayout/core/state/State$Helper;->ALIGN_HORIZONTALLY:Landroidx/constraintlayout/core/state/State$Helper;

    .line 30
    .line 31
    new-instance v5, Landroidx/constraintlayout/core/state/State$Helper;

    .line 32
    .line 33
    const-string v7, "ALIGN_VERTICALLY"

    .line 34
    .line 35
    const/4 v8, 0x3

    .line 36
    invoke-direct {v5, v7, v8}, Landroidx/constraintlayout/core/state/State$Helper;-><init>(Ljava/lang/String;I)V

    .line 37
    .line 38
    .line 39
    sput-object v5, Landroidx/constraintlayout/core/state/State$Helper;->ALIGN_VERTICALLY:Landroidx/constraintlayout/core/state/State$Helper;

    .line 40
    .line 41
    new-instance v7, Landroidx/constraintlayout/core/state/State$Helper;

    .line 42
    .line 43
    const-string v9, "BARRIER"

    .line 44
    .line 45
    const/4 v10, 0x4

    .line 46
    invoke-direct {v7, v9, v10}, Landroidx/constraintlayout/core/state/State$Helper;-><init>(Ljava/lang/String;I)V

    .line 47
    .line 48
    .line 49
    sput-object v7, Landroidx/constraintlayout/core/state/State$Helper;->BARRIER:Landroidx/constraintlayout/core/state/State$Helper;

    .line 50
    .line 51
    new-instance v9, Landroidx/constraintlayout/core/state/State$Helper;

    .line 52
    .line 53
    const-string v11, "LAYER"

    .line 54
    .line 55
    const/4 v12, 0x5

    .line 56
    invoke-direct {v9, v11, v12}, Landroidx/constraintlayout/core/state/State$Helper;-><init>(Ljava/lang/String;I)V

    .line 57
    .line 58
    .line 59
    sput-object v9, Landroidx/constraintlayout/core/state/State$Helper;->LAYER:Landroidx/constraintlayout/core/state/State$Helper;

    .line 60
    .line 61
    new-instance v11, Landroidx/constraintlayout/core/state/State$Helper;

    .line 62
    .line 63
    const-string v13, "FLOW"

    .line 64
    .line 65
    const/4 v14, 0x6

    .line 66
    invoke-direct {v11, v13, v14}, Landroidx/constraintlayout/core/state/State$Helper;-><init>(Ljava/lang/String;I)V

    .line 67
    .line 68
    .line 69
    sput-object v11, Landroidx/constraintlayout/core/state/State$Helper;->FLOW:Landroidx/constraintlayout/core/state/State$Helper;

    .line 70
    .line 71
    const/4 v13, 0x7

    .line 72
    new-array v13, v13, [Landroidx/constraintlayout/core/state/State$Helper;

    .line 73
    .line 74
    aput-object v0, v13, v2

    .line 75
    .line 76
    aput-object v1, v13, v4

    .line 77
    .line 78
    aput-object v3, v13, v6

    .line 79
    .line 80
    aput-object v5, v13, v8

    .line 81
    .line 82
    aput-object v7, v13, v10

    .line 83
    .line 84
    aput-object v9, v13, v12

    .line 85
    .line 86
    aput-object v11, v13, v14

    .line 87
    .line 88
    sput-object v13, Landroidx/constraintlayout/core/state/State$Helper;->$VALUES:[Landroidx/constraintlayout/core/state/State$Helper;

    .line 89
    .line 90
    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 2
    .line 3
    .line 4
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Landroidx/constraintlayout/core/state/State$Helper;
    .locals 1

    .line 1
    const-class v0, Landroidx/constraintlayout/core/state/State$Helper;

    .line 2
    .line 3
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    .line 4
    .line 5
    .line 6
    move-result-object p0

    .line 7
    check-cast p0, Landroidx/constraintlayout/core/state/State$Helper;

    .line 8
    .line 9
    return-object p0
.end method

.method public static values()[Landroidx/constraintlayout/core/state/State$Helper;
    .locals 1

    .line 1
    sget-object v0, Landroidx/constraintlayout/core/state/State$Helper;->$VALUES:[Landroidx/constraintlayout/core/state/State$Helper;

    .line 2
    .line 3
    invoke-virtual {v0}, [Landroidx/constraintlayout/core/state/State$Helper;->clone()Ljava/lang/Object;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    check-cast v0, [Landroidx/constraintlayout/core/state/State$Helper;

    .line 8
    .line 9
    return-object v0
.end method
