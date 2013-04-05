; data-flow.lisp
; Implements a reusable iterative data-flow solver

(in-package "VITAMIN")

(defmacro update-slot-unless (slot new-val pred bb)
  (let ((temp-val (gensym)))
    `(let ((,temp-val ,new-val))
       (if (,pred ,slot ,temp-val)
	   (setf (fblock-changed? ,bb) nil)
	   (setf (fblock-changed? ,bb) t))
       (setf ,slot ,temp-val))))

(defun do-merge-next-sets (comb-func way bb func universe)
  (let ((next-func (if (eql way :forward) #'bb-preds #'bb-succs)))
    (funcall comb-func 
	     (iter (for next in-vector (funcall next-func bb))
		   (collect (funcall func next)))
	     universe)))

(defun analyze-data-flow (proc way universe node-func comp-func)
  (ensure-analyses-valid '(:rpo) proc)
  (let ((rpo (if (eql way :forward) (proc-frpo proc) (proc-brpo proc))))
    (note 'dfa "Starting analysis ~A" comp-func)
    (when node-func
      (iter (for bb in-univ (proc-bbs proc))
	    (funcall node-func proc bb universe)))
    (to-fixpoint
      (note 'dfa "Iterating for ~A" comp-func)
      (iter (for bb in-vector rpo)
	    (flet ((merge-next (op func)
		     (do-merge-next-sets op way bb func universe)))
	      (funcall comp-func bb #'merge-next))
	    (when (fblock-changed? bb) (mark-changed))))))
