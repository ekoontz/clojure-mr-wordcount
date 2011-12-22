(ns org.wordcount.mr)

(gen-class 
 :name org.wordcount.mr.Reducer
 :extends org.apache.hadoop.mapred.MapReduceBase
 :implements ["org.apache.hadoop.mapred.Reducer"]
 :prefix "reducer-")

(defn -initialize []
  (println "initialization of mr..")
  )
