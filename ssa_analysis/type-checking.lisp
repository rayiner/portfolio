; type-checking.lisp
; Contains the type-checker for the intermediate representation

(in-package "VITAMIN")

(defun elements-match-types? (elements types)
  (iter (for elt in-olist elements)
	(for type in types)
	(unless (typep elt type)
	  (return nil)))
  t)

(defun operands-match-pattern? (ins pattern)
  (cond
    ((statement-form? pattern)
     (elements-match-types? (ins-uses ins) pattern))
    ((assignment-form? pattern)
     (and (typep (instruction-def ins) (first pattern))
	  (elements-match-types? (ins-uses ins) (second pattern))))))

(defgeneric typecheck-instruction (ins))

(defmethod typecheck-instruction ((ins instruction))
  (iter (for pattern in (ins-form ins))
	(when (operands-match-pattern? ins pattern)
	  (leave t)))
  t)

(defmethod typecheck-instruction ((ins procedure-call)) t)
(defmethod typecheck-instruction ((ins procedure-exit)) t)
