(ns org.hadoopgen.gen_clojure
  (:import (com.wordcount AbstractWordCount))
  (:gen-class
   :name org.wordcount.WordCount
   :extends com.wordcount.AbstractWordCount
   :constructors {[String] [String]
                  [String String] [String String]}
   :implements [Runnable]
   :init initialize
   :state localState
   :methods [[stateValue [] String]]))

(defn -initialize
  ([s1]
     (println "Init value: " s1)
     [[s1 "default"] (ref s1)])
  ([s1 s2]
     (println "Init values:" s1 "," s2)
     [[s1 s2] (ref s2)]))

(defn -getCurrentStatus [this]
  "getCurrentStatus from Wordcount.")

(defn -stateValue [this]
  @(.localState this))

(defn -run [this]
  (println "In run!")
  (println "I'm a" (class this))
  (dosync (ref-set (.localState this) "GO")))

(defn -main []
  (let [g (new org.wordcount.WordCount "READY")]
    (println (.getCurrentStatus g))
    (println (.getSecret g))
    (println (.stateValue g)))
  (let [g (new org.wordcount.WordCount "READY" "SET")]
    (println (.stateValue g))
    (.start (Thread. g))
    (Thread/sleep 1000)
    (println (.stateValue g))))



  