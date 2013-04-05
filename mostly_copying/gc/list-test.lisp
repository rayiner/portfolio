; Lisp version of the list test

(defconstant +page-size+ 1024)
(defconstant +cons-size+ 32)

(defun list-test ()
  (let* ((retain-factor 64)
	 (max-live 20000)
	 (alloc-count (/ (* max-live +page-size+ retain-factor) +cons-size+))
	 (list-head nil)
	 (list-tail nil))
    (loop for i from 0 below alloc-count do
	 (let ((cell (cons i nil)))
	   (if (= 0 (mod i retain-factor))
	       (if list-head
		   (progn
		     (setf (cdr list-tail) cell)
		     (setf list-tail cell))
		   (progn
		     (setf list-head cell)
		     (setf list-tail cell))))))
    list-head))
    