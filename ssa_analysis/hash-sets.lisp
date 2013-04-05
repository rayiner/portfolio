; hash-sets.lisp
; Set-like structure based on hash tables

(in-package "VITAMIN")

(defun new-hash-set () (make-hash-table))

(defun hs-add (thing set) (setf (gethash thing set) t))

(defun hs-rem (thing set) (remhash thing set))

(defun hs-member? (thing set) (gethash thing set))

