package androidx.constraintlayout.core.parser;

import c1.a;

/* JADX INFO: loaded from: classes.dex */
public class CLParsingException extends Exception {
    private final String mElementClass = "unknown";
    private final int mLineNumber = 0;
    private final String mReason;

    public CLParsingException(String str, a aVar) {
        this.mReason = str;
    }

    public String reason() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.mReason);
        sb.append(" (");
        sb.append(this.mElementClass);
        sb.append(" at line ");
        return a1.a.g(this.mLineNumber, ")", sb);
    }

    @Override // java.lang.Throwable
    public String toString() {
        return "CLParsingException (" + hashCode() + ") : " + reason();
    }
}
