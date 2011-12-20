.PHONY: test clean repl

clean:
	-rm `find classes -name "*.class"`

classes:
	-mkdir -p classes/com/curry/utils/calc

classes/MyJavaClass.class: MyJavaClass.java classes
	javac -d classes -cp .:classes $<

repl:
	rlwrap java -classpath .:classes:src:/Users/ekoontz/.m2/repository/org/clojure/clojure/1.3.0/clojure-1.3.0.jar clojure.main

test: classes/MyJavaClass.class
	java -cp .:classes MyJavaClass foo

