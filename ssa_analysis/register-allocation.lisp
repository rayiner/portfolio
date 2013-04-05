; register-allocation.lisp
; Common code for register allocation

(in-package "VITAMIN")

(defvar *register-allocators* (make-hash-table))
(defparameter *current-register-allocator* :chaitin)

(defun register-register-allocator (key func)
  (setf (gethash key *register-allocators*) func))

(defun current-register-allocator ()
  (gethash *current-register-allocator* *register-allocators*))

(defun prepare-simplification-temporaries (intg)
  (iter (for temp in-gra-nodes intg)
	(setf (mtemp-acount temp) (gra-neighbor-count temp intg))
	(setf (mtemp-in-intg? temp) t)))

(defun choose-unconstrained-node (intg k)
  (iter (for temp in-gra-nodes intg)
	(when (and (mtemp-in-intg? temp)
		   (< (mtemp-acount temp) k))
	  (leave temp))))

(defun remove-unconstrained-node (temp intg)
  (iter (for nbor adj-to temp in-gra intg)
	(decf (mtemp-acount nbor)))
  (setf (mtemp-in-intg? temp) nil))

(defun simplify-interference-graph (intg k spill-chooser)
  (prepare-simplification-temporaries intg)
  (let ((stack nil)
	(count (gra-node-count intg)))
    (until-loop (= count 0)
      (let ((node (or (choose-unconstrained-node intg k)
		      (funcall spill-chooser intg))))
	(remove-unconstrained-node node intg)
	(push node stack)
	(decf count)))
    stack))

(defun prepare-coloring-temporaries (proc)
  (iter (for temp in-gra-nodes (fproc-intg proc))
	(setf (mtemp-acolors temp) (new-bit-set (mproc-aregs proc)))))

(defun find-free-color (temp proc)
  (iter (for reg in-univ (mproc-aregs proc))
	(unless (bs-member? reg (mtemp-acolors temp))
	  (leave reg))))

(defun assign-color-to-temporary (color temp proc)
  (setf (mtemp-reg temp) color)
  (iter (for nbor adj-to temp in-gra (fproc-intg proc))
	(bs-add color (mtemp-acolors nbor))))

(defun mark-temporary-as-spill (temp proc)
  (setf (mtemp-reg temp) (new-spill-temporary proc)))

(defun color-temporary (temp proc)
  (let ((color (find-free-color temp proc)))
    (if color
	(progn
	  (assign-color-to-temporary color temp proc)
	  (setf (mtemp-in-intg? temp) t))
	(mark-temporary-as-spill temp proc))))

(defun color-procedure-temporaries (proc stack)
  (prepare-coloring-temporaries proc)
  (until-loop (null stack)
    (let ((temp (pop stack)))
      (color-temporary temp proc))))

(defun allocate-registers (proc)
  (funcall (current-register-allocator) proc))

(defun print-register-assignments (proc)
  (iter (for temp in-gra-nodes (fproc-intg proc))
	(format t "~A -> ~A~%" (temp-name temp)
		(temp-name (mtemp-reg temp)))))
