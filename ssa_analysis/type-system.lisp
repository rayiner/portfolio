; type-system.lisp
; Defines the VIS type system and contains code for operating on types

(in-package "VITAMIN")

(defparameter *designator-table* 
  '((:p . pointer-temporary)
    (:h . half-temporary)
    (:w . word-temporary)
    (:s . single-temporary)
    (:d . double-temporary)
    (:g . generic-temporary)
    (:cp . pointer-constant)
    (:ch . half-constant)
    (:cw . word-constant)
    (:cs . single-constant)
    (:cd . double-constant)
    (:cg . generic-constant)))

(defparameter *constant-type-table*
  '((pointer-constant . pointer-temporary)
    (half-constant . half-temporary)
    (word-constant . word-temporary)
    (single-constant . single-temporary)
    (double-constant . double-temporary)
    (generic-constant . generic-temporary)))

(defclass pointer () ())
(defclass half () ())
(defclass word () ())
(defclass single () ())
(defclass double () ())
(defclass generic () ())

(defun type-for-designator (key)
  (cdr (assoc key *designator-table*)))
   
(defun designator-for-type (type)
  (car (rassoc type *designator-table*)))

(defun constant-type-for-temporary-type (type)
  (car (rassoc type *constant-type-table*)))

(defun temporary-type-for-constant-type (type)
  (cdr (assoc type *constant-type-table*)))

(defun lisp-type-for-constant-type (type)
  (ecase type
    (pointer-constant '(integer -9223372036854775808 9223372036854775807))
    (half-constant '(integer -2147483648 2147483647))
    (word-constant '(integer -9223372036854775808 9223372036854775807))
    (single-constant 'single-float)
    (double-constant 'double-float)
    (generic-constant '(integer 0 18446744073709551615))))

(defun coerce-constant-to-lisp-value (constant type)
  (coerce constant (lisp-type-for-constant-type type)))
