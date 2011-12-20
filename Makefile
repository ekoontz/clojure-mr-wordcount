.PHONY: test clean repl

clean:
	-rm classes/*.class

classes:
	-mkdir -p classes

classes/MyJavaClass.class: MyJavaClass.java classes
	javac -d classes -cp .:classes $<

repl:
	rlwrap java -classpath .:classes:/Users/ekoontz/.m2/repository/org/clojure/clojure/1.3.0/clojure-1.3.0.jar clojure.main

test: classes/MyJavaClass.class
	java -cp .:classes MyJavaClass foo

