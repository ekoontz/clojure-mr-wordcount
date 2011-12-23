(in-ns 'org.wordcount.foo)
(import '(java.util StringTokenizer))
(import '(org.apache.hadoop.util Tool))
(import '(org.apache.hadoop.mapred JobConf TextInputFormat TextOutputFormat FileInputFormat FileOutputFormat JobClient))
(import '(org.apache.hadoop.io Text LongWritable))
(import '(org.apache.hadoop.fs Path))
(import '(org.codehaus.jackson.map JsonMappingException))

(gen-class
 :name "org.wordcount.foo.tool"
 :extends "org.apache.hadoop.conf.Configured"
 :implements ["org.apache.hadoop.util.Tool"]
 :main true)

(defn -run [#^Tool this args]
  (println "The wordcount job has begun.");

  (doto (JobConf. (.getConf this) (.getClass this))
    (.setJobName "doesThisNameMatterOrNot")
    (.setJar "wordcount.jar")
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

  (println "The wordcount job has finished.");
  0)

(defn -main [& args]
  (do
    (System/exit
     (org.apache.hadoop.util.ToolRunner/run 
      (new org.apache.hadoop.conf.Configuration)
      (. (Class/forName "org.wordcount.foo.tool") newInstance)
      (into-array String args)))))
