package com.justin.project.database;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManagerFactory;

public final class PMF {
    private static final PersistenceManagerFactory pmfInstance =
        JDOHelper.getPersistenceManagerFactory("eventual-reads-short-deadlines");

    private PMF() {}

    public static PersistenceManagerFactory get() {
        return pmfInstance;
    }
}