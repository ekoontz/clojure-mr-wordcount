(in-ns 'org.wordcount.mapreduce)

(gen-class
 :name "org.wordcount.mapreduce.config"
 :extends "org.apache.hadoop.conf.Configured"
 :implements ["org.apache.hadoop.util.Tool"]
 :main true)

;; now:
;; (.getConf (org.wordcount.mapreduce.config.))
;; works.

(defn -main [& args]
  (println "inside tool-main..any backpacks around here?"))

       