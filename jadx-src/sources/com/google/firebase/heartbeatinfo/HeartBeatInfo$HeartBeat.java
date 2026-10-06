package com.google.firebase.heartbeatinfo;

/* JADX INFO: loaded from: classes.dex */
public enum HeartBeatInfo$HeartBeat {
    NONE(0),
    SDK(1),
    GLOBAL(2),
    COMBINED(3);

    private final int code;

    HeartBeatInfo$HeartBeat(int i) {
        this.code = i;
    }

    public int getCode() {
        return this.code;
    }
}
