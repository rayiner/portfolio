(require 'asdf)

(asdf:operate 'asdf:load-op :cffi)

(cffi:load-foreign-library "libvfun.so")

(load (merge-pathnames "../testsuite/vfun/vfun-cffi-bindings.lisp"
                       (asdf:component-pathname (asdf:find-system :verrazano))))

(defpackage :vfun-test
  (:use :common-lisp :vfun-cffi-bindings))

(in-package :vfun-test)

(let ((pr (baser-new-1 3))
      (pb (base-new-1 5))
      (pd (derived-new-1 7)))
  (format t "~A ~A ~A~%" 
	  (baser-get-value pr)
	  (base-get-value pb)
	  (base-get-value pd)))

(in-package :cl-user)
(quit)
