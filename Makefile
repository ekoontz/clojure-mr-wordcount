.PHONY: test clean repl clj_test java_test classes
CLASSPATH=.:classes:src:lib/clojure-1.3.0.jar:lib/hadoop-core-0.20.205.1.jar
clean:
	-rm `find classes -name "*.class"` `find src -name "*~"` # remove class files and emacs auto-saved files.

lib/clojure-1.3.0.jar:
	lein deps

classes/org/wordcount classes/com/wordcount:
	-mkdir -p $@

classes: classes/org/wordcount/mr/config.class classes/org/wordcount/mr/mapper.class classes/org/wordcount/mr/reducer.class

classes/com/wordcount/AbstractWordCount.class: src/com/wordcount/AbstractWordCount.java classes/com/wordcount
	javac -d classes -cp .:classes $<

classes/org/wordcount/WordCount.class: lib/clojure-1.3.0.jar classes/com/wordcount/AbstractWordCount.class
	echo "(compile 'org.wordcount)" | java -cp $(CLASSPATH) clojure.main

classes/org/wordcount/Aux.class: lib/clojure-1.3.0.jar classes/com/wordcount/AbstractWordCount.class
	echo "(compile 'org.wordcount.aux)" | java -cp $(CLASSPATH) clojure.main

classes/org/wordcount/mr/config.class: lib/clojure-1.3.0.jar src/org/wordcount/mr/config.clj
	echo "(do (load \"org/wordcount/mr/config\") (compile 'org.wordcount.mr))" | java -cp $(CLASSPATH) clojure.main

classes/org/wordcount/mr/mapper.class: lib/clojure-1.3.0.jar src/org/wordcount/mr/mapper.clj
	echo "(do (load \"org/wordcount/mr/mapper\") (compile 'org.wordcount.mr))" | java -cp $(CLASSPATH) clojure.main

classes/org/wordcount/mr/reducer.class: lib/clojure-1.3.0.jar src/org/wordcount/mr/reducer.clj 
	echo "(do (load \"org/wordcount/mr/reducer\") (compile 'org.wordcount.mr))" | java -cp $(CLASSPATH) clojure.main

test: classes java_test clj_test
	echo "all tests passed."

java_test: classes/com/wordcount/AbstractWordCount.class classes/org/wordcount/WordCount.class
	java -cp $(CLASSPATH) org.wordcount.WordCount

clj_test: lib/clojure-1.3.0.jar classes/org/wordcount/WordCount.class classes/org/wordcount/WordCount.class
	echo "(load \"org/wordcount/test\")" | java -cp $(CLASSPATH) clojure.main

repl:
	rlwrap java -cp $(CLASSPATH) clojure.main

