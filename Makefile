.PHONY: test clean

clean:
	-rm classes/*.class

classes:
	-mkdir -p classes

classes/MyJavaClass.class: MyJavaClass.java classes
	javac -d classes -cp .:classes $<


test: classes/MyJavaClass.class
	java -cp .:classes MyJavaClass foo

