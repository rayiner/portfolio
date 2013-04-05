; printing.lisp
; Contains protocols for transforming internal data to lists and strings

(in-package "VITAMIN")

(defgeneric listify-thing (thing &optional short))

(defmethod listify-thing (thing &optional short)
  (declare (ignore short))
  thing)
