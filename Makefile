.PHONY: test clean repl clj_test java_test
CLASSPATH=.:classes:src:lib/clojure-1.3.0.jar
clean:
	-rm `find classes -name "*.class"`

lib/clojure-1.3.0.jar:
	lein deps

classes/com/gentest:
	-mkdir -p $@

classes/com/gentest/AbstractJavaClass.class: src/com/gentest/AbstractJavaClass.java classes
	javac -d classes -cp .:classes $<

classes/com/gentest/ConcreteClojureClass.class: lib/clojure-1.3.0.jar
	echo "(compile 'com.gentest.gen_clojure)" | java -cp $(CLASSPATH) clojure.main

test: java_test clj_test

java_test: classes/com/gentest/AbstractJavaClass.class classes/com/gentest/ConcreteClojureClass.class
	java -cp $(CLASSPATH) com.gentest.ConcreteClojureClass

clj_test: lib/clojure-1.3.0.jar classes/com/gentest/AbstractJavaClass.class classes/com/gentest/ConcreteClojureClass.class
	echo "(load \"concrete-test\")" | java -cp $(CLASSPATH) clojure.main

repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

