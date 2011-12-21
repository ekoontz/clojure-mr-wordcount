package org.wordcount;

public abstract class AbstractWordCount {
    public AbstractWordCount(String a, String b) {
	System.out.println("Constructor: a, b");
    }
    public AbstractWordCount(String a) {
	System.out.println("Constructor: a");
    }

    public abstract String getCurrentStatus();

    public String getSecret() {
	return "The Secret";
    }
    
}