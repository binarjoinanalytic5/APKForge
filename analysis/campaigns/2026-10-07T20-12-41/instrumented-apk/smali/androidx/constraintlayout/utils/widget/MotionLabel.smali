.class public Landroidx/constraintlayout/utils/widget/MotionLabel;
.super Landroid/view/View;
.source "SourceFile"

# interfaces
.implements Lh1/b;


# instance fields
.field public A:F

.field public B:F

.field public C:Landroid/graphics/drawable/Drawable;

.field public D:Landroid/graphics/Matrix;

.field public E:Landroid/graphics/Bitmap;

.field public F:Landroid/graphics/BitmapShader;

.field public G:Landroid/graphics/Matrix;

.field public H:F

.field public I:F

.field public J:F

.field public K:F

.field public final L:Landroid/graphics/Paint;

.field public M:I

.field public N:Landroid/graphics/Rect;

.field public O:Landroid/graphics/Paint;

.field public P:F

.field public Q:F

.field public R:F

.field public S:F

.field public T:F

.field public final a:Landroid/text/TextPaint;

.field public b:Landroid/graphics/Path;

.field public c:I

.field public d:I

.field public e:Z

.field public f:F

.field public g:F

.field public h:Landroid/view/ViewOutlineProvider;

.field public i:Landroid/graphics/RectF;

.field public j:F

.field public k:F

.field public l:I

.field public m:I

.field public n:F

.field public o:Ljava/lang/String;

.field public p:Z

.field public final q:Landroid/graphics/Rect;

.field public r:I

.field public s:I

.field public t:I

.field public u:I

.field public v:Ljava/lang/String;

.field public w:I

.field public x:I

.field public y:Z

.field public z:F


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 5
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 1
    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 2
    new-instance v0, Landroid/text/TextPaint;

    invoke-direct {v0}, Landroid/text/TextPaint;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 3
    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    const v0, 0xffff

    .line 4
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->c:I

    .line 5
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->d:I

    const/4 v0, 0x0

    .line 6
    iput-boolean v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    const/4 v1, 0x0

    .line 7
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    const/high16 v2, 0x7fc00000    # Float.NaN

    .line 8
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->g:F

    const/high16 v3, 0x42400000    # 48.0f

    .line 9
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 10
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 11
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 12
    const-string v3, "Hello World"

    iput-object v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->o:Ljava/lang/String;

    const/4 v3, 0x1

    .line 13
    iput-boolean v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->p:Z

    .line 14
    new-instance v4, Landroid/graphics/Rect;

    invoke-direct {v4}, Landroid/graphics/Rect;-><init>()V

    iput-object v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->q:Landroid/graphics/Rect;

    .line 15
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 16
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->s:I

    .line 17
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 18
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->u:I

    const v3, 0x800033

    .line 19
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->w:I

    .line 20
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->x:I

    .line 21
    iput-boolean v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->y:Z

    .line 22
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 23
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 24
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 25
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 26
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    iput-object v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->L:Landroid/graphics/Paint;

    .line 27
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->M:I

    .line 28
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->Q:F

    .line 29
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->R:F

    .line 30
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->S:F

    .line 31
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->T:F

    .line 32
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/utils/widget/MotionLabel;->b(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 4
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 33
    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 34
    new-instance p3, Landroid/text/TextPaint;

    invoke-direct {p3}, Landroid/text/TextPaint;-><init>()V

    iput-object p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 35
    new-instance p3, Landroid/graphics/Path;

    invoke-direct {p3}, Landroid/graphics/Path;-><init>()V

    iput-object p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    const p3, 0xffff

    .line 36
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->c:I

    .line 37
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->d:I

    const/4 p3, 0x0

    .line 38
    iput-boolean p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    const/4 v0, 0x0

    .line 39
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    const/high16 v1, 0x7fc00000    # Float.NaN

    .line 40
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->g:F

    const/high16 v2, 0x42400000    # 48.0f

    .line 41
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 42
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 43
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 44
    const-string v2, "Hello World"

    iput-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->o:Ljava/lang/String;

    const/4 v2, 0x1

    .line 45
    iput-boolean v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->p:Z

    .line 46
    new-instance v3, Landroid/graphics/Rect;

    invoke-direct {v3}, Landroid/graphics/Rect;-><init>()V

    iput-object v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->q:Landroid/graphics/Rect;

    .line 47
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 48
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->s:I

    .line 49
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 50
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->u:I

    const v2, 0x800033

    .line 51
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->w:I

    .line 52
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->x:I

    .line 53
    iput-boolean p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->y:Z

    .line 54
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 55
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 56
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 57
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 58
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->L:Landroid/graphics/Paint;

    .line 59
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->M:I

    .line 60
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->Q:F

    .line 61
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->R:F

    .line 62
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->S:F

    .line 63
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->T:F

    .line 64
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/utils/widget/MotionLabel;->b(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method private getHorizontalOffset()F
    .locals 6

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 2
    .line 3
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    .line 4
    .line 5
    .line 6
    move-result v0

    .line 7
    const/high16 v1, 0x3f800000    # 1.0f

    .line 8
    .line 9
    if-eqz v0, :cond_0

    .line 10
    .line 11
    move v0, v1

    .line 12
    goto :goto_0

    .line 13
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 14
    .line 15
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 16
    .line 17
    div-float/2addr v0, v2

    .line 18
    :goto_0
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->o:Ljava/lang/String;

    .line 19
    .line 20
    const/4 v3, 0x0

    .line 21
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    .line 22
    .line 23
    .line 24
    move-result v4

    .line 25
    iget-object v5, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 26
    .line 27
    invoke-virtual {v5, v2, v3, v4}, Landroid/graphics/Paint;->measureText(Ljava/lang/String;II)F

    .line 28
    .line 29
    .line 30
    move-result v2

    .line 31
    mul-float/2addr v2, v0

    .line 32
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->A:F

    .line 33
    .line 34
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    .line 35
    .line 36
    .line 37
    move-result v0

    .line 38
    if-eqz v0, :cond_1

    .line 39
    .line 40
    invoke-virtual {p0}, Landroid/view/View;->getMeasuredWidth()I

    .line 41
    .line 42
    .line 43
    move-result v0

    .line 44
    int-to-float v0, v0

    .line 45
    goto :goto_1

    .line 46
    :cond_1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->A:F

    .line 47
    .line 48
    :goto_1
    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    .line 49
    .line 50
    .line 51
    move-result v3

    .line 52
    int-to-float v3, v3

    .line 53
    sub-float/2addr v0, v3

    .line 54
    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    .line 55
    .line 56
    .line 57
    move-result v3

    .line 58
    int-to-float v3, v3

    .line 59
    sub-float/2addr v0, v3

    .line 60
    sub-float/2addr v0, v2

    .line 61
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 62
    .line 63
    add-float/2addr v2, v1

    .line 64
    mul-float/2addr v2, v0

    .line 65
    const/high16 v0, 0x40000000    # 2.0f

    .line 66
    .line 67
    div-float/2addr v2, v0

    .line 68
    return v2
.end method

.method private getVerticalOffset()F
    .locals 5

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 2
    .line 3
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    .line 4
    .line 5
    .line 6
    move-result v0

    .line 7
    const/high16 v1, 0x3f800000    # 1.0f

    .line 8
    .line 9
    if-eqz v0, :cond_0

    .line 10
    .line 11
    move v0, v1

    .line 12
    goto :goto_0

    .line 13
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 14
    .line 15
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 16
    .line 17
    div-float/2addr v0, v2

    .line 18
    :goto_0
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 19
    .line 20
    invoke-virtual {v2}, Landroid/graphics/Paint;->getFontMetrics()Landroid/graphics/Paint$FontMetrics;

    .line 21
    .line 22
    .line 23
    move-result-object v2

    .line 24
    iget v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->B:F

    .line 25
    .line 26
    invoke-static {v3}, Ljava/lang/Float;->isNaN(F)Z

    .line 27
    .line 28
    .line 29
    move-result v3

    .line 30
    if-eqz v3, :cond_1

    .line 31
    .line 32
    invoke-virtual {p0}, Landroid/view/View;->getMeasuredHeight()I

    .line 33
    .line 34
    .line 35
    move-result v3

    .line 36
    int-to-float v3, v3

    .line 37
    goto :goto_1

    .line 38
    :cond_1
    iget v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->B:F

    .line 39
    .line 40
    :goto_1
    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    .line 41
    .line 42
    .line 43
    move-result v4

    .line 44
    int-to-float v4, v4

    .line 45
    sub-float/2addr v3, v4

    .line 46
    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    .line 47
    .line 48
    .line 49
    move-result v4

    .line 50
    int-to-float v4, v4

    .line 51
    sub-float/2addr v3, v4

    .line 52
    iget v4, v2, Landroid/graphics/Paint$FontMetrics;->descent:F

    .line 53
    .line 54
    iget v2, v2, Landroid/graphics/Paint$FontMetrics;->ascent:F

    .line 55
    .line 56
    sub-float/2addr v4, v2

    .line 57
    mul-float/2addr v4, v0

    .line 58
    sub-float/2addr v3, v4

    .line 59
    iget v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 60
    .line 61
    sub-float/2addr v1, v4

    .line 62
    mul-float/2addr v1, v3

    .line 63
    const/high16 v3, 0x40000000    # 2.0f

    .line 64
    .line 65
    div-float/2addr v1, v3

    .line 66
    mul-float/2addr v0, v2

    .line 67
    sub-float/2addr v1, v0

    .line 68
    return v1
.end method


# virtual methods
.method public final a(F)V
    .locals 11

    .line 1
    iget-boolean v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 2
    .line 3
    const/high16 v1, 0x3f800000    # 1.0f

    .line 4
    .line 5
    if-nez v0, :cond_0

    .line 6
    .line 7
    cmpl-float v0, p1, v1

    .line 8
    .line 9
    if-nez v0, :cond_0

    .line 10
    .line 11
    return-void

    .line 12
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 13
    .line 14
    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    .line 15
    .line 16
    .line 17
    iget-object v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->o:Ljava/lang/String;

    .line 18
    .line 19
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    .line 20
    .line 21
    .line 22
    move-result v5

    .line 23
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 24
    .line 25
    iget-object v9, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->q:Landroid/graphics/Rect;

    .line 26
    .line 27
    const/4 v10, 0x0

    .line 28
    invoke-virtual {v0, v3, v10, v5, v9}, Landroid/graphics/Paint;->getTextBounds(Ljava/lang/String;IILandroid/graphics/Rect;)V

    .line 29
    .line 30
    .line 31
    iget-object v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 32
    .line 33
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 34
    .line 35
    const/4 v4, 0x0

    .line 36
    const/4 v6, 0x0

    .line 37
    const/4 v7, 0x0

    .line 38
    invoke-virtual/range {v2 .. v8}, Landroid/graphics/Paint;->getTextPath(Ljava/lang/String;IIFFLandroid/graphics/Path;)V

    .line 39
    .line 40
    .line 41
    cmpl-float v0, p1, v1

    .line 42
    .line 43
    if-eqz v0, :cond_1

    .line 44
    .line 45
    invoke-static {}, Lso/c;->u()Ljava/lang/String;

    .line 46
    .line 47
    .line 48
    new-instance v0, Landroid/graphics/Matrix;

    .line 49
    .line 50
    invoke-direct {v0}, Landroid/graphics/Matrix;-><init>()V

    .line 51
    .line 52
    .line 53
    invoke-virtual {v0, p1, p1}, Landroid/graphics/Matrix;->postScale(FF)Z

    .line 54
    .line 55
    .line 56
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 57
    .line 58
    invoke-virtual {p1, v0}, Landroid/graphics/Path;->transform(Landroid/graphics/Matrix;)V

    .line 59
    .line 60
    .line 61
    :cond_1
    iget p1, v9, Landroid/graphics/Rect;->right:I

    .line 62
    .line 63
    add-int/lit8 p1, p1, -0x1

    .line 64
    .line 65
    iput p1, v9, Landroid/graphics/Rect;->right:I

    .line 66
    .line 67
    iget p1, v9, Landroid/graphics/Rect;->left:I

    .line 68
    .line 69
    add-int/lit8 p1, p1, 0x1

    .line 70
    .line 71
    iput p1, v9, Landroid/graphics/Rect;->left:I

    .line 72
    .line 73
    iget p1, v9, Landroid/graphics/Rect;->bottom:I

    .line 74
    .line 75
    add-int/lit8 p1, p1, 0x1

    .line 76
    .line 77
    iput p1, v9, Landroid/graphics/Rect;->bottom:I

    .line 78
    .line 79
    iget p1, v9, Landroid/graphics/Rect;->top:I

    .line 80
    .line 81
    add-int/lit8 p1, p1, -0x1

    .line 82
    .line 83
    iput p1, v9, Landroid/graphics/Rect;->top:I

    .line 84
    .line 85
    new-instance p1, Landroid/graphics/RectF;

    .line 86
    .line 87
    invoke-direct {p1}, Landroid/graphics/RectF;-><init>()V

    .line 88
    .line 89
    .line 90
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    .line 91
    .line 92
    .line 93
    move-result v0

    .line 94
    int-to-float v0, v0

    .line 95
    iput v0, p1, Landroid/graphics/RectF;->bottom:F

    .line 96
    .line 97
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    .line 98
    .line 99
    .line 100
    move-result v0

    .line 101
    int-to-float v0, v0

    .line 102
    iput v0, p1, Landroid/graphics/RectF;->right:F

    .line 103
    .line 104
    iput-boolean v10, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->p:Z

    .line 105
    .line 106
    return-void
.end method

.method public final b(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 10

    .line 1
    new-instance v0, Landroid/util/TypedValue;

    .line 2
    .line 3
    invoke-direct {v0}, Landroid/util/TypedValue;-><init>()V

    .line 4
    .line 5
    .line 6
    invoke-virtual {p1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    .line 7
    .line 8
    .line 9
    move-result-object p1

    .line 10
    const v1, 0x7f040169

    .line 11
    .line 12
    .line 13
    const/4 v2, 0x1

    .line 14
    invoke-virtual {p1, v1, v0, v2}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    .line 15
    .line 16
    .line 17
    iget p1, v0, Landroid/util/TypedValue;->data:I

    .line 18
    .line 19
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->c:I

    .line 20
    .line 21
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 22
    .line 23
    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 24
    .line 25
    .line 26
    const/4 p1, 0x4

    .line 27
    const/4 v1, 0x3

    .line 28
    const/4 v3, 0x0

    .line 29
    const/4 v4, 0x2

    .line 30
    if-eqz p2, :cond_18

    .line 31
    .line 32
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 33
    .line 34
    .line 35
    move-result-object v5

    .line 36
    sget-object v6, Lj1/m;->q:[I

    .line 37
    .line 38
    invoke-virtual {v5, p2, v6}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    .line 39
    .line 40
    .line 41
    move-result-object p2

    .line 42
    invoke-virtual {p2}, Landroid/content/res/TypedArray;->getIndexCount()I

    .line 43
    .line 44
    .line 45
    move-result v5

    .line 46
    move v6, v3

    .line 47
    :goto_0
    if-ge v6, v5, :cond_17

    .line 48
    .line 49
    invoke-virtual {p2, v6}, Landroid/content/res/TypedArray;->getIndex(I)I

    .line 50
    .line 51
    .line 52
    move-result v7

    .line 53
    const/4 v8, 0x5

    .line 54
    if-ne v7, v8, :cond_0

    .line 55
    .line 56
    invoke-virtual {p2, v7}, Landroid/content/res/TypedArray;->getText(I)Ljava/lang/CharSequence;

    .line 57
    .line 58
    .line 59
    move-result-object v7

    .line 60
    invoke-virtual {p0, v7}, Landroidx/constraintlayout/utils/widget/MotionLabel;->setText(Ljava/lang/CharSequence;)V

    .line 61
    .line 62
    .line 63
    goto/16 :goto_1

    .line 64
    .line 65
    :cond_0
    const/4 v8, 0x7

    .line 66
    if-ne v7, v8, :cond_1

    .line 67
    .line 68
    invoke-virtual {p2, v7}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    .line 69
    .line 70
    .line 71
    move-result-object v7

    .line 72
    iput-object v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->v:Ljava/lang/String;

    .line 73
    .line 74
    goto/16 :goto_1

    .line 75
    .line 76
    :cond_1
    const/16 v8, 0xb

    .line 77
    .line 78
    if-ne v7, v8, :cond_2

    .line 79
    .line 80
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 81
    .line 82
    float-to-int v8, v8

    .line 83
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getDimensionPixelSize(II)I

    .line 84
    .line 85
    .line 86
    move-result v7

    .line 87
    int-to-float v7, v7

    .line 88
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 89
    .line 90
    goto/16 :goto_1

    .line 91
    .line 92
    :cond_2
    if-nez v7, :cond_3

    .line 93
    .line 94
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 95
    .line 96
    float-to-int v8, v8

    .line 97
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getDimensionPixelSize(II)I

    .line 98
    .line 99
    .line 100
    move-result v7

    .line 101
    int-to-float v7, v7

    .line 102
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 103
    .line 104
    goto/16 :goto_1

    .line 105
    .line 106
    :cond_3
    if-ne v7, v4, :cond_4

    .line 107
    .line 108
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->l:I

    .line 109
    .line 110
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 111
    .line 112
    .line 113
    move-result v7

    .line 114
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->l:I

    .line 115
    .line 116
    goto/16 :goto_1

    .line 117
    .line 118
    :cond_4
    if-ne v7, v2, :cond_5

    .line 119
    .line 120
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->m:I

    .line 121
    .line 122
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 123
    .line 124
    .line 125
    move-result v7

    .line 126
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->m:I

    .line 127
    .line 128
    goto/16 :goto_1

    .line 129
    .line 130
    :cond_5
    if-ne v7, v1, :cond_6

    .line 131
    .line 132
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->c:I

    .line 133
    .line 134
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getColor(II)I

    .line 135
    .line 136
    .line 137
    move-result v7

    .line 138
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->c:I

    .line 139
    .line 140
    goto/16 :goto_1

    .line 141
    .line 142
    :cond_6
    const/16 v8, 0x9

    .line 143
    .line 144
    if-ne v7, v8, :cond_7

    .line 145
    .line 146
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->g:F

    .line 147
    .line 148
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getDimension(IF)F

    .line 149
    .line 150
    .line 151
    move-result v7

    .line 152
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->g:F

    .line 153
    .line 154
    invoke-virtual {p0, v7}, Landroidx/constraintlayout/utils/widget/MotionLabel;->setRound(F)V

    .line 155
    .line 156
    .line 157
    goto/16 :goto_1

    .line 158
    .line 159
    :cond_7
    const/16 v8, 0xa

    .line 160
    .line 161
    if-ne v7, v8, :cond_8

    .line 162
    .line 163
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    .line 164
    .line 165
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 166
    .line 167
    .line 168
    move-result v7

    .line 169
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    .line 170
    .line 171
    invoke-virtual {p0, v7}, Landroidx/constraintlayout/utils/widget/MotionLabel;->setRoundPercent(F)V

    .line 172
    .line 173
    .line 174
    goto/16 :goto_1

    .line 175
    .line 176
    :cond_8
    if-ne v7, p1, :cond_9

    .line 177
    .line 178
    const/4 v8, -0x1

    .line 179
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 180
    .line 181
    .line 182
    move-result v7

    .line 183
    invoke-virtual {p0, v7}, Landroidx/constraintlayout/utils/widget/MotionLabel;->setGravity(I)V

    .line 184
    .line 185
    .line 186
    goto/16 :goto_1

    .line 187
    .line 188
    :cond_9
    const/16 v8, 0x8

    .line 189
    .line 190
    if-ne v7, v8, :cond_a

    .line 191
    .line 192
    invoke-virtual {p2, v7, v3}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 193
    .line 194
    .line 195
    move-result v7

    .line 196
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->x:I

    .line 197
    .line 198
    goto/16 :goto_1

    .line 199
    .line 200
    :cond_a
    const/16 v8, 0x11

    .line 201
    .line 202
    if-ne v7, v8, :cond_b

    .line 203
    .line 204
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->d:I

    .line 205
    .line 206
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 207
    .line 208
    .line 209
    move-result v7

    .line 210
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->d:I

    .line 211
    .line 212
    iput-boolean v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 213
    .line 214
    goto/16 :goto_1

    .line 215
    .line 216
    :cond_b
    const/16 v8, 0x12

    .line 217
    .line 218
    if-ne v7, v8, :cond_c

    .line 219
    .line 220
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 221
    .line 222
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getDimension(IF)F

    .line 223
    .line 224
    .line 225
    move-result v7

    .line 226
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 227
    .line 228
    iput-boolean v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 229
    .line 230
    goto/16 :goto_1

    .line 231
    .line 232
    :cond_c
    const/16 v8, 0xc

    .line 233
    .line 234
    if-ne v7, v8, :cond_d

    .line 235
    .line 236
    invoke-virtual {p2, v7}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    .line 237
    .line 238
    .line 239
    move-result-object v7

    .line 240
    iput-object v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->C:Landroid/graphics/drawable/Drawable;

    .line 241
    .line 242
    iput-boolean v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 243
    .line 244
    goto/16 :goto_1

    .line 245
    .line 246
    :cond_d
    const/16 v8, 0xd

    .line 247
    .line 248
    if-ne v7, v8, :cond_e

    .line 249
    .line 250
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->Q:F

    .line 251
    .line 252
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 253
    .line 254
    .line 255
    move-result v7

    .line 256
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->Q:F

    .line 257
    .line 258
    goto/16 :goto_1

    .line 259
    .line 260
    :cond_e
    const/16 v8, 0xe

    .line 261
    .line 262
    if-ne v7, v8, :cond_f

    .line 263
    .line 264
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->R:F

    .line 265
    .line 266
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 267
    .line 268
    .line 269
    move-result v7

    .line 270
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->R:F

    .line 271
    .line 272
    goto :goto_1

    .line 273
    :cond_f
    const/16 v8, 0x13

    .line 274
    .line 275
    if-ne v7, v8, :cond_10

    .line 276
    .line 277
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 278
    .line 279
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 280
    .line 281
    .line 282
    move-result v7

    .line 283
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 284
    .line 285
    goto :goto_1

    .line 286
    :cond_10
    const/16 v8, 0x14

    .line 287
    .line 288
    if-ne v7, v8, :cond_11

    .line 289
    .line 290
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 291
    .line 292
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 293
    .line 294
    .line 295
    move-result v7

    .line 296
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 297
    .line 298
    goto :goto_1

    .line 299
    :cond_11
    const/16 v8, 0xf

    .line 300
    .line 301
    if-ne v7, v8, :cond_12

    .line 302
    .line 303
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->T:F

    .line 304
    .line 305
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 306
    .line 307
    .line 308
    move-result v7

    .line 309
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->T:F

    .line 310
    .line 311
    goto :goto_1

    .line 312
    :cond_12
    const/16 v8, 0x10

    .line 313
    .line 314
    if-ne v7, v8, :cond_13

    .line 315
    .line 316
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->S:F

    .line 317
    .line 318
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 319
    .line 320
    .line 321
    move-result v7

    .line 322
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->S:F

    .line 323
    .line 324
    goto :goto_1

    .line 325
    :cond_13
    const/16 v8, 0x17

    .line 326
    .line 327
    if-ne v7, v8, :cond_14

    .line 328
    .line 329
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 330
    .line 331
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getDimension(IF)F

    .line 332
    .line 333
    .line 334
    move-result v7

    .line 335
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 336
    .line 337
    goto :goto_1

    .line 338
    :cond_14
    const/16 v8, 0x18

    .line 339
    .line 340
    if-ne v7, v8, :cond_15

    .line 341
    .line 342
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 343
    .line 344
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getDimension(IF)F

    .line 345
    .line 346
    .line 347
    move-result v7

    .line 348
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 349
    .line 350
    goto :goto_1

    .line 351
    :cond_15
    const/16 v8, 0x16

    .line 352
    .line 353
    if-ne v7, v8, :cond_16

    .line 354
    .line 355
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->M:I

    .line 356
    .line 357
    invoke-virtual {p2, v7, v8}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 358
    .line 359
    .line 360
    move-result v7

    .line 361
    iput v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->M:I

    .line 362
    .line 363
    :cond_16
    :goto_1
    add-int/lit8 v6, v6, 0x1

    .line 364
    .line 365
    goto/16 :goto_0

    .line 366
    .line 367
    :cond_17
    invoke-virtual {p2}, Landroid/content/res/TypedArray;->recycle()V

    .line 368
    .line 369
    .line 370
    :cond_18
    iget-object p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->C:Landroid/graphics/drawable/Drawable;

    .line 371
    .line 372
    const/16 v5, 0x80

    .line 373
    .line 374
    if-eqz p2, :cond_21

    .line 375
    .line 376
    new-instance p2, Landroid/graphics/Matrix;

    .line 377
    .line 378
    invoke-direct {p2}, Landroid/graphics/Matrix;-><init>()V

    .line 379
    .line 380
    .line 381
    iput-object p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->G:Landroid/graphics/Matrix;

    .line 382
    .line 383
    iget-object p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->C:Landroid/graphics/drawable/Drawable;

    .line 384
    .line 385
    invoke-virtual {p2}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    .line 386
    .line 387
    .line 388
    move-result p2

    .line 389
    iget-object v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->C:Landroid/graphics/drawable/Drawable;

    .line 390
    .line 391
    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    .line 392
    .line 393
    .line 394
    move-result v6

    .line 395
    if-gtz p2, :cond_1a

    .line 396
    .line 397
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    .line 398
    .line 399
    .line 400
    move-result p2

    .line 401
    if-nez p2, :cond_1a

    .line 402
    .line 403
    iget p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 404
    .line 405
    invoke-static {p2}, Ljava/lang/Float;->isNaN(F)Z

    .line 406
    .line 407
    .line 408
    move-result p2

    .line 409
    if-eqz p2, :cond_19

    .line 410
    .line 411
    move p2, v5

    .line 412
    goto :goto_2

    .line 413
    :cond_19
    iget p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 414
    .line 415
    float-to-int p2, p2

    .line 416
    :cond_1a
    :goto_2
    if-gtz v6, :cond_1c

    .line 417
    .line 418
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    .line 419
    .line 420
    .line 421
    move-result v6

    .line 422
    if-nez v6, :cond_1c

    .line 423
    .line 424
    iget v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 425
    .line 426
    invoke-static {v6}, Ljava/lang/Float;->isNaN(F)Z

    .line 427
    .line 428
    .line 429
    move-result v6

    .line 430
    if-eqz v6, :cond_1b

    .line 431
    .line 432
    move v6, v5

    .line 433
    goto :goto_3

    .line 434
    :cond_1b
    iget v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 435
    .line 436
    float-to-int v6, v6

    .line 437
    :cond_1c
    :goto_3
    iget v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->M:I

    .line 438
    .line 439
    if-eqz v7, :cond_1d

    .line 440
    .line 441
    div-int/lit8 p2, p2, 0x2

    .line 442
    .line 443
    div-int/lit8 v6, v6, 0x2

    .line 444
    .line 445
    :cond_1d
    sget-object v7, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    .line 446
    .line 447
    invoke-static {p2, v6, v7}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    .line 448
    .line 449
    .line 450
    move-result-object p2

    .line 451
    iput-object p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->E:Landroid/graphics/Bitmap;

    .line 452
    .line 453
    new-instance p2, Landroid/graphics/Canvas;

    .line 454
    .line 455
    iget-object v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->E:Landroid/graphics/Bitmap;

    .line 456
    .line 457
    invoke-direct {p2, v6}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 458
    .line 459
    .line 460
    iget-object v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->C:Landroid/graphics/drawable/Drawable;

    .line 461
    .line 462
    invoke-virtual {p2}, Landroid/graphics/Canvas;->getWidth()I

    .line 463
    .line 464
    .line 465
    move-result v7

    .line 466
    invoke-virtual {p2}, Landroid/graphics/Canvas;->getHeight()I

    .line 467
    .line 468
    .line 469
    move-result v8

    .line 470
    invoke-virtual {v6, v3, v3, v7, v8}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 471
    .line 472
    .line 473
    iget-object v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->C:Landroid/graphics/drawable/Drawable;

    .line 474
    .line 475
    invoke-virtual {v6, v2}, Landroid/graphics/drawable/Drawable;->setFilterBitmap(Z)V

    .line 476
    .line 477
    .line 478
    iget-object v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->C:Landroid/graphics/drawable/Drawable;

    .line 479
    .line 480
    invoke-virtual {v6, p2}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    .line 481
    .line 482
    .line 483
    iget p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->M:I

    .line 484
    .line 485
    if-eqz p2, :cond_20

    .line 486
    .line 487
    iget-object p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->E:Landroid/graphics/Bitmap;

    .line 488
    .line 489
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    .line 490
    .line 491
    .line 492
    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getWidth()I

    .line 493
    .line 494
    .line 495
    move-result v6

    .line 496
    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getHeight()I

    .line 497
    .line 498
    .line 499
    move-result v7

    .line 500
    div-int/2addr v6, v4

    .line 501
    div-int/2addr v7, v4

    .line 502
    invoke-static {p2, v6, v7, v2}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    .line 503
    .line 504
    .line 505
    move-result-object p2

    .line 506
    move v8, v3

    .line 507
    :goto_4
    if-ge v8, p1, :cond_1f

    .line 508
    .line 509
    const/16 v9, 0x20

    .line 510
    .line 511
    if-lt v6, v9, :cond_1f

    .line 512
    .line 513
    if-ge v7, v9, :cond_1e

    .line 514
    .line 515
    goto :goto_5

    .line 516
    :cond_1e
    div-int/lit8 v6, v6, 0x2

    .line 517
    .line 518
    div-int/lit8 v7, v7, 0x2

    .line 519
    .line 520
    invoke-static {p2, v6, v7, v2}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    .line 521
    .line 522
    .line 523
    move-result-object p2

    .line 524
    add-int/lit8 v8, v8, 0x1

    .line 525
    .line 526
    goto :goto_4

    .line 527
    :cond_1f
    :goto_5
    iput-object p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->E:Landroid/graphics/Bitmap;

    .line 528
    .line 529
    :cond_20
    new-instance p1, Landroid/graphics/BitmapShader;

    .line 530
    .line 531
    iget-object p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->E:Landroid/graphics/Bitmap;

    .line 532
    .line 533
    sget-object v6, Landroid/graphics/Shader$TileMode;->REPEAT:Landroid/graphics/Shader$TileMode;

    .line 534
    .line 535
    invoke-direct {p1, p2, v6, v6}, Landroid/graphics/BitmapShader;-><init>(Landroid/graphics/Bitmap;Landroid/graphics/Shader$TileMode;Landroid/graphics/Shader$TileMode;)V

    .line 536
    .line 537
    .line 538
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->F:Landroid/graphics/BitmapShader;

    .line 539
    .line 540
    :cond_21
    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    .line 541
    .line 542
    .line 543
    move-result p1

    .line 544
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 545
    .line 546
    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    .line 547
    .line 548
    .line 549
    move-result p1

    .line 550
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->s:I

    .line 551
    .line 552
    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    .line 553
    .line 554
    .line 555
    move-result p1

    .line 556
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 557
    .line 558
    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    .line 559
    .line 560
    .line 561
    move-result p1

    .line 562
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->u:I

    .line 563
    .line 564
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->v:Ljava/lang/String;

    .line 565
    .line 566
    iget p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->m:I

    .line 567
    .line 568
    iget v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->l:I

    .line 569
    .line 570
    if-eqz p1, :cond_22

    .line 571
    .line 572
    invoke-static {p1, v6}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    .line 573
    .line 574
    .line 575
    move-result-object p1

    .line 576
    if-eqz p1, :cond_23

    .line 577
    .line 578
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/utils/widget/MotionLabel;->setTypeface(Landroid/graphics/Typeface;)V

    .line 579
    .line 580
    .line 581
    goto :goto_9

    .line 582
    :cond_22
    const/4 p1, 0x0

    .line 583
    :cond_23
    if-eq p2, v2, :cond_26

    .line 584
    .line 585
    if-eq p2, v4, :cond_25

    .line 586
    .line 587
    if-eq p2, v1, :cond_24

    .line 588
    .line 589
    goto :goto_6

    .line 590
    :cond_24
    sget-object p1, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    .line 591
    .line 592
    goto :goto_6

    .line 593
    :cond_25
    sget-object p1, Landroid/graphics/Typeface;->SERIF:Landroid/graphics/Typeface;

    .line 594
    .line 595
    goto :goto_6

    .line 596
    :cond_26
    sget-object p1, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    .line 597
    .line 598
    :goto_6
    const/4 p2, 0x0

    .line 599
    if-lez v6, :cond_2b

    .line 600
    .line 601
    if-nez p1, :cond_27

    .line 602
    .line 603
    invoke-static {v6}, Landroid/graphics/Typeface;->defaultFromStyle(I)Landroid/graphics/Typeface;

    .line 604
    .line 605
    .line 606
    move-result-object p1

    .line 607
    goto :goto_7

    .line 608
    :cond_27
    invoke-static {p1, v6}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    .line 609
    .line 610
    .line 611
    move-result-object p1

    .line 612
    :goto_7
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/utils/widget/MotionLabel;->setTypeface(Landroid/graphics/Typeface;)V

    .line 613
    .line 614
    .line 615
    if-eqz p1, :cond_28

    .line 616
    .line 617
    invoke-virtual {p1}, Landroid/graphics/Typeface;->getStyle()I

    .line 618
    .line 619
    .line 620
    move-result p1

    .line 621
    goto :goto_8

    .line 622
    :cond_28
    move p1, v3

    .line 623
    :goto_8
    not-int p1, p1

    .line 624
    and-int/2addr p1, v6

    .line 625
    and-int/lit8 v1, p1, 0x1

    .line 626
    .line 627
    if-eqz v1, :cond_29

    .line 628
    .line 629
    move v3, v2

    .line 630
    :cond_29
    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setFakeBoldText(Z)V

    .line 631
    .line 632
    .line 633
    and-int/2addr p1, v4

    .line 634
    if-eqz p1, :cond_2a

    .line 635
    .line 636
    const/high16 p2, -0x41800000    # -0.25f

    .line 637
    .line 638
    :cond_2a
    invoke-virtual {v0, p2}, Landroid/graphics/Paint;->setTextSkewX(F)V

    .line 639
    .line 640
    .line 641
    goto :goto_9

    .line 642
    :cond_2b
    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setFakeBoldText(Z)V

    .line 643
    .line 644
    .line 645
    invoke-virtual {v0, p2}, Landroid/graphics/Paint;->setTextSkewX(F)V

    .line 646
    .line 647
    .line 648
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/utils/widget/MotionLabel;->setTypeface(Landroid/graphics/Typeface;)V

    .line 649
    .line 650
    .line 651
    :goto_9
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->c:I

    .line 652
    .line 653
    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 654
    .line 655
    .line 656
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 657
    .line 658
    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 659
    .line 660
    .line 661
    sget-object p1, Landroid/graphics/Paint$Style;->FILL_AND_STROKE:Landroid/graphics/Paint$Style;

    .line 662
    .line 663
    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 664
    .line 665
    .line 666
    invoke-virtual {v0, v5}, Landroid/graphics/Paint;->setFlags(I)V

    .line 667
    .line 668
    .line 669
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 670
    .line 671
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/utils/widget/MotionLabel;->setTextSize(F)V

    .line 672
    .line 673
    .line 674
    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    .line 675
    .line 676
    .line 677
    return-void
.end method

.method public final c(FFFF)V
    .locals 6

    .line 1
    const/high16 v0, 0x3f000000    # 0.5f

    .line 2
    .line 3
    add-float v1, p1, v0

    .line 4
    .line 5
    float-to-int v1, v1

    .line 6
    int-to-float v2, v1

    .line 7
    sub-float v2, p1, v2

    .line 8
    .line 9
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->z:F

    .line 10
    .line 11
    add-float v2, p3, v0

    .line 12
    .line 13
    float-to-int v2, v2

    .line 14
    sub-int v3, v2, v1

    .line 15
    .line 16
    add-float v4, p4, v0

    .line 17
    .line 18
    float-to-int v4, v4

    .line 19
    add-float/2addr v0, p2

    .line 20
    float-to-int v0, v0

    .line 21
    sub-int v5, v4, v0

    .line 22
    .line 23
    sub-float/2addr p3, p1

    .line 24
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->A:F

    .line 25
    .line 26
    sub-float/2addr p4, p2

    .line 27
    iput p4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->B:F

    .line 28
    .line 29
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->G:Landroid/graphics/Matrix;

    .line 30
    .line 31
    if-nez p1, :cond_0

    .line 32
    .line 33
    goto :goto_0

    .line 34
    :cond_0
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->A:F

    .line 35
    .line 36
    iput p4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->B:F

    .line 37
    .line 38
    invoke-virtual {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->d()V

    .line 39
    .line 40
    .line 41
    :goto_0
    invoke-virtual {p0}, Landroid/view/View;->getMeasuredHeight()I

    .line 42
    .line 43
    .line 44
    move-result p1

    .line 45
    if-ne p1, v5, :cond_2

    .line 46
    .line 47
    invoke-virtual {p0}, Landroid/view/View;->getMeasuredWidth()I

    .line 48
    .line 49
    .line 50
    move-result p1

    .line 51
    if-eq p1, v3, :cond_1

    .line 52
    .line 53
    goto :goto_1

    .line 54
    :cond_1
    invoke-super {p0, v1, v0, v2, v4}, Landroid/view/View;->layout(IIII)V

    .line 55
    .line 56
    .line 57
    goto :goto_2

    .line 58
    :cond_2
    :goto_1
    const/high16 p1, 0x40000000    # 2.0f

    .line 59
    .line 60
    invoke-static {v3, p1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    .line 61
    .line 62
    .line 63
    move-result p2

    .line 64
    invoke-static {v5, p1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    .line 65
    .line 66
    .line 67
    move-result p1

    .line 68
    invoke-virtual {p0, p2, p1}, Landroid/view/View;->measure(II)V

    .line 69
    .line 70
    .line 71
    invoke-super {p0, v1, v0, v2, v4}, Landroid/view/View;->layout(IIII)V

    .line 72
    .line 73
    .line 74
    :goto_2
    iget-boolean p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->y:Z

    .line 75
    .line 76
    if-eqz p1, :cond_7

    .line 77
    .line 78
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 79
    .line 80
    iget-object p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 81
    .line 82
    if-nez p1, :cond_3

    .line 83
    .line 84
    new-instance p1, Landroid/graphics/Paint;

    .line 85
    .line 86
    invoke-direct {p1}, Landroid/graphics/Paint;-><init>()V

    .line 87
    .line 88
    .line 89
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->O:Landroid/graphics/Paint;

    .line 90
    .line 91
    new-instance p1, Landroid/graphics/Rect;

    .line 92
    .line 93
    invoke-direct {p1}, Landroid/graphics/Rect;-><init>()V

    .line 94
    .line 95
    .line 96
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 97
    .line 98
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->O:Landroid/graphics/Paint;

    .line 99
    .line 100
    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->set(Landroid/graphics/Paint;)V

    .line 101
    .line 102
    .line 103
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->O:Landroid/graphics/Paint;

    .line 104
    .line 105
    invoke-virtual {p1}, Landroid/graphics/Paint;->getTextSize()F

    .line 106
    .line 107
    .line 108
    move-result p1

    .line 109
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->P:F

    .line 110
    .line 111
    :cond_3
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->A:F

    .line 112
    .line 113
    iput p4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->B:F

    .line 114
    .line 115
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->O:Landroid/graphics/Paint;

    .line 116
    .line 117
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->o:Ljava/lang/String;

    .line 118
    .line 119
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    .line 120
    .line 121
    .line 122
    move-result v1

    .line 123
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 124
    .line 125
    const/4 v3, 0x0

    .line 126
    invoke-virtual {p1, v0, v3, v1, v2}, Landroid/graphics/Paint;->getTextBounds(Ljava/lang/String;IILandroid/graphics/Rect;)V

    .line 127
    .line 128
    .line 129
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 130
    .line 131
    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    .line 132
    .line 133
    .line 134
    move-result p1

    .line 135
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 136
    .line 137
    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    .line 138
    .line 139
    .line 140
    move-result v0

    .line 141
    int-to-float v0, v0

    .line 142
    const v1, 0x3fa66666    # 1.3f

    .line 143
    .line 144
    .line 145
    mul-float/2addr v0, v1

    .line 146
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->s:I

    .line 147
    .line 148
    int-to-float v1, v1

    .line 149
    sub-float/2addr p3, v1

    .line 150
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 151
    .line 152
    int-to-float v1, v1

    .line 153
    sub-float/2addr p3, v1

    .line 154
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->u:I

    .line 155
    .line 156
    int-to-float v1, v1

    .line 157
    sub-float/2addr p4, v1

    .line 158
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 159
    .line 160
    int-to-float v1, v1

    .line 161
    sub-float/2addr p4, v1

    .line 162
    int-to-float p1, p1

    .line 163
    mul-float v1, p1, p4

    .line 164
    .line 165
    mul-float v2, v0, p3

    .line 166
    .line 167
    cmpl-float v1, v1, v2

    .line 168
    .line 169
    if-lez v1, :cond_4

    .line 170
    .line 171
    iget p4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->P:F

    .line 172
    .line 173
    mul-float/2addr p4, p3

    .line 174
    div-float/2addr p4, p1

    .line 175
    invoke-virtual {p2, p4}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 176
    .line 177
    .line 178
    goto :goto_3

    .line 179
    :cond_4
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->P:F

    .line 180
    .line 181
    mul-float/2addr p1, p4

    .line 182
    div-float/2addr p1, v0

    .line 183
    invoke-virtual {p2, p1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 184
    .line 185
    .line 186
    :goto_3
    iget-boolean p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 187
    .line 188
    if-nez p1, :cond_5

    .line 189
    .line 190
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 191
    .line 192
    invoke-static {p1}, Ljava/lang/Float;->isNaN(F)Z

    .line 193
    .line 194
    .line 195
    move-result p1

    .line 196
    if-nez p1, :cond_7

    .line 197
    .line 198
    :cond_5
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 199
    .line 200
    invoke-static {p1}, Ljava/lang/Float;->isNaN(F)Z

    .line 201
    .line 202
    .line 203
    move-result p1

    .line 204
    if-eqz p1, :cond_6

    .line 205
    .line 206
    const/high16 p1, 0x3f800000    # 1.0f

    .line 207
    .line 208
    goto :goto_4

    .line 209
    :cond_6
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 210
    .line 211
    iget p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 212
    .line 213
    div-float/2addr p1, p2

    .line 214
    :goto_4
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/utils/widget/MotionLabel;->a(F)V

    .line 215
    .line 216
    .line 217
    :cond_7
    return-void
.end method

.method public final d()V
    .locals 11

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->Q:F

    .line 2
    .line 3
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    .line 4
    .line 5
    .line 6
    move-result v0

    .line 7
    const/4 v1, 0x0

    .line 8
    if-eqz v0, :cond_0

    .line 9
    .line 10
    move v0, v1

    .line 11
    goto :goto_0

    .line 12
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->Q:F

    .line 13
    .line 14
    :goto_0
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->R:F

    .line 15
    .line 16
    invoke-static {v2}, Ljava/lang/Float;->isNaN(F)Z

    .line 17
    .line 18
    .line 19
    move-result v2

    .line 20
    if-eqz v2, :cond_1

    .line 21
    .line 22
    move v2, v1

    .line 23
    goto :goto_1

    .line 24
    :cond_1
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->R:F

    .line 25
    .line 26
    :goto_1
    iget v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->S:F

    .line 27
    .line 28
    invoke-static {v3}, Ljava/lang/Float;->isNaN(F)Z

    .line 29
    .line 30
    .line 31
    move-result v3

    .line 32
    if-eqz v3, :cond_2

    .line 33
    .line 34
    const/high16 v3, 0x3f800000    # 1.0f

    .line 35
    .line 36
    goto :goto_2

    .line 37
    :cond_2
    iget v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->S:F

    .line 38
    .line 39
    :goto_2
    iget v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->T:F

    .line 40
    .line 41
    invoke-static {v4}, Ljava/lang/Float;->isNaN(F)Z

    .line 42
    .line 43
    .line 44
    move-result v4

    .line 45
    if-eqz v4, :cond_3

    .line 46
    .line 47
    goto :goto_3

    .line 48
    :cond_3
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->T:F

    .line 49
    .line 50
    :goto_3
    iget-object v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->G:Landroid/graphics/Matrix;

    .line 51
    .line 52
    invoke-virtual {v4}, Landroid/graphics/Matrix;->reset()V

    .line 53
    .line 54
    .line 55
    iget-object v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->E:Landroid/graphics/Bitmap;

    .line 56
    .line 57
    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    .line 58
    .line 59
    .line 60
    move-result v4

    .line 61
    int-to-float v4, v4

    .line 62
    iget-object v5, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->E:Landroid/graphics/Bitmap;

    .line 63
    .line 64
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getHeight()I

    .line 65
    .line 66
    .line 67
    move-result v5

    .line 68
    int-to-float v5, v5

    .line 69
    iget v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 70
    .line 71
    invoke-static {v6}, Ljava/lang/Float;->isNaN(F)Z

    .line 72
    .line 73
    .line 74
    move-result v6

    .line 75
    if-eqz v6, :cond_4

    .line 76
    .line 77
    iget v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->A:F

    .line 78
    .line 79
    goto :goto_4

    .line 80
    :cond_4
    iget v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 81
    .line 82
    :goto_4
    iget v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 83
    .line 84
    invoke-static {v7}, Ljava/lang/Float;->isNaN(F)Z

    .line 85
    .line 86
    .line 87
    move-result v7

    .line 88
    if-eqz v7, :cond_5

    .line 89
    .line 90
    iget v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->B:F

    .line 91
    .line 92
    goto :goto_5

    .line 93
    :cond_5
    iget v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 94
    .line 95
    :goto_5
    mul-float v8, v4, v7

    .line 96
    .line 97
    mul-float v9, v5, v6

    .line 98
    .line 99
    cmpg-float v8, v8, v9

    .line 100
    .line 101
    if-gez v8, :cond_6

    .line 102
    .line 103
    div-float v8, v6, v4

    .line 104
    .line 105
    goto :goto_6

    .line 106
    :cond_6
    div-float v8, v7, v5

    .line 107
    .line 108
    :goto_6
    mul-float/2addr v3, v8

    .line 109
    iget-object v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->G:Landroid/graphics/Matrix;

    .line 110
    .line 111
    invoke-virtual {v8, v3, v3}, Landroid/graphics/Matrix;->postScale(FF)Z

    .line 112
    .line 113
    .line 114
    mul-float/2addr v4, v3

    .line 115
    sub-float v8, v6, v4

    .line 116
    .line 117
    mul-float/2addr v3, v5

    .line 118
    sub-float v5, v7, v3

    .line 119
    .line 120
    iget v9, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 121
    .line 122
    invoke-static {v9}, Ljava/lang/Float;->isNaN(F)Z

    .line 123
    .line 124
    .line 125
    move-result v9

    .line 126
    const/high16 v10, 0x40000000    # 2.0f

    .line 127
    .line 128
    if-nez v9, :cond_7

    .line 129
    .line 130
    iget v5, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 131
    .line 132
    div-float/2addr v5, v10

    .line 133
    :cond_7
    iget v9, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 134
    .line 135
    invoke-static {v9}, Ljava/lang/Float;->isNaN(F)Z

    .line 136
    .line 137
    .line 138
    move-result v9

    .line 139
    if-nez v9, :cond_8

    .line 140
    .line 141
    iget v8, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 142
    .line 143
    div-float/2addr v8, v10

    .line 144
    :cond_8
    mul-float/2addr v0, v8

    .line 145
    add-float/2addr v0, v6

    .line 146
    sub-float/2addr v0, v4

    .line 147
    const/high16 v4, 0x3f000000    # 0.5f

    .line 148
    .line 149
    mul-float/2addr v0, v4

    .line 150
    mul-float/2addr v2, v5

    .line 151
    add-float/2addr v2, v7

    .line 152
    sub-float/2addr v2, v3

    .line 153
    mul-float/2addr v2, v4

    .line 154
    iget-object v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->G:Landroid/graphics/Matrix;

    .line 155
    .line 156
    invoke-virtual {v3, v0, v2}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    .line 157
    .line 158
    .line 159
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->G:Landroid/graphics/Matrix;

    .line 160
    .line 161
    div-float/2addr v6, v10

    .line 162
    div-float/2addr v7, v10

    .line 163
    invoke-virtual {v0, v1, v6, v7}, Landroid/graphics/Matrix;->postRotate(FFF)Z

    .line 164
    .line 165
    .line 166
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->F:Landroid/graphics/BitmapShader;

    .line 167
    .line 168
    iget-object v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->G:Landroid/graphics/Matrix;

    .line 169
    .line 170
    invoke-virtual {v0, v1}, Landroid/graphics/Shader;->setLocalMatrix(Landroid/graphics/Matrix;)V

    .line 171
    .line 172
    .line 173
    return-void
.end method

.method public getRound()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->g:F

    .line 2
    .line 3
    return v0
.end method

.method public getRoundPercent()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    .line 2
    .line 3
    return v0
.end method

.method public getScaleFromTextSize()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 2
    .line 3
    return v0
.end method

.method public getTextBackgroundPanX()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->Q:F

    .line 2
    .line 3
    return v0
.end method

.method public getTextBackgroundPanY()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->R:F

    .line 2
    .line 3
    return v0
.end method

.method public getTextBackgroundRotate()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->T:F

    .line 2
    .line 3
    return v0
.end method

.method public getTextBackgroundZoom()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->S:F

    .line 2
    .line 3
    return v0
.end method

.method public getTextOutlineColor()I
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->d:I

    .line 2
    .line 3
    return v0
.end method

.method public getTextPanX()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 2
    .line 3
    return v0
.end method

.method public getTextPanY()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 2
    .line 3
    return v0
.end method

.method public getTextureHeight()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 2
    .line 3
    return v0
.end method

.method public getTextureWidth()F
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 2
    .line 3
    return v0
.end method

.method public getTypeface()Landroid/graphics/Typeface;
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 2
    .line 3
    invoke-virtual {v0}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    return-object v0
.end method

.method public final layout(IIII)V
    .locals 9

    .line 1
    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/View;->layout(IIII)V

    .line 2
    .line 3
    .line 4
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 5
    .line 6
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    .line 7
    .line 8
    .line 9
    move-result v0

    .line 10
    if-eqz v0, :cond_0

    .line 11
    .line 12
    const/high16 v1, 0x3f800000    # 1.0f

    .line 13
    .line 14
    goto :goto_0

    .line 15
    :cond_0
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 16
    .line 17
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 18
    .line 19
    div-float/2addr v1, v2

    .line 20
    :goto_0
    sub-int v2, p3, p1

    .line 21
    .line 22
    int-to-float v2, v2

    .line 23
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->A:F

    .line 24
    .line 25
    sub-int v2, p4, p2

    .line 26
    .line 27
    int-to-float v2, v2

    .line 28
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->B:F

    .line 29
    .line 30
    iget-boolean v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->y:Z

    .line 31
    .line 32
    if-eqz v2, :cond_5

    .line 33
    .line 34
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 35
    .line 36
    iget-object v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 37
    .line 38
    if-nez v2, :cond_1

    .line 39
    .line 40
    new-instance v2, Landroid/graphics/Paint;

    .line 41
    .line 42
    invoke-direct {v2}, Landroid/graphics/Paint;-><init>()V

    .line 43
    .line 44
    .line 45
    iput-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->O:Landroid/graphics/Paint;

    .line 46
    .line 47
    new-instance v2, Landroid/graphics/Rect;

    .line 48
    .line 49
    invoke-direct {v2}, Landroid/graphics/Rect;-><init>()V

    .line 50
    .line 51
    .line 52
    iput-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 53
    .line 54
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->O:Landroid/graphics/Paint;

    .line 55
    .line 56
    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->set(Landroid/graphics/Paint;)V

    .line 57
    .line 58
    .line 59
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->O:Landroid/graphics/Paint;

    .line 60
    .line 61
    invoke-virtual {v2}, Landroid/graphics/Paint;->getTextSize()F

    .line 62
    .line 63
    .line 64
    move-result v2

    .line 65
    iput v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->P:F

    .line 66
    .line 67
    :cond_1
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->O:Landroid/graphics/Paint;

    .line 68
    .line 69
    iget-object v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->o:Ljava/lang/String;

    .line 70
    .line 71
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    .line 72
    .line 73
    .line 74
    move-result v5

    .line 75
    iget-object v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 76
    .line 77
    const/4 v7, 0x0

    .line 78
    invoke-virtual {v2, v4, v7, v5, v6}, Landroid/graphics/Paint;->getTextBounds(Ljava/lang/String;IILandroid/graphics/Rect;)V

    .line 79
    .line 80
    .line 81
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 82
    .line 83
    invoke-virtual {v2}, Landroid/graphics/Rect;->width()I

    .line 84
    .line 85
    .line 86
    move-result v2

    .line 87
    iget-object v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->N:Landroid/graphics/Rect;

    .line 88
    .line 89
    invoke-virtual {v4}, Landroid/graphics/Rect;->height()I

    .line 90
    .line 91
    .line 92
    move-result v4

    .line 93
    int-to-float v4, v4

    .line 94
    const v5, 0x3fa66666    # 1.3f

    .line 95
    .line 96
    .line 97
    mul-float/2addr v4, v5

    .line 98
    float-to-int v4, v4

    .line 99
    iget v5, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->A:F

    .line 100
    .line 101
    iget v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->s:I

    .line 102
    .line 103
    int-to-float v6, v6

    .line 104
    sub-float/2addr v5, v6

    .line 105
    iget v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 106
    .line 107
    int-to-float v6, v6

    .line 108
    sub-float/2addr v5, v6

    .line 109
    iget v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->B:F

    .line 110
    .line 111
    iget v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->u:I

    .line 112
    .line 113
    int-to-float v7, v7

    .line 114
    sub-float/2addr v6, v7

    .line 115
    iget v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 116
    .line 117
    int-to-float v7, v7

    .line 118
    sub-float/2addr v6, v7

    .line 119
    if-eqz v0, :cond_3

    .line 120
    .line 121
    int-to-float v2, v2

    .line 122
    mul-float v7, v2, v6

    .line 123
    .line 124
    int-to-float v4, v4

    .line 125
    mul-float v8, v4, v5

    .line 126
    .line 127
    cmpl-float v7, v7, v8

    .line 128
    .line 129
    if-lez v7, :cond_2

    .line 130
    .line 131
    iget v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->P:F

    .line 132
    .line 133
    mul-float/2addr v4, v5

    .line 134
    div-float/2addr v4, v2

    .line 135
    invoke-virtual {v3, v4}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 136
    .line 137
    .line 138
    goto :goto_1

    .line 139
    :cond_2
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->P:F

    .line 140
    .line 141
    mul-float/2addr v2, v6

    .line 142
    div-float/2addr v2, v4

    .line 143
    invoke-virtual {v3, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 144
    .line 145
    .line 146
    goto :goto_1

    .line 147
    :cond_3
    int-to-float v1, v2

    .line 148
    mul-float v2, v1, v6

    .line 149
    .line 150
    int-to-float v3, v4

    .line 151
    mul-float v4, v3, v5

    .line 152
    .line 153
    cmpl-float v2, v2, v4

    .line 154
    .line 155
    if-lez v2, :cond_4

    .line 156
    .line 157
    div-float/2addr v5, v1

    .line 158
    move v1, v5

    .line 159
    goto :goto_1

    .line 160
    :cond_4
    div-float/2addr v6, v3

    .line 161
    move v1, v6

    .line 162
    :cond_5
    :goto_1
    iget-boolean v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 163
    .line 164
    if-nez v2, :cond_6

    .line 165
    .line 166
    if-nez v0, :cond_8

    .line 167
    .line 168
    :cond_6
    int-to-float p1, p1

    .line 169
    int-to-float p2, p2

    .line 170
    int-to-float p3, p3

    .line 171
    int-to-float p4, p4

    .line 172
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->G:Landroid/graphics/Matrix;

    .line 173
    .line 174
    if-nez v0, :cond_7

    .line 175
    .line 176
    goto :goto_2

    .line 177
    :cond_7
    sub-float/2addr p3, p1

    .line 178
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->A:F

    .line 179
    .line 180
    sub-float/2addr p4, p2

    .line 181
    iput p4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->B:F

    .line 182
    .line 183
    invoke-virtual {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->d()V

    .line 184
    .line 185
    .line 186
    :goto_2
    invoke-virtual {p0, v1}, Landroidx/constraintlayout/utils/widget/MotionLabel;->a(F)V

    .line 187
    .line 188
    .line 189
    :cond_8
    return-void
.end method

.method public final onDraw(Landroid/graphics/Canvas;)V
    .locals 6

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 2
    .line 3
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    .line 4
    .line 5
    .line 6
    move-result v0

    .line 7
    const/high16 v1, 0x3f800000    # 1.0f

    .line 8
    .line 9
    if-eqz v0, :cond_0

    .line 10
    .line 11
    move v0, v1

    .line 12
    goto :goto_0

    .line 13
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 14
    .line 15
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 16
    .line 17
    div-float/2addr v0, v2

    .line 18
    :goto_0
    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    .line 19
    .line 20
    .line 21
    iget-boolean v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 22
    .line 23
    iget-object v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 24
    .line 25
    if-nez v2, :cond_1

    .line 26
    .line 27
    cmpl-float v1, v0, v1

    .line 28
    .line 29
    if-nez v1, :cond_1

    .line 30
    .line 31
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 32
    .line 33
    int-to-float v0, v0

    .line 34
    invoke-direct {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->getHorizontalOffset()F

    .line 35
    .line 36
    .line 37
    move-result v1

    .line 38
    add-float/2addr v0, v1

    .line 39
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 40
    .line 41
    int-to-float v1, v1

    .line 42
    invoke-direct {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->getVerticalOffset()F

    .line 43
    .line 44
    .line 45
    move-result v2

    .line 46
    add-float/2addr v1, v2

    .line 47
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->o:Ljava/lang/String;

    .line 48
    .line 49
    iget v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->z:F

    .line 50
    .line 51
    add-float/2addr v4, v0

    .line 52
    invoke-virtual {p1, v2, v4, v1, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 53
    .line 54
    .line 55
    return-void

    .line 56
    :cond_1
    iget-boolean v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->p:Z

    .line 57
    .line 58
    if-eqz v1, :cond_2

    .line 59
    .line 60
    invoke-virtual {p0, v0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->a(F)V

    .line 61
    .line 62
    .line 63
    :cond_2
    iget-object v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 64
    .line 65
    if-nez v1, :cond_3

    .line 66
    .line 67
    new-instance v1, Landroid/graphics/Matrix;

    .line 68
    .line 69
    invoke-direct {v1}, Landroid/graphics/Matrix;-><init>()V

    .line 70
    .line 71
    .line 72
    iput-object v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 73
    .line 74
    :cond_3
    iget-boolean v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 75
    .line 76
    if-eqz v1, :cond_6

    .line 77
    .line 78
    iget-object v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->L:Landroid/graphics/Paint;

    .line 79
    .line 80
    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->set(Landroid/graphics/Paint;)V

    .line 81
    .line 82
    .line 83
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 84
    .line 85
    invoke-virtual {v2}, Landroid/graphics/Matrix;->reset()V

    .line 86
    .line 87
    .line 88
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 89
    .line 90
    int-to-float v2, v2

    .line 91
    invoke-direct {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->getHorizontalOffset()F

    .line 92
    .line 93
    .line 94
    move-result v4

    .line 95
    add-float/2addr v2, v4

    .line 96
    iget v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 97
    .line 98
    int-to-float v4, v4

    .line 99
    invoke-direct {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->getVerticalOffset()F

    .line 100
    .line 101
    .line 102
    move-result v5

    .line 103
    add-float/2addr v4, v5

    .line 104
    iget-object v5, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 105
    .line 106
    invoke-virtual {v5, v2, v4}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    .line 107
    .line 108
    .line 109
    iget-object v5, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 110
    .line 111
    invoke-virtual {v5, v0, v0}, Landroid/graphics/Matrix;->preScale(FF)Z

    .line 112
    .line 113
    .line 114
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 115
    .line 116
    iget-object v5, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 117
    .line 118
    invoke-virtual {v0, v5}, Landroid/graphics/Path;->transform(Landroid/graphics/Matrix;)V

    .line 119
    .line 120
    .line 121
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->F:Landroid/graphics/BitmapShader;

    .line 122
    .line 123
    if-eqz v0, :cond_4

    .line 124
    .line 125
    const/4 v0, 0x1

    .line 126
    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    .line 127
    .line 128
    .line 129
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->F:Landroid/graphics/BitmapShader;

    .line 130
    .line 131
    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 132
    .line 133
    .line 134
    goto :goto_1

    .line 135
    :cond_4
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->c:I

    .line 136
    .line 137
    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 138
    .line 139
    .line 140
    :goto_1
    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    .line 141
    .line 142
    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 143
    .line 144
    .line 145
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 146
    .line 147
    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 148
    .line 149
    .line 150
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 151
    .line 152
    invoke-virtual {p1, v0, v3}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 153
    .line 154
    .line 155
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->F:Landroid/graphics/BitmapShader;

    .line 156
    .line 157
    if-eqz v0, :cond_5

    .line 158
    .line 159
    const/4 v0, 0x0

    .line 160
    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 161
    .line 162
    .line 163
    :cond_5
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->d:I

    .line 164
    .line 165
    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 166
    .line 167
    .line 168
    sget-object v0, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    .line 169
    .line 170
    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 171
    .line 172
    .line 173
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 174
    .line 175
    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 176
    .line 177
    .line 178
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 179
    .line 180
    invoke-virtual {p1, v0, v3}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 181
    .line 182
    .line 183
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 184
    .line 185
    invoke-virtual {p1}, Landroid/graphics/Matrix;->reset()V

    .line 186
    .line 187
    .line 188
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 189
    .line 190
    neg-float v0, v2

    .line 191
    neg-float v2, v4

    .line 192
    invoke-virtual {p1, v0, v2}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    .line 193
    .line 194
    .line 195
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 196
    .line 197
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 198
    .line 199
    invoke-virtual {p1, v0}, Landroid/graphics/Path;->transform(Landroid/graphics/Matrix;)V

    .line 200
    .line 201
    .line 202
    invoke-virtual {v3, v1}, Landroid/graphics/Paint;->set(Landroid/graphics/Paint;)V

    .line 203
    .line 204
    .line 205
    goto :goto_2

    .line 206
    :cond_6
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 207
    .line 208
    int-to-float v0, v0

    .line 209
    invoke-direct {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->getHorizontalOffset()F

    .line 210
    .line 211
    .line 212
    move-result v1

    .line 213
    add-float/2addr v0, v1

    .line 214
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 215
    .line 216
    int-to-float v1, v1

    .line 217
    invoke-direct {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->getVerticalOffset()F

    .line 218
    .line 219
    .line 220
    move-result v2

    .line 221
    add-float/2addr v1, v2

    .line 222
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 223
    .line 224
    invoke-virtual {v2}, Landroid/graphics/Matrix;->reset()V

    .line 225
    .line 226
    .line 227
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 228
    .line 229
    invoke-virtual {v2, v0, v1}, Landroid/graphics/Matrix;->preTranslate(FF)Z

    .line 230
    .line 231
    .line 232
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 233
    .line 234
    iget-object v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 235
    .line 236
    invoke-virtual {v2, v4}, Landroid/graphics/Path;->transform(Landroid/graphics/Matrix;)V

    .line 237
    .line 238
    .line 239
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->c:I

    .line 240
    .line 241
    invoke-virtual {v3, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 242
    .line 243
    .line 244
    sget-object v2, Landroid/graphics/Paint$Style;->FILL_AND_STROKE:Landroid/graphics/Paint$Style;

    .line 245
    .line 246
    invoke-virtual {v3, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 247
    .line 248
    .line 249
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 250
    .line 251
    invoke-virtual {v3, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 252
    .line 253
    .line 254
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 255
    .line 256
    invoke-virtual {p1, v2, v3}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 257
    .line 258
    .line 259
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 260
    .line 261
    invoke-virtual {p1}, Landroid/graphics/Matrix;->reset()V

    .line 262
    .line 263
    .line 264
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 265
    .line 266
    neg-float v0, v0

    .line 267
    neg-float v1, v1

    .line 268
    invoke-virtual {p1, v0, v1}, Landroid/graphics/Matrix;->preTranslate(FF)Z

    .line 269
    .line 270
    .line 271
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 272
    .line 273
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->D:Landroid/graphics/Matrix;

    .line 274
    .line 275
    invoke-virtual {p1, v0}, Landroid/graphics/Path;->transform(Landroid/graphics/Matrix;)V

    .line 276
    .line 277
    .line 278
    :goto_2
    return-void
.end method

.method public final onMeasure(II)V
    .locals 8

    .line 1
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getMode(I)I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getMode(I)I

    .line 6
    .line 7
    .line 8
    move-result v1

    .line 9
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    .line 10
    .line 11
    .line 12
    move-result p1

    .line 13
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    .line 14
    .line 15
    .line 16
    move-result p2

    .line 17
    const/4 v2, 0x0

    .line 18
    iput-boolean v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->y:Z

    .line 19
    .line 20
    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    .line 21
    .line 22
    .line 23
    move-result v3

    .line 24
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 25
    .line 26
    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    .line 27
    .line 28
    .line 29
    move-result v3

    .line 30
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->s:I

    .line 31
    .line 32
    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    .line 33
    .line 34
    .line 35
    move-result v3

    .line 36
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 37
    .line 38
    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    .line 39
    .line 40
    .line 41
    move-result v3

    .line 42
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->u:I

    .line 43
    .line 44
    const/high16 v3, 0x40000000    # 2.0f

    .line 45
    .line 46
    if-ne v0, v3, :cond_1

    .line 47
    .line 48
    if-eq v1, v3, :cond_0

    .line 49
    .line 50
    goto :goto_0

    .line 51
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->x:I

    .line 52
    .line 53
    if-eqz v0, :cond_4

    .line 54
    .line 55
    const/4 v0, 0x1

    .line 56
    iput-boolean v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->y:Z

    .line 57
    .line 58
    goto :goto_1

    .line 59
    :cond_1
    :goto_0
    iget-object v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->o:Ljava/lang/String;

    .line 60
    .line 61
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    .line 62
    .line 63
    .line 64
    move-result v5

    .line 65
    iget-object v6, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 66
    .line 67
    iget-object v7, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->q:Landroid/graphics/Rect;

    .line 68
    .line 69
    invoke-virtual {v6, v4, v2, v5, v7}, Landroid/graphics/Paint;->getTextBounds(Ljava/lang/String;IILandroid/graphics/Rect;)V

    .line 70
    .line 71
    .line 72
    const v2, 0x3f7fff58    # 0.99999f

    .line 73
    .line 74
    .line 75
    if-eq v0, v3, :cond_2

    .line 76
    .line 77
    invoke-virtual {v7}, Landroid/graphics/Rect;->width()I

    .line 78
    .line 79
    .line 80
    move-result p1

    .line 81
    int-to-float p1, p1

    .line 82
    add-float/2addr p1, v2

    .line 83
    float-to-int p1, p1

    .line 84
    :cond_2
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->r:I

    .line 85
    .line 86
    iget v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->s:I

    .line 87
    .line 88
    add-int/2addr v0, v4

    .line 89
    add-int/2addr p1, v0

    .line 90
    if-eq v1, v3, :cond_4

    .line 91
    .line 92
    const/4 v0, 0x0

    .line 93
    invoke-virtual {v6, v0}, Landroid/graphics/Paint;->getFontMetricsInt(Landroid/graphics/Paint$FontMetricsInt;)I

    .line 94
    .line 95
    .line 96
    move-result v0

    .line 97
    int-to-float v0, v0

    .line 98
    add-float/2addr v0, v2

    .line 99
    float-to-int v0, v0

    .line 100
    const/high16 v2, -0x80000000

    .line 101
    .line 102
    if-ne v1, v2, :cond_3

    .line 103
    .line 104
    invoke-static {p2, v0}, Ljava/lang/Math;->min(II)I

    .line 105
    .line 106
    .line 107
    move-result v0

    .line 108
    :cond_3
    iget p2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->t:I

    .line 109
    .line 110
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->u:I

    .line 111
    .line 112
    add-int/2addr p2, v1

    .line 113
    add-int/2addr p2, v0

    .line 114
    :cond_4
    :goto_1
    invoke-virtual {p0, p1, p2}, Landroid/view/View;->setMeasuredDimension(II)V

    .line 115
    .line 116
    .line 117
    return-void
.end method

.method public setGravity(I)V
    .locals 7
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "RtlHardcoded"
        }
    .end annotation

    .line 1
    const v0, 0x800007

    .line 2
    .line 3
    .line 4
    and-int v1, p1, v0

    .line 5
    .line 6
    const v2, 0x800003

    .line 7
    .line 8
    .line 9
    if-nez v1, :cond_0

    .line 10
    .line 11
    or-int/2addr p1, v2

    .line 12
    :cond_0
    and-int/lit8 v1, p1, 0x70

    .line 13
    .line 14
    if-nez v1, :cond_1

    .line 15
    .line 16
    or-int/lit8 p1, p1, 0x30

    .line 17
    .line 18
    :cond_1
    iget v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->w:I

    .line 19
    .line 20
    if-eq p1, v1, :cond_2

    .line 21
    .line 22
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 23
    .line 24
    .line 25
    :cond_2
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->w:I

    .line 26
    .line 27
    and-int/lit8 v1, p1, 0x70

    .line 28
    .line 29
    const/high16 v3, -0x40800000    # -1.0f

    .line 30
    .line 31
    const/high16 v4, 0x3f800000    # 1.0f

    .line 32
    .line 33
    const/4 v5, 0x0

    .line 34
    const/16 v6, 0x30

    .line 35
    .line 36
    if-eq v1, v6, :cond_4

    .line 37
    .line 38
    const/16 v6, 0x50

    .line 39
    .line 40
    if-eq v1, v6, :cond_3

    .line 41
    .line 42
    iput v5, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 43
    .line 44
    goto :goto_0

    .line 45
    :cond_3
    iput v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 46
    .line 47
    goto :goto_0

    .line 48
    :cond_4
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 49
    .line 50
    :goto_0
    and-int/2addr p1, v0

    .line 51
    const/4 v0, 0x3

    .line 52
    if-eq p1, v0, :cond_6

    .line 53
    .line 54
    const/4 v0, 0x5

    .line 55
    if-eq p1, v0, :cond_5

    .line 56
    .line 57
    if-eq p1, v2, :cond_6

    .line 58
    .line 59
    const v0, 0x800005

    .line 60
    .line 61
    .line 62
    if-eq p1, v0, :cond_5

    .line 63
    .line 64
    iput v5, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 65
    .line 66
    goto :goto_1

    .line 67
    :cond_5
    iput v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 68
    .line 69
    goto :goto_1

    .line 70
    :cond_6
    iput v3, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 71
    .line 72
    :goto_1
    return-void
.end method

.method public setRound(F)V
    .locals 4

    .line 1
    invoke-static {p1}, Ljava/lang/Float;->isNaN(F)Z

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    if-eqz v0, :cond_0

    .line 6
    .line 7
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->g:F

    .line 8
    .line 9
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    .line 10
    .line 11
    const/high16 v0, -0x40800000    # -1.0f

    .line 12
    .line 13
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    .line 14
    .line 15
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/utils/widget/MotionLabel;->setRoundPercent(F)V

    .line 16
    .line 17
    .line 18
    return-void

    .line 19
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->g:F

    .line 20
    .line 21
    cmpl-float v0, v0, p1

    .line 22
    .line 23
    const/4 v1, 0x0

    .line 24
    const/4 v2, 0x1

    .line 25
    if-eqz v0, :cond_1

    .line 26
    .line 27
    move v0, v2

    .line 28
    goto :goto_0

    .line 29
    :cond_1
    move v0, v1

    .line 30
    :goto_0
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->g:F

    .line 31
    .line 32
    const/4 v3, 0x0

    .line 33
    cmpl-float p1, p1, v3

    .line 34
    .line 35
    if-eqz p1, :cond_5

    .line 36
    .line 37
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 38
    .line 39
    if-nez p1, :cond_2

    .line 40
    .line 41
    new-instance p1, Landroid/graphics/Path;

    .line 42
    .line 43
    invoke-direct {p1}, Landroid/graphics/Path;-><init>()V

    .line 44
    .line 45
    .line 46
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 47
    .line 48
    :cond_2
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->i:Landroid/graphics/RectF;

    .line 49
    .line 50
    if-nez p1, :cond_3

    .line 51
    .line 52
    new-instance p1, Landroid/graphics/RectF;

    .line 53
    .line 54
    invoke-direct {p1}, Landroid/graphics/RectF;-><init>()V

    .line 55
    .line 56
    .line 57
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->i:Landroid/graphics/RectF;

    .line 58
    .line 59
    :cond_3
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->h:Landroid/view/ViewOutlineProvider;

    .line 60
    .line 61
    if-nez p1, :cond_4

    .line 62
    .line 63
    new-instance p1, Li1/e;

    .line 64
    .line 65
    const/4 v1, 0x1

    .line 66
    invoke-direct {p1, p0, v1}, Li1/e;-><init>(Landroidx/constraintlayout/utils/widget/MotionLabel;I)V

    .line 67
    .line 68
    .line 69
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->h:Landroid/view/ViewOutlineProvider;

    .line 70
    .line 71
    invoke-virtual {p0, p1}, Landroid/view/View;->setOutlineProvider(Landroid/view/ViewOutlineProvider;)V

    .line 72
    .line 73
    .line 74
    :cond_4
    invoke-virtual {p0, v2}, Landroid/view/View;->setClipToOutline(Z)V

    .line 75
    .line 76
    .line 77
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    .line 78
    .line 79
    .line 80
    move-result p1

    .line 81
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    .line 82
    .line 83
    .line 84
    move-result v1

    .line 85
    iget-object v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->i:Landroid/graphics/RectF;

    .line 86
    .line 87
    int-to-float p1, p1

    .line 88
    int-to-float v1, v1

    .line 89
    invoke-virtual {v2, v3, v3, p1, v1}, Landroid/graphics/RectF;->set(FFFF)V

    .line 90
    .line 91
    .line 92
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 93
    .line 94
    invoke-virtual {p1}, Landroid/graphics/Path;->reset()V

    .line 95
    .line 96
    .line 97
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 98
    .line 99
    iget-object v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->i:Landroid/graphics/RectF;

    .line 100
    .line 101
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->g:F

    .line 102
    .line 103
    sget-object v3, Landroid/graphics/Path$Direction;->CW:Landroid/graphics/Path$Direction;

    .line 104
    .line 105
    invoke-virtual {p1, v1, v2, v2, v3}, Landroid/graphics/Path;->addRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Path$Direction;)V

    .line 106
    .line 107
    .line 108
    goto :goto_1

    .line 109
    :cond_5
    invoke-virtual {p0, v1}, Landroid/view/View;->setClipToOutline(Z)V

    .line 110
    .line 111
    .line 112
    :goto_1
    if-eqz v0, :cond_6

    .line 113
    .line 114
    invoke-virtual {p0}, Landroid/view/View;->invalidateOutline()V

    .line 115
    .line 116
    .line 117
    :cond_6
    return-void
.end method

.method public setRoundPercent(F)V
    .locals 5

    .line 1
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    .line 2
    .line 3
    cmpl-float v0, v0, p1

    .line 4
    .line 5
    const/4 v1, 0x0

    .line 6
    const/4 v2, 0x1

    .line 7
    if-eqz v0, :cond_0

    .line 8
    .line 9
    move v0, v2

    .line 10
    goto :goto_0

    .line 11
    :cond_0
    move v0, v1

    .line 12
    :goto_0
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    .line 13
    .line 14
    const/4 v3, 0x0

    .line 15
    cmpl-float p1, p1, v3

    .line 16
    .line 17
    if-eqz p1, :cond_4

    .line 18
    .line 19
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 20
    .line 21
    if-nez p1, :cond_1

    .line 22
    .line 23
    new-instance p1, Landroid/graphics/Path;

    .line 24
    .line 25
    invoke-direct {p1}, Landroid/graphics/Path;-><init>()V

    .line 26
    .line 27
    .line 28
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 29
    .line 30
    :cond_1
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->i:Landroid/graphics/RectF;

    .line 31
    .line 32
    if-nez p1, :cond_2

    .line 33
    .line 34
    new-instance p1, Landroid/graphics/RectF;

    .line 35
    .line 36
    invoke-direct {p1}, Landroid/graphics/RectF;-><init>()V

    .line 37
    .line 38
    .line 39
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->i:Landroid/graphics/RectF;

    .line 40
    .line 41
    :cond_2
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->h:Landroid/view/ViewOutlineProvider;

    .line 42
    .line 43
    if-nez p1, :cond_3

    .line 44
    .line 45
    new-instance p1, Li1/e;

    .line 46
    .line 47
    const/4 v1, 0x0

    .line 48
    invoke-direct {p1, p0, v1}, Li1/e;-><init>(Landroidx/constraintlayout/utils/widget/MotionLabel;I)V

    .line 49
    .line 50
    .line 51
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->h:Landroid/view/ViewOutlineProvider;

    .line 52
    .line 53
    invoke-virtual {p0, p1}, Landroid/view/View;->setOutlineProvider(Landroid/view/ViewOutlineProvider;)V

    .line 54
    .line 55
    .line 56
    :cond_3
    invoke-virtual {p0, v2}, Landroid/view/View;->setClipToOutline(Z)V

    .line 57
    .line 58
    .line 59
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    .line 60
    .line 61
    .line 62
    move-result p1

    .line 63
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    .line 64
    .line 65
    .line 66
    move-result v1

    .line 67
    invoke-static {p1, v1}, Ljava/lang/Math;->min(II)I

    .line 68
    .line 69
    .line 70
    move-result v2

    .line 71
    int-to-float v2, v2

    .line 72
    iget v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->f:F

    .line 73
    .line 74
    mul-float/2addr v2, v4

    .line 75
    const/high16 v4, 0x40000000    # 2.0f

    .line 76
    .line 77
    div-float/2addr v2, v4

    .line 78
    iget-object v4, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->i:Landroid/graphics/RectF;

    .line 79
    .line 80
    int-to-float p1, p1

    .line 81
    int-to-float v1, v1

    .line 82
    invoke-virtual {v4, v3, v3, p1, v1}, Landroid/graphics/RectF;->set(FFFF)V

    .line 83
    .line 84
    .line 85
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 86
    .line 87
    invoke-virtual {p1}, Landroid/graphics/Path;->reset()V

    .line 88
    .line 89
    .line 90
    iget-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->b:Landroid/graphics/Path;

    .line 91
    .line 92
    iget-object v1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->i:Landroid/graphics/RectF;

    .line 93
    .line 94
    sget-object v3, Landroid/graphics/Path$Direction;->CW:Landroid/graphics/Path$Direction;

    .line 95
    .line 96
    invoke-virtual {p1, v1, v2, v2, v3}, Landroid/graphics/Path;->addRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Path$Direction;)V

    .line 97
    .line 98
    .line 99
    goto :goto_1

    .line 100
    :cond_4
    invoke-virtual {p0, v1}, Landroid/view/View;->setClipToOutline(Z)V

    .line 101
    .line 102
    .line 103
    :goto_1
    if-eqz v0, :cond_5

    .line 104
    .line 105
    invoke-virtual {p0}, Landroid/view/View;->invalidateOutline()V

    .line 106
    .line 107
    .line 108
    :cond_5
    return-void
.end method

.method public setScaleFromTextSize(F)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 2
    .line 3
    return-void
.end method

.method public setText(Ljava/lang/CharSequence;)V
    .locals 0

    .line 1
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    .line 2
    .line 3
    .line 4
    move-result-object p1

    .line 5
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->o:Ljava/lang/String;

    .line 6
    .line 7
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 8
    .line 9
    .line 10
    return-void
.end method

.method public setTextBackgroundPanX(F)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->Q:F

    .line 2
    .line 3
    invoke-virtual {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->d()V

    .line 4
    .line 5
    .line 6
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 7
    .line 8
    .line 9
    return-void
.end method

.method public setTextBackgroundPanY(F)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->R:F

    .line 2
    .line 3
    invoke-virtual {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->d()V

    .line 4
    .line 5
    .line 6
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 7
    .line 8
    .line 9
    return-void
.end method

.method public setTextBackgroundRotate(F)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->T:F

    .line 2
    .line 3
    invoke-virtual {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->d()V

    .line 4
    .line 5
    .line 6
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 7
    .line 8
    .line 9
    return-void
.end method

.method public setTextBackgroundZoom(F)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->S:F

    .line 2
    .line 3
    invoke-virtual {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->d()V

    .line 4
    .line 5
    .line 6
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 7
    .line 8
    .line 9
    return-void
.end method

.method public setTextFillColor(I)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->c:I

    .line 2
    .line 3
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 4
    .line 5
    .line 6
    return-void
.end method

.method public setTextOutlineColor(I)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->d:I

    .line 2
    .line 3
    const/4 p1, 0x1

    .line 4
    iput-boolean p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 5
    .line 6
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 7
    .line 8
    .line 9
    return-void
.end method

.method public setTextOutlineThickness(F)V
    .locals 1

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 2
    .line 3
    const/4 v0, 0x1

    .line 4
    iput-boolean v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 5
    .line 6
    invoke-static {p1}, Ljava/lang/Float;->isNaN(F)Z

    .line 7
    .line 8
    .line 9
    move-result p1

    .line 10
    if-eqz p1, :cond_0

    .line 11
    .line 12
    const/high16 p1, 0x3f800000    # 1.0f

    .line 13
    .line 14
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->n:F

    .line 15
    .line 16
    const/4 p1, 0x0

    .line 17
    iput-boolean p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->e:Z

    .line 18
    .line 19
    :cond_0
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 20
    .line 21
    .line 22
    return-void
.end method

.method public setTextPanX(F)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->J:F

    .line 2
    .line 3
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 4
    .line 5
    .line 6
    return-void
.end method

.method public setTextPanY(F)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->K:F

    .line 2
    .line 3
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 4
    .line 5
    .line 6
    return-void
.end method

.method public setTextSize(F)V
    .locals 1

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 2
    .line 3
    invoke-static {}, Lso/c;->u()Ljava/lang/String;

    .line 4
    .line 5
    .line 6
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 7
    .line 8
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    .line 9
    .line 10
    .line 11
    move-result v0

    .line 12
    if-eqz v0, :cond_0

    .line 13
    .line 14
    goto :goto_0

    .line 15
    :cond_0
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 16
    .line 17
    :goto_0
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 18
    .line 19
    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 20
    .line 21
    .line 22
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 23
    .line 24
    invoke-static {p1}, Ljava/lang/Float;->isNaN(F)Z

    .line 25
    .line 26
    .line 27
    move-result p1

    .line 28
    if-eqz p1, :cond_1

    .line 29
    .line 30
    const/high16 p1, 0x3f800000    # 1.0f

    .line 31
    .line 32
    goto :goto_1

    .line 33
    :cond_1
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->j:F

    .line 34
    .line 35
    iget v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->k:F

    .line 36
    .line 37
    div-float/2addr p1, v0

    .line 38
    :goto_1
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/utils/widget/MotionLabel;->a(F)V

    .line 39
    .line 40
    .line 41
    invoke-virtual {p0}, Landroid/view/View;->requestLayout()V

    .line 42
    .line 43
    .line 44
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 45
    .line 46
    .line 47
    return-void
.end method

.method public setTextureHeight(F)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->H:F

    .line 2
    .line 3
    invoke-virtual {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->d()V

    .line 4
    .line 5
    .line 6
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 7
    .line 8
    .line 9
    return-void
.end method

.method public setTextureWidth(F)V
    .locals 0

    .line 1
    iput p1, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->I:F

    .line 2
    .line 3
    invoke-virtual {p0}, Landroidx/constraintlayout/utils/widget/MotionLabel;->d()V

    .line 4
    .line 5
    .line 6
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    .line 7
    .line 8
    .line 9
    return-void
.end method

.method public setTypeface(Landroid/graphics/Typeface;)V
    .locals 2

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionLabel;->a:Landroid/text/TextPaint;

    .line 2
    .line 3
    invoke-virtual {v0}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    .line 4
    .line 5
    .line 6
    move-result-object v1

    .line 7
    if-eq v1, p1, :cond_0

    .line 8
    .line 9
    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 10
    .line 11
    .line 12
    :cond_0
    return-void
.end method
