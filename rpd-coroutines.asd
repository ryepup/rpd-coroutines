;;;; rpd-coroutines.asd

(asdf:defsystem #:rpd-coroutines
  :serial t
  :depends-on (#:alexandria
               #:cl-cont
               #:bordeaux-threads)
  :components ((:file "package")
               (:file "rpd-coroutines")))

