(require 'asdf)

(asdf:operate 'asdf:load-op :cffi)

(cffi:load-foreign-library "libfltk.so")

(load (merge-pathnames "example-bindings/fltk-cffi-bindings.lisp"
                       (asdf:component-pathname (asdf:find-system :verrazano))))

(defpackage :fltk-test
  (:use :common-lisp :fltk-cffi-bindings))

(in-package :fltk-test)

(defun main()
  (let ((win (fl-window-new-2 300 200 "Testing")))
    (fl-group-begin win)
    (let ((but (fl-button-new-1 10 150 70 30 "Click me")))
      (fl-group-end win)
      (fl-window-show win)
      (fl-run))))

(main)

