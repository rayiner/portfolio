; transform.lisp
; Contains common code used by various CFG transformations

(in-package "VITAMIN")

(defstruct deletion-queue
  queue
  fun)

(defun new-deletion-queue (fun)
  (make-deletion-queue :fun fun))

(defun queue-for-deletion (thing queue)
  (push thing (deletion-queue-queue queue)))

(defun delete-queued-items (queue)
  (iter (for thing in (deletion-queue-queue queue))
	(funcall (deletion-queue-fun queue) thing)))

(defun convert-to-strict-form (proc)
  (ensure-analyses-valid '(:livein) proc)
  (iter (for temp in-univ (proc-names proc))
	(when (set-member? temp (fblock-livein (proc-entry proc)))
	  (prepend-block-instruction (new-undef temp) (proc-entry proc))))
  proc)
 