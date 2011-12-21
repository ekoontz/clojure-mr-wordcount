.PHONY: test clean repl clj_test java_test
CLASSPATH=.:classes:src:lib/clojure-1.3.0.jar
clean:
	-rm `find classes -name "*.class"`

lib/clojure-1.3.0.jar:
	lein deps

classes/org/wordcount classes/com/wordcount:
	-mkdir -p $@

classes/com/wordcount/AbstractWordCount.class: src/com/wordcount/AbstractWordCount.java classes/com/wordcount
	javac -d classes -cp .:classes $<

classes/org/wordcount/WordCount.class: lib/clojure-1.3.0.jar classes/com/wordcount/AbstractWordCount.class
	echo "(compile 'org.hadoopgen.gen_clojure)" | java -cp $(CLASSPATH) clojure.main

test: java_test clj_test
	echo "all tests passed."

java_test: classes/com/wordcount/AbstractWordCount.class classes/org/wordcount/WordCount.class
	java -cp $(CLASSPATH) org.wordcount.WordCount

clj_test: lib/clojure-1.3.0.jar classes/org/wordcount/WordCount.class classes/org/wordcount/WordCount.class
	echo "(load \"concrete-test\")" | java -cp $(CLASSPATH) clojure.main

repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

