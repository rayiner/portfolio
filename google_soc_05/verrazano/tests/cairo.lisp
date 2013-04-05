(require :asdf)

(asdf:operate 'asdf:load-op :cffi)

(cffi:load-foreign-library "libcairo.so")

(load (merge-pathnames "example-bindings/cairo-cffi-bindings.lisp"
                       (asdf:component-pathname (asdf:find-system :verrazano))))

(defpackage :cairo-test
  (:use :common-lisp :asdf :cairo-cffi-bindings))

(in-package :cairo-test)

(defconstant +stroke-width+ 0.04d0)

(defun draw (cr side)
  (cairo-scale cr side side)
  (cairo-set-line-width cr +stroke-width+)
  (let ((x0 0.1d0)
	(y0 0.1d0)
	(x1 0.9d0)
	(y1 0.9d0)
	(r 0.4d0))
    (cairo-move-to cr x0 (+ y0 r))
    (cairo-curve-to cr x0 y0 x0 y0 (/ (+ x0 x1) 2.0d0) y0)
    (cairo-curve-to cr x1 y0 x1 y0 x1 (+ y0 r))
    (cairo-line-to cr x1 (- y1 r))
    (cairo-curve-to cr x1 y1 x1 y1 (/ (+ x0 x1) 2.0d0) y1)
    (cairo-curve-to cr x0 y1 x0 y1 x0 (- y1 r))
    (cairo-close-path cr)
    (cairo-set-source-rgb cr 0.5d0 0.5d0 1d0)
    (cairo-fill-preserve cr)
    (cairo-set-source-rgba cr 0.5d0 0.0d0 0.0d0 0.5d0)
    (cairo-stroke cr)
    (cairo-select-font-face cr "Sans" :cairo-font-slant-normal
                            :cairo-font-weight-normal)
    (cairo-set-font-size cr 0.2d0)
    (cairo-move-to cr 0.275d0 0.560d0)
    (cairo-text-path cr "Lisp!")
    (cairo-set-source-rgb cr 0.0d0 0.5d0 0.5d0)
    (cairo-fill-preserve cr)
    (cairo-set-source-rgb cr 0.0d0 0.0d0 0.0d0)
    (cairo-set-line-width cr 0.01d0)
    (cairo-stroke cr)))

(let ((sfc (cairo-image-surface-create :cairo-format-argb32 175 175)))
  (let ((cr (cairo-create sfc)))
    (draw cr 175.0d0)
    (cairo-surface-write-to-png sfc (namestring
                                     (merge-pathnames "../testsuite/cairo-output.png"
                                                      (component-pathname
                                                       (find-system :verrazano)))))
    (cairo-destroy cr)
    (cairo-surface-destroy sfc)))

(let ((sfc (cairo-pdf-surface-create (namestring
                                      (merge-pathnames "../testsuite/cairo-output.pdf"
                                                       (component-pathname
                                                        (find-system :verrazano))))
                                     288.0d0 288.0d0)))
  (let ((cr (cairo-create sfc)))
    (draw cr 288.0d0)
    (cairo-show-page cr)
    (cairo-destroy cr)
    (cairo-surface-destroy sfc)))

(in-package :cl-user)
(quit)
