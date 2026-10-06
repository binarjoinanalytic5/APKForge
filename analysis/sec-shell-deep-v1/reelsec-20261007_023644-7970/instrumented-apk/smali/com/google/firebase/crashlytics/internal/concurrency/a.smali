.class public final Lcom/google/firebase/crashlytics/internal/concurrency/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final d:Lqf/c;


# instance fields
.field public final a:Lqf/b;

.field public final b:Lqf/b;

.field public final c:Lqf/b;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lqf/c;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/crashlytics/internal/concurrency/a;->d:Lqf/c;

    .line 7
    .line 8
    return-void
.end method

.method public constructor <init>(Ljava/util/concurrent/ExecutorService;Ljava/util/concurrent/ExecutorService;)V
    .locals 1

    .line 1
    const-string v0, "backgroundExecutorService"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    const-string v0, "blockingExecutorService"

    .line 7
    .line 8
    invoke-static {p2, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    .line 10
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    .line 13
    .line 14
    new-instance v0, Lqf/b;

    .line 15
    .line 16
    invoke-direct {v0, p1}, Lqf/b;-><init>(Ljava/util/concurrent/ExecutorService;)V

    .line 17
    .line 18
    .line 19
    iput-object v0, p0, Lcom/google/firebase/crashlytics/internal/concurrency/a;->a:Lqf/b;

    .line 20
    .line 21
    new-instance v0, Lqf/b;

    .line 22
    .line 23
    invoke-direct {v0, p1}, Lqf/b;-><init>(Ljava/util/concurrent/ExecutorService;)V

    .line 24
    .line 25
    .line 26
    iput-object v0, p0, Lcom/google/firebase/crashlytics/internal/concurrency/a;->b:Lqf/b;

    .line 27
    .line 28
    const/4 p1, 0x0

    .line 29
    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    .line 30
    .line 31
    .line 32
    new-instance p1, Lqf/b;

    .line 33
    .line 34
    invoke-direct {p1, p2}, Lqf/b;-><init>(Ljava/util/concurrent/ExecutorService;)V

    .line 35
    .line 36
    .line 37
    iput-object p1, p0, Lcom/google/firebase/crashlytics/internal/concurrency/a;->c:Lqf/b;

    .line 38
    .line 39
    return-void
.end method

.method public static final a()V
    .locals 2

    .line 1
    sget-object v0, Lcom/google/firebase/crashlytics/internal/concurrency/a;->d:Lqf/c;

    .line 2
    .line 3
    new-instance v1, Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkBackgroundThread$1;

    .line 4
    .line 5
    invoke-direct {v1, v0}, Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkBackgroundThread$1;-><init>(Ljava/lang/Object;)V

    .line 6
    .line 7
    .line 8
    sget-object v0, Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkBackgroundThread$2;->INSTANCE:Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkBackgroundThread$2;

    .line 9
    .line 10
    invoke-static {v1, v0}, Lqf/c;->a(Lwakotl/jvm/functions/Function0;Lwakotl/jvm/functions/Function0;)V

    .line 11
    .line 12
    .line 13
    return-void
.end method

.method public static final b()V
    .locals 2

    .line 1
    sget-object v0, Lcom/google/firebase/crashlytics/internal/concurrency/a;->d:Lqf/c;

    .line 2
    .line 3
    new-instance v1, Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkBlockingThread$1;

    .line 4
    .line 5
    invoke-direct {v1, v0}, Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkBlockingThread$1;-><init>(Ljava/lang/Object;)V

    .line 6
    .line 7
    .line 8
    sget-object v0, Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkBlockingThread$2;->INSTANCE:Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkBlockingThread$2;

    .line 9
    .line 10
    invoke-static {v1, v0}, Lqf/c;->a(Lwakotl/jvm/functions/Function0;Lwakotl/jvm/functions/Function0;)V

    .line 11
    .line 12
    .line 13
    return-void
.end method

.method public static final c()V
    .locals 2

    .line 1
    sget-object v0, Lcom/google/firebase/crashlytics/internal/concurrency/a;->d:Lqf/c;

    .line 2
    .line 3
    new-instance v1, Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkNotMainThread$1;

    .line 4
    .line 5
    invoke-direct {v1, v0}, Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkNotMainThread$1;-><init>(Ljava/lang/Object;)V

    .line 6
    .line 7
    .line 8
    sget-object v0, Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkNotMainThread$2;->INSTANCE:Lcom/google/firebase/crashlytics/internal/concurrency/CrashlyticsWorkers$Companion$checkNotMainThread$2;

    .line 9
    .line 10
    invoke-static {v1, v0}, Lqf/c;->a(Lwakotl/jvm/functions/Function0;Lwakotl/jvm/functions/Function0;)V

    .line 11
    .line 12
    .line 13
    return-void
.end method
