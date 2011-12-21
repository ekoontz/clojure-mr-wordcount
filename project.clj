;; TODO: move functionality out of Makefile and into here as I gradually learn leiningen.
(defproject cia-ch-5 "1.0.0-SNAPSHOT"
  :jvm-opts ["-Xmx768m" "-server"]
  :description "experiments based on Chapter 5 of Clojure In Action by Amit Rathore."
  :javac-options {:debug "true" :fork "true"}
  :repositories {"conjars" "http://conjars.org/repo/"
                 "bixo" "http://bixo.github.com/repo"
                 "mvn" "http://mvnrepository.com"}
  :dependencies [[org.clojure/clojure "1.3.0"]
                 [org.clojure/clojure-contrib "1.2.0"]
                 ;; jgrapht exclusion works around cascading pom bug
                 ;; that causes projects dependent on cascalog to not
                 ;; be able to find jgrapht.
                 [cascading/cascading-core "1.2.4"
                  :exclusions [org.codehaus.janino/janino
                               thirdparty/jgrapht-jdk1.6
                               riffle/riffle]]
                 [thirdparty/jgrapht-jdk1.6 "0.8.1"]
                 [riffle/riffle "0.1-dev"]
                 [log4j/log4j "1.2.16"]
                 [commons-cli "1.2"]
                 [commons-configuration "1.6"]
                 [commons-logging "1.1.1"]
                 [hadoop-util "0.2.4"]
                 [junit/junit "4.7"]
                 [com.bixolabs/cascading.solr "1.0-SNAPSHOT"]
                 [com.stuartsierra/clojure-hadoop "1.2.0-SNAPSHOT"]
                 [org.mortbay.jetty/servlet-api-2.5 "6.1.14"]
                 [org.codehaus.jackson/jackson-core-asl "1.8.2"]
                 [org.codehaus.jackson/jackson-mapper-asl "1.8.2"]]
  :resources-path "src/resources")

  


