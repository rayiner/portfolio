; dominance-analysis.lisp
; Various analyses for finding dominance relationships in the CFG

(in-package "VITAMIN")

(defun make-empty-dominator-sets (block universe)
  (setf (fblock-dom block) (new-bit-set universe)))

(defun initialize-dominator-sets (proc block universe)
  (make-empty-dominator-sets block universe)
  (with-slots (dom) block
    (if (eql block (proc-entry proc))
	(bs-add block dom)
	(bs-add-all dom))))

(defun dominator-pred-contribution (block)
  (with-slots (dom) block dom))

(defun recompute-dominator-sets (block merge-next)
  (with-slots (dom) block
    (update-slot-unless dom (bs-ior (bs-from-element block dom)
				     (funcall merge-next
					      #'bs-and*
					      #'dominator-pred-contribution))
			bs-equal? block)))

(defun analyze-dominators (proc)
  (analyze-data-flow proc :forward
		     (proc-bbs proc)
		     #'initialize-dominator-sets
		     #'recompute-dominator-sets))

(defun analyze-immediate-dominators (proc)
  (let ((dom-table (make-hash-table :test #'equal)))
    (iter (for bb in-univ (proc-bbs proc))
	  (setf (fblock-domchld bb) (new-stretchy-vector))
	  (setf (gethash (bit-set-vector (fblock-dom bb)) dom-table) bb))
    (iter (for bb in-univ (proc-bbs proc))
	  (let* ((cur-dom (fblock-dom bb))
		 (i-dom (bs-without-element cur-dom bb))
		 (idom-bb (gethash (bit-set-vector i-dom) dom-table)))
	    (if idom-bb
		(progn
		  (setf (fblock-idom bb) idom-bb)
		  (vector-push-extend bb (fblock-domchld idom-bb)))
		(setf (fblock-idom bb) nil))))))

(defun make-empty-dominance-frontier-sets (block universe)
  (setf (fblock-df block) (new-sparse-set universe)))

(defun analyze-dominance-frontiers (proc)
  (iter (for bb in-univ (proc-bbs proc))
	(make-empty-dominance-frontier-sets bb (proc-bbs proc)))
  (iter (for bb in-univ (proc-bbs proc))
	(when (join-point? bb)
	  (let ((idom (fblock-idom bb)))
	    (iter (for pbb in-vector (bb-preds bb))
		  (let ((runner pbb))
		    (until-loop (eql runner idom)
		      (ss-add bb (fblock-df runner))
		      (setf runner (fblock-idom runner)))))))))

(register-demand-analysis #'analyze-dominators '() '(:dom))
(register-demand-analysis #'analyze-immediate-dominators '(:dom) '(:idom))
(register-demand-analysis #'analyze-dominance-frontiers '(:idom) '(:df))
