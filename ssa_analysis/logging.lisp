; logging.lisp
; A central logging facility

(in-package "VITAMIN")

(defvar *global-log* nil)

(defun enable-logging ()
  (setf *global-log* (open "debug/compiler.log" :direction :output
			   :if-exists :append :if-does-not-exist :create)))

(defun disable-logging ()
  (when *global-log* (close *global-log*))
  (setf *global-log* nil))

(defun logging? ()
  *global-log*)

(defun note (id msg &rest args)
  (when *global-log*
    (format *global-log* "~A ~A: " (get-internal-run-time) (symbol-name id))
    (apply 'format *global-log* msg args)
    (format *global-log* "~%")))
