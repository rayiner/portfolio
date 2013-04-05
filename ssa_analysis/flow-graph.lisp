; flow-graph.lisp
; Contains routines for operating on the control flow graph

(in-package "VITAMIN")

(defun temporary? (value)
  (typep value 'temporary))

(defun constant? (value)
  (typep value 'constant))

(defun branch? (ins)
  (typep ins 'branch))

(defun transfer? (ins)
  (typep ins 'transfer))

(defun phi? (ins)
  (typep ins 'join))

(defun not-phi? (ins)
  (not (typep ins 'join)))

(defun block-terminator? (ins)
  (typep ins 'block-terminator))

(defun new-constant (value type)
  (make-instance type :value (coerce-constant-to-lisp-value value type)))

(defun new-temporary (name type)
  (let ((temp (make-instance type :name name)))
    (setf (ftemp-base temp) temp)))

(defun new-instruction (type &optional defs uses)
  (let ((ins (make-instance type)))
    (iter (for def in defs)
	  (list-append def (ins-defs ins)))
    (iter (for use in uses)
	  (list-append use (ins-uses ins)))
    ins))

(defun new-phi (temp)
  (new-instruction 'ins-phi (list temp)))

(defun new-copy (source dest)
  (new-instruction 'ins-cp (list dest) (list source)))

(defun new-undef (temp)
  (new-instruction 'ins-undef (list temp)))

(defun new-basic-block (label)
  (make-instance 'basic-block :label label))

(defun instruction-has-def? (ins)
  (not (list-empty? (ins-defs ins))))

(defun instruction-def (ins)
  (list-head (ins-defs ins)))

(defun block-leader (block)
  (list-head (bb-insns block)))

(defun block-terminator (block)
  (list-tail (bb-insns block)))

(defun source-of-copy (cp)
  (seq-first (ins-uses cp)))

(defun dest-of-copy (cp)
  (instruction-def cp))

(defun lookup-name (name proc)
  (iter (for temp in-univ (proc-names proc))
	(when (eql name (temp-name temp))
	  (leave temp))))

(defun add-instruction-def (def ins)
  (list-append def (ins-defs ins)))

(defun add-instruction-use (use ins)
  (list-append use (ins-uses ins)))

(defun add-branch-target (target ins)
  (vector-push-extend target (br-targets ins)))

(defun add-branch-condition (condition ins)
  (setf (brc-condition ins) condition))

(defun add-call-function (func ins)
  (setf (call-func ins) func))

(defun move-fill-to-last-phi (block)
  (setf (bb-fill block) nil)
  (iter (for thing in-olist (bb-insns block) with-ref ref pred #'phi?)
	(setf (bb-fill block) ref)))

(defun insert-instruction-after-fill (ins block)
  (list-insert-after ins (bb-fill block) (bb-insns block))
  (setf (bb-fill block) (list-ref-next (bb-fill block))))

(defun prepend-block-instruction (ins block)
  (list-prepend ins (bb-insns block)))

(defun insert-instruction-before (ins after block)
  (list-insert-before ins (list-find after (bb-insns block)) (bb-insns block)))

(defun insert-instruction-after (ins before block)
  (list-insert-after ins (list-find before (bb-insns block)) (bb-insns block)))

(defun add-instruction (ins block)
  (list-append ins (bb-insns block)))

(defun rem-instruction (ins block)
  (list-delete (list-find ins (bb-insns block)) (bb-insns block)))

(defun add-block (block proc)
  (when (empty? (bb-preds block)) (setf (proc-entry proc) block))
  (when (empty? (bb-succs block)) (setf (proc-exit proc) block))
  (add-to-universe block (proc-bbs proc)))

(defun link-pred-succ (pred succ)
  (vector-push-unique pred (bb-preds succ))
  (vector-push-unique succ (bb-succs pred)))

(defun unlink-pred-succ (pred succ)
  (setf (bb-preds succ) (delete pred (bb-preds succ)))
  (setf (bb-succs pred) (delete succ (bb-succs pred))))

(defun join-point? (bb)
  (> (length (bb-preds bb)) 1))

(defun split-point? (bb)
  (> (length (bb-succs bb)) 1))

(defun critical-edge? (pred succ)
  (and (split-point? pred) (join-point? succ)))

(defun depth-first-search (pre post node next-func 
			   &optional (seen (make-hash-table)))
  (setf (gethash node seen) t)
  (when pre (funcall pre node))
  (iter (for next in-vector (funcall next-func node))
	(unless (gethash next seen)
	  (depth-first-search pre post next next-func seen)))
  (when post (funcall post node)))

(defun linearize-rpo (table)
  (sort (table-keys-to-vector table)
	#'(lambda (lhs rhs) (> (gethash lhs table) (gethash rhs table)))))

(defun compute-cfg-rpo (proc way)
  (let ((next-func (if (eql way :forward) #'bb-succs #'bb-preds))
	(start-bb (if (eql way :forward) (proc-entry proc) (proc-exit proc)))
	(index-table (make-hash-table))
	(counter 0))
    (depth-first-search nil #'(lambda (node)
				(setf (gethash node index-table) 
				      (incf counter))) start-bb next-func)
    (linearize-rpo index-table)))

(defun analyze-cfg-rpo (proc)
  (setf (proc-frpo proc) (compute-cfg-rpo proc :forward))
  (setf (proc-brpo proc) (compute-cfg-rpo proc :backward)))

(defun number-dom-tree-preorder (proc)
  (ensure-analyses-valid '(:idom) proc)
  (let ((preonum -1))
    (depth-first-search #'(lambda (bb)
			    (setf (fblock-preonum bb) (incf preonum)))
			#'(lambda (bb)
			    (setf (fblock-maxpreonum bb)
				  (or (slice-apply #'max
					       (fblock-domchld bb)
					       #'fblock-maxpreonum)
				      (fblock-preonum bb))))
			(proc-entry proc)
			#'fblock-domchld)))

(defun map-over-instructions (func proc &optional kind) 
  (iter (for bb in-univ (proc-bbs proc))
	(if kind
	    (iter (for ins in-olist (bb-insns bb) 
		       pred #'(lambda (thing) (typep thing kind)))
		  (funcall func ins))
	    (iter (for ins in-olist (bb-insns bb))
		  (funcall func ins)))))

(defun worklist-from-instructions (proc &optional kind)
  (let ((wlist (new-worklist)))
    (map-over-instructions #'(lambda (ins)
			       (queue-work ins wlist))
			   proc kind)))

(register-demand-analysis #'analyze-cfg-rpo '() '(:rpo))
