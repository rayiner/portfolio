; representation.lisp
; Defines the intermediate representation and contains utility routines
; for operating on the intermediate form

(in-package "VITAMIN")

(defparameter *branch-conditions* '(:< :<= := :!= :>= :>
				    :=h :=p :=s :!=h :!=p :!=s))

(defclass value (flow-value) ())

(defclass temporary (value flow-temporary machine-temporary)
  ((name :initarg :name :accessor temp-name)))

(defclass constant (value flow-constant)
  ((value :initarg :value :accessor const-value)))

(defstruct reference
  ins
  idx)

(defmethod listify-thing ((thing temporary) &optional short)
  (declare (ignore short))
  (temp-name thing))

(defmethod listify-thing ((thing constant) &optional short)
  (declare (ignore short))
  (const-value thing))

(defclass pointer-temporary (temporary pointer) ())
(defclass half-temporary (temporary half) ())
(defclass word-temporary (temporary word) ())
(defclass single-temporary (temporary single) ())
(defclass double-temporary (temporary double) ())
(defclass generic-temporary (temporary generic) ())

(defclass pointer-constant (constant pointer) ())
(defclass half-constant (constant half) ())
(defclass word-constant (constant word) ())
(defclass single-constant (constant single) ())
(defclass double-constant (constant double) ())
(defclass generic-constant (constant generic) ())

(defgeneric clone-temporary (temp &rest keys))

(defmacro define-temp-cloner (type)
  `(defmethod clone-temporary ((temp ,type) &rest keys)
     (apply #'make-instance ',type keys)))

(define-temp-cloner pointer-temporary)
(define-temp-cloner half-temporary)
(define-temp-cloner word-temporary)
(define-temp-cloner single-temporary)
(define-temp-cloner double-temporary)
(define-temp-cloner generic-temporary)

(defclass instruction (machine-instruction)
  ((mnem :initarg :mnem :reader ins-mnem)
   (defs :initarg :defs :accessor ins-defs :initform (new-object-list))
   (uses :initarg :uses :accessor ins-uses :initform (new-object-list))
   (form :initform nil :reader ins-form)))

(defclass basic-block (flow-basic-block machine-basic-block)
  ((label :initarg :label :reader bb-label)
   (fill :initarg :fill :accessor bb-fill)
   (insns :initarg :insns :accessor bb-insns :initform (new-object-list))
   (preds :initarg :preds :accessor bb-preds :initform (new-stretchy-vector))
   (succs :initarg :succs :accessor bb-succs :initform (new-stretchy-vector))))

(defclass procedure (flow-procedure machine-procedure)
  ((analyses :reader proc-analyses :initform (make-hash-table))
   (names :initarg :names :reader proc-names :initform (new-universe))
   (entry :initarg :entry :accessor proc-entry)
   (exit :initarg :exit :accessor proc-exit)
   (bbs :initarg :bbs :reader proc-bbs :initform (new-universe))
   (frpo :initarg :frpo :accessor proc-frpo :initform (new-stretchy-vector))
   (brpo :initarg :brpo :accessor proc-brpo :initform (new-stretchy-vector))))

(defclass initial-definition (instruction) ())

(defclass block-terminator (instruction) ())

(defclass branch (block-terminator)
  ((targets :initarg targets :reader br-targets 
	    :initform (new-stretchy-vector))))

(defclass join (instruction) ())

(defclass conditional-branch (branch)
  ((condition :initarg :condition :accessor brc-condition)))

(defclass indirect-branch (branch) ())

(defclass procedure-call (instruction) ())

(defclass direct-procedure-call (procedure-call)
  ((func :initarg func :accessor call-func)))

(defclass indirect-procedure-call (procedure-call) ())

(defclass procedure-exit (block-terminator) ())

(defclass arithmetic-operator (instruction) ())

(defclass conversion (instruction) ())

(defclass memory-operation (instruction) ())

(defclass memory-load (memory-operation) ())

(defclass memory-store (memory-operation) ())

(defclass constant-definition (instruction) ())

(defclass transfer (instruction) ())

(defclass address-calculation (instruction) ())

(defmethod listify-thing ((thing instruction) &optional short)
  (if short
      (ins-mnem thing)
      (unconvert-instruction thing)))

(defmethod listify-thing ((thing basic-block) &optional short)
  (if short
      (bb-label thing)
      (list :name (bb-label thing)
	    :preds (iter (for bb in-vector (bb-preds thing))
			 (collect (listify-thing bb t)))
	    :succs (iter (for bb in-vector (bb-succs thing))
			 (collect (listify-thing bb t)))
	    :insns (iter (for ins in-olist (bb-insns thing))
			 (collect (listify-thing ins t))))))

(defmethod listify-thing ((thing procedure) &optional short)
  (declare (ignore short))
  (list :bbs (listify-thing (proc-bbs thing))
	:names (listify-thing (proc-names thing))
	:analyses (iter (for (key val) in-hashtable (proc-analyses thing))
			(collect (listify-thing key)))))
