; procedure.lisp
; Management of procedure-global data structures

(in-package "VITAMIN")

(defvar *target-registry* (make-hash-table))
(defparameter *current-target* :amd64)
(defparameter *cache-analyses?* t)

(defun register-target-procedure-maker (key func)
  (setf (gethash key *target-registry*) func))

(defun procedure-maker-for-target (key)
  (gethash key *target-registry*))

(defun new-procedure (name-table)
  (let ((proc (funcall (procedure-maker-for-target *current-target*))))
    (iter (for (name temp) in-hashtable name-table)
	  (add-to-universe temp (proc-names proc)))
    proc))

(defun note-analyses-valid (analyses proc)
  (note :repr-dep "Analyses marked valid - ~A" analyses)
  (iter (for analysis in analyses)
	(setf (gethash analysis (proc-analyses proc)) t)))

(defun note-analyses-invalid (analyses proc)
  (note :repr-dep "Analyses marked invalid - ~A" analyses)
  (iter (for analysis in analyses)
	(remhash analysis (proc-analyses proc))))

(defun note-all-analyses-invalid (proc)
  (note :repr-dep "All analyses marked invalid")
  (clrhash (proc-analyses proc)))

(defun note-only-analyses-valid (analyses proc)
  (iter (for analysis in (valid-analyses proc))
	(unless (member analysis analyses)
	  (remhash analysis (proc-analyses proc)))))

(defun analyses-valid? (analyses proc)
  (iter (for analysis in analyses)
	(unless (gethash analysis (proc-analyses proc)) (leave)))
  t)

(defun ensure-one-analysis-valid (analysis proc)
  (unless (gethash analysis (proc-analyses proc))
    (let ((analysis-obj (gethash analysis *demand-analyses*)))
      (iter (for req in (analysis-requires analysis-obj))
	    (ensure-one-analysis-valid req proc))
      (funcall (analysis-function analysis-obj) proc)
      (note-analyses-valid (analysis-provides analysis-obj) proc))))

(defun ensure-analyses-valid (analyses proc)
  (iter (for analysis in analyses)
	(ensure-one-analysis-valid analysis proc))
  (unless *cache-analyses?* (note-all-analyses-invalid proc)))

(defun valid-analyses (proc)
  (iter (for (key val) in-hashtable (proc-analyses proc))
	(collect key)))
