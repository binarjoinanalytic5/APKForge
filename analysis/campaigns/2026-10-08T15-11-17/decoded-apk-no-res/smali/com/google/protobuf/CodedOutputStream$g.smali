.class public final Lcom/google/protobuf/CodedOutputStream$g;
.super Lcom/google/protobuf/CodedOutputStream;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/CodedOutputStream;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "g"
.end annotation


# instance fields
.field private final address:J

.field private final buffer:Ljava/nio/ByteBuffer;

.field private final initialPosition:J

.field private final limit:J

.field private final oneVarintLimit:J

.field private final originalBuffer:Ljava/nio/ByteBuffer;

.field private position:J


# direct methods
.method public constructor <init>(Ljava/nio/ByteBuffer;)V
    .locals 6

    .line 1
    const/4 v0, 0x0

    .line 2
    invoke-direct {p0, v0}, Lcom/google/protobuf/CodedOutputStream;-><init>(Lcom/google/protobuf/p;)V

    .line 3
    .line 4
    .line 5
    iput-object p1, p0, Lcom/google/protobuf/CodedOutputStream$g;->originalBuffer:Ljava/nio/ByteBuffer;

    .line 6
    .line 7
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    .line 8
    .line 9
    .line 10
    move-result-object v0

    .line 11
    sget-object v1, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    .line 12
    .line 13
    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 14
    .line 15
    .line 16
    move-result-object v0

    .line 17
    iput-object v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->buffer:Ljava/nio/ByteBuffer;

    .line 18
    .line 19
    invoke-static {p1}, Lcom/google/protobuf/o2;->addressOffset(Ljava/nio/ByteBuffer;)J

    .line 20
    .line 21
    .line 22
    move-result-wide v0

    .line 23
    iput-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->address:J

    .line 24
    .line 25
    invoke-virtual {p1}, Ljava/nio/Buffer;->position()I

    .line 26
    .line 27
    .line 28
    move-result v2

    .line 29
    int-to-long v2, v2

    .line 30
    add-long/2addr v2, v0

    .line 31
    iput-wide v2, p0, Lcom/google/protobuf/CodedOutputStream$g;->initialPosition:J

    .line 32
    .line 33
    invoke-virtual {p1}, Ljava/nio/Buffer;->limit()I

    .line 34
    .line 35
    .line 36
    move-result p1

    .line 37
    int-to-long v4, p1

    .line 38
    add-long/2addr v0, v4

    .line 39
    iput-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    .line 40
    .line 41
    const-wide/16 v4, 0xa

    .line 42
    .line 43
    sub-long/2addr v0, v4

    .line 44
    iput-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->oneVarintLimit:J

    .line 45
    .line 46
    iput-wide v2, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 47
    .line 48
    return-void
.end method

.method private bufferPos(J)I
    .locals 2

    .line 1
    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->address:J

    .line 2
    .line 3
    sub-long/2addr p1, v0

    .line 4
    long-to-int p1, p1

    .line 5
    return p1
.end method

.method public static isSupported()Z
    .locals 1

    .line 1
    invoke-static {}, Lcom/google/protobuf/o2;->hasUnsafeByteBufferOperations()Z

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    return v0
.end method

.method private repositionBuffer(J)V
    .locals 1

    .line 1
    iget-object v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->buffer:Ljava/nio/ByteBuffer;

    .line 2
    .line 3
    invoke-direct {p0, p1, p2}, Lcom/google/protobuf/CodedOutputStream$g;->bufferPos(J)I

    .line 4
    .line 5
    .line 6
    move-result p1

    .line 7
    invoke-static {v0, p1}, Lcom/google/protobuf/v0;->position(Ljava/nio/Buffer;I)V

    .line 8
    .line 9
    .line 10
    return-void
.end method


# virtual methods
.method public flush()V
    .locals 3

    .line 1
    iget-object v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->originalBuffer:Ljava/nio/ByteBuffer;

    .line 2
    .line 3
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 4
    .line 5
    invoke-direct {p0, v1, v2}, Lcom/google/protobuf/CodedOutputStream$g;->bufferPos(J)I

    .line 6
    .line 7
    .line 8
    move-result v1

    .line 9
    invoke-static {v0, v1}, Lcom/google/protobuf/v0;->position(Ljava/nio/Buffer;I)V

    .line 10
    .line 11
    .line 12
    return-void
.end method

.method public getTotalBytesWritten()I
    .locals 4

    .line 1
    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 2
    .line 3
    iget-wide v2, p0, Lcom/google/protobuf/CodedOutputStream$g;->initialPosition:J

    .line 4
    .line 5
    sub-long/2addr v0, v2

    .line 6
    long-to-int v0, v0

    .line 7
    return v0
.end method

.method public spaceLeft()I
    .locals 4

    .line 1
    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    .line 2
    .line 3
    iget-wide v2, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 4
    .line 5
    sub-long/2addr v0, v2

    .line 6
    long-to-int v0, v0

    .line 7
    return v0
.end method

.method public write(B)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x1

    .line 1
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    iget-wide v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    cmp-long v3, v1, v3

    if-gez v3, :cond_0

    const-wide/16 v3, 0x1

    add-long/2addr v3, v1

    .line 2
    iput-wide v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    invoke-static {v1, v2, p1}, Lcom/google/protobuf/o2;->putByte(JB)V

    return-void

    .line 3
    :cond_0
    new-instance p1, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;

    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 4
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    iget-wide v2, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v1, v4, v5

    aput-object v2, v4, v0

    const/4 v0, 0x2

    aput-object v3, v4, v0

    const-string v0, "Pos: %d, limit: %d, len: %d"

    invoke-static {v0, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public write(Ljava/nio/ByteBuffer;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 11
    :try_start_0
    invoke-virtual {p1}, Ljava/nio/Buffer;->remaining()I

    move-result v0

    .line 12
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    invoke-direct {p0, v1, v2}, Lcom/google/protobuf/CodedOutputStream$g;->repositionBuffer(J)V

    .line 13
    iget-object v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 14
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    int-to-long v3, v0

    add-long/2addr v1, v3

    iput-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J
    :try_end_0
    .catch Ljava/nio/BufferOverflowException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 15
    new-instance v0, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;

    invoke-direct {v0, p1}, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method

.method public write([BII)V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    if-eqz p1, :cond_1

    if-ltz p2, :cond_1

    if-ltz p3, :cond_1

    .line 5
    array-length v0, p1

    sub-int/2addr v0, p3

    if-lt v0, p2, :cond_1

    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    int-to-long v9, p3

    sub-long/2addr v0, v9

    iget-wide v5, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    cmp-long v0, v0, v5

    if-gez v0, :cond_0

    goto :goto_0

    :cond_0
    int-to-long v3, p2

    move-object v2, p1

    move-wide v7, v9

    .line 6
    invoke-static/range {v2 .. v8}, Lcom/google/protobuf/o2;->copyMemory([BJJJ)V

    .line 7
    iget-wide p1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    add-long/2addr p1, v9

    iput-wide p1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    return-void

    :cond_1
    :goto_0
    if-nez p1, :cond_2

    .line 8
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "value"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 9
    :cond_2
    new-instance p1, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;

    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 10
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p2, v1, v2

    const/4 p2, 0x1

    aput-object v0, v1, p2

    const/4 p2, 0x2

    aput-object p3, v1, p2

    const-string p2, "Pos: %d, limit: %d, len: %d"

    invoke-static {p2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public writeBool(IZ)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x0

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    .line 4
    .line 5
    int-to-byte p1, p2

    .line 6
    invoke-virtual {p0, p1}, Lcom/google/protobuf/CodedOutputStream$g;->write(B)V

    .line 7
    .line 8
    .line 9
    return-void
.end method

.method public writeByteArray(I[B)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    array-length v0, p2

    const/4 v1, 0x0

    invoke-virtual {p0, p1, p2, v1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeByteArray(I[BII)V

    return-void
.end method

.method public writeByteArray(I[BII)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x2

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    invoke-virtual {p0, p2, p3, p4}, Lcom/google/protobuf/CodedOutputStream$g;->writeByteArrayNoTag([BII)V

    return-void
.end method

.method public writeByteArrayNoTag([BII)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    invoke-virtual {p0, p3}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 2
    .line 3
    .line 4
    invoke-virtual {p0, p1, p2, p3}, Lcom/google/protobuf/CodedOutputStream$g;->write([BII)V

    .line 5
    .line 6
    .line 7
    return-void
.end method

.method public writeByteBuffer(ILjava/nio/ByteBuffer;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x2

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    .line 4
    .line 5
    invoke-virtual {p2}, Ljava/nio/Buffer;->capacity()I

    .line 6
    .line 7
    .line 8
    move-result p1

    .line 9
    invoke-virtual {p0, p1}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 10
    .line 11
    .line 12
    invoke-virtual {p0, p2}, Lcom/google/protobuf/CodedOutputStream$g;->writeRawBytes(Ljava/nio/ByteBuffer;)V

    .line 13
    .line 14
    .line 15
    return-void
.end method

.method public writeBytes(ILcom/google/protobuf/ByteString;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x2

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    .line 4
    .line 5
    invoke-virtual {p0, p2}, Lcom/google/protobuf/CodedOutputStream$g;->writeBytesNoTag(Lcom/google/protobuf/ByteString;)V

    .line 6
    .line 7
    .line 8
    return-void
.end method

.method public writeBytesNoTag(Lcom/google/protobuf/ByteString;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    invoke-virtual {p1}, Lcom/google/protobuf/ByteString;->size()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    invoke-virtual {p0, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 6
    .line 7
    .line 8
    invoke-virtual {p1, p0}, Lcom/google/protobuf/ByteString;->writeTo(Lcom/google/protobuf/ByteOutput;)V

    .line 9
    .line 10
    .line 11
    return-void
.end method

.method public writeFixed32(II)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x5

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    .line 4
    .line 5
    invoke-virtual {p0, p2}, Lcom/google/protobuf/CodedOutputStream$g;->writeFixed32NoTag(I)V

    .line 6
    .line 7
    .line 8
    return-void
.end method

.method public writeFixed32NoTag(I)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    iget-object v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->buffer:Ljava/nio/ByteBuffer;

    .line 2
    .line 3
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 4
    .line 5
    invoke-direct {p0, v1, v2}, Lcom/google/protobuf/CodedOutputStream$g;->bufferPos(J)I

    .line 6
    .line 7
    .line 8
    move-result v1

    .line 9
    invoke-virtual {v0, v1, p1}, Ljava/nio/ByteBuffer;->putInt(II)Ljava/nio/ByteBuffer;

    .line 10
    .line 11
    .line 12
    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 13
    .line 14
    const-wide/16 v2, 0x4

    .line 15
    .line 16
    add-long/2addr v0, v2

    .line 17
    iput-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 18
    .line 19
    return-void
.end method

.method public writeFixed64(IJ)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x1

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    .line 4
    .line 5
    invoke-virtual {p0, p2, p3}, Lcom/google/protobuf/CodedOutputStream$g;->writeFixed64NoTag(J)V

    .line 6
    .line 7
    .line 8
    return-void
.end method

.method public writeFixed64NoTag(J)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    iget-object v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->buffer:Ljava/nio/ByteBuffer;

    .line 2
    .line 3
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 4
    .line 5
    invoke-direct {p0, v1, v2}, Lcom/google/protobuf/CodedOutputStream$g;->bufferPos(J)I

    .line 6
    .line 7
    .line 8
    move-result v1

    .line 9
    invoke-virtual {v0, v1, p1, p2}, Ljava/nio/ByteBuffer;->putLong(IJ)Ljava/nio/ByteBuffer;

    .line 10
    .line 11
    .line 12
    iget-wide p1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 13
    .line 14
    const-wide/16 v0, 0x8

    .line 15
    .line 16
    add-long/2addr p1, v0

    .line 17
    iput-wide p1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 18
    .line 19
    return-void
.end method

.method public writeInt32(II)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x0

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    .line 4
    .line 5
    invoke-virtual {p0, p2}, Lcom/google/protobuf/CodedOutputStream$g;->writeInt32NoTag(I)V

    .line 6
    .line 7
    .line 8
    return-void
.end method

.method public writeInt32NoTag(I)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    if-ltz p1, :cond_0

    .line 2
    .line 3
    invoke-virtual {p0, p1}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 4
    .line 5
    .line 6
    goto :goto_0

    .line 7
    :cond_0
    int-to-long v0, p1

    .line 8
    invoke-virtual {p0, v0, v1}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt64NoTag(J)V

    .line 9
    .line 10
    .line 11
    :goto_0
    return-void
.end method

.method public writeLazy(Ljava/nio/ByteBuffer;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2
    invoke-virtual {p0, p1}, Lcom/google/protobuf/CodedOutputStream$g;->write(Ljava/nio/ByteBuffer;)V

    return-void
.end method

.method public writeLazy([BII)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    invoke-virtual {p0, p1, p2, p3}, Lcom/google/protobuf/CodedOutputStream$g;->write([BII)V

    return-void
.end method

.method public writeMessage(ILcom/google/protobuf/MessageLite;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x2

    .line 1
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 2
    invoke-virtual {p0, p2}, Lcom/google/protobuf/CodedOutputStream$g;->writeMessageNoTag(Lcom/google/protobuf/MessageLite;)V

    return-void
.end method

.method public writeMessage(ILcom/google/protobuf/MessageLite;Lcom/google/protobuf/z1;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x2

    .line 3
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 4
    invoke-virtual {p0, p2, p3}, Lcom/google/protobuf/CodedOutputStream$g;->writeMessageNoTag(Lcom/google/protobuf/MessageLite;Lcom/google/protobuf/z1;)V

    return-void
.end method

.method public writeMessageNoTag(Lcom/google/protobuf/MessageLite;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    invoke-interface {p1}, Lcom/google/protobuf/MessageLite;->getSerializedSize()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 2
    invoke-interface {p1, p0}, Lcom/google/protobuf/MessageLite;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    return-void
.end method

.method public writeMessageNoTag(Lcom/google/protobuf/MessageLite;Lcom/google/protobuf/z1;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 3
    move-object v0, p1

    check-cast v0, Lcom/google/protobuf/AbstractMessageLite;

    invoke-virtual {v0, p2}, Lcom/google/protobuf/AbstractMessageLite;->getSerializedSize(Lcom/google/protobuf/z1;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 4
    iget-object v0, p0, Lcom/google/protobuf/CodedOutputStream;->wrapper:Lcom/google/protobuf/r;

    invoke-interface {p2, p1, v0}, Lcom/google/protobuf/z1;->writeTo(Ljava/lang/Object;Lcom/google/protobuf/r2;)V

    return-void
.end method

.method public writeMessageSetExtension(ILcom/google/protobuf/MessageLite;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x1

    .line 2
    const/4 v1, 0x3

    .line 3
    invoke-virtual {p0, v0, v1}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 4
    .line 5
    .line 6
    const/4 v2, 0x2

    .line 7
    invoke-virtual {p0, v2, p1}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32(II)V

    .line 8
    .line 9
    .line 10
    invoke-virtual {p0, v1, p2}, Lcom/google/protobuf/CodedOutputStream$g;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 11
    .line 12
    .line 13
    const/4 p1, 0x4

    .line 14
    invoke-virtual {p0, v0, p1}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 15
    .line 16
    .line 17
    return-void
.end method

.method public writeRawBytes(Ljava/nio/ByteBuffer;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->hasArray()Z

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    if-eqz v0, :cond_0

    .line 6
    .line 7
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    .line 8
    .line 9
    .line 10
    move-result-object v0

    .line 11
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->arrayOffset()I

    .line 12
    .line 13
    .line 14
    move-result v1

    .line 15
    invoke-virtual {p1}, Ljava/nio/Buffer;->capacity()I

    .line 16
    .line 17
    .line 18
    move-result p1

    .line 19
    invoke-virtual {p0, v0, v1, p1}, Lcom/google/protobuf/CodedOutputStream$g;->write([BII)V

    .line 20
    .line 21
    .line 22
    goto :goto_0

    .line 23
    :cond_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    .line 24
    .line 25
    .line 26
    move-result-object p1

    .line 27
    invoke-static {p1}, Lcom/google/protobuf/v0;->clear(Ljava/nio/Buffer;)V

    .line 28
    .line 29
    .line 30
    invoke-virtual {p0, p1}, Lcom/google/protobuf/CodedOutputStream$g;->write(Ljava/nio/ByteBuffer;)V

    .line 31
    .line 32
    .line 33
    :goto_0
    return-void
.end method

.method public writeRawMessageSetExtension(ILcom/google/protobuf/ByteString;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x1

    .line 2
    const/4 v1, 0x3

    .line 3
    invoke-virtual {p0, v0, v1}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 4
    .line 5
    .line 6
    const/4 v2, 0x2

    .line 7
    invoke-virtual {p0, v2, p1}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32(II)V

    .line 8
    .line 9
    .line 10
    invoke-virtual {p0, v1, p2}, Lcom/google/protobuf/CodedOutputStream$g;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 11
    .line 12
    .line 13
    const/4 p1, 0x4

    .line 14
    invoke-virtual {p0, v0, p1}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 15
    .line 16
    .line 17
    return-void
.end method

.method public writeString(ILjava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x2

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    .line 4
    .line 5
    invoke-virtual {p0, p2}, Lcom/google/protobuf/CodedOutputStream$g;->writeStringNoTag(Ljava/lang/String;)V

    .line 6
    .line 7
    .line 8
    return-void
.end method

.method public writeStringNoTag(Ljava/lang/String;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 2
    .line 3
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    .line 4
    .line 5
    .line 6
    move-result v2

    .line 7
    mul-int/lit8 v2, v2, 0x3

    .line 8
    .line 9
    invoke-static {v2}, Lcom/google/protobuf/CodedOutputStream;->computeUInt32SizeNoTag(I)I

    .line 10
    .line 11
    .line 12
    move-result v2

    .line 13
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    .line 14
    .line 15
    .line 16
    move-result v3

    .line 17
    invoke-static {v3}, Lcom/google/protobuf/CodedOutputStream;->computeUInt32SizeNoTag(I)I

    .line 18
    .line 19
    .line 20
    move-result v3

    .line 21
    if-ne v3, v2, :cond_0

    .line 22
    .line 23
    iget-wide v4, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 24
    .line 25
    invoke-direct {p0, v4, v5}, Lcom/google/protobuf/CodedOutputStream$g;->bufferPos(J)I

    .line 26
    .line 27
    .line 28
    move-result v2

    .line 29
    add-int/2addr v2, v3

    .line 30
    iget-object v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->buffer:Ljava/nio/ByteBuffer;

    .line 31
    .line 32
    invoke-static {v3, v2}, Lcom/google/protobuf/v0;->position(Ljava/nio/Buffer;I)V

    .line 33
    .line 34
    .line 35
    iget-object v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->buffer:Ljava/nio/ByteBuffer;

    .line 36
    .line 37
    invoke-static {p1, v3}, Lcom/google/protobuf/Utf8;->encodeUtf8(Ljava/lang/CharSequence;Ljava/nio/ByteBuffer;)V

    .line 38
    .line 39
    .line 40
    iget-object v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->buffer:Ljava/nio/ByteBuffer;

    .line 41
    .line 42
    invoke-virtual {v3}, Ljava/nio/Buffer;->position()I

    .line 43
    .line 44
    .line 45
    move-result v3

    .line 46
    sub-int/2addr v3, v2

    .line 47
    invoke-virtual {p0, v3}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 48
    .line 49
    .line 50
    iget-wide v4, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 51
    .line 52
    int-to-long v2, v3

    .line 53
    add-long/2addr v4, v2

    .line 54
    iput-wide v4, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 55
    .line 56
    goto :goto_3

    .line 57
    :catch_0
    move-exception p1

    .line 58
    goto :goto_0

    .line 59
    :catch_1
    move-exception p1

    .line 60
    goto :goto_1

    .line 61
    :catch_2
    move-exception v2

    .line 62
    goto :goto_2

    .line 63
    :cond_0
    invoke-static {p1}, Lcom/google/protobuf/Utf8;->encodedLength(Ljava/lang/CharSequence;)I

    .line 64
    .line 65
    .line 66
    move-result v2

    .line 67
    invoke-virtual {p0, v2}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 68
    .line 69
    .line 70
    iget-wide v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 71
    .line 72
    invoke-direct {p0, v3, v4}, Lcom/google/protobuf/CodedOutputStream$g;->repositionBuffer(J)V

    .line 73
    .line 74
    .line 75
    iget-object v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->buffer:Ljava/nio/ByteBuffer;

    .line 76
    .line 77
    invoke-static {p1, v3}, Lcom/google/protobuf/Utf8;->encodeUtf8(Ljava/lang/CharSequence;Ljava/nio/ByteBuffer;)V

    .line 78
    .line 79
    .line 80
    iget-wide v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 81
    .line 82
    int-to-long v5, v2

    .line 83
    add-long/2addr v3, v5

    .line 84
    iput-wide v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J
    :try_end_0
    .catch Lcom/google/protobuf/Utf8$UnpairedSurrogateException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    .line 85
    .line 86
    goto :goto_3

    .line 87
    :goto_0
    new-instance v0, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;

    .line 88
    .line 89
    invoke-direct {v0, p1}, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;-><init>(Ljava/lang/Throwable;)V

    .line 90
    .line 91
    .line 92
    throw v0

    .line 93
    :goto_1
    new-instance v0, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;

    .line 94
    .line 95
    invoke-direct {v0, p1}, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;-><init>(Ljava/lang/Throwable;)V

    .line 96
    .line 97
    .line 98
    throw v0

    .line 99
    :goto_2
    iput-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 100
    .line 101
    invoke-direct {p0, v0, v1}, Lcom/google/protobuf/CodedOutputStream$g;->repositionBuffer(J)V

    .line 102
    .line 103
    .line 104
    invoke-virtual {p0, p1, v2}, Lcom/google/protobuf/CodedOutputStream;->inefficientWriteStringNoTag(Ljava/lang/String;Lcom/google/protobuf/Utf8$UnpairedSurrogateException;)V

    .line 105
    .line 106
    .line 107
    :goto_3
    return-void
.end method

.method public writeTag(II)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    invoke-static {p1, p2}, Lcom/google/protobuf/WireFormat;->makeTag(II)I

    .line 2
    .line 3
    .line 4
    move-result p1

    .line 5
    invoke-virtual {p0, p1}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 6
    .line 7
    .line 8
    return-void
.end method

.method public writeUInt32(II)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x0

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    .line 4
    .line 5
    invoke-virtual {p0, p2}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt32NoTag(I)V

    .line 6
    .line 7
    .line 8
    return-void
.end method

.method public writeUInt32NoTag(I)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x1

    .line 2
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 3
    .line 4
    iget-wide v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->oneVarintLimit:J

    .line 5
    .line 6
    cmp-long v1, v1, v3

    .line 7
    .line 8
    const-wide/16 v2, 0x1

    .line 9
    .line 10
    if-gtz v1, :cond_1

    .line 11
    .line 12
    :goto_0
    and-int/lit8 v0, p1, -0x80

    .line 13
    .line 14
    if-nez v0, :cond_0

    .line 15
    .line 16
    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 17
    .line 18
    add-long/2addr v2, v0

    .line 19
    iput-wide v2, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 20
    .line 21
    int-to-byte p1, p1

    .line 22
    invoke-static {v0, v1, p1}, Lcom/google/protobuf/o2;->putByte(JB)V

    .line 23
    .line 24
    .line 25
    return-void

    .line 26
    :cond_0
    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 27
    .line 28
    add-long v4, v0, v2

    .line 29
    .line 30
    iput-wide v4, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 31
    .line 32
    and-int/lit8 v4, p1, 0x7f

    .line 33
    .line 34
    or-int/lit16 v4, v4, 0x80

    .line 35
    .line 36
    int-to-byte v4, v4

    .line 37
    invoke-static {v0, v1, v4}, Lcom/google/protobuf/o2;->putByte(JB)V

    .line 38
    .line 39
    .line 40
    ushr-int/lit8 p1, p1, 0x7

    .line 41
    .line 42
    goto :goto_0

    .line 43
    :cond_1
    :goto_1
    iget-wide v4, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 44
    .line 45
    iget-wide v6, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    .line 46
    .line 47
    cmp-long v1, v4, v6

    .line 48
    .line 49
    if-gez v1, :cond_3

    .line 50
    .line 51
    and-int/lit8 v1, p1, -0x80

    .line 52
    .line 53
    if-nez v1, :cond_2

    .line 54
    .line 55
    add-long/2addr v2, v4

    .line 56
    iput-wide v2, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 57
    .line 58
    int-to-byte p1, p1

    .line 59
    invoke-static {v4, v5, p1}, Lcom/google/protobuf/o2;->putByte(JB)V

    .line 60
    .line 61
    .line 62
    return-void

    .line 63
    :cond_2
    add-long v6, v4, v2

    .line 64
    .line 65
    iput-wide v6, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 66
    .line 67
    and-int/lit8 v1, p1, 0x7f

    .line 68
    .line 69
    or-int/lit16 v1, v1, 0x80

    .line 70
    .line 71
    int-to-byte v1, v1

    .line 72
    invoke-static {v4, v5, v1}, Lcom/google/protobuf/o2;->putByte(JB)V

    .line 73
    .line 74
    .line 75
    ushr-int/lit8 p1, p1, 0x7

    .line 76
    .line 77
    goto :goto_1

    .line 78
    :cond_3
    new-instance p1, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;

    .line 79
    .line 80
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 81
    .line 82
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    .line 83
    .line 84
    .line 85
    move-result-object v1

    .line 86
    iget-wide v2, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    .line 87
    .line 88
    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    .line 89
    .line 90
    .line 91
    move-result-object v2

    .line 92
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 93
    .line 94
    .line 95
    move-result-object v3

    .line 96
    const/4 v4, 0x3

    .line 97
    new-array v4, v4, [Ljava/lang/Object;

    .line 98
    .line 99
    const/4 v5, 0x0

    .line 100
    aput-object v1, v4, v5

    .line 101
    .line 102
    aput-object v2, v4, v0

    .line 103
    .line 104
    const/4 v0, 0x2

    .line 105
    aput-object v3, v4, v0

    .line 106
    .line 107
    const-string v0, "Pos: %d, limit: %d, len: %d"

    .line 108
    .line 109
    invoke-static {v0, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    .line 110
    .line 111
    .line 112
    move-result-object v0

    .line 113
    invoke-direct {p1, v0}, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;-><init>(Ljava/lang/String;)V

    .line 114
    .line 115
    .line 116
    throw p1
.end method

.method public writeUInt64(IJ)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x0

    .line 2
    invoke-virtual {p0, p1, v0}, Lcom/google/protobuf/CodedOutputStream$g;->writeTag(II)V

    .line 3
    .line 4
    .line 5
    invoke-virtual {p0, p2, p3}, Lcom/google/protobuf/CodedOutputStream$g;->writeUInt64NoTag(J)V

    .line 6
    .line 7
    .line 8
    return-void
.end method

.method public writeUInt64NoTag(J)V
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    const/4 v0, 0x1

    .line 2
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 3
    .line 4
    iget-wide v3, p0, Lcom/google/protobuf/CodedOutputStream$g;->oneVarintLimit:J

    .line 5
    .line 6
    cmp-long v1, v1, v3

    .line 7
    .line 8
    const/4 v2, 0x7

    .line 9
    const-wide/16 v3, 0x0

    .line 10
    .line 11
    const-wide/16 v5, -0x80

    .line 12
    .line 13
    const-wide/16 v7, 0x1

    .line 14
    .line 15
    if-gtz v1, :cond_1

    .line 16
    .line 17
    :goto_0
    and-long v0, p1, v5

    .line 18
    .line 19
    cmp-long v0, v0, v3

    .line 20
    .line 21
    if-nez v0, :cond_0

    .line 22
    .line 23
    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 24
    .line 25
    add-long/2addr v7, v0

    .line 26
    iput-wide v7, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 27
    .line 28
    long-to-int p1, p1

    .line 29
    int-to-byte p1, p1

    .line 30
    invoke-static {v0, v1, p1}, Lcom/google/protobuf/o2;->putByte(JB)V

    .line 31
    .line 32
    .line 33
    return-void

    .line 34
    :cond_0
    iget-wide v0, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 35
    .line 36
    add-long v9, v0, v7

    .line 37
    .line 38
    iput-wide v9, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 39
    .line 40
    long-to-int v9, p1

    .line 41
    and-int/lit8 v9, v9, 0x7f

    .line 42
    .line 43
    or-int/lit16 v9, v9, 0x80

    .line 44
    .line 45
    int-to-byte v9, v9

    .line 46
    invoke-static {v0, v1, v9}, Lcom/google/protobuf/o2;->putByte(JB)V

    .line 47
    .line 48
    .line 49
    ushr-long/2addr p1, v2

    .line 50
    goto :goto_0

    .line 51
    :cond_1
    :goto_1
    iget-wide v9, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 52
    .line 53
    iget-wide v11, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    .line 54
    .line 55
    cmp-long v1, v9, v11

    .line 56
    .line 57
    if-gez v1, :cond_3

    .line 58
    .line 59
    and-long v11, p1, v5

    .line 60
    .line 61
    cmp-long v1, v11, v3

    .line 62
    .line 63
    if-nez v1, :cond_2

    .line 64
    .line 65
    add-long/2addr v7, v9

    .line 66
    iput-wide v7, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 67
    .line 68
    long-to-int p1, p1

    .line 69
    int-to-byte p1, p1

    .line 70
    invoke-static {v9, v10, p1}, Lcom/google/protobuf/o2;->putByte(JB)V

    .line 71
    .line 72
    .line 73
    return-void

    .line 74
    :cond_2
    add-long v11, v9, v7

    .line 75
    .line 76
    iput-wide v11, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 77
    .line 78
    long-to-int v1, p1

    .line 79
    and-int/lit8 v1, v1, 0x7f

    .line 80
    .line 81
    or-int/lit16 v1, v1, 0x80

    .line 82
    .line 83
    int-to-byte v1, v1

    .line 84
    invoke-static {v9, v10, v1}, Lcom/google/protobuf/o2;->putByte(JB)V

    .line 85
    .line 86
    .line 87
    ushr-long/2addr p1, v2

    .line 88
    goto :goto_1

    .line 89
    :cond_3
    new-instance p1, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;

    .line 90
    .line 91
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->position:J

    .line 92
    .line 93
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    .line 94
    .line 95
    .line 96
    move-result-object p2

    .line 97
    iget-wide v1, p0, Lcom/google/protobuf/CodedOutputStream$g;->limit:J

    .line 98
    .line 99
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    .line 100
    .line 101
    .line 102
    move-result-object v1

    .line 103
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 104
    .line 105
    .line 106
    move-result-object v2

    .line 107
    const/4 v3, 0x3

    .line 108
    new-array v3, v3, [Ljava/lang/Object;

    .line 109
    .line 110
    const/4 v4, 0x0

    .line 111
    aput-object p2, v3, v4

    .line 112
    .line 113
    aput-object v1, v3, v0

    .line 114
    .line 115
    const/4 p2, 0x2

    .line 116
    aput-object v2, v3, p2

    .line 117
    .line 118
    const-string p2, "Pos: %d, limit: %d, len: %d"

    .line 119
    .line 120
    invoke-static {p2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    .line 121
    .line 122
    .line 123
    move-result-object p2

    .line 124
    invoke-direct {p1, p2}, Lcom/google/protobuf/CodedOutputStream$OutOfSpaceException;-><init>(Ljava/lang/String;)V

    .line 125
    .line 126
    .line 127
    throw p1
.end method
