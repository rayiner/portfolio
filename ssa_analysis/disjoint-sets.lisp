; disjoint-sets.lisp
; Sets of disjoint partitions based on disjoint-set forests,
; using union-by-rank and path compresson

(in-package "VITAMIN")

(defstruct partition-set 
  universe
  index)

(defstruct partition-node
  parent
  rank
  value
  set)

(defun new-partition-set (universe)
  (make-partition-set :universe universe :index (make-hash-table)))

(defun partition-from-element (rep pset)
  (let* ((universe (partition-set-universe pset))
	 (node (make-partition-node :value rep
				    :rank 0
				    :set (new-bit-set universe))))
    (bs-add rep (partition-node-set node))
    (setf (gethash rep (partition-set-index pset)) node)
    rep))

(defun find-partition-rep (rep pset)
  (partition-node-value 
   (do-find-partition (gethash rep (partition-set-index pset)))))

(defun find-partition-set (rep pset)
  (partition-node-set 
   (do-find-partition (gethash rep (partition-set-index pset)))))

(defun do-find-partition (node)
  (if (null (partition-node-parent node))
      node
      (setf (partition-node-parent node)
	    (do-find-partition (partition-node-parent node)))))

(defun in-same-partition? (rep1 rep2 pset)
  (eql (find-partition-rep rep1 pset) (find-partition-rep rep2 pset)))

(defun union-partitions (rep1 rep2 pset)
  (let ((node1 (gethash rep1 (partition-set-index pset)))
	(node2 (gethash rep2 (partition-set-index pset))))
    (do-union-partitions node1 node2)))

(defun do-union-partitions (node1 node2)
  (let ((root1 (do-find-partition node1))
	(root2 (do-find-partition node2)))
    (if (> (partition-node-rank root1) (partition-node-rank root2))
	(progn
	  (setf (partition-node-parent root2) root1)
	  (bs-ior (partition-node-set root1)
		   (partition-node-set root2) t))
	(progn
	  (setf (partition-node-parent root1) root2)
	  (bs-ior (partition-node-set root2)
		   (partition-node-set root1) t)))
    (when (eql (partition-node-rank root1)
	       (partition-node-rank root2))
      (incf (partition-node-rank root2)))))

(defun collect-partition-reps (pset)
  (let ((table (make-hash-table)))
    (iter (for rep in-univ (partition-set-universe pset))
	  (setf (gethash (find-partition-rep rep pset) table) t))
    (iter (for (key val) in-hashtable table)
	  (collect key))))

(defun collect-partition-sets (pset)
  (mapcar #'(lambda (rep)
	      (partition-node-set (gethash rep (partition-set-index pset))))
	  (collect-partition-reps pset)))

(defmethod listify-thing ((thing partition-set) &optional short)
  (iter (for set in (collect-partition-sets thing))
	(collect (listify-thing set short))))