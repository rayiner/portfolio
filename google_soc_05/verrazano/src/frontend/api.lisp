(in-package :verrazano)

(defvar *parser*)

(defvar *backend*)

(defvar *unique-name-counter*)

(defgeneric make-backend (backend-specification &key &allow-other-keys)
  (:method ((backend-specification list) &rest args)
    (assert (null args) () "MAKE-BACKEND was called with both a list BACKEND-SPECIFICATION and keyword args at the same time")
    (apply 'make-backend backend-specification)))

(defgeneric process-gccxml-node (backend node)
  (:documentation "This is the toplevel protocol method called on the root gccxml node which by default calls it on all its subnodes."))
