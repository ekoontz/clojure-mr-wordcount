(ns org.wordcount.mr)

(gen-class 
 :name org.wordcount.Mr
 :extends org.apache.hadoop.conf.Configured
 :implements ["org.apache.hadoop.util.Tool"]
 :prefix "tool-"
 :main true)

(defn -initialize []
  (println "initialization of mr..")
  )

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

(compile 'org.wordcount.mr)
