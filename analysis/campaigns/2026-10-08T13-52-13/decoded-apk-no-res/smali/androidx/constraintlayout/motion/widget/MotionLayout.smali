.class public Landroidx/constraintlayout/motion/widget/MotionLayout;
.super Landroidx/constraintlayout/widget/ConstraintLayout;
.source "SourceFile"

# interfaces
.implements Landroidx/core/view/x;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;
    }
.end annotation


# static fields
.field public static H0:Z


# instance fields
.field public A:I

.field public A0:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

.field public B:Z

.field public final B0:Lh1/s;

.field public final C:Ljava/util/HashMap;

.field public C0:Z

.field public D:J

.field public final D0:Landroid/graphics/RectF;

.field public E:F

.field public E0:Landroid/view/View;

.field public F:F

.field public F0:Landroid/graphics/Matrix;

.field public G:F

.field public final G0:Ljava/util/ArrayList;

.field public H:J

.field public I:F

.field public J:Z

.field public K:Z

.field public L:Lh1/u;

.field public M:I

.field public N:Lh1/r;

.field public O:Z

.field public final P:Lg1/b;

.field public final Q:Lh1/q;

.field public R:Lh1/a;

.field public S:I

.field public T:I

.field public U:Z

.field public V:F

.field public W:F

.field public a0:J

.field public b0:F

.field public c0:Z

.field public d0:Ljava/util/ArrayList;

.field public e0:Ljava/util/ArrayList;

.field public f0:Ljava/util/ArrayList;

.field public g0:Ljava/util/concurrent/CopyOnWriteArrayList;

.field public h0:I

.field public i0:J

.field public j0:F

.field public k0:I

.field public l0:F

.field public m0:Z

.field public n0:I

.field public o0:I

.field public p0:I

.field public q0:I

.field public r0:I

.field public s:Landroidx/constraintlayout/motion/widget/c;

.field public s0:I

.field public t:Lh1/o;

.field public t0:F

.field public u:Landroid/view/animation/Interpolator;

.field public final u0:Lb1/e;

.field public v:F

.field public v0:Z

.field public w:I

.field public w0:Landroidx/constraintlayout/motion/widget/b;

.field public x:I

.field public x0:Lcom/vungle/ads/internal/util/d;

.field public y:I

.field public final y0:Landroid/graphics/Rect;

.field public z:I

.field public z0:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 4
    .param p1    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 1
    invoke-direct {p0, p1, p2}, Landroidx/constraintlayout/widget/ConstraintLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    .line 2
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u:Landroid/view/animation/Interpolator;

    const/4 v0, 0x0

    .line 3
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    const/4 v1, -0x1

    .line 4
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 5
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 6
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    const/4 v1, 0x0

    .line 7
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->z:I

    .line 8
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->A:I

    const/4 v2, 0x1

    .line 9
    iput-boolean v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B:Z

    .line 10
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    iput-object v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    const-wide/16 v2, 0x0

    .line 11
    iput-wide v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D:J

    const/high16 v2, 0x3f800000    # 1.0f

    .line 12
    iput v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 13
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 14
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 15
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 16
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 17
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 18
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->O:Z

    .line 19
    new-instance v2, Lg1/b;

    invoke-direct {v2}, Lg1/b;-><init>()V

    iput-object v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->P:Lg1/b;

    .line 20
    new-instance v2, Lh1/q;

    invoke-direct {v2, p0}, Lh1/q;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    iput-object v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->Q:Lh1/q;

    .line 21
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->U:Z

    .line 22
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 23
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->d0:Ljava/util/ArrayList;

    .line 24
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->e0:Ljava/util/ArrayList;

    .line 25
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 26
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 27
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->h0:I

    const-wide/16 v2, -0x1

    .line 28
    iput-wide v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->i0:J

    .line 29
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->j0:F

    .line 30
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->k0:I

    .line 31
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->l0:F

    .line 32
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->m0:Z

    .line 33
    new-instance v0, Lb1/e;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Lb1/e;-><init>(I)V

    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u0:Lb1/e;

    .line 34
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v0:Z

    .line 35
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x0:Lcom/vungle/ads/internal/util/d;

    .line 36
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 37
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y0:Landroid/graphics/Rect;

    .line 38
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->z0:Z

    .line 39
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->UNDEFINED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->A0:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 40
    new-instance v0, Lh1/s;

    invoke-direct {v0, p0}, Lh1/s;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B0:Lh1/s;

    .line 41
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C0:Z

    .line 42
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D0:Landroid/graphics/RectF;

    .line 43
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 44
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F0:Landroid/graphics/Matrix;

    .line 45
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G0:Ljava/util/ArrayList;

    .line 46
    invoke-virtual {p0, p2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->z(Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 3
    .param p1    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 47
    invoke-direct {p0, p1, p2, p3}, Landroidx/constraintlayout/widget/ConstraintLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    .line 48
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u:Landroid/view/animation/Interpolator;

    const/4 p3, 0x0

    .line 49
    iput p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    const/4 v0, -0x1

    .line 50
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 51
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 52
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    const/4 v0, 0x0

    .line 53
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->z:I

    .line 54
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->A:I

    const/4 v1, 0x1

    .line 55
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B:Z

    .line 56
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    const-wide/16 v1, 0x0

    .line 57
    iput-wide v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D:J

    const/high16 v1, 0x3f800000    # 1.0f

    .line 58
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 59
    iput p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 60
    iput p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 61
    iput p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 62
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 63
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 64
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->O:Z

    .line 65
    new-instance v1, Lg1/b;

    invoke-direct {v1}, Lg1/b;-><init>()V

    iput-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->P:Lg1/b;

    .line 66
    new-instance v1, Lh1/q;

    invoke-direct {v1, p0}, Lh1/q;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    iput-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->Q:Lh1/q;

    .line 67
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->U:Z

    .line 68
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 69
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->d0:Ljava/util/ArrayList;

    .line 70
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->e0:Ljava/util/ArrayList;

    .line 71
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 72
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 73
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->h0:I

    const-wide/16 v1, -0x1

    .line 74
    iput-wide v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->i0:J

    .line 75
    iput p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->j0:F

    .line 76
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->k0:I

    .line 77
    iput p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->l0:F

    .line 78
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->m0:Z

    .line 79
    new-instance p3, Lb1/e;

    const/4 v1, 0x1

    invoke-direct {p3, v1}, Lb1/e;-><init>(I)V

    iput-object p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u0:Lb1/e;

    .line 80
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v0:Z

    .line 81
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x0:Lcom/vungle/ads/internal/util/d;

    .line 82
    new-instance p3, Ljava/util/HashMap;

    invoke-direct {p3}, Ljava/util/HashMap;-><init>()V

    .line 83
    new-instance p3, Landroid/graphics/Rect;

    invoke-direct {p3}, Landroid/graphics/Rect;-><init>()V

    iput-object p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y0:Landroid/graphics/Rect;

    .line 84
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->z0:Z

    .line 85
    sget-object p3, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->UNDEFINED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    iput-object p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->A0:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 86
    new-instance p3, Lh1/s;

    invoke-direct {p3, p0}, Lh1/s;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    iput-object p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B0:Lh1/s;

    .line 87
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C0:Z

    .line 88
    new-instance p3, Landroid/graphics/RectF;

    invoke-direct {p3}, Landroid/graphics/RectF;-><init>()V

    iput-object p3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D0:Landroid/graphics/RectF;

    .line 89
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 90
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F0:Landroid/graphics/Matrix;

    .line 91
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G0:Ljava/util/ArrayList;

    .line 92
    invoke-virtual {p0, p2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->z(Landroid/util/AttributeSet;)V

    return-void
.end method

.method public static q(Landroidx/constraintlayout/motion/widget/MotionLayout;Ld1/f;)Landroid/graphics/Rect;
    .locals 2

    .line 1
    invoke-virtual {p1}, Ld1/f;->t()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    iget-object p0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y0:Landroid/graphics/Rect;

    .line 6
    .line 7
    iput v0, p0, Landroid/graphics/Rect;->top:I

    .line 8
    .line 9
    invoke-virtual {p1}, Ld1/f;->s()I

    .line 10
    .line 11
    .line 12
    move-result v0

    .line 13
    iput v0, p0, Landroid/graphics/Rect;->left:I

    .line 14
    .line 15
    invoke-virtual {p1}, Ld1/f;->r()I

    .line 16
    .line 17
    .line 18
    move-result v0

    .line 19
    iget v1, p0, Landroid/graphics/Rect;->left:I

    .line 20
    .line 21
    add-int/2addr v0, v1

    .line 22
    iput v0, p0, Landroid/graphics/Rect;->right:I

    .line 23
    .line 24
    invoke-virtual {p1}, Ld1/f;->l()I

    .line 25
    .line 26
    .line 27
    move-result p1

    .line 28
    iget v0, p0, Landroid/graphics/Rect;->top:I

    .line 29
    .line 30
    add-int/2addr p1, v0

    .line 31
    iput p1, p0, Landroid/graphics/Rect;->bottom:I

    .line 32
    .line 33
    return-object p0
.end method


# virtual methods
.method public final A()V
    .locals 7

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    return-void

    .line 6
    :cond_0
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 7
    .line 8
    invoke-virtual {v0, v1, p0}, Landroidx/constraintlayout/motion/widget/c;->a(ILandroidx/constraintlayout/motion/widget/MotionLayout;)Z

    .line 9
    .line 10
    .line 11
    move-result v0

    .line 12
    if-eqz v0, :cond_1

    .line 13
    .line 14
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->requestLayout()V

    .line 15
    .line 16
    .line 17
    return-void

    .line 18
    :cond_1
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 19
    .line 20
    const/4 v1, -0x1

    .line 21
    if-eq v0, v1, :cond_9

    .line 22
    .line 23
    iget-object v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 24
    .line 25
    iget-object v3, v2, Landroidx/constraintlayout/motion/widget/c;->d:Ljava/util/ArrayList;

    .line 26
    .line 27
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 28
    .line 29
    .line 30
    move-result-object v4

    .line 31
    :cond_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    .line 32
    .line 33
    .line 34
    move-result v5

    .line 35
    if-eqz v5, :cond_3

    .line 36
    .line 37
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 38
    .line 39
    .line 40
    move-result-object v5

    .line 41
    check-cast v5, Lh1/x;

    .line 42
    .line 43
    iget-object v6, v5, Lh1/x;->m:Ljava/util/ArrayList;

    .line 44
    .line 45
    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    .line 46
    .line 47
    .line 48
    move-result v6

    .line 49
    if-lez v6, :cond_2

    .line 50
    .line 51
    iget-object v5, v5, Lh1/x;->m:Ljava/util/ArrayList;

    .line 52
    .line 53
    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 54
    .line 55
    .line 56
    move-result-object v5

    .line 57
    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    .line 58
    .line 59
    .line 60
    move-result v6

    .line 61
    if-eqz v6, :cond_2

    .line 62
    .line 63
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 64
    .line 65
    .line 66
    move-result-object v6

    .line 67
    check-cast v6, Lh1/w;

    .line 68
    .line 69
    invoke-virtual {v6, p0}, Lh1/w;->b(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 70
    .line 71
    .line 72
    goto :goto_0

    .line 73
    :cond_3
    iget-object v2, v2, Landroidx/constraintlayout/motion/widget/c;->f:Ljava/util/ArrayList;

    .line 74
    .line 75
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 76
    .line 77
    .line 78
    move-result-object v4

    .line 79
    :cond_4
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    .line 80
    .line 81
    .line 82
    move-result v5

    .line 83
    if-eqz v5, :cond_5

    .line 84
    .line 85
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 86
    .line 87
    .line 88
    move-result-object v5

    .line 89
    check-cast v5, Lh1/x;

    .line 90
    .line 91
    iget-object v6, v5, Lh1/x;->m:Ljava/util/ArrayList;

    .line 92
    .line 93
    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    .line 94
    .line 95
    .line 96
    move-result v6

    .line 97
    if-lez v6, :cond_4

    .line 98
    .line 99
    iget-object v5, v5, Lh1/x;->m:Ljava/util/ArrayList;

    .line 100
    .line 101
    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 102
    .line 103
    .line 104
    move-result-object v5

    .line 105
    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    .line 106
    .line 107
    .line 108
    move-result v6

    .line 109
    if-eqz v6, :cond_4

    .line 110
    .line 111
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 112
    .line 113
    .line 114
    move-result-object v6

    .line 115
    check-cast v6, Lh1/w;

    .line 116
    .line 117
    invoke-virtual {v6, p0}, Lh1/w;->b(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 118
    .line 119
    .line 120
    goto :goto_1

    .line 121
    :cond_5
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 122
    .line 123
    .line 124
    move-result-object v3

    .line 125
    :cond_6
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    .line 126
    .line 127
    .line 128
    move-result v4

    .line 129
    if-eqz v4, :cond_7

    .line 130
    .line 131
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 132
    .line 133
    .line 134
    move-result-object v4

    .line 135
    check-cast v4, Lh1/x;

    .line 136
    .line 137
    iget-object v5, v4, Lh1/x;->m:Ljava/util/ArrayList;

    .line 138
    .line 139
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    .line 140
    .line 141
    .line 142
    move-result v5

    .line 143
    if-lez v5, :cond_6

    .line 144
    .line 145
    iget-object v5, v4, Lh1/x;->m:Ljava/util/ArrayList;

    .line 146
    .line 147
    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 148
    .line 149
    .line 150
    move-result-object v5

    .line 151
    :goto_2
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    .line 152
    .line 153
    .line 154
    move-result v6

    .line 155
    if-eqz v6, :cond_6

    .line 156
    .line 157
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 158
    .line 159
    .line 160
    move-result-object v6

    .line 161
    check-cast v6, Lh1/w;

    .line 162
    .line 163
    invoke-virtual {v6, p0, v0, v4}, Lh1/w;->a(Landroidx/constraintlayout/motion/widget/MotionLayout;ILh1/x;)V

    .line 164
    .line 165
    .line 166
    goto :goto_2

    .line 167
    :cond_7
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 168
    .line 169
    .line 170
    move-result-object v2

    .line 171
    :cond_8
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    .line 172
    .line 173
    .line 174
    move-result v3

    .line 175
    if-eqz v3, :cond_9

    .line 176
    .line 177
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 178
    .line 179
    .line 180
    move-result-object v3

    .line 181
    check-cast v3, Lh1/x;

    .line 182
    .line 183
    iget-object v4, v3, Lh1/x;->m:Ljava/util/ArrayList;

    .line 184
    .line 185
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    .line 186
    .line 187
    .line 188
    move-result v4

    .line 189
    if-lez v4, :cond_8

    .line 190
    .line 191
    iget-object v4, v3, Lh1/x;->m:Ljava/util/ArrayList;

    .line 192
    .line 193
    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 194
    .line 195
    .line 196
    move-result-object v4

    .line 197
    :goto_3
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    .line 198
    .line 199
    .line 200
    move-result v5

    .line 201
    if-eqz v5, :cond_8

    .line 202
    .line 203
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 204
    .line 205
    .line 206
    move-result-object v5

    .line 207
    check-cast v5, Lh1/w;

    .line 208
    .line 209
    invoke-virtual {v5, p0, v0, v3}, Lh1/w;->a(Landroidx/constraintlayout/motion/widget/MotionLayout;ILh1/x;)V

    .line 210
    .line 211
    .line 212
    goto :goto_3

    .line 213
    :cond_9
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 214
    .line 215
    invoke-virtual {v0}, Landroidx/constraintlayout/motion/widget/c;->o()Z

    .line 216
    .line 217
    .line 218
    move-result v0

    .line 219
    if-eqz v0, :cond_c

    .line 220
    .line 221
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 222
    .line 223
    iget-object v0, v0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 224
    .line 225
    if-eqz v0, :cond_c

    .line 226
    .line 227
    iget-object v0, v0, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 228
    .line 229
    if-eqz v0, :cond_c

    .line 230
    .line 231
    iget v2, v0, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 232
    .line 233
    if-eq v2, v1, :cond_a

    .line 234
    .line 235
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 236
    .line 237
    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 238
    .line 239
    .line 240
    move-result-object v2

    .line 241
    if-nez v2, :cond_b

    .line 242
    .line 243
    new-instance v3, Ljava/lang/StringBuilder;

    .line 244
    .line 245
    const-string v4, "cannot find TouchAnchorId @id/"

    .line 246
    .line 247
    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 248
    .line 249
    .line 250
    invoke-virtual {v1}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 251
    .line 252
    .line 253
    move-result-object v1

    .line 254
    iget v0, v0, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 255
    .line 256
    invoke-static {v1, v0}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 257
    .line 258
    .line 259
    move-result-object v0

    .line 260
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 261
    .line 262
    .line 263
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 264
    .line 265
    .line 266
    move-result-object v0

    .line 267
    const-string v1, "TouchResponse"

    .line 268
    .line 269
    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 270
    .line 271
    .line 272
    goto :goto_4

    .line 273
    :cond_a
    const/4 v2, 0x0

    .line 274
    :cond_b
    :goto_4
    instance-of v0, v2, Landroidx/core/widget/NestedScrollView;

    .line 275
    .line 276
    if-eqz v0, :cond_c

    .line 277
    .line 278
    check-cast v2, Landroidx/core/widget/NestedScrollView;

    .line 279
    .line 280
    new-instance v0, Lh1/y;

    .line 281
    .line 282
    const/4 v1, 0x0

    .line 283
    invoke-direct {v0, v1}, Lh1/y;-><init>(I)V

    .line 284
    .line 285
    .line 286
    invoke-virtual {v2, v0}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 287
    .line 288
    .line 289
    new-instance v0, Lcom/crazymaple/reelshort/novel/htmltext/e;

    .line 290
    .line 291
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 292
    .line 293
    .line 294
    invoke-virtual {v2, v0}, Landroidx/core/widget/NestedScrollView;->setOnScrollChangeListener(Landroidx/core/widget/l;)V

    .line 295
    .line 296
    .line 297
    :cond_c
    return-void
.end method

.method public final B()V
    .locals 6

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->L:Lh1/u;

    .line 2
    .line 3
    if-nez v0, :cond_1

    .line 4
    .line 5
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 6
    .line 7
    if-eqz v0, :cond_0

    .line 8
    .line 9
    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    .line 10
    .line 11
    .line 12
    move-result v0

    .line 13
    if-eqz v0, :cond_1

    .line 14
    .line 15
    :cond_0
    return-void

    .line 16
    :cond_1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G0:Ljava/util/ArrayList;

    .line 17
    .line 18
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 19
    .line 20
    .line 21
    move-result-object v1

    .line 22
    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    .line 23
    .line 24
    .line 25
    move-result v2

    .line 26
    if-eqz v2, :cond_4

    .line 27
    .line 28
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 29
    .line 30
    .line 31
    move-result-object v2

    .line 32
    check-cast v2, Ljava/lang/Integer;

    .line 33
    .line 34
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->L:Lh1/u;

    .line 35
    .line 36
    if-eqz v3, :cond_3

    .line 37
    .line 38
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    .line 39
    .line 40
    .line 41
    move-result v4

    .line 42
    invoke-interface {v3, v4}, Lh1/u;->a(I)V

    .line 43
    .line 44
    .line 45
    :cond_3
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 46
    .line 47
    if-eqz v3, :cond_2

    .line 48
    .line 49
    invoke-virtual {v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    .line 50
    .line 51
    .line 52
    move-result-object v3

    .line 53
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    .line 54
    .line 55
    .line 56
    move-result v4

    .line 57
    if-eqz v4, :cond_2

    .line 58
    .line 59
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 60
    .line 61
    .line 62
    move-result-object v4

    .line 63
    check-cast v4, Lh1/u;

    .line 64
    .line 65
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    .line 66
    .line 67
    .line 68
    move-result v5

    .line 69
    invoke-interface {v4, v5}, Lh1/u;->a(I)V

    .line 70
    .line 71
    .line 72
    goto :goto_0

    .line 73
    :cond_4
    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 74
    .line 75
    .line 76
    return-void
.end method

.method public final C()V
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B0:Lh1/s;

    .line 2
    .line 3
    invoke-virtual {v0}, Lh1/s;->f()V

    .line 4
    .line 5
    .line 6
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 7
    .line 8
    .line 9
    return-void
.end method

.method public final D(FF)V
    .locals 2

    .line 1
    invoke-super {p0}, Landroid/view/ViewGroup;->isAttachedToWindow()Z

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    if-nez v0, :cond_1

    .line 6
    .line 7
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 8
    .line 9
    if-nez v0, :cond_0

    .line 10
    .line 11
    new-instance v0, Landroidx/constraintlayout/motion/widget/b;

    .line 12
    .line 13
    invoke-direct {v0, p0}, Landroidx/constraintlayout/motion/widget/b;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 14
    .line 15
    .line 16
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 17
    .line 18
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 19
    .line 20
    iput p1, v0, Landroidx/constraintlayout/motion/widget/b;->a:F

    .line 21
    .line 22
    iput p2, v0, Landroidx/constraintlayout/motion/widget/b;->b:F

    .line 23
    .line 24
    return-void

    .line 25
    :cond_1
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 26
    .line 27
    .line 28
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 29
    .line 30
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 31
    .line 32
    .line 33
    iput p2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 34
    .line 35
    const/4 v0, 0x0

    .line 36
    cmpl-float p2, p2, v0

    .line 37
    .line 38
    const/high16 v1, 0x3f800000    # 1.0f

    .line 39
    .line 40
    if-eqz p2, :cond_3

    .line 41
    .line 42
    if-lez p2, :cond_2

    .line 43
    .line 44
    move v0, v1

    .line 45
    :cond_2
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    .line 46
    .line 47
    .line 48
    goto :goto_0

    .line 49
    :cond_3
    cmpl-float p2, p1, v0

    .line 50
    .line 51
    if-eqz p2, :cond_5

    .line 52
    .line 53
    cmpl-float p2, p1, v1

    .line 54
    .line 55
    if-eqz p2, :cond_5

    .line 56
    .line 57
    const/high16 p2, 0x3f000000    # 0.5f

    .line 58
    .line 59
    cmpl-float p1, p1, p2

    .line 60
    .line 61
    if-lez p1, :cond_4

    .line 62
    .line 63
    move v0, v1

    .line 64
    :cond_4
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    .line 65
    .line 66
    .line 67
    :cond_5
    :goto_0
    return-void
.end method

.method public final E(I)V
    .locals 6

    .line 1
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->SETUP:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 2
    .line 3
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 4
    .line 5
    .line 6
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 7
    .line 8
    const/4 v0, -0x1

    .line 9
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 10
    .line 11
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 12
    .line 13
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->k:Lcom/google/firebase/messaging/o;

    .line 14
    .line 15
    if-eqz v1, :cond_a

    .line 16
    .line 17
    int-to-float v2, v0

    .line 18
    iget v3, v1, Lcom/google/firebase/messaging/o;->a:I

    .line 19
    .line 20
    iget-object v4, v1, Lcom/google/firebase/messaging/o;->d:Ljava/lang/Object;

    .line 21
    .line 22
    check-cast v4, Landroid/util/SparseArray;

    .line 23
    .line 24
    iget-object v5, v1, Lcom/google/firebase/messaging/o;->c:Ljava/lang/Object;

    .line 25
    .line 26
    check-cast v5, Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 27
    .line 28
    if-ne v3, p1, :cond_6

    .line 29
    .line 30
    if-ne p1, v0, :cond_0

    .line 31
    .line 32
    const/4 p1, 0x0

    .line 33
    invoke-virtual {v4, p1}, Landroid/util/SparseArray;->valueAt(I)Ljava/lang/Object;

    .line 34
    .line 35
    .line 36
    move-result-object p1

    .line 37
    check-cast p1, Lj1/d;

    .line 38
    .line 39
    goto :goto_0

    .line 40
    :cond_0
    invoke-virtual {v4, v3}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 41
    .line 42
    .line 43
    move-result-object p1

    .line 44
    check-cast p1, Lj1/d;

    .line 45
    .line 46
    :goto_0
    iget v3, v1, Lcom/google/firebase/messaging/o;->b:I

    .line 47
    .line 48
    if-eq v3, v0, :cond_1

    .line 49
    .line 50
    iget-object v4, p1, Lj1/d;->b:Ljava/util/ArrayList;

    .line 51
    .line 52
    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 53
    .line 54
    .line 55
    move-result-object v3

    .line 56
    check-cast v3, Lj1/e;

    .line 57
    .line 58
    invoke-virtual {v3, v2, v2}, Lj1/e;->a(FF)Z

    .line 59
    .line 60
    .line 61
    move-result v3

    .line 62
    if-eqz v3, :cond_1

    .line 63
    .line 64
    goto/16 :goto_5

    .line 65
    .line 66
    :cond_1
    invoke-virtual {p1, v2, v2}, Lj1/d;->b(FF)I

    .line 67
    .line 68
    .line 69
    move-result v2

    .line 70
    iget v3, v1, Lcom/google/firebase/messaging/o;->b:I

    .line 71
    .line 72
    if-ne v3, v2, :cond_2

    .line 73
    .line 74
    goto :goto_5

    .line 75
    :cond_2
    iget-object p1, p1, Lj1/d;->b:Ljava/util/ArrayList;

    .line 76
    .line 77
    if-ne v2, v0, :cond_3

    .line 78
    .line 79
    const/4 v3, 0x0

    .line 80
    goto :goto_1

    .line 81
    :cond_3
    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 82
    .line 83
    .line 84
    move-result-object v3

    .line 85
    check-cast v3, Lj1/e;

    .line 86
    .line 87
    iget-object v3, v3, Lj1/e;->f:Landroidx/constraintlayout/widget/d;

    .line 88
    .line 89
    :goto_1
    if-ne v2, v0, :cond_4

    .line 90
    .line 91
    goto :goto_2

    .line 92
    :cond_4
    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 93
    .line 94
    .line 95
    move-result-object p1

    .line 96
    check-cast p1, Lj1/e;

    .line 97
    .line 98
    iget p1, p1, Lj1/e;->e:I

    .line 99
    .line 100
    :goto_2
    if-nez v3, :cond_5

    .line 101
    .line 102
    goto :goto_5

    .line 103
    :cond_5
    iput v2, v1, Lcom/google/firebase/messaging/o;->b:I

    .line 104
    .line 105
    invoke-virtual {v3, v5}, Landroidx/constraintlayout/widget/d;->b(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 106
    .line 107
    .line 108
    goto :goto_5

    .line 109
    :cond_6
    iput p1, v1, Lcom/google/firebase/messaging/o;->a:I

    .line 110
    .line 111
    invoke-virtual {v4, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 112
    .line 113
    .line 114
    move-result-object p1

    .line 115
    check-cast p1, Lj1/d;

    .line 116
    .line 117
    invoke-virtual {p1, v2, v2}, Lj1/d;->b(FF)I

    .line 118
    .line 119
    .line 120
    move-result v2

    .line 121
    iget-object v3, p1, Lj1/d;->b:Ljava/util/ArrayList;

    .line 122
    .line 123
    if-ne v2, v0, :cond_7

    .line 124
    .line 125
    iget-object p1, p1, Lj1/d;->d:Landroidx/constraintlayout/widget/d;

    .line 126
    .line 127
    goto :goto_3

    .line 128
    :cond_7
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 129
    .line 130
    .line 131
    move-result-object p1

    .line 132
    check-cast p1, Lj1/e;

    .line 133
    .line 134
    iget-object p1, p1, Lj1/e;->f:Landroidx/constraintlayout/widget/d;

    .line 135
    .line 136
    :goto_3
    if-ne v2, v0, :cond_8

    .line 137
    .line 138
    goto :goto_4

    .line 139
    :cond_8
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 140
    .line 141
    .line 142
    move-result-object v0

    .line 143
    check-cast v0, Lj1/e;

    .line 144
    .line 145
    iget v0, v0, Lj1/e;->e:I

    .line 146
    .line 147
    :goto_4
    if-nez p1, :cond_9

    .line 148
    .line 149
    goto :goto_5

    .line 150
    :cond_9
    iput v2, v1, Lcom/google/firebase/messaging/o;->b:I

    .line 151
    .line 152
    invoke-virtual {p1, v5}, Landroidx/constraintlayout/widget/d;->b(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 153
    .line 154
    .line 155
    goto :goto_5

    .line 156
    :cond_a
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 157
    .line 158
    if-eqz v0, :cond_b

    .line 159
    .line 160
    invoke-virtual {v0, p1}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 161
    .line 162
    .line 163
    move-result-object p1

    .line 164
    invoke-virtual {p1, p0}, Landroidx/constraintlayout/widget/d;->b(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 165
    .line 166
    .line 167
    :cond_b
    :goto_5
    return-void
.end method

.method public final F(II)V
    .locals 1

    .line 1
    invoke-super {p0}, Landroid/view/ViewGroup;->isAttachedToWindow()Z

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    if-nez v0, :cond_1

    .line 6
    .line 7
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 8
    .line 9
    if-nez v0, :cond_0

    .line 10
    .line 11
    new-instance v0, Landroidx/constraintlayout/motion/widget/b;

    .line 12
    .line 13
    invoke-direct {v0, p0}, Landroidx/constraintlayout/motion/widget/b;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 14
    .line 15
    .line 16
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 17
    .line 18
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 19
    .line 20
    iput p1, v0, Landroidx/constraintlayout/motion/widget/b;->c:I

    .line 21
    .line 22
    iput p2, v0, Landroidx/constraintlayout/motion/widget/b;->d:I

    .line 23
    .line 24
    return-void

    .line 25
    :cond_1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 26
    .line 27
    if-eqz v0, :cond_2

    .line 28
    .line 29
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 30
    .line 31
    iput p2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 32
    .line 33
    invoke-virtual {v0, p1, p2}, Landroidx/constraintlayout/motion/widget/c;->n(II)V

    .line 34
    .line 35
    .line 36
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 37
    .line 38
    invoke-virtual {v0, p1}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 39
    .line 40
    .line 41
    move-result-object p1

    .line 42
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 43
    .line 44
    invoke-virtual {v0, p2}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 45
    .line 46
    .line 47
    move-result-object p2

    .line 48
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B0:Lh1/s;

    .line 49
    .line 50
    invoke-virtual {v0, p1, p2}, Lh1/s;->e(Landroidx/constraintlayout/widget/d;Landroidx/constraintlayout/widget/d;)V

    .line 51
    .line 52
    .line 53
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->C()V

    .line 54
    .line 55
    .line 56
    const/4 p1, 0x0

    .line 57
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 58
    .line 59
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    .line 60
    .line 61
    .line 62
    :cond_2
    return-void
.end method

.method public final G(IFF)V
    .locals 15

    .line 1
    move-object v0, p0

    .line 2
    move/from16 v1, p1

    .line 3
    .line 4
    move/from16 v8, p2

    .line 5
    .line 6
    move/from16 v4, p3

    .line 7
    .line 8
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 9
    .line 10
    if-nez v2, :cond_0

    .line 11
    .line 12
    return-void

    .line 13
    :cond_0
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 14
    .line 15
    cmpl-float v2, v2, v8

    .line 16
    .line 17
    if-nez v2, :cond_1

    .line 18
    .line 19
    return-void

    .line 20
    :cond_1
    const/4 v2, 0x1

    .line 21
    iput-boolean v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->O:Z

    .line 22
    .line 23
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 24
    .line 25
    .line 26
    move-result-wide v5

    .line 27
    iput-wide v5, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D:J

    .line 28
    .line 29
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 30
    .line 31
    invoke-virtual {v3}, Landroidx/constraintlayout/motion/widget/c;->c()I

    .line 32
    .line 33
    .line 34
    move-result v3

    .line 35
    int-to-float v3, v3

    .line 36
    const/high16 v5, 0x447a0000    # 1000.0f

    .line 37
    .line 38
    div-float v5, v3, v5

    .line 39
    .line 40
    iput v5, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 41
    .line 42
    iput v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 43
    .line 44
    iput-boolean v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 45
    .line 46
    iget-object v9, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->P:Lg1/b;

    .line 47
    .line 48
    const/4 v10, 0x0

    .line 49
    const/high16 v3, 0x3f800000    # 1.0f

    .line 50
    .line 51
    const/4 v6, 0x7

    .line 52
    const/4 v7, 0x6

    .line 53
    const/4 v11, 0x2

    .line 54
    const/4 v12, 0x0

    .line 55
    if-eqz v1, :cond_7

    .line 56
    .line 57
    if-eq v1, v2, :cond_7

    .line 58
    .line 59
    if-eq v1, v11, :cond_7

    .line 60
    .line 61
    iget-object v13, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->Q:Lh1/q;

    .line 62
    .line 63
    const/4 v14, 0x4

    .line 64
    if-eq v1, v14, :cond_6

    .line 65
    .line 66
    const/4 v14, 0x5

    .line 67
    if-eq v1, v14, :cond_2

    .line 68
    .line 69
    if-eq v1, v7, :cond_7

    .line 70
    .line 71
    if-eq v1, v6, :cond_7

    .line 72
    .line 73
    goto/16 :goto_c

    .line 74
    .line 75
    :cond_2
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 76
    .line 77
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 78
    .line 79
    invoke-virtual {v2}, Landroidx/constraintlayout/motion/widget/c;->g()F

    .line 80
    .line 81
    .line 82
    move-result v2

    .line 83
    cmpl-float v5, v4, v10

    .line 84
    .line 85
    const/high16 v6, 0x40000000    # 2.0f

    .line 86
    .line 87
    if-lez v5, :cond_3

    .line 88
    .line 89
    div-float v5, v4, v2

    .line 90
    .line 91
    mul-float v7, v4, v5

    .line 92
    .line 93
    mul-float/2addr v2, v5

    .line 94
    mul-float/2addr v2, v5

    .line 95
    div-float/2addr v2, v6

    .line 96
    sub-float/2addr v7, v2

    .line 97
    add-float/2addr v7, v1

    .line 98
    cmpl-float v1, v7, v3

    .line 99
    .line 100
    if-lez v1, :cond_4

    .line 101
    .line 102
    goto :goto_0

    .line 103
    :cond_3
    neg-float v3, v4

    .line 104
    div-float/2addr v3, v2

    .line 105
    mul-float v5, v4, v3

    .line 106
    .line 107
    mul-float/2addr v2, v3

    .line 108
    mul-float/2addr v2, v3

    .line 109
    div-float/2addr v2, v6

    .line 110
    add-float/2addr v2, v5

    .line 111
    add-float/2addr v2, v1

    .line 112
    cmpg-float v1, v2, v10

    .line 113
    .line 114
    if-gez v1, :cond_4

    .line 115
    .line 116
    :goto_0
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 117
    .line 118
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 119
    .line 120
    invoke-virtual {v2}, Landroidx/constraintlayout/motion/widget/c;->g()F

    .line 121
    .line 122
    .line 123
    move-result v2

    .line 124
    iput v4, v13, Lh1/q;->a:F

    .line 125
    .line 126
    iput v1, v13, Lh1/q;->b:F

    .line 127
    .line 128
    iput v2, v13, Lh1/q;->c:F

    .line 129
    .line 130
    iput-object v13, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 131
    .line 132
    goto/16 :goto_c

    .line 133
    .line 134
    :cond_4
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 135
    .line 136
    iget v5, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 137
    .line 138
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 139
    .line 140
    invoke-virtual {v1}, Landroidx/constraintlayout/motion/widget/c;->g()F

    .line 141
    .line 142
    .line 143
    move-result v6

    .line 144
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 145
    .line 146
    iget-object v1, v1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 147
    .line 148
    if-eqz v1, :cond_5

    .line 149
    .line 150
    iget-object v1, v1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 151
    .line 152
    if-eqz v1, :cond_5

    .line 153
    .line 154
    iget v1, v1, Landroidx/constraintlayout/motion/widget/d;->s:F

    .line 155
    .line 156
    move v7, v1

    .line 157
    goto :goto_1

    .line 158
    :cond_5
    move v7, v10

    .line 159
    :goto_1
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->P:Lg1/b;

    .line 160
    .line 161
    move/from16 v3, p2

    .line 162
    .line 163
    move/from16 v4, p3

    .line 164
    .line 165
    invoke-virtual/range {v1 .. v7}, Lg1/b;->b(FFFFFF)V

    .line 166
    .line 167
    .line 168
    iput v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 169
    .line 170
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 171
    .line 172
    iput v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 173
    .line 174
    iput v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 175
    .line 176
    iput-object v9, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 177
    .line 178
    goto/16 :goto_c

    .line 179
    .line 180
    :cond_6
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 181
    .line 182
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 183
    .line 184
    invoke-virtual {v2}, Landroidx/constraintlayout/motion/widget/c;->g()F

    .line 185
    .line 186
    .line 187
    move-result v2

    .line 188
    iput v4, v13, Lh1/q;->a:F

    .line 189
    .line 190
    iput v1, v13, Lh1/q;->b:F

    .line 191
    .line 192
    iput v2, v13, Lh1/q;->c:F

    .line 193
    .line 194
    iput-object v13, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 195
    .line 196
    goto/16 :goto_c

    .line 197
    .line 198
    :cond_7
    if-eq v1, v2, :cond_a

    .line 199
    .line 200
    if-ne v1, v6, :cond_8

    .line 201
    .line 202
    goto :goto_2

    .line 203
    :cond_8
    if-eq v1, v11, :cond_9

    .line 204
    .line 205
    if-ne v1, v7, :cond_b

    .line 206
    .line 207
    :cond_9
    move v8, v3

    .line 208
    goto :goto_3

    .line 209
    :cond_a
    :goto_2
    move v8, v10

    .line 210
    :cond_b
    :goto_3
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 211
    .line 212
    iget-object v2, v1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 213
    .line 214
    if-eqz v2, :cond_c

    .line 215
    .line 216
    iget-object v3, v2, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 217
    .line 218
    if-eqz v3, :cond_c

    .line 219
    .line 220
    iget v3, v3, Landroidx/constraintlayout/motion/widget/d;->D:I

    .line 221
    .line 222
    goto :goto_4

    .line 223
    :cond_c
    move v3, v12

    .line 224
    :goto_4
    if-nez v3, :cond_e

    .line 225
    .line 226
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 227
    .line 228
    invoke-virtual {v1}, Landroidx/constraintlayout/motion/widget/c;->g()F

    .line 229
    .line 230
    .line 231
    move-result v6

    .line 232
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 233
    .line 234
    iget-object v1, v1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 235
    .line 236
    if-eqz v1, :cond_d

    .line 237
    .line 238
    iget-object v1, v1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 239
    .line 240
    if-eqz v1, :cond_d

    .line 241
    .line 242
    iget v1, v1, Landroidx/constraintlayout/motion/widget/d;->s:F

    .line 243
    .line 244
    move v7, v1

    .line 245
    goto :goto_5

    .line 246
    :cond_d
    move v7, v10

    .line 247
    :goto_5
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->P:Lg1/b;

    .line 248
    .line 249
    move v3, v8

    .line 250
    move/from16 v4, p3

    .line 251
    .line 252
    invoke-virtual/range {v1 .. v7}, Lg1/b;->b(FFFFFF)V

    .line 253
    .line 254
    .line 255
    goto :goto_b

    .line 256
    :cond_e
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 257
    .line 258
    if-eqz v2, :cond_f

    .line 259
    .line 260
    iget-object v3, v2, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 261
    .line 262
    if-eqz v3, :cond_f

    .line 263
    .line 264
    iget v3, v3, Landroidx/constraintlayout/motion/widget/d;->z:F

    .line 265
    .line 266
    goto :goto_6

    .line 267
    :cond_f
    move v3, v10

    .line 268
    :goto_6
    if-eqz v2, :cond_10

    .line 269
    .line 270
    iget-object v4, v2, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 271
    .line 272
    if-eqz v4, :cond_10

    .line 273
    .line 274
    iget v4, v4, Landroidx/constraintlayout/motion/widget/d;->A:F

    .line 275
    .line 276
    goto :goto_7

    .line 277
    :cond_10
    move v4, v10

    .line 278
    :goto_7
    if-eqz v2, :cond_11

    .line 279
    .line 280
    iget-object v5, v2, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 281
    .line 282
    if-eqz v5, :cond_11

    .line 283
    .line 284
    iget v5, v5, Landroidx/constraintlayout/motion/widget/d;->y:F

    .line 285
    .line 286
    goto :goto_8

    .line 287
    :cond_11
    move v5, v10

    .line 288
    :goto_8
    if-eqz v2, :cond_12

    .line 289
    .line 290
    iget-object v6, v2, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 291
    .line 292
    if-eqz v6, :cond_12

    .line 293
    .line 294
    iget v6, v6, Landroidx/constraintlayout/motion/widget/d;->B:F

    .line 295
    .line 296
    goto :goto_9

    .line 297
    :cond_12
    move v6, v10

    .line 298
    :goto_9
    if-eqz v2, :cond_13

    .line 299
    .line 300
    iget-object v2, v2, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 301
    .line 302
    if-eqz v2, :cond_13

    .line 303
    .line 304
    iget v2, v2, Landroidx/constraintlayout/motion/widget/d;->C:I

    .line 305
    .line 306
    goto :goto_a

    .line 307
    :cond_13
    move v2, v12

    .line 308
    :goto_a
    iget-object v7, v9, Lg1/b;->b:Lb1/j;

    .line 309
    .line 310
    if-nez v7, :cond_14

    .line 311
    .line 312
    new-instance v7, Lb1/j;

    .line 313
    .line 314
    invoke-direct {v7}, Ljava/lang/Object;-><init>()V

    .line 315
    .line 316
    .line 317
    const-wide/high16 v13, 0x3fe0000000000000L    # 0.5

    .line 318
    .line 319
    iput-wide v13, v7, Lb1/j;->a:D

    .line 320
    .line 321
    iput v12, v7, Lb1/j;->i:I

    .line 322
    .line 323
    iput-object v7, v9, Lg1/b;->b:Lb1/j;

    .line 324
    .line 325
    :cond_14
    iget-object v7, v9, Lg1/b;->b:Lb1/j;

    .line 326
    .line 327
    iput-object v7, v9, Lg1/b;->c:Lb1/l;

    .line 328
    .line 329
    float-to-double v13, v8

    .line 330
    iput-wide v13, v7, Lb1/j;->c:D

    .line 331
    .line 332
    float-to-double v13, v5

    .line 333
    iput-wide v13, v7, Lb1/j;->a:D

    .line 334
    .line 335
    iput v1, v7, Lb1/j;->e:F

    .line 336
    .line 337
    float-to-double v4, v4

    .line 338
    iput-wide v4, v7, Lb1/j;->b:D

    .line 339
    .line 340
    iput v3, v7, Lb1/j;->g:F

    .line 341
    .line 342
    iput v6, v7, Lb1/j;->h:F

    .line 343
    .line 344
    iput v2, v7, Lb1/j;->i:I

    .line 345
    .line 346
    iput v10, v7, Lb1/j;->d:F

    .line 347
    .line 348
    :goto_b
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 349
    .line 350
    iput v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 351
    .line 352
    iput v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 353
    .line 354
    iput-object v9, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 355
    .line 356
    :goto_c
    iput-boolean v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->J:Z

    .line 357
    .line 358
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 359
    .line 360
    .line 361
    move-result-wide v1

    .line 362
    iput-wide v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D:J

    .line 363
    .line 364
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 365
    .line 366
    .line 367
    return-void
.end method

.method public final H()V
    .locals 1

    .line 1
    const/high16 v0, 0x3f800000    # 1.0f

    .line 2
    .line 3
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    .line 4
    .line 5
    .line 6
    const/4 v0, 0x0

    .line 7
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x0:Lcom/vungle/ads/internal/util/d;

    .line 8
    .line 9
    return-void
.end method

.method public final I(I)V
    .locals 14

    .line 1
    invoke-super {p0}, Landroid/view/ViewGroup;->isAttachedToWindow()Z

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    if-nez v0, :cond_1

    .line 6
    .line 7
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 8
    .line 9
    if-nez v0, :cond_0

    .line 10
    .line 11
    new-instance v0, Landroidx/constraintlayout/motion/widget/b;

    .line 12
    .line 13
    invoke-direct {v0, p0}, Landroidx/constraintlayout/motion/widget/b;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 14
    .line 15
    .line 16
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 17
    .line 18
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 19
    .line 20
    iput p1, v0, Landroidx/constraintlayout/motion/widget/b;->d:I

    .line 21
    .line 22
    return-void

    .line 23
    :cond_1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 24
    .line 25
    const/4 v1, -0x1

    .line 26
    const/4 v2, 0x0

    .line 27
    if-eqz v0, :cond_b

    .line 28
    .line 29
    iget-object v0, v0, Landroidx/constraintlayout/motion/widget/c;->b:Landroidx/compose/animation/core/u;

    .line 30
    .line 31
    if-eqz v0, :cond_b

    .line 32
    .line 33
    iget v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 34
    .line 35
    int-to-float v4, v1

    .line 36
    iget-object v0, v0, Landroidx/compose/animation/core/u;->b:Ljava/lang/Object;

    .line 37
    .line 38
    check-cast v0, Landroid/util/SparseArray;

    .line 39
    .line 40
    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 41
    .line 42
    .line 43
    move-result-object v0

    .line 44
    check-cast v0, Lj1/p;

    .line 45
    .line 46
    if-nez v0, :cond_2

    .line 47
    .line 48
    move v3, p1

    .line 49
    goto :goto_2

    .line 50
    :cond_2
    const/high16 v5, -0x40800000    # -1.0f

    .line 51
    .line 52
    cmpl-float v5, v4, v5

    .line 53
    .line 54
    iget-object v6, v0, Lj1/p;->b:Ljava/util/ArrayList;

    .line 55
    .line 56
    iget v0, v0, Lj1/p;->c:I

    .line 57
    .line 58
    if-eqz v5, :cond_8

    .line 59
    .line 60
    if-nez v5, :cond_3

    .line 61
    .line 62
    goto :goto_1

    .line 63
    :cond_3
    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 64
    .line 65
    .line 66
    move-result-object v5

    .line 67
    move-object v6, v2

    .line 68
    :cond_4
    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    .line 69
    .line 70
    .line 71
    move-result v7

    .line 72
    if-eqz v7, :cond_6

    .line 73
    .line 74
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 75
    .line 76
    .line 77
    move-result-object v7

    .line 78
    check-cast v7, Lj1/q;

    .line 79
    .line 80
    invoke-virtual {v7, v4, v4}, Lj1/q;->a(FF)Z

    .line 81
    .line 82
    .line 83
    move-result v8

    .line 84
    if-eqz v8, :cond_4

    .line 85
    .line 86
    iget v6, v7, Lj1/q;->e:I

    .line 87
    .line 88
    if-ne v3, v6, :cond_5

    .line 89
    .line 90
    goto :goto_2

    .line 91
    :cond_5
    move-object v6, v7

    .line 92
    goto :goto_0

    .line 93
    :cond_6
    if-eqz v6, :cond_7

    .line 94
    .line 95
    iget v3, v6, Lj1/q;->e:I

    .line 96
    .line 97
    goto :goto_2

    .line 98
    :cond_7
    move v3, v0

    .line 99
    goto :goto_2

    .line 100
    :cond_8
    :goto_1
    if-ne v0, v3, :cond_9

    .line 101
    .line 102
    goto :goto_2

    .line 103
    :cond_9
    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 104
    .line 105
    .line 106
    move-result-object v4

    .line 107
    :cond_a
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    .line 108
    .line 109
    .line 110
    move-result v5

    .line 111
    if-eqz v5, :cond_7

    .line 112
    .line 113
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 114
    .line 115
    .line 116
    move-result-object v5

    .line 117
    check-cast v5, Lj1/q;

    .line 118
    .line 119
    iget v5, v5, Lj1/q;->e:I

    .line 120
    .line 121
    if-ne v3, v5, :cond_a

    .line 122
    .line 123
    :goto_2
    if-eq v3, v1, :cond_b

    .line 124
    .line 125
    move p1, v3

    .line 126
    :cond_b
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 127
    .line 128
    if-ne v0, p1, :cond_c

    .line 129
    .line 130
    goto/16 :goto_11

    .line 131
    .line 132
    :cond_c
    iget v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 133
    .line 134
    const/4 v4, 0x0

    .line 135
    if-ne v3, p1, :cond_d

    .line 136
    .line 137
    invoke-virtual {p0, v4}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    .line 138
    .line 139
    .line 140
    goto/16 :goto_11

    .line 141
    .line 142
    :cond_d
    iget v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 143
    .line 144
    const/high16 v5, 0x3f800000    # 1.0f

    .line 145
    .line 146
    if-ne v3, p1, :cond_e

    .line 147
    .line 148
    invoke-virtual {p0, v5}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    .line 149
    .line 150
    .line 151
    goto/16 :goto_11

    .line 152
    .line 153
    :cond_e
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 154
    .line 155
    if-eq v0, v1, :cond_f

    .line 156
    .line 157
    invoke-virtual {p0, v0, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->F(II)V

    .line 158
    .line 159
    .line 160
    invoke-virtual {p0, v5}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    .line 161
    .line 162
    .line 163
    iput v4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 164
    .line 165
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->H()V

    .line 166
    .line 167
    .line 168
    goto/16 :goto_11

    .line 169
    .line 170
    :cond_f
    const/4 v0, 0x0

    .line 171
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->O:Z

    .line 172
    .line 173
    iput v5, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 174
    .line 175
    iput v4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 176
    .line 177
    iput v4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 178
    .line 179
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 180
    .line 181
    .line 182
    move-result-wide v6

    .line 183
    iput-wide v6, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H:J

    .line 184
    .line 185
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 186
    .line 187
    .line 188
    move-result-wide v6

    .line 189
    iput-wide v6, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D:J

    .line 190
    .line 191
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->J:Z

    .line 192
    .line 193
    iput-object v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 194
    .line 195
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 196
    .line 197
    invoke-virtual {v3}, Landroidx/constraintlayout/motion/widget/c;->c()I

    .line 198
    .line 199
    .line 200
    move-result v3

    .line 201
    int-to-float v3, v3

    .line 202
    const/high16 v6, 0x447a0000    # 1000.0f

    .line 203
    .line 204
    div-float/2addr v3, v6

    .line 205
    iput v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 206
    .line 207
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 208
    .line 209
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 210
    .line 211
    iget v6, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 212
    .line 213
    invoke-virtual {v3, v1, v6}, Landroidx/constraintlayout/motion/widget/c;->n(II)V

    .line 214
    .line 215
    .line 216
    new-instance v1, Landroid/util/SparseArray;

    .line 217
    .line 218
    invoke-direct {v1}, Landroid/util/SparseArray;-><init>()V

    .line 219
    .line 220
    .line 221
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 222
    .line 223
    .line 224
    move-result v3

    .line 225
    iget-object v6, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 226
    .line 227
    invoke-virtual {v6}, Ljava/util/HashMap;->clear()V

    .line 228
    .line 229
    .line 230
    move v7, v0

    .line 231
    :goto_3
    if-ge v7, v3, :cond_10

    .line 232
    .line 233
    invoke-virtual {p0, v7}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 234
    .line 235
    .line 236
    move-result-object v8

    .line 237
    new-instance v9, Lh1/n;

    .line 238
    .line 239
    invoke-direct {v9, v8}, Lh1/n;-><init>(Landroid/view/View;)V

    .line 240
    .line 241
    .line 242
    invoke-virtual {v6, v8, v9}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 243
    .line 244
    .line 245
    invoke-virtual {v8}, Landroid/view/View;->getId()I

    .line 246
    .line 247
    .line 248
    move-result v9

    .line 249
    invoke-virtual {v6, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 250
    .line 251
    .line 252
    move-result-object v8

    .line 253
    check-cast v8, Lh1/n;

    .line 254
    .line 255
    invoke-virtual {v1, v9, v8}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 256
    .line 257
    .line 258
    add-int/lit8 v7, v7, 0x1

    .line 259
    .line 260
    goto :goto_3

    .line 261
    :cond_10
    const/4 v1, 0x1

    .line 262
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 263
    .line 264
    iget-object v7, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 265
    .line 266
    invoke-virtual {v7, p1}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 267
    .line 268
    .line 269
    move-result-object p1

    .line 270
    iget-object v7, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B0:Lh1/s;

    .line 271
    .line 272
    invoke-virtual {v7, v2, p1}, Lh1/s;->e(Landroidx/constraintlayout/widget/d;Landroidx/constraintlayout/widget/d;)V

    .line 273
    .line 274
    .line 275
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->C()V

    .line 276
    .line 277
    .line 278
    invoke-virtual {v7}, Lh1/s;->a()V

    .line 279
    .line 280
    .line 281
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 282
    .line 283
    .line 284
    move-result p1

    .line 285
    move v2, v0

    .line 286
    :goto_4
    if-ge v2, p1, :cond_13

    .line 287
    .line 288
    invoke-virtual {p0, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 289
    .line 290
    .line 291
    move-result-object v7

    .line 292
    invoke-virtual {v6, v7}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 293
    .line 294
    .line 295
    move-result-object v8

    .line 296
    check-cast v8, Lh1/n;

    .line 297
    .line 298
    if-nez v8, :cond_11

    .line 299
    .line 300
    goto/16 :goto_6

    .line 301
    .line 302
    :cond_11
    iget-object v9, v8, Lh1/n;->f:Lh1/v;

    .line 303
    .line 304
    iput v4, v9, Lh1/v;->c:F

    .line 305
    .line 306
    iput v4, v9, Lh1/v;->d:F

    .line 307
    .line 308
    invoke-virtual {v7}, Landroid/view/View;->getX()F

    .line 309
    .line 310
    .line 311
    move-result v10

    .line 312
    invoke-virtual {v7}, Landroid/view/View;->getY()F

    .line 313
    .line 314
    .line 315
    move-result v11

    .line 316
    invoke-virtual {v7}, Landroid/view/View;->getWidth()I

    .line 317
    .line 318
    .line 319
    move-result v12

    .line 320
    int-to-float v12, v12

    .line 321
    invoke-virtual {v7}, Landroid/view/View;->getHeight()I

    .line 322
    .line 323
    .line 324
    move-result v13

    .line 325
    int-to-float v13, v13

    .line 326
    invoke-virtual {v9, v10, v11, v12, v13}, Lh1/v;->f(FFFF)V

    .line 327
    .line 328
    .line 329
    iget-object v8, v8, Lh1/n;->h:Lh1/l;

    .line 330
    .line 331
    invoke-virtual {v8}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 332
    .line 333
    .line 334
    invoke-virtual {v7}, Landroid/view/View;->getX()F

    .line 335
    .line 336
    .line 337
    invoke-virtual {v7}, Landroid/view/View;->getY()F

    .line 338
    .line 339
    .line 340
    invoke-virtual {v7}, Landroid/view/View;->getWidth()I

    .line 341
    .line 342
    .line 343
    invoke-virtual {v7}, Landroid/view/View;->getHeight()I

    .line 344
    .line 345
    .line 346
    invoke-virtual {v7}, Landroid/view/View;->getVisibility()I

    .line 347
    .line 348
    .line 349
    move-result v9

    .line 350
    iput v9, v8, Lh1/l;->c:I

    .line 351
    .line 352
    invoke-virtual {v7}, Landroid/view/View;->getVisibility()I

    .line 353
    .line 354
    .line 355
    move-result v9

    .line 356
    if-eqz v9, :cond_12

    .line 357
    .line 358
    move v9, v4

    .line 359
    goto :goto_5

    .line 360
    :cond_12
    invoke-virtual {v7}, Landroid/view/View;->getAlpha()F

    .line 361
    .line 362
    .line 363
    move-result v9

    .line 364
    :goto_5
    iput v9, v8, Lh1/l;->a:F

    .line 365
    .line 366
    invoke-virtual {v7}, Landroid/view/View;->getElevation()F

    .line 367
    .line 368
    .line 369
    move-result v9

    .line 370
    iput v9, v8, Lh1/l;->d:F

    .line 371
    .line 372
    invoke-virtual {v7}, Landroid/view/View;->getRotation()F

    .line 373
    .line 374
    .line 375
    move-result v9

    .line 376
    iput v9, v8, Lh1/l;->e:F

    .line 377
    .line 378
    invoke-virtual {v7}, Landroid/view/View;->getRotationX()F

    .line 379
    .line 380
    .line 381
    move-result v9

    .line 382
    iput v9, v8, Lh1/l;->f:F

    .line 383
    .line 384
    invoke-virtual {v7}, Landroid/view/View;->getRotationY()F

    .line 385
    .line 386
    .line 387
    move-result v9

    .line 388
    iput v9, v8, Lh1/l;->g:F

    .line 389
    .line 390
    invoke-virtual {v7}, Landroid/view/View;->getScaleX()F

    .line 391
    .line 392
    .line 393
    move-result v9

    .line 394
    iput v9, v8, Lh1/l;->h:F

    .line 395
    .line 396
    invoke-virtual {v7}, Landroid/view/View;->getScaleY()F

    .line 397
    .line 398
    .line 399
    move-result v9

    .line 400
    iput v9, v8, Lh1/l;->i:F

    .line 401
    .line 402
    invoke-virtual {v7}, Landroid/view/View;->getPivotX()F

    .line 403
    .line 404
    .line 405
    move-result v9

    .line 406
    iput v9, v8, Lh1/l;->j:F

    .line 407
    .line 408
    invoke-virtual {v7}, Landroid/view/View;->getPivotY()F

    .line 409
    .line 410
    .line 411
    move-result v9

    .line 412
    iput v9, v8, Lh1/l;->k:F

    .line 413
    .line 414
    invoke-virtual {v7}, Landroid/view/View;->getTranslationX()F

    .line 415
    .line 416
    .line 417
    move-result v9

    .line 418
    iput v9, v8, Lh1/l;->l:F

    .line 419
    .line 420
    invoke-virtual {v7}, Landroid/view/View;->getTranslationY()F

    .line 421
    .line 422
    .line 423
    move-result v9

    .line 424
    iput v9, v8, Lh1/l;->m:F

    .line 425
    .line 426
    invoke-virtual {v7}, Landroid/view/View;->getTranslationZ()F

    .line 427
    .line 428
    .line 429
    move-result v7

    .line 430
    iput v7, v8, Lh1/l;->n:F

    .line 431
    .line 432
    :goto_6
    add-int/lit8 v2, v2, 0x1

    .line 433
    .line 434
    goto/16 :goto_4

    .line 435
    .line 436
    :cond_13
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    .line 437
    .line 438
    .line 439
    move-result p1

    .line 440
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    .line 441
    .line 442
    .line 443
    move-result v2

    .line 444
    iget-object v7, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 445
    .line 446
    if-eqz v7, :cond_18

    .line 447
    .line 448
    move v7, v0

    .line 449
    :goto_7
    if-ge v7, v3, :cond_15

    .line 450
    .line 451
    invoke-virtual {p0, v7}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 452
    .line 453
    .line 454
    move-result-object v8

    .line 455
    invoke-virtual {v6, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 456
    .line 457
    .line 458
    move-result-object v8

    .line 459
    check-cast v8, Lh1/n;

    .line 460
    .line 461
    if-nez v8, :cond_14

    .line 462
    .line 463
    goto :goto_8

    .line 464
    :cond_14
    iget-object v9, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 465
    .line 466
    invoke-virtual {v9, v8}, Landroidx/constraintlayout/motion/widget/c;->f(Lh1/n;)V

    .line 467
    .line 468
    .line 469
    :goto_8
    add-int/lit8 v7, v7, 0x1

    .line 470
    .line 471
    goto :goto_7

    .line 472
    :cond_15
    iget-object v7, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 473
    .line 474
    invoke-virtual {v7}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 475
    .line 476
    .line 477
    move-result-object v7

    .line 478
    :goto_9
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    .line 479
    .line 480
    .line 481
    move-result v8

    .line 482
    if-eqz v8, :cond_16

    .line 483
    .line 484
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 485
    .line 486
    .line 487
    move-result-object v8

    .line 488
    check-cast v8, Landroidx/constraintlayout/motion/widget/MotionHelper;

    .line 489
    .line 490
    invoke-virtual {v8, p0, v6}, Landroidx/constraintlayout/motion/widget/MotionHelper;->r(Landroidx/constraintlayout/motion/widget/MotionLayout;Ljava/util/HashMap;)V

    .line 491
    .line 492
    .line 493
    goto :goto_9

    .line 494
    :cond_16
    move v7, v0

    .line 495
    :goto_a
    if-ge v7, v3, :cond_1a

    .line 496
    .line 497
    invoke-virtual {p0, v7}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 498
    .line 499
    .line 500
    move-result-object v8

    .line 501
    invoke-virtual {v6, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 502
    .line 503
    .line 504
    move-result-object v8

    .line 505
    check-cast v8, Lh1/n;

    .line 506
    .line 507
    if-nez v8, :cond_17

    .line 508
    .line 509
    goto :goto_b

    .line 510
    :cond_17
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 511
    .line 512
    .line 513
    move-result-wide v9

    .line 514
    invoke-virtual {v8, p1, v2, v9, v10}, Lh1/n;->h(IIJ)V

    .line 515
    .line 516
    .line 517
    :goto_b
    add-int/lit8 v7, v7, 0x1

    .line 518
    .line 519
    goto :goto_a

    .line 520
    :cond_18
    move v7, v0

    .line 521
    :goto_c
    if-ge v7, v3, :cond_1a

    .line 522
    .line 523
    invoke-virtual {p0, v7}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 524
    .line 525
    .line 526
    move-result-object v8

    .line 527
    invoke-virtual {v6, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 528
    .line 529
    .line 530
    move-result-object v8

    .line 531
    check-cast v8, Lh1/n;

    .line 532
    .line 533
    if-nez v8, :cond_19

    .line 534
    .line 535
    goto :goto_d

    .line 536
    :cond_19
    iget-object v9, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 537
    .line 538
    invoke-virtual {v9, v8}, Landroidx/constraintlayout/motion/widget/c;->f(Lh1/n;)V

    .line 539
    .line 540
    .line 541
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 542
    .line 543
    .line 544
    move-result-wide v9

    .line 545
    invoke-virtual {v8, p1, v2, v9, v10}, Lh1/n;->h(IIJ)V

    .line 546
    .line 547
    .line 548
    :goto_d
    add-int/lit8 v7, v7, 0x1

    .line 549
    .line 550
    goto :goto_c

    .line 551
    :cond_1a
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 552
    .line 553
    iget-object p1, p1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 554
    .line 555
    if-eqz p1, :cond_1b

    .line 556
    .line 557
    iget p1, p1, Lh1/x;->i:F

    .line 558
    .line 559
    goto :goto_e

    .line 560
    :cond_1b
    move p1, v4

    .line 561
    :goto_e
    cmpl-float v2, p1, v4

    .line 562
    .line 563
    if-eqz v2, :cond_1d

    .line 564
    .line 565
    const v2, 0x7f7fffff    # Float.MAX_VALUE

    .line 566
    .line 567
    .line 568
    const v7, -0x800001

    .line 569
    .line 570
    .line 571
    move v8, v0

    .line 572
    :goto_f
    if-ge v8, v3, :cond_1c

    .line 573
    .line 574
    invoke-virtual {p0, v8}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 575
    .line 576
    .line 577
    move-result-object v9

    .line 578
    invoke-virtual {v6, v9}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 579
    .line 580
    .line 581
    move-result-object v9

    .line 582
    check-cast v9, Lh1/n;

    .line 583
    .line 584
    iget-object v9, v9, Lh1/n;->g:Lh1/v;

    .line 585
    .line 586
    iget v10, v9, Lh1/v;->e:F

    .line 587
    .line 588
    iget v9, v9, Lh1/v;->f:F

    .line 589
    .line 590
    add-float/2addr v9, v10

    .line 591
    invoke-static {v2, v9}, Ljava/lang/Math;->min(FF)F

    .line 592
    .line 593
    .line 594
    move-result v2

    .line 595
    invoke-static {v7, v9}, Ljava/lang/Math;->max(FF)F

    .line 596
    .line 597
    .line 598
    move-result v7

    .line 599
    add-int/lit8 v8, v8, 0x1

    .line 600
    .line 601
    goto :goto_f

    .line 602
    :cond_1c
    :goto_10
    if-ge v0, v3, :cond_1d

    .line 603
    .line 604
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 605
    .line 606
    .line 607
    move-result-object v8

    .line 608
    invoke-virtual {v6, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 609
    .line 610
    .line 611
    move-result-object v8

    .line 612
    check-cast v8, Lh1/n;

    .line 613
    .line 614
    iget-object v9, v8, Lh1/n;->g:Lh1/v;

    .line 615
    .line 616
    iget v10, v9, Lh1/v;->e:F

    .line 617
    .line 618
    iget v9, v9, Lh1/v;->f:F

    .line 619
    .line 620
    sub-float v11, v5, p1

    .line 621
    .line 622
    div-float v11, v5, v11

    .line 623
    .line 624
    iput v11, v8, Lh1/n;->n:F

    .line 625
    .line 626
    add-float/2addr v10, v9

    .line 627
    sub-float/2addr v10, v2

    .line 628
    mul-float/2addr v10, p1

    .line 629
    sub-float v9, v7, v2

    .line 630
    .line 631
    div-float/2addr v10, v9

    .line 632
    sub-float v9, p1, v10

    .line 633
    .line 634
    iput v9, v8, Lh1/n;->m:F

    .line 635
    .line 636
    add-int/lit8 v0, v0, 0x1

    .line 637
    .line 638
    goto :goto_10

    .line 639
    :cond_1d
    iput v4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 640
    .line 641
    iput v4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 642
    .line 643
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 644
    .line 645
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 646
    .line 647
    .line 648
    :goto_11
    return-void
.end method

.method public final J(ILandroidx/constraintlayout/widget/d;)V
    .locals 3

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-eqz v0, :cond_0

    .line 4
    .line 5
    iget-object v0, v0, Landroidx/constraintlayout/motion/widget/c;->g:Landroid/util/SparseArray;

    .line 6
    .line 7
    invoke-virtual {v0, p1, p2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 8
    .line 9
    .line 10
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 11
    .line 12
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 13
    .line 14
    invoke-virtual {v0, v1}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 15
    .line 16
    .line 17
    move-result-object v0

    .line 18
    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 19
    .line 20
    iget v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 21
    .line 22
    invoke-virtual {v1, v2}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 23
    .line 24
    .line 25
    move-result-object v1

    .line 26
    iget-object v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B0:Lh1/s;

    .line 27
    .line 28
    invoke-virtual {v2, v0, v1}, Lh1/s;->e(Landroidx/constraintlayout/widget/d;Landroidx/constraintlayout/widget/d;)V

    .line 29
    .line 30
    .line 31
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->C()V

    .line 32
    .line 33
    .line 34
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 35
    .line 36
    if-ne v0, p1, :cond_1

    .line 37
    .line 38
    invoke-virtual {p2, p0}, Landroidx/constraintlayout/widget/d;->b(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 39
    .line 40
    .line 41
    :cond_1
    return-void
.end method

.method public final b(ILandroid/view/View;)V
    .locals 11

    .line 1
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-eqz p1, :cond_6

    .line 4
    .line 5
    iget p2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->b0:F

    .line 6
    .line 7
    const/4 v0, 0x0

    .line 8
    cmpl-float v1, p2, v0

    .line 9
    .line 10
    if-nez v1, :cond_0

    .line 11
    .line 12
    goto/16 :goto_3

    .line 13
    .line 14
    :cond_0
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->V:F

    .line 15
    .line 16
    div-float/2addr v1, p2

    .line 17
    iget v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->W:F

    .line 18
    .line 19
    div-float/2addr v2, p2

    .line 20
    iget-object p1, p1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 21
    .line 22
    if-eqz p1, :cond_6

    .line 23
    .line 24
    iget-object p1, p1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 25
    .line 26
    if-eqz p1, :cond_6

    .line 27
    .line 28
    const/4 p2, 0x0

    .line 29
    iput-boolean p2, p1, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 30
    .line 31
    iget-object v3, p1, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 32
    .line 33
    invoke-virtual {v3}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 34
    .line 35
    .line 36
    move-result v10

    .line 37
    iget v5, p1, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 38
    .line 39
    iget v7, p1, Landroidx/constraintlayout/motion/widget/d;->h:F

    .line 40
    .line 41
    iget v8, p1, Landroidx/constraintlayout/motion/widget/d;->g:F

    .line 42
    .line 43
    iget-object v9, p1, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 44
    .line 45
    iget-object v4, p1, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 46
    .line 47
    move v6, v10

    .line 48
    invoke-virtual/range {v4 .. v9}, Landroidx/constraintlayout/motion/widget/MotionLayout;->w(IFFF[F)V

    .line 49
    .line 50
    .line 51
    iget v4, p1, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 52
    .line 53
    iget-object v5, p1, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 54
    .line 55
    aget v6, v5, p2

    .line 56
    .line 57
    iget v7, p1, Landroidx/constraintlayout/motion/widget/d;->l:F

    .line 58
    .line 59
    const/4 v8, 0x1

    .line 60
    aget v5, v5, v8

    .line 61
    .line 62
    cmpl-float v9, v4, v0

    .line 63
    .line 64
    if-eqz v9, :cond_1

    .line 65
    .line 66
    mul-float/2addr v1, v4

    .line 67
    div-float/2addr v1, v6

    .line 68
    goto :goto_0

    .line 69
    :cond_1
    mul-float/2addr v2, v7

    .line 70
    div-float v1, v2, v5

    .line 71
    .line 72
    :goto_0
    invoke-static {v1}, Ljava/lang/Float;->isNaN(F)Z

    .line 73
    .line 74
    .line 75
    move-result v2

    .line 76
    if-nez v2, :cond_2

    .line 77
    .line 78
    const/high16 v2, 0x40400000    # 3.0f

    .line 79
    .line 80
    div-float v2, v1, v2

    .line 81
    .line 82
    add-float/2addr v10, v2

    .line 83
    :cond_2
    cmpl-float v2, v10, v0

    .line 84
    .line 85
    if-eqz v2, :cond_6

    .line 86
    .line 87
    const/high16 v2, 0x3f800000    # 1.0f

    .line 88
    .line 89
    cmpl-float v4, v10, v2

    .line 90
    .line 91
    if-eqz v4, :cond_3

    .line 92
    .line 93
    move v4, v8

    .line 94
    goto :goto_1

    .line 95
    :cond_3
    move v4, p2

    .line 96
    :goto_1
    iget p1, p1, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 97
    .line 98
    const/4 v5, 0x3

    .line 99
    if-eq p1, v5, :cond_4

    .line 100
    .line 101
    move p2, v8

    .line 102
    :cond_4
    and-int/2addr p2, v4

    .line 103
    if-eqz p2, :cond_6

    .line 104
    .line 105
    float-to-double v4, v10

    .line 106
    const-wide/high16 v6, 0x3fe0000000000000L    # 0.5

    .line 107
    .line 108
    cmpg-double p2, v4, v6

    .line 109
    .line 110
    if-gez p2, :cond_5

    .line 111
    .line 112
    goto :goto_2

    .line 113
    :cond_5
    move v0, v2

    .line 114
    :goto_2
    invoke-virtual {v3, p1, v0, v1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->G(IFF)V

    .line 115
    .line 116
    .line 117
    :cond_6
    :goto_3
    return-void
.end method

.method public final c(Landroid/view/View;Landroid/view/View;II)V
    .locals 0

    .line 1
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 2
    .line 3
    .line 4
    move-result-wide p1

    .line 5
    iput-wide p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->a0:J

    .line 6
    .line 7
    const/4 p1, 0x0

    .line 8
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->b0:F

    .line 9
    .line 10
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->V:F

    .line 11
    .line 12
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->W:F

    .line 13
    .line 14
    return-void
.end method

.method public final d(Landroid/view/View;II[II)V
    .locals 19

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v1, p1

    .line 4
    .line 5
    move/from16 v2, p2

    .line 6
    .line 7
    move/from16 v3, p3

    .line 8
    .line 9
    iget-object v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 10
    .line 11
    if-nez v4, :cond_0

    .line 12
    .line 13
    return-void

    .line 14
    :cond_0
    iget-object v5, v4, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 15
    .line 16
    if-eqz v5, :cond_14

    .line 17
    .line 18
    iget-boolean v6, v5, Lh1/x;->o:Z

    .line 19
    .line 20
    if-eqz v6, :cond_1

    .line 21
    .line 22
    goto/16 :goto_4

    .line 23
    .line 24
    :cond_1
    const/4 v7, -0x1

    .line 25
    if-nez v6, :cond_2

    .line 26
    .line 27
    iget-object v6, v5, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 28
    .line 29
    if-eqz v6, :cond_2

    .line 30
    .line 31
    iget v6, v6, Landroidx/constraintlayout/motion/widget/d;->e:I

    .line 32
    .line 33
    if-eq v6, v7, :cond_2

    .line 34
    .line 35
    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getId()I

    .line 36
    .line 37
    .line 38
    move-result v8

    .line 39
    if-eq v8, v6, :cond_2

    .line 40
    .line 41
    return-void

    .line 42
    :cond_2
    iget-object v6, v4, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 43
    .line 44
    const/4 v8, 0x0

    .line 45
    if-eqz v6, :cond_3

    .line 46
    .line 47
    iget-object v6, v6, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 48
    .line 49
    if-eqz v6, :cond_3

    .line 50
    .line 51
    iget-boolean v6, v6, Landroidx/constraintlayout/motion/widget/d;->u:Z

    .line 52
    .line 53
    goto :goto_0

    .line 54
    :cond_3
    move v6, v8

    .line 55
    :goto_0
    const/high16 v9, 0x3f800000    # 1.0f

    .line 56
    .line 57
    const/4 v10, 0x0

    .line 58
    if-eqz v6, :cond_6

    .line 59
    .line 60
    iget-object v6, v5, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 61
    .line 62
    if-eqz v6, :cond_4

    .line 63
    .line 64
    iget v6, v6, Landroidx/constraintlayout/motion/widget/d;->w:I

    .line 65
    .line 66
    and-int/lit8 v6, v6, 0x4

    .line 67
    .line 68
    if-eqz v6, :cond_4

    .line 69
    .line 70
    move v7, v3

    .line 71
    :cond_4
    iget v6, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 72
    .line 73
    cmpl-float v11, v6, v9

    .line 74
    .line 75
    if-eqz v11, :cond_5

    .line 76
    .line 77
    cmpl-float v6, v6, v10

    .line 78
    .line 79
    if-nez v6, :cond_6

    .line 80
    .line 81
    :cond_5
    invoke-virtual {v1, v7}, Landroid/view/View;->canScrollVertically(I)Z

    .line 82
    .line 83
    .line 84
    move-result v6

    .line 85
    if-eqz v6, :cond_6

    .line 86
    .line 87
    return-void

    .line 88
    :cond_6
    iget-object v5, v5, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 89
    .line 90
    const/4 v6, 0x1

    .line 91
    if-eqz v5, :cond_d

    .line 92
    .line 93
    iget v5, v5, Landroidx/constraintlayout/motion/widget/d;->w:I

    .line 94
    .line 95
    and-int/2addr v5, v6

    .line 96
    if-eqz v5, :cond_d

    .line 97
    .line 98
    int-to-float v5, v2

    .line 99
    int-to-float v7, v3

    .line 100
    iget-object v11, v4, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 101
    .line 102
    if-eqz v11, :cond_a

    .line 103
    .line 104
    iget-object v11, v11, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 105
    .line 106
    if-eqz v11, :cond_a

    .line 107
    .line 108
    iget-object v12, v11, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 109
    .line 110
    invoke-virtual {v12}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 111
    .line 112
    .line 113
    move-result v15

    .line 114
    iget v14, v11, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 115
    .line 116
    iget v12, v11, Landroidx/constraintlayout/motion/widget/d;->h:F

    .line 117
    .line 118
    iget v13, v11, Landroidx/constraintlayout/motion/widget/d;->g:F

    .line 119
    .line 120
    iget-object v9, v11, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 121
    .line 122
    iget-object v6, v11, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 123
    .line 124
    move/from16 v17, v13

    .line 125
    .line 126
    move-object v13, v6

    .line 127
    move/from16 v16, v12

    .line 128
    .line 129
    move-object/from16 v18, v9

    .line 130
    .line 131
    invoke-virtual/range {v13 .. v18}, Landroidx/constraintlayout/motion/widget/MotionLayout;->w(IFFF[F)V

    .line 132
    .line 133
    .line 134
    iget v6, v11, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 135
    .line 136
    cmpl-float v9, v6, v10

    .line 137
    .line 138
    iget-object v12, v11, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 139
    .line 140
    const v13, 0x33d6bf95    # 1.0E-7f

    .line 141
    .line 142
    .line 143
    if-eqz v9, :cond_8

    .line 144
    .line 145
    aget v7, v12, v8

    .line 146
    .line 147
    cmpl-float v7, v7, v10

    .line 148
    .line 149
    if-nez v7, :cond_7

    .line 150
    .line 151
    aput v13, v12, v8

    .line 152
    .line 153
    :cond_7
    mul-float/2addr v5, v6

    .line 154
    aget v6, v12, v8

    .line 155
    .line 156
    div-float/2addr v5, v6

    .line 157
    goto :goto_1

    .line 158
    :cond_8
    const/4 v5, 0x1

    .line 159
    aget v6, v12, v5

    .line 160
    .line 161
    cmpl-float v6, v6, v10

    .line 162
    .line 163
    if-nez v6, :cond_9

    .line 164
    .line 165
    aput v13, v12, v5

    .line 166
    .line 167
    :cond_9
    iget v6, v11, Landroidx/constraintlayout/motion/widget/d;->l:F

    .line 168
    .line 169
    mul-float/2addr v7, v6

    .line 170
    aget v6, v12, v5

    .line 171
    .line 172
    div-float v5, v7, v6

    .line 173
    .line 174
    goto :goto_1

    .line 175
    :cond_a
    move v5, v10

    .line 176
    :goto_1
    iget v6, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 177
    .line 178
    cmpg-float v7, v6, v10

    .line 179
    .line 180
    if-gtz v7, :cond_b

    .line 181
    .line 182
    cmpg-float v7, v5, v10

    .line 183
    .line 184
    if-ltz v7, :cond_c

    .line 185
    .line 186
    :cond_b
    const/high16 v7, 0x3f800000    # 1.0f

    .line 187
    .line 188
    cmpl-float v6, v6, v7

    .line 189
    .line 190
    if-ltz v6, :cond_d

    .line 191
    .line 192
    cmpl-float v5, v5, v10

    .line 193
    .line 194
    if-lez v5, :cond_d

    .line 195
    .line 196
    :cond_c
    invoke-virtual {v1, v8}, Landroid/view/View;->setNestedScrollingEnabled(Z)V

    .line 197
    .line 198
    .line 199
    new-instance v2, Lh1/p;

    .line 200
    .line 201
    move-object v3, v1

    .line 202
    check-cast v3, Landroid/view/ViewGroup;

    .line 203
    .line 204
    const/4 v4, 0x0

    .line 205
    invoke-direct {v2, v3, v4}, Lh1/p;-><init>(Landroid/view/ViewGroup;I)V

    .line 206
    .line 207
    .line 208
    invoke-virtual {v1, v2}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 209
    .line 210
    .line 211
    return-void

    .line 212
    :cond_d
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 213
    .line 214
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 215
    .line 216
    .line 217
    move-result-wide v5

    .line 218
    int-to-float v7, v2

    .line 219
    iput v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->V:F

    .line 220
    .line 221
    int-to-float v9, v3

    .line 222
    iput v9, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->W:F

    .line 223
    .line 224
    iget-wide v11, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->a0:J

    .line 225
    .line 226
    sub-long v11, v5, v11

    .line 227
    .line 228
    long-to-double v11, v11

    .line 229
    const-wide v13, 0x3e112e0be826d695L    # 1.0E-9

    .line 230
    .line 231
    .line 232
    .line 233
    .line 234
    mul-double/2addr v11, v13

    .line 235
    double-to-float v11, v11

    .line 236
    iput v11, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->b0:F

    .line 237
    .line 238
    iput-wide v5, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->a0:J

    .line 239
    .line 240
    iget-object v4, v4, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 241
    .line 242
    if-eqz v4, :cond_11

    .line 243
    .line 244
    iget-object v4, v4, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 245
    .line 246
    if-eqz v4, :cond_11

    .line 247
    .line 248
    iget-object v5, v4, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 249
    .line 250
    invoke-virtual {v5}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 251
    .line 252
    .line 253
    move-result v6

    .line 254
    iget-boolean v11, v4, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 255
    .line 256
    if-nez v11, :cond_e

    .line 257
    .line 258
    const/4 v11, 0x1

    .line 259
    iput-boolean v11, v4, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 260
    .line 261
    invoke-virtual {v5, v6}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 262
    .line 263
    .line 264
    :cond_e
    iget v12, v4, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 265
    .line 266
    iget v14, v4, Landroidx/constraintlayout/motion/widget/d;->h:F

    .line 267
    .line 268
    iget v15, v4, Landroidx/constraintlayout/motion/widget/d;->g:F

    .line 269
    .line 270
    iget-object v13, v4, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 271
    .line 272
    iget-object v11, v4, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 273
    .line 274
    move-object/from16 v16, v13

    .line 275
    .line 276
    move v13, v6

    .line 277
    invoke-virtual/range {v11 .. v16}, Landroidx/constraintlayout/motion/widget/MotionLayout;->w(IFFF[F)V

    .line 278
    .line 279
    .line 280
    iget v11, v4, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 281
    .line 282
    iget-object v12, v4, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 283
    .line 284
    aget v13, v12, v8

    .line 285
    .line 286
    mul-float/2addr v11, v13

    .line 287
    iget v13, v4, Landroidx/constraintlayout/motion/widget/d;->l:F

    .line 288
    .line 289
    const/4 v14, 0x1

    .line 290
    aget v15, v12, v14

    .line 291
    .line 292
    mul-float/2addr v13, v15

    .line 293
    add-float/2addr v13, v11

    .line 294
    invoke-static {v13}, Ljava/lang/Math;->abs(F)F

    .line 295
    .line 296
    .line 297
    move-result v11

    .line 298
    float-to-double v10, v11

    .line 299
    const-wide v15, 0x3f847ae147ae147bL    # 0.01

    .line 300
    .line 301
    .line 302
    .line 303
    .line 304
    cmpg-double v10, v10, v15

    .line 305
    .line 306
    if-gez v10, :cond_f

    .line 307
    .line 308
    const v10, 0x3c23d70a    # 0.01f

    .line 309
    .line 310
    .line 311
    aput v10, v12, v8

    .line 312
    .line 313
    aput v10, v12, v14

    .line 314
    .line 315
    :cond_f
    iget v10, v4, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 316
    .line 317
    const/4 v11, 0x0

    .line 318
    cmpl-float v14, v10, v11

    .line 319
    .line 320
    if-eqz v14, :cond_10

    .line 321
    .line 322
    mul-float/2addr v7, v10

    .line 323
    aget v4, v12, v8

    .line 324
    .line 325
    div-float/2addr v7, v4

    .line 326
    goto :goto_2

    .line 327
    :cond_10
    iget v4, v4, Landroidx/constraintlayout/motion/widget/d;->l:F

    .line 328
    .line 329
    mul-float/2addr v9, v4

    .line 330
    const/4 v4, 0x1

    .line 331
    aget v7, v12, v4

    .line 332
    .line 333
    div-float v7, v9, v7

    .line 334
    .line 335
    :goto_2
    add-float/2addr v6, v7

    .line 336
    const/high16 v4, 0x3f800000    # 1.0f

    .line 337
    .line 338
    invoke-static {v6, v4}, Ljava/lang/Math;->min(FF)F

    .line 339
    .line 340
    .line 341
    move-result v4

    .line 342
    const/4 v6, 0x0

    .line 343
    invoke-static {v4, v6}, Ljava/lang/Math;->max(FF)F

    .line 344
    .line 345
    .line 346
    move-result v4

    .line 347
    invoke-virtual {v5}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 348
    .line 349
    .line 350
    move-result v6

    .line 351
    cmpl-float v6, v4, v6

    .line 352
    .line 353
    if-eqz v6, :cond_11

    .line 354
    .line 355
    invoke-virtual {v5, v4}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 356
    .line 357
    .line 358
    :cond_11
    iget v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 359
    .line 360
    cmpl-float v1, v1, v4

    .line 361
    .line 362
    if-eqz v1, :cond_12

    .line 363
    .line 364
    aput v2, p4, v8

    .line 365
    .line 366
    const/4 v1, 0x1

    .line 367
    aput v3, p4, v1

    .line 368
    .line 369
    goto :goto_3

    .line 370
    :cond_12
    const/4 v1, 0x1

    .line 371
    :goto_3
    invoke-virtual {v0, v8}, Landroidx/constraintlayout/motion/widget/MotionLayout;->t(Z)V

    .line 372
    .line 373
    .line 374
    aget v2, p4, v8

    .line 375
    .line 376
    if-nez v2, :cond_13

    .line 377
    .line 378
    aget v2, p4, v1

    .line 379
    .line 380
    if-eqz v2, :cond_14

    .line 381
    .line 382
    :cond_13
    iput-boolean v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->U:Z

    .line 383
    .line 384
    :cond_14
    :goto_4
    return-void
.end method

.method public final dispatchDraw(Landroid/graphics/Canvas;)V
    .locals 34

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v1, p1

    .line 4
    .line 5
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 6
    .line 7
    if-eqz v2, :cond_0

    .line 8
    .line 9
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 10
    .line 11
    .line 12
    move-result-object v2

    .line 13
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    .line 14
    .line 15
    .line 16
    move-result v3

    .line 17
    if-eqz v3, :cond_0

    .line 18
    .line 19
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 20
    .line 21
    .line 22
    move-result-object v3

    .line 23
    check-cast v3, Landroidx/constraintlayout/motion/widget/MotionHelper;

    .line 24
    .line 25
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 26
    .line 27
    .line 28
    goto :goto_0

    .line 29
    :cond_0
    const/4 v2, 0x0

    .line 30
    invoke-virtual {v0, v2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->t(Z)V

    .line 31
    .line 32
    .line 33
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 34
    .line 35
    const/4 v4, 0x0

    .line 36
    if-eqz v3, :cond_3

    .line 37
    .line 38
    iget-object v3, v3, Landroidx/constraintlayout/motion/widget/c;->q:Las/c;

    .line 39
    .line 40
    if-eqz v3, :cond_3

    .line 41
    .line 42
    iget-object v5, v3, Las/c;->e:Ljava/lang/Object;

    .line 43
    .line 44
    check-cast v5, Ljava/util/ArrayList;

    .line 45
    .line 46
    if-nez v5, :cond_1

    .line 47
    .line 48
    goto :goto_2

    .line 49
    :cond_1
    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 50
    .line 51
    .line 52
    move-result-object v5

    .line 53
    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    .line 54
    .line 55
    .line 56
    move-result v6

    .line 57
    if-eqz v6, :cond_2

    .line 58
    .line 59
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 60
    .line 61
    .line 62
    move-result-object v6

    .line 63
    check-cast v6, Lh1/z;

    .line 64
    .line 65
    invoke-virtual {v6}, Lh1/z;->a()V

    .line 66
    .line 67
    .line 68
    goto :goto_1

    .line 69
    :cond_2
    iget-object v5, v3, Las/c;->e:Ljava/lang/Object;

    .line 70
    .line 71
    check-cast v5, Ljava/util/ArrayList;

    .line 72
    .line 73
    iget-object v6, v3, Las/c;->f:Ljava/lang/Object;

    .line 74
    .line 75
    check-cast v6, Ljava/util/ArrayList;

    .line 76
    .line 77
    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->removeAll(Ljava/util/Collection;)Z

    .line 78
    .line 79
    .line 80
    invoke-virtual {v6}, Ljava/util/ArrayList;->clear()V

    .line 81
    .line 82
    .line 83
    iget-object v5, v3, Las/c;->e:Ljava/lang/Object;

    .line 84
    .line 85
    check-cast v5, Ljava/util/ArrayList;

    .line 86
    .line 87
    invoke-virtual {v5}, Ljava/util/ArrayList;->isEmpty()Z

    .line 88
    .line 89
    .line 90
    move-result v5

    .line 91
    if-eqz v5, :cond_3

    .line 92
    .line 93
    iput-object v4, v3, Las/c;->e:Ljava/lang/Object;

    .line 94
    .line 95
    :cond_3
    :goto_2
    invoke-super/range {p0 .. p1}, Landroidx/constraintlayout/widget/ConstraintLayout;->dispatchDraw(Landroid/graphics/Canvas;)V

    .line 96
    .line 97
    .line 98
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 99
    .line 100
    if-nez v3, :cond_4

    .line 101
    .line 102
    return-void

    .line 103
    :cond_4
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 104
    .line 105
    const/4 v5, 0x1

    .line 106
    and-int/2addr v3, v5

    .line 107
    const/high16 v6, 0x41300000    # 11.0f

    .line 108
    .line 109
    const/high16 v7, 0x41200000    # 10.0f

    .line 110
    .line 111
    if-ne v3, v5, :cond_8

    .line 112
    .line 113
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->isInEditMode()Z

    .line 114
    .line 115
    .line 116
    move-result v3

    .line 117
    if-nez v3, :cond_8

    .line 118
    .line 119
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->h0:I

    .line 120
    .line 121
    add-int/2addr v3, v5

    .line 122
    iput v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->h0:I

    .line 123
    .line 124
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 125
    .line 126
    .line 127
    move-result-wide v8

    .line 128
    iget-wide v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->i0:J

    .line 129
    .line 130
    const-wide/16 v12, -0x1

    .line 131
    .line 132
    cmp-long v3, v10, v12

    .line 133
    .line 134
    if-eqz v3, :cond_5

    .line 135
    .line 136
    sub-long v10, v8, v10

    .line 137
    .line 138
    const-wide/32 v12, 0xbebc200

    .line 139
    .line 140
    .line 141
    cmp-long v3, v10, v12

    .line 142
    .line 143
    if-lez v3, :cond_6

    .line 144
    .line 145
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->h0:I

    .line 146
    .line 147
    int-to-float v3, v3

    .line 148
    long-to-float v10, v10

    .line 149
    const v11, 0x3089705f    # 1.0E-9f

    .line 150
    .line 151
    .line 152
    mul-float/2addr v10, v11

    .line 153
    div-float/2addr v3, v10

    .line 154
    const/high16 v10, 0x42c80000    # 100.0f

    .line 155
    .line 156
    mul-float/2addr v3, v10

    .line 157
    float-to-int v3, v3

    .line 158
    int-to-float v3, v3

    .line 159
    div-float/2addr v3, v10

    .line 160
    iput v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->j0:F

    .line 161
    .line 162
    iput v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->h0:I

    .line 163
    .line 164
    iput-wide v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->i0:J

    .line 165
    .line 166
    goto :goto_3

    .line 167
    :cond_5
    iput-wide v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->i0:J

    .line 168
    .line 169
    :cond_6
    :goto_3
    new-instance v3, Landroid/graphics/Paint;

    .line 170
    .line 171
    invoke-direct {v3}, Landroid/graphics/Paint;-><init>()V

    .line 172
    .line 173
    .line 174
    const/high16 v8, 0x42280000    # 42.0f

    .line 175
    .line 176
    invoke-virtual {v3, v8}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 177
    .line 178
    .line 179
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 180
    .line 181
    .line 182
    move-result v8

    .line 183
    const/high16 v9, 0x447a0000    # 1000.0f

    .line 184
    .line 185
    mul-float/2addr v8, v9

    .line 186
    float-to-int v8, v8

    .line 187
    int-to-float v8, v8

    .line 188
    div-float/2addr v8, v7

    .line 189
    new-instance v9, Ljava/lang/StringBuilder;

    .line 190
    .line 191
    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    .line 192
    .line 193
    .line 194
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->j0:F

    .line 195
    .line 196
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    .line 197
    .line 198
    .line 199
    const-string v10, " fps "

    .line 200
    .line 201
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 202
    .line 203
    .line 204
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 205
    .line 206
    invoke-static {v10, v0}, Lso/c;->y(ILandroidx/constraintlayout/motion/widget/MotionLayout;)Ljava/lang/String;

    .line 207
    .line 208
    .line 209
    move-result-object v10

    .line 210
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 211
    .line 212
    .line 213
    const-string v10, " -> "

    .line 214
    .line 215
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 216
    .line 217
    .line 218
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 219
    .line 220
    .line 221
    move-result-object v9

    .line 222
    invoke-static {v9}, La1/a;->y(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 223
    .line 224
    .line 225
    move-result-object v9

    .line 226
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 227
    .line 228
    invoke-static {v10, v0}, Lso/c;->y(ILandroidx/constraintlayout/motion/widget/MotionLayout;)Ljava/lang/String;

    .line 229
    .line 230
    .line 231
    move-result-object v10

    .line 232
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 233
    .line 234
    .line 235
    const-string v10, " (progress: "

    .line 236
    .line 237
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 238
    .line 239
    .line 240
    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    .line 241
    .line 242
    .line 243
    const-string v8, " ) state="

    .line 244
    .line 245
    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 246
    .line 247
    .line 248
    iget v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 249
    .line 250
    const/4 v10, -0x1

    .line 251
    if-ne v8, v10, :cond_7

    .line 252
    .line 253
    const-string v8, "undefined"

    .line 254
    .line 255
    goto :goto_4

    .line 256
    :cond_7
    invoke-static {v8, v0}, Lso/c;->y(ILandroidx/constraintlayout/motion/widget/MotionLayout;)Ljava/lang/String;

    .line 257
    .line 258
    .line 259
    move-result-object v8

    .line 260
    :goto_4
    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 261
    .line 262
    .line 263
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 264
    .line 265
    .line 266
    move-result-object v8

    .line 267
    const/high16 v9, -0x1000000

    .line 268
    .line 269
    invoke-virtual {v3, v9}, Landroid/graphics/Paint;->setColor(I)V

    .line 270
    .line 271
    .line 272
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getHeight()I

    .line 273
    .line 274
    .line 275
    move-result v9

    .line 276
    add-int/lit8 v9, v9, -0x1d

    .line 277
    .line 278
    int-to-float v9, v9

    .line 279
    invoke-virtual {v1, v8, v6, v9, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 280
    .line 281
    .line 282
    const v9, -0x77ff78

    .line 283
    .line 284
    .line 285
    invoke-virtual {v3, v9}, Landroid/graphics/Paint;->setColor(I)V

    .line 286
    .line 287
    .line 288
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getHeight()I

    .line 289
    .line 290
    .line 291
    move-result v9

    .line 292
    add-int/lit8 v9, v9, -0x1e

    .line 293
    .line 294
    int-to-float v9, v9

    .line 295
    invoke-virtual {v1, v8, v7, v9, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 296
    .line 297
    .line 298
    :cond_8
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 299
    .line 300
    if-le v3, v5, :cond_30

    .line 301
    .line 302
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->N:Lh1/r;

    .line 303
    .line 304
    if-nez v3, :cond_9

    .line 305
    .line 306
    new-instance v3, Lh1/r;

    .line 307
    .line 308
    invoke-direct {v3, v0}, Lh1/r;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 309
    .line 310
    .line 311
    iput-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->N:Lh1/r;

    .line 312
    .line 313
    :cond_9
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->N:Lh1/r;

    .line 314
    .line 315
    iget-object v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 316
    .line 317
    iget-object v9, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 318
    .line 319
    invoke-virtual {v9}, Landroidx/constraintlayout/motion/widget/c;->c()I

    .line 320
    .line 321
    .line 322
    move-result v9

    .line 323
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 324
    .line 325
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 326
    .line 327
    .line 328
    if-eqz v8, :cond_30

    .line 329
    .line 330
    invoke-virtual {v8}, Ljava/util/HashMap;->size()I

    .line 331
    .line 332
    .line 333
    move-result v11

    .line 334
    if-nez v11, :cond_a

    .line 335
    .line 336
    goto/16 :goto_1b

    .line 337
    .line 338
    :cond_a
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->save()I

    .line 339
    .line 340
    .line 341
    iget-object v11, v3, Lh1/r;->n:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 342
    .line 343
    invoke-virtual {v11}, Landroid/view/View;->isInEditMode()Z

    .line 344
    .line 345
    .line 346
    move-result v12

    .line 347
    iget-object v13, v3, Lh1/r;->e:Landroid/graphics/Paint;

    .line 348
    .line 349
    const/4 v14, 0x2

    .line 350
    if-nez v12, :cond_b

    .line 351
    .line 352
    and-int/lit8 v12, v10, 0x1

    .line 353
    .line 354
    if-ne v12, v14, :cond_b

    .line 355
    .line 356
    new-instance v12, Ljava/lang/StringBuilder;

    .line 357
    .line 358
    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    .line 359
    .line 360
    .line 361
    invoke-virtual {v11}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 362
    .line 363
    .line 364
    move-result-object v15

    .line 365
    invoke-virtual {v15}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 366
    .line 367
    .line 368
    move-result-object v15

    .line 369
    iget v14, v11, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 370
    .line 371
    invoke-virtual {v15, v14}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    .line 372
    .line 373
    .line 374
    move-result-object v14

    .line 375
    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 376
    .line 377
    .line 378
    const-string v14, ":"

    .line 379
    .line 380
    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 381
    .line 382
    .line 383
    invoke-virtual {v11}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 384
    .line 385
    .line 386
    move-result v14

    .line 387
    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    .line 388
    .line 389
    .line 390
    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 391
    .line 392
    .line 393
    move-result-object v12

    .line 394
    invoke-virtual {v11}, Landroid/view/View;->getHeight()I

    .line 395
    .line 396
    .line 397
    move-result v14

    .line 398
    add-int/lit8 v14, v14, -0x1e

    .line 399
    .line 400
    int-to-float v14, v14

    .line 401
    iget-object v15, v3, Lh1/r;->h:Landroid/graphics/Paint;

    .line 402
    .line 403
    invoke-virtual {v1, v12, v7, v14, v15}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 404
    .line 405
    .line 406
    invoke-virtual {v11}, Landroid/view/View;->getHeight()I

    .line 407
    .line 408
    .line 409
    move-result v7

    .line 410
    add-int/lit8 v7, v7, -0x1d

    .line 411
    .line 412
    int-to-float v7, v7

    .line 413
    invoke-virtual {v1, v12, v6, v7, v13}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 414
    .line 415
    .line 416
    :cond_b
    invoke-virtual {v8}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    .line 417
    .line 418
    .line 419
    move-result-object v6

    .line 420
    invoke-interface {v6}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    .line 421
    .line 422
    .line 423
    move-result-object v6

    .line 424
    :goto_5
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    .line 425
    .line 426
    .line 427
    move-result v7

    .line 428
    if-eqz v7, :cond_2f

    .line 429
    .line 430
    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 431
    .line 432
    .line 433
    move-result-object v7

    .line 434
    check-cast v7, Lh1/n;

    .line 435
    .line 436
    iget-object v8, v7, Lh1/n;->f:Lh1/v;

    .line 437
    .line 438
    iget v8, v8, Lh1/v;->b:I

    .line 439
    .line 440
    iget-object v11, v7, Lh1/n;->u:Ljava/util/ArrayList;

    .line 441
    .line 442
    invoke-virtual {v11}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 443
    .line 444
    .line 445
    move-result-object v12

    .line 446
    :goto_6
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    .line 447
    .line 448
    .line 449
    move-result v14

    .line 450
    if-eqz v14, :cond_c

    .line 451
    .line 452
    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 453
    .line 454
    .line 455
    move-result-object v14

    .line 456
    check-cast v14, Lh1/v;

    .line 457
    .line 458
    iget v14, v14, Lh1/v;->b:I

    .line 459
    .line 460
    invoke-static {v8, v14}, Ljava/lang/Math;->max(II)I

    .line 461
    .line 462
    .line 463
    move-result v8

    .line 464
    goto :goto_6

    .line 465
    :cond_c
    iget-object v12, v7, Lh1/n;->g:Lh1/v;

    .line 466
    .line 467
    iget v12, v12, Lh1/v;->b:I

    .line 468
    .line 469
    invoke-static {v8, v12}, Ljava/lang/Math;->max(II)I

    .line 470
    .line 471
    .line 472
    move-result v8

    .line 473
    if-lez v10, :cond_d

    .line 474
    .line 475
    if-nez v8, :cond_d

    .line 476
    .line 477
    move v8, v5

    .line 478
    :cond_d
    if-nez v8, :cond_e

    .line 479
    .line 480
    goto :goto_5

    .line 481
    :cond_e
    iget-object v12, v3, Lh1/r;->c:[F

    .line 482
    .line 483
    if-eqz v12, :cond_11

    .line 484
    .line 485
    iget-object v14, v7, Lh1/n;->j:[Lb4/a;

    .line 486
    .line 487
    aget-object v14, v14, v2

    .line 488
    .line 489
    invoke-virtual {v14}, Lb4/a;->z()[D

    .line 490
    .line 491
    .line 492
    move-result-object v14

    .line 493
    iget-object v15, v3, Lh1/r;->b:[I

    .line 494
    .line 495
    if-eqz v15, :cond_f

    .line 496
    .line 497
    invoke-virtual {v11}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 498
    .line 499
    .line 500
    move-result-object v16

    .line 501
    move/from16 v17, v2

    .line 502
    .line 503
    :goto_7
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->hasNext()Z

    .line 504
    .line 505
    .line 506
    move-result v18

    .line 507
    if-eqz v18, :cond_f

    .line 508
    .line 509
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 510
    .line 511
    .line 512
    move-result-object v18

    .line 513
    move-object/from16 v4, v18

    .line 514
    .line 515
    check-cast v4, Lh1/v;

    .line 516
    .line 517
    add-int/lit8 v18, v17, 0x1

    .line 518
    .line 519
    iget v4, v4, Lh1/v;->o:I

    .line 520
    .line 521
    aput v4, v15, v17

    .line 522
    .line 523
    move/from16 v17, v18

    .line 524
    .line 525
    const/4 v4, 0x0

    .line 526
    goto :goto_7

    .line 527
    :cond_f
    move v4, v2

    .line 528
    move v15, v4

    .line 529
    :goto_8
    array-length v5, v14

    .line 530
    if-ge v4, v5, :cond_10

    .line 531
    .line 532
    iget-object v5, v7, Lh1/n;->j:[Lb4/a;

    .line 533
    .line 534
    aget-object v5, v5, v2

    .line 535
    .line 536
    move-object/from16 v23, v3

    .line 537
    .line 538
    aget-wide v2, v14, v4

    .line 539
    .line 540
    move-object/from16 v24, v6

    .line 541
    .line 542
    iget-object v6, v7, Lh1/n;->p:[D

    .line 543
    .line 544
    invoke-virtual {v5, v2, v3, v6}, Lb4/a;->v(D[D)V

    .line 545
    .line 546
    .line 547
    aget-wide v17, v14, v4

    .line 548
    .line 549
    iget-object v2, v7, Lh1/n;->o:[I

    .line 550
    .line 551
    iget-object v3, v7, Lh1/n;->p:[D

    .line 552
    .line 553
    iget-object v5, v7, Lh1/n;->f:Lh1/v;

    .line 554
    .line 555
    move-object/from16 v16, v5

    .line 556
    .line 557
    move-object/from16 v19, v2

    .line 558
    .line 559
    move-object/from16 v20, v3

    .line 560
    .line 561
    move-object/from16 v21, v12

    .line 562
    .line 563
    move/from16 v22, v15

    .line 564
    .line 565
    invoke-virtual/range {v16 .. v22}, Lh1/v;->d(D[I[D[FI)V

    .line 566
    .line 567
    .line 568
    add-int/lit8 v15, v15, 0x2

    .line 569
    .line 570
    add-int/lit8 v4, v4, 0x1

    .line 571
    .line 572
    move-object/from16 v3, v23

    .line 573
    .line 574
    move-object/from16 v6, v24

    .line 575
    .line 576
    const/4 v2, 0x0

    .line 577
    goto :goto_8

    .line 578
    :cond_10
    move-object/from16 v23, v3

    .line 579
    .line 580
    move-object/from16 v24, v6

    .line 581
    .line 582
    div-int/lit8 v2, v15, 0x2

    .line 583
    .line 584
    goto :goto_9

    .line 585
    :cond_11
    move-object/from16 v24, v6

    .line 586
    .line 587
    const/4 v2, 0x0

    .line 588
    :goto_9
    iput v2, v3, Lh1/r;->k:I

    .line 589
    .line 590
    const/4 v2, 0x1

    .line 591
    if-lt v8, v2, :cond_2e

    .line 592
    .line 593
    div-int/lit8 v2, v9, 0x10

    .line 594
    .line 595
    iget-object v4, v3, Lh1/r;->a:[F

    .line 596
    .line 597
    if-eqz v4, :cond_12

    .line 598
    .line 599
    array-length v4, v4

    .line 600
    mul-int/lit8 v5, v2, 0x2

    .line 601
    .line 602
    if-eq v4, v5, :cond_13

    .line 603
    .line 604
    :cond_12
    mul-int/lit8 v4, v2, 0x2

    .line 605
    .line 606
    new-array v4, v4, [F

    .line 607
    .line 608
    iput-object v4, v3, Lh1/r;->a:[F

    .line 609
    .line 610
    new-instance v4, Landroid/graphics/Path;

    .line 611
    .line 612
    invoke-direct {v4}, Landroid/graphics/Path;-><init>()V

    .line 613
    .line 614
    .line 615
    iput-object v4, v3, Lh1/r;->d:Landroid/graphics/Path;

    .line 616
    .line 617
    :cond_13
    iget v4, v3, Lh1/r;->m:I

    .line 618
    .line 619
    int-to-float v5, v4

    .line 620
    invoke-virtual {v1, v5, v5}, Landroid/graphics/Canvas;->translate(FF)V

    .line 621
    .line 622
    .line 623
    const/high16 v5, 0x77000000

    .line 624
    .line 625
    invoke-virtual {v13, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 626
    .line 627
    .line 628
    iget-object v6, v3, Lh1/r;->i:Landroid/graphics/Paint;

    .line 629
    .line 630
    invoke-virtual {v6, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 631
    .line 632
    .line 633
    iget-object v12, v3, Lh1/r;->f:Landroid/graphics/Paint;

    .line 634
    .line 635
    invoke-virtual {v12, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 636
    .line 637
    .line 638
    iget-object v14, v3, Lh1/r;->g:Landroid/graphics/Paint;

    .line 639
    .line 640
    invoke-virtual {v14, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 641
    .line 642
    .line 643
    iget-object v5, v3, Lh1/r;->a:[F

    .line 644
    .line 645
    add-int/lit8 v15, v2, -0x1

    .line 646
    .line 647
    int-to-float v15, v15

    .line 648
    move/from16 v23, v9

    .line 649
    .line 650
    const/high16 v9, 0x3f800000    # 1.0f

    .line 651
    .line 652
    div-float v15, v9, v15

    .line 653
    .line 654
    iget-object v9, v7, Lh1/n;->y:Ljava/util/HashMap;

    .line 655
    .line 656
    move/from16 v25, v10

    .line 657
    .line 658
    const-string v10, "translationX"

    .line 659
    .line 660
    if-nez v9, :cond_14

    .line 661
    .line 662
    const/4 v9, 0x0

    .line 663
    goto :goto_a

    .line 664
    :cond_14
    invoke-virtual {v9, v10}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 665
    .line 666
    .line 667
    move-result-object v9

    .line 668
    check-cast v9, Lg1/l;

    .line 669
    .line 670
    :goto_a
    iget-object v0, v7, Lh1/n;->y:Ljava/util/HashMap;

    .line 671
    .line 672
    move/from16 v26, v4

    .line 673
    .line 674
    const-string v4, "translationY"

    .line 675
    .line 676
    if-nez v0, :cond_15

    .line 677
    .line 678
    move-object/from16 v27, v14

    .line 679
    .line 680
    const/4 v0, 0x0

    .line 681
    goto :goto_b

    .line 682
    :cond_15
    invoke-virtual {v0, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 683
    .line 684
    .line 685
    move-result-object v0

    .line 686
    check-cast v0, Lg1/l;

    .line 687
    .line 688
    move-object/from16 v27, v14

    .line 689
    .line 690
    :goto_b
    iget-object v14, v7, Lh1/n;->z:Ljava/util/HashMap;

    .line 691
    .line 692
    if-nez v14, :cond_16

    .line 693
    .line 694
    const/4 v10, 0x0

    .line 695
    goto :goto_c

    .line 696
    :cond_16
    invoke-virtual {v14, v10}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 697
    .line 698
    .line 699
    move-result-object v10

    .line 700
    check-cast v10, Lg1/g;

    .line 701
    .line 702
    :goto_c
    iget-object v14, v7, Lh1/n;->z:Ljava/util/HashMap;

    .line 703
    .line 704
    if-nez v14, :cond_17

    .line 705
    .line 706
    const/4 v4, 0x0

    .line 707
    goto :goto_d

    .line 708
    :cond_17
    invoke-virtual {v14, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 709
    .line 710
    .line 711
    move-result-object v4

    .line 712
    check-cast v4, Lg1/g;

    .line 713
    .line 714
    :goto_d
    move-object/from16 v28, v6

    .line 715
    .line 716
    const/4 v14, 0x0

    .line 717
    :goto_e
    iget-object v6, v7, Lh1/n;->f:Lh1/v;

    .line 718
    .line 719
    const/high16 v16, 0x7fc00000    # Float.NaN

    .line 720
    .line 721
    move-object/from16 v29, v12

    .line 722
    .line 723
    if-ge v14, v2, :cond_25

    .line 724
    .line 725
    int-to-float v12, v14

    .line 726
    mul-float/2addr v12, v15

    .line 727
    move/from16 v30, v2

    .line 728
    .line 729
    iget v2, v7, Lh1/n;->n:F

    .line 730
    .line 731
    const/high16 v18, 0x3f800000    # 1.0f

    .line 732
    .line 733
    cmpl-float v19, v2, v18

    .line 734
    .line 735
    if-eqz v19, :cond_19

    .line 736
    .line 737
    move/from16 v31, v15

    .line 738
    .line 739
    iget v15, v7, Lh1/n;->m:F

    .line 740
    .line 741
    cmpg-float v18, v12, v15

    .line 742
    .line 743
    if-gez v18, :cond_18

    .line 744
    .line 745
    const/4 v12, 0x0

    .line 746
    :cond_18
    cmpl-float v18, v12, v15

    .line 747
    .line 748
    move-object/from16 v32, v0

    .line 749
    .line 750
    if-lez v18, :cond_1a

    .line 751
    .line 752
    float-to-double v0, v12

    .line 753
    const-wide/high16 v18, 0x3ff0000000000000L    # 1.0

    .line 754
    .line 755
    cmpg-double v0, v0, v18

    .line 756
    .line 757
    if-gez v0, :cond_1a

    .line 758
    .line 759
    sub-float/2addr v12, v15

    .line 760
    mul-float/2addr v12, v2

    .line 761
    const/high16 v0, 0x3f800000    # 1.0f

    .line 762
    .line 763
    invoke-static {v12, v0}, Ljava/lang/Math;->min(FF)F

    .line 764
    .line 765
    .line 766
    move-result v12

    .line 767
    goto :goto_f

    .line 768
    :cond_19
    move-object/from16 v32, v0

    .line 769
    .line 770
    move/from16 v31, v15

    .line 771
    .line 772
    :cond_1a
    const/high16 v0, 0x3f800000    # 1.0f

    .line 773
    .line 774
    :goto_f
    float-to-double v1, v12

    .line 775
    iget-object v6, v6, Lh1/v;->a:Lb1/e;

    .line 776
    .line 777
    invoke-virtual {v11}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 778
    .line 779
    .line 780
    move-result-object v15

    .line 781
    const/16 v17, 0x0

    .line 782
    .line 783
    :goto_10
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    .line 784
    .line 785
    .line 786
    move-result v18

    .line 787
    if-eqz v18, :cond_1d

    .line 788
    .line 789
    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 790
    .line 791
    .line 792
    move-result-object v18

    .line 793
    move-object/from16 v0, v18

    .line 794
    .line 795
    check-cast v0, Lh1/v;

    .line 796
    .line 797
    move-wide/from16 v18, v1

    .line 798
    .line 799
    iget-object v1, v0, Lh1/v;->a:Lb1/e;

    .line 800
    .line 801
    if-eqz v1, :cond_1c

    .line 802
    .line 803
    iget v2, v0, Lh1/v;->c:F

    .line 804
    .line 805
    cmpg-float v20, v2, v12

    .line 806
    .line 807
    if-gez v20, :cond_1b

    .line 808
    .line 809
    move-object v6, v1

    .line 810
    move/from16 v17, v2

    .line 811
    .line 812
    goto :goto_11

    .line 813
    :cond_1b
    invoke-static/range {v16 .. v16}, Ljava/lang/Float;->isNaN(F)Z

    .line 814
    .line 815
    .line 816
    move-result v1

    .line 817
    if-eqz v1, :cond_1c

    .line 818
    .line 819
    iget v0, v0, Lh1/v;->c:F

    .line 820
    .line 821
    move/from16 v16, v0

    .line 822
    .line 823
    :cond_1c
    :goto_11
    move-wide/from16 v1, v18

    .line 824
    .line 825
    const/high16 v0, 0x3f800000    # 1.0f

    .line 826
    .line 827
    goto :goto_10

    .line 828
    :cond_1d
    move-wide/from16 v18, v1

    .line 829
    .line 830
    if-eqz v6, :cond_1f

    .line 831
    .line 832
    invoke-static/range {v16 .. v16}, Ljava/lang/Float;->isNaN(F)Z

    .line 833
    .line 834
    .line 835
    move-result v0

    .line 836
    if-eqz v0, :cond_1e

    .line 837
    .line 838
    const/high16 v18, 0x3f800000    # 1.0f

    .line 839
    .line 840
    goto :goto_12

    .line 841
    :cond_1e
    move/from16 v18, v16

    .line 842
    .line 843
    :goto_12
    sub-float v0, v12, v17

    .line 844
    .line 845
    sub-float v18, v18, v17

    .line 846
    .line 847
    div-float v0, v0, v18

    .line 848
    .line 849
    float-to-double v0, v0

    .line 850
    invoke-virtual {v6, v0, v1}, Lb1/e;->a(D)D

    .line 851
    .line 852
    .line 853
    move-result-wide v0

    .line 854
    double-to-float v0, v0

    .line 855
    mul-float v0, v0, v18

    .line 856
    .line 857
    add-float v0, v0, v17

    .line 858
    .line 859
    float-to-double v0, v0

    .line 860
    goto :goto_13

    .line 861
    :cond_1f
    move-wide/from16 v0, v18

    .line 862
    .line 863
    :goto_13
    iget-object v2, v7, Lh1/n;->j:[Lb4/a;

    .line 864
    .line 865
    const/4 v6, 0x0

    .line 866
    aget-object v2, v2, v6

    .line 867
    .line 868
    iget-object v6, v7, Lh1/n;->p:[D

    .line 869
    .line 870
    invoke-virtual {v2, v0, v1, v6}, Lb4/a;->v(D[D)V

    .line 871
    .line 872
    .line 873
    iget-object v2, v7, Lh1/n;->k:Lb1/b;

    .line 874
    .line 875
    if-eqz v2, :cond_20

    .line 876
    .line 877
    iget-object v6, v7, Lh1/n;->p:[D

    .line 878
    .line 879
    array-length v15, v6

    .line 880
    if-lez v15, :cond_20

    .line 881
    .line 882
    invoke-virtual {v2, v0, v1, v6}, Lb1/b;->v(D[D)V

    .line 883
    .line 884
    .line 885
    :cond_20
    iget-object v2, v7, Lh1/n;->o:[I

    .line 886
    .line 887
    iget-object v6, v7, Lh1/n;->p:[D

    .line 888
    .line 889
    mul-int/lit8 v15, v14, 0x2

    .line 890
    .line 891
    move-object/from16 v33, v11

    .line 892
    .line 893
    iget-object v11, v7, Lh1/n;->f:Lh1/v;

    .line 894
    .line 895
    move-object/from16 v16, v11

    .line 896
    .line 897
    move-wide/from16 v17, v0

    .line 898
    .line 899
    move-object/from16 v19, v2

    .line 900
    .line 901
    move-object/from16 v20, v6

    .line 902
    .line 903
    move-object/from16 v21, v5

    .line 904
    .line 905
    move/from16 v22, v15

    .line 906
    .line 907
    invoke-virtual/range {v16 .. v22}, Lh1/v;->d(D[I[D[FI)V

    .line 908
    .line 909
    .line 910
    if-eqz v10, :cond_21

    .line 911
    .line 912
    aget v0, v5, v15

    .line 913
    .line 914
    invoke-virtual {v10, v12}, Lg1/g;->a(F)F

    .line 915
    .line 916
    .line 917
    move-result v1

    .line 918
    add-float/2addr v1, v0

    .line 919
    aput v1, v5, v15

    .line 920
    .line 921
    goto :goto_14

    .line 922
    :cond_21
    if-eqz v9, :cond_22

    .line 923
    .line 924
    aget v0, v5, v15

    .line 925
    .line 926
    invoke-virtual {v9, v12}, Lg1/l;->a(F)F

    .line 927
    .line 928
    .line 929
    move-result v1

    .line 930
    add-float/2addr v1, v0

    .line 931
    aput v1, v5, v15

    .line 932
    .line 933
    :cond_22
    :goto_14
    if-eqz v4, :cond_24

    .line 934
    .line 935
    add-int/lit8 v15, v15, 0x1

    .line 936
    .line 937
    aget v0, v5, v15

    .line 938
    .line 939
    invoke-virtual {v4, v12}, Lg1/g;->a(F)F

    .line 940
    .line 941
    .line 942
    move-result v1

    .line 943
    add-float/2addr v1, v0

    .line 944
    aput v1, v5, v15

    .line 945
    .line 946
    :cond_23
    move-object/from16 v1, v32

    .line 947
    .line 948
    goto :goto_15

    .line 949
    :cond_24
    if-eqz v32, :cond_23

    .line 950
    .line 951
    add-int/lit8 v15, v15, 0x1

    .line 952
    .line 953
    aget v0, v5, v15

    .line 954
    .line 955
    move-object/from16 v1, v32

    .line 956
    .line 957
    invoke-virtual {v1, v12}, Lg1/l;->a(F)F

    .line 958
    .line 959
    .line 960
    move-result v2

    .line 961
    add-float/2addr v2, v0

    .line 962
    aput v2, v5, v15

    .line 963
    .line 964
    :goto_15
    add-int/lit8 v14, v14, 0x1

    .line 965
    .line 966
    move-object v0, v1

    .line 967
    move-object/from16 v12, v29

    .line 968
    .line 969
    move/from16 v2, v30

    .line 970
    .line 971
    move/from16 v15, v31

    .line 972
    .line 973
    move-object/from16 v11, v33

    .line 974
    .line 975
    move-object/from16 v1, p1

    .line 976
    .line 977
    goto/16 :goto_e

    .line 978
    .line 979
    :cond_25
    iget v0, v3, Lh1/r;->k:I

    .line 980
    .line 981
    move-object/from16 v1, p1

    .line 982
    .line 983
    invoke-virtual {v3, v1, v8, v0, v7}, Lh1/r;->a(Landroid/graphics/Canvas;IILh1/n;)V

    .line 984
    .line 985
    .line 986
    const/16 v0, -0x55cd

    .line 987
    .line 988
    invoke-virtual {v13, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 989
    .line 990
    .line 991
    const v0, -0x1f8a66

    .line 992
    .line 993
    .line 994
    move-object/from16 v2, v29

    .line 995
    .line 996
    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 997
    .line 998
    .line 999
    move-object/from16 v2, v28

    .line 1000
    .line 1001
    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 1002
    .line 1003
    .line 1004
    const v0, -0xcc5600

    .line 1005
    .line 1006
    .line 1007
    move-object/from16 v2, v27

    .line 1008
    .line 1009
    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 1010
    .line 1011
    .line 1012
    move/from16 v0, v26

    .line 1013
    .line 1014
    neg-int v0, v0

    .line 1015
    int-to-float v0, v0

    .line 1016
    invoke-virtual {v1, v0, v0}, Landroid/graphics/Canvas;->translate(FF)V

    .line 1017
    .line 1018
    .line 1019
    iget v0, v3, Lh1/r;->k:I

    .line 1020
    .line 1021
    invoke-virtual {v3, v1, v8, v0, v7}, Lh1/r;->a(Landroid/graphics/Canvas;IILh1/n;)V

    .line 1022
    .line 1023
    .line 1024
    const/4 v0, 0x5

    .line 1025
    if-ne v8, v0, :cond_2d

    .line 1026
    .line 1027
    iget-object v2, v3, Lh1/r;->d:Landroid/graphics/Path;

    .line 1028
    .line 1029
    invoke-virtual {v2}, Landroid/graphics/Path;->reset()V

    .line 1030
    .line 1031
    .line 1032
    const/4 v2, 0x0

    .line 1033
    :goto_16
    const/16 v5, 0x32

    .line 1034
    .line 1035
    if-gt v2, v5, :cond_2c

    .line 1036
    .line 1037
    int-to-float v8, v2

    .line 1038
    int-to-float v5, v5

    .line 1039
    div-float/2addr v8, v5

    .line 1040
    const/4 v5, 0x0

    .line 1041
    invoke-virtual {v7, v5, v8}, Lh1/n;->b([FF)F

    .line 1042
    .line 1043
    .line 1044
    move-result v8

    .line 1045
    iget-object v9, v7, Lh1/n;->j:[Lb4/a;

    .line 1046
    .line 1047
    const/4 v10, 0x0

    .line 1048
    aget-object v9, v9, v10

    .line 1049
    .line 1050
    float-to-double v10, v8

    .line 1051
    iget-object v8, v7, Lh1/n;->p:[D

    .line 1052
    .line 1053
    invoke-virtual {v9, v10, v11, v8}, Lb4/a;->v(D[D)V

    .line 1054
    .line 1055
    .line 1056
    iget-object v8, v7, Lh1/n;->o:[I

    .line 1057
    .line 1058
    iget-object v9, v7, Lh1/n;->p:[D

    .line 1059
    .line 1060
    iget v10, v6, Lh1/v;->e:F

    .line 1061
    .line 1062
    iget v11, v6, Lh1/v;->f:F

    .line 1063
    .line 1064
    iget v12, v6, Lh1/v;->g:F

    .line 1065
    .line 1066
    iget v14, v6, Lh1/v;->h:F

    .line 1067
    .line 1068
    move v15, v14

    .line 1069
    move v14, v12

    .line 1070
    move v12, v11

    .line 1071
    move v11, v10

    .line 1072
    const/4 v10, 0x0

    .line 1073
    :goto_17
    array-length v5, v8

    .line 1074
    const/4 v4, 0x3

    .line 1075
    if-ge v10, v5, :cond_2a

    .line 1076
    .line 1077
    aget-wide v0, v9, v10

    .line 1078
    .line 1079
    double-to-float v0, v0

    .line 1080
    aget v1, v8, v10

    .line 1081
    .line 1082
    const/4 v5, 0x1

    .line 1083
    if-eq v1, v5, :cond_29

    .line 1084
    .line 1085
    const/4 v5, 0x2

    .line 1086
    if-eq v1, v5, :cond_28

    .line 1087
    .line 1088
    if-eq v1, v4, :cond_27

    .line 1089
    .line 1090
    const/4 v4, 0x4

    .line 1091
    if-eq v1, v4, :cond_26

    .line 1092
    .line 1093
    goto :goto_18

    .line 1094
    :cond_26
    move v15, v0

    .line 1095
    goto :goto_18

    .line 1096
    :cond_27
    move v14, v0

    .line 1097
    goto :goto_18

    .line 1098
    :cond_28
    move v12, v0

    .line 1099
    goto :goto_18

    .line 1100
    :cond_29
    move v11, v0

    .line 1101
    :goto_18
    add-int/lit8 v10, v10, 0x1

    .line 1102
    .line 1103
    move-object/from16 v1, p1

    .line 1104
    .line 1105
    const/4 v0, 0x5

    .line 1106
    goto :goto_17

    .line 1107
    :cond_2a
    iget-object v0, v6, Lh1/v;->m:Lh1/n;

    .line 1108
    .line 1109
    if-eqz v0, :cond_2b

    .line 1110
    .line 1111
    const/4 v0, 0x0

    .line 1112
    float-to-double v8, v0

    .line 1113
    float-to-double v0, v11

    .line 1114
    float-to-double v10, v12

    .line 1115
    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    .line 1116
    .line 1117
    .line 1118
    move-result-wide v20

    .line 1119
    mul-double v20, v20, v0

    .line 1120
    .line 1121
    add-double v20, v20, v8

    .line 1122
    .line 1123
    const/high16 v12, 0x40000000    # 2.0f

    .line 1124
    .line 1125
    div-float v5, v14, v12

    .line 1126
    .line 1127
    float-to-double v4, v5

    .line 1128
    sub-double v4, v20, v4

    .line 1129
    .line 1130
    double-to-float v4, v4

    .line 1131
    invoke-static {v10, v11}, Ljava/lang/Math;->cos(D)D

    .line 1132
    .line 1133
    .line 1134
    move-result-wide v10

    .line 1135
    mul-double/2addr v10, v0

    .line 1136
    sub-double/2addr v8, v10

    .line 1137
    div-float v0, v15, v12

    .line 1138
    .line 1139
    float-to-double v0, v0

    .line 1140
    sub-double/2addr v8, v0

    .line 1141
    double-to-float v12, v8

    .line 1142
    move v11, v4

    .line 1143
    :cond_2b
    add-float/2addr v14, v11

    .line 1144
    add-float/2addr v15, v12

    .line 1145
    invoke-static/range {v16 .. v16}, Ljava/lang/Float;->isNaN(F)Z

    .line 1146
    .line 1147
    .line 1148
    invoke-static/range {v16 .. v16}, Ljava/lang/Float;->isNaN(F)Z

    .line 1149
    .line 1150
    .line 1151
    const/4 v0, 0x0

    .line 1152
    add-float/2addr v11, v0

    .line 1153
    add-float/2addr v12, v0

    .line 1154
    add-float/2addr v14, v0

    .line 1155
    add-float/2addr v15, v0

    .line 1156
    iget-object v1, v3, Lh1/r;->j:[F

    .line 1157
    .line 1158
    const/4 v4, 0x0

    .line 1159
    aput v11, v1, v4

    .line 1160
    .line 1161
    const/4 v8, 0x1

    .line 1162
    aput v12, v1, v8

    .line 1163
    .line 1164
    const/4 v5, 0x2

    .line 1165
    aput v14, v1, v5

    .line 1166
    .line 1167
    const/4 v5, 0x3

    .line 1168
    aput v12, v1, v5

    .line 1169
    .line 1170
    const/4 v5, 0x4

    .line 1171
    aput v14, v1, v5

    .line 1172
    .line 1173
    const/4 v9, 0x5

    .line 1174
    aput v15, v1, v9

    .line 1175
    .line 1176
    const/4 v9, 0x6

    .line 1177
    aput v11, v1, v9

    .line 1178
    .line 1179
    const/4 v10, 0x7

    .line 1180
    aput v15, v1, v10

    .line 1181
    .line 1182
    iget-object v14, v3, Lh1/r;->d:Landroid/graphics/Path;

    .line 1183
    .line 1184
    invoke-virtual {v14, v11, v12}, Landroid/graphics/Path;->moveTo(FF)V

    .line 1185
    .line 1186
    .line 1187
    iget-object v11, v3, Lh1/r;->d:Landroid/graphics/Path;

    .line 1188
    .line 1189
    const/4 v12, 0x2

    .line 1190
    aget v14, v1, v12

    .line 1191
    .line 1192
    const/4 v15, 0x3

    .line 1193
    aget v15, v1, v15

    .line 1194
    .line 1195
    invoke-virtual {v11, v14, v15}, Landroid/graphics/Path;->lineTo(FF)V

    .line 1196
    .line 1197
    .line 1198
    iget-object v11, v3, Lh1/r;->d:Landroid/graphics/Path;

    .line 1199
    .line 1200
    const/4 v5, 0x4

    .line 1201
    aget v5, v1, v5

    .line 1202
    .line 1203
    const/4 v14, 0x5

    .line 1204
    aget v15, v1, v14

    .line 1205
    .line 1206
    invoke-virtual {v11, v5, v15}, Landroid/graphics/Path;->lineTo(FF)V

    .line 1207
    .line 1208
    .line 1209
    iget-object v5, v3, Lh1/r;->d:Landroid/graphics/Path;

    .line 1210
    .line 1211
    aget v9, v1, v9

    .line 1212
    .line 1213
    aget v1, v1, v10

    .line 1214
    .line 1215
    invoke-virtual {v5, v9, v1}, Landroid/graphics/Path;->lineTo(FF)V

    .line 1216
    .line 1217
    .line 1218
    iget-object v1, v3, Lh1/r;->d:Landroid/graphics/Path;

    .line 1219
    .line 1220
    invoke-virtual {v1}, Landroid/graphics/Path;->close()V

    .line 1221
    .line 1222
    .line 1223
    add-int/lit8 v2, v2, 0x1

    .line 1224
    .line 1225
    move-object/from16 v1, p1

    .line 1226
    .line 1227
    move v0, v14

    .line 1228
    goto/16 :goto_16

    .line 1229
    .line 1230
    :cond_2c
    const/4 v4, 0x0

    .line 1231
    const/4 v8, 0x1

    .line 1232
    const/4 v12, 0x2

    .line 1233
    const/high16 v0, 0x44000000    # 512.0f

    .line 1234
    .line 1235
    invoke-virtual {v13, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 1236
    .line 1237
    .line 1238
    move-object/from16 v0, p1

    .line 1239
    .line 1240
    const/high16 v1, 0x40000000    # 2.0f

    .line 1241
    .line 1242
    invoke-virtual {v0, v1, v1}, Landroid/graphics/Canvas;->translate(FF)V

    .line 1243
    .line 1244
    .line 1245
    iget-object v1, v3, Lh1/r;->d:Landroid/graphics/Path;

    .line 1246
    .line 1247
    invoke-virtual {v0, v1, v13}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 1248
    .line 1249
    .line 1250
    const/high16 v1, -0x40000000    # -2.0f

    .line 1251
    .line 1252
    invoke-virtual {v0, v1, v1}, Landroid/graphics/Canvas;->translate(FF)V

    .line 1253
    .line 1254
    .line 1255
    const/high16 v1, -0x10000

    .line 1256
    .line 1257
    invoke-virtual {v13, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 1258
    .line 1259
    .line 1260
    iget-object v1, v3, Lh1/r;->d:Landroid/graphics/Path;

    .line 1261
    .line 1262
    invoke-virtual {v0, v1, v13}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 1263
    .line 1264
    .line 1265
    goto :goto_1a

    .line 1266
    :cond_2d
    move-object v0, v1

    .line 1267
    const/4 v4, 0x0

    .line 1268
    const/4 v8, 0x1

    .line 1269
    :goto_19
    const/4 v12, 0x2

    .line 1270
    goto :goto_1a

    .line 1271
    :cond_2e
    move-object v0, v1

    .line 1272
    move v8, v2

    .line 1273
    move/from16 v23, v9

    .line 1274
    .line 1275
    move/from16 v25, v10

    .line 1276
    .line 1277
    const/4 v4, 0x0

    .line 1278
    goto :goto_19

    .line 1279
    :goto_1a
    move-object v1, v0

    .line 1280
    move v2, v4

    .line 1281
    move v5, v8

    .line 1282
    move/from16 v9, v23

    .line 1283
    .line 1284
    move-object/from16 v6, v24

    .line 1285
    .line 1286
    move/from16 v10, v25

    .line 1287
    .line 1288
    const/4 v4, 0x0

    .line 1289
    move-object/from16 v0, p0

    .line 1290
    .line 1291
    goto/16 :goto_5

    .line 1292
    .line 1293
    :cond_2f
    move-object v0, v1

    .line 1294
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->restore()V

    .line 1295
    .line 1296
    .line 1297
    :cond_30
    :goto_1b
    move-object/from16 v0, p0

    .line 1298
    .line 1299
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 1300
    .line 1301
    if-eqz v1, :cond_31

    .line 1302
    .line 1303
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 1304
    .line 1305
    .line 1306
    move-result-object v1

    .line 1307
    :goto_1c
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    .line 1308
    .line 1309
    .line 1310
    move-result v2

    .line 1311
    if-eqz v2, :cond_31

    .line 1312
    .line 1313
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 1314
    .line 1315
    .line 1316
    move-result-object v2

    .line 1317
    check-cast v2, Landroidx/constraintlayout/motion/widget/MotionHelper;

    .line 1318
    .line 1319
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 1320
    .line 1321
    .line 1322
    goto :goto_1c

    .line 1323
    :cond_31
    return-void
.end method

.method public final g(Landroid/view/View;IIIII[I)V
    .locals 0

    .line 1
    iget-boolean p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->U:Z

    .line 2
    .line 3
    const/4 p6, 0x0

    .line 4
    if-nez p1, :cond_0

    .line 5
    .line 6
    if-nez p2, :cond_0

    .line 7
    .line 8
    if-eqz p3, :cond_1

    .line 9
    .line 10
    :cond_0
    aget p1, p7, p6

    .line 11
    .line 12
    add-int/2addr p1, p4

    .line 13
    aput p1, p7, p6

    .line 14
    .line 15
    const/4 p1, 0x1

    .line 16
    aget p2, p7, p1

    .line 17
    .line 18
    add-int/2addr p2, p5

    .line 19
    aput p2, p7, p1

    .line 20
    .line 21
    :cond_1
    iput-boolean p6, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->U:Z

    .line 22
    .line 23
    return-void
.end method

.method public getConstraintSetIds()[I
    .locals 5

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    const/4 v0, 0x0

    .line 6
    return-object v0

    .line 7
    :cond_0
    iget-object v0, v0, Landroidx/constraintlayout/motion/widget/c;->g:Landroid/util/SparseArray;

    .line 8
    .line 9
    invoke-virtual {v0}, Landroid/util/SparseArray;->size()I

    .line 10
    .line 11
    .line 12
    move-result v1

    .line 13
    new-array v2, v1, [I

    .line 14
    .line 15
    const/4 v3, 0x0

    .line 16
    :goto_0
    if-ge v3, v1, :cond_1

    .line 17
    .line 18
    invoke-virtual {v0, v3}, Landroid/util/SparseArray;->keyAt(I)I

    .line 19
    .line 20
    .line 21
    move-result v4

    .line 22
    aput v4, v2, v3

    .line 23
    .line 24
    add-int/lit8 v3, v3, 0x1

    .line 25
    .line 26
    goto :goto_0

    .line 27
    :cond_1
    return-object v2
.end method

.method public getCurrentState()I
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 2
    .line 3
    return v0
.end method

.method public getDefinedTransitions()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lh1/x;",
            ">;"
        }
    .end annotation

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    const/4 v0, 0x0

    .line 6
    return-object v0

    .line 7
    :cond_0
    iget-object v0, v0, Landroidx/constraintlayout/motion/widget/c;->d:Ljava/util/ArrayList;

    .line 8
    .line 9
    return-object v0
.end method

.method public getDesignTool()Lh1/a;
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->R:Lh1/a;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    new-instance v0, Lh1/a;

    .line 6
    .line 7
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 8
    .line 9
    .line 10
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->R:Lh1/a;

    .line 11
    .line 12
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->R:Lh1/a;

    .line 13
    .line 14
    return-object v0
.end method

.method public getEndState()I
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 2
    .line 3
    return v0
.end method

.method public getNanoTime()J
    .locals 2

    .line 1
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    .line 2
    .line 3
    .line 4
    move-result-wide v0

    .line 5
    return-wide v0
.end method

.method public getProgress()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 2
    .line 3
    return v0
.end method

.method public getScene()Landroidx/constraintlayout/motion/widget/c;
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    return-object v0
.end method

.method public getStartState()I
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 2
    .line 3
    return v0
.end method

.method public getTargetPosition()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 2
    .line 3
    return v0
.end method

.method public getTransitionState()Landroid/os/Bundle;
    .locals 4

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    new-instance v0, Landroidx/constraintlayout/motion/widget/b;

    .line 6
    .line 7
    invoke-direct {v0, p0}, Landroidx/constraintlayout/motion/widget/b;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 8
    .line 9
    .line 10
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 11
    .line 12
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 13
    .line 14
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/b;->e:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 15
    .line 16
    iget v2, v1, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 17
    .line 18
    iput v2, v0, Landroidx/constraintlayout/motion/widget/b;->d:I

    .line 19
    .line 20
    iget v2, v1, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 21
    .line 22
    iput v2, v0, Landroidx/constraintlayout/motion/widget/b;->c:I

    .line 23
    .line 24
    invoke-virtual {v1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getVelocity()F

    .line 25
    .line 26
    .line 27
    move-result v2

    .line 28
    iput v2, v0, Landroidx/constraintlayout/motion/widget/b;->b:F

    .line 29
    .line 30
    invoke-virtual {v1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 31
    .line 32
    .line 33
    move-result v1

    .line 34
    iput v1, v0, Landroidx/constraintlayout/motion/widget/b;->a:F

    .line 35
    .line 36
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 37
    .line 38
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 39
    .line 40
    .line 41
    new-instance v1, Landroid/os/Bundle;

    .line 42
    .line 43
    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 44
    .line 45
    .line 46
    const-string v2, "motion.progress"

    .line 47
    .line 48
    iget v3, v0, Landroidx/constraintlayout/motion/widget/b;->a:F

    .line 49
    .line 50
    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->putFloat(Ljava/lang/String;F)V

    .line 51
    .line 52
    .line 53
    const-string v2, "motion.velocity"

    .line 54
    .line 55
    iget v3, v0, Landroidx/constraintlayout/motion/widget/b;->b:F

    .line 56
    .line 57
    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->putFloat(Ljava/lang/String;F)V

    .line 58
    .line 59
    .line 60
    const-string v2, "motion.StartState"

    .line 61
    .line 62
    iget v3, v0, Landroidx/constraintlayout/motion/widget/b;->c:I

    .line 63
    .line 64
    invoke-virtual {v1, v2, v3}, Landroid/os/BaseBundle;->putInt(Ljava/lang/String;I)V

    .line 65
    .line 66
    .line 67
    const-string v2, "motion.EndState"

    .line 68
    .line 69
    iget v0, v0, Landroidx/constraintlayout/motion/widget/b;->d:I

    .line 70
    .line 71
    invoke-virtual {v1, v2, v0}, Landroid/os/BaseBundle;->putInt(Ljava/lang/String;I)V

    .line 72
    .line 73
    .line 74
    return-object v1
.end method

.method public getTransitionTimeMs()J
    .locals 2

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    const/high16 v1, 0x447a0000    # 1000.0f

    .line 4
    .line 5
    if-eqz v0, :cond_0

    .line 6
    .line 7
    invoke-virtual {v0}, Landroidx/constraintlayout/motion/widget/c;->c()I

    .line 8
    .line 9
    .line 10
    move-result v0

    .line 11
    int-to-float v0, v0

    .line 12
    div-float/2addr v0, v1

    .line 13
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 14
    .line 15
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 16
    .line 17
    mul-float/2addr v0, v1

    .line 18
    float-to-long v0, v0

    .line 19
    return-wide v0
.end method

.method public getVelocity()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 2
    .line 3
    return v0
.end method

.method public final h(Landroid/view/View;IIIII)V
    .locals 0

    .line 1
    return-void
.end method

.method public final i(Landroid/view/View;Landroid/view/View;II)Z
    .locals 0

    .line 1
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-eqz p1, :cond_1

    .line 4
    .line 5
    iget-object p1, p1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 6
    .line 7
    if-eqz p1, :cond_1

    .line 8
    .line 9
    iget-object p1, p1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 10
    .line 11
    if-eqz p1, :cond_1

    .line 12
    .line 13
    iget p1, p1, Landroidx/constraintlayout/motion/widget/d;->w:I

    .line 14
    .line 15
    and-int/lit8 p1, p1, 0x2

    .line 16
    .line 17
    if-eqz p1, :cond_0

    .line 18
    .line 19
    goto :goto_0

    .line 20
    :cond_0
    const/4 p1, 0x1

    .line 21
    return p1

    .line 22
    :cond_1
    :goto_0
    const/4 p1, 0x0

    .line 23
    return p1
.end method

.method public final m(I)V
    .locals 0

    .line 1
    const/4 p1, 0x0

    .line 2
    iput-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->k:Lcom/google/firebase/messaging/o;

    .line 3
    .line 4
    return-void
.end method

.method public final onAttachedToWindow()V
    .locals 8

    .line 1
    invoke-super {p0}, Landroid/view/ViewGroup;->onAttachedToWindow()V

    .line 2
    .line 3
    .line 4
    invoke-virtual {p0}, Landroid/view/View;->getDisplay()Landroid/view/Display;

    .line 5
    .line 6
    .line 7
    move-result-object v0

    .line 8
    if-eqz v0, :cond_0

    .line 9
    .line 10
    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    .line 11
    .line 12
    .line 13
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 14
    .line 15
    if-eqz v0, :cond_7

    .line 16
    .line 17
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 18
    .line 19
    const/4 v2, -0x1

    .line 20
    if-eq v1, v2, :cond_7

    .line 21
    .line 22
    invoke-virtual {v0, v1}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 23
    .line 24
    .line 25
    move-result-object v0

    .line 26
    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 27
    .line 28
    const/4 v2, 0x0

    .line 29
    :goto_0
    iget-object v3, v1, Landroidx/constraintlayout/motion/widget/c;->g:Landroid/util/SparseArray;

    .line 30
    .line 31
    invoke-virtual {v3}, Landroid/util/SparseArray;->size()I

    .line 32
    .line 33
    .line 34
    move-result v4

    .line 35
    if-ge v2, v4, :cond_4

    .line 36
    .line 37
    invoke-virtual {v3, v2}, Landroid/util/SparseArray;->keyAt(I)I

    .line 38
    .line 39
    .line 40
    move-result v3

    .line 41
    iget-object v4, v1, Landroidx/constraintlayout/motion/widget/c;->i:Landroid/util/SparseIntArray;

    .line 42
    .line 43
    invoke-virtual {v4, v3}, Landroid/util/SparseIntArray;->get(I)I

    .line 44
    .line 45
    .line 46
    move-result v5

    .line 47
    invoke-virtual {v4}, Landroid/util/SparseIntArray;->size()I

    .line 48
    .line 49
    .line 50
    move-result v6

    .line 51
    :goto_1
    if-lez v5, :cond_3

    .line 52
    .line 53
    if-ne v5, v3, :cond_1

    .line 54
    .line 55
    goto :goto_2

    .line 56
    :cond_1
    add-int/lit8 v7, v6, -0x1

    .line 57
    .line 58
    if-gez v6, :cond_2

    .line 59
    .line 60
    :goto_2
    const-string v1, "MotionScene"

    .line 61
    .line 62
    const-string v2, "Cannot be derived from yourself"

    .line 63
    .line 64
    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 65
    .line 66
    .line 67
    goto :goto_3

    .line 68
    :cond_2
    invoke-virtual {v4, v5}, Landroid/util/SparseIntArray;->get(I)I

    .line 69
    .line 70
    .line 71
    move-result v5

    .line 72
    move v6, v7

    .line 73
    goto :goto_1

    .line 74
    :cond_3
    invoke-virtual {v1, v3, p0}, Landroidx/constraintlayout/motion/widget/c;->m(ILandroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 75
    .line 76
    .line 77
    add-int/lit8 v2, v2, 0x1

    .line 78
    .line 79
    goto :goto_0

    .line 80
    :cond_4
    :goto_3
    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 81
    .line 82
    if-eqz v1, :cond_5

    .line 83
    .line 84
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 85
    .line 86
    .line 87
    move-result-object v1

    .line 88
    :goto_4
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    .line 89
    .line 90
    .line 91
    move-result v2

    .line 92
    if-eqz v2, :cond_5

    .line 93
    .line 94
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 95
    .line 96
    .line 97
    move-result-object v2

    .line 98
    check-cast v2, Landroidx/constraintlayout/motion/widget/MotionHelper;

    .line 99
    .line 100
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 101
    .line 102
    .line 103
    goto :goto_4

    .line 104
    :cond_5
    if-eqz v0, :cond_6

    .line 105
    .line 106
    invoke-virtual {v0, p0}, Landroidx/constraintlayout/widget/d;->b(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 107
    .line 108
    .line 109
    :cond_6
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 110
    .line 111
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 112
    .line 113
    :cond_7
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->A()V

    .line 114
    .line 115
    .line 116
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 117
    .line 118
    if-eqz v0, :cond_9

    .line 119
    .line 120
    iget-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->z0:Z

    .line 121
    .line 122
    if-eqz v1, :cond_8

    .line 123
    .line 124
    new-instance v0, Lh1/p;

    .line 125
    .line 126
    const/4 v1, 0x1

    .line 127
    invoke-direct {v0, p0, v1}, Lh1/p;-><init>(Landroid/view/ViewGroup;I)V

    .line 128
    .line 129
    .line 130
    invoke-virtual {p0, v0}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 131
    .line 132
    .line 133
    goto :goto_5

    .line 134
    :cond_8
    invoke-virtual {v0}, Landroidx/constraintlayout/motion/widget/b;->a()V

    .line 135
    .line 136
    .line 137
    goto :goto_5

    .line 138
    :cond_9
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 139
    .line 140
    if-eqz v0, :cond_a

    .line 141
    .line 142
    iget-object v0, v0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 143
    .line 144
    if-eqz v0, :cond_a

    .line 145
    .line 146
    iget v0, v0, Lh1/x;->n:I

    .line 147
    .line 148
    const/4 v1, 0x4

    .line 149
    if-ne v0, v1, :cond_a

    .line 150
    .line 151
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->H()V

    .line 152
    .line 153
    .line 154
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->SETUP:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 155
    .line 156
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 157
    .line 158
    .line 159
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 160
    .line 161
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 162
    .line 163
    .line 164
    :cond_a
    :goto_5
    return-void
.end method

.method public final onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 22

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    const/4 v2, 0x2

    .line 4
    const/4 v3, 0x1

    .line 5
    iget-object v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 6
    .line 7
    if-eqz v4, :cond_0

    .line 8
    .line 9
    iget-boolean v6, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B:Z

    .line 10
    .line 11
    if-nez v6, :cond_1

    .line 12
    .line 13
    :cond_0
    const/4 v1, 0x0

    .line 14
    goto/16 :goto_16

    .line 15
    .line 16
    :cond_1
    const/4 v6, -0x1

    .line 17
    iget-object v4, v4, Landroidx/constraintlayout/motion/widget/c;->q:Las/c;

    .line 18
    .line 19
    if-eqz v4, :cond_2b

    .line 20
    .line 21
    iget-object v7, v4, Las/c;->b:Ljava/lang/Object;

    .line 22
    .line 23
    move-object v15, v7

    .line 24
    check-cast v15, Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 25
    .line 26
    invoke-virtual {v15}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getCurrentState()I

    .line 27
    .line 28
    .line 29
    move-result v14

    .line 30
    if-ne v14, v6, :cond_2

    .line 31
    .line 32
    goto/16 :goto_15

    .line 33
    .line 34
    :cond_2
    iget-object v7, v4, Las/c;->d:Ljava/lang/Object;

    .line 35
    .line 36
    check-cast v7, Ljava/util/HashSet;

    .line 37
    .line 38
    iget-object v8, v4, Las/c;->c:Ljava/lang/Object;

    .line 39
    .line 40
    check-cast v8, Ljava/util/ArrayList;

    .line 41
    .line 42
    if-nez v7, :cond_5

    .line 43
    .line 44
    new-instance v7, Ljava/util/HashSet;

    .line 45
    .line 46
    invoke-direct {v7}, Ljava/util/HashSet;-><init>()V

    .line 47
    .line 48
    .line 49
    iput-object v7, v4, Las/c;->d:Ljava/lang/Object;

    .line 50
    .line 51
    invoke-virtual {v8}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 52
    .line 53
    .line 54
    move-result-object v7

    .line 55
    :cond_3
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    .line 56
    .line 57
    .line 58
    move-result v9

    .line 59
    if-eqz v9, :cond_5

    .line 60
    .line 61
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 62
    .line 63
    .line 64
    move-result-object v9

    .line 65
    check-cast v9, Lh1/a0;

    .line 66
    .line 67
    invoke-virtual {v15}, Landroid/view/ViewGroup;->getChildCount()I

    .line 68
    .line 69
    .line 70
    move-result v10

    .line 71
    const/4 v11, 0x0

    .line 72
    :goto_0
    if-ge v11, v10, :cond_3

    .line 73
    .line 74
    invoke-virtual {v15, v11}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 75
    .line 76
    .line 77
    move-result-object v12

    .line 78
    invoke-virtual {v9, v12}, Lh1/a0;->a(Landroid/view/View;)Z

    .line 79
    .line 80
    .line 81
    move-result v13

    .line 82
    if-eqz v13, :cond_4

    .line 83
    .line 84
    invoke-virtual {v12}, Landroid/view/View;->getId()I

    .line 85
    .line 86
    .line 87
    iget-object v13, v4, Las/c;->d:Ljava/lang/Object;

    .line 88
    .line 89
    check-cast v13, Ljava/util/HashSet;

    .line 90
    .line 91
    invoke-virtual {v13, v12}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 92
    .line 93
    .line 94
    :cond_4
    add-int/2addr v11, v3

    .line 95
    goto :goto_0

    .line 96
    :cond_5
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getX()F

    .line 97
    .line 98
    .line 99
    move-result v13

    .line 100
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getY()F

    .line 101
    .line 102
    .line 103
    move-result v12

    .line 104
    new-instance v11, Landroid/graphics/Rect;

    .line 105
    .line 106
    invoke-direct {v11}, Landroid/graphics/Rect;-><init>()V

    .line 107
    .line 108
    .line 109
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    .line 110
    .line 111
    .line 112
    move-result v10

    .line 113
    iget-object v7, v4, Las/c;->e:Ljava/lang/Object;

    .line 114
    .line 115
    check-cast v7, Ljava/util/ArrayList;

    .line 116
    .line 117
    if-eqz v7, :cond_9

    .line 118
    .line 119
    invoke-virtual {v7}, Ljava/util/ArrayList;->isEmpty()Z

    .line 120
    .line 121
    .line 122
    move-result v7

    .line 123
    if-nez v7, :cond_9

    .line 124
    .line 125
    iget-object v7, v4, Las/c;->e:Ljava/lang/Object;

    .line 126
    .line 127
    check-cast v7, Ljava/util/ArrayList;

    .line 128
    .line 129
    invoke-virtual {v7}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 130
    .line 131
    .line 132
    move-result-object v7

    .line 133
    :goto_1
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    .line 134
    .line 135
    .line 136
    move-result v9

    .line 137
    if-eqz v9, :cond_9

    .line 138
    .line 139
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 140
    .line 141
    .line 142
    move-result-object v9

    .line 143
    check-cast v9, Lh1/z;

    .line 144
    .line 145
    if-eq v10, v3, :cond_7

    .line 146
    .line 147
    if-eq v10, v2, :cond_6

    .line 148
    .line 149
    invoke-virtual {v9}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 150
    .line 151
    .line 152
    goto :goto_2

    .line 153
    :cond_6
    iget-object v1, v9, Lh1/z;->c:Lh1/n;

    .line 154
    .line 155
    iget-object v1, v1, Lh1/n;->b:Landroid/view/View;

    .line 156
    .line 157
    iget-object v6, v9, Lh1/z;->l:Landroid/graphics/Rect;

    .line 158
    .line 159
    invoke-virtual {v1, v6}, Landroid/view/View;->getHitRect(Landroid/graphics/Rect;)V

    .line 160
    .line 161
    .line 162
    float-to-int v1, v13

    .line 163
    float-to-int v5, v12

    .line 164
    invoke-virtual {v6, v1, v5}, Landroid/graphics/Rect;->contains(II)Z

    .line 165
    .line 166
    .line 167
    move-result v1

    .line 168
    if-nez v1, :cond_8

    .line 169
    .line 170
    iget-boolean v1, v9, Lh1/z;->h:Z

    .line 171
    .line 172
    if-nez v1, :cond_8

    .line 173
    .line 174
    invoke-virtual {v9}, Lh1/z;->b()V

    .line 175
    .line 176
    .line 177
    goto :goto_2

    .line 178
    :cond_7
    iget-boolean v1, v9, Lh1/z;->h:Z

    .line 179
    .line 180
    if-nez v1, :cond_8

    .line 181
    .line 182
    invoke-virtual {v9}, Lh1/z;->b()V

    .line 183
    .line 184
    .line 185
    :cond_8
    :goto_2
    const/4 v6, -0x1

    .line 186
    goto :goto_1

    .line 187
    :cond_9
    if-eqz v10, :cond_a

    .line 188
    .line 189
    if-eq v10, v3, :cond_a

    .line 190
    .line 191
    goto/16 :goto_15

    .line 192
    .line 193
    :cond_a
    iget-object v1, v15, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 194
    .line 195
    if-nez v1, :cond_b

    .line 196
    .line 197
    const/4 v1, 0x0

    .line 198
    goto :goto_3

    .line 199
    :cond_b
    invoke-virtual {v1, v14}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 200
    .line 201
    .line 202
    move-result-object v1

    .line 203
    :goto_3
    invoke-virtual {v8}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 204
    .line 205
    .line 206
    move-result-object v6

    .line 207
    :goto_4
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    .line 208
    .line 209
    .line 210
    move-result v7

    .line 211
    if-eqz v7, :cond_2b

    .line 212
    .line 213
    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 214
    .line 215
    .line 216
    move-result-object v7

    .line 217
    move-object v9, v7

    .line 218
    check-cast v9, Lh1/a0;

    .line 219
    .line 220
    iget v7, v9, Lh1/a0;->b:I

    .line 221
    .line 222
    if-ne v7, v3, :cond_c

    .line 223
    .line 224
    if-nez v10, :cond_2a

    .line 225
    .line 226
    goto :goto_5

    .line 227
    :cond_c
    if-ne v7, v2, :cond_d

    .line 228
    .line 229
    if-ne v10, v3, :cond_2a

    .line 230
    .line 231
    goto :goto_5

    .line 232
    :cond_d
    const/4 v8, 0x3

    .line 233
    if-ne v7, v8, :cond_2a

    .line 234
    .line 235
    if-nez v10, :cond_2a

    .line 236
    .line 237
    :goto_5
    iget-object v7, v4, Las/c;->d:Ljava/lang/Object;

    .line 238
    .line 239
    check-cast v7, Ljava/util/HashSet;

    .line 240
    .line 241
    invoke-virtual {v7}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    .line 242
    .line 243
    .line 244
    move-result-object v16

    .line 245
    :goto_6
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->hasNext()Z

    .line 246
    .line 247
    .line 248
    move-result v7

    .line 249
    if-eqz v7, :cond_2a

    .line 250
    .line 251
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 252
    .line 253
    .line 254
    move-result-object v7

    .line 255
    check-cast v7, Landroid/view/View;

    .line 256
    .line 257
    invoke-virtual {v9, v7}, Lh1/a0;->a(Landroid/view/View;)Z

    .line 258
    .line 259
    .line 260
    move-result v8

    .line 261
    if-nez v8, :cond_e

    .line 262
    .line 263
    goto :goto_6

    .line 264
    :cond_e
    invoke-virtual {v7, v11}, Landroid/view/View;->getHitRect(Landroid/graphics/Rect;)V

    .line 265
    .line 266
    .line 267
    float-to-int v8, v13

    .line 268
    float-to-int v5, v12

    .line 269
    invoke-virtual {v11, v8, v5}, Landroid/graphics/Rect;->contains(II)Z

    .line 270
    .line 271
    .line 272
    move-result v5

    .line 273
    if-eqz v5, :cond_29

    .line 274
    .line 275
    new-array v5, v3, [Landroid/view/View;

    .line 276
    .line 277
    const/4 v8, 0x0

    .line 278
    aput-object v7, v5, v8

    .line 279
    .line 280
    iget-boolean v7, v9, Lh1/a0;->c:Z

    .line 281
    .line 282
    if-eqz v7, :cond_f

    .line 283
    .line 284
    goto/16 :goto_13

    .line 285
    .line 286
    :cond_f
    iget v7, v9, Lh1/a0;->e:I

    .line 287
    .line 288
    iget-object v3, v9, Lh1/a0;->f:Lh1/g;

    .line 289
    .line 290
    if-ne v7, v2, :cond_1b

    .line 291
    .line 292
    aget-object v5, v5, v8

    .line 293
    .line 294
    new-instance v8, Lh1/n;

    .line 295
    .line 296
    invoke-direct {v8, v5}, Lh1/n;-><init>(Landroid/view/View;)V

    .line 297
    .line 298
    .line 299
    iget-object v7, v8, Lh1/n;->f:Lh1/v;

    .line 300
    .line 301
    const/4 v2, 0x0

    .line 302
    iput v2, v7, Lh1/v;->c:F

    .line 303
    .line 304
    iput v2, v7, Lh1/v;->d:F

    .line 305
    .line 306
    const/4 v2, 0x1

    .line 307
    iput-boolean v2, v8, Lh1/n;->G:Z

    .line 308
    .line 309
    invoke-virtual {v5}, Landroid/view/View;->getX()F

    .line 310
    .line 311
    .line 312
    move-result v2

    .line 313
    move-object/from16 v18, v6

    .line 314
    .line 315
    invoke-virtual {v5}, Landroid/view/View;->getY()F

    .line 316
    .line 317
    .line 318
    move-result v6

    .line 319
    move/from16 v19, v10

    .line 320
    .line 321
    invoke-virtual {v5}, Landroid/view/View;->getWidth()I

    .line 322
    .line 323
    .line 324
    move-result v10

    .line 325
    int-to-float v10, v10

    .line 326
    move-object/from16 v20, v11

    .line 327
    .line 328
    invoke-virtual {v5}, Landroid/view/View;->getHeight()I

    .line 329
    .line 330
    .line 331
    move-result v11

    .line 332
    int-to-float v11, v11

    .line 333
    invoke-virtual {v7, v2, v6, v10, v11}, Lh1/v;->f(FFFF)V

    .line 334
    .line 335
    .line 336
    invoke-virtual {v5}, Landroid/view/View;->getX()F

    .line 337
    .line 338
    .line 339
    move-result v2

    .line 340
    invoke-virtual {v5}, Landroid/view/View;->getY()F

    .line 341
    .line 342
    .line 343
    move-result v6

    .line 344
    invoke-virtual {v5}, Landroid/view/View;->getWidth()I

    .line 345
    .line 346
    .line 347
    move-result v7

    .line 348
    int-to-float v7, v7

    .line 349
    invoke-virtual {v5}, Landroid/view/View;->getHeight()I

    .line 350
    .line 351
    .line 352
    move-result v10

    .line 353
    int-to-float v10, v10

    .line 354
    iget-object v11, v8, Lh1/n;->g:Lh1/v;

    .line 355
    .line 356
    invoke-virtual {v11, v2, v6, v7, v10}, Lh1/v;->f(FFFF)V

    .line 357
    .line 358
    .line 359
    iget-object v2, v8, Lh1/n;->h:Lh1/l;

    .line 360
    .line 361
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 362
    .line 363
    .line 364
    invoke-virtual {v5}, Landroid/view/View;->getX()F

    .line 365
    .line 366
    .line 367
    invoke-virtual {v5}, Landroid/view/View;->getY()F

    .line 368
    .line 369
    .line 370
    invoke-virtual {v5}, Landroid/view/View;->getWidth()I

    .line 371
    .line 372
    .line 373
    invoke-virtual {v5}, Landroid/view/View;->getHeight()I

    .line 374
    .line 375
    .line 376
    invoke-virtual {v5}, Landroid/view/View;->getVisibility()I

    .line 377
    .line 378
    .line 379
    move-result v6

    .line 380
    iput v6, v2, Lh1/l;->c:I

    .line 381
    .line 382
    invoke-virtual {v5}, Landroid/view/View;->getVisibility()I

    .line 383
    .line 384
    .line 385
    move-result v6

    .line 386
    if-eqz v6, :cond_10

    .line 387
    .line 388
    const/4 v6, 0x0

    .line 389
    goto :goto_7

    .line 390
    :cond_10
    invoke-virtual {v5}, Landroid/view/View;->getAlpha()F

    .line 391
    .line 392
    .line 393
    move-result v6

    .line 394
    :goto_7
    iput v6, v2, Lh1/l;->a:F

    .line 395
    .line 396
    invoke-virtual {v5}, Landroid/view/View;->getElevation()F

    .line 397
    .line 398
    .line 399
    move-result v6

    .line 400
    iput v6, v2, Lh1/l;->d:F

    .line 401
    .line 402
    invoke-virtual {v5}, Landroid/view/View;->getRotation()F

    .line 403
    .line 404
    .line 405
    move-result v6

    .line 406
    iput v6, v2, Lh1/l;->e:F

    .line 407
    .line 408
    invoke-virtual {v5}, Landroid/view/View;->getRotationX()F

    .line 409
    .line 410
    .line 411
    move-result v6

    .line 412
    iput v6, v2, Lh1/l;->f:F

    .line 413
    .line 414
    invoke-virtual {v5}, Landroid/view/View;->getRotationY()F

    .line 415
    .line 416
    .line 417
    move-result v6

    .line 418
    iput v6, v2, Lh1/l;->g:F

    .line 419
    .line 420
    invoke-virtual {v5}, Landroid/view/View;->getScaleX()F

    .line 421
    .line 422
    .line 423
    move-result v6

    .line 424
    iput v6, v2, Lh1/l;->h:F

    .line 425
    .line 426
    invoke-virtual {v5}, Landroid/view/View;->getScaleY()F

    .line 427
    .line 428
    .line 429
    move-result v6

    .line 430
    iput v6, v2, Lh1/l;->i:F

    .line 431
    .line 432
    invoke-virtual {v5}, Landroid/view/View;->getPivotX()F

    .line 433
    .line 434
    .line 435
    move-result v6

    .line 436
    iput v6, v2, Lh1/l;->j:F

    .line 437
    .line 438
    invoke-virtual {v5}, Landroid/view/View;->getPivotY()F

    .line 439
    .line 440
    .line 441
    move-result v6

    .line 442
    iput v6, v2, Lh1/l;->k:F

    .line 443
    .line 444
    invoke-virtual {v5}, Landroid/view/View;->getTranslationX()F

    .line 445
    .line 446
    .line 447
    move-result v6

    .line 448
    iput v6, v2, Lh1/l;->l:F

    .line 449
    .line 450
    invoke-virtual {v5}, Landroid/view/View;->getTranslationY()F

    .line 451
    .line 452
    .line 453
    move-result v6

    .line 454
    iput v6, v2, Lh1/l;->m:F

    .line 455
    .line 456
    invoke-virtual {v5}, Landroid/view/View;->getTranslationZ()F

    .line 457
    .line 458
    .line 459
    move-result v6

    .line 460
    iput v6, v2, Lh1/l;->n:F

    .line 461
    .line 462
    iget-object v2, v8, Lh1/n;->i:Lh1/l;

    .line 463
    .line 464
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 465
    .line 466
    .line 467
    invoke-virtual {v5}, Landroid/view/View;->getX()F

    .line 468
    .line 469
    .line 470
    invoke-virtual {v5}, Landroid/view/View;->getY()F

    .line 471
    .line 472
    .line 473
    invoke-virtual {v5}, Landroid/view/View;->getWidth()I

    .line 474
    .line 475
    .line 476
    invoke-virtual {v5}, Landroid/view/View;->getHeight()I

    .line 477
    .line 478
    .line 479
    invoke-virtual {v5}, Landroid/view/View;->getVisibility()I

    .line 480
    .line 481
    .line 482
    move-result v6

    .line 483
    iput v6, v2, Lh1/l;->c:I

    .line 484
    .line 485
    invoke-virtual {v5}, Landroid/view/View;->getVisibility()I

    .line 486
    .line 487
    .line 488
    move-result v6

    .line 489
    if-eqz v6, :cond_11

    .line 490
    .line 491
    const/4 v6, 0x0

    .line 492
    goto :goto_8

    .line 493
    :cond_11
    invoke-virtual {v5}, Landroid/view/View;->getAlpha()F

    .line 494
    .line 495
    .line 496
    move-result v6

    .line 497
    :goto_8
    iput v6, v2, Lh1/l;->a:F

    .line 498
    .line 499
    invoke-virtual {v5}, Landroid/view/View;->getElevation()F

    .line 500
    .line 501
    .line 502
    move-result v6

    .line 503
    iput v6, v2, Lh1/l;->d:F

    .line 504
    .line 505
    invoke-virtual {v5}, Landroid/view/View;->getRotation()F

    .line 506
    .line 507
    .line 508
    move-result v6

    .line 509
    iput v6, v2, Lh1/l;->e:F

    .line 510
    .line 511
    invoke-virtual {v5}, Landroid/view/View;->getRotationX()F

    .line 512
    .line 513
    .line 514
    move-result v6

    .line 515
    iput v6, v2, Lh1/l;->f:F

    .line 516
    .line 517
    invoke-virtual {v5}, Landroid/view/View;->getRotationY()F

    .line 518
    .line 519
    .line 520
    move-result v6

    .line 521
    iput v6, v2, Lh1/l;->g:F

    .line 522
    .line 523
    invoke-virtual {v5}, Landroid/view/View;->getScaleX()F

    .line 524
    .line 525
    .line 526
    move-result v6

    .line 527
    iput v6, v2, Lh1/l;->h:F

    .line 528
    .line 529
    invoke-virtual {v5}, Landroid/view/View;->getScaleY()F

    .line 530
    .line 531
    .line 532
    move-result v6

    .line 533
    iput v6, v2, Lh1/l;->i:F

    .line 534
    .line 535
    invoke-virtual {v5}, Landroid/view/View;->getPivotX()F

    .line 536
    .line 537
    .line 538
    move-result v6

    .line 539
    iput v6, v2, Lh1/l;->j:F

    .line 540
    .line 541
    invoke-virtual {v5}, Landroid/view/View;->getPivotY()F

    .line 542
    .line 543
    .line 544
    move-result v6

    .line 545
    iput v6, v2, Lh1/l;->k:F

    .line 546
    .line 547
    invoke-virtual {v5}, Landroid/view/View;->getTranslationX()F

    .line 548
    .line 549
    .line 550
    move-result v6

    .line 551
    iput v6, v2, Lh1/l;->l:F

    .line 552
    .line 553
    invoke-virtual {v5}, Landroid/view/View;->getTranslationY()F

    .line 554
    .line 555
    .line 556
    move-result v6

    .line 557
    iput v6, v2, Lh1/l;->m:F

    .line 558
    .line 559
    invoke-virtual {v5}, Landroid/view/View;->getTranslationZ()F

    .line 560
    .line 561
    .line 562
    move-result v5

    .line 563
    iput v5, v2, Lh1/l;->n:F

    .line 564
    .line 565
    const/4 v2, -0x1

    .line 566
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 567
    .line 568
    .line 569
    move-result-object v5

    .line 570
    iget-object v2, v3, Lh1/g;->a:Ljava/util/HashMap;

    .line 571
    .line 572
    invoke-virtual {v2, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 573
    .line 574
    .line 575
    move-result-object v2

    .line 576
    check-cast v2, Ljava/util/ArrayList;

    .line 577
    .line 578
    if-eqz v2, :cond_12

    .line 579
    .line 580
    iget-object v3, v8, Lh1/n;->w:Ljava/util/ArrayList;

    .line 581
    .line 582
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 583
    .line 584
    .line 585
    :cond_12
    invoke-virtual {v15}, Landroid/view/View;->getWidth()I

    .line 586
    .line 587
    .line 588
    move-result v2

    .line 589
    invoke-virtual {v15}, Landroid/view/View;->getHeight()I

    .line 590
    .line 591
    .line 592
    move-result v3

    .line 593
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    .line 594
    .line 595
    .line 596
    move-result-wide v5

    .line 597
    invoke-virtual {v8, v2, v3, v5, v6}, Lh1/n;->h(IIJ)V

    .line 598
    .line 599
    .line 600
    new-instance v7, Lh1/z;

    .line 601
    .line 602
    iget v10, v9, Lh1/a0;->h:I

    .line 603
    .line 604
    iget v11, v9, Lh1/a0;->i:I

    .line 605
    .line 606
    iget v2, v9, Lh1/a0;->b:I

    .line 607
    .line 608
    invoke-virtual {v15}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 609
    .line 610
    .line 611
    move-result-object v3

    .line 612
    iget v5, v9, Lh1/a0;->l:I

    .line 613
    .line 614
    const/4 v6, -0x2

    .line 615
    if-eq v5, v6, :cond_1a

    .line 616
    .line 617
    const/4 v6, -0x1

    .line 618
    if-eq v5, v6, :cond_19

    .line 619
    .line 620
    if-eqz v5, :cond_18

    .line 621
    .line 622
    const/4 v3, 0x1

    .line 623
    if-eq v5, v3, :cond_17

    .line 624
    .line 625
    const/4 v3, 0x2

    .line 626
    if-eq v5, v3, :cond_16

    .line 627
    .line 628
    const/4 v3, 0x4

    .line 629
    if-eq v5, v3, :cond_15

    .line 630
    .line 631
    const/4 v3, 0x5

    .line 632
    if-eq v5, v3, :cond_14

    .line 633
    .line 634
    const/4 v3, 0x6

    .line 635
    if-eq v5, v3, :cond_13

    .line 636
    .line 637
    const/4 v3, 0x0

    .line 638
    :goto_9
    const/4 v6, 0x2

    .line 639
    goto :goto_a

    .line 640
    :cond_13
    new-instance v3, Landroid/view/animation/AnticipateInterpolator;

    .line 641
    .line 642
    invoke-direct {v3}, Landroid/view/animation/AnticipateInterpolator;-><init>()V

    .line 643
    .line 644
    .line 645
    goto :goto_9

    .line 646
    :cond_14
    new-instance v3, Landroid/view/animation/OvershootInterpolator;

    .line 647
    .line 648
    invoke-direct {v3}, Landroid/view/animation/OvershootInterpolator;-><init>()V

    .line 649
    .line 650
    .line 651
    goto :goto_9

    .line 652
    :cond_15
    new-instance v3, Landroid/view/animation/BounceInterpolator;

    .line 653
    .line 654
    invoke-direct {v3}, Landroid/view/animation/BounceInterpolator;-><init>()V

    .line 655
    .line 656
    .line 657
    goto :goto_9

    .line 658
    :cond_16
    new-instance v3, Landroid/view/animation/DecelerateInterpolator;

    .line 659
    .line 660
    invoke-direct {v3}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    .line 661
    .line 662
    .line 663
    goto :goto_9

    .line 664
    :cond_17
    new-instance v3, Landroid/view/animation/AccelerateInterpolator;

    .line 665
    .line 666
    invoke-direct {v3}, Landroid/view/animation/AccelerateInterpolator;-><init>()V

    .line 667
    .line 668
    .line 669
    goto :goto_9

    .line 670
    :cond_18
    new-instance v3, Landroid/view/animation/AccelerateDecelerateInterpolator;

    .line 671
    .line 672
    invoke-direct {v3}, Landroid/view/animation/AccelerateDecelerateInterpolator;-><init>()V

    .line 673
    .line 674
    .line 675
    goto :goto_9

    .line 676
    :cond_19
    iget-object v3, v9, Lh1/a0;->m:Ljava/lang/String;

    .line 677
    .line 678
    invoke-static {v3}, Lb1/e;->d(Ljava/lang/String;)Lb1/e;

    .line 679
    .line 680
    .line 681
    move-result-object v3

    .line 682
    new-instance v5, Lh1/m;

    .line 683
    .line 684
    const/4 v6, 0x2

    .line 685
    invoke-direct {v5, v3, v6}, Lh1/m;-><init>(Lb1/e;I)V

    .line 686
    .line 687
    .line 688
    move-object v3, v5

    .line 689
    goto :goto_a

    .line 690
    :cond_1a
    const/4 v6, 0x2

    .line 691
    iget v5, v9, Lh1/a0;->n:I

    .line 692
    .line 693
    invoke-static {v3, v5}, Landroid/view/animation/AnimationUtils;->loadInterpolator(Landroid/content/Context;I)Landroid/view/animation/Interpolator;

    .line 694
    .line 695
    .line 696
    move-result-object v3

    .line 697
    :goto_a
    iget v5, v9, Lh1/a0;->p:I

    .line 698
    .line 699
    iget v6, v9, Lh1/a0;->q:I

    .line 700
    .line 701
    move-object/from16 v17, v8

    .line 702
    .line 703
    move-object v8, v4

    .line 704
    move-object/from16 v21, v4

    .line 705
    .line 706
    move-object v4, v9

    .line 707
    move-object/from16 v9, v17

    .line 708
    .line 709
    move/from16 v17, v19

    .line 710
    .line 711
    move-object/from16 v19, v20

    .line 712
    .line 713
    move/from16 v20, v12

    .line 714
    .line 715
    move v12, v2

    .line 716
    move v2, v13

    .line 717
    move-object v13, v3

    .line 718
    move v3, v14

    .line 719
    move v14, v5

    .line 720
    move-object v5, v15

    .line 721
    move v15, v6

    .line 722
    invoke-direct/range {v7 .. v15}, Lh1/z;-><init>(Las/c;Lh1/n;IIILandroid/view/animation/Interpolator;II)V

    .line 723
    .line 724
    .line 725
    move v8, v3

    .line 726
    move-object v6, v5

    .line 727
    const/4 v7, 0x4

    .line 728
    const/4 v11, 0x1

    .line 729
    goto/16 :goto_14

    .line 730
    .line 731
    :cond_1b
    move-object/from16 v21, v4

    .line 732
    .line 733
    move-object/from16 v18, v6

    .line 734
    .line 735
    move-object v4, v9

    .line 736
    move/from16 v17, v10

    .line 737
    .line 738
    move-object/from16 v19, v11

    .line 739
    .line 740
    move/from16 v20, v12

    .line 741
    .line 742
    move v2, v13

    .line 743
    move v8, v14

    .line 744
    move-object v6, v15

    .line 745
    iget-object v9, v4, Lh1/a0;->g:Landroidx/constraintlayout/widget/c;

    .line 746
    .line 747
    const/4 v10, 0x1

    .line 748
    if-ne v7, v10, :cond_21

    .line 749
    .line 750
    invoke-virtual {v6}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getConstraintSetIds()[I

    .line 751
    .line 752
    .line 753
    move-result-object v7

    .line 754
    const/4 v10, 0x0

    .line 755
    :goto_b
    array-length v11, v7

    .line 756
    if-ge v10, v11, :cond_20

    .line 757
    .line 758
    aget v11, v7, v10

    .line 759
    .line 760
    if-ne v11, v8, :cond_1d

    .line 761
    .line 762
    :cond_1c
    :goto_c
    const/4 v11, 0x1

    .line 763
    goto :goto_f

    .line 764
    :cond_1d
    iget-object v12, v6, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 765
    .line 766
    if-nez v12, :cond_1e

    .line 767
    .line 768
    const/4 v11, 0x0

    .line 769
    :goto_d
    const/4 v12, 0x0

    .line 770
    goto :goto_e

    .line 771
    :cond_1e
    invoke-virtual {v12, v11}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 772
    .line 773
    .line 774
    move-result-object v11

    .line 775
    goto :goto_d

    .line 776
    :goto_e
    aget-object v13, v5, v12

    .line 777
    .line 778
    invoke-virtual {v13}, Landroid/view/View;->getId()I

    .line 779
    .line 780
    .line 781
    move-result v12

    .line 782
    invoke-virtual {v11, v12}, Landroidx/constraintlayout/widget/d;->l(I)Landroidx/constraintlayout/widget/c;

    .line 783
    .line 784
    .line 785
    move-result-object v11

    .line 786
    if-eqz v9, :cond_1c

    .line 787
    .line 788
    iget-object v12, v9, Landroidx/constraintlayout/widget/c;->h:Lj1/f;

    .line 789
    .line 790
    if-eqz v12, :cond_1f

    .line 791
    .line 792
    invoke-virtual {v12, v11}, Lj1/f;->e(Landroidx/constraintlayout/widget/c;)V

    .line 793
    .line 794
    .line 795
    :cond_1f
    iget-object v11, v11, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 796
    .line 797
    iget-object v12, v9, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 798
    .line 799
    invoke-virtual {v11, v12}, Ljava/util/HashMap;->putAll(Ljava/util/Map;)V

    .line 800
    .line 801
    .line 802
    goto :goto_c

    .line 803
    :goto_f
    add-int/2addr v10, v11

    .line 804
    goto :goto_b

    .line 805
    :cond_20
    const/4 v11, 0x1

    .line 806
    goto :goto_10

    .line 807
    :cond_21
    move v11, v10

    .line 808
    :goto_10
    new-instance v7, Landroidx/constraintlayout/widget/d;

    .line 809
    .line 810
    invoke-direct {v7}, Landroidx/constraintlayout/widget/d;-><init>()V

    .line 811
    .line 812
    .line 813
    iget-object v10, v7, Landroidx/constraintlayout/widget/d;->f:Ljava/util/HashMap;

    .line 814
    .line 815
    invoke-virtual {v10}, Ljava/util/HashMap;->clear()V

    .line 816
    .line 817
    .line 818
    iget-object v12, v1, Landroidx/constraintlayout/widget/d;->f:Ljava/util/HashMap;

    .line 819
    .line 820
    invoke-virtual {v12}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    .line 821
    .line 822
    .line 823
    move-result-object v12

    .line 824
    invoke-interface {v12}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    .line 825
    .line 826
    .line 827
    move-result-object v12

    .line 828
    :goto_11
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    .line 829
    .line 830
    .line 831
    move-result v13

    .line 832
    if-eqz v13, :cond_23

    .line 833
    .line 834
    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 835
    .line 836
    .line 837
    move-result-object v13

    .line 838
    check-cast v13, Ljava/lang/Integer;

    .line 839
    .line 840
    iget-object v14, v1, Landroidx/constraintlayout/widget/d;->f:Ljava/util/HashMap;

    .line 841
    .line 842
    invoke-virtual {v14, v13}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 843
    .line 844
    .line 845
    move-result-object v14

    .line 846
    check-cast v14, Landroidx/constraintlayout/widget/c;

    .line 847
    .line 848
    if-nez v14, :cond_22

    .line 849
    .line 850
    goto :goto_11

    .line 851
    :cond_22
    invoke-virtual {v14}, Landroidx/constraintlayout/widget/c;->e()Landroidx/constraintlayout/widget/c;

    .line 852
    .line 853
    .line 854
    move-result-object v14

    .line 855
    invoke-virtual {v10, v13, v14}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 856
    .line 857
    .line 858
    goto :goto_11

    .line 859
    :cond_23
    const/4 v13, 0x0

    .line 860
    aget-object v10, v5, v13

    .line 861
    .line 862
    invoke-virtual {v10}, Landroid/view/View;->getId()I

    .line 863
    .line 864
    .line 865
    move-result v10

    .line 866
    invoke-virtual {v7, v10}, Landroidx/constraintlayout/widget/d;->l(I)Landroidx/constraintlayout/widget/c;

    .line 867
    .line 868
    .line 869
    move-result-object v10

    .line 870
    if-eqz v9, :cond_25

    .line 871
    .line 872
    iget-object v12, v9, Landroidx/constraintlayout/widget/c;->h:Lj1/f;

    .line 873
    .line 874
    if-eqz v12, :cond_24

    .line 875
    .line 876
    invoke-virtual {v12, v10}, Lj1/f;->e(Landroidx/constraintlayout/widget/c;)V

    .line 877
    .line 878
    .line 879
    :cond_24
    iget-object v10, v10, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 880
    .line 881
    iget-object v9, v9, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 882
    .line 883
    invoke-virtual {v10, v9}, Ljava/util/HashMap;->putAll(Ljava/util/Map;)V

    .line 884
    .line 885
    .line 886
    :cond_25
    invoke-virtual {v6, v8, v7}, Landroidx/constraintlayout/motion/widget/MotionLayout;->J(ILandroidx/constraintlayout/widget/d;)V

    .line 887
    .line 888
    .line 889
    const v7, 0x7f0a0ac1

    .line 890
    .line 891
    .line 892
    invoke-virtual {v6, v7, v1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->J(ILandroidx/constraintlayout/widget/d;)V

    .line 893
    .line 894
    .line 895
    invoke-virtual {v6, v7}, Landroidx/constraintlayout/motion/widget/MotionLayout;->E(I)V

    .line 896
    .line 897
    .line 898
    new-instance v7, Lh1/x;

    .line 899
    .line 900
    iget-object v9, v6, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 901
    .line 902
    invoke-direct {v7, v9, v8}, Lh1/x;-><init>(Landroidx/constraintlayout/motion/widget/c;I)V

    .line 903
    .line 904
    .line 905
    const/4 v9, 0x0

    .line 906
    aget-object v10, v5, v9

    .line 907
    .line 908
    iget v9, v4, Lh1/a0;->h:I

    .line 909
    .line 910
    const/4 v12, -0x1

    .line 911
    if-eq v9, v12, :cond_26

    .line 912
    .line 913
    const/16 v12, 0x8

    .line 914
    .line 915
    invoke-static {v9, v12}, Ljava/lang/Math;->max(II)I

    .line 916
    .line 917
    .line 918
    move-result v9

    .line 919
    iput v9, v7, Lh1/x;->h:I

    .line 920
    .line 921
    :cond_26
    iget v9, v4, Lh1/a0;->d:I

    .line 922
    .line 923
    iput v9, v7, Lh1/x;->p:I

    .line 924
    .line 925
    iget v9, v4, Lh1/a0;->l:I

    .line 926
    .line 927
    iget-object v12, v4, Lh1/a0;->m:Ljava/lang/String;

    .line 928
    .line 929
    iget v13, v4, Lh1/a0;->n:I

    .line 930
    .line 931
    iput v9, v7, Lh1/x;->e:I

    .line 932
    .line 933
    iput-object v12, v7, Lh1/x;->f:Ljava/lang/String;

    .line 934
    .line 935
    iput v13, v7, Lh1/x;->g:I

    .line 936
    .line 937
    invoke-virtual {v10}, Landroid/view/View;->getId()I

    .line 938
    .line 939
    .line 940
    move-result v9

    .line 941
    if-eqz v3, :cond_28

    .line 942
    .line 943
    const/4 v10, -0x1

    .line 944
    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 945
    .line 946
    .line 947
    move-result-object v12

    .line 948
    iget-object v3, v3, Lh1/g;->a:Ljava/util/HashMap;

    .line 949
    .line 950
    invoke-virtual {v3, v12}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 951
    .line 952
    .line 953
    move-result-object v3

    .line 954
    check-cast v3, Ljava/util/ArrayList;

    .line 955
    .line 956
    new-instance v10, Lh1/g;

    .line 957
    .line 958
    invoke-direct {v10}, Ljava/lang/Object;-><init>()V

    .line 959
    .line 960
    .line 961
    new-instance v12, Ljava/util/HashMap;

    .line 962
    .line 963
    invoke-direct {v12}, Ljava/util/HashMap;-><init>()V

    .line 964
    .line 965
    .line 966
    iput-object v12, v10, Lh1/g;->a:Ljava/util/HashMap;

    .line 967
    .line 968
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 969
    .line 970
    .line 971
    move-result-object v3

    .line 972
    :goto_12
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    .line 973
    .line 974
    .line 975
    move-result v12

    .line 976
    if-eqz v12, :cond_27

    .line 977
    .line 978
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 979
    .line 980
    .line 981
    move-result-object v12

    .line 982
    check-cast v12, Lh1/c;

    .line 983
    .line 984
    invoke-virtual {v12}, Lh1/c;->a()Lh1/c;

    .line 985
    .line 986
    .line 987
    move-result-object v12

    .line 988
    iput v9, v12, Lh1/c;->b:I

    .line 989
    .line 990
    invoke-virtual {v10, v12}, Lh1/g;->b(Lh1/c;)V

    .line 991
    .line 992
    .line 993
    goto :goto_12

    .line 994
    :cond_27
    iget-object v3, v7, Lh1/x;->k:Ljava/util/ArrayList;

    .line 995
    .line 996
    invoke-virtual {v3, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 997
    .line 998
    .line 999
    :cond_28
    invoke-virtual {v6, v7}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setTransition(Lh1/x;)V

    .line 1000
    .line 1001
    .line 1002
    new-instance v3, Lcom/vungle/ads/internal/util/d;

    .line 1003
    .line 1004
    const/4 v7, 0x4

    .line 1005
    invoke-direct {v3, v7, v4, v5}, Lcom/vungle/ads/internal/util/d;-><init>(ILjava/lang/Object;Ljava/lang/Object;)V

    .line 1006
    .line 1007
    .line 1008
    const/high16 v5, 0x3f800000    # 1.0f

    .line 1009
    .line 1010
    invoke-virtual {v6, v5}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    .line 1011
    .line 1012
    .line 1013
    iput-object v3, v6, Landroidx/constraintlayout/motion/widget/MotionLayout;->x0:Lcom/vungle/ads/internal/util/d;

    .line 1014
    .line 1015
    goto :goto_14

    .line 1016
    :cond_29
    :goto_13
    move-object/from16 v21, v4

    .line 1017
    .line 1018
    move-object/from16 v18, v6

    .line 1019
    .line 1020
    move-object v4, v9

    .line 1021
    move/from16 v17, v10

    .line 1022
    .line 1023
    move-object/from16 v19, v11

    .line 1024
    .line 1025
    move/from16 v20, v12

    .line 1026
    .line 1027
    move v2, v13

    .line 1028
    move v8, v14

    .line 1029
    move-object v6, v15

    .line 1030
    const/4 v7, 0x4

    .line 1031
    move v11, v3

    .line 1032
    :goto_14
    move v13, v2

    .line 1033
    move-object v9, v4

    .line 1034
    move-object v15, v6

    .line 1035
    move v14, v8

    .line 1036
    move v3, v11

    .line 1037
    move/from16 v10, v17

    .line 1038
    .line 1039
    move-object/from16 v6, v18

    .line 1040
    .line 1041
    move-object/from16 v11, v19

    .line 1042
    .line 1043
    move/from16 v12, v20

    .line 1044
    .line 1045
    move-object/from16 v4, v21

    .line 1046
    .line 1047
    const/4 v2, 0x2

    .line 1048
    goto/16 :goto_6

    .line 1049
    .line 1050
    :cond_2a
    move-object/from16 v21, v4

    .line 1051
    .line 1052
    move-object/from16 v18, v6

    .line 1053
    .line 1054
    move/from16 v17, v10

    .line 1055
    .line 1056
    move-object/from16 v19, v11

    .line 1057
    .line 1058
    move/from16 v20, v12

    .line 1059
    .line 1060
    move v2, v13

    .line 1061
    move v8, v14

    .line 1062
    move-object v6, v15

    .line 1063
    const/4 v7, 0x4

    .line 1064
    move v11, v3

    .line 1065
    move v13, v2

    .line 1066
    move-object v15, v6

    .line 1067
    move v14, v8

    .line 1068
    move v3, v11

    .line 1069
    move/from16 v10, v17

    .line 1070
    .line 1071
    move-object/from16 v6, v18

    .line 1072
    .line 1073
    move-object/from16 v11, v19

    .line 1074
    .line 1075
    move/from16 v12, v20

    .line 1076
    .line 1077
    move-object/from16 v4, v21

    .line 1078
    .line 1079
    const/4 v2, 0x2

    .line 1080
    goto/16 :goto_4

    .line 1081
    .line 1082
    :cond_2b
    :goto_15
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 1083
    .line 1084
    iget-object v1, v1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 1085
    .line 1086
    if-eqz v1, :cond_2f

    .line 1087
    .line 1088
    iget-boolean v2, v1, Lh1/x;->o:Z

    .line 1089
    .line 1090
    if-nez v2, :cond_2f

    .line 1091
    .line 1092
    iget-object v1, v1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 1093
    .line 1094
    if-eqz v1, :cond_2f

    .line 1095
    .line 1096
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    .line 1097
    .line 1098
    .line 1099
    move-result v2

    .line 1100
    if-nez v2, :cond_2c

    .line 1101
    .line 1102
    new-instance v2, Landroid/graphics/RectF;

    .line 1103
    .line 1104
    invoke-direct {v2}, Landroid/graphics/RectF;-><init>()V

    .line 1105
    .line 1106
    .line 1107
    invoke-virtual {v1, v0, v2}, Landroidx/constraintlayout/motion/widget/d;->b(Landroid/view/ViewGroup;Landroid/graphics/RectF;)Landroid/graphics/RectF;

    .line 1108
    .line 1109
    .line 1110
    move-result-object v2

    .line 1111
    if-eqz v2, :cond_2c

    .line 1112
    .line 1113
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getX()F

    .line 1114
    .line 1115
    .line 1116
    move-result v3

    .line 1117
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getY()F

    .line 1118
    .line 1119
    .line 1120
    move-result v4

    .line 1121
    invoke-virtual {v2, v3, v4}, Landroid/graphics/RectF;->contains(FF)Z

    .line 1122
    .line 1123
    .line 1124
    move-result v2

    .line 1125
    if-nez v2, :cond_2c

    .line 1126
    .line 1127
    const/4 v2, 0x0

    .line 1128
    return v2

    .line 1129
    :cond_2c
    iget v1, v1, Landroidx/constraintlayout/motion/widget/d;->e:I

    .line 1130
    .line 1131
    const/4 v2, -0x1

    .line 1132
    if-eq v1, v2, :cond_2f

    .line 1133
    .line 1134
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 1135
    .line 1136
    if-eqz v2, :cond_2d

    .line 1137
    .line 1138
    invoke-virtual {v2}, Landroid/view/View;->getId()I

    .line 1139
    .line 1140
    .line 1141
    move-result v2

    .line 1142
    if-eq v2, v1, :cond_2e

    .line 1143
    .line 1144
    :cond_2d
    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 1145
    .line 1146
    .line 1147
    move-result-object v1

    .line 1148
    iput-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 1149
    .line 1150
    :cond_2e
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 1151
    .line 1152
    if-eqz v1, :cond_2f

    .line 1153
    .line 1154
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D0:Landroid/graphics/RectF;

    .line 1155
    .line 1156
    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    .line 1157
    .line 1158
    .line 1159
    move-result v1

    .line 1160
    int-to-float v1, v1

    .line 1161
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 1162
    .line 1163
    invoke-virtual {v3}, Landroid/view/View;->getTop()I

    .line 1164
    .line 1165
    .line 1166
    move-result v3

    .line 1167
    int-to-float v3, v3

    .line 1168
    iget-object v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 1169
    .line 1170
    invoke-virtual {v4}, Landroid/view/View;->getRight()I

    .line 1171
    .line 1172
    .line 1173
    move-result v4

    .line 1174
    int-to-float v4, v4

    .line 1175
    iget-object v5, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 1176
    .line 1177
    invoke-virtual {v5}, Landroid/view/View;->getBottom()I

    .line 1178
    .line 1179
    .line 1180
    move-result v5

    .line 1181
    int-to-float v5, v5

    .line 1182
    invoke-virtual {v2, v1, v3, v4, v5}, Landroid/graphics/RectF;->set(FFFF)V

    .line 1183
    .line 1184
    .line 1185
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getX()F

    .line 1186
    .line 1187
    .line 1188
    move-result v1

    .line 1189
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getY()F

    .line 1190
    .line 1191
    .line 1192
    move-result v3

    .line 1193
    invoke-virtual {v2, v1, v3}, Landroid/graphics/RectF;->contains(FF)Z

    .line 1194
    .line 1195
    .line 1196
    move-result v1

    .line 1197
    if-eqz v1, :cond_2f

    .line 1198
    .line 1199
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 1200
    .line 1201
    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    .line 1202
    .line 1203
    .line 1204
    move-result v1

    .line 1205
    int-to-float v1, v1

    .line 1206
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 1207
    .line 1208
    invoke-virtual {v2}, Landroid/view/View;->getTop()I

    .line 1209
    .line 1210
    .line 1211
    move-result v2

    .line 1212
    int-to-float v2, v2

    .line 1213
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E0:Landroid/view/View;

    .line 1214
    .line 1215
    move-object/from16 v4, p1

    .line 1216
    .line 1217
    invoke-virtual {v0, v1, v2, v3, v4}, Landroidx/constraintlayout/motion/widget/MotionLayout;->y(FFLandroid/view/View;Landroid/view/MotionEvent;)Z

    .line 1218
    .line 1219
    .line 1220
    move-result v1

    .line 1221
    if-nez v1, :cond_2f

    .line 1222
    .line 1223
    invoke-virtual/range {p0 .. p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->onTouchEvent(Landroid/view/MotionEvent;)Z

    .line 1224
    .line 1225
    .line 1226
    move-result v1

    .line 1227
    return v1

    .line 1228
    :cond_2f
    const/4 v1, 0x0

    .line 1229
    :goto_16
    return v1
.end method

.method public final onLayout(ZIIII)V
    .locals 3

    .line 1
    const/4 v0, 0x1

    .line 2
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v0:Z

    .line 3
    .line 4
    const/4 v1, 0x0

    .line 5
    :try_start_0
    iget-object v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 6
    .line 7
    if-nez v2, :cond_0

    .line 8
    .line 9
    invoke-super/range {p0 .. p5}, Landroidx/constraintlayout/widget/ConstraintLayout;->onLayout(ZIIII)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 10
    .line 11
    .line 12
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v0:Z

    .line 13
    .line 14
    return-void

    .line 15
    :catchall_0
    move-exception p1

    .line 16
    goto :goto_0

    .line 17
    :cond_0
    sub-int/2addr p4, p2

    .line 18
    sub-int/2addr p5, p3

    .line 19
    :try_start_1
    iget p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->S:I

    .line 20
    .line 21
    if-ne p1, p4, :cond_1

    .line 22
    .line 23
    iget p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->T:I

    .line 24
    .line 25
    if-eq p1, p5, :cond_2

    .line 26
    .line 27
    :cond_1
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->C()V

    .line 28
    .line 29
    .line 30
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->t(Z)V

    .line 31
    .line 32
    .line 33
    :cond_2
    iput p4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->S:I

    .line 34
    .line 35
    iput p5, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->T:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 36
    .line 37
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v0:Z

    .line 38
    .line 39
    return-void

    .line 40
    :goto_0
    iput-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v0:Z

    .line 41
    .line 42
    throw p1
.end method

.method public final onMeasure(II)V
    .locals 17

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move/from16 v1, p1

    .line 4
    .line 5
    move/from16 v2, p2

    .line 6
    .line 7
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 8
    .line 9
    if-nez v3, :cond_0

    .line 10
    .line 11
    invoke-super/range {p0 .. p2}, Landroidx/constraintlayout/widget/ConstraintLayout;->onMeasure(II)V

    .line 12
    .line 13
    .line 14
    return-void

    .line 15
    :cond_0
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->z:I

    .line 16
    .line 17
    const/4 v4, 0x1

    .line 18
    const/4 v5, 0x0

    .line 19
    if-ne v3, v1, :cond_2

    .line 20
    .line 21
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->A:I

    .line 22
    .line 23
    if-eq v3, v2, :cond_1

    .line 24
    .line 25
    goto :goto_0

    .line 26
    :cond_1
    move v3, v5

    .line 27
    goto :goto_1

    .line 28
    :cond_2
    :goto_0
    move v3, v4

    .line 29
    :goto_1
    iget-boolean v6, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C0:Z

    .line 30
    .line 31
    if-eqz v6, :cond_3

    .line 32
    .line 33
    iput-boolean v5, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C0:Z

    .line 34
    .line 35
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->A()V

    .line 36
    .line 37
    .line 38
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->B()V

    .line 39
    .line 40
    .line 41
    move v3, v4

    .line 42
    :cond_3
    iget-boolean v6, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    .line 43
    .line 44
    if-eqz v6, :cond_4

    .line 45
    .line 46
    move v3, v4

    .line 47
    :cond_4
    iput v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->z:I

    .line 48
    .line 49
    iput v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->A:I

    .line 50
    .line 51
    iget-object v6, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 52
    .line 53
    invoke-virtual {v6}, Landroidx/constraintlayout/motion/widget/c;->h()I

    .line 54
    .line 55
    .line 56
    move-result v6

    .line 57
    iget-object v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 58
    .line 59
    iget-object v7, v7, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 60
    .line 61
    const/4 v8, -0x1

    .line 62
    if-nez v7, :cond_5

    .line 63
    .line 64
    move v7, v8

    .line 65
    goto :goto_2

    .line 66
    :cond_5
    iget v7, v7, Lh1/x;->c:I

    .line 67
    .line 68
    :goto_2
    iget-object v9, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    .line 69
    .line 70
    iget-object v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B0:Lh1/s;

    .line 71
    .line 72
    if-nez v3, :cond_6

    .line 73
    .line 74
    iget v11, v10, Lh1/s;->e:I

    .line 75
    .line 76
    if-ne v6, v11, :cond_6

    .line 77
    .line 78
    iget v11, v10, Lh1/s;->f:I

    .line 79
    .line 80
    if-eq v7, v11, :cond_7

    .line 81
    .line 82
    :cond_6
    iget v11, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 83
    .line 84
    if-eq v11, v8, :cond_7

    .line 85
    .line 86
    invoke-super/range {p0 .. p2}, Landroidx/constraintlayout/widget/ConstraintLayout;->onMeasure(II)V

    .line 87
    .line 88
    .line 89
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 90
    .line 91
    invoke-virtual {v1, v6}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 92
    .line 93
    .line 94
    move-result-object v1

    .line 95
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 96
    .line 97
    invoke-virtual {v2, v7}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 98
    .line 99
    .line 100
    move-result-object v2

    .line 101
    invoke-virtual {v10, v1, v2}, Lh1/s;->e(Landroidx/constraintlayout/widget/d;Landroidx/constraintlayout/widget/d;)V

    .line 102
    .line 103
    .line 104
    invoke-virtual {v10}, Lh1/s;->f()V

    .line 105
    .line 106
    .line 107
    iput v6, v10, Lh1/s;->e:I

    .line 108
    .line 109
    iput v7, v10, Lh1/s;->f:I

    .line 110
    .line 111
    move v1, v5

    .line 112
    goto :goto_3

    .line 113
    :cond_7
    if-eqz v3, :cond_8

    .line 114
    .line 115
    invoke-super/range {p0 .. p2}, Landroidx/constraintlayout/widget/ConstraintLayout;->onMeasure(II)V

    .line 116
    .line 117
    .line 118
    :cond_8
    move v1, v4

    .line 119
    :goto_3
    iget-boolean v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->m0:Z

    .line 120
    .line 121
    if-nez v2, :cond_9

    .line 122
    .line 123
    if-eqz v1, :cond_e

    .line 124
    .line 125
    :cond_9
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getPaddingTop()I

    .line 126
    .line 127
    .line 128
    move-result v1

    .line 129
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getPaddingBottom()I

    .line 130
    .line 131
    .line 132
    move-result v2

    .line 133
    add-int/2addr v2, v1

    .line 134
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getPaddingLeft()I

    .line 135
    .line 136
    .line 137
    move-result v1

    .line 138
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getPaddingRight()I

    .line 139
    .line 140
    .line 141
    move-result v3

    .line 142
    add-int/2addr v3, v1

    .line 143
    invoke-virtual {v9}, Ld1/f;->r()I

    .line 144
    .line 145
    .line 146
    move-result v1

    .line 147
    add-int/2addr v1, v3

    .line 148
    invoke-virtual {v9}, Ld1/f;->l()I

    .line 149
    .line 150
    .line 151
    move-result v3

    .line 152
    add-int/2addr v3, v2

    .line 153
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->r0:I

    .line 154
    .line 155
    const/high16 v6, -0x80000000

    .line 156
    .line 157
    if-eq v2, v6, :cond_a

    .line 158
    .line 159
    if-nez v2, :cond_b

    .line 160
    .line 161
    :cond_a
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->n0:I

    .line 162
    .line 163
    int-to-float v2, v1

    .line 164
    iget v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t0:F

    .line 165
    .line 166
    iget v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->p0:I

    .line 167
    .line 168
    sub-int/2addr v8, v1

    .line 169
    int-to-float v1, v8

    .line 170
    mul-float/2addr v7, v1

    .line 171
    add-float/2addr v7, v2

    .line 172
    float-to-int v1, v7

    .line 173
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->requestLayout()V

    .line 174
    .line 175
    .line 176
    :cond_b
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s0:I

    .line 177
    .line 178
    if-eq v2, v6, :cond_c

    .line 179
    .line 180
    if-nez v2, :cond_d

    .line 181
    .line 182
    :cond_c
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->o0:I

    .line 183
    .line 184
    int-to-float v3, v2

    .line 185
    iget v6, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t0:F

    .line 186
    .line 187
    iget v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->q0:I

    .line 188
    .line 189
    sub-int/2addr v7, v2

    .line 190
    int-to-float v2, v7

    .line 191
    mul-float/2addr v6, v2

    .line 192
    add-float/2addr v6, v3

    .line 193
    float-to-int v3, v6

    .line 194
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->requestLayout()V

    .line 195
    .line 196
    .line 197
    :cond_d
    invoke-virtual {v0, v1, v3}, Landroid/view/View;->setMeasuredDimension(II)V

    .line 198
    .line 199
    .line 200
    :cond_e
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 201
    .line 202
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 203
    .line 204
    sub-float/2addr v1, v2

    .line 205
    invoke-static {v1}, Ljava/lang/Math;->signum(F)F

    .line 206
    .line 207
    .line 208
    move-result v1

    .line 209
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 210
    .line 211
    .line 212
    move-result-wide v2

    .line 213
    iget-object v6, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 214
    .line 215
    instance-of v7, v6, Lg1/b;

    .line 216
    .line 217
    const v8, 0x3089705f    # 1.0E-9f

    .line 218
    .line 219
    .line 220
    const/4 v9, 0x0

    .line 221
    if-nez v7, :cond_f

    .line 222
    .line 223
    iget-wide v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H:J

    .line 224
    .line 225
    sub-long v10, v2, v10

    .line 226
    .line 227
    long-to-float v7, v10

    .line 228
    mul-float/2addr v7, v1

    .line 229
    mul-float/2addr v7, v8

    .line 230
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 231
    .line 232
    div-float/2addr v7, v10

    .line 233
    goto :goto_4

    .line 234
    :cond_f
    move v7, v9

    .line 235
    :goto_4
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 236
    .line 237
    add-float/2addr v10, v7

    .line 238
    iget-boolean v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->J:Z

    .line 239
    .line 240
    if-eqz v7, :cond_10

    .line 241
    .line 242
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 243
    .line 244
    :cond_10
    cmpl-float v7, v1, v9

    .line 245
    .line 246
    if-lez v7, :cond_11

    .line 247
    .line 248
    iget v11, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 249
    .line 250
    cmpl-float v11, v10, v11

    .line 251
    .line 252
    if-gez v11, :cond_12

    .line 253
    .line 254
    :cond_11
    cmpg-float v11, v1, v9

    .line 255
    .line 256
    if-gtz v11, :cond_13

    .line 257
    .line 258
    iget v11, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 259
    .line 260
    cmpg-float v11, v10, v11

    .line 261
    .line 262
    if-gtz v11, :cond_13

    .line 263
    .line 264
    :cond_12
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 265
    .line 266
    goto :goto_5

    .line 267
    :cond_13
    move v4, v5

    .line 268
    :goto_5
    if-eqz v6, :cond_15

    .line 269
    .line 270
    if-nez v4, :cond_15

    .line 271
    .line 272
    iget-boolean v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->O:Z

    .line 273
    .line 274
    if-eqz v4, :cond_14

    .line 275
    .line 276
    iget-wide v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D:J

    .line 277
    .line 278
    sub-long/2addr v2, v10

    .line 279
    long-to-float v2, v2

    .line 280
    mul-float/2addr v2, v8

    .line 281
    invoke-interface {v6, v2}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 282
    .line 283
    .line 284
    move-result v10

    .line 285
    goto :goto_6

    .line 286
    :cond_14
    invoke-interface {v6, v10}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 287
    .line 288
    .line 289
    move-result v10

    .line 290
    :cond_15
    :goto_6
    if-lez v7, :cond_16

    .line 291
    .line 292
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 293
    .line 294
    cmpl-float v2, v10, v2

    .line 295
    .line 296
    if-gez v2, :cond_17

    .line 297
    .line 298
    :cond_16
    cmpg-float v1, v1, v9

    .line 299
    .line 300
    if-gtz v1, :cond_18

    .line 301
    .line 302
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 303
    .line 304
    cmpg-float v1, v10, v1

    .line 305
    .line 306
    if-gtz v1, :cond_18

    .line 307
    .line 308
    :cond_17
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 309
    .line 310
    :cond_18
    iput v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t0:F

    .line 311
    .line 312
    invoke-virtual/range {p0 .. p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 313
    .line 314
    .line 315
    move-result v1

    .line 316
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 317
    .line 318
    .line 319
    move-result-wide v2

    .line 320
    iget-object v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u:Landroid/view/animation/Interpolator;

    .line 321
    .line 322
    if-nez v4, :cond_19

    .line 323
    .line 324
    goto :goto_7

    .line 325
    :cond_19
    invoke-interface {v4, v10}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 326
    .line 327
    .line 328
    move-result v10

    .line 329
    :goto_7
    if-ge v5, v1, :cond_1b

    .line 330
    .line 331
    invoke-virtual {v0, v5}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 332
    .line 333
    .line 334
    move-result-object v15

    .line 335
    iget-object v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 336
    .line 337
    invoke-virtual {v4, v15}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 338
    .line 339
    .line 340
    move-result-object v4

    .line 341
    move-object v11, v4

    .line 342
    check-cast v11, Lh1/n;

    .line 343
    .line 344
    if-eqz v11, :cond_1a

    .line 345
    .line 346
    iget-object v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u0:Lb1/e;

    .line 347
    .line 348
    move v12, v10

    .line 349
    move-wide v13, v2

    .line 350
    move-object/from16 v16, v4

    .line 351
    .line 352
    invoke-virtual/range {v11 .. v16}, Lh1/n;->e(FJLandroid/view/View;Lb1/e;)Z

    .line 353
    .line 354
    .line 355
    :cond_1a
    add-int/lit8 v5, v5, 0x1

    .line 356
    .line 357
    goto :goto_7

    .line 358
    :cond_1b
    iget-boolean v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->m0:Z

    .line 359
    .line 360
    if-eqz v1, :cond_1c

    .line 361
    .line 362
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->requestLayout()V

    .line 363
    .line 364
    .line 365
    :cond_1c
    return-void
.end method

.method public final onNestedFling(Landroid/view/View;FFZ)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public final onNestedPreFling(Landroid/view/View;FF)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public final onRtlPropertiesChanged(I)V
    .locals 1

    .line 1
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-eqz p1, :cond_0

    .line 4
    .line 5
    invoke-virtual {p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->l()Z

    .line 6
    .line 7
    .line 8
    move-result v0

    .line 9
    iput-boolean v0, p1, Landroidx/constraintlayout/motion/widget/c;->p:Z

    .line 10
    .line 11
    iget-object p1, p1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 12
    .line 13
    if-eqz p1, :cond_0

    .line 14
    .line 15
    iget-object p1, p1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 16
    .line 17
    if-eqz p1, :cond_0

    .line 18
    .line 19
    invoke-virtual {p1, v0}, Landroidx/constraintlayout/motion/widget/d;->c(Z)V

    .line 20
    .line 21
    .line 22
    :cond_0
    return-void
.end method

.method public final onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 33

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v1, p1

    .line 4
    .line 5
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 6
    .line 7
    if-eqz v2, :cond_63

    .line 8
    .line 9
    iget-boolean v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B:Z

    .line 10
    .line 11
    if-eqz v3, :cond_63

    .line 12
    .line 13
    invoke-virtual {v2}, Landroidx/constraintlayout/motion/widget/c;->o()Z

    .line 14
    .line 15
    .line 16
    move-result v2

    .line 17
    if-eqz v2, :cond_63

    .line 18
    .line 19
    iget-object v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 20
    .line 21
    iget-object v3, v2, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 22
    .line 23
    if-eqz v3, :cond_0

    .line 24
    .line 25
    iget-boolean v3, v3, Lh1/x;->o:Z

    .line 26
    .line 27
    if-eqz v3, :cond_0

    .line 28
    .line 29
    invoke-super/range {p0 .. p1}, Landroid/view/ViewGroup;->onTouchEvent(Landroid/view/MotionEvent;)Z

    .line 30
    .line 31
    .line 32
    move-result v1

    .line 33
    return v1

    .line 34
    :cond_0
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getCurrentState()I

    .line 35
    .line 36
    .line 37
    move-result v3

    .line 38
    new-instance v4, Landroid/graphics/RectF;

    .line 39
    .line 40
    invoke-direct {v4}, Landroid/graphics/RectF;-><init>()V

    .line 41
    .line 42
    .line 43
    iget-object v5, v2, Landroidx/constraintlayout/motion/widget/c;->o:Lh1/t;

    .line 44
    .line 45
    iget-object v6, v2, Landroidx/constraintlayout/motion/widget/c;->a:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 46
    .line 47
    if-nez v5, :cond_1

    .line 48
    .line 49
    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 50
    .line 51
    .line 52
    sget-object v5, Lh1/t;->b:Lh1/t;

    .line 53
    .line 54
    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    .line 55
    .line 56
    .line 57
    move-result-object v7

    .line 58
    iput-object v7, v5, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 59
    .line 60
    iput-object v5, v2, Landroidx/constraintlayout/motion/widget/c;->o:Lh1/t;

    .line 61
    .line 62
    :cond_1
    iget-object v5, v2, Landroidx/constraintlayout/motion/widget/c;->o:Lh1/t;

    .line 63
    .line 64
    iget-object v5, v5, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 65
    .line 66
    if-eqz v5, :cond_2

    .line 67
    .line 68
    invoke-virtual {v5, v1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    .line 69
    .line 70
    .line 71
    :cond_2
    const/4 v8, 0x2

    .line 72
    const/4 v10, -0x1

    .line 73
    if-eq v3, v10, :cond_19

    .line 74
    .line 75
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    .line 76
    .line 77
    .line 78
    move-result v12

    .line 79
    if-eqz v12, :cond_16

    .line 80
    .line 81
    if-eq v12, v8, :cond_3

    .line 82
    .line 83
    goto/16 :goto_b

    .line 84
    .line 85
    :cond_3
    iget-boolean v12, v2, Landroidx/constraintlayout/motion/widget/c;->m:Z

    .line 86
    .line 87
    if-eqz v12, :cond_4

    .line 88
    .line 89
    goto/16 :goto_b

    .line 90
    .line 91
    :cond_4
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 92
    .line 93
    .line 94
    move-result v12

    .line 95
    iget v13, v2, Landroidx/constraintlayout/motion/widget/c;->s:F

    .line 96
    .line 97
    sub-float/2addr v12, v13

    .line 98
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 99
    .line 100
    .line 101
    move-result v13

    .line 102
    iget v14, v2, Landroidx/constraintlayout/motion/widget/c;->r:F

    .line 103
    .line 104
    sub-float/2addr v13, v14

    .line 105
    float-to-double v14, v13

    .line 106
    const-wide/16 v16, 0x0

    .line 107
    .line 108
    cmpl-double v14, v14, v16

    .line 109
    .line 110
    if-nez v14, :cond_5

    .line 111
    .line 112
    float-to-double v14, v12

    .line 113
    cmpl-double v14, v14, v16

    .line 114
    .line 115
    if-eqz v14, :cond_61

    .line 116
    .line 117
    :cond_5
    iget-object v14, v2, Landroidx/constraintlayout/motion/widget/c;->l:Landroid/view/MotionEvent;

    .line 118
    .line 119
    if-nez v14, :cond_6

    .line 120
    .line 121
    goto/16 :goto_2e

    .line 122
    .line 123
    :cond_6
    if-eq v3, v10, :cond_14

    .line 124
    .line 125
    iget-object v15, v2, Landroidx/constraintlayout/motion/widget/c;->b:Landroidx/compose/animation/core/u;

    .line 126
    .line 127
    if-eqz v15, :cond_7

    .line 128
    .line 129
    invoke-virtual {v15, v3}, Landroidx/compose/animation/core/u;->t(I)I

    .line 130
    .line 131
    .line 132
    move-result v15

    .line 133
    if-eq v15, v10, :cond_7

    .line 134
    .line 135
    goto :goto_0

    .line 136
    :cond_7
    move v15, v3

    .line 137
    :goto_0
    new-instance v5, Ljava/util/ArrayList;

    .line 138
    .line 139
    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 140
    .line 141
    .line 142
    iget-object v10, v2, Landroidx/constraintlayout/motion/widget/c;->d:Ljava/util/ArrayList;

    .line 143
    .line 144
    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 145
    .line 146
    .line 147
    move-result-object v10

    .line 148
    :goto_1
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    .line 149
    .line 150
    .line 151
    move-result v18

    .line 152
    if-eqz v18, :cond_a

    .line 153
    .line 154
    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 155
    .line 156
    .line 157
    move-result-object v18

    .line 158
    move-object/from16 v8, v18

    .line 159
    .line 160
    check-cast v8, Lh1/x;

    .line 161
    .line 162
    iget v7, v8, Lh1/x;->d:I

    .line 163
    .line 164
    if-eq v7, v15, :cond_8

    .line 165
    .line 166
    iget v7, v8, Lh1/x;->c:I

    .line 167
    .line 168
    if-ne v7, v15, :cond_9

    .line 169
    .line 170
    :cond_8
    invoke-virtual {v5, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 171
    .line 172
    .line 173
    :cond_9
    const/4 v8, 0x2

    .line 174
    goto :goto_1

    .line 175
    :cond_a
    new-instance v7, Landroid/graphics/RectF;

    .line 176
    .line 177
    invoke-direct {v7}, Landroid/graphics/RectF;-><init>()V

    .line 178
    .line 179
    .line 180
    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 181
    .line 182
    .line 183
    move-result-object v5

    .line 184
    const/4 v8, 0x0

    .line 185
    const/4 v10, 0x0

    .line 186
    :goto_2
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    .line 187
    .line 188
    .line 189
    move-result v15

    .line 190
    if-eqz v15, :cond_13

    .line 191
    .line 192
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 193
    .line 194
    .line 195
    move-result-object v15

    .line 196
    check-cast v15, Lh1/x;

    .line 197
    .line 198
    iget-boolean v9, v15, Lh1/x;->o:Z

    .line 199
    .line 200
    if-eqz v9, :cond_b

    .line 201
    .line 202
    move-object/from16 v20, v5

    .line 203
    .line 204
    goto :goto_3

    .line 205
    :cond_b
    iget-object v9, v15, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 206
    .line 207
    if-eqz v9, :cond_11

    .line 208
    .line 209
    iget-boolean v11, v2, Landroidx/constraintlayout/motion/widget/c;->p:Z

    .line 210
    .line 211
    invoke-virtual {v9, v11}, Landroidx/constraintlayout/motion/widget/d;->c(Z)V

    .line 212
    .line 213
    .line 214
    iget-object v9, v15, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 215
    .line 216
    invoke-virtual {v9, v6, v7}, Landroidx/constraintlayout/motion/widget/d;->b(Landroid/view/ViewGroup;Landroid/graphics/RectF;)Landroid/graphics/RectF;

    .line 217
    .line 218
    .line 219
    move-result-object v9

    .line 220
    if-eqz v9, :cond_c

    .line 221
    .line 222
    invoke-virtual {v14}, Landroid/view/MotionEvent;->getX()F

    .line 223
    .line 224
    .line 225
    move-result v11

    .line 226
    move-object/from16 v20, v5

    .line 227
    .line 228
    invoke-virtual {v14}, Landroid/view/MotionEvent;->getY()F

    .line 229
    .line 230
    .line 231
    move-result v5

    .line 232
    invoke-virtual {v9, v11, v5}, Landroid/graphics/RectF;->contains(FF)Z

    .line 233
    .line 234
    .line 235
    move-result v5

    .line 236
    if-nez v5, :cond_d

    .line 237
    .line 238
    goto :goto_3

    .line 239
    :cond_c
    move-object/from16 v20, v5

    .line 240
    .line 241
    :cond_d
    iget-object v5, v15, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 242
    .line 243
    invoke-virtual {v5, v6, v7}, Landroidx/constraintlayout/motion/widget/d;->a(Landroid/view/ViewGroup;Landroid/graphics/RectF;)Landroid/graphics/RectF;

    .line 244
    .line 245
    .line 246
    move-result-object v5

    .line 247
    if-eqz v5, :cond_e

    .line 248
    .line 249
    invoke-virtual {v14}, Landroid/view/MotionEvent;->getX()F

    .line 250
    .line 251
    .line 252
    move-result v9

    .line 253
    invoke-virtual {v14}, Landroid/view/MotionEvent;->getY()F

    .line 254
    .line 255
    .line 256
    move-result v11

    .line 257
    invoke-virtual {v5, v9, v11}, Landroid/graphics/RectF;->contains(FF)Z

    .line 258
    .line 259
    .line 260
    move-result v5

    .line 261
    if-nez v5, :cond_e

    .line 262
    .line 263
    :goto_3
    move-object/from16 v5, v20

    .line 264
    .line 265
    goto :goto_2

    .line 266
    :cond_e
    iget-object v5, v15, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 267
    .line 268
    iget v9, v5, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 269
    .line 270
    mul-float/2addr v9, v13

    .line 271
    iget v11, v5, Landroidx/constraintlayout/motion/widget/d;->l:F

    .line 272
    .line 273
    mul-float/2addr v11, v12

    .line 274
    add-float/2addr v11, v9

    .line 275
    iget-boolean v5, v5, Landroidx/constraintlayout/motion/widget/d;->j:Z

    .line 276
    .line 277
    if-eqz v5, :cond_f

    .line 278
    .line 279
    invoke-virtual {v14}, Landroid/view/MotionEvent;->getX()F

    .line 280
    .line 281
    .line 282
    move-result v5

    .line 283
    iget-object v9, v15, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 284
    .line 285
    invoke-virtual {v9}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 286
    .line 287
    .line 288
    const/high16 v9, 0x3f000000    # 0.5f

    .line 289
    .line 290
    sub-float/2addr v5, v9

    .line 291
    invoke-virtual {v14}, Landroid/view/MotionEvent;->getY()F

    .line 292
    .line 293
    .line 294
    move-result v11

    .line 295
    iget-object v9, v15, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 296
    .line 297
    invoke-virtual {v9}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 298
    .line 299
    .line 300
    const/high16 v9, 0x3f000000    # 0.5f

    .line 301
    .line 302
    sub-float/2addr v11, v9

    .line 303
    add-float v9, v13, v5

    .line 304
    .line 305
    move-object/from16 v21, v7

    .line 306
    .line 307
    add-float v7, v12, v11

    .line 308
    .line 309
    move/from16 v22, v12

    .line 310
    .line 311
    move/from16 v23, v13

    .line 312
    .line 313
    float-to-double v12, v7

    .line 314
    move-object v7, v10

    .line 315
    float-to-double v9, v9

    .line 316
    invoke-static {v12, v13, v9, v10}, Ljava/lang/Math;->atan2(DD)D

    .line 317
    .line 318
    .line 319
    move-result-wide v9

    .line 320
    float-to-double v12, v5

    .line 321
    move-object/from16 v24, v4

    .line 322
    .line 323
    float-to-double v4, v11

    .line 324
    invoke-static {v12, v13, v4, v5}, Ljava/lang/Math;->atan2(DD)D

    .line 325
    .line 326
    .line 327
    move-result-wide v4

    .line 328
    sub-double/2addr v9, v4

    .line 329
    double-to-float v4, v9

    .line 330
    const/high16 v5, 0x41200000    # 10.0f

    .line 331
    .line 332
    mul-float v11, v4, v5

    .line 333
    .line 334
    goto :goto_4

    .line 335
    :cond_f
    move-object/from16 v24, v4

    .line 336
    .line 337
    move-object/from16 v21, v7

    .line 338
    .line 339
    move-object v7, v10

    .line 340
    move/from16 v22, v12

    .line 341
    .line 342
    move/from16 v23, v13

    .line 343
    .line 344
    :goto_4
    iget v4, v15, Lh1/x;->c:I

    .line 345
    .line 346
    if-ne v4, v3, :cond_10

    .line 347
    .line 348
    const/high16 v4, -0x40800000    # -1.0f

    .line 349
    .line 350
    :goto_5
    mul-float/2addr v11, v4

    .line 351
    goto :goto_6

    .line 352
    :cond_10
    const v4, 0x3f8ccccd    # 1.1f

    .line 353
    .line 354
    .line 355
    goto :goto_5

    .line 356
    :goto_6
    cmpl-float v4, v11, v8

    .line 357
    .line 358
    if-lez v4, :cond_12

    .line 359
    .line 360
    move v8, v11

    .line 361
    move-object v10, v15

    .line 362
    goto :goto_7

    .line 363
    :cond_11
    move-object/from16 v24, v4

    .line 364
    .line 365
    move-object/from16 v20, v5

    .line 366
    .line 367
    move-object/from16 v21, v7

    .line 368
    .line 369
    move-object v7, v10

    .line 370
    move/from16 v22, v12

    .line 371
    .line 372
    move/from16 v23, v13

    .line 373
    .line 374
    :cond_12
    move-object v10, v7

    .line 375
    :goto_7
    move-object/from16 v5, v20

    .line 376
    .line 377
    move-object/from16 v7, v21

    .line 378
    .line 379
    move/from16 v12, v22

    .line 380
    .line 381
    move/from16 v13, v23

    .line 382
    .line 383
    move-object/from16 v4, v24

    .line 384
    .line 385
    goto/16 :goto_2

    .line 386
    .line 387
    :cond_13
    move-object/from16 v24, v4

    .line 388
    .line 389
    move-object v7, v10

    .line 390
    goto :goto_8

    .line 391
    :cond_14
    move-object/from16 v24, v4

    .line 392
    .line 393
    iget-object v10, v2, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 394
    .line 395
    :goto_8
    if-eqz v10, :cond_19

    .line 396
    .line 397
    invoke-virtual {v0, v10}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setTransition(Lh1/x;)V

    .line 398
    .line 399
    .line 400
    iget-object v3, v2, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 401
    .line 402
    iget-object v3, v3, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 403
    .line 404
    move-object/from16 v4, v24

    .line 405
    .line 406
    invoke-virtual {v3, v6, v4}, Landroidx/constraintlayout/motion/widget/d;->b(Landroid/view/ViewGroup;Landroid/graphics/RectF;)Landroid/graphics/RectF;

    .line 407
    .line 408
    .line 409
    move-result-object v3

    .line 410
    if-eqz v3, :cond_15

    .line 411
    .line 412
    iget-object v4, v2, Landroidx/constraintlayout/motion/widget/c;->l:Landroid/view/MotionEvent;

    .line 413
    .line 414
    invoke-virtual {v4}, Landroid/view/MotionEvent;->getX()F

    .line 415
    .line 416
    .line 417
    move-result v4

    .line 418
    iget-object v5, v2, Landroidx/constraintlayout/motion/widget/c;->l:Landroid/view/MotionEvent;

    .line 419
    .line 420
    invoke-virtual {v5}, Landroid/view/MotionEvent;->getY()F

    .line 421
    .line 422
    .line 423
    move-result v5

    .line 424
    invoke-virtual {v3, v4, v5}, Landroid/graphics/RectF;->contains(FF)Z

    .line 425
    .line 426
    .line 427
    move-result v3

    .line 428
    if-nez v3, :cond_15

    .line 429
    .line 430
    const/4 v3, 0x1

    .line 431
    goto :goto_9

    .line 432
    :cond_15
    const/4 v3, 0x0

    .line 433
    :goto_9
    iput-boolean v3, v2, Landroidx/constraintlayout/motion/widget/c;->n:Z

    .line 434
    .line 435
    iget-object v3, v2, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 436
    .line 437
    iget-object v3, v3, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 438
    .line 439
    iget v4, v2, Landroidx/constraintlayout/motion/widget/c;->r:F

    .line 440
    .line 441
    iget v5, v2, Landroidx/constraintlayout/motion/widget/c;->s:F

    .line 442
    .line 443
    iput v4, v3, Landroidx/constraintlayout/motion/widget/d;->p:F

    .line 444
    .line 445
    iput v5, v3, Landroidx/constraintlayout/motion/widget/d;->q:F

    .line 446
    .line 447
    const/4 v5, 0x0

    .line 448
    iput-boolean v5, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 449
    .line 450
    goto :goto_b

    .line 451
    :cond_16
    const/4 v5, 0x0

    .line 452
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 453
    .line 454
    .line 455
    move-result v3

    .line 456
    iput v3, v2, Landroidx/constraintlayout/motion/widget/c;->r:F

    .line 457
    .line 458
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 459
    .line 460
    .line 461
    move-result v3

    .line 462
    iput v3, v2, Landroidx/constraintlayout/motion/widget/c;->s:F

    .line 463
    .line 464
    iput-object v1, v2, Landroidx/constraintlayout/motion/widget/c;->l:Landroid/view/MotionEvent;

    .line 465
    .line 466
    iput-boolean v5, v2, Landroidx/constraintlayout/motion/widget/c;->m:Z

    .line 467
    .line 468
    iget-object v1, v2, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 469
    .line 470
    iget-object v1, v1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 471
    .line 472
    if-eqz v1, :cond_61

    .line 473
    .line 474
    invoke-virtual {v1, v6, v4}, Landroidx/constraintlayout/motion/widget/d;->a(Landroid/view/ViewGroup;Landroid/graphics/RectF;)Landroid/graphics/RectF;

    .line 475
    .line 476
    .line 477
    move-result-object v1

    .line 478
    if-eqz v1, :cond_17

    .line 479
    .line 480
    iget-object v3, v2, Landroidx/constraintlayout/motion/widget/c;->l:Landroid/view/MotionEvent;

    .line 481
    .line 482
    invoke-virtual {v3}, Landroid/view/MotionEvent;->getX()F

    .line 483
    .line 484
    .line 485
    move-result v3

    .line 486
    iget-object v5, v2, Landroidx/constraintlayout/motion/widget/c;->l:Landroid/view/MotionEvent;

    .line 487
    .line 488
    invoke-virtual {v5}, Landroid/view/MotionEvent;->getY()F

    .line 489
    .line 490
    .line 491
    move-result v5

    .line 492
    invoke-virtual {v1, v3, v5}, Landroid/graphics/RectF;->contains(FF)Z

    .line 493
    .line 494
    .line 495
    move-result v1

    .line 496
    if-nez v1, :cond_17

    .line 497
    .line 498
    const/4 v1, 0x0

    .line 499
    iput-object v1, v2, Landroidx/constraintlayout/motion/widget/c;->l:Landroid/view/MotionEvent;

    .line 500
    .line 501
    const/4 v1, 0x1

    .line 502
    iput-boolean v1, v2, Landroidx/constraintlayout/motion/widget/c;->m:Z

    .line 503
    .line 504
    goto/16 :goto_2e

    .line 505
    .line 506
    :cond_17
    iget-object v1, v2, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 507
    .line 508
    iget-object v1, v1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 509
    .line 510
    invoke-virtual {v1, v6, v4}, Landroidx/constraintlayout/motion/widget/d;->b(Landroid/view/ViewGroup;Landroid/graphics/RectF;)Landroid/graphics/RectF;

    .line 511
    .line 512
    .line 513
    move-result-object v1

    .line 514
    if-eqz v1, :cond_18

    .line 515
    .line 516
    iget-object v3, v2, Landroidx/constraintlayout/motion/widget/c;->l:Landroid/view/MotionEvent;

    .line 517
    .line 518
    invoke-virtual {v3}, Landroid/view/MotionEvent;->getX()F

    .line 519
    .line 520
    .line 521
    move-result v3

    .line 522
    iget-object v4, v2, Landroidx/constraintlayout/motion/widget/c;->l:Landroid/view/MotionEvent;

    .line 523
    .line 524
    invoke-virtual {v4}, Landroid/view/MotionEvent;->getY()F

    .line 525
    .line 526
    .line 527
    move-result v4

    .line 528
    invoke-virtual {v1, v3, v4}, Landroid/graphics/RectF;->contains(FF)Z

    .line 529
    .line 530
    .line 531
    move-result v1

    .line 532
    if-nez v1, :cond_18

    .line 533
    .line 534
    const/4 v1, 0x1

    .line 535
    iput-boolean v1, v2, Landroidx/constraintlayout/motion/widget/c;->n:Z

    .line 536
    .line 537
    goto :goto_a

    .line 538
    :cond_18
    const/4 v1, 0x0

    .line 539
    iput-boolean v1, v2, Landroidx/constraintlayout/motion/widget/c;->n:Z

    .line 540
    .line 541
    :goto_a
    iget-object v1, v2, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 542
    .line 543
    iget-object v1, v1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 544
    .line 545
    iget v3, v2, Landroidx/constraintlayout/motion/widget/c;->r:F

    .line 546
    .line 547
    iget v2, v2, Landroidx/constraintlayout/motion/widget/c;->s:F

    .line 548
    .line 549
    iput v3, v1, Landroidx/constraintlayout/motion/widget/d;->p:F

    .line 550
    .line 551
    iput v2, v1, Landroidx/constraintlayout/motion/widget/d;->q:F

    .line 552
    .line 553
    goto/16 :goto_2e

    .line 554
    .line 555
    :cond_19
    :goto_b
    iget-boolean v3, v2, Landroidx/constraintlayout/motion/widget/c;->m:Z

    .line 556
    .line 557
    if-eqz v3, :cond_1a

    .line 558
    .line 559
    goto/16 :goto_2e

    .line 560
    .line 561
    :cond_1a
    iget-object v3, v2, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 562
    .line 563
    if-eqz v3, :cond_5d

    .line 564
    .line 565
    iget-object v3, v3, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 566
    .line 567
    if-eqz v3, :cond_5d

    .line 568
    .line 569
    iget-boolean v4, v2, Landroidx/constraintlayout/motion/widget/c;->n:Z

    .line 570
    .line 571
    if-nez v4, :cond_5d

    .line 572
    .line 573
    iget-object v4, v2, Landroidx/constraintlayout/motion/widget/c;->o:Lh1/t;

    .line 574
    .line 575
    iget-boolean v5, v3, Landroidx/constraintlayout/motion/widget/d;->j:Z

    .line 576
    .line 577
    iget-object v6, v3, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 578
    .line 579
    iget-object v14, v3, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 580
    .line 581
    if-eqz v5, :cond_3c

    .line 582
    .line 583
    iget-object v5, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 584
    .line 585
    if-eqz v5, :cond_1b

    .line 586
    .line 587
    invoke-virtual {v5, v1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    .line 588
    .line 589
    .line 590
    :cond_1b
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    .line 591
    .line 592
    .line 593
    move-result v5

    .line 594
    if-eqz v5, :cond_3b

    .line 595
    .line 596
    iget-object v7, v3, Landroidx/constraintlayout/motion/widget/d;->o:[I

    .line 597
    .line 598
    const/high16 v24, 0x40000000    # 2.0f

    .line 599
    .line 600
    const/4 v9, 0x1

    .line 601
    if-eq v5, v9, :cond_2b

    .line 602
    .line 603
    const/4 v9, 0x2

    .line 604
    if-eq v5, v9, :cond_1c

    .line 605
    .line 606
    goto/16 :goto_2b

    .line 607
    .line 608
    :cond_1c
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 609
    .line 610
    .line 611
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 612
    .line 613
    .line 614
    invoke-virtual {v14}, Landroid/view/View;->getWidth()I

    .line 615
    .line 616
    .line 617
    move-result v5

    .line 618
    int-to-float v5, v5

    .line 619
    div-float v5, v5, v24

    .line 620
    .line 621
    invoke-virtual {v14}, Landroid/view/View;->getHeight()I

    .line 622
    .line 623
    .line 624
    move-result v9

    .line 625
    int-to-float v9, v9

    .line 626
    div-float v9, v9, v24

    .line 627
    .line 628
    iget v10, v3, Landroidx/constraintlayout/motion/widget/d;->i:I

    .line 629
    .line 630
    const/4 v15, -0x1

    .line 631
    if-eq v10, v15, :cond_1d

    .line 632
    .line 633
    invoke-virtual {v14, v10}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 634
    .line 635
    .line 636
    move-result-object v5

    .line 637
    invoke-virtual {v14, v7}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 638
    .line 639
    .line 640
    const/4 v9, 0x0

    .line 641
    aget v9, v7, v9

    .line 642
    .line 643
    int-to-float v9, v9

    .line 644
    invoke-virtual {v5}, Landroid/view/View;->getLeft()I

    .line 645
    .line 646
    .line 647
    move-result v10

    .line 648
    invoke-virtual {v5}, Landroid/view/View;->getRight()I

    .line 649
    .line 650
    .line 651
    move-result v15

    .line 652
    add-int/2addr v15, v10

    .line 653
    int-to-float v10, v15

    .line 654
    div-float v10, v10, v24

    .line 655
    .line 656
    add-float/2addr v9, v10

    .line 657
    const/4 v10, 0x1

    .line 658
    aget v7, v7, v10

    .line 659
    .line 660
    int-to-float v7, v7

    .line 661
    invoke-virtual {v5}, Landroid/view/View;->getTop()I

    .line 662
    .line 663
    .line 664
    move-result v10

    .line 665
    invoke-virtual {v5}, Landroid/view/View;->getBottom()I

    .line 666
    .line 667
    .line 668
    move-result v5

    .line 669
    add-int/2addr v5, v10

    .line 670
    int-to-float v5, v5

    .line 671
    div-float v5, v5, v24

    .line 672
    .line 673
    add-float/2addr v5, v7

    .line 674
    move/from16 v32, v9

    .line 675
    .line 676
    move v9, v5

    .line 677
    move/from16 v5, v32

    .line 678
    .line 679
    goto :goto_c

    .line 680
    :cond_1d
    iget v10, v3, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 681
    .line 682
    const/4 v15, -0x1

    .line 683
    if-eq v10, v15, :cond_1f

    .line 684
    .line 685
    iget-object v15, v14, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 686
    .line 687
    invoke-virtual {v14, v10}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 688
    .line 689
    .line 690
    move-result-object v10

    .line 691
    invoke-virtual {v15, v10}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 692
    .line 693
    .line 694
    move-result-object v10

    .line 695
    check-cast v10, Lh1/n;

    .line 696
    .line 697
    iget-object v10, v10, Lh1/n;->f:Lh1/v;

    .line 698
    .line 699
    iget v10, v10, Lh1/v;->k:I

    .line 700
    .line 701
    invoke-virtual {v14, v10}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 702
    .line 703
    .line 704
    move-result-object v10

    .line 705
    if-nez v10, :cond_1e

    .line 706
    .line 707
    const-string v7, "TouchResponse"

    .line 708
    .line 709
    const-string v10, "could not find view to animate to"

    .line 710
    .line 711
    invoke-static {v7, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 712
    .line 713
    .line 714
    goto :goto_c

    .line 715
    :cond_1e
    invoke-virtual {v14, v7}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 716
    .line 717
    .line 718
    const/4 v5, 0x0

    .line 719
    aget v5, v7, v5

    .line 720
    .line 721
    int-to-float v5, v5

    .line 722
    invoke-virtual {v10}, Landroid/view/View;->getLeft()I

    .line 723
    .line 724
    .line 725
    move-result v9

    .line 726
    invoke-virtual {v10}, Landroid/view/View;->getRight()I

    .line 727
    .line 728
    .line 729
    move-result v15

    .line 730
    add-int/2addr v15, v9

    .line 731
    int-to-float v9, v15

    .line 732
    div-float v9, v9, v24

    .line 733
    .line 734
    add-float/2addr v5, v9

    .line 735
    const/4 v9, 0x1

    .line 736
    aget v7, v7, v9

    .line 737
    .line 738
    int-to-float v7, v7

    .line 739
    invoke-virtual {v10}, Landroid/view/View;->getTop()I

    .line 740
    .line 741
    .line 742
    move-result v9

    .line 743
    invoke-virtual {v10}, Landroid/view/View;->getBottom()I

    .line 744
    .line 745
    .line 746
    move-result v10

    .line 747
    add-int/2addr v10, v9

    .line 748
    int-to-float v9, v10

    .line 749
    div-float v9, v9, v24

    .line 750
    .line 751
    add-float/2addr v9, v7

    .line 752
    :cond_1f
    :goto_c
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 753
    .line 754
    .line 755
    move-result v7

    .line 756
    sub-float/2addr v7, v5

    .line 757
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 758
    .line 759
    .line 760
    move-result v10

    .line 761
    sub-float/2addr v10, v9

    .line 762
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 763
    .line 764
    .line 765
    move-result v15

    .line 766
    sub-float/2addr v15, v9

    .line 767
    move-object/from16 v25, v14

    .line 768
    .line 769
    float-to-double v13, v15

    .line 770
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 771
    .line 772
    .line 773
    move-result v15

    .line 774
    sub-float/2addr v15, v5

    .line 775
    float-to-double v11, v15

    .line 776
    invoke-static {v13, v14, v11, v12}, Ljava/lang/Math;->atan2(DD)D

    .line 777
    .line 778
    .line 779
    move-result-wide v11

    .line 780
    iget v13, v3, Landroidx/constraintlayout/motion/widget/d;->q:F

    .line 781
    .line 782
    sub-float/2addr v13, v9

    .line 783
    float-to-double v13, v13

    .line 784
    iget v9, v3, Landroidx/constraintlayout/motion/widget/d;->p:F

    .line 785
    .line 786
    sub-float/2addr v9, v5

    .line 787
    float-to-double v8, v9

    .line 788
    invoke-static {v13, v14, v8, v9}, Ljava/lang/Math;->atan2(DD)D

    .line 789
    .line 790
    .line 791
    move-result-wide v8

    .line 792
    sub-double v8, v11, v8

    .line 793
    .line 794
    const-wide v13, 0x4066800000000000L    # 180.0

    .line 795
    .line 796
    .line 797
    .line 798
    .line 799
    mul-double/2addr v8, v13

    .line 800
    const-wide v13, 0x400921fb54442d18L    # Math.PI

    .line 801
    .line 802
    .line 803
    .line 804
    .line 805
    div-double/2addr v8, v13

    .line 806
    double-to-float v8, v8

    .line 807
    const/high16 v9, 0x43a50000    # 330.0f

    .line 808
    .line 809
    cmpl-float v9, v8, v9

    .line 810
    .line 811
    if-lez v9, :cond_20

    .line 812
    .line 813
    const/high16 v5, 0x43b40000    # 360.0f

    .line 814
    .line 815
    sub-float/2addr v8, v5

    .line 816
    goto :goto_d

    .line 817
    :cond_20
    const/high16 v5, 0x43b40000    # 360.0f

    .line 818
    .line 819
    const/high16 v9, -0x3c5b0000    # -330.0f

    .line 820
    .line 821
    cmpg-float v9, v8, v9

    .line 822
    .line 823
    if-gez v9, :cond_21

    .line 824
    .line 825
    add-float/2addr v8, v5

    .line 826
    :cond_21
    :goto_d
    invoke-static {v8}, Ljava/lang/Math;->abs(F)F

    .line 827
    .line 828
    .line 829
    move-result v9

    .line 830
    float-to-double v13, v9

    .line 831
    const-wide v19, 0x3f847ae147ae147bL    # 0.01

    .line 832
    .line 833
    .line 834
    .line 835
    .line 836
    cmpl-double v9, v13, v19

    .line 837
    .line 838
    if-gtz v9, :cond_22

    .line 839
    .line 840
    iget-boolean v9, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 841
    .line 842
    if-eqz v9, :cond_5d

    .line 843
    .line 844
    :cond_22
    invoke-virtual/range {v25 .. v25}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 845
    .line 846
    .line 847
    move-result v9

    .line 848
    iget-boolean v13, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 849
    .line 850
    if-nez v13, :cond_23

    .line 851
    .line 852
    const/4 v13, 0x1

    .line 853
    iput-boolean v13, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 854
    .line 855
    move-object/from16 v13, v25

    .line 856
    .line 857
    invoke-virtual {v13, v9}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 858
    .line 859
    .line 860
    goto :goto_e

    .line 861
    :cond_23
    move-object/from16 v13, v25

    .line 862
    .line 863
    :goto_e
    iget v14, v3, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 864
    .line 865
    const/4 v15, -0x1

    .line 866
    if-eq v14, v15, :cond_24

    .line 867
    .line 868
    iget v5, v3, Landroidx/constraintlayout/motion/widget/d;->h:F

    .line 869
    .line 870
    iget v15, v3, Landroidx/constraintlayout/motion/widget/d;->g:F

    .line 871
    .line 872
    iget-object v0, v3, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 873
    .line 874
    move-object/from16 v25, v2

    .line 875
    .line 876
    iget-object v2, v3, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 877
    .line 878
    move-object/from16 v19, v2

    .line 879
    .line 880
    move/from16 v20, v14

    .line 881
    .line 882
    move/from16 v21, v9

    .line 883
    .line 884
    move/from16 v22, v5

    .line 885
    .line 886
    move/from16 v23, v15

    .line 887
    .line 888
    move-object/from16 v24, v0

    .line 889
    .line 890
    invoke-virtual/range {v19 .. v24}, Landroidx/constraintlayout/motion/widget/MotionLayout;->w(IFFF[F)V

    .line 891
    .line 892
    .line 893
    const/4 v0, 0x1

    .line 894
    aget v2, v6, v0

    .line 895
    .line 896
    float-to-double v14, v2

    .line 897
    invoke-static {v14, v15}, Ljava/lang/Math;->toDegrees(D)D

    .line 898
    .line 899
    .line 900
    move-result-wide v14

    .line 901
    double-to-float v2, v14

    .line 902
    aput v2, v6, v0

    .line 903
    .line 904
    goto :goto_f

    .line 905
    :cond_24
    move-object/from16 v25, v2

    .line 906
    .line 907
    const/4 v0, 0x1

    .line 908
    const/high16 v2, 0x43b40000    # 360.0f

    .line 909
    .line 910
    aput v2, v6, v0

    .line 911
    .line 912
    :goto_f
    iget v2, v3, Landroidx/constraintlayout/motion/widget/d;->v:F

    .line 913
    .line 914
    mul-float/2addr v8, v2

    .line 915
    aget v2, v6, v0

    .line 916
    .line 917
    div-float/2addr v8, v2

    .line 918
    add-float/2addr v8, v9

    .line 919
    const/high16 v0, 0x3f800000    # 1.0f

    .line 920
    .line 921
    invoke-static {v8, v0}, Ljava/lang/Math;->min(FF)F

    .line 922
    .line 923
    .line 924
    move-result v2

    .line 925
    const/4 v5, 0x0

    .line 926
    invoke-static {v2, v5}, Ljava/lang/Math;->max(FF)F

    .line 927
    .line 928
    .line 929
    move-result v2

    .line 930
    invoke-virtual {v13}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 931
    .line 932
    .line 933
    move-result v6

    .line 934
    cmpl-float v8, v2, v6

    .line 935
    .line 936
    if-eqz v8, :cond_2a

    .line 937
    .line 938
    cmpl-float v8, v6, v5

    .line 939
    .line 940
    if-eqz v8, :cond_25

    .line 941
    .line 942
    cmpl-float v0, v6, v0

    .line 943
    .line 944
    if-nez v0, :cond_26

    .line 945
    .line 946
    :cond_25
    invoke-virtual {v13}, Landroidx/constraintlayout/motion/widget/MotionLayout;->s()V

    .line 947
    .line 948
    .line 949
    :cond_26
    invoke-virtual {v13, v2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 950
    .line 951
    .line 952
    iget-object v0, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 953
    .line 954
    if-eqz v0, :cond_27

    .line 955
    .line 956
    const/16 v2, 0x3e8

    .line 957
    .line 958
    invoke-virtual {v0, v2}, Landroid/view/VelocityTracker;->computeCurrentVelocity(I)V

    .line 959
    .line 960
    .line 961
    :cond_27
    iget-object v0, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 962
    .line 963
    if-eqz v0, :cond_28

    .line 964
    .line 965
    invoke-virtual {v0}, Landroid/view/VelocityTracker;->getXVelocity()F

    .line 966
    .line 967
    .line 968
    move-result v0

    .line 969
    goto :goto_10

    .line 970
    :cond_28
    const/4 v0, 0x0

    .line 971
    :goto_10
    iget-object v2, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 972
    .line 973
    if-eqz v2, :cond_29

    .line 974
    .line 975
    invoke-virtual {v2}, Landroid/view/VelocityTracker;->getYVelocity()F

    .line 976
    .line 977
    .line 978
    move-result v5

    .line 979
    goto :goto_11

    .line 980
    :cond_29
    const/4 v5, 0x0

    .line 981
    :goto_11
    float-to-double v4, v5

    .line 982
    float-to-double v8, v0

    .line 983
    invoke-static {v4, v5, v8, v9}, Ljava/lang/Math;->hypot(DD)D

    .line 984
    .line 985
    .line 986
    move-result-wide v14

    .line 987
    invoke-static {v4, v5, v8, v9}, Ljava/lang/Math;->atan2(DD)D

    .line 988
    .line 989
    .line 990
    move-result-wide v4

    .line 991
    sub-double/2addr v4, v11

    .line 992
    invoke-static {v4, v5}, Ljava/lang/Math;->sin(D)D

    .line 993
    .line 994
    .line 995
    move-result-wide v4

    .line 996
    mul-double/2addr v4, v14

    .line 997
    float-to-double v6, v7

    .line 998
    float-to-double v8, v10

    .line 999
    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->hypot(DD)D

    .line 1000
    .line 1001
    .line 1002
    move-result-wide v6

    .line 1003
    div-double/2addr v4, v6

    .line 1004
    double-to-float v0, v4

    .line 1005
    float-to-double v4, v0

    .line 1006
    invoke-static {v4, v5}, Ljava/lang/Math;->toDegrees(D)D

    .line 1007
    .line 1008
    .line 1009
    move-result-wide v4

    .line 1010
    double-to-float v0, v4

    .line 1011
    iput v0, v13, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 1012
    .line 1013
    goto :goto_12

    .line 1014
    :cond_2a
    move v0, v5

    .line 1015
    iput v0, v13, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 1016
    .line 1017
    :goto_12
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 1018
    .line 1019
    .line 1020
    move-result v0

    .line 1021
    iput v0, v3, Landroidx/constraintlayout/motion/widget/d;->p:F

    .line 1022
    .line 1023
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 1024
    .line 1025
    .line 1026
    move-result v0

    .line 1027
    iput v0, v3, Landroidx/constraintlayout/motion/widget/d;->q:F

    .line 1028
    .line 1029
    goto/16 :goto_2c

    .line 1030
    .line 1031
    :cond_2b
    move-object/from16 v25, v2

    .line 1032
    .line 1033
    move-object v13, v14

    .line 1034
    const/4 v0, 0x0

    .line 1035
    iput-boolean v0, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 1036
    .line 1037
    iget-object v0, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1038
    .line 1039
    if-eqz v0, :cond_2c

    .line 1040
    .line 1041
    const/16 v2, 0x10

    .line 1042
    .line 1043
    invoke-virtual {v0, v2}, Landroid/view/VelocityTracker;->computeCurrentVelocity(I)V

    .line 1044
    .line 1045
    .line 1046
    :cond_2c
    iget-object v0, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1047
    .line 1048
    if-eqz v0, :cond_2d

    .line 1049
    .line 1050
    invoke-virtual {v0}, Landroid/view/VelocityTracker;->getXVelocity()F

    .line 1051
    .line 1052
    .line 1053
    move-result v0

    .line 1054
    goto :goto_13

    .line 1055
    :cond_2d
    const/4 v0, 0x0

    .line 1056
    :goto_13
    iget-object v2, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1057
    .line 1058
    if-eqz v2, :cond_2e

    .line 1059
    .line 1060
    invoke-virtual {v2}, Landroid/view/VelocityTracker;->getYVelocity()F

    .line 1061
    .line 1062
    .line 1063
    move-result v2

    .line 1064
    goto :goto_14

    .line 1065
    :cond_2e
    const/4 v2, 0x0

    .line 1066
    :goto_14
    invoke-virtual {v13}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 1067
    .line 1068
    .line 1069
    move-result v4

    .line 1070
    invoke-virtual {v13}, Landroid/view/View;->getWidth()I

    .line 1071
    .line 1072
    .line 1073
    move-result v8

    .line 1074
    int-to-float v8, v8

    .line 1075
    div-float v8, v8, v24

    .line 1076
    .line 1077
    invoke-virtual {v13}, Landroid/view/View;->getHeight()I

    .line 1078
    .line 1079
    .line 1080
    move-result v9

    .line 1081
    int-to-float v9, v9

    .line 1082
    div-float v9, v9, v24

    .line 1083
    .line 1084
    iget v11, v3, Landroidx/constraintlayout/motion/widget/d;->i:I

    .line 1085
    .line 1086
    const/4 v12, -0x1

    .line 1087
    if-eq v11, v12, :cond_2f

    .line 1088
    .line 1089
    invoke-virtual {v13, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 1090
    .line 1091
    .line 1092
    move-result-object v8

    .line 1093
    invoke-virtual {v13, v7}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 1094
    .line 1095
    .line 1096
    const/4 v9, 0x0

    .line 1097
    aget v9, v7, v9

    .line 1098
    .line 1099
    int-to-float v9, v9

    .line 1100
    invoke-virtual {v8}, Landroid/view/View;->getLeft()I

    .line 1101
    .line 1102
    .line 1103
    move-result v11

    .line 1104
    invoke-virtual {v8}, Landroid/view/View;->getRight()I

    .line 1105
    .line 1106
    .line 1107
    move-result v12

    .line 1108
    add-int/2addr v12, v11

    .line 1109
    int-to-float v11, v12

    .line 1110
    div-float v11, v11, v24

    .line 1111
    .line 1112
    add-float/2addr v9, v11

    .line 1113
    const/4 v11, 0x1

    .line 1114
    aget v7, v7, v11

    .line 1115
    .line 1116
    int-to-float v7, v7

    .line 1117
    invoke-virtual {v8}, Landroid/view/View;->getTop()I

    .line 1118
    .line 1119
    .line 1120
    move-result v11

    .line 1121
    invoke-virtual {v8}, Landroid/view/View;->getBottom()I

    .line 1122
    .line 1123
    .line 1124
    move-result v8

    .line 1125
    :goto_15
    add-int/2addr v8, v11

    .line 1126
    int-to-float v8, v8

    .line 1127
    div-float v8, v8, v24

    .line 1128
    .line 1129
    add-float/2addr v7, v8

    .line 1130
    move v8, v9

    .line 1131
    move v9, v7

    .line 1132
    goto :goto_16

    .line 1133
    :cond_2f
    iget v11, v3, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 1134
    .line 1135
    const/4 v12, -0x1

    .line 1136
    if-eq v11, v12, :cond_30

    .line 1137
    .line 1138
    iget-object v8, v13, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 1139
    .line 1140
    invoke-virtual {v13, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 1141
    .line 1142
    .line 1143
    move-result-object v9

    .line 1144
    invoke-virtual {v8, v9}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 1145
    .line 1146
    .line 1147
    move-result-object v8

    .line 1148
    check-cast v8, Lh1/n;

    .line 1149
    .line 1150
    iget-object v8, v8, Lh1/n;->f:Lh1/v;

    .line 1151
    .line 1152
    iget v8, v8, Lh1/v;->k:I

    .line 1153
    .line 1154
    invoke-virtual {v13, v8}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 1155
    .line 1156
    .line 1157
    move-result-object v8

    .line 1158
    invoke-virtual {v13, v7}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 1159
    .line 1160
    .line 1161
    const/4 v9, 0x0

    .line 1162
    aget v9, v7, v9

    .line 1163
    .line 1164
    int-to-float v9, v9

    .line 1165
    invoke-virtual {v8}, Landroid/view/View;->getLeft()I

    .line 1166
    .line 1167
    .line 1168
    move-result v11

    .line 1169
    invoke-virtual {v8}, Landroid/view/View;->getRight()I

    .line 1170
    .line 1171
    .line 1172
    move-result v12

    .line 1173
    add-int/2addr v12, v11

    .line 1174
    int-to-float v11, v12

    .line 1175
    div-float v11, v11, v24

    .line 1176
    .line 1177
    add-float/2addr v9, v11

    .line 1178
    const/4 v11, 0x1

    .line 1179
    aget v7, v7, v11

    .line 1180
    .line 1181
    int-to-float v7, v7

    .line 1182
    invoke-virtual {v8}, Landroid/view/View;->getTop()I

    .line 1183
    .line 1184
    .line 1185
    move-result v11

    .line 1186
    invoke-virtual {v8}, Landroid/view/View;->getBottom()I

    .line 1187
    .line 1188
    .line 1189
    move-result v8

    .line 1190
    goto :goto_15

    .line 1191
    :cond_30
    :goto_16
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 1192
    .line 1193
    .line 1194
    move-result v7

    .line 1195
    sub-float/2addr v7, v8

    .line 1196
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 1197
    .line 1198
    .line 1199
    move-result v8

    .line 1200
    sub-float/2addr v8, v9

    .line 1201
    float-to-double v11, v8

    .line 1202
    float-to-double v14, v7

    .line 1203
    invoke-static {v11, v12, v14, v15}, Ljava/lang/Math;->atan2(DD)D

    .line 1204
    .line 1205
    .line 1206
    move-result-wide v11

    .line 1207
    invoke-static {v11, v12}, Ljava/lang/Math;->toDegrees(D)D

    .line 1208
    .line 1209
    .line 1210
    move-result-wide v11

    .line 1211
    iget v9, v3, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 1212
    .line 1213
    const/4 v14, -0x1

    .line 1214
    if-eq v9, v14, :cond_31

    .line 1215
    .line 1216
    iget v5, v3, Landroidx/constraintlayout/motion/widget/d;->h:F

    .line 1217
    .line 1218
    iget v14, v3, Landroidx/constraintlayout/motion/widget/d;->g:F

    .line 1219
    .line 1220
    iget-object v15, v3, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 1221
    .line 1222
    iget-object v10, v3, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 1223
    .line 1224
    move-object/from16 v26, v10

    .line 1225
    .line 1226
    move/from16 v27, v9

    .line 1227
    .line 1228
    move/from16 v28, v4

    .line 1229
    .line 1230
    move/from16 v29, v5

    .line 1231
    .line 1232
    move/from16 v30, v14

    .line 1233
    .line 1234
    move-object/from16 v31, v15

    .line 1235
    .line 1236
    invoke-virtual/range {v26 .. v31}, Landroidx/constraintlayout/motion/widget/MotionLayout;->w(IFFF[F)V

    .line 1237
    .line 1238
    .line 1239
    const/4 v5, 0x1

    .line 1240
    aget v9, v6, v5

    .line 1241
    .line 1242
    float-to-double v9, v9

    .line 1243
    invoke-static {v9, v10}, Ljava/lang/Math;->toDegrees(D)D

    .line 1244
    .line 1245
    .line 1246
    move-result-wide v9

    .line 1247
    double-to-float v9, v9

    .line 1248
    aput v9, v6, v5

    .line 1249
    .line 1250
    goto :goto_17

    .line 1251
    :cond_31
    const/4 v5, 0x1

    .line 1252
    const/high16 v9, 0x43b40000    # 360.0f

    .line 1253
    .line 1254
    aput v9, v6, v5

    .line 1255
    .line 1256
    :goto_17
    add-float/2addr v2, v8

    .line 1257
    float-to-double v8, v2

    .line 1258
    add-float/2addr v0, v7

    .line 1259
    float-to-double v14, v0

    .line 1260
    invoke-static {v8, v9, v14, v15}, Ljava/lang/Math;->atan2(DD)D

    .line 1261
    .line 1262
    .line 1263
    move-result-wide v7

    .line 1264
    invoke-static {v7, v8}, Ljava/lang/Math;->toDegrees(D)D

    .line 1265
    .line 1266
    .line 1267
    move-result-wide v7

    .line 1268
    sub-double/2addr v7, v11

    .line 1269
    double-to-float v0, v7

    .line 1270
    const/high16 v2, 0x427a0000    # 62.5f

    .line 1271
    .line 1272
    mul-float/2addr v0, v2

    .line 1273
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    .line 1274
    .line 1275
    .line 1276
    move-result v2

    .line 1277
    if-nez v2, :cond_32

    .line 1278
    .line 1279
    const/high16 v2, 0x40400000    # 3.0f

    .line 1280
    .line 1281
    mul-float v10, v0, v2

    .line 1282
    .line 1283
    iget v2, v3, Landroidx/constraintlayout/motion/widget/d;->v:F

    .line 1284
    .line 1285
    mul-float/2addr v10, v2

    .line 1286
    const/4 v2, 0x1

    .line 1287
    aget v5, v6, v2

    .line 1288
    .line 1289
    div-float/2addr v10, v5

    .line 1290
    add-float/2addr v10, v4

    .line 1291
    :goto_18
    const/4 v2, 0x0

    .line 1292
    goto :goto_19

    .line 1293
    :cond_32
    move v10, v4

    .line 1294
    goto :goto_18

    .line 1295
    :goto_19
    cmpl-float v5, v10, v2

    .line 1296
    .line 1297
    if-eqz v5, :cond_39

    .line 1298
    .line 1299
    const/high16 v2, 0x3f800000    # 1.0f

    .line 1300
    .line 1301
    cmpl-float v5, v10, v2

    .line 1302
    .line 1303
    if-eqz v5, :cond_39

    .line 1304
    .line 1305
    iget v2, v3, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 1306
    .line 1307
    const/4 v5, 0x3

    .line 1308
    if-eq v2, v5, :cond_39

    .line 1309
    .line 1310
    iget v5, v3, Landroidx/constraintlayout/motion/widget/d;->v:F

    .line 1311
    .line 1312
    mul-float/2addr v0, v5

    .line 1313
    const/4 v5, 0x1

    .line 1314
    aget v6, v6, v5

    .line 1315
    .line 1316
    div-float/2addr v0, v6

    .line 1317
    float-to-double v5, v10

    .line 1318
    const-wide/high16 v7, 0x3fe0000000000000L    # 0.5

    .line 1319
    .line 1320
    cmpg-double v5, v5, v7

    .line 1321
    .line 1322
    if-gez v5, :cond_33

    .line 1323
    .line 1324
    const/4 v5, 0x0

    .line 1325
    :goto_1a
    const/4 v6, 0x6

    .line 1326
    goto :goto_1b

    .line 1327
    :cond_33
    const/high16 v5, 0x3f800000    # 1.0f

    .line 1328
    .line 1329
    goto :goto_1a

    .line 1330
    :goto_1b
    if-ne v2, v6, :cond_35

    .line 1331
    .line 1332
    add-float v2, v4, v0

    .line 1333
    .line 1334
    const/4 v5, 0x0

    .line 1335
    cmpg-float v2, v2, v5

    .line 1336
    .line 1337
    if-gez v2, :cond_34

    .line 1338
    .line 1339
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    .line 1340
    .line 1341
    .line 1342
    move-result v0

    .line 1343
    :cond_34
    const/high16 v5, 0x3f800000    # 1.0f

    .line 1344
    .line 1345
    :cond_35
    iget v2, v3, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 1346
    .line 1347
    const/4 v6, 0x7

    .line 1348
    if-ne v2, v6, :cond_37

    .line 1349
    .line 1350
    add-float v2, v4, v0

    .line 1351
    .line 1352
    const/high16 v5, 0x3f800000    # 1.0f

    .line 1353
    .line 1354
    cmpl-float v2, v2, v5

    .line 1355
    .line 1356
    if-lez v2, :cond_36

    .line 1357
    .line 1358
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    .line 1359
    .line 1360
    .line 1361
    move-result v0

    .line 1362
    neg-float v0, v0

    .line 1363
    :cond_36
    const/4 v5, 0x0

    .line 1364
    :cond_37
    iget v2, v3, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 1365
    .line 1366
    const/high16 v3, 0x40400000    # 3.0f

    .line 1367
    .line 1368
    mul-float/2addr v0, v3

    .line 1369
    invoke-virtual {v13, v2, v5, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->G(IFF)V

    .line 1370
    .line 1371
    .line 1372
    const/4 v0, 0x0

    .line 1373
    cmpl-float v0, v0, v4

    .line 1374
    .line 1375
    if-gez v0, :cond_38

    .line 1376
    .line 1377
    const/high16 v0, 0x3f800000    # 1.0f

    .line 1378
    .line 1379
    cmpg-float v0, v0, v4

    .line 1380
    .line 1381
    if-gtz v0, :cond_5e

    .line 1382
    .line 1383
    :cond_38
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 1384
    .line 1385
    invoke-virtual {v13, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 1386
    .line 1387
    .line 1388
    goto/16 :goto_2c

    .line 1389
    .line 1390
    :cond_39
    const/4 v0, 0x0

    .line 1391
    cmpl-float v0, v0, v10

    .line 1392
    .line 1393
    if-gez v0, :cond_3a

    .line 1394
    .line 1395
    const/high16 v0, 0x3f800000    # 1.0f

    .line 1396
    .line 1397
    cmpg-float v0, v0, v10

    .line 1398
    .line 1399
    if-gtz v0, :cond_5e

    .line 1400
    .line 1401
    :cond_3a
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 1402
    .line 1403
    invoke-virtual {v13, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 1404
    .line 1405
    .line 1406
    goto/16 :goto_2c

    .line 1407
    .line 1408
    :cond_3b
    move-object/from16 v25, v2

    .line 1409
    .line 1410
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 1411
    .line 1412
    .line 1413
    move-result v0

    .line 1414
    iput v0, v3, Landroidx/constraintlayout/motion/widget/d;->p:F

    .line 1415
    .line 1416
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 1417
    .line 1418
    .line 1419
    move-result v0

    .line 1420
    iput v0, v3, Landroidx/constraintlayout/motion/widget/d;->q:F

    .line 1421
    .line 1422
    const/4 v0, 0x0

    .line 1423
    iput-boolean v0, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 1424
    .line 1425
    goto/16 :goto_2c

    .line 1426
    .line 1427
    :cond_3c
    move-object/from16 v25, v2

    .line 1428
    .line 1429
    move-object v13, v14

    .line 1430
    iget-object v0, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1431
    .line 1432
    if-eqz v0, :cond_3d

    .line 1433
    .line 1434
    invoke-virtual {v0, v1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    .line 1435
    .line 1436
    .line 1437
    :cond_3d
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    .line 1438
    .line 1439
    .line 1440
    move-result v0

    .line 1441
    if-eqz v0, :cond_5c

    .line 1442
    .line 1443
    const/4 v2, 0x1

    .line 1444
    if-eq v0, v2, :cond_4d

    .line 1445
    .line 1446
    const/4 v2, 0x2

    .line 1447
    if-eq v0, v2, :cond_3e

    .line 1448
    .line 1449
    goto/16 :goto_2c

    .line 1450
    .line 1451
    :cond_3e
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 1452
    .line 1453
    .line 1454
    move-result v0

    .line 1455
    iget v2, v3, Landroidx/constraintlayout/motion/widget/d;->q:F

    .line 1456
    .line 1457
    sub-float/2addr v0, v2

    .line 1458
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 1459
    .line 1460
    .line 1461
    move-result v2

    .line 1462
    iget v5, v3, Landroidx/constraintlayout/motion/widget/d;->p:F

    .line 1463
    .line 1464
    sub-float/2addr v2, v5

    .line 1465
    iget v5, v3, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 1466
    .line 1467
    mul-float/2addr v5, v2

    .line 1468
    iget v7, v3, Landroidx/constraintlayout/motion/widget/d;->l:F

    .line 1469
    .line 1470
    mul-float/2addr v7, v0

    .line 1471
    add-float/2addr v7, v5

    .line 1472
    invoke-static {v7}, Ljava/lang/Math;->abs(F)F

    .line 1473
    .line 1474
    .line 1475
    move-result v5

    .line 1476
    iget v7, v3, Landroidx/constraintlayout/motion/widget/d;->x:F

    .line 1477
    .line 1478
    cmpl-float v5, v5, v7

    .line 1479
    .line 1480
    if-gtz v5, :cond_3f

    .line 1481
    .line 1482
    iget-boolean v5, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 1483
    .line 1484
    if-eqz v5, :cond_5e

    .line 1485
    .line 1486
    :cond_3f
    invoke-virtual {v13}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 1487
    .line 1488
    .line 1489
    move-result v5

    .line 1490
    iget-boolean v7, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 1491
    .line 1492
    if-nez v7, :cond_40

    .line 1493
    .line 1494
    const/4 v7, 0x1

    .line 1495
    iput-boolean v7, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 1496
    .line 1497
    invoke-virtual {v13, v5}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 1498
    .line 1499
    .line 1500
    :cond_40
    iget v8, v3, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 1501
    .line 1502
    const/4 v7, -0x1

    .line 1503
    if-eq v8, v7, :cond_41

    .line 1504
    .line 1505
    iget v10, v3, Landroidx/constraintlayout/motion/widget/d;->h:F

    .line 1506
    .line 1507
    iget v11, v3, Landroidx/constraintlayout/motion/widget/d;->g:F

    .line 1508
    .line 1509
    iget-object v12, v3, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 1510
    .line 1511
    iget-object v7, v3, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 1512
    .line 1513
    move v9, v5

    .line 1514
    invoke-virtual/range {v7 .. v12}, Landroidx/constraintlayout/motion/widget/MotionLayout;->w(IFFF[F)V

    .line 1515
    .line 1516
    .line 1517
    const/4 v8, 0x0

    .line 1518
    const/4 v9, 0x1

    .line 1519
    goto :goto_1c

    .line 1520
    :cond_41
    invoke-virtual {v13}, Landroid/view/View;->getWidth()I

    .line 1521
    .line 1522
    .line 1523
    move-result v7

    .line 1524
    invoke-virtual {v13}, Landroid/view/View;->getHeight()I

    .line 1525
    .line 1526
    .line 1527
    move-result v8

    .line 1528
    invoke-static {v7, v8}, Ljava/lang/Math;->min(II)I

    .line 1529
    .line 1530
    .line 1531
    move-result v7

    .line 1532
    int-to-float v7, v7

    .line 1533
    iget v8, v3, Landroidx/constraintlayout/motion/widget/d;->l:F

    .line 1534
    .line 1535
    mul-float/2addr v8, v7

    .line 1536
    const/4 v9, 0x1

    .line 1537
    aput v8, v6, v9

    .line 1538
    .line 1539
    iget v8, v3, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 1540
    .line 1541
    mul-float/2addr v7, v8

    .line 1542
    const/4 v8, 0x0

    .line 1543
    aput v7, v6, v8

    .line 1544
    .line 1545
    :goto_1c
    iget v7, v3, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 1546
    .line 1547
    aget v10, v6, v8

    .line 1548
    .line 1549
    mul-float/2addr v7, v10

    .line 1550
    iget v8, v3, Landroidx/constraintlayout/motion/widget/d;->l:F

    .line 1551
    .line 1552
    aget v10, v6, v9

    .line 1553
    .line 1554
    mul-float/2addr v8, v10

    .line 1555
    add-float/2addr v8, v7

    .line 1556
    iget v7, v3, Landroidx/constraintlayout/motion/widget/d;->v:F

    .line 1557
    .line 1558
    mul-float/2addr v8, v7

    .line 1559
    invoke-static {v8}, Ljava/lang/Math;->abs(F)F

    .line 1560
    .line 1561
    .line 1562
    move-result v7

    .line 1563
    float-to-double v7, v7

    .line 1564
    const-wide v10, 0x3f847ae147ae147bL    # 0.01

    .line 1565
    .line 1566
    .line 1567
    .line 1568
    .line 1569
    cmpg-double v7, v7, v10

    .line 1570
    .line 1571
    const v8, 0x3c23d70a    # 0.01f

    .line 1572
    .line 1573
    .line 1574
    if-gez v7, :cond_42

    .line 1575
    .line 1576
    const/4 v7, 0x0

    .line 1577
    aput v8, v6, v7

    .line 1578
    .line 1579
    aput v8, v6, v9

    .line 1580
    .line 1581
    goto :goto_1d

    .line 1582
    :cond_42
    const/4 v7, 0x0

    .line 1583
    :goto_1d
    iget v10, v3, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 1584
    .line 1585
    const/4 v11, 0x0

    .line 1586
    cmpl-float v10, v10, v11

    .line 1587
    .line 1588
    if-eqz v10, :cond_43

    .line 1589
    .line 1590
    aget v0, v6, v7

    .line 1591
    .line 1592
    div-float/2addr v2, v0

    .line 1593
    goto :goto_1e

    .line 1594
    :cond_43
    aget v2, v6, v9

    .line 1595
    .line 1596
    div-float v2, v0, v2

    .line 1597
    .line 1598
    :goto_1e
    add-float/2addr v5, v2

    .line 1599
    const/high16 v0, 0x3f800000    # 1.0f

    .line 1600
    .line 1601
    invoke-static {v5, v0}, Ljava/lang/Math;->min(FF)F

    .line 1602
    .line 1603
    .line 1604
    move-result v2

    .line 1605
    invoke-static {v2, v11}, Ljava/lang/Math;->max(FF)F

    .line 1606
    .line 1607
    .line 1608
    move-result v0

    .line 1609
    iget v2, v3, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 1610
    .line 1611
    const/4 v5, 0x6

    .line 1612
    if-ne v2, v5, :cond_44

    .line 1613
    .line 1614
    invoke-static {v0, v8}, Ljava/lang/Math;->max(FF)F

    .line 1615
    .line 1616
    .line 1617
    move-result v0

    .line 1618
    :cond_44
    iget v2, v3, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 1619
    .line 1620
    const/4 v5, 0x7

    .line 1621
    if-ne v2, v5, :cond_45

    .line 1622
    .line 1623
    const v2, 0x3f7d70a4    # 0.99f

    .line 1624
    .line 1625
    .line 1626
    invoke-static {v0, v2}, Ljava/lang/Math;->min(FF)F

    .line 1627
    .line 1628
    .line 1629
    move-result v0

    .line 1630
    :cond_45
    invoke-virtual {v13}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 1631
    .line 1632
    .line 1633
    move-result v2

    .line 1634
    cmpl-float v5, v0, v2

    .line 1635
    .line 1636
    if-eqz v5, :cond_4c

    .line 1637
    .line 1638
    const/4 v5, 0x0

    .line 1639
    cmpl-float v7, v2, v5

    .line 1640
    .line 1641
    if-eqz v7, :cond_46

    .line 1642
    .line 1643
    const/high16 v5, 0x3f800000    # 1.0f

    .line 1644
    .line 1645
    cmpl-float v2, v2, v5

    .line 1646
    .line 1647
    if-nez v2, :cond_47

    .line 1648
    .line 1649
    :cond_46
    invoke-virtual {v13}, Landroidx/constraintlayout/motion/widget/MotionLayout;->s()V

    .line 1650
    .line 1651
    .line 1652
    :cond_47
    invoke-virtual {v13, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 1653
    .line 1654
    .line 1655
    iget-object v0, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1656
    .line 1657
    if-eqz v0, :cond_48

    .line 1658
    .line 1659
    const/16 v2, 0x3e8

    .line 1660
    .line 1661
    invoke-virtual {v0, v2}, Landroid/view/VelocityTracker;->computeCurrentVelocity(I)V

    .line 1662
    .line 1663
    .line 1664
    :cond_48
    iget-object v0, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1665
    .line 1666
    if-eqz v0, :cond_49

    .line 1667
    .line 1668
    invoke-virtual {v0}, Landroid/view/VelocityTracker;->getXVelocity()F

    .line 1669
    .line 1670
    .line 1671
    move-result v0

    .line 1672
    goto :goto_1f

    .line 1673
    :cond_49
    const/4 v0, 0x0

    .line 1674
    :goto_1f
    iget-object v2, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1675
    .line 1676
    if-eqz v2, :cond_4a

    .line 1677
    .line 1678
    invoke-virtual {v2}, Landroid/view/VelocityTracker;->getYVelocity()F

    .line 1679
    .line 1680
    .line 1681
    move-result v2

    .line 1682
    goto :goto_20

    .line 1683
    :cond_4a
    const/4 v2, 0x0

    .line 1684
    :goto_20
    iget v4, v3, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 1685
    .line 1686
    const/4 v5, 0x0

    .line 1687
    cmpl-float v4, v4, v5

    .line 1688
    .line 1689
    if-eqz v4, :cond_4b

    .line 1690
    .line 1691
    const/4 v4, 0x0

    .line 1692
    aget v2, v6, v4

    .line 1693
    .line 1694
    div-float/2addr v0, v2

    .line 1695
    goto :goto_21

    .line 1696
    :cond_4b
    const/4 v0, 0x1

    .line 1697
    aget v4, v6, v0

    .line 1698
    .line 1699
    div-float v0, v2, v4

    .line 1700
    .line 1701
    :goto_21
    iput v0, v13, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 1702
    .line 1703
    goto :goto_22

    .line 1704
    :cond_4c
    const/4 v5, 0x0

    .line 1705
    iput v5, v13, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 1706
    .line 1707
    :goto_22
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 1708
    .line 1709
    .line 1710
    move-result v0

    .line 1711
    iput v0, v3, Landroidx/constraintlayout/motion/widget/d;->p:F

    .line 1712
    .line 1713
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 1714
    .line 1715
    .line 1716
    move-result v0

    .line 1717
    iput v0, v3, Landroidx/constraintlayout/motion/widget/d;->q:F

    .line 1718
    .line 1719
    goto/16 :goto_2c

    .line 1720
    .line 1721
    :cond_4d
    const/4 v0, 0x0

    .line 1722
    iput-boolean v0, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 1723
    .line 1724
    iget-object v0, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1725
    .line 1726
    if-eqz v0, :cond_4e

    .line 1727
    .line 1728
    const/16 v2, 0x3e8

    .line 1729
    .line 1730
    invoke-virtual {v0, v2}, Landroid/view/VelocityTracker;->computeCurrentVelocity(I)V

    .line 1731
    .line 1732
    .line 1733
    :cond_4e
    iget-object v0, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1734
    .line 1735
    if-eqz v0, :cond_4f

    .line 1736
    .line 1737
    invoke-virtual {v0}, Landroid/view/VelocityTracker;->getXVelocity()F

    .line 1738
    .line 1739
    .line 1740
    move-result v0

    .line 1741
    goto :goto_23

    .line 1742
    :cond_4f
    const/4 v0, 0x0

    .line 1743
    :goto_23
    iget-object v2, v4, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1744
    .line 1745
    if-eqz v2, :cond_50

    .line 1746
    .line 1747
    invoke-virtual {v2}, Landroid/view/VelocityTracker;->getYVelocity()F

    .line 1748
    .line 1749
    .line 1750
    move-result v2

    .line 1751
    goto :goto_24

    .line 1752
    :cond_50
    const/4 v2, 0x0

    .line 1753
    :goto_24
    invoke-virtual {v13}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getProgress()F

    .line 1754
    .line 1755
    .line 1756
    move-result v4

    .line 1757
    iget v8, v3, Landroidx/constraintlayout/motion/widget/d;->d:I

    .line 1758
    .line 1759
    const/4 v5, -0x1

    .line 1760
    if-eq v8, v5, :cond_51

    .line 1761
    .line 1762
    iget v10, v3, Landroidx/constraintlayout/motion/widget/d;->h:F

    .line 1763
    .line 1764
    iget v11, v3, Landroidx/constraintlayout/motion/widget/d;->g:F

    .line 1765
    .line 1766
    iget-object v12, v3, Landroidx/constraintlayout/motion/widget/d;->n:[F

    .line 1767
    .line 1768
    iget-object v7, v3, Landroidx/constraintlayout/motion/widget/d;->r:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 1769
    .line 1770
    move v9, v4

    .line 1771
    invoke-virtual/range {v7 .. v12}, Landroidx/constraintlayout/motion/widget/MotionLayout;->w(IFFF[F)V

    .line 1772
    .line 1773
    .line 1774
    const/4 v7, 0x0

    .line 1775
    const/4 v8, 0x1

    .line 1776
    goto :goto_25

    .line 1777
    :cond_51
    invoke-virtual {v13}, Landroid/view/View;->getWidth()I

    .line 1778
    .line 1779
    .line 1780
    move-result v5

    .line 1781
    invoke-virtual {v13}, Landroid/view/View;->getHeight()I

    .line 1782
    .line 1783
    .line 1784
    move-result v7

    .line 1785
    invoke-static {v5, v7}, Ljava/lang/Math;->min(II)I

    .line 1786
    .line 1787
    .line 1788
    move-result v5

    .line 1789
    int-to-float v5, v5

    .line 1790
    iget v7, v3, Landroidx/constraintlayout/motion/widget/d;->l:F

    .line 1791
    .line 1792
    mul-float/2addr v7, v5

    .line 1793
    const/4 v8, 0x1

    .line 1794
    aput v7, v6, v8

    .line 1795
    .line 1796
    iget v7, v3, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 1797
    .line 1798
    mul-float/2addr v5, v7

    .line 1799
    const/4 v7, 0x0

    .line 1800
    aput v5, v6, v7

    .line 1801
    .line 1802
    :goto_25
    iget v5, v3, Landroidx/constraintlayout/motion/widget/d;->k:F

    .line 1803
    .line 1804
    aget v7, v6, v7

    .line 1805
    .line 1806
    aget v6, v6, v8

    .line 1807
    .line 1808
    const/4 v8, 0x0

    .line 1809
    cmpl-float v5, v5, v8

    .line 1810
    .line 1811
    if-eqz v5, :cond_52

    .line 1812
    .line 1813
    div-float/2addr v0, v7

    .line 1814
    goto :goto_26

    .line 1815
    :cond_52
    div-float v0, v2, v6

    .line 1816
    .line 1817
    :goto_26
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    .line 1818
    .line 1819
    .line 1820
    move-result v2

    .line 1821
    if-nez v2, :cond_53

    .line 1822
    .line 1823
    const/high16 v2, 0x40400000    # 3.0f

    .line 1824
    .line 1825
    div-float v2, v0, v2

    .line 1826
    .line 1827
    add-float/2addr v2, v4

    .line 1828
    :goto_27
    const/4 v5, 0x0

    .line 1829
    goto :goto_28

    .line 1830
    :cond_53
    move v2, v4

    .line 1831
    goto :goto_27

    .line 1832
    :goto_28
    cmpl-float v6, v2, v5

    .line 1833
    .line 1834
    if-eqz v6, :cond_5a

    .line 1835
    .line 1836
    const/high16 v5, 0x3f800000    # 1.0f

    .line 1837
    .line 1838
    cmpl-float v6, v2, v5

    .line 1839
    .line 1840
    if-eqz v6, :cond_5a

    .line 1841
    .line 1842
    iget v5, v3, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 1843
    .line 1844
    const/4 v6, 0x3

    .line 1845
    if-eq v5, v6, :cond_5a

    .line 1846
    .line 1847
    float-to-double v6, v2

    .line 1848
    const-wide/high16 v8, 0x3fe0000000000000L    # 0.5

    .line 1849
    .line 1850
    cmpg-double v2, v6, v8

    .line 1851
    .line 1852
    if-gez v2, :cond_54

    .line 1853
    .line 1854
    const/4 v2, 0x0

    .line 1855
    :goto_29
    const/4 v6, 0x6

    .line 1856
    goto :goto_2a

    .line 1857
    :cond_54
    const/high16 v2, 0x3f800000    # 1.0f

    .line 1858
    .line 1859
    goto :goto_29

    .line 1860
    :goto_2a
    if-ne v5, v6, :cond_56

    .line 1861
    .line 1862
    add-float v2, v4, v0

    .line 1863
    .line 1864
    const/4 v5, 0x0

    .line 1865
    cmpg-float v2, v2, v5

    .line 1866
    .line 1867
    if-gez v2, :cond_55

    .line 1868
    .line 1869
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    .line 1870
    .line 1871
    .line 1872
    move-result v0

    .line 1873
    :cond_55
    const/high16 v2, 0x3f800000    # 1.0f

    .line 1874
    .line 1875
    :cond_56
    iget v5, v3, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 1876
    .line 1877
    const/4 v6, 0x7

    .line 1878
    if-ne v5, v6, :cond_58

    .line 1879
    .line 1880
    add-float v2, v4, v0

    .line 1881
    .line 1882
    const/high16 v5, 0x3f800000    # 1.0f

    .line 1883
    .line 1884
    cmpl-float v2, v2, v5

    .line 1885
    .line 1886
    if-lez v2, :cond_57

    .line 1887
    .line 1888
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    .line 1889
    .line 1890
    .line 1891
    move-result v0

    .line 1892
    neg-float v0, v0

    .line 1893
    :cond_57
    const/4 v2, 0x0

    .line 1894
    :cond_58
    iget v3, v3, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 1895
    .line 1896
    invoke-virtual {v13, v3, v2, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->G(IFF)V

    .line 1897
    .line 1898
    .line 1899
    const/4 v0, 0x0

    .line 1900
    cmpl-float v0, v0, v4

    .line 1901
    .line 1902
    if-gez v0, :cond_59

    .line 1903
    .line 1904
    const/high16 v0, 0x3f800000    # 1.0f

    .line 1905
    .line 1906
    cmpg-float v0, v0, v4

    .line 1907
    .line 1908
    if-gtz v0, :cond_5e

    .line 1909
    .line 1910
    :cond_59
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 1911
    .line 1912
    invoke-virtual {v13, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 1913
    .line 1914
    .line 1915
    goto :goto_2c

    .line 1916
    :cond_5a
    const/4 v0, 0x0

    .line 1917
    cmpl-float v0, v0, v2

    .line 1918
    .line 1919
    if-gez v0, :cond_5b

    .line 1920
    .line 1921
    const/high16 v0, 0x3f800000    # 1.0f

    .line 1922
    .line 1923
    cmpg-float v0, v0, v2

    .line 1924
    .line 1925
    if-gtz v0, :cond_5e

    .line 1926
    .line 1927
    :cond_5b
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 1928
    .line 1929
    invoke-virtual {v13, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 1930
    .line 1931
    .line 1932
    goto :goto_2c

    .line 1933
    :cond_5c
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 1934
    .line 1935
    .line 1936
    move-result v0

    .line 1937
    iput v0, v3, Landroidx/constraintlayout/motion/widget/d;->p:F

    .line 1938
    .line 1939
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 1940
    .line 1941
    .line 1942
    move-result v0

    .line 1943
    iput v0, v3, Landroidx/constraintlayout/motion/widget/d;->q:F

    .line 1944
    .line 1945
    const/4 v0, 0x0

    .line 1946
    iput-boolean v0, v3, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 1947
    .line 1948
    goto :goto_2c

    .line 1949
    :cond_5d
    :goto_2b
    move-object/from16 v25, v2

    .line 1950
    .line 1951
    :cond_5e
    :goto_2c
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawX()F

    .line 1952
    .line 1953
    .line 1954
    move-result v0

    .line 1955
    move-object/from16 v2, v25

    .line 1956
    .line 1957
    iput v0, v2, Landroidx/constraintlayout/motion/widget/c;->r:F

    .line 1958
    .line 1959
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getRawY()F

    .line 1960
    .line 1961
    .line 1962
    move-result v0

    .line 1963
    iput v0, v2, Landroidx/constraintlayout/motion/widget/c;->s:F

    .line 1964
    .line 1965
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    .line 1966
    .line 1967
    .line 1968
    move-result v0

    .line 1969
    const/4 v1, 0x1

    .line 1970
    if-ne v0, v1, :cond_60

    .line 1971
    .line 1972
    iget-object v0, v2, Landroidx/constraintlayout/motion/widget/c;->o:Lh1/t;

    .line 1973
    .line 1974
    if-eqz v0, :cond_60

    .line 1975
    .line 1976
    iget-object v1, v0, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1977
    .line 1978
    if-eqz v1, :cond_5f

    .line 1979
    .line 1980
    invoke-virtual {v1}, Landroid/view/VelocityTracker;->recycle()V

    .line 1981
    .line 1982
    .line 1983
    const/4 v1, 0x0

    .line 1984
    iput-object v1, v0, Lh1/t;->a:Landroid/view/VelocityTracker;

    .line 1985
    .line 1986
    goto :goto_2d

    .line 1987
    :cond_5f
    const/4 v1, 0x0

    .line 1988
    :goto_2d
    iput-object v1, v2, Landroidx/constraintlayout/motion/widget/c;->o:Lh1/t;

    .line 1989
    .line 1990
    move-object/from16 v0, p0

    .line 1991
    .line 1992
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 1993
    .line 1994
    const/4 v3, -0x1

    .line 1995
    if-eq v1, v3, :cond_61

    .line 1996
    .line 1997
    invoke-virtual {v2, v1, v0}, Landroidx/constraintlayout/motion/widget/c;->a(ILandroidx/constraintlayout/motion/widget/MotionLayout;)Z

    .line 1998
    .line 1999
    .line 2000
    goto :goto_2e

    .line 2001
    :cond_60
    move-object/from16 v0, p0

    .line 2002
    .line 2003
    :cond_61
    :goto_2e
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2004
    .line 2005
    iget-object v1, v1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 2006
    .line 2007
    iget v2, v1, Lh1/x;->r:I

    .line 2008
    .line 2009
    and-int/lit8 v2, v2, 0x4

    .line 2010
    .line 2011
    if-eqz v2, :cond_62

    .line 2012
    .line 2013
    iget-object v1, v1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 2014
    .line 2015
    iget-boolean v1, v1, Landroidx/constraintlayout/motion/widget/d;->m:Z

    .line 2016
    .line 2017
    return v1

    .line 2018
    :cond_62
    const/4 v1, 0x1

    .line 2019
    return v1

    .line 2020
    :cond_63
    invoke-super/range {p0 .. p1}, Landroid/view/ViewGroup;->onTouchEvent(Landroid/view/MotionEvent;)Z

    .line 2021
    .line 2022
    .line 2023
    move-result v1

    .line 2024
    return v1
.end method

.method public final onViewAdded(Landroid/view/View;)V
    .locals 1

    .line 1
    invoke-super {p0, p1}, Landroidx/constraintlayout/widget/ConstraintLayout;->onViewAdded(Landroid/view/View;)V

    .line 2
    .line 3
    .line 4
    instance-of v0, p1, Landroidx/constraintlayout/motion/widget/MotionHelper;

    .line 5
    .line 6
    if-eqz v0, :cond_6

    .line 7
    .line 8
    check-cast p1, Landroidx/constraintlayout/motion/widget/MotionHelper;

    .line 9
    .line 10
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 11
    .line 12
    if-nez v0, :cond_0

    .line 13
    .line 14
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 15
    .line 16
    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    .line 17
    .line 18
    .line 19
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 20
    .line 21
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 22
    .line 23
    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 24
    .line 25
    .line 26
    iget-boolean v0, p1, Landroidx/constraintlayout/motion/widget/MotionHelper;->i:Z

    .line 27
    .line 28
    if-eqz v0, :cond_2

    .line 29
    .line 30
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->d0:Ljava/util/ArrayList;

    .line 31
    .line 32
    if-nez v0, :cond_1

    .line 33
    .line 34
    new-instance v0, Ljava/util/ArrayList;

    .line 35
    .line 36
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 37
    .line 38
    .line 39
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->d0:Ljava/util/ArrayList;

    .line 40
    .line 41
    :cond_1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->d0:Ljava/util/ArrayList;

    .line 42
    .line 43
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 44
    .line 45
    .line 46
    :cond_2
    iget-boolean v0, p1, Landroidx/constraintlayout/motion/widget/MotionHelper;->j:Z

    .line 47
    .line 48
    if-eqz v0, :cond_4

    .line 49
    .line 50
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->e0:Ljava/util/ArrayList;

    .line 51
    .line 52
    if-nez v0, :cond_3

    .line 53
    .line 54
    new-instance v0, Ljava/util/ArrayList;

    .line 55
    .line 56
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 57
    .line 58
    .line 59
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->e0:Ljava/util/ArrayList;

    .line 60
    .line 61
    :cond_3
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->e0:Ljava/util/ArrayList;

    .line 62
    .line 63
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 64
    .line 65
    .line 66
    :cond_4
    instance-of v0, p1, Landroidx/constraintlayout/helper/widget/MotionEffect;

    .line 67
    .line 68
    if-eqz v0, :cond_6

    .line 69
    .line 70
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 71
    .line 72
    if-nez v0, :cond_5

    .line 73
    .line 74
    new-instance v0, Ljava/util/ArrayList;

    .line 75
    .line 76
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 77
    .line 78
    .line 79
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 80
    .line 81
    :cond_5
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->f0:Ljava/util/ArrayList;

    .line 82
    .line 83
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 84
    .line 85
    .line 86
    :cond_6
    return-void
.end method

.method public final onViewRemoved(Landroid/view/View;)V
    .locals 1

    .line 1
    invoke-super {p0, p1}, Landroidx/constraintlayout/widget/ConstraintLayout;->onViewRemoved(Landroid/view/View;)V

    .line 2
    .line 3
    .line 4
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->d0:Ljava/util/ArrayList;

    .line 5
    .line 6
    if-eqz v0, :cond_0

    .line 7
    .line 8
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 9
    .line 10
    .line 11
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->e0:Ljava/util/ArrayList;

    .line 12
    .line 13
    if-eqz v0, :cond_1

    .line 14
    .line 15
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 16
    .line 17
    .line 18
    :cond_1
    return-void
.end method

.method public final r(F)V
    .locals 4

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    return-void

    .line 6
    :cond_0
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 7
    .line 8
    iget v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 9
    .line 10
    cmpl-float v1, v1, v2

    .line 11
    .line 12
    if-eqz v1, :cond_1

    .line 13
    .line 14
    iget-boolean v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->J:Z

    .line 15
    .line 16
    if-eqz v1, :cond_1

    .line 17
    .line 18
    iput v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 19
    .line 20
    :cond_1
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 21
    .line 22
    cmpl-float v2, v1, p1

    .line 23
    .line 24
    if-nez v2, :cond_2

    .line 25
    .line 26
    return-void

    .line 27
    :cond_2
    const/4 v2, 0x0

    .line 28
    iput-boolean v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->O:Z

    .line 29
    .line 30
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 31
    .line 32
    invoke-virtual {v0}, Landroidx/constraintlayout/motion/widget/c;->c()I

    .line 33
    .line 34
    .line 35
    move-result p1

    .line 36
    int-to-float p1, p1

    .line 37
    const/high16 v0, 0x447a0000    # 1000.0f

    .line 38
    .line 39
    div-float/2addr p1, v0

    .line 40
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 41
    .line 42
    iget p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 43
    .line 44
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 45
    .line 46
    .line 47
    const/4 p1, 0x0

    .line 48
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 49
    .line 50
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 51
    .line 52
    invoke-virtual {p1}, Landroidx/constraintlayout/motion/widget/c;->e()Landroid/view/animation/Interpolator;

    .line 53
    .line 54
    .line 55
    move-result-object p1

    .line 56
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u:Landroid/view/animation/Interpolator;

    .line 57
    .line 58
    iput-boolean v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->J:Z

    .line 59
    .line 60
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 61
    .line 62
    .line 63
    move-result-wide v2

    .line 64
    iput-wide v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D:J

    .line 65
    .line 66
    const/4 p1, 0x1

    .line 67
    iput-boolean p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 68
    .line 69
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 70
    .line 71
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 72
    .line 73
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 74
    .line 75
    .line 76
    return-void
.end method

.method public final requestLayout()V
    .locals 4

    .line 1
    iget-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->m0:Z

    .line 2
    .line 3
    if-nez v0, :cond_2

    .line 4
    .line 5
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 6
    .line 7
    const/4 v1, -0x1

    .line 8
    if-ne v0, v1, :cond_2

    .line 9
    .line 10
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 11
    .line 12
    if-eqz v0, :cond_2

    .line 13
    .line 14
    iget-object v0, v0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 15
    .line 16
    if-eqz v0, :cond_2

    .line 17
    .line 18
    iget v0, v0, Lh1/x;->q:I

    .line 19
    .line 20
    if-nez v0, :cond_0

    .line 21
    .line 22
    return-void

    .line 23
    :cond_0
    const/4 v1, 0x2

    .line 24
    if-ne v0, v1, :cond_2

    .line 25
    .line 26
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 27
    .line 28
    .line 29
    move-result v0

    .line 30
    const/4 v1, 0x0

    .line 31
    :goto_0
    if-ge v1, v0, :cond_1

    .line 32
    .line 33
    invoke-virtual {p0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 34
    .line 35
    .line 36
    move-result-object v2

    .line 37
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 38
    .line 39
    invoke-virtual {v3, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 40
    .line 41
    .line 42
    move-result-object v2

    .line 43
    check-cast v2, Lh1/n;

    .line 44
    .line 45
    const/4 v3, 0x1

    .line 46
    iput-boolean v3, v2, Lh1/n;->d:Z

    .line 47
    .line 48
    add-int/lit8 v1, v1, 0x1

    .line 49
    .line 50
    goto :goto_0

    .line 51
    :cond_1
    return-void

    .line 52
    :cond_2
    invoke-super {p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->requestLayout()V

    .line 53
    .line 54
    .line 55
    return-void
.end method

.method public final s()V
    .locals 4

    .line 1
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    const/4 v1, 0x0

    .line 6
    :goto_0
    if-ge v1, v0, :cond_1

    .line 7
    .line 8
    invoke-virtual {p0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 9
    .line 10
    .line 11
    move-result-object v2

    .line 12
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 13
    .line 14
    invoke-virtual {v3, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 15
    .line 16
    .line 17
    move-result-object v2

    .line 18
    check-cast v2, Lh1/n;

    .line 19
    .line 20
    if-eqz v2, :cond_0

    .line 21
    .line 22
    iget-object v2, v2, Lh1/n;->b:Landroid/view/View;

    .line 23
    .line 24
    invoke-static {v2}, Lso/c;->x(Landroid/view/View;)Ljava/lang/String;

    .line 25
    .line 26
    .line 27
    move-result-object v2

    .line 28
    const-string v3, "button"

    .line 29
    .line 30
    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 31
    .line 32
    .line 33
    :cond_0
    add-int/lit8 v1, v1, 0x1

    .line 34
    .line 35
    goto :goto_0

    .line 36
    :cond_1
    return-void
.end method

.method public setDebugMode(I)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 2
    .line 3
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 4
    .line 5
    .line 6
    return-void
.end method

.method public setDelayedApplicationOfInitialState(Z)V
    .locals 0

    .line 1
    iput-boolean p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->z0:Z

    .line 2
    .line 3
    return-void
.end method

.method public setInteractionEnabled(Z)V
    .locals 0

    .line 1
    iput-boolean p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B:Z

    .line 2
    .line 3
    return-void
.end method

.method public setInterpolatedProgress(F)V
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-eqz v0, :cond_0

    .line 4
    .line 5
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 6
    .line 7
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 8
    .line 9
    .line 10
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 11
    .line 12
    invoke-virtual {v0}, Landroidx/constraintlayout/motion/widget/c;->e()Landroid/view/animation/Interpolator;

    .line 13
    .line 14
    .line 15
    move-result-object v0

    .line 16
    if-eqz v0, :cond_0

    .line 17
    .line 18
    invoke-interface {v0, p1}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 19
    .line 20
    .line 21
    move-result p1

    .line 22
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 23
    .line 24
    .line 25
    return-void

    .line 26
    :cond_0
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 27
    .line 28
    .line 29
    return-void
.end method

.method public setOnHide(F)V
    .locals 3

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->e0:Ljava/util/ArrayList;

    .line 2
    .line 3
    if-eqz v0, :cond_0

    .line 4
    .line 5
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    .line 6
    .line 7
    .line 8
    move-result v0

    .line 9
    const/4 v1, 0x0

    .line 10
    :goto_0
    if-ge v1, v0, :cond_0

    .line 11
    .line 12
    iget-object v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->e0:Ljava/util/ArrayList;

    .line 13
    .line 14
    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 15
    .line 16
    .line 17
    move-result-object v2

    .line 18
    check-cast v2, Landroidx/constraintlayout/motion/widget/MotionHelper;

    .line 19
    .line 20
    invoke-virtual {v2, p1}, Landroidx/constraintlayout/motion/widget/MotionHelper;->setProgress(F)V

    .line 21
    .line 22
    .line 23
    add-int/lit8 v1, v1, 0x1

    .line 24
    .line 25
    goto :goto_0

    .line 26
    :cond_0
    return-void
.end method

.method public setOnShow(F)V
    .locals 3

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->d0:Ljava/util/ArrayList;

    .line 2
    .line 3
    if-eqz v0, :cond_0

    .line 4
    .line 5
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    .line 6
    .line 7
    .line 8
    move-result v0

    .line 9
    const/4 v1, 0x0

    .line 10
    :goto_0
    if-ge v1, v0, :cond_0

    .line 11
    .line 12
    iget-object v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->d0:Ljava/util/ArrayList;

    .line 13
    .line 14
    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 15
    .line 16
    .line 17
    move-result-object v2

    .line 18
    check-cast v2, Landroidx/constraintlayout/motion/widget/MotionHelper;

    .line 19
    .line 20
    invoke-virtual {v2, p1}, Landroidx/constraintlayout/motion/widget/MotionHelper;->setProgress(F)V

    .line 21
    .line 22
    .line 23
    add-int/lit8 v1, v1, 0x1

    .line 24
    .line 25
    goto :goto_0

    .line 26
    :cond_0
    return-void
.end method

.method public setProgress(F)V
    .locals 4

    .line 1
    const/4 v0, 0x0

    .line 2
    cmpg-float v1, p1, v0

    .line 3
    .line 4
    const/high16 v2, 0x3f800000    # 1.0f

    .line 5
    .line 6
    if-ltz v1, :cond_0

    .line 7
    .line 8
    cmpl-float v3, p1, v2

    .line 9
    .line 10
    :cond_0
    invoke-super {p0}, Landroid/view/ViewGroup;->isAttachedToWindow()Z

    .line 11
    .line 12
    .line 13
    move-result v3

    .line 14
    if-nez v3, :cond_2

    .line 15
    .line 16
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 17
    .line 18
    if-nez v0, :cond_1

    .line 19
    .line 20
    new-instance v0, Landroidx/constraintlayout/motion/widget/b;

    .line 21
    .line 22
    invoke-direct {v0, p0}, Landroidx/constraintlayout/motion/widget/b;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 23
    .line 24
    .line 25
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 26
    .line 27
    :cond_1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 28
    .line 29
    iput p1, v0, Landroidx/constraintlayout/motion/widget/b;->a:F

    .line 30
    .line 31
    return-void

    .line 32
    :cond_2
    if-gtz v1, :cond_4

    .line 33
    .line 34
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 35
    .line 36
    cmpl-float v1, v1, v2

    .line 37
    .line 38
    if-nez v1, :cond_3

    .line 39
    .line 40
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 41
    .line 42
    iget v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 43
    .line 44
    if-ne v1, v2, :cond_3

    .line 45
    .line 46
    sget-object v1, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 47
    .line 48
    invoke-virtual {p0, v1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 49
    .line 50
    .line 51
    :cond_3
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 52
    .line 53
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 54
    .line 55
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 56
    .line 57
    cmpl-float v0, v1, v0

    .line 58
    .line 59
    if-nez v0, :cond_7

    .line 60
    .line 61
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 62
    .line 63
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 64
    .line 65
    .line 66
    goto :goto_0

    .line 67
    :cond_4
    cmpl-float v1, p1, v2

    .line 68
    .line 69
    if-ltz v1, :cond_6

    .line 70
    .line 71
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 72
    .line 73
    cmpl-float v0, v1, v0

    .line 74
    .line 75
    if-nez v0, :cond_5

    .line 76
    .line 77
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 78
    .line 79
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 80
    .line 81
    if-ne v0, v1, :cond_5

    .line 82
    .line 83
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 84
    .line 85
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 86
    .line 87
    .line 88
    :cond_5
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 89
    .line 90
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 91
    .line 92
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 93
    .line 94
    cmpl-float v0, v0, v2

    .line 95
    .line 96
    if-nez v0, :cond_7

    .line 97
    .line 98
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 99
    .line 100
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 101
    .line 102
    .line 103
    goto :goto_0

    .line 104
    :cond_6
    const/4 v0, -0x1

    .line 105
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 106
    .line 107
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 108
    .line 109
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 110
    .line 111
    .line 112
    :cond_7
    :goto_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 113
    .line 114
    if-nez v0, :cond_8

    .line 115
    .line 116
    return-void

    .line 117
    :cond_8
    const/4 v0, 0x1

    .line 118
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->J:Z

    .line 119
    .line 120
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 121
    .line 122
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 123
    .line 124
    const-wide/16 v1, -0x1

    .line 125
    .line 126
    iput-wide v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H:J

    .line 127
    .line 128
    iput-wide v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D:J

    .line 129
    .line 130
    const/4 p1, 0x0

    .line 131
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 132
    .line 133
    iput-boolean v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 134
    .line 135
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 136
    .line 137
    .line 138
    return-void
.end method

.method public setScene(Landroidx/constraintlayout/motion/widget/c;)V
    .locals 1

    .line 1
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    invoke-virtual {p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->l()Z

    .line 4
    .line 5
    .line 6
    move-result v0

    .line 7
    iput-boolean v0, p1, Landroidx/constraintlayout/motion/widget/c;->p:Z

    .line 8
    .line 9
    iget-object p1, p1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 10
    .line 11
    if-eqz p1, :cond_0

    .line 12
    .line 13
    iget-object p1, p1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 14
    .line 15
    if-eqz p1, :cond_0

    .line 16
    .line 17
    invoke-virtual {p1, v0}, Landroidx/constraintlayout/motion/widget/d;->c(Z)V

    .line 18
    .line 19
    .line 20
    :cond_0
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->C()V

    .line 21
    .line 22
    .line 23
    return-void
.end method

.method public setStartState(I)V
    .locals 1

    .line 1
    invoke-super {p0}, Landroid/view/ViewGroup;->isAttachedToWindow()Z

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    if-nez v0, :cond_1

    .line 6
    .line 7
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 8
    .line 9
    if-nez v0, :cond_0

    .line 10
    .line 11
    new-instance v0, Landroidx/constraintlayout/motion/widget/b;

    .line 12
    .line 13
    invoke-direct {v0, p0}, Landroidx/constraintlayout/motion/widget/b;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 14
    .line 15
    .line 16
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 17
    .line 18
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 19
    .line 20
    iput p1, v0, Landroidx/constraintlayout/motion/widget/b;->c:I

    .line 21
    .line 22
    iput p1, v0, Landroidx/constraintlayout/motion/widget/b;->d:I

    .line 23
    .line 24
    return-void

    .line 25
    :cond_1
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 26
    .line 27
    return-void
.end method

.method public setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V
    .locals 4

    .line 1
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 2
    .line 3
    if-ne p1, v0, :cond_0

    .line 4
    .line 5
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 6
    .line 7
    const/4 v2, -0x1

    .line 8
    if-ne v1, v2, :cond_0

    .line 9
    .line 10
    return-void

    .line 11
    :cond_0
    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->A0:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 12
    .line 13
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->A0:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 14
    .line 15
    sget-object v2, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 16
    .line 17
    if-ne v1, v2, :cond_1

    .line 18
    .line 19
    if-ne p1, v2, :cond_1

    .line 20
    .line 21
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->u()V

    .line 22
    .line 23
    .line 24
    :cond_1
    sget-object v3, Landroidx/constraintlayout/motion/widget/a;->a:[I

    .line 25
    .line 26
    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    .line 27
    .line 28
    .line 29
    move-result v1

    .line 30
    aget v1, v3, v1

    .line 31
    .line 32
    const/4 v3, 0x1

    .line 33
    if-eq v1, v3, :cond_3

    .line 34
    .line 35
    const/4 v3, 0x2

    .line 36
    if-eq v1, v3, :cond_3

    .line 37
    .line 38
    const/4 v2, 0x3

    .line 39
    if-eq v1, v2, :cond_2

    .line 40
    .line 41
    goto :goto_0

    .line 42
    :cond_2
    if-ne p1, v0, :cond_5

    .line 43
    .line 44
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->v()V

    .line 45
    .line 46
    .line 47
    goto :goto_0

    .line 48
    :cond_3
    if-ne p1, v2, :cond_4

    .line 49
    .line 50
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->u()V

    .line 51
    .line 52
    .line 53
    :cond_4
    if-ne p1, v0, :cond_5

    .line 54
    .line 55
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->v()V

    .line 56
    .line 57
    .line 58
    :cond_5
    :goto_0
    return-void
.end method

.method public setTransition(I)V
    .locals 5

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    if-eqz v0, :cond_9

    .line 2
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->x(I)Lh1/x;

    move-result-object p1

    .line 3
    iget v0, p1, Lh1/x;->d:I

    .line 4
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 5
    iget v0, p1, Lh1/x;->c:I

    .line 6
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 7
    invoke-super {p0}, Landroid/view/ViewGroup;->isAttachedToWindow()Z

    move-result v0

    if-nez v0, :cond_1

    .line 8
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    if-nez p1, :cond_0

    .line 9
    new-instance p1, Landroidx/constraintlayout/motion/widget/b;

    invoke-direct {p1, p0}, Landroidx/constraintlayout/motion/widget/b;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 10
    :cond_0
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 11
    iput v0, p1, Landroidx/constraintlayout/motion/widget/b;->c:I

    .line 12
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 13
    iput v0, p1, Landroidx/constraintlayout/motion/widget/b;->d:I

    return-void

    .line 14
    :cond_1
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    const/4 v2, 0x0

    const/high16 v3, 0x3f800000    # 1.0f

    if-ne v0, v1, :cond_2

    move v0, v2

    goto :goto_0

    .line 15
    :cond_2
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    if-ne v0, v1, :cond_3

    move v0, v3

    goto :goto_0

    :cond_3
    const/high16 v0, 0x7fc00000    # Float.NaN

    .line 16
    :goto_0
    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 17
    iput-object p1, v1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 18
    iget-object p1, p1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    if-eqz p1, :cond_4

    .line 19
    iget-boolean v1, v1, Landroidx/constraintlayout/motion/widget/c;->p:Z

    invoke-virtual {p1, v1}, Landroidx/constraintlayout/motion/widget/d;->c(Z)V

    .line 20
    :cond_4
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    invoke-virtual {p1, v1}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    move-result-object p1

    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    iget v4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    invoke-virtual {v1, v4}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    move-result-object v1

    iget-object v4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B0:Lh1/s;

    invoke-virtual {v4, p1, v1}, Lh1/s;->e(Landroidx/constraintlayout/widget/d;Landroidx/constraintlayout/widget/d;)V

    .line 21
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->C()V

    .line 22
    iget p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    cmpl-float p1, p1, v0

    if-eqz p1, :cond_6

    cmpl-float p1, v0, v2

    if-nez p1, :cond_5

    .line 23
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->s()V

    .line 24
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    invoke-virtual {p1, v1}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroidx/constraintlayout/widget/d;->b(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    goto :goto_1

    :cond_5
    cmpl-float p1, v0, v3

    if-nez p1, :cond_6

    .line 25
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->s()V

    .line 26
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    invoke-virtual {p1, v1}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroidx/constraintlayout/widget/d;->b(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 27
    :cond_6
    :goto_1
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    move-result p1

    if-eqz p1, :cond_7

    move p1, v2

    goto :goto_2

    :cond_7
    move p1, v0

    :goto_2
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 28
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    move-result p1

    if-eqz p1, :cond_8

    .line 29
    invoke-static {}, Lso/c;->v()Ljava/lang/String;

    .line 30
    invoke-virtual {p0, v2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    goto :goto_3

    .line 31
    :cond_8
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    :cond_9
    :goto_3
    return-void
.end method

.method public setTransition(Lh1/x;)V
    .locals 3

    .line 32
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 33
    iput-object p1, v0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    if-eqz p1, :cond_0

    .line 34
    iget-object v1, p1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    if-eqz v1, :cond_0

    .line 35
    iget-boolean v0, v0, Landroidx/constraintlayout/motion/widget/c;->p:Z

    invoke-virtual {v1, v0}, Landroidx/constraintlayout/motion/widget/d;->c(Z)V

    .line 36
    :cond_0
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->SETUP:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    invoke-virtual {p0, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 37
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 38
    iget-object v1, v1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    const/4 v2, -0x1

    if-nez v1, :cond_1

    move v1, v2

    goto :goto_0

    .line 39
    :cond_1
    iget v1, v1, Lh1/x;->c:I

    :goto_0
    if-ne v0, v1, :cond_2

    const/high16 v0, 0x3f800000    # 1.0f

    .line 40
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 41
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 42
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    .line 43
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 44
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 45
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 46
    :goto_1
    iget p1, p1, Lh1/x;->r:I

    and-int/lit8 p1, p1, 0x1

    if-eqz p1, :cond_3

    const-wide/16 v0, -0x1

    goto :goto_2

    .line 47
    :cond_3
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    move-result-wide v0

    :goto_2
    iput-wide v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H:J

    .line 48
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    invoke-virtual {p1}, Landroidx/constraintlayout/motion/widget/c;->h()I

    move-result p1

    .line 49
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 50
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    if-nez v1, :cond_4

    goto :goto_3

    .line 51
    :cond_4
    iget v2, v1, Lh1/x;->c:I

    .line 52
    :goto_3
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    if-ne p1, v1, :cond_5

    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    if-ne v2, v1, :cond_5

    return-void

    .line 53
    :cond_5
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 54
    iput v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 55
    invoke-virtual {v0, p1, v2}, Landroidx/constraintlayout/motion/widget/c;->n(II)V

    .line 56
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    invoke-virtual {p1, v0}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    move-result-object p1

    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    invoke-virtual {v0, v1}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    move-result-object v0

    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->B0:Lh1/s;

    invoke-virtual {v1, p1, v0}, Lh1/s;->e(Landroidx/constraintlayout/widget/d;Landroidx/constraintlayout/widget/d;)V

    .line 57
    iget p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 58
    iput p1, v1, Lh1/s;->e:I

    .line 59
    iput v0, v1, Lh1/s;->f:I

    .line 60
    invoke-virtual {v1}, Lh1/s;->f()V

    .line 61
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->C()V

    return-void
.end method

.method public setTransitionDuration(I)V
    .locals 2

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    const-string p1, "MotionLayout"

    .line 6
    .line 7
    const-string v0, "MotionScene not defined"

    .line 8
    .line 9
    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 10
    .line 11
    .line 12
    return-void

    .line 13
    :cond_0
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 14
    .line 15
    if-eqz v1, :cond_1

    .line 16
    .line 17
    const/16 v0, 0x8

    .line 18
    .line 19
    invoke-static {p1, v0}, Ljava/lang/Math;->max(II)I

    .line 20
    .line 21
    .line 22
    move-result p1

    .line 23
    iput p1, v1, Lh1/x;->h:I

    .line 24
    .line 25
    goto :goto_0

    .line 26
    :cond_1
    iput p1, v0, Landroidx/constraintlayout/motion/widget/c;->j:I

    .line 27
    .line 28
    :goto_0
    return-void
.end method

.method public setTransitionListener(Lh1/u;)V
    .locals 0

    .line 1
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->L:Lh1/u;

    .line 2
    .line 3
    return-void
.end method

.method public setTransitionState(Landroid/os/Bundle;)V
    .locals 2

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    new-instance v0, Landroidx/constraintlayout/motion/widget/b;

    .line 6
    .line 7
    invoke-direct {v0, p0}, Landroidx/constraintlayout/motion/widget/b;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 8
    .line 9
    .line 10
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 11
    .line 12
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 13
    .line 14
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 15
    .line 16
    .line 17
    const-string v1, "motion.progress"

    .line 18
    .line 19
    invoke-virtual {p1, v1}, Landroid/os/Bundle;->getFloat(Ljava/lang/String;)F

    .line 20
    .line 21
    .line 22
    move-result v1

    .line 23
    iput v1, v0, Landroidx/constraintlayout/motion/widget/b;->a:F

    .line 24
    .line 25
    const-string v1, "motion.velocity"

    .line 26
    .line 27
    invoke-virtual {p1, v1}, Landroid/os/Bundle;->getFloat(Ljava/lang/String;)F

    .line 28
    .line 29
    .line 30
    move-result v1

    .line 31
    iput v1, v0, Landroidx/constraintlayout/motion/widget/b;->b:F

    .line 32
    .line 33
    const-string v1, "motion.StartState"

    .line 34
    .line 35
    invoke-virtual {p1, v1}, Landroid/os/BaseBundle;->getInt(Ljava/lang/String;)I

    .line 36
    .line 37
    .line 38
    move-result v1

    .line 39
    iput v1, v0, Landroidx/constraintlayout/motion/widget/b;->c:I

    .line 40
    .line 41
    const-string v1, "motion.EndState"

    .line 42
    .line 43
    invoke-virtual {p1, v1}, Landroid/os/BaseBundle;->getInt(Ljava/lang/String;)I

    .line 44
    .line 45
    .line 46
    move-result p1

    .line 47
    iput p1, v0, Landroidx/constraintlayout/motion/widget/b;->d:I

    .line 48
    .line 49
    invoke-super {p0}, Landroid/view/ViewGroup;->isAttachedToWindow()Z

    .line 50
    .line 51
    .line 52
    move-result p1

    .line 53
    if-eqz p1, :cond_1

    .line 54
    .line 55
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w0:Landroidx/constraintlayout/motion/widget/b;

    .line 56
    .line 57
    invoke-virtual {p1}, Landroidx/constraintlayout/motion/widget/b;->a()V

    .line 58
    .line 59
    .line 60
    :cond_1
    return-void
.end method

.method public final t(Z)V
    .locals 22

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    iget-wide v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H:J

    .line 4
    .line 5
    const-wide/16 v3, -0x1

    .line 6
    .line 7
    cmp-long v1, v1, v3

    .line 8
    .line 9
    if-nez v1, :cond_0

    .line 10
    .line 11
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 12
    .line 13
    .line 14
    move-result-wide v1

    .line 15
    iput-wide v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H:J

    .line 16
    .line 17
    :cond_0
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 18
    .line 19
    const/4 v2, 0x0

    .line 20
    cmpl-float v3, v1, v2

    .line 21
    .line 22
    const/4 v4, -0x1

    .line 23
    const/high16 v5, 0x3f800000    # 1.0f

    .line 24
    .line 25
    if-lez v3, :cond_1

    .line 26
    .line 27
    cmpg-float v3, v1, v5

    .line 28
    .line 29
    if-gez v3, :cond_1

    .line 30
    .line 31
    iput v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 32
    .line 33
    :cond_1
    iget-boolean v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 34
    .line 35
    const/4 v6, 0x1

    .line 36
    const/4 v7, 0x0

    .line 37
    if-nez v3, :cond_2

    .line 38
    .line 39
    iget-boolean v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 40
    .line 41
    if-eqz v3, :cond_28

    .line 42
    .line 43
    if-nez p1, :cond_2

    .line 44
    .line 45
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 46
    .line 47
    cmpl-float v3, v3, v1

    .line 48
    .line 49
    if-eqz v3, :cond_28

    .line 50
    .line 51
    :cond_2
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 52
    .line 53
    sub-float/2addr v3, v1

    .line 54
    invoke-static {v3}, Ljava/lang/Math;->signum(F)F

    .line 55
    .line 56
    .line 57
    move-result v1

    .line 58
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 59
    .line 60
    .line 61
    move-result-wide v8

    .line 62
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 63
    .line 64
    instance-of v10, v3, Lh1/o;

    .line 65
    .line 66
    const v11, 0x3089705f    # 1.0E-9f

    .line 67
    .line 68
    .line 69
    if-nez v10, :cond_3

    .line 70
    .line 71
    iget-wide v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H:J

    .line 72
    .line 73
    sub-long v12, v8, v12

    .line 74
    .line 75
    long-to-float v10, v12

    .line 76
    mul-float/2addr v10, v1

    .line 77
    mul-float/2addr v10, v11

    .line 78
    iget v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 79
    .line 80
    div-float/2addr v10, v12

    .line 81
    goto :goto_0

    .line 82
    :cond_3
    move v10, v2

    .line 83
    :goto_0
    iget v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 84
    .line 85
    add-float/2addr v12, v10

    .line 86
    iget-boolean v13, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->J:Z

    .line 87
    .line 88
    if-eqz v13, :cond_4

    .line 89
    .line 90
    iget v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 91
    .line 92
    :cond_4
    cmpl-float v13, v1, v2

    .line 93
    .line 94
    if-lez v13, :cond_5

    .line 95
    .line 96
    iget v14, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 97
    .line 98
    cmpl-float v14, v12, v14

    .line 99
    .line 100
    if-gez v14, :cond_6

    .line 101
    .line 102
    :cond_5
    cmpg-float v14, v1, v2

    .line 103
    .line 104
    if-gtz v14, :cond_7

    .line 105
    .line 106
    iget v14, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 107
    .line 108
    cmpg-float v14, v12, v14

    .line 109
    .line 110
    if-gtz v14, :cond_7

    .line 111
    .line 112
    :cond_6
    iget v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 113
    .line 114
    iput-boolean v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 115
    .line 116
    move v14, v6

    .line 117
    goto :goto_1

    .line 118
    :cond_7
    move v14, v7

    .line 119
    :goto_1
    iput v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 120
    .line 121
    iput v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 122
    .line 123
    iput-wide v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H:J

    .line 124
    .line 125
    const v15, 0x3727c5ac    # 1.0E-5f

    .line 126
    .line 127
    .line 128
    if-eqz v3, :cond_f

    .line 129
    .line 130
    if-nez v14, :cond_f

    .line 131
    .line 132
    iget-boolean v14, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->O:Z

    .line 133
    .line 134
    if-eqz v14, :cond_d

    .line 135
    .line 136
    iget-wide v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D:J

    .line 137
    .line 138
    sub-long v4, v8, v4

    .line 139
    .line 140
    long-to-float v4, v4

    .line 141
    mul-float/2addr v4, v11

    .line 142
    invoke-interface {v3, v4}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 143
    .line 144
    .line 145
    move-result v3

    .line 146
    iget-object v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 147
    .line 148
    iget-object v5, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->P:Lg1/b;

    .line 149
    .line 150
    const/4 v10, 0x2

    .line 151
    if-ne v4, v5, :cond_9

    .line 152
    .line 153
    iget-object v4, v5, Lg1/b;->c:Lb1/l;

    .line 154
    .line 155
    invoke-interface {v4}, Lb1/l;->b()Z

    .line 156
    .line 157
    .line 158
    move-result v4

    .line 159
    if-eqz v4, :cond_8

    .line 160
    .line 161
    move v4, v10

    .line 162
    goto :goto_2

    .line 163
    :cond_8
    move v4, v6

    .line 164
    goto :goto_2

    .line 165
    :cond_9
    move v4, v7

    .line 166
    :goto_2
    iput v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 167
    .line 168
    iput-wide v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H:J

    .line 169
    .line 170
    iget-object v5, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 171
    .line 172
    instance-of v8, v5, Lh1/o;

    .line 173
    .line 174
    if-eqz v8, :cond_c

    .line 175
    .line 176
    invoke-virtual {v5}, Lh1/o;->a()F

    .line 177
    .line 178
    .line 179
    move-result v5

    .line 180
    iput v5, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 181
    .line 182
    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    .line 183
    .line 184
    .line 185
    move-result v8

    .line 186
    iget v9, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 187
    .line 188
    mul-float/2addr v8, v9

    .line 189
    cmpg-float v8, v8, v15

    .line 190
    .line 191
    if-gtz v8, :cond_a

    .line 192
    .line 193
    if-ne v4, v10, :cond_a

    .line 194
    .line 195
    iput-boolean v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 196
    .line 197
    :cond_a
    cmpl-float v8, v5, v2

    .line 198
    .line 199
    if-lez v8, :cond_b

    .line 200
    .line 201
    const/high16 v8, 0x3f800000    # 1.0f

    .line 202
    .line 203
    cmpl-float v9, v3, v8

    .line 204
    .line 205
    if-ltz v9, :cond_b

    .line 206
    .line 207
    iput v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 208
    .line 209
    iput-boolean v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 210
    .line 211
    const/high16 v3, 0x3f800000    # 1.0f

    .line 212
    .line 213
    :cond_b
    cmpg-float v5, v5, v2

    .line 214
    .line 215
    if-gez v5, :cond_c

    .line 216
    .line 217
    cmpg-float v5, v3, v2

    .line 218
    .line 219
    if-gtz v5, :cond_c

    .line 220
    .line 221
    iput v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 222
    .line 223
    iput-boolean v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 224
    .line 225
    move v12, v2

    .line 226
    goto :goto_5

    .line 227
    :cond_c
    move v12, v3

    .line 228
    goto :goto_5

    .line 229
    :cond_d
    invoke-interface {v3, v12}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 230
    .line 231
    .line 232
    move-result v3

    .line 233
    iget-object v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 234
    .line 235
    instance-of v5, v4, Lh1/o;

    .line 236
    .line 237
    if-eqz v5, :cond_e

    .line 238
    .line 239
    invoke-virtual {v4}, Lh1/o;->a()F

    .line 240
    .line 241
    .line 242
    move-result v4

    .line 243
    iput v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 244
    .line 245
    goto :goto_3

    .line 246
    :cond_e
    add-float/2addr v12, v10

    .line 247
    invoke-interface {v4, v12}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 248
    .line 249
    .line 250
    move-result v4

    .line 251
    sub-float/2addr v4, v3

    .line 252
    mul-float/2addr v4, v1

    .line 253
    div-float/2addr v4, v10

    .line 254
    iput v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 255
    .line 256
    :goto_3
    move v12, v3

    .line 257
    :goto_4
    move v4, v7

    .line 258
    goto :goto_5

    .line 259
    :cond_f
    iput v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 260
    .line 261
    goto :goto_4

    .line 262
    :goto_5
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 263
    .line 264
    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    .line 265
    .line 266
    .line 267
    move-result v3

    .line 268
    cmpl-float v3, v3, v15

    .line 269
    .line 270
    if-lez v3, :cond_10

    .line 271
    .line 272
    sget-object v3, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 273
    .line 274
    invoke-virtual {v0, v3}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 275
    .line 276
    .line 277
    :cond_10
    if-eq v4, v6, :cond_15

    .line 278
    .line 279
    if-lez v13, :cond_11

    .line 280
    .line 281
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 282
    .line 283
    cmpl-float v3, v12, v3

    .line 284
    .line 285
    if-gez v3, :cond_12

    .line 286
    .line 287
    :cond_11
    cmpg-float v3, v1, v2

    .line 288
    .line 289
    if-gtz v3, :cond_13

    .line 290
    .line 291
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 292
    .line 293
    cmpg-float v3, v12, v3

    .line 294
    .line 295
    if-gtz v3, :cond_13

    .line 296
    .line 297
    :cond_12
    iget v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 298
    .line 299
    iput-boolean v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 300
    .line 301
    :cond_13
    const/high16 v3, 0x3f800000    # 1.0f

    .line 302
    .line 303
    cmpl-float v4, v12, v3

    .line 304
    .line 305
    if-gez v4, :cond_14

    .line 306
    .line 307
    cmpg-float v3, v12, v2

    .line 308
    .line 309
    if-gtz v3, :cond_15

    .line 310
    .line 311
    :cond_14
    iput-boolean v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 312
    .line 313
    sget-object v3, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 314
    .line 315
    invoke-virtual {v0, v3}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 316
    .line 317
    .line 318
    :cond_15
    invoke-virtual/range {p0 .. p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 319
    .line 320
    .line 321
    move-result v3

    .line 322
    iput-boolean v7, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 323
    .line 324
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->getNanoTime()J

    .line 325
    .line 326
    .line 327
    move-result-wide v4

    .line 328
    iput v12, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->t0:F

    .line 329
    .line 330
    iget-object v8, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u:Landroid/view/animation/Interpolator;

    .line 331
    .line 332
    if-nez v8, :cond_16

    .line 333
    .line 334
    move v8, v12

    .line 335
    goto :goto_6

    .line 336
    :cond_16
    invoke-interface {v8, v12}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 337
    .line 338
    .line 339
    move-result v8

    .line 340
    :goto_6
    iget-object v9, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u:Landroid/view/animation/Interpolator;

    .line 341
    .line 342
    if-eqz v9, :cond_17

    .line 343
    .line 344
    iget v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 345
    .line 346
    div-float v10, v1, v10

    .line 347
    .line 348
    add-float/2addr v10, v12

    .line 349
    invoke-interface {v9, v10}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 350
    .line 351
    .line 352
    move-result v9

    .line 353
    iput v9, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 354
    .line 355
    iget-object v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u:Landroid/view/animation/Interpolator;

    .line 356
    .line 357
    invoke-interface {v10, v12}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 358
    .line 359
    .line 360
    move-result v10

    .line 361
    sub-float/2addr v9, v10

    .line 362
    iput v9, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 363
    .line 364
    :cond_17
    move v9, v7

    .line 365
    :goto_7
    if-ge v9, v3, :cond_19

    .line 366
    .line 367
    invoke-virtual {v0, v9}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 368
    .line 369
    .line 370
    move-result-object v10

    .line 371
    iget-object v11, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 372
    .line 373
    invoke-virtual {v11, v10}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 374
    .line 375
    .line 376
    move-result-object v11

    .line 377
    move-object/from16 v16, v11

    .line 378
    .line 379
    check-cast v16, Lh1/n;

    .line 380
    .line 381
    if-eqz v16, :cond_18

    .line 382
    .line 383
    iget-boolean v11, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 384
    .line 385
    iget-object v15, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->u0:Lb1/e;

    .line 386
    .line 387
    move/from16 v17, v8

    .line 388
    .line 389
    move-wide/from16 v18, v4

    .line 390
    .line 391
    move-object/from16 v20, v10

    .line 392
    .line 393
    move-object/from16 v21, v15

    .line 394
    .line 395
    invoke-virtual/range {v16 .. v21}, Lh1/n;->e(FJLandroid/view/View;Lb1/e;)Z

    .line 396
    .line 397
    .line 398
    move-result v10

    .line 399
    or-int/2addr v10, v11

    .line 400
    iput-boolean v10, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 401
    .line 402
    :cond_18
    add-int/lit8 v9, v9, 0x1

    .line 403
    .line 404
    goto :goto_7

    .line 405
    :cond_19
    if-lez v13, :cond_1a

    .line 406
    .line 407
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 408
    .line 409
    cmpl-float v3, v12, v3

    .line 410
    .line 411
    if-gez v3, :cond_1b

    .line 412
    .line 413
    :cond_1a
    cmpg-float v3, v1, v2

    .line 414
    .line 415
    if-gtz v3, :cond_1c

    .line 416
    .line 417
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 418
    .line 419
    cmpg-float v3, v12, v3

    .line 420
    .line 421
    if-gtz v3, :cond_1c

    .line 422
    .line 423
    :cond_1b
    move v3, v6

    .line 424
    goto :goto_8

    .line 425
    :cond_1c
    move v3, v7

    .line 426
    :goto_8
    iget-boolean v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 427
    .line 428
    if-nez v4, :cond_1d

    .line 429
    .line 430
    iget-boolean v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 431
    .line 432
    if-nez v4, :cond_1d

    .line 433
    .line 434
    if-eqz v3, :cond_1d

    .line 435
    .line 436
    sget-object v4, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 437
    .line 438
    invoke-virtual {v0, v4}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 439
    .line 440
    .line 441
    :cond_1d
    iget-boolean v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->m0:Z

    .line 442
    .line 443
    if-eqz v4, :cond_1e

    .line 444
    .line 445
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->requestLayout()V

    .line 446
    .line 447
    .line 448
    :cond_1e
    iget-boolean v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 449
    .line 450
    xor-int/2addr v3, v6

    .line 451
    or-int/2addr v3, v4

    .line 452
    iput-boolean v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 453
    .line 454
    cmpg-float v3, v12, v2

    .line 455
    .line 456
    if-gtz v3, :cond_1f

    .line 457
    .line 458
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 459
    .line 460
    const/4 v4, -0x1

    .line 461
    if-eq v3, v4, :cond_1f

    .line 462
    .line 463
    iget v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 464
    .line 465
    if-eq v4, v3, :cond_1f

    .line 466
    .line 467
    iput v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 468
    .line 469
    iget-object v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 470
    .line 471
    invoke-virtual {v4, v3}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 472
    .line 473
    .line 474
    move-result-object v3

    .line 475
    invoke-virtual {v3, v0}, Landroidx/constraintlayout/widget/d;->a(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 476
    .line 477
    .line 478
    sget-object v3, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 479
    .line 480
    invoke-virtual {v0, v3}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 481
    .line 482
    .line 483
    move v7, v6

    .line 484
    :cond_1f
    float-to-double v3, v12

    .line 485
    const-wide/high16 v8, 0x3ff0000000000000L    # 1.0

    .line 486
    .line 487
    cmpl-double v3, v3, v8

    .line 488
    .line 489
    if-ltz v3, :cond_20

    .line 490
    .line 491
    iget v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 492
    .line 493
    iget v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 494
    .line 495
    if-eq v3, v4, :cond_20

    .line 496
    .line 497
    iput v4, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 498
    .line 499
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 500
    .line 501
    invoke-virtual {v3, v4}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 502
    .line 503
    .line 504
    move-result-object v3

    .line 505
    invoke-virtual {v3, v0}, Landroidx/constraintlayout/widget/d;->a(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 506
    .line 507
    .line 508
    sget-object v3, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 509
    .line 510
    invoke-virtual {v0, v3}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 511
    .line 512
    .line 513
    move v7, v6

    .line 514
    :cond_20
    iget-boolean v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 515
    .line 516
    if-nez v3, :cond_24

    .line 517
    .line 518
    iget-boolean v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 519
    .line 520
    if-eqz v3, :cond_21

    .line 521
    .line 522
    goto :goto_9

    .line 523
    :cond_21
    if-lez v13, :cond_22

    .line 524
    .line 525
    const/high16 v3, 0x3f800000    # 1.0f

    .line 526
    .line 527
    cmpl-float v4, v12, v3

    .line 528
    .line 529
    if-eqz v4, :cond_23

    .line 530
    .line 531
    :cond_22
    cmpg-float v3, v1, v2

    .line 532
    .line 533
    if-gez v3, :cond_25

    .line 534
    .line 535
    cmpl-float v3, v12, v2

    .line 536
    .line 537
    if-nez v3, :cond_25

    .line 538
    .line 539
    :cond_23
    sget-object v3, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 540
    .line 541
    invoke-virtual {v0, v3}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 542
    .line 543
    .line 544
    goto :goto_a

    .line 545
    :cond_24
    :goto_9
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->invalidate()V

    .line 546
    .line 547
    .line 548
    :cond_25
    :goto_a
    iget-boolean v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->c0:Z

    .line 549
    .line 550
    if-nez v3, :cond_28

    .line 551
    .line 552
    iget-boolean v3, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 553
    .line 554
    if-nez v3, :cond_28

    .line 555
    .line 556
    if-lez v13, :cond_26

    .line 557
    .line 558
    const/high16 v3, 0x3f800000    # 1.0f

    .line 559
    .line 560
    cmpl-float v4, v12, v3

    .line 561
    .line 562
    if-eqz v4, :cond_27

    .line 563
    .line 564
    :cond_26
    cmpg-float v1, v1, v2

    .line 565
    .line 566
    if-gez v1, :cond_28

    .line 567
    .line 568
    cmpl-float v1, v12, v2

    .line 569
    .line 570
    if-nez v1, :cond_28

    .line 571
    .line 572
    :cond_27
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->A()V

    .line 573
    .line 574
    .line 575
    :cond_28
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 576
    .line 577
    const/high16 v3, 0x3f800000    # 1.0f

    .line 578
    .line 579
    cmpl-float v3, v1, v3

    .line 580
    .line 581
    if-ltz v3, :cond_2a

    .line 582
    .line 583
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 584
    .line 585
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 586
    .line 587
    if-eq v1, v2, :cond_29

    .line 588
    .line 589
    goto :goto_b

    .line 590
    :cond_29
    move v6, v7

    .line 591
    :goto_b
    iput v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 592
    .line 593
    :goto_c
    move v7, v6

    .line 594
    goto :goto_e

    .line 595
    :cond_2a
    cmpg-float v1, v1, v2

    .line 596
    .line 597
    if-gtz v1, :cond_2c

    .line 598
    .line 599
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 600
    .line 601
    iget v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 602
    .line 603
    if-eq v1, v2, :cond_2b

    .line 604
    .line 605
    goto :goto_d

    .line 606
    :cond_2b
    move v6, v7

    .line 607
    :goto_d
    iput v2, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 608
    .line 609
    goto :goto_c

    .line 610
    :cond_2c
    :goto_e
    iget-boolean v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C0:Z

    .line 611
    .line 612
    or-int/2addr v1, v7

    .line 613
    iput-boolean v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C0:Z

    .line 614
    .line 615
    if-eqz v7, :cond_2d

    .line 616
    .line 617
    iget-boolean v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v0:Z

    .line 618
    .line 619
    if-nez v1, :cond_2d

    .line 620
    .line 621
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->requestLayout()V

    .line 622
    .line 623
    .line 624
    :cond_2d
    iget v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 625
    .line 626
    iput v1, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 627
    .line 628
    return-void
.end method

.method public final toString()Ljava/lang/String;
    .locals 3

    .line 1
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    new-instance v1, Ljava/lang/StringBuilder;

    .line 6
    .line 7
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 8
    .line 9
    .line 10
    iget v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 11
    .line 12
    invoke-static {v0, v2}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 13
    .line 14
    .line 15
    move-result-object v2

    .line 16
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 17
    .line 18
    .line 19
    const-string v2, "->"

    .line 20
    .line 21
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 22
    .line 23
    .line 24
    iget v2, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 25
    .line 26
    invoke-static {v0, v2}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 27
    .line 28
    .line 29
    move-result-object v0

    .line 30
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 31
    .line 32
    .line 33
    const-string v0, " (pos:"

    .line 34
    .line 35
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 36
    .line 37
    .line 38
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 39
    .line 40
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    .line 41
    .line 42
    .line 43
    const-string v0, " Dpos/Dt:"

    .line 44
    .line 45
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 46
    .line 47
    .line 48
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 49
    .line 50
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    .line 51
    .line 52
    .line 53
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 54
    .line 55
    .line 56
    move-result-object v0

    .line 57
    return-object v0
.end method

.method public final u()V
    .locals 3

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->L:Lh1/u;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 6
    .line 7
    if-eqz v0, :cond_2

    .line 8
    .line 9
    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    .line 10
    .line 11
    .line 12
    move-result v0

    .line 13
    if-nez v0, :cond_2

    .line 14
    .line 15
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->l0:F

    .line 16
    .line 17
    iget v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 18
    .line 19
    cmpl-float v0, v0, v1

    .line 20
    .line 21
    if-eqz v0, :cond_2

    .line 22
    .line 23
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->k0:I

    .line 24
    .line 25
    const/4 v1, -0x1

    .line 26
    if-eq v0, v1, :cond_1

    .line 27
    .line 28
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 29
    .line 30
    if-eqz v0, :cond_1

    .line 31
    .line 32
    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    .line 33
    .line 34
    .line 35
    move-result-object v0

    .line 36
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 37
    .line 38
    .line 39
    move-result v2

    .line 40
    if-eqz v2, :cond_1

    .line 41
    .line 42
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 43
    .line 44
    .line 45
    move-result-object v2

    .line 46
    check-cast v2, Lh1/u;

    .line 47
    .line 48
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 49
    .line 50
    .line 51
    goto :goto_0

    .line 52
    :cond_1
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->k0:I

    .line 53
    .line 54
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F:F

    .line 55
    .line 56
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->l0:F

    .line 57
    .line 58
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 59
    .line 60
    if-eqz v0, :cond_2

    .line 61
    .line 62
    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    .line 63
    .line 64
    .line 65
    move-result-object v0

    .line 66
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 67
    .line 68
    .line 69
    move-result v1

    .line 70
    if-eqz v1, :cond_2

    .line 71
    .line 72
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 73
    .line 74
    .line 75
    move-result-object v1

    .line 76
    check-cast v1, Lh1/u;

    .line 77
    .line 78
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 79
    .line 80
    .line 81
    goto :goto_1

    .line 82
    :cond_2
    return-void
.end method

.method public final v()V
    .locals 4

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->L:Lh1/u;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->g0:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 6
    .line 7
    if-eqz v0, :cond_2

    .line 8
    .line 9
    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    .line 10
    .line 11
    .line 12
    move-result v0

    .line 13
    if-nez v0, :cond_2

    .line 14
    .line 15
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->k0:I

    .line 16
    .line 17
    const/4 v1, -0x1

    .line 18
    if-ne v0, v1, :cond_2

    .line 19
    .line 20
    iget v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 21
    .line 22
    iput v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->k0:I

    .line 23
    .line 24
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->G0:Ljava/util/ArrayList;

    .line 25
    .line 26
    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    .line 27
    .line 28
    .line 29
    move-result v2

    .line 30
    if-nez v2, :cond_1

    .line 31
    .line 32
    const/4 v2, 0x1

    .line 33
    invoke-static {v2, v0}, Lcom/newleaf/app/android/victor/common/m;->i(ILjava/util/ArrayList;)Ljava/lang/Object;

    .line 34
    .line 35
    .line 36
    move-result-object v2

    .line 37
    check-cast v2, Ljava/lang/Integer;

    .line 38
    .line 39
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    .line 40
    .line 41
    .line 42
    move-result v2

    .line 43
    goto :goto_0

    .line 44
    :cond_1
    move v2, v1

    .line 45
    :goto_0
    iget v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 46
    .line 47
    if-eq v2, v3, :cond_2

    .line 48
    .line 49
    if-eq v3, v1, :cond_2

    .line 50
    .line 51
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 52
    .line 53
    .line 54
    move-result-object v1

    .line 55
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 56
    .line 57
    .line 58
    :cond_2
    invoke-virtual {p0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->B()V

    .line 59
    .line 60
    .line 61
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x0:Lcom/vungle/ads/internal/util/d;

    .line 62
    .line 63
    if-eqz v0, :cond_3

    .line 64
    .line 65
    invoke-virtual {v0}, Lcom/vungle/ads/internal/util/d;->run()V

    .line 66
    .line 67
    .line 68
    :cond_3
    return-void
.end method

.method public final w(IFFF[F)V
    .locals 2

    .line 1
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/widget/ConstraintLayout;->f(I)Landroid/view/View;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 6
    .line 7
    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 8
    .line 9
    .line 10
    move-result-object v1

    .line 11
    check-cast v1, Lh1/n;

    .line 12
    .line 13
    if-eqz v1, :cond_0

    .line 14
    .line 15
    invoke-virtual {v1, p2, p3, p4, p5}, Lh1/n;->d(FFF[F)V

    .line 16
    .line 17
    .line 18
    invoke-virtual {v0}, Landroid/view/View;->getY()F

    .line 19
    .line 20
    .line 21
    goto :goto_0

    .line 22
    :cond_0
    if-nez v0, :cond_1

    .line 23
    .line 24
    goto :goto_0

    .line 25
    :cond_1
    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 26
    .line 27
    .line 28
    move-result-object p2

    .line 29
    invoke-virtual {p2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 30
    .line 31
    .line 32
    move-result-object p2

    .line 33
    invoke-virtual {p2, p1}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    .line 34
    .line 35
    .line 36
    :goto_0
    return-void
.end method

.method public final x(I)Lh1/x;
    .locals 3

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 2
    .line 3
    iget-object v0, v0, Landroidx/constraintlayout/motion/widget/c;->d:Ljava/util/ArrayList;

    .line 4
    .line 5
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 6
    .line 7
    .line 8
    move-result-object v0

    .line 9
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 10
    .line 11
    .line 12
    move-result v1

    .line 13
    if-eqz v1, :cond_1

    .line 14
    .line 15
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 16
    .line 17
    .line 18
    move-result-object v1

    .line 19
    check-cast v1, Lh1/x;

    .line 20
    .line 21
    iget v2, v1, Lh1/x;->a:I

    .line 22
    .line 23
    if-ne v2, p1, :cond_0

    .line 24
    .line 25
    goto :goto_0

    .line 26
    :cond_1
    const/4 v1, 0x0

    .line 27
    :goto_0
    return-object v1
.end method

.method public final y(FFLandroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 7

    .line 1
    instance-of v0, p3, Landroid/view/ViewGroup;

    .line 2
    .line 3
    const/4 v1, 0x1

    .line 4
    if-eqz v0, :cond_1

    .line 5
    .line 6
    move-object v0, p3

    .line 7
    check-cast v0, Landroid/view/ViewGroup;

    .line 8
    .line 9
    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 10
    .line 11
    .line 12
    move-result v2

    .line 13
    sub-int/2addr v2, v1

    .line 14
    :goto_0
    if-ltz v2, :cond_1

    .line 15
    .line 16
    invoke-virtual {v0, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 17
    .line 18
    .line 19
    move-result-object v3

    .line 20
    invoke-virtual {v3}, Landroid/view/View;->getLeft()I

    .line 21
    .line 22
    .line 23
    move-result v4

    .line 24
    int-to-float v4, v4

    .line 25
    add-float/2addr v4, p1

    .line 26
    invoke-virtual {p3}, Landroid/view/View;->getScrollX()I

    .line 27
    .line 28
    .line 29
    move-result v5

    .line 30
    int-to-float v5, v5

    .line 31
    sub-float/2addr v4, v5

    .line 32
    invoke-virtual {v3}, Landroid/view/View;->getTop()I

    .line 33
    .line 34
    .line 35
    move-result v5

    .line 36
    int-to-float v5, v5

    .line 37
    add-float/2addr v5, p2

    .line 38
    invoke-virtual {p3}, Landroid/view/View;->getScrollY()I

    .line 39
    .line 40
    .line 41
    move-result v6

    .line 42
    int-to-float v6, v6

    .line 43
    sub-float/2addr v5, v6

    .line 44
    invoke-virtual {p0, v4, v5, v3, p4}, Landroidx/constraintlayout/motion/widget/MotionLayout;->y(FFLandroid/view/View;Landroid/view/MotionEvent;)Z

    .line 45
    .line 46
    .line 47
    move-result v3

    .line 48
    if-eqz v3, :cond_0

    .line 49
    .line 50
    move v0, v1

    .line 51
    goto :goto_1

    .line 52
    :cond_0
    add-int/lit8 v2, v2, -0x1

    .line 53
    .line 54
    goto :goto_0

    .line 55
    :cond_1
    const/4 v0, 0x0

    .line 56
    :goto_1
    if-nez v0, :cond_5

    .line 57
    .line 58
    invoke-virtual {p3}, Landroid/view/View;->getRight()I

    .line 59
    .line 60
    .line 61
    move-result v2

    .line 62
    int-to-float v2, v2

    .line 63
    add-float/2addr v2, p1

    .line 64
    invoke-virtual {p3}, Landroid/view/View;->getLeft()I

    .line 65
    .line 66
    .line 67
    move-result v3

    .line 68
    int-to-float v3, v3

    .line 69
    sub-float/2addr v2, v3

    .line 70
    invoke-virtual {p3}, Landroid/view/View;->getBottom()I

    .line 71
    .line 72
    .line 73
    move-result v3

    .line 74
    int-to-float v3, v3

    .line 75
    add-float/2addr v3, p2

    .line 76
    invoke-virtual {p3}, Landroid/view/View;->getTop()I

    .line 77
    .line 78
    .line 79
    move-result v4

    .line 80
    int-to-float v4, v4

    .line 81
    sub-float/2addr v3, v4

    .line 82
    iget-object v4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->D0:Landroid/graphics/RectF;

    .line 83
    .line 84
    invoke-virtual {v4, p1, p2, v2, v3}, Landroid/graphics/RectF;->set(FFFF)V

    .line 85
    .line 86
    .line 87
    invoke-virtual {p4}, Landroid/view/MotionEvent;->getAction()I

    .line 88
    .line 89
    .line 90
    move-result v2

    .line 91
    if-nez v2, :cond_2

    .line 92
    .line 93
    invoke-virtual {p4}, Landroid/view/MotionEvent;->getX()F

    .line 94
    .line 95
    .line 96
    move-result v2

    .line 97
    invoke-virtual {p4}, Landroid/view/MotionEvent;->getY()F

    .line 98
    .line 99
    .line 100
    move-result v3

    .line 101
    invoke-virtual {v4, v2, v3}, Landroid/graphics/RectF;->contains(FF)Z

    .line 102
    .line 103
    .line 104
    move-result v2

    .line 105
    if-eqz v2, :cond_5

    .line 106
    .line 107
    :cond_2
    neg-float p1, p1

    .line 108
    neg-float p2, p2

    .line 109
    invoke-virtual {p3}, Landroid/view/View;->getMatrix()Landroid/graphics/Matrix;

    .line 110
    .line 111
    .line 112
    move-result-object v2

    .line 113
    invoke-virtual {v2}, Landroid/graphics/Matrix;->isIdentity()Z

    .line 114
    .line 115
    .line 116
    move-result v3

    .line 117
    if-eqz v3, :cond_3

    .line 118
    .line 119
    invoke-virtual {p4, p1, p2}, Landroid/view/MotionEvent;->offsetLocation(FF)V

    .line 120
    .line 121
    .line 122
    invoke-virtual {p3, p4}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    .line 123
    .line 124
    .line 125
    move-result p3

    .line 126
    neg-float p1, p1

    .line 127
    neg-float p2, p2

    .line 128
    invoke-virtual {p4, p1, p2}, Landroid/view/MotionEvent;->offsetLocation(FF)V

    .line 129
    .line 130
    .line 131
    goto :goto_2

    .line 132
    :cond_3
    invoke-static {p4}, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    .line 133
    .line 134
    .line 135
    move-result-object p4

    .line 136
    invoke-virtual {p4, p1, p2}, Landroid/view/MotionEvent;->offsetLocation(FF)V

    .line 137
    .line 138
    .line 139
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F0:Landroid/graphics/Matrix;

    .line 140
    .line 141
    if-nez p1, :cond_4

    .line 142
    .line 143
    new-instance p1, Landroid/graphics/Matrix;

    .line 144
    .line 145
    invoke-direct {p1}, Landroid/graphics/Matrix;-><init>()V

    .line 146
    .line 147
    .line 148
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F0:Landroid/graphics/Matrix;

    .line 149
    .line 150
    :cond_4
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F0:Landroid/graphics/Matrix;

    .line 151
    .line 152
    invoke-virtual {v2, p1}, Landroid/graphics/Matrix;->invert(Landroid/graphics/Matrix;)Z

    .line 153
    .line 154
    .line 155
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->F0:Landroid/graphics/Matrix;

    .line 156
    .line 157
    invoke-virtual {p4, p1}, Landroid/view/MotionEvent;->transform(Landroid/graphics/Matrix;)V

    .line 158
    .line 159
    .line 160
    invoke-virtual {p3, p4}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    .line 161
    .line 162
    .line 163
    move-result p3

    .line 164
    invoke-virtual {p4}, Landroid/view/MotionEvent;->recycle()V

    .line 165
    .line 166
    .line 167
    :goto_2
    if-eqz p3, :cond_5

    .line 168
    .line 169
    goto :goto_3

    .line 170
    :cond_5
    move v1, v0

    .line 171
    :goto_3
    return v1
.end method

.method public final z(Landroid/util/AttributeSet;)V
    .locals 11

    .line 1
    invoke-virtual {p0}, Landroid/view/View;->isInEditMode()Z

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    sput-boolean v0, Landroidx/constraintlayout/motion/widget/MotionLayout;->H0:Z

    .line 6
    .line 7
    const-string v0, "MotionLayout"

    .line 8
    .line 9
    const/4 v1, -0x1

    .line 10
    const/4 v2, 0x0

    .line 11
    if-eqz p1, :cond_9

    .line 12
    .line 13
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 14
    .line 15
    .line 16
    move-result-object v3

    .line 17
    sget-object v4, Lj1/m;->r:[I

    .line 18
    .line 19
    invoke-virtual {v3, p1, v4}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    .line 20
    .line 21
    .line 22
    move-result-object p1

    .line 23
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->getIndexCount()I

    .line 24
    .line 25
    .line 26
    move-result v3

    .line 27
    const/4 v4, 0x1

    .line 28
    move v5, v2

    .line 29
    move v6, v4

    .line 30
    :goto_0
    if-ge v5, v3, :cond_7

    .line 31
    .line 32
    invoke-virtual {p1, v5}, Landroid/content/res/TypedArray;->getIndex(I)I

    .line 33
    .line 34
    .line 35
    move-result v7

    .line 36
    const/4 v8, 0x2

    .line 37
    if-ne v7, v8, :cond_0

    .line 38
    .line 39
    invoke-virtual {p1, v7, v1}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 40
    .line 41
    .line 42
    move-result v7

    .line 43
    new-instance v8, Landroidx/constraintlayout/motion/widget/c;

    .line 44
    .line 45
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 46
    .line 47
    .line 48
    move-result-object v9

    .line 49
    invoke-direct {v8, v9, p0, v7}, Landroidx/constraintlayout/motion/widget/c;-><init>(Landroid/content/Context;Landroidx/constraintlayout/motion/widget/MotionLayout;I)V

    .line 50
    .line 51
    .line 52
    iput-object v8, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 53
    .line 54
    goto :goto_2

    .line 55
    :cond_0
    if-ne v7, v4, :cond_1

    .line 56
    .line 57
    invoke-virtual {p1, v7, v1}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 58
    .line 59
    .line 60
    move-result v7

    .line 61
    iput v7, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 62
    .line 63
    goto :goto_2

    .line 64
    :cond_1
    const/4 v9, 0x4

    .line 65
    if-ne v7, v9, :cond_2

    .line 66
    .line 67
    const/4 v8, 0x0

    .line 68
    invoke-virtual {p1, v7, v8}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 69
    .line 70
    .line 71
    move-result v7

    .line 72
    iput v7, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 73
    .line 74
    iput-boolean v4, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->K:Z

    .line 75
    .line 76
    goto :goto_2

    .line 77
    :cond_2
    if-nez v7, :cond_3

    .line 78
    .line 79
    invoke-virtual {p1, v7, v6}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    .line 80
    .line 81
    .line 82
    move-result v6

    .line 83
    goto :goto_2

    .line 84
    :cond_3
    const/4 v9, 0x5

    .line 85
    if-ne v7, v9, :cond_5

    .line 86
    .line 87
    iget v9, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 88
    .line 89
    if-nez v9, :cond_6

    .line 90
    .line 91
    invoke-virtual {p1, v7, v2}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    .line 92
    .line 93
    .line 94
    move-result v7

    .line 95
    if-eqz v7, :cond_4

    .line 96
    .line 97
    goto :goto_1

    .line 98
    :cond_4
    move v8, v2

    .line 99
    :goto_1
    iput v8, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 100
    .line 101
    goto :goto_2

    .line 102
    :cond_5
    const/4 v8, 0x3

    .line 103
    if-ne v7, v8, :cond_6

    .line 104
    .line 105
    invoke-virtual {p1, v7, v2}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 106
    .line 107
    .line 108
    move-result v7

    .line 109
    iput v7, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 110
    .line 111
    :cond_6
    :goto_2
    add-int/lit8 v5, v5, 0x1

    .line 112
    .line 113
    goto :goto_0

    .line 114
    :cond_7
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    .line 115
    .line 116
    .line 117
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 118
    .line 119
    if-nez p1, :cond_8

    .line 120
    .line 121
    const-string p1, "WARNING NO app:layoutDescription tag"

    .line 122
    .line 123
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 124
    .line 125
    .line 126
    :cond_8
    if-nez v6, :cond_9

    .line 127
    .line 128
    const/4 p1, 0x0

    .line 129
    iput-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 130
    .line 131
    :cond_9
    iget p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 132
    .line 133
    if-eqz p1, :cond_14

    .line 134
    .line 135
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 136
    .line 137
    if-nez p1, :cond_a

    .line 138
    .line 139
    const-string p1, "CHECK: motion scene not set! set \"app:layoutDescription=\"@xml/file\""

    .line 140
    .line 141
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 142
    .line 143
    .line 144
    goto/16 :goto_7

    .line 145
    .line 146
    :cond_a
    invoke-virtual {p1}, Landroidx/constraintlayout/motion/widget/c;->h()I

    .line 147
    .line 148
    .line 149
    move-result p1

    .line 150
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 151
    .line 152
    invoke-virtual {v3}, Landroidx/constraintlayout/motion/widget/c;->h()I

    .line 153
    .line 154
    .line 155
    move-result v4

    .line 156
    invoke-virtual {v3, v4}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 157
    .line 158
    .line 159
    move-result-object v3

    .line 160
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 161
    .line 162
    .line 163
    move-result-object v4

    .line 164
    invoke-static {v4, p1}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 165
    .line 166
    .line 167
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 168
    .line 169
    .line 170
    move-result p1

    .line 171
    move v4, v2

    .line 172
    :goto_3
    if-ge v4, p1, :cond_c

    .line 173
    .line 174
    invoke-virtual {p0, v4}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 175
    .line 176
    .line 177
    move-result-object v5

    .line 178
    invoke-virtual {v5}, Landroid/view/View;->getId()I

    .line 179
    .line 180
    .line 181
    move-result v6

    .line 182
    invoke-virtual {v3, v6}, Landroidx/constraintlayout/widget/d;->l(I)Landroidx/constraintlayout/widget/c;

    .line 183
    .line 184
    .line 185
    move-result-object v6

    .line 186
    if-nez v6, :cond_b

    .line 187
    .line 188
    invoke-static {v5}, Lso/c;->x(Landroid/view/View;)Ljava/lang/String;

    .line 189
    .line 190
    .line 191
    :cond_b
    add-int/lit8 v4, v4, 0x1

    .line 192
    .line 193
    goto :goto_3

    .line 194
    :cond_c
    iget-object p1, v3, Landroidx/constraintlayout/widget/d;->f:Ljava/util/HashMap;

    .line 195
    .line 196
    invoke-virtual {p1}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    .line 197
    .line 198
    .line 199
    move-result-object p1

    .line 200
    new-array v4, v2, [Ljava/lang/Integer;

    .line 201
    .line 202
    invoke-interface {p1, v4}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    .line 203
    .line 204
    .line 205
    move-result-object p1

    .line 206
    check-cast p1, [Ljava/lang/Integer;

    .line 207
    .line 208
    array-length v4, p1

    .line 209
    new-array v5, v4, [I

    .line 210
    .line 211
    move v6, v2

    .line 212
    :goto_4
    if-ge v6, v4, :cond_d

    .line 213
    .line 214
    aget-object v7, p1, v6

    .line 215
    .line 216
    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    .line 217
    .line 218
    .line 219
    move-result v7

    .line 220
    aput v7, v5, v6

    .line 221
    .line 222
    add-int/lit8 v6, v6, 0x1

    .line 223
    .line 224
    goto :goto_4

    .line 225
    :cond_d
    :goto_5
    if-ge v2, v4, :cond_e

    .line 226
    .line 227
    aget p1, v5, v2

    .line 228
    .line 229
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 230
    .line 231
    .line 232
    move-result-object v6

    .line 233
    invoke-static {v6, p1}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 234
    .line 235
    .line 236
    aget v6, v5, v2

    .line 237
    .line 238
    invoke-virtual {p0, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 239
    .line 240
    .line 241
    invoke-virtual {v3, p1}, Landroidx/constraintlayout/widget/d;->k(I)Landroidx/constraintlayout/widget/c;

    .line 242
    .line 243
    .line 244
    move-result-object v6

    .line 245
    iget-object v6, v6, Landroidx/constraintlayout/widget/c;->e:Lj1/g;

    .line 246
    .line 247
    iget v6, v6, Lj1/g;->d:I

    .line 248
    .line 249
    invoke-virtual {v3, p1}, Landroidx/constraintlayout/widget/d;->k(I)Landroidx/constraintlayout/widget/c;

    .line 250
    .line 251
    .line 252
    move-result-object p1

    .line 253
    iget-object p1, p1, Landroidx/constraintlayout/widget/c;->e:Lj1/g;

    .line 254
    .line 255
    iget p1, p1, Lj1/g;->c:I

    .line 256
    .line 257
    add-int/lit8 v2, v2, 0x1

    .line 258
    .line 259
    goto :goto_5

    .line 260
    :cond_e
    new-instance p1, Landroid/util/SparseIntArray;

    .line 261
    .line 262
    invoke-direct {p1}, Landroid/util/SparseIntArray;-><init>()V

    .line 263
    .line 264
    .line 265
    new-instance v2, Landroid/util/SparseIntArray;

    .line 266
    .line 267
    invoke-direct {v2}, Landroid/util/SparseIntArray;-><init>()V

    .line 268
    .line 269
    .line 270
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 271
    .line 272
    iget-object v3, v3, Landroidx/constraintlayout/motion/widget/c;->d:Ljava/util/ArrayList;

    .line 273
    .line 274
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 275
    .line 276
    .line 277
    move-result-object v3

    .line 278
    :cond_f
    :goto_6
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    .line 279
    .line 280
    .line 281
    move-result v4

    .line 282
    if-eqz v4, :cond_14

    .line 283
    .line 284
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 285
    .line 286
    .line 287
    move-result-object v4

    .line 288
    check-cast v4, Lh1/x;

    .line 289
    .line 290
    iget-object v5, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 291
    .line 292
    iget-object v5, v5, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 293
    .line 294
    iget v5, v4, Lh1/x;->d:I

    .line 295
    .line 296
    iget v6, v4, Lh1/x;->c:I

    .line 297
    .line 298
    if-ne v5, v6, :cond_10

    .line 299
    .line 300
    const-string v5, "CHECK: start and end constraint set should not be the same!"

    .line 301
    .line 302
    invoke-static {v0, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 303
    .line 304
    .line 305
    :cond_10
    iget v5, v4, Lh1/x;->d:I

    .line 306
    .line 307
    iget v4, v4, Lh1/x;->c:I

    .line 308
    .line 309
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 310
    .line 311
    .line 312
    move-result-object v6

    .line 313
    invoke-static {v6, v5}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 314
    .line 315
    .line 316
    move-result-object v6

    .line 317
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 318
    .line 319
    .line 320
    move-result-object v7

    .line 321
    invoke-static {v7, v4}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 322
    .line 323
    .line 324
    move-result-object v7

    .line 325
    invoke-virtual {p1, v5}, Landroid/util/SparseIntArray;->get(I)I

    .line 326
    .line 327
    .line 328
    move-result v8

    .line 329
    const-string v9, "->"

    .line 330
    .line 331
    if-ne v8, v4, :cond_11

    .line 332
    .line 333
    new-instance v8, Ljava/lang/StringBuilder;

    .line 334
    .line 335
    const-string v10, "CHECK: two transitions with the same start and end "

    .line 336
    .line 337
    invoke-direct {v8, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 338
    .line 339
    .line 340
    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 341
    .line 342
    .line 343
    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 344
    .line 345
    .line 346
    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 347
    .line 348
    .line 349
    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 350
    .line 351
    .line 352
    move-result-object v8

    .line 353
    invoke-static {v0, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 354
    .line 355
    .line 356
    :cond_11
    invoke-virtual {v2, v4}, Landroid/util/SparseIntArray;->get(I)I

    .line 357
    .line 358
    .line 359
    move-result v8

    .line 360
    if-ne v8, v5, :cond_12

    .line 361
    .line 362
    new-instance v8, Ljava/lang/StringBuilder;

    .line 363
    .line 364
    const-string v10, "CHECK: you can\'t have reverse transitions"

    .line 365
    .line 366
    invoke-direct {v8, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 367
    .line 368
    .line 369
    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 370
    .line 371
    .line 372
    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 373
    .line 374
    .line 375
    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 376
    .line 377
    .line 378
    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 379
    .line 380
    .line 381
    move-result-object v7

    .line 382
    invoke-static {v0, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 383
    .line 384
    .line 385
    :cond_12
    invoke-virtual {p1, v5, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 386
    .line 387
    .line 388
    invoke-virtual {v2, v4, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 389
    .line 390
    .line 391
    iget-object v7, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 392
    .line 393
    invoke-virtual {v7, v5}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 394
    .line 395
    .line 396
    move-result-object v5

    .line 397
    if-nez v5, :cond_13

    .line 398
    .line 399
    new-instance v5, Ljava/lang/StringBuilder;

    .line 400
    .line 401
    const-string v7, " no such constraintSetStart "

    .line 402
    .line 403
    invoke-direct {v5, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 404
    .line 405
    .line 406
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 407
    .line 408
    .line 409
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 410
    .line 411
    .line 412
    move-result-object v5

    .line 413
    invoke-static {v0, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 414
    .line 415
    .line 416
    :cond_13
    iget-object v5, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 417
    .line 418
    invoke-virtual {v5, v4}, Landroidx/constraintlayout/motion/widget/c;->b(I)Landroidx/constraintlayout/widget/d;

    .line 419
    .line 420
    .line 421
    move-result-object v4

    .line 422
    if-nez v4, :cond_f

    .line 423
    .line 424
    new-instance v4, Ljava/lang/StringBuilder;

    .line 425
    .line 426
    const-string v5, " no such constraintSetEnd "

    .line 427
    .line 428
    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 429
    .line 430
    .line 431
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 432
    .line 433
    .line 434
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 435
    .line 436
    .line 437
    move-result-object v4

    .line 438
    invoke-static {v0, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 439
    .line 440
    .line 441
    goto/16 :goto_6

    .line 442
    .line 443
    :cond_14
    :goto_7
    iget p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 444
    .line 445
    if-ne p1, v1, :cond_16

    .line 446
    .line 447
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 448
    .line 449
    if-eqz p1, :cond_16

    .line 450
    .line 451
    invoke-virtual {p1}, Landroidx/constraintlayout/motion/widget/c;->h()I

    .line 452
    .line 453
    .line 454
    move-result p1

    .line 455
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->x:I

    .line 456
    .line 457
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 458
    .line 459
    invoke-virtual {p1}, Landroidx/constraintlayout/motion/widget/c;->h()I

    .line 460
    .line 461
    .line 462
    move-result p1

    .line 463
    iput p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->w:I

    .line 464
    .line 465
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->s:Landroidx/constraintlayout/motion/widget/c;

    .line 466
    .line 467
    iget-object p1, p1, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 468
    .line 469
    if-nez p1, :cond_15

    .line 470
    .line 471
    goto :goto_8

    .line 472
    :cond_15
    iget v1, p1, Lh1/x;->c:I

    .line 473
    .line 474
    :goto_8
    iput v1, p0, Landroidx/constraintlayout/motion/widget/MotionLayout;->y:I

    .line 475
    .line 476
    :cond_16
    return-void
.end method
