package com.google.firebase.messaging.reporting;

import gg.b;

/* JADX INFO: loaded from: classes.dex */
public enum MessagingClientEvent$MessageType implements b {
    UNKNOWN(0),
    DATA_MESSAGE(1),
    TOPIC(2),
    DISPLAY_NOTIFICATION(3);

    private final int number_;

    MessagingClientEvent$MessageType(int i) {
        this.number_ = i;
    }

    public int getNumber() {
        return this.number_;
    }
}
