(in-ns 'org.wordcount.wordcount)
(import 'java.util.StringTokenizer)
(import '(org.apache.hadoop.mapred OutputCollector))
(import '(org.apache.hadoop.io LongWritable))

(gen-class
 :name "org.wordcount.mapreduce.mapper"
 :extends "org.apache.hadoop.mapred.MapReduceBase"
 :implements ["org.apache.hadoop.mapred.Mapper"]
 :prefix "mapper-")

(defn mapper-map
  "This is our implementation of the Mapper.map method.  The key and
  value arguments are sub-classes of Hadoop's Writable interface, so
  we have to convert them to strings or some other type before we can
  use them.  Likewise, we have to call the OutputCollector.collect
  method with objects that are sub-classes of Writable."
  [this key value #^OutputCollector output reporter]
  (doseq [word (enumeration-seq (StringTokenizer. (str value)))]
    (.collect output (Text. word) (LongWritable. 1))))
