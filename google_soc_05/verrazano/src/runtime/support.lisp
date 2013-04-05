; utility routines for users of Verrazano-generated packages
(in-package :cl-user)

(defpackage :verrazano-runtime
  (:nicknames #:vzn)
  (:use :common-lisp :cffi)
  (:export #:vtable-lookup
	   #:virtual-funcall))

(in-package :verrazano-runtime)

;; lookup the pointer to a given function
(defun vtable-lookup (pobj indx coff)
  (let ((vptr (mem-ref pobj :pointer coff)))
    (mem-aref vptr :pointer (- indx 2))))

;; macro for emitting a virtual function call
(defmacro virtual-funcall (pobj indx coff &body body)
  `(foreign-funcall-pointer (vtable-lookup ,pobj ,indx ,coff) nil ,@body))
