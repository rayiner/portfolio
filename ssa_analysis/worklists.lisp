; worklists.lisp
; Implementation of work-list data structures

(in-package "VITAMIN")

(defclass worklist ()
  ((queue :accessor worklist-queue :initform nil)))

(defun new-worklist () (make-instance 'worklist))

(defun queue-work (thing wlist)
  (pushnew thing (worklist-queue wlist)))

(defun dequeue-work (wlist)
  (let ((thing (first (last (worklist-queue wlist)))))
    (setf (worklist-queue wlist) (butlast (worklist-queue wlist)))
    thing))

(defun worklist-empty? (wlist)
  (null (worklist-queue wlist)))

(defun worklist-from-oset (set)
  (let ((wlist (new-worklist)))
    (iter (for thing in-oset set)
	  (queue-work thing wlist))
    wlist))

(defun worklist-from-sset (set)
  (let ((wlist (new-worklist)))
    (iter (for thing in-sset set)
	  (queue-work thing wlist))
    wlist))

(defmacro-driver (FOR var IN-WLIST wlist)
  (let ((itr (gensym))
	(last (gensym))
	(key (if generate 'generate 'for)))
    `(progn
       (with ,itr = (worklist-queue ,wlist))
       (,key ,var next (progn (when (eql ,itr nil) (terminate))
			      (let ((,last (car ,itr)))
				(setf ,itr (cdr ,itr))
				,last))))))

(defmethod listify-thing ((thing worklist) &optional short)
  (declare (ignore short))
  (iter (for item in (worklist-queue thing))
	(collect (listify-thing item t))))
