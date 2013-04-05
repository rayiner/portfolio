; ssa-conversion.lisp
; Implements a conversion of the IR into SSA form

(in-package "VITAMIN")

(defun analyze-global-names (proc)
  (setf (fproc-gnames proc)
	(set-ior* (iter (for bb in-univ (proc-bbs proc))
			(collect (fblock-uevar bb)))
		  (proc-names proc))))

(defun prepare-block-for-phi-insertion (bb)
  (setf (bb-fill bb) -1))

(defun maybe-insert-phi (temp block visited)
  (unless (or (hs-member? block visited)
	      (not (set-member? temp (fblock-livein block))))
    (insert-instruction-after-fill (new-phi temp) block)
    (hs-add block visited)
    t))

(defun insert-phi-operations (proc)
  (ensure-analyses-valid '(:gnames :defin :df :livein) proc)
  (iter (for bb in-univ (proc-bbs proc))
	(prepare-block-for-phi-insertion bb))
  (iter (for temp in-oset (fproc-gnames proc))
	(let ((wlist (worklist-from-oset (ftemp-defin temp)))
	      (visited (new-hash-set)))
	  (until-loop (worklist-empty? wlist)
	    (let ((bb (dequeue-work wlist)))
	      (iter (for dbb in-sset (fblock-df bb))
		    (when (maybe-insert-phi temp dbb visited)
		      (queue-work dbb wlist))))))))

(defun make-renamed-temporary (temp version proc)
  (let ((temp (clone-temporary temp
		   :name (suffixsym (temp-name temp)
				    (format nil ".~A" version))
		   :base (ftemp-base temp))))
    (add-to-universe temp (proc-names proc))
    temp))

; this depends on the fact that we're constructing pruned SSA
; on a program in strict form, since any phi-function that uses
; a value that has not yet been defined and placed on the stack
; must necessarily be killed by a later redefinition on any path
; leading to an actual use of that value
(defun prepare-temps-for-renaming (proc)
  (iter (for temp in-univ (proc-names proc))
	(setf (ftemp-rencount temp) -1)
	(setf (ftemp-renstack temp) nil)))

(defun rename-ins-operands (ins)
  (iter (for use in-olist (ins-uses ins) pred #'temporary? with-ref ref)
	(list-ref-replace ref (first (ftemp-renstack use)))))

(defun rename-ins-definition (ins proc)
  (let* ((base (ftemp-base (instruction-def ins))))
    (push (make-renamed-temporary base (incf (ftemp-rencount base)) proc)
	  (ftemp-renstack base))
    (list-ref-replace (list-head-ref (ins-defs ins))
		      (first (ftemp-renstack base)))))

; this depends on the fact that successors are organized "left to right"
; in the successor list, so extending the operand list of the phi operation
; at the end produces a consistent ordering when walking the CFG naturally
(defun rename-phi-uses-in-block (bb)
  (iter (for phi in-olist bb pred #'phi?)
	(let ((base-def (ftemp-base (instruction-def phi))))
	  (add-instruction-use (first (ftemp-renstack base-def)) phi))))

(defun rename-temps-in-block (proc bb)
  (iter (for ins in-olist bb pred #'phi?)
	(rename-ins-definition ins proc))
  (iter (for ins in-olist bb pred #'not-phi?)
	(rename-ins-operands ins)
	(when (instruction-has-def? ins)
	  (rename-ins-definition ins proc)))
  (iter (for succ in-vector (bb-succs bb))
	(rename-phi-uses-in-block succ))
  (iter (for chld in-vector (fblock-domchld bb))
	(rename-temps-in-block proc chld))
  (iter (for ins in-olist (bb-insns bb))
	(when (instruction-has-def? ins)
	  (pop (ftemp-renstack (ftemp-base (instruction-def ins)))))))

(defun rename-temporaries (proc)
  (ensure-analyses-valid '(:idom :defin :livein) proc)
  (prepare-temps-for-renaming proc)
  (rename-temps-in-block proc (proc-entry proc)))

(defun convert-to-ssa-form (proc)
  (insert-phi-operations proc)
  (rename-temporaries proc)
  (note-all-analyses-invalid proc))

(register-demand-analysis #'analyze-global-names '(:uevar) '(:gnames))
