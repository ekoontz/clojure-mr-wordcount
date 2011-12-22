(in-ns 'org.wordcount.mapreduce)

(gen-class
 :name "org.wordcount.mapreduce.reducer"
 :extends "org.apache.hadoop.mapred.MapReduceBase"
 :implements ["org.apache.hadoop.mapred.Reducer"]
 :prefix "reducer-")
