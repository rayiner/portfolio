; spilling.lisp
; Code to support spilling of temporaries to the backing store

(in-package "VITAMIN")

(defclass spill-temporary (temporary) ())

(defun spilled-temporary? (temp)
  (typep temp 'spill-temporary))

(defun new-spill-temporary (proc)
  (let* ((count (incf (mproc-spill-count proc)))
	 (temp (make-instance 'spill-temporary
			      :name (suffixsym "spill."
					       (format nil ".~A" count)))))
    (setf (ftemp-base temp) temp)
    (add-to-universe temp (mproc-spills proc))))