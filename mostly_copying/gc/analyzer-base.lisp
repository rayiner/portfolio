; analyzer-base.lisp
; The core of the GC log analyzer

(in-package "GC-LOG-ANALYZER")

(defparameter *heap-base* nil)
(defparameter *heap-size* nil)
(defparameter *page-size* nil)
(defparameter *generations* nil)
(defparameter *obj-counter* -1)

(defun new-object-id () (incf *obj-counter*))

(defun lookup-event-info (name log)
  (cdr (find name log :key #'car)))

(defun lookup-info-value (key info)
  (elt info (+ 1 (position key info))))

(defgeneric do-dispatch-gc-event (key info page-table obj-table))

(defmethod do-dispatch-gc-event (key info page-table obj-table))

(defmethod do-dispatch-gc-event ((key (eql :start-gc))
				 info
				 page-table
				 obj-table)
  (format t "Starting GC up to ~A~%" (lookup-info-value :max-gen info)))

(defmethod do-dispatch-gc-event ((key (eql :finish-gc))
				 info
				 page-table
				 obj-table)
  (format t "Finished GC~%"))

(defmethod do-dispatch-gc-event ((key (eql :generation-stats))
				 info
				 page-table
				 obj-table)
  (let ((gen (lookup-info-value :gen info))
	(live-size (lookup-info-value :live-size info)))
    (format t "Generation ~A has ~A bytes live~%" gen live-size)))

(defmethod do-dispatch-gc-event ((key (eql :allocate-object))
				 info
				 page-table
				 obj-table)
  (let ((obj-ptr (lookup-info-value :obj info))
	(obj-id (new-object-id)))
    (setf (gethash obj-ptr obj-table) obj-id)))

(defmethod do-dispatch-gc-event ((key (eql :relocate-pointer))
				 info
				 page-table
				 obj-table)
  (let* ((obj-ptrs (lookup-info-value :obj info))
	 (old-ptr (first obj-ptrs))
	 (new-ptr (second obj-ptrs)))
    (unless (gethash old-ptr obj-table) 
      (format t "Relocating invalid object~%"))
    (setf (gethash new-ptr obj-table) (gethash old-ptr obj-table))
    (unless (eql old-ptr new-ptr) (remhash old-ptr obj-table))))

(defmethod do-dispatch-gc-event ((key (eql :copy-object))
				 info
				 page-table
				 obj-table)
  (let ((obj-ptr (lookup-info-value :obj info))
	(obj-size (lookup-info-value :size info)))
    (unless (gethash obj-ptr obj-table) (format t "Copying invalid object ~%"))
    (format t "Copying object ~A of size ~A~%" 
	    (gethash obj-ptr obj-table) obj-size)))

(defun dispatch-gc-event (event page-table obj-table)
  (do-dispatch-gc-event (car event) (cdr event) page-table obj-table))

(defun analyze-gc-events (log)
  (let* ((heap-info (lookup-event-info :create-heap log))
	 (*heap-base* (lookup-info-value :mem heap-info))
	 (*heap-size* (lookup-info-value :size heap-info))
	 (*page-size* (lookup-info-value :page-size heap-info))
	 (*generations* (lookup-info-value :generations heap-info))
	 (page-table (make-array (/ *heap-size* *page-size*)))
	 (obj-table (make-hash-table)))
    (iter (for event in log)
	  (dispatch-gc-event event page-table obj-table))))

(defun analyze-gc-log (log-file)
  (with-open-file (file log-file :direction :input)
    (read file)))



