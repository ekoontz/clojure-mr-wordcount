package com.gentest;

public abstract class AbstractJavaClass {
    public AbstractJavaClass(String a, String b) {
	System.out.println("Constructor: a, b");
    }
    public AbstractJavaClass(String a) {
	System.out.println("Constructor: a");
    }

    public abstract String getCurrentStatus();

    public abstract String getCurrentStats();

    public abstract String getFoo();

    public String getSecret() {
	return "The Secret";
    }
    
}