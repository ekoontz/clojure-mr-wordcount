.PHONY: test clean repl
CLASSPATH=.:classes:src:lib/clojure-1.3.0.jar
clean:
	-rm `find classes -name "*.class"`

lib/clojure-1.3.0.jar:
	lein deps

classes: classes/com/gentest
	-mkdir -p $<

classes/com/gentest/AbstractJavaClass.class: src/com/gentest/AbstractJavaClass.java classes
	javac -d classes -cp .:classes $<

classes/com/gentest/ConcreteClojureClass.class:
	echo "(compile 'com.gentest.gen_clojure)" | java -cp $(CLASSPATH) clojure.main

test: classes/com/gentest/AbstractJavaClass.class classes/com/gentest/ConcreteClojureClass.class
	java -cp $(CLASSPATH) com.gentest.ConcreteClojureClass

repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

