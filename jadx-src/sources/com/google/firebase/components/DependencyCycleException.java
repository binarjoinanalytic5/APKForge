package com.google.firebase.components;

import java.util.Arrays;
import java.util.List;
import jf.b;

/* JADX INFO: loaded from: classes.dex */
public class DependencyCycleException extends DependencyException {
    private final List<b> componentsInCycle;

    public DependencyCycleException(List<b> list) {
        super("Dependency cycle detected: " + Arrays.toString(list.toArray()));
        this.componentsInCycle = list;
    }

    public List<b> getComponentsInCycle() {
        return this.componentsInCycle;
    }
}
