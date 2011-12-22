(ns org.wordcount.mr)

(gen-class 
 :name org.wordcount.mr.Mapper
 :extends org.apache.hadoop.mapred.MapReduceBase
 :implements ["org.apache.hadoop.mapred.Mapper"]
 :prefix "mapper-")

(defn -initialize []
  (println "initialization of mr..")
  )
