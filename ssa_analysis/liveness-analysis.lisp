; liveness-analysis.lisp
; Implements a DFA to find liveout and livein sets

(in-package "VITAMIN")

(defun make-empty-liveness-sets (block universe)
  (setf (fblock-livein block) (new-bit-set universe))
  (setf (fblock-liveout block) (new-bit-set universe))
  (setf (fblock-varkill block) (new-bit-set universe))
  (setf (fblock-uevar block) (new-bit-set universe))
  (setf (fblock-uevarp block)
	(map 'vector #'(lambda (pred)
			 (declare (ignore pred))
			 (new-bit-set universe)) 
	     (bb-preds block))))

(defun initialize-liveness-sets (proc block universe)
  (declare (ignore proc))
  (make-empty-liveness-sets block universe)
  (with-slots (uevar uevarp varkill) block
    (iter (for ins in-olist (bb-insns block) pred #'phi?)
	  (iter (for use in-olist (ins-uses ins) pred #'temporary?)
		(for uevar-n in-vector uevarp)
		(bs-add use uevar-n))
	  (iter (for def in-olist (ins-defs ins))
		(bs-add def varkill)))
    (iter (for ins in-olist (bb-insns block) pred #'not-phi?)
	  (iter (for use in-olist (ins-uses ins) pred #'temporary?)
		(unless (bs-member? use varkill)
		  (bs-add use uevar)))
	  (iter (for def in-olist (ins-defs ins))
		(bs-add def varkill)
		(bs-add block (ftemp-defin def))))))

(defun liveness-succ-contribution (pred succ)
  (with-slots (liveout uevar uevarp varkill) succ
    (let* ((uevar-n (aref uevarp (position pred (bb-preds succ))))
	   (uevar-t (if uevar-n (bs-ior uevar-n uevar) uevar)))
      (bs-ior (bs-and (bs-not varkill) liveout t) uevar-t t))))

(defun recompute-liveness-sets (block merge-next)
  (with-slots (liveout) block
    (flet ((succ-contrib-wrapper (succ)
	     (liveness-succ-contribution block succ)))
      (update-slot-unless liveout (funcall merge-next
					   #'bs-ior*
					   #'succ-contrib-wrapper)
			  bs-equal? block))))

(defun prepare-liveness-universe (proc)
  (iter (for temp in-univ (proc-names proc))
	(setf (ftemp-defin temp) (new-bit-set (proc-bbs proc)))))

(defun analyze-liveness (proc)
  (prepare-liveness-universe proc)
  (analyze-data-flow proc :backward
		     (proc-names proc)
		     #'initialize-liveness-sets
		     #'recompute-liveness-sets))

(defun analyze-livein (proc)
  (ensure-analyses-valid '(:liveout) proc)
  (iter (for bb in-univ (proc-bbs proc))
	(with-slots (livein liveout uevar varkill) bb
	  (setf livein 
		(bs-ior (bs-and (bs-not varkill) liveout t) uevar t))
	  (iter (for ins in-olist (bb-insns bb) pred #'phi?)
		(iter (for def in-olist (ins-defs ins))
		      (bs-add def livein))))))

(register-demand-analysis #'analyze-liveness '() '(:liveout :uevar 
						   :varkill :defin))

(register-demand-analysis #'analyze-livein '(:liveout) '(:livein))

