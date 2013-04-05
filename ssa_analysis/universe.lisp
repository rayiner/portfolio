; universe.lisp
; Universes of enumerable objects

(in-package "VITAMIN")

(defclass universe ()
  ((members :initarg :members :accessor universe-members
	    :initform (new-stretchy-vector))
   (index :accessor universe-index :initform (make-hash-table))
   (rindex :accessor universe-rindex :initform (make-hash-table))
   (counter :accessor universe-counter :initform -1)))

(defun new-universe ()
  (make-instance 'universe))

(defun add-to-universe (member univ)
  (unless (gethash member (universe-index univ))
    (setf (gethash member (universe-index univ))
	  (incf (universe-counter univ)))
    (setf (gethash (universe-counter univ)
		   (universe-rindex univ)) member)
    (vector-push-extend member (universe-members univ))))

(defun rem-from-universe (member univ)
  (remhash (gethash member (universe-index univ))
	   (universe-rindex univ))
  (remhash member (universe-index univ))
  (delete member (universe-members univ)))

(defun universe-size (univ)
  (length (universe-members univ)))

(defun universe-member-index (member universe)
  (gethash member (universe-index universe)))

(defmacro-driver (FOR var IN-UNIV univ &optional KIND kind)
    (let ((vec (gensym))
	  (end (gensym))
	  (index (gensym))
	  (value (gensym))
	  (key (if generate 'generate 'for)))
      `(progn
	 (with ,vec = (universe-members ,univ))
	 (with ,end = (length ,vec))
	 (with ,index = -1)
	 (,key ,var next (progn (incf ,index)
				(when (>= ,index ,end) (terminate))
				(let ((,value (aref ,vec ,index)))
				  ,(if kind
				       `(unless (typep ,value ,kind)
					  (next-iteration))
				       `(progn))
				  ,value))))))

(defmethod listify-thing ((thing universe) &optional short)
  (declare (ignore short))
  (iter (for item in-univ thing)
	(collect (listify-thing item t))))
