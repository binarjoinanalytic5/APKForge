package com.google.zxing.oned;

import bh.c;
import com.google.zxing.BarcodeFormat;
import com.moloco.sdk.internal.publisher.s;
import java.util.ArrayList;
import java.util.EnumMap;
import java.util.Iterator;
import xg.b;

/* JADX INFO: renamed from: com.google.zxing.oned.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0154a extends s {
    /* JADX INFO: renamed from: N */
    public static Code128Writer$CType m350N(int i, String str) {
        int length = str.length();
        if (i >= length) {
            return Code128Writer$CType.UNCODABLE;
        }
        char cCharAt = str.charAt(i);
        if (cCharAt == 241) {
            return Code128Writer$CType.FNC_1;
        }
        if (cCharAt < '0' || cCharAt > '9') {
            return Code128Writer$CType.UNCODABLE;
        }
        int i2 = i + 1;
        if (i2 >= length) {
            return Code128Writer$CType.ONE_DIGIT;
        }
        char cCharAt2 = str.charAt(i2);
        return (cCharAt2 < '0' || cCharAt2 > '9') ? Code128Writer$CType.ONE_DIGIT : Code128Writer$CType.TWO_DIGITS;
    }

    /* JADX INFO: renamed from: s */
    public final b m351s(String str, BarcodeFormat barcodeFormat, EnumMap enumMap) {
        if (barcodeFormat == BarcodeFormat.CODE_128) {
            return super.s(str, barcodeFormat, enumMap);
        }
        throw new IllegalArgumentException("Can only encode CODE_128, but got ".concat(String.valueOf(barcodeFormat)));
    }

    /* JADX WARN: Code duplicated, block: B:21:0x004c  */
    /* JADX WARN: Code duplicated, block: B:45:0x0088  */
    /* JADX INFO: renamed from: t */
    public final boolean[] m352t(String str) {
        int i;
        Code128Writer$CType code128Writer$CTypeM350N;
        char cCharAt;
        int i2;
        int iCharAt;
        int length = str.length();
        if (length <= 0 || length > 80) {
            throw new IllegalArgumentException("Contents length should be between 1 and 80 characters, but got ".concat(String.valueOf(length)));
        }
        for (int i3 = 0; i3 < length; i3++) {
            char cCharAt2 = str.charAt(i3);
            switch (cCharAt2) {
                case 241:
                case 242:
                case 243:
                case 244:
                    break;
                default:
                    if (cCharAt2 > 127) {
                        throw new IllegalArgumentException("Bad character in input: ".concat(String.valueOf(cCharAt2)));
                    }
                    break;
                    break;
            }
        }
        ArrayList<int[]> arrayList = new ArrayList();
        int i4 = 1;
        int i5 = 0;
        int i6 = 0;
        int i7 = 0;
        while (true) {
            int[][] iArr = c.e;
            if (i5 >= length) {
                arrayList.add(iArr[i6 % 103]);
                arrayList.add(iArr[106]);
                int i8 = 0;
                for (int[] iArr2 : arrayList) {
                    for (int i9 : iArr2) {
                        i8 += i9;
                    }
                }
                boolean[] zArr = new boolean[i8];
                Iterator it = arrayList.iterator();
                int iJ = 0;
                while (it.hasNext()) {
                    iJ += s.j(zArr, iJ, (int[]) it.next(), true);
                }
                return zArr;
            }
            Code128Writer$CType code128Writer$CTypeM350N2 = m350N(i5, str);
            Code128Writer$CType code128Writer$CType = Code128Writer$CType.ONE_DIGIT;
            if (code128Writer$CTypeM350N2 != code128Writer$CType) {
                Code128Writer$CType code128Writer$CType2 = Code128Writer$CType.UNCODABLE;
                if (code128Writer$CTypeM350N2 != code128Writer$CType2) {
                    i = 99;
                    if (i7 != 99) {
                        if (i7 == 100) {
                            Code128Writer$CType code128Writer$CType3 = Code128Writer$CType.FNC_1;
                            if (code128Writer$CTypeM350N2 != code128Writer$CType3 && (code128Writer$CTypeM350N = m350N(i5 + 2, str)) != code128Writer$CType2 && code128Writer$CTypeM350N != code128Writer$CType) {
                                if (code128Writer$CTypeM350N != code128Writer$CType3) {
                                    int i10 = i5 + 4;
                                    while (true) {
                                        Code128Writer$CType code128Writer$CTypeM350N3 = m350N(i10, str);
                                        if (code128Writer$CTypeM350N3 == Code128Writer$CType.TWO_DIGITS) {
                                            i10 += 2;
                                        } else if (code128Writer$CTypeM350N3 != Code128Writer$CType.ONE_DIGIT) {
                                            i = 99;
                                        }
                                    }
                                } else if (m350N(i5 + 3, str) == Code128Writer$CType.TWO_DIGITS) {
                                    i = 99;
                                }
                            }
                            i = 100;
                        } else {
                            if (code128Writer$CTypeM350N2 == Code128Writer$CType.FNC_1) {
                                code128Writer$CTypeM350N2 = m350N(i5 + 1, str);
                            }
                            if (code128Writer$CTypeM350N2 == Code128Writer$CType.TWO_DIGITS) {
                                i = 99;
                            } else {
                                i = 100;
                            }
                        }
                    }
                } else if (i5 >= str.length() || ((cCharAt = str.charAt(i5)) >= ' ' && (i7 != 101 || cCharAt >= '`'))) {
                    i = 100;
                } else {
                    i = 101;
                }
            } else {
                i = 100;
            }
            if (i == i7) {
                switch (str.charAt(i5)) {
                    case 241:
                        iCharAt = 102;
                        break;
                    case 242:
                        iCharAt = 97;
                        break;
                    case 243:
                        iCharAt = 96;
                        break;
                    case 244:
                        iCharAt = i7 == 101 ? 101 : 100;
                        break;
                    default:
                        if (i7 == 100) {
                            iCharAt = str.charAt(i5) - ' ';
                        } else if (i7 != 101) {
                            iCharAt = Integer.parseInt(str.substring(i5, i5 + 2));
                            i5++;
                        } else {
                            char cCharAt3 = str.charAt(i5);
                            iCharAt = cCharAt3 - ' ';
                            if (iCharAt < 0) {
                                iCharAt = cCharAt3 + '@';
                            }
                        }
                        break;
                }
                i5++;
            } else {
                if (i7 != 0) {
                    i2 = i;
                } else if (i != 100) {
                    i2 = i != 101 ? 105 : 103;
                } else {
                    i2 = 104;
                }
                i7 = i;
                iCharAt = i2;
            }
            arrayList.add(iArr[iCharAt]);
            i6 += iCharAt * i4;
            if (i5 != 0) {
                i4++;
            }
        }
    }
}
