;;;; rpd-coroutines.lisp

(in-package #:rpd-coroutines)

;;; "rpd-coroutines" goes here. Hacks and glory await!

(defmacro make-coroutine ((&key (done-value :done)
				(yield 'yield)) &body body)
  "Make a coroutine.
 * done-value - a value to return after the body has finished executing
 * yield - the symbol you want to use for your yield function
 * body - contents of your routine, with yield statements.  Runs in a progn.

Uses the cl-cont continuation library (and all the limitations that go with it)
to create a repeatedly funcallable function."
  (with-unique-names (continuation)
    `(let (,continuation)
       (with-call/cc
	 (labels ((,yield (&rest values)  
		    (let/cc k
		      (setf ,continuation k)
		      (apply #'values values))))
	   (,yield (lambda () (call/cc ,continuation)))
	   ,@body
	   (loop do (,yield ,done-value)))))))

(defun %coroutine-test ()
  "simple test function"
  (let ((cor (make-coroutine ()
	       (yield 1)
	       (yield)
	       (yield 4))))

    (assert (eql 1 (funcall cor)) )
    (assert (null (funcall cor)))
    (assert (eql 4 (funcall cor)))
    (assert (eql :done (funcall cor)))
    (assert (eql :done (funcall cor)))))
