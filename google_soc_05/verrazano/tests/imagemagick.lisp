(require :asdf)

(asdf:operate 'asdf:load-op :cffi)

(cffi:load-foreign-library "libMagick.so")
(cffi:load-foreign-library "libWand.so")

(load (merge-pathnames "exmaple-bindings/imagemagick-cffi-bindings.lisp"
                       (asdf:component-pathname (asdf:find-system :verrazano))))

(defpackage :imagemagick-test
  (:use :common-lisp :asdf :imagemagick-cffi-bindings :alexandria))

(in-package :imagemagick-test)

(magick-wand-genesis)

(defmacro with-new-magick-wand (wand &body body)
  `(let ((,wand (new-magick-wand)))
     (unwind-protect
          (progn ,@body)
       (destroy-magick-wand ,wand))))

(defun test ()
  (let ((input-file (namestring
                     (merge-pathnames "../testsuite/cairo-output.png"
                                      (component-pathname
                                       (find-system :verrazano)))))
        (output-file (namestring
                      (merge-pathnames "../testsuite/imagemagick-output.jpg"
                                       (component-pathname
                                        (find-system :verrazano))))))
    (with-new-magick-wand wand
      (unless (eq :magick-true
                  (magick-read-image wand input-file))
        (error "Failed to read ~A" input-file))
      (magick-resize-image wand 400 400 :gaussian-filter 1.0d0)
      (magick-write-images wand output-file :magick-true))))

(test)

(in-package :cl-user)
(quit)

#|

;; Bah, if someone has the time/energy/knowledge to follow all those 'wand's in the doc...

(defmacro with-new-drawing-wand (wand &body body)
  (destructuring-bind (wand &key color stroke-width) (ensure-list wand)
    (with-unique-names (drawing-wand)
      (once-only (wand)
        `(let ((,drawing-wand (new-drawing-wand)))
          (push-drawing-wand ,drawing-wand)
          (unwind-protect
               (progn
                 ,(when color
                    `(draw-set-stroke-color ,drawing-wand ,color))
                 ,(when stroke-width
                    `(draw-set-stroke-width ,drawing-wand ,stroke-width))
                 ,@body)
            (pop-drawing-wand ,wand)
            (destroy-drawing-wand ,drawing-wand)))))))

(defmacro with-new-pixel-wand (wand &body body)
  (destructuring-bind (wand &key color) (ensure-list wand)
    `(let ((,wand (new-pixel-wand)))
      (unwind-protect
           (progn
             ,(when color
                `(pixel-set-color ,wand ,color))
             ,@body)
        (destroy-pixel-wand ,wand)))))

(defconstant +stroke-width+ 0.04d0)

(defun draw (wand)
  (let ((x0 0.1d0)
	(y0 0.1d0)
	(x1 0.9d0)
	(y1 0.9d0)
	(r 0.4d0))
    (with-new-drawing-wand (wand :color "rgb(0,0,128)" :stroke-width +stroke-width+)
      (draw-path-move-to-absolute wand x0 (+ y0 r))
      (draw-path-curve-to-absolute wand x0 y0 x0 y0 (/ (+ x0 x1) 2.0d0) y0)
      (draw-path-curve-to-absolute wand x1 y0 x1 y0 x1 (+ y0 r))
      (draw-path-line-to-absolute wand x1 (- y1 r))
      (draw-path-curve-to-absolute wand x1 y1 x1 y1 (/ (+ x0 x1) 2.0d0) y1)
      (draw-path-curve-to-absolute wand x0 y1 x0 y1 x0 (- y1 r))
      ;;(cairo-close-path cr)
      )
    (with-new-drawing-wand (wand :color "rgb(128,128,255)")
      (draw-color wand 100 100 :floodfill-method) ; (cairo-fill cr)

      #+nil((cairo-set-source-rgba cr 0.5d0 0.0d0 0.0d0 0.5d0)
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
      (cairo-stroke cr)))))

(defun test ()
  (with-new-magick-wand wand
    (with-new-pixel-wand (background :color "rgb(0,0,255)")
      (magick-new-image wand 175 175 background)
      (draw wand)
      (magick-write-image wand (namestring
                                (merge-pathnames "../testsuite/imagemagick-output.png"
                                                 (component-pathname
                                                  (find-system :verrazano))))))))

(test)

|#
