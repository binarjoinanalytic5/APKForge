package com.google.firebase.messaging.reporting;

import gg.b;

/* JADX INFO: loaded from: classes.dex */
public enum MessagingClientEvent$SDKPlatform implements b {
    UNKNOWN_OS(0),
    ANDROID(1),
    IOS(2),
    WEB(3);

    private final int number_;

    MessagingClientEvent$SDKPlatform(int i) {
        this.number_ = i;
    }

    public int getNumber() {
        return this.number_;
    }
}
