# run "make clean reload test" to exercise all functionality.
.PHONY: test clean repl clj_test mr_test java_test classes load clear-input reload
CLASSPATH=.:classes:src:lib/clojure-1.3.0.jar:lib/hadoop-core-0.20.205.1.jar:lib/commons-logging-1.1.1.jar:lib/jackson-mapper-asl-1.8.2.jar:lib/jackson-core-asl-1.8.2.jar:src/resources:
HDFS_ROOT=hdfs://localhost:9000

clean:
	-rm *.jar `find classes -name "*.class"` `find src -name "*~"` # remove class files and emacs auto-saved files.

lib/clojure-1.3.0.jar:
#this loads in all the libraries (not just lib/clojure-1.3.0.jar: see project.clj for set of dependencies).
	lein deps

classes/org/wordcount classes/com/wordcount:
	-mkdir -p $@

load:
	-hadoop fs -mkdir $(HDFS_ROOT)/hd-in/
	find src -name "*.clj" -exec hadoop fs -copyFromLocal '{}' $(HDFS_ROOT)/hd-in/ ';'
	hadoop fs -ls $(HDFS_ROOT)/hd-in/

clear-input:
	-hadoop fs -rmr $(HDFS_ROOT)/hd-in/

reload: clear-input load

classes: classes/org/wordcount/mr/tool.class 

classes/org/wordcount/mr/tool.class: lib/clojure-1.3.0.jar src/org/wordcount/mr/tool.clj
	echo "(try (compile 'org.wordcount.mapreduce) (catch java.lang.RuntimeException compiler-error (do (println compiler-error) (System/exit 1))))  " | java -cp $(CLASSPATH) clojure.main

wordcount.jar: classes/org/wordcount/mr/tool.class
	jar -cf $@ classes

test: classes wordcount-test
	echo "all tests passed."


wordcount-test: wordcount.jar
	-hadoop fs -rmr $(HDFS_ROOT)/hd-out/
	hadoop jar wordcount.jar org.wordcount.mapreduce $(HDFS_ROOT)/hd-in $(HDFS_ROOT)/hd-out
	make summary 

summary: 
#show the top 20 most-frequent words.
	hadoop fs -cat $(HDFS_ROOT)/hd-out/part-00000 | sort -r -n -k2 |head -n 20


repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

#java_test and clj_test are older and don't use the same classes: needs work for 
#integration with wordcount-test.
java_test: classes/com/wordcount/AbstractWordCount.class classes/org/wordcount/WordCount.class
	java -cp $(CLASSPATH) org.wordcount.WordCount

clj_test: lib/clojure-1.3.0.jar classes/org/wordcount/WordCount.class classes/org/wordcount/WordCount.class
	echo "(load \"org/wordcount/test\")" | java -cp $(CLASSPATH) clojure.main

#TODO: rename: has nothing to do with WordCount.
classes/com/wordcount/AbstractWordCount.class: src/com/wordcount/AbstractWordCount.java classes/com/wordcount
	javac -d classes -cp .:classes $<

#TODO: rename: has nothing to do with WordCount.
classes/org/wordcount/WordCount.class: lib/clojure-1.3.0.jar classes/com/wordcount/AbstractWordCount.class
	echo "(compile 'org.wordcount)" | java -cp $(CLASSPATH) clojure.main

#TODO: rename: has nothing to do with WordCount.
classes/org/wordcount/Aux.class: lib/clojure-1.3.0.jar classes/com/wordcount/AbstractWordCount.class
	echo "(compile 'org.wordcount.aux)" | java -cp $(CLASSPATH) clojure.main
