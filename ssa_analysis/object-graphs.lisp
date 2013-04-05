; object-graphs.lip
; General graphs of objects

(in-package "VITAMIN")

(defstruct object-graph
  universe
  nodes
  matrix
  lists)

(defun new-object-graph (universe)
  (make-object-graph :matrix (make-array (list (universe-size universe)
					       (universe-size universe))
					 :element-type 'bit)
		     :lists (make-array (universe-size universe)
					:initial-element nil)
		     :nodes (new-object-set universe)
		     :universe universe))

(defun sync-object-graph (graph)
  (let ((size (universe-size (object-graph-universe graph))))
    (when (not (eql size 
		    (first (array-dimensions (object-graph-matrix graph)))))
      (setf (object-graph-matrix graph)
	    (adjust-array (object-graph-matrix graph) (list size size)
			  :initial-element 0))
      (setf (object-graph-lists graph)
	    (adjust-array (object-graph-lists graph) size
			  :initial-element nil)))))

(defun compute-matrix-indices (node1 node2 graph)
  (let ((row (universe-member-index node1 (object-graph-universe graph)))
	(col (universe-member-index node2 (object-graph-universe graph))))
    (if (> col row)
      (values col row)
      (values row col))))

(defun gra-matrix-bit-set? (node1 node2 graph)
  (multiple-value-bind (row col)
      (compute-matrix-indices node1 node2 graph)
    (eql (aref (object-graph-matrix graph) row col) 1)))

(defun gra-matrix-set-bit (node1 node2 graph)
  (multiple-value-bind (row col)
      (compute-matrix-indices node1 node2 graph)
    (setf (aref (object-graph-matrix graph) row col) 1)))

(defun gra-matrix-clear-bit (node1 node2 graph)
  (multiple-value-bind (row col)
      (compute-matrix-indices node1 node2 graph)
    (setf (aref (object-graph-matrix graph) row col) 0)))

(defun gra-node-member? (node graph)
  (sync-object-graph graph)
  (set-member? node (object-graph-nodes graph)))

(defun gra-add-node (node graph)
  (sync-object-graph graph)
  (bs-add node (object-graph-nodes graph)))

(defun gra-edge-member? (node1 node2 graph)
  (sync-object-graph graph)
  (and (gra-node-member? node1 graph)
       (gra-node-member? node2 graph)
       (gra-matrix-bit-set? node1 node2 graph)))

(defun gra-add-edge (node1 node2 graph)
  (sync-object-graph graph)
  (unless (and (gra-node-member? node1 graph)
	       (gra-node-member? node2 graph)
	       (gra-edge-member? node1 node2 graph))
    (gra-matrix-set-bit node1 node2 graph)
    (let ((idx1 (universe-member-index node1 (object-graph-universe graph)))
	  (idx2 (universe-member-index node2 (object-graph-universe graph))))
      (push node2 (aref (object-graph-lists graph) idx1))
      (unless (eql node1 node2)
	(push node1 (aref (object-graph-lists graph) idx2))))))

(defun gra-rem-edge (node1 node2 graph)
  (sync-object-graph graph)
  (when (and (gra-node-member? node1 graph)
	     (gra-node-member? node2 graph)
	     (gra-edge-member? node1 node2 graph))
    (gra-matrix-clear-bit node1 node2 graph)
    (let ((idx1 (universe-member-index node1 (object-graph-universe graph)))
	  (idx2 (universe-member-index node2 (object-graph-universe graph))))
      (setf (aref (object-graph-lists graph) idx1)
	    (delete node2 (aref (object-graph-lists graph) idx1)))
      (setf (aref (object-graph-lists graph) idx2)
	    (delete node1 (aref (object-graph-lists graph) idx2))))))

(defun gra-add-edges-to-set-members (node oset graph)
  (sync-object-graph graph)
  (iter (for member in-oset oset)
	(gra-add-edge node member graph)))

(defun gra-node-count (graph)
  (set-count (object-graph-nodes graph)))

(defun gra-neighbor-count (node graph)
  (length (aref (object-graph-lists graph)
		(universe-member-index node (object-graph-universe graph)))))

(defmacro-driver (FOR var IN-GRA-NODES gra)
  (let ((set (gensym))
	(key (if generate 'generate 'for)))
    `(progn
       (with ,set = (object-graph-nodes ,gra))
       (,key ,var in-oset ,set))))

(defmacro-driver (FOR var ADJ-TO node IN-GRA gra)
  (let ((idx (gensym))
	(itr (gensym))
	(last (gensym))
	(key (if generate 'generate 'for)))
    `(progn
       (with ,idx = (universe-member-index ,node (object-graph-universe ,gra)))
       (with ,itr = (aref (object-graph-lists ,gra) ,idx))
       (,key ,var next (progn (when (eql ,itr nil) (terminate))
			      (let ((,last ,itr))
				(setf ,itr (cdr ,itr))
				(car ,last)))))))

(defmethod listify-thing ((thing object-graph) &optional short)
  (declare (ignore short))
  (iter (for node in-oset (object-graph-nodes thing))
	(collect (list (listify-thing node)
		       (iter (for nbor adj-to node in-gra thing)
			     (collect (listify-thing nbor t)))))))