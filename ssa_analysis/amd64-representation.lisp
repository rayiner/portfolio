; amd64-representation.lisp
; AMD64-specific intermediate representation

(in-package "VITAMIN")

(defclass amd64-temporary (temporary) ())

(defclass amd64-procedure (procedure) ())

(defun new-amd64-procedure ()
  (let ((proc (make-instance 'amd64-procedure))
	(names '(rax rbx rcx rdx rsi rdi rbp rsp
		 r8 r9 r10 r11 r12 r13 r14 r15)))
    (iter (for name in names)
	  (let ((temp (make-instance 'amd64-temporary :name name)))
	    (setf (ftemp-base temp) temp)
	    (unless (member name '(rbp rsp)) ; rbp, rsp not allocable
	      (add-to-universe temp (mproc-aregs proc)))
	    (add-to-universe temp (mproc-regs proc))))
    proc))

(register-target-procedure-maker :amd64 'new-amd64-procedure)

