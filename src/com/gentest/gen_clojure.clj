(ns com.gentest.gen_clojure
  (:import (com.gentest AbstractJavaClass))
  (:gen-class
   :name com.gentest.ConcreteClojureClass
   :extends com.gentest.AbstractJavaClass
   :constructors {[String] [String]
                  [String String] [String String]}
   :implements [Runnable]
   :init initialize
   :state localState
   :method [[stateValue [] String]]
   ))

(defn -initialize
  ([s1]
     (println "Init value: " s1)
     [[s1 "default"] (ref s1)])
  ([s1 s2]
     (println "Init values:" s1 "," s2)))
;     [[s2] (ref s2)]))

(defn -getCurrentStatus [this]
  "getCurrentStatus from - com.gentest.ConcreteClojureClass - what is up!!")

(defn -getCurrentStats [this]
  "getCurrentStats from - com.gentest.ConcreteClojureClass - what is down!!")

(defn -stateValue [this]
  @(.localState this))

(defn -stateValue2 [this]
  "stateValue2 HAS BEEN CALLED!!")

;;(defn -getFoo [this]
;;  "I want to buy a large backpack..")

(defn -run [this]
  (println "In run!")
  (println "I'm a" (class this))
  (dosync (ref-set (.localState this) "GO")))

(defn -main []
  (println "BEGINNING..")
  (let [g (new com.gentest.ConcreteClojureClass "READY")]
    (println "FIRST G CONSTRUCTOR...")
;    (println (.getFoo g))
    (println (.getCurrentStatus g))
    (println (.getCurrentStats g))
;    (println (.getCurrentStatus2 g)))
;    (println (.getSecret g))
;    (println (.stateValue2 g)))
  ;;    (println (.stateValue g)))
  )
  (let [g (new com.gentest.ConcreteClojureClass "READY" "SET")]
    (println "SECOND G CONSTRUCTOR..."))
;    (println (.stateValue g))
;    (.start (Thread. g))
;    (Thread/sleep 1000)
;    (println (.stateValue g))
;    ))
)



  