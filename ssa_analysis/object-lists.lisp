; object-lists.lisp
; Doubly-linked lists of objects

(in-package "VITAMIN")

(defstruct object-list
  head
  tail)

(defstruct list-node
  prev
  next
  data)

(defun new-object-list ()
  (make-object-list))

(defun list-insert-before (thing iter list)
  (let ((node (make-list-node :data thing
			      :next iter
			      :prev (list-node-prev iter))))
    (if (list-node-prev iter)
	(setf (list-node-next (list-node-prev iter)) node)
	(setf (object-list-head list) node))
    (setf (list-node-prev iter) node)))

(defun list-insert-after (thing iter list)
  (let ((node (make-list-node :data thing
			      :next (list-node-next iter)
			      :prev iter)))
    (if (list-node-next iter)
	(setf (list-node-prev (list-node-next iter)) node)
	(setf (object-list-tail list) node))
    (setf (list-node-next iter) node)))

(defun list-insert-only-element (thing list)
  (let ((node (make-list-node :data thing)))
    (setf (object-list-head list) node)
    (setf (object-list-tail list) node)))

(defun list-prepend (thing list)
  (if (object-list-head list)
      (list-insert-before thing (object-list-head list) list)
      (list-insert-only-element thing list)))

(defun list-append (thing list)
  (if (object-list-tail list)
      (list-insert-after thing (object-list-tail list) list)
      (list-insert-only-element thing list))) 

(defun list-delete (iter list)
  (if (list-node-prev iter)
      (setf (list-node-next (list-node-prev iter)) (list-node-next iter))
      (setf (object-list-head list) (list-node-next iter)))
  (if (list-node-next iter)
      (setf (list-node-prev (list-node-next iter)) (list-node-prev iter))
      (setf (object-list-tail list) (list-node-prev iter))))

(defun list-empty? (list)
  (not (object-list-head list)))

(defun list-head (list)
  (list-node-data (object-list-head list)))

(defun list-tail (list)
  (list-node-data (object-list-tail list)))

(defun list-head-ref (list)
  (object-list-head list))

(defun list-tail-ref (list)
  (object-list-tail list))

(defun list-ref-next (ref)
  (list-node-next ref))

(defun list-ref-prev (ref)
  (list-node-prev ref))

(defun list-ref-item (ref)
  (list-node-data ref))

(defun list-ref-replace (ref new-data)
  (setf (list-node-data ref) new-data))

(defmacro-driver (FOR var IN-OLIST list &optional PRED pred WITH-REF ref
		      WAY way)
  (let ((value (gensym))
	(next-ref (gensym))
	(ref (or ref (gensym)))
	(start (if (eql way 'backward) 'object-list-tail 'object-list-head))
	(next (if (eql way 'backward) 'list-node-prev 'list-node-next))
	(key (if generate 'generate 'for)))
    `(progn
       (with ,ref = nil)
       (with ,next-ref = (,start ,list))
       (,key ,var next (progn
			 (when (eq ,next-ref nil) (terminate))
			 (let ((,value (list-node-data ,next-ref)))
			   (setf ,ref ,next-ref)
			   (setf ,next-ref (,next ,next-ref))
			   ,(if pred
				`(unless (funcall ,pred ,value) 
				   (next-iteration))
				`(progn))
			   ,value))))))

; why oh why do I have to do this
(defun list-find (thing list &optional pred)
  (let ((pred (or pred #'(lambda (thing1 thing2) (eql thing1 thing2)))))
    (iter (for maybe-thing in-olist list with-ref ref)
	  (when (funcall pred thing maybe-thing)
	    (leave ref)))))

(defun list-position (thing list)
  (let ((count 0))
    (iter (for maybe-thing in-olist list)
	  (when (eq thing maybe-thing) (leave count))
	  (incf count))))

(defun list-nth (idx list)
  (let ((count idx))
    (iter (for maybe-thing in-olist list)
	  (when (eql count 0) (leave maybe-thing))
	  (decf count))))

(defun test-object-list ()
  (let ((list (new-object-list)))
    (iter (for i from 1 to 10)
	  (if (oddp i)
	      (list-append i list)
	      (list-prepend i list)))
    (iter (for thing in-olist list with-ref ref)
	  (format t "~A : ~A~%" thing (list-node-data ref))
	  (when (evenp thing)
	    (list-delete ref list)))
    (iter (for thing in-olist list with-ref ref way backward)
	  (format t "~A : ~A~%" thing (list-node-data ref)))
    (format t "~A~%" (list-position 5 list))
    (format t "~A~%" (list-nth 2 list))))

(defmethod listify-thing ((thing object-list) &optional short)
  (iter (for item in-olist thing)
	(collect (listify-thing item short))))
