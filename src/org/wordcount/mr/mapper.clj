(in-ns 'org.wordcount.mapreduce)

(gen-class
 :name "org.wordcount.mapreduce.mapper"
 :extends "org.apache.hadoop.mapred.MapReduceBase"
 :implements ["org.apache.hadoop.mapred.Mapper"]
 :prefix "mapper-")
