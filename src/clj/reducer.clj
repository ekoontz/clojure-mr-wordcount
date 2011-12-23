(in-ns 'wordcount)

(gen-class
 :name "wordcount.reducer"
 :extends "org.apache.hadoop.mapred.MapReduceBase"
 :implements ["org.apache.hadoop.mapred.Reducer"])

(defn -reduce 
  "This is our implementation of the Reducer.reduce method.  The key
  argument is a sub-class of Hadoop's Writable, but 'values' is a Java
  Iterator that returns successive values.  We have to use
  iterator-seq to get a Clojure sequence from the Iterator.  

  Beware, however, that Hadoop re-uses a single object for every
  object returned by the Iterator.  So when you get an object from the
  iterator, you must extract its value (as we do here with the 'get'
  method) immediately, before accepting the next value from the
  iterator.  That is, you cannot hang on to past values from the
  iterator."
  [this key values #^OutputCollector output reporter]
  (let [sum (reduce + (map (fn [#^LongWritable v] (.get v)) (iterator-seq values)))]
    (.collect output key (LongWritable. sum))))

