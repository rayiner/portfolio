; conversion.lisp
; Contains routines to convert the intermediate representation
; to and from various other forms (source form, Graphviz diagrams)

(in-package "VITAMIN")

(defun lookup-name-in-table (name name-table)
  (let ((ref (gethash name name-table)))
    (assert-user ref name "reference to unknown name")
    ref))

(defun add-names-as-uses (operands ins name-table)
  (iter (for operand in operands)
	(add-instruction-use (lookup-name-in-table operand name-table) ins)))

(defun add-name-as-def (operand ins name-table)
  (add-instruction-def (lookup-name-in-table operand name-table) ins))

(defun add-labels-as-targets (label-list ins)
  (iter (for label in label-list)
	(add-branch-target label ins)))

(defgeneric convert-instruction (ins line name-table))

(defmethod convert-instruction ((ins instruction) line name-table)
  (when (assignment-form? line)
    (add-name-as-def (extract-result line) ins name-table))
  (add-names-as-uses (extract-operands line) ins name-table))

(defmethod convert-instruction ((ins ins-ldi) line name-table)
  (add-name-as-def (extract-result line) ins name-table)
  (let ((ctype (constant-type-for-temporary-type 
		(type-of (instruction-def ins)))))
    (iter (for operand in (extract-operands line))
	  (add-instruction-use (new-constant operand ctype) ins))))

(defmethod convert-instruction ((ins ins-br) line name-table)
  (add-branch-target (extract-br-label line) ins))

(defmethod convert-instruction ((ins ins-bri) line name-table)
  (add-names-as-uses (list (extract-bri-temporary line)) ins name-table)
  (add-labels-as-targets (extract-bri-labels line) ins))

(defmethod convert-instruction ((ins ins-brc) line name-table)
  (add-branch-condition (extract-brc-condition line) ins)
  (add-names-as-uses (extract-brc-operands line) ins name-table)
  (add-labels-as-targets (extract-brc-labels line) ins))

(defmethod convert-instruction ((ins ins-brt) line name-table)
  (add-branch-condition (extract-brt-condition line) ins)
  (add-names-as-uses (extract-brt-operands line) ins name-table)
  (add-labels-as-targets (extract-brt-labels line) ins))

(defmethod convert-instruction ((ins ins-call) line name-table)
  (add-name-as-def (extract-result line) ins name-table)
  (add-names-as-uses (extract-call-operands line) ins name-table)
  (add-call-function (extract-call-label line) ins))

(defun construct-value-for-designator (name key)
  (make-instance (type-for-designator key) :name name))

(defun construct-name-table (source)
  (let ((name-table (make-hash-table)))
    (iter (for entry in (extract-name-table source))
	  (let* ((name (extract-entry-name entry))
		 (desig (extract-entry-type entry))
		 (type (type-for-designator desig)))
	    (assert-user type entry "unknown type")
	    (setf (gethash name name-table) 
		  (new-temporary name type))))
    name-table))

(defun convert-source-form (line name-table)
  (let* ((mnem (extract-operation line))
	 (class (class-for-mnemonic mnem))
	 (ins (make-instance class)))
    (assert-user class line "unknown instruction")
    (convert-instruction ins line name-table)
    (assert-user (typecheck-instruction ins) line "typecheck failed")
    ins))

(defun construct-source-block-table (source name-table)
  (let ((block-table (make-hash-table))
	(cur-block))
    (iter (for line in (extract-body source))
	  (if (label? line)
	      (progn
		(assert-user (null cur-block) line "label inside block")
		(setf cur-block (new-basic-block line))
		(setf (gethash line block-table) cur-block))
	      (let ((ins (convert-source-form line name-table)))
		(assert-user cur-block line "instruction outside block")
		(add-instruction ins cur-block)
		(when (block-terminator? ins) (setf cur-block nil)))))
    (assert-user (null cur-block) nil "premature end of body")
    block-table))

(defun convert-procedure (name-table block-table)
  (let ((proc (new-procedure name-table)))
    (iter (for (label block) in-hashtable block-table)
	  (let ((term (block-terminator block)))
	    (when (branch? term)
	      (iter (for target in-vector (br-targets term))
		    (link-pred-succ block (gethash target block-table)))))
	  (add-block block proc))
    proc))

(defun convert-source (source)
  (handler-case 
      (let* ((name-table (construct-name-table source))
	     (block-table (construct-source-block-table source name-table)))
	(convert-procedure name-table block-table))
    (user-error (err) (format t "~A ~A~%" 
			      (generator-error-message err)
			      (user-error-form err)))))

(defgeneric unconvert-instruction (ins))

(defun unconvert-value (value)
  (typecase value
    (temporary (temp-name value))
    (constant (const-value value))))

(defun unconvert-values (values)
  (iter (for value in-olist values)
	(collect (unconvert-value value))))

(defun unconvert-assignment-form (ins)
  (list (unconvert-value (instruction-def ins))
	(cons (ins-mnem ins) (unconvert-values (ins-uses ins)))))

(defun unconvert-statement-form (ins)
  (cons (ins-mnem ins) (unconvert-values (ins-uses ins))))

(defmethod unconvert-instruction ((ins instruction))
  (if (instruction-has-def? ins)
      (unconvert-assignment-form ins)
      (unconvert-statement-form ins)))

(defmethod unconvert-instruction ((ins ins-br))
  (append (list (ins-mnem ins)) (vector-to-list (br-targets ins))))

(defmethod unconvert-instruction ((ins conditional-branch))
  (append (list (ins-mnem ins)) (list (brc-condition ins))
	  (unconvert-values (ins-uses ins))
	  (vector-to-list (br-targets ins))))

(defmethod unconvert-instruction ((ins ins-bri))
  (append (list (ins-mnem ins))
	  (unconvert-values (ins-uses ins))
	  (vector-to-list (br-targets ins))))

(defmethod unconvert-instruction ((ins ins-call))
  (list (unconvert-value (instruction-def ins))
	(append (list (ins-mnem ins)) (list (call-func ins))
		(unconvert-values (ins-uses ins)))))

(defun unconvert-basic-block (bb)
  (cons (bb-label bb)
	(iter (for ins in-olist (bb-insns bb))
	      (collect (unconvert-instruction ins)))))

(defun unconvert-body (proc)
    (iter (for block in-univ (proc-bbs proc))
	  (appending (unconvert-basic-block block))))

(defun unconvert-name-table (name-table)
  (iter (for temp in-univ name-table)
	(collect (list (temp-name temp) (designator-for-type (type-of temp))))))

(defun unconvert-procedure (proc)
  (cons (unconvert-name-table (proc-names proc))
	(unconvert-body proc)))

(defun dotify-mnemonic (ins)
  (string-downcase (to-string (ins-mnem ins))))

(defun dotify-value (value)
  (typecase value
    (temporary (string-downcase (to-string (temp-name value))))
    (constant (string-downcase (to-string (const-value value))))))

(defun dotify-values (values)
  (stringify-list (iter (for value in-olist values)
			(collect value))))

(defun dotify-labels (label-list)
  (with-output-to-string (str)
    (iter (for label in-vector label-list)
	  (format str "~A " label))))

(defgeneric dotify-instruction (ins str))

(defmethod dotify-instruction ((ins instruction) str)
  (if (instruction-has-def? ins)
      (format str "~A = ~A ~A\\n" 
	      (dotify-value (instruction-def ins))
	      (dotify-mnemonic ins) 
	      (dotify-values (ins-uses ins)))
      (format str "~A ~A\\n" 
	      (dotify-mnemonic ins) 
	      (dotify-values (ins-uses ins)))))

(defmethod dotify-instruction ((ins ins-br) str))

(defmethod dotify-instruction ((ins ins-brc) str)
  (format str "~A ~A ~A : ~A\\n"
	  (dotify-value (list-nth 0 (ins-uses ins))) 
	  (brc-condition ins)
	  (dotify-value (list-nth 1 (ins-uses ins)))
	  (dotify-labels (br-targets ins))))

(defun prettify-brt-condition (con)
  (ecase con
    (:=h "half?")
    (:=p "ptr?")
    (:=s "flo?")
    (:!=h "!half?")
    (:!=p "!ptr?")
    (:!=s "!flo?")))

(defmethod dotify-instruction ((ins ins-brt) str)
  (format str "~A ~A : ~A\\n"
	  (prettify-brt-condition (brc-condition ins))
	  (dotify-value (list-nth 0 (ins-uses ins)))
	  (dotify-labels (br-targets ins))))

(defun dotify-instructions (block)
  (with-output-to-string (str)
    (iter (for ins in-olist (bb-insns block))
	  (dotify-instruction ins str))))

(defun dotify-successor (succ block str)
  (format str "~A -> ~A;" (bb-label block) (bb-label succ)))

(defun dotify-successors (block succ-func)
  (with-output-to-string (str)
    (iter (for succ in-vector (funcall succ-func block))
	  (dotify-successor succ block str)
	  (format str "~%"))))

(defun dotify-block (block str succ-func)
  (format str "~A [shape=box,fontsize=10,label=\"~A\\n~A\"];~%~A"
	  (bb-label block)
	  (bb-label block)
	  (dotify-instructions block)
	  (dotify-successors block succ-func)))

(defun dotify-blocks (bbs succ-func)
  (with-output-to-string (str)
    (iter (for block in-univ bbs)
	  (dotify-block block str succ-func))))

(defun dotify-cfg (proc &optional (mode :forward-cfg))
  (when (eql mode :dom-tree) (ensure-analyses-valid '(:idom) proc))
  (let ((succ-func (ecase mode
		     (:forward-cfg #'bb-succs)
		     (:backward-cfg #'bb-preds)
		     (:dom-tree #'fblock-domchld))))
    (format nil "digraph CFG {~%~A }" 
	    (dotify-blocks (proc-bbs proc) succ-func))))
