(ns org.wordcount.mr)

(gen-class 
 :name org.wordcount.mr.Config
 :extends org.apache.hadoop.conf.Configured
 :implements ["org.apache.hadoop.util.Tool"]
 :prefix "tool-"
 :main true)

(defn -initialize []
  (println "initialization of mr..")
  )

(defn -main []
  (println "config's main is being called.."))
