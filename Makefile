.PHONY: test clean repl clj_test java_test
CLASSPATH=.:classes:src:lib/clojure-1.3.0.jar
clean:
	-rm `find classes -name "*.class"`

lib/clojure-1.3.0.jar:
	lein deps

classes/com/gentest:
	-mkdir -p $@

classes/org/wordcount:
	-mkdir -p $@


classes/com/gentest/AbstractJavaClass.class: src/com/gentest/AbstractJavaClass.java classes/com/gentest
	javac -d classes -cp .:classes $<

classes/org/wordcount/AbstractWordCount.class: src/org/wordcount/AbstractWordCount.java classes/org/wordcount
	javac -d classes -cp .:classes $<

classes/com/gentest/ConcreteClojureClass.class: lib/clojure-1.3.0.jar classes/com/gentest/AbstractJavaClass.class
	echo "(compile 'com.gentest.gen_clojure)" | java -cp $(CLASSPATH) clojure.main

classes/org/wordcount/WordCount.class: lib/clojure-1.3.0.jar classes/org/wordcount/AbstractWordCount.class
	echo "(compile 'org.wordcount.gen_clojure)" | java -cp $(CLASSPATH) clojure.main

test: java_test clj_test wc_java_test wc_clj_test

java_test: classes/com/gentest/AbstractJavaClass.class classes/com/gentest/ConcreteClojureClass.class
	java -cp $(CLASSPATH) com.gentest.ConcreteClojureClass

wc_java_test: classes/org/wordcount/AbstractWordCount.class classes/org/wordcount/WordCount.class
	java -cp $(CLASSPATH) org.wordcount.WordCount

clj_test: lib/clojure-1.3.0.jar classes/com/gentest/AbstractJavaClass.class classes/com/gentest/ConcreteClojureClass.class
	echo "(load \"concrete-test\")" | java -cp $(CLASSPATH) clojure.main

wc_clj_test: lib/clojure-1.3.0.jar classes/org/wordcount/WordCount.class classes/org/wordcount/WordCount.class
	echo "(load \"concrete-test-wc\")" | java -cp $(CLASSPATH) clojure.main


repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

