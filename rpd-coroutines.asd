;;;; rpd-coroutines.asd

(asdf:defsystem #:rpd-coroutines
  :serial t
  :depends-on (#:alexandria
               #:cl-cont)
  :components ((:file "package")
               (:file "rpd-coroutines")))

