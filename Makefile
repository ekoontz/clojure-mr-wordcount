# run "make clean reload test" to exercise all functionality.
.PHONY: test clean repl wordcount-test classes load clear-input reload
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

classes: classes/org/wordcount/wc/tool.class 

classes/org/wordcount/wc/tool.class: lib/clojure-1.3.0.jar src/org/wordcount/wc/tool.clj
	mkdir -p classes/org/wordcount/wc
	echo "(try (compile 'org.wordcount.mapreduce) (catch java.lang.RuntimeException compiler-error (do (println compiler-error) (System/exit 1))))  " | java -cp $(CLASSPATH) clojure.main

wordcount.jar: classes/org/wordcount/wc/tool.class
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

