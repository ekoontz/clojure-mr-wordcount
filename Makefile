.PHONY: test clean repl classes

clean:
	-rm `find classes -name "*.class"`

classes: 
	-mkdir -p classes/com/curry/utils/calc
	-mkdir -p classes/com/gentest

classes/MyJavaClass.class: MyJavaClass.java classes
	javac -d classes -cp .:classes $<


classes/com/gentest/AbstractJavaClass.class: src/com/gentest/AbstractJavaClass.java classes
	javac -d classes -cp .:classes $<

repl:
	rlwrap java -classpath .:classes:src:/Users/ekoontz/.m2/repository/org/clojure/clojure/1.3.0/clojure-1.3.0.jar clojure.main

test: classes/MyJavaClass.class
	java -cp .:classes MyJavaClass foo

