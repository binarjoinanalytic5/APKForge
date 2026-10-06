package com.google.firebase.messaging.reporting;

import gg.b;

/* JADX INFO: loaded from: classes.dex */
public enum MessagingClientEvent$Event implements b {
    UNKNOWN_EVENT(0),
    MESSAGE_DELIVERED(1),
    MESSAGE_OPEN(2);

    private final int number_;

    MessagingClientEvent$Event(int i) {
        this.number_ = i;
    }

    public int getNumber() {
        return this.number_;
    }
}
