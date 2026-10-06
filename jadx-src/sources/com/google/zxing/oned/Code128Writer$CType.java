package com.google.zxing.oned;

/* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
/* JADX WARN: Unknown enum class pattern. Please report as an issue! */
/* JADX INFO: loaded from: classes.dex */
final class Code128Writer$CType {
    public static final Code128Writer$CType FNC_1;
    public static final Code128Writer$CType ONE_DIGIT;
    public static final Code128Writer$CType TWO_DIGITS;
    public static final Code128Writer$CType UNCODABLE;

    /* JADX INFO: renamed from: a */
    public static final /* synthetic */ Code128Writer$CType[] f929a;

    static {
        Code128Writer$CType code128Writer$CType = new Code128Writer$CType("UNCODABLE", 0);
        UNCODABLE = code128Writer$CType;
        Code128Writer$CType code128Writer$CType2 = new Code128Writer$CType("ONE_DIGIT", 1);
        ONE_DIGIT = code128Writer$CType2;
        Code128Writer$CType code128Writer$CType3 = new Code128Writer$CType("TWO_DIGITS", 2);
        TWO_DIGITS = code128Writer$CType3;
        Code128Writer$CType code128Writer$CType4 = new Code128Writer$CType("FNC_1", 3);
        FNC_1 = code128Writer$CType4;
        f929a = new Code128Writer$CType[]{code128Writer$CType, code128Writer$CType2, code128Writer$CType3, code128Writer$CType4};
    }

    public static Code128Writer$CType valueOf(String str) {
        return (Code128Writer$CType) Enum.valueOf(Code128Writer$CType.class, str);
    }

    public static Code128Writer$CType[] values() {
        return (Code128Writer$CType[]) f929a.clone();
    }
}
