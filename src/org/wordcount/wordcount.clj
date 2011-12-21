(load "org.hadoopgen.gen_clojure")

(.getSecret (org.wordcount.WordCount. "foo"))

(def myobj (org.wordcount.WordCount. "foo" "bar"))

(.run myobj)
