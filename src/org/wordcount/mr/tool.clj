(in-ns 'org.wordcount.mapreduce)
(import 'java.util.StringTokenizer)
(import 'org.apache.hadoop.util.Tool)
(import '(org.apache.hadoop.mapred JobConf TextInputFormat TextOutputFormat FileInputFormat FileOutputFormat JobClient))
(import '(org.apache.hadoop.io Text LongWritable))
(import '(org.apache.hadoop.fs Path))
(import '(org.codehaus.jackson.map JsonMappingException))

(gen-class
 :name "org.wordcount.mapreduce.tool"
 :extends "org.apache.hadoop.conf.Configured"
 :implements ["org.apache.hadoop.util.Tool"]
 :main true)

(defn -run [#^Tool this args]
  (doto (JobConf. (.getConf this) (.getClass this))
    (.setJobName "doesThisNameMatterOrNot")
    (.setJar "wc.jar")
    (.setOutputKeyClass Text)
    (.setOutputValueClass LongWritable)
    (.setMapperClass (Class/forName "org.wordcount.mapreduce.mapper"))
    (.setReducerClass (Class/forName "org.wordcount.mapreduce.reducer"))
    (.setInputFormat TextInputFormat)
    (.setOutputFormat TextOutputFormat)
    (FileInputFormat/setInputPaths (first args))
    (FileOutputFormat/setOutputPath (Path. (second args)))
    (JobClient/runJob)
    )

  (println "Done running: returning 0 now.")
  0)

(defn -main [& args]
  (do
    (System/exit
     (org.apache.hadoop.util.ToolRunner/run 
      (new org.apache.hadoop.conf.Configuration)
      (. (Class/forName "org.wordcount.mapreduce.tool") newInstance)
      (into-array String args)))))
