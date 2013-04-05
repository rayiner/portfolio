; chaitin-allocator.lisp
; A simple Briggs-Chaitin register allocator

(in-package "VITAMIN")

; choose node with highest degree for spilling
(defun max-degree-spill-chooser (intg)
  (iter (for temp in-gra-nodes intg)
	(finding temp maximizing (if (mtemp-in-intg? temp)
				     (mtemp-acount temp)
				     -1))))

(defun chaitin-register-allocator (proc)
  (note-all-analyses-invalid proc)
  (ensure-analyses-valid '(:intg) proc)
  (let* ((k (universe-size (mproc-aregs proc)))
	 (stack (simplify-interference-graph (fproc-intg proc) k
					     #'max-degree-spill-chooser)))
    (color-procedure-temporaries proc stack)))

(register-register-allocator :chaitin 'chaitin-register-allocator)