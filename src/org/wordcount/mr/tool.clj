(in-ns 'org.wordcount.mapreduce)
(import 'java.util.StringTokenizer)
(import 'org.apache.hadoop.util.Tool)

(gen-class
 :name "org.wordcount.mapreduce.tool"
 :extends "org.apache.hadoop.conf.Configured"
 :implements ["org.apache.hadoop.util.Tool"]
 :main true)

;; now:
;; (.getConf (org.wordcount.mapreduce.tool.))
;; works.

(defn -run [#^Tool this args]
  (println "THE RUN METHOD IS HERE, ok?")
  0)

(defn -main [& args]
  (do
    (println "inside tool-main..any backpacks around here?")
    (System/exit
     (org.apache.hadoop.util.ToolRunner/run 
      (new org.apache.hadoop.conf.Configuration)
      (. (Class/forName "org.wordcount.mapreduce.tool") newInstance)
      (into-array String args)))))
