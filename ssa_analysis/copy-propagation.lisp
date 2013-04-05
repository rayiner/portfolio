; copy-propagation.lisp
; Copy-coalescing optimization

(in-package "VITAMIN")

(defun new-copy-table () (make-hash-table))

(defun copy-chain-root (value copy-table)
  (or (gethash value copy-table) value))

(defun add-copy-to-chain (source dest copy-table)
  (setf (gethash dest copy-table)
	(copy-chain-root source copy-table)))

(defun note-copy-instruction (ins copy-table)
  (add-copy-to-chain (source-of-copy ins) (dest-of-copy ins) copy-table))

(defun replace-copy-uses (ins copy-table)
  (iter (for use in-olist (ins-uses ins) pred #'temporary? with-ref ref)
	(list-ref-replace ref (copy-chain-root use copy-table))))

(defun propagate-copies (proc)
  (let ((copy-table (new-copy-table)))
	(map-over-instructions #'(lambda (ins)
				   (note-copy-instruction ins copy-table))
			       proc 'transfer)
	(map-over-instructions #'(lambda (ins)
				   (replace-copy-uses ins copy-table))
			       proc)))

    