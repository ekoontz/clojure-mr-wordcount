(ns org.wordcount)

(.getSecret (org.wordcount.WordCount. "foo"))

(def myobj (org.wordcount.WordCount. "foo" "bar"))

(.run myobj)

