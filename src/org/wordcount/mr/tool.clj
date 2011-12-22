(in-ns 'org.wordcount.mapreduce)
(import 'java.util.StringTokenizer)
(import 'org.apache.hadoop.util.Tool)
(import '(org.apache.hadoop.mapred JobConf))
(import '(org.apache.hadoop.io Text LongWritable))

(gen-class
 :name "org.wordcount.mapreduce.tool"
 :extends "org.apache.hadoop.conf.Configured"
 :implements ["org.apache.hadoop.util.Tool"]
 :main true)

;; now:
;; (.getConf (org.wordcount.mapreduce.tool.))
;; works.

(defn -run [#^Tool this args]
  (println "Here we go..")
  (doto (JobConf. (.getConf this) (.getClass this))
    (.setJobName "mywordcount")
    (.setOutputKeyClass Text)
    (.setOutputValueClass LongWritable)
    )

  (println "Done running: returning 0 now.")
  0)

(defn -main [& args]
  (do
    (println "inside tool-main..any backpacks around here?")
    (System/exit
     (org.apache.hadoop.util.ToolRunner/run 
      (new org.apache.hadoop.conf.Configuration)
      (. (Class/forName "org.wordcount.mapreduce.tool") newInstance)
      (into-array String args)))))
