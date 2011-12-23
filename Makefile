# run "make clean reload test" to exercise all functionality.
.PHONY: test clean repl classes load clear-input reload
CLASSPATH=.:classes:src/clj:lib/clojure-1.3.0.jar:lib/hadoop-core-0.20.205.1.jar:lib/commons-logging-1.1.1.jar:lib/jackson-mapper-asl-1.8.2.jar:lib/jackson-core-asl-1.8.2.jar:src/resources:
HDFS_ROOT=hdfs://localhost:9000
SOURCES=src/clj/wordcount.clj src/clj/tool.clj src/clj/reducer.clj src/clj/mapper.clj

clean:
	-rm *.jar `find classes -name "*.class"` `find src -name "*~"` # remove class files and emacs auto-saved files.

lib/clojure-1.3.0.jar:
#this loads in all the libraries (not just lib/clojure-1.3.0.jar: see project.clj for set of dependencies).
	lein deps

classes/org/wordcount:
	-mkdir -p $@

load:
	-hadoop fs -mkdir $(HDFS_ROOT)/hd-in/
	hadoop fs -copyFromLocal README $(HDFS_ROOT)/hd-in/
	find src -name "*.clj" -exec hadoop fs -copyFromLocal '{}' $(HDFS_ROOT)/hd-in/ ';'
	hadoop fs -ls $(HDFS_ROOT)/hd-in/

clear-input:
	-hadoop fs -rmr $(HDFS_ROOT)/hd-in/

reload: clear-input load

classes: lib/clojure-1.3.0.jar $(SOURCES)
	mkdir -p wordcount 
	echo "(try (compile 'wordcount) (catch java.lang.RuntimeException compiler-error (do (println compiler-error) (System/exit 1))))  " | java -cp $(CLASSPATH) clojure.main

wordcount.jar: classes
	jar -cf $@ $<

test: wordcount.jar classes
	-hadoop fs -rmr $(HDFS_ROOT)/hd-out/
	hadoop jar wordcount.jar wordcount $(HDFS_ROOT)/hd-in $(HDFS_ROOT)/hd-out
	make summary 
	echo "all tests passed."

summary: 
#show the top 20 most-frequent words.
	hadoop fs -cat $(HDFS_ROOT)/hd-out/part-00000 | sort -r -n -k2 |head -n 20


repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

