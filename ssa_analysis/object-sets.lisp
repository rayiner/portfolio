; object-sets.lisp
; Implementation of sets of objects based on bit-vectors

(in-package "VITAMIN")

(declaim (inline bit-set? set-bit clear-bit set-member? set-add set-rem
		 set-ior set-and set-not set-ior* set-and*))

(defun new-bit-vector (num &optional fill-all)
  (declare (fixnum num))
  (let ((fill (if fill-all 1 0)))
    (make-array num :element-type 'bit :initial-element fill)))

(defun bit-set? (mat idx)
  (declare (simple-bit-vector mat))
  (eql (bit mat idx) 1))

(defun set-bit (mat idx)
  (declare (simple-bit-vector mat))
  (setf (bit mat idx) 1))

(defun clear-bit (mat idx)
  (declare (simple-bit-vector mat))
  (setf (bit mat idx) 0))

(defun set-all-bits (mat)
  (declare (simple-bit-vector mat))
  (bit-eqv mat mat t))

(defun clear-all-bits (mat)
  (declare (simple-bit-vector mat))
  (bit-xor mat mat t))

(defstruct object-set
  vector
  universe)

(defun new-object-set (univ &optional fill)
  (make-object-set :vector (new-bit-vector (universe-size univ) fill)
		   :universe univ))

(defun clone-object-set (set)
  (with-slots (vector universe) set
    (declare (simple-bit-vector vector))
    (make-object-set :vector (make-array (length vector)
					 :element-type 'bit
					 :initial-contents vector)
		     :universe universe)))

(defun sync-object-set (set)
  (let ((size (universe-size (object-set-universe set))))
    (setf (object-set-vector set)
	  (adjust-array (object-set-vector set) size :initial-element 0))))

(defun set-member? (thing set)
  (sync-object-set set)
  (with-slots (vector universe) set
    (bit-set? vector (universe-member-index thing universe))))

(defun set-add (thing set)
  (sync-object-set set)
  (with-slots (vector universe) set
    (set-bit vector (universe-member-index thing universe))
    set))

(defun set-rem (thing set)
  (sync-object-set set)
  (with-slots (vector universe) set
    (clear-bit vector (universe-member-index thing universe))
    set))

(defun set-add-all (set)
  (sync-object-set set)
  (with-slots (vector) set
    (set-all-bits vector)
    set))

(defun set-rem-all (set)
  (sync-object-set set)
  (with-slots (vector) set
    (clear-all-bits vector)
    set))

(defun set-from-element (element model)
  (sync-object-set model)
  (with-slots (universe) model
    (set-add element (new-object-set universe))))

(defun set-without-element (set element)
  (sync-object-set set)
  (set-rem element (clone-object-set set)))

(defun set-ior (set1 set2 &optional overwrite?)
  (sync-object-set set1)
  (sync-object-set set2)
  (make-object-set :vector (bit-ior (object-set-vector set1)
				    (object-set-vector set2) overwrite?)
		   :universe (object-set-universe set1)))

(defun set-and (set1 set2 &optional overwrite?)
  (sync-object-set set1)
  (sync-object-set set2)
  (make-object-set :vector (bit-and (object-set-vector set1)
				    (object-set-vector set2) overwrite?)
		   :universe (object-set-universe set1)))

(defun set-not (set1 &optional overwrite?)
  (sync-object-set set1)
  (make-object-set :vector (bit-not (object-set-vector set1) overwrite?)
		   :universe (object-set-universe set1)))

(defun set-ior* (sets universe)
  (let ((result (new-object-set universe)))
    (iter (for set in sets)
	  (sync-object-set set)
	  (set-ior result set t))
    result))

; Small amount of sneakiness here with the parameter to new-object set.
; Normally, starting with a set containing every element in the universe
; gives correct results as we accumulate with bit-and. However, if sets
; is nil, we want to return the empty set. Hence, we pass the value of
; sets as the fill parameter for new-object-set.
(defun set-and* (sets universe)
  (let ((result (new-object-set universe sets)))
    (iter (for set in sets)
	  (sync-object-set set)
	  (set-and result set t))
    result))

(defun set-equal? (set1 set2)
  (sync-object-set set1)
  (sync-object-set set2)
  (equal (object-set-vector set1)
	 (object-set-vector set2)))

(defun set-empty? (set)
  (every #'zerop (object-set-vector set)))

(defmacro-driver (FOR var IN-OSET set)
  (let ((vec (gensym))
	(end (gensym))
	(index (gensym))
	(univ (gensym))
	(value (gensym))
	(key (if generate 'generate 'for)))
    `(progn
       (with ,univ = (object-set-universe ,set))
       (with ,vec = (universe-members ,univ))
       (with ,end = (length (object-set-vector ,set)))       (with ,index = -1)
       (,key ,var next (progn (incf ,index)
			      (when (>= ,index ,end) (terminate))
			      (let ((,value (aref ,vec ,index)))
				(unless (set-member? ,value ,set)
				  (next-iteration))
				,value))))))

(defmethod listify-thing ((thing object-set) &optional short)
  (declare (ignore short))
  (iter (for item in-oset thing)
	(collect (listify-thing item t))))
