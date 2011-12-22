(ns org.wordcount.aux)

(gen-class 
 :name org.wordcount.Aux
 :constructors {[String] []}
 :init initialize
 :state localState
 :methods [[stateValue [] String]])

(defn -initialize [s1]
  (println "A secret: " (.getSecret (org.wordcount.WordCount. "foo")))
  (println "Aux init value: " s1))

(defn -stateValue [this]
  @(.localState this))

(compile 'org.wordcount)
