.PHONY: test clean repl wc_clj_test wc_java_test
CLASSPATH=.:classes:src:lib/clojure-1.3.0.jar
clean:
	-rm `find classes -name "*.class"`

lib/clojure-1.3.0.jar:
	lein deps

classes/org/wordcount:
	-mkdir -p $@

classes/org/wordcount/AbstractWordCount.class: src/org/wordcount/AbstractWordCount.java classes/org/wordcount
	javac -d classes -cp .:classes $<

classes/org/wordcount/WordCount.class: lib/clojure-1.3.0.jar classes/org/wordcount/AbstractWordCount.class
	echo "(compile 'org.wordcount.gen_clojure)" | java -cp $(CLASSPATH) clojure.main

test: wc_java_test wc_clj_test

wc_java_test: classes/org/wordcount/AbstractWordCount.class classes/org/wordcount/WordCount.class
	java -cp $(CLASSPATH) org.wordcount.WordCount

wc_clj_test: lib/clojure-1.3.0.jar classes/org/wordcount/WordCount.class classes/org/wordcount/WordCount.class
	echo "(load \"concrete-test-wc\")" | java -cp $(CLASSPATH) clojure.main

repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

