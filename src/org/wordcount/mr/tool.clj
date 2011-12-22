(in-ns 'org.wordcount.mapreduce)

(gen-class
 :name "org.wordcount.mapreduce.tool"
 :extends "org.apache.hadoop.conf.Configured"
 :implements ["org.apache.hadoop.util.Tool"]
 :main true)

;; now:
;; (.getConf (org.wordcount.mapreduce.tool.))
;; works.

(defn -main [& args]
  (println "inside tool-main..any backpacks around here?"))

       