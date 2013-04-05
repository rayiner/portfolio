; sparse-sets.lisp
; Sparse set implementation based on Cooper & Torczon

(in-package "VITAMIN")

(defstruct sparse-set
  sparse
  dense
  members
  universe)

(defun new-sparse-set (universe &optional fill-all)
  (let ((set (make-sparse-set :sparse (make-array (universe-size universe)
						  :element-type 'fixnum)
			      :dense (make-array (universe-size universe)
						 :element-type 'fixnum)
			      :members 0
			      :universe universe)))
    (when fill-all
      (iter (for thing in-univ universe)
	    (ss-add thing set)))
    set))

(defun clone-sparse-set (set)
  (with-slots (sparse dense members universe) set
    (make-sparse-set :sparse (make-array (length sparse)
					 :element-type 'fixnum
					 :initial-contents sparse)
		     :dense (make-array (length dense)
					:element-type 'fixnum
					:initial-contents dense)
		     :members members
		     :universe universe)))

(defun sync-sparse-set (set)
  (let ((size (universe-size (sparse-set-universe set))))
    (when (not (eql size (length (sparse-set-sparse set))))
      (setf (sparse-set-sparse set)
	    (adjust-array (sparse-set-sparse set) size
			  :element-type 'fixnum))
      (setf (sparse-set-dense set)
	    (adjust-array (sparse-set-dense set) size
			  :element-type 'fixnum)))))

(defun ss-member? (thing set)
  (sync-sparse-set set)
  (with-slots (sparse dense members universe) set
    (let ((a (aref sparse (universe-member-index thing universe))))
      (and (< a members)
	   (= (aref dense a)
	      (universe-member-index thing universe))))))

(defun ss-add (thing set)
  (sync-sparse-set set)
  (unless (ss-member? thing set)
    (with-slots (sparse dense members universe) set
      (let ((k (universe-member-index thing universe)))
	(setf (aref sparse k) members)
	(setf (aref dense members) k)
	(incf members)))))

(defun ss-rem (thing set)
  (sync-sparse-set set)
  (when (ss-member? thing set)
    (with-slots (sparse dense members universe) set
      (let* ((a (aref sparse (universe-member-index thing universe)))
	     (e (aref dense (decf members))))
	(setf (aref dense a) e)
	(setf (aref sparse e) a)))))

(defun ss-rem-all (set)
  (sync-sparse-set set)
  (setf (sparse-set-members set) 0))

(defun ss-ior (set1 set2 &optional overwrite?)
  (sync-sparse-set set1)
  (sync-sparse-set set2)
  (let ((result (if overwrite? set1 (clone-sparse-set set1))))
    (iter (for i from 0 below (sparse-set-members set2))
	  (ss-add (aref (sparse-set-dense set2) i) result))
    result))

(defun ss-and (set1 set2 &optional overwrite?)
  (sync-sparse-set set1)
  (sync-sparse-set set2)
  (let ((result (if overwrite? set1 (clone-sparse-set set1))))
    (iter (for i from 0 below (sparse-set-members result))
	  (let ((thing (aref (sparse-set-dense result) i)))
	    (unless (ss-member? thing set2)
	      (ss-rem thing result))))
    result))

(defun ss-ior* (sets universe)
  (let ((result (new-sparse-set universe)))
    (iter (for set in sets)
	  (sync-sparse-set set)
	  (ss-ior result set t))
    result))

; Small amount of sneakiness here with the parameter to new-object set.
; Normally, starting with a set containg every element in the universe
; gives correct results as we accumulate with bit-and. However, if sets
; is nil, we want to return the empty set. Hence, we pass the value of
; sets as the fill parameter for new-object-set.
(defun ss-and* (sets universe)
  (let ((result (new-sparse-set universe sets)))
    (iter (for set in sets)
	  (sync-sparse-set set)
	  (ss-and result set t))
    result))

(defun ss-empty? (set)
  (zerop (sparse-set-members set)))

(defun ss-count (set)
  (sparse-set-members set))

(defmacro-driver (FOR var IN-SSET set)
  (let ((vec (gensym))
	(end (gensym))
	(index (gensym))
	(univ (gensym))
	(value (gensym))
	(key (if generate 'generate 'for)))
    `(progn
       (with ,univ = (sparse-set-universe ,set))
       (with ,vec = (universe-members ,univ))
       (with ,end = (length (sparse-set-sparse ,set)))
       (with ,index = -1)
       (,key ,var next (progn (incf ,index)
			      (when (>= ,index ,end) (terminate))
			      (let ((,value (aref ,vec ,index)))
				(unless (ss-member? ,value ,set)
				  (next-iteration))
				,value))))))

(defmethod listify-thing ((thing sparse-set) &optional short)
  (declare (ignore short))
  (iter (for item in-sset thing)
	(collect (listify-thing item t))))
