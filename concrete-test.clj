(load "com.gentest.gen_clojure")

(.getSecret (com.gentest.ConcreteClojureClass. "foo"))

(def myobj (com.gentest.ConcreteClojureClass. "foo" "bar"))

(.run myobj)
