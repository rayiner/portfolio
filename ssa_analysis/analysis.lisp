; analysis.lisp
; Contains common code used by the various analysis routines

(in-package "VITAMIN")

(defvar *demand-analyses* (make-hash-table))

(defclass analysis ()
  ((requires :initarg :requires :reader analysis-requires)
   (provides :initarg :provides :reader analysis-provides)
   (function :initarg :function :reader analysis-function)))

(defun register-demand-analysis (function requires provides)
  (note 'repr-dep "Registered analysis ~A" function)
  (let ((analysis (make-instance 'analysis 
				 :function function
				 :requires requires 
				 :provides provides)))
    (iter (for prov in provides)
	  (setf (gethash prov *demand-analyses*) analysis))))

; We can't be too clever here, as we need *fast* access to these.
(defclass flow-basic-block ()
  ((changed? :accessor fblock-changed? :initform nil)
   (livein :accessor fblock-livein)
   (liveout :accessor fblock-liveout)
   (uevar :accessor fblock-uevar)
   (uevarp :accessor fblock-uevarp)
   (varkill :accessor fblock-varkill)
   (dom :accessor fblock-dom)
   (idom :accessor fblock-idom)
   (domchld :accessor fblock-domchld)
   (df :accessor fblock-df)
   (preonum :accessor fblock-preonum)
   (maxpreonum :accessor fblock-maxpreonum)))

(defclass flow-value () ())

(defclass flow-temporary ()
  ((defin :accessor ftemp-defin)
   (base :initarg :base :accessor ftemp-base)
   (rencount :accessor ftemp-rencount)
   (renstack :accessor ftemp-renstack)))

(defclass flow-constant () ())

(defclass flow-procedure ()
  ((gnames :accessor fproc-gnames)
   (intg :accessor fproc-intg)
   (pccs :accessor fproc-pccs)))

(defmethod listify-thing ((thing analysis) &optional short)
  (declare (ignore short))
  (list (analysis-function thing) 
	(analysis-requires thing) 
	(analysis-provides thing)))

(defun listify-flow-analyses (sets thing)
  (iter (for slot in sets)
	(when (and (slot-exists-p thing slot) (slot-boundp thing slot))
	  (collect (list slot (listify-thing (slot-value thing slot) t))))))

(defun listify-procedure-analyses (sets proc)
  (list :blocks
	(iter (for bb in-univ (proc-bbs proc))
	      (let ((res (listify-flow-analyses sets bb)))
		(when res (collect (list (bb-label bb) res)))))
	:temporaries
	(iter (for temp in-univ (proc-names proc))
	      (let ((res (listify-flow-analyses sets temp)))
		(when res (collect (list (temp-name temp) res)))))
	:procedure
	(listify-flow-analyses sets proc)))
