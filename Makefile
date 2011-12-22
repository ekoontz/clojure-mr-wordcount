.PHONY: test clean repl clj_test mr_test java_test classes
CLASSPATH=.:classes:src:src/resources:lib/clojure-1.3.0.jar:lib/hadoop-core-0.20.205.1.jar:lib/commons-logging-1.1.1.jar
clean:
	-rm *.jar `find classes -name "*.class"` `find src -name "*~"` # remove class files and emacs auto-saved files.

lib/clojure-1.3.0.jar:
	lein deps

classes/org/wordcount classes/com/wordcount:
	-mkdir -p $@

classes: classes/org/wordcount/mr/tool.class 

classes/com/wordcount/AbstractWordCount.class: src/com/wordcount/AbstractWordCount.java classes/com/wordcount
	javac -d classes -cp .:classes $<

classes/org/wordcount/WordCount.class: lib/clojure-1.3.0.jar classes/com/wordcount/AbstractWordCount.class
	echo "(compile 'org.wordcount)" | java -cp $(CLASSPATH) clojure.main

classes/org/wordcount/Aux.class: lib/clojure-1.3.0.jar classes/com/wordcount/AbstractWordCount.class
	echo "(compile 'org.wordcount.aux)" | java -cp $(CLASSPATH) clojure.main

classes/org/wordcount/mr/tool.class: lib/clojure-1.3.0.jar src/org/wordcount/mr/tool.clj
	echo "(compile 'org.wordcount.mapreduce)" | java -cp $(CLASSPATH) clojure.main

wc.jar: classes/org/wordcount/mr/tool.class
	jar -cf $@ classes

test: classes java_test clj_test mr_test
	echo "all tests passed."

java_test: classes/com/wordcount/AbstractWordCount.class classes/org/wordcount/WordCount.class
	java -cp $(CLASSPATH) org.wordcount.WordCount

clj_test: lib/clojure-1.3.0.jar classes/org/wordcount/WordCount.class classes/org/wordcount/WordCount.class
	echo "(load \"org/wordcount/test\")" | java -cp $(CLASSPATH) clojure.main

mr_test: classes wc.jar
	hadoop jar wc.jar org.wordcount.mapreduce hdfs://localhost:9000/hd-in hdfs://localhost:9000/hd-out 

repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

