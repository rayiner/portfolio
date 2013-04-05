; single-set.lisp
; Parallel arrays of sets with at most one element

(in-package "VITAMIN")

; A single set is an element of an infinitely wide height-2 semilattice.
; Top is represented by nil, and bottom is represented by t.
; The following table outlines the behavior of the join and meet operators.
; Meet    nil    n    m    t            Join    nil    n    m    t
; nil     nil    n    m    t            nil     nil    nil  nil  nil
; n       n      n    t    t            n       nil    n    nil  n
; m       m      t    m    t            m       nil    nil  m    m
; t       t      t    t    t            t       nil    n    m    t

(defstruct parallel-single-set
  universe
  entries)

(defun new-parallel-single-set (universe)
  (make-parallel-single-set :universe universe
			    :entries (make-array (universe-size universe)
						 :initial-element nil)))

(defun clone-parallel-single-set (set)
  (with-slots (universe entries) set
    (make-parallel-single-set :universe universe
			      :entries (make-array (length entries)
						   :initial-contents entries))))

(defun sync-parallel-single-set (set)
  (let ((size (universe-size (parallel-single-set-universe set))))
    (when (not (eql size (length (parallel-single-set-entries set))))
      (set (parallel-single-set-entries set)
	   (adjust-array (parallel-single-set-entries set) size
			 :initial-element nil)))))

(defun pss-add (thing key set)
  (with-slots (universe entries) set
    (setf (aref entries (universe-member-index key universe)) thing)))

(defun pss-rem (key set)
  (with-slots (universe entries) set
    (setf (aref entries (universe-member-index key universe)) nil)))

(defun pss-element-ior (one two)
  (cond
    ((or (null one) (null two)) nil)
    ((eql one t) two)
    ((eql two t) one)
    ((eql one two) one)
    (t nil)))

(defun pss-element-and (one two)
  (cond
    ((or (eql t one) (eql t two)) t)
    ((null one) two)
    ((null two) one)
    ((eql one two) one)
    (t t)))

(defun pss-element-or (one two)
  (cond
    ((null two) one)
    ((null one) two)
    (t one)))

(defun pss-map-over-entries (func set1 set2 &optional overwrite?)
  (let ((result (if overwrite? set1 (clone-parallel-single-set set1))))
    (with-slots ((rentries entries) (runiverse universe)) result
      (with-slots (entries universe) set2
	(iter (for rentry in-vector rentries with-index idx)
	      (for entry in-vector entries)
	      (setf (aref rentries idx)
		    (funcall func rentry entry)))))
    result))

(defun pss-ior (set1 set2 &optional overwrite?)
  (pss-map-over-entries #'pss-element-ior set1 set2 overwrite?))

(defun pss-and (set1 set2 &optional overwrite?)
  (pss-map-over-entries #'pss-element-and set1 set2 overwrite?))

(defun pss-or (set1 set2 &optional overwrite?)
  (pss-map-over-entries #'pss-element-or set1 set2 overwrite?))

(defun pss-reduce-sets (func sets universe)
  (cond 
    ((eql (length sets) 0) (new-parallel-single-set universe))
    ((eql (length sets) 1) (first sets))
    (t (let ((result (clone-parallel-single-set (first sets))))
	 (iter (for set in (rest sets))
	       (funcall func result set t))
	 result))))

(defun pss-ior* (sets universe)
  (pss-reduce-sets #'pss-ior sets universe))

(defun pss-and* (sets universe)
  (pss-reduce-sets #'pss-and sets universe))

(defun pss-equal? (set1 set2)
  (equalp (parallel-single-set-entries set1)
	  (parallel-single-set-entries set2)))

(defmethod listify-thing ((thing parallel-single-set) &optional short)
  (declare (ignore short))
  (iter (for item in-vector (parallel-single-set-entries thing))
	(collect (listify-thing item t))))
