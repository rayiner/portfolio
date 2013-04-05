; vis-definition.lisp
; Defines the VIS instruction set

(in-package "VITAMIN")

(defvar *instruction-table* (make-hash-table))

(defun class-for-mnemonic (mnem)
  (gethash mnem *instruction-table*))

(defmacro define-instruction (name supers patterns)
  (flet ((instruction-class-name (name)
	   (intern (concatenate 'string "INS-" (symbol-name name))))
	 (instruction-mnemonic (name)
	   (intern (symbol-name name) "KEYWORD")))
    `(progn 
       (defclass ,(instruction-class-name name) ,supers
	 ((mnem :initform ,(instruction-mnemonic name))
	  (form :initform ',patterns)))
       (setf (gethash ,(instruction-mnemonic name) *instruction-table*)
	     ',(instruction-class-name name)))))

(defmacro define-arithmetic-instruction (name)
  `(define-instruction ,name (arithmetic-operator)
     ((half-temporary (half-temporary half-temporary))
      (word-temporary (word-temporary word-temporary))
      (single-temporary (single-temporary single-temporary)))))

(defmacro define-integer-instruction (name)
  `(define-instruction ,name (arithmetic-operator)
     ((half-temporary (half-temporary half-temporary))
      (word-temporary (word-temporary word-temporary)))))

(defmacro define-floating-point-instruction (name)
  `(define-instruction ,name (arithmetic-operator)
     ((single-temporary (single-temporary single-temporary))
      (double-temporary (double-temporary double-temporary)))))

(defmacro define-round-instruction (name)
  `(define-instruction ,name (conversion)
     ((word-temporary (double-temporary))
      (half-temporary (double-temporary))
      (word-temporary (single-temporary))
      (half-temporary (single-temporary)))))

(define-instruction undef (initial-definition)
  ((pointer-temporary ())
   (half-temporary ())
   (word-temporary ())
   (single-temporary ())
   (double-temporary ())
   (generic-temporary ())))

(define-instruction phi (join)
  ((pointer-temporary ())
   (half-temporary ())
   (word-temporary ())
   (single-temporary ())
   (double-temporary ())
   (generic-temporary ())))

(define-instruction cp (transfer)
  ((pointer-temporary (pointer-temporary))
   (half-temporary (half-temporary))
   (word-temporary (word-temporary))
   (single-temporary (single-temporary))
   (double-temporary (double-temporary))
   (generic-temporary (generic-temporary))))

(define-instruction ldi (constant-definition)
  ((pointer-temporary (pointer-constant))
   (half-temporary (half-constant))
   (word-temporary (word-constant))
   (single-temporary (single-constant))
   (double-temporary (double-constant))
   (generic-temporary (generic-constant))))

(define-instruction ld (memory-load)
  ((pointer-temporary (pointer-temporary))
   (half-temporary (pointer-temporary))
   (word-temporary (pointer-temporary))
   (single-temporary (pointer-temporary))
   (double-temporary (pointer-temporary))
   (generic-temporary (pointer-temporary))))

(define-instruction st (memory-store)
  ((pointer-temporary pointer-temporary)
   (half-temporary pointer-temporary)
   (word-temporary pointer-temporary)
   (single-temporary pointer-temporary)
   (double-temporary pointer-temporary)
   (generic-temporary pointer-temporary)))

(define-instruction ldb (memory-load)
  ((half-temporary (pointer-temporary))
   (word-temporary (pointer-temporary))))

(define-instruction stb (memory-store)
  ((half-temporary pointer-temporary)
   (word-temporary pointer-temporary)))

(define-instruction br (branch) ())

(define-instruction bri (indirect-branch)
  ((pointer-temporary)))

(define-instruction brc (conditional-branch)
  ((pointer-temporary pointer-temporary)
   (half-temporary half-temporary)
   (word-temporary word-temporary)
   (single-temporary single-temporary)
   (double-temporary double-temporary)
   (generic-temporary generic-temporary)))

(define-instruction brt (conditional-branch)
  ((generic-temporary)))

(define-instruction call (direct-procedure-call)
  ((pointer-temporary ())
   (half-temporary ())
   (word-temporary ())
   (single-temporary ())
   (double-temporary ())
   (generic-temporary ())))

(define-instruction calli (indirect-procedure-call)
  ((pointer-temporary (pointer-temporary))
   (half-temporary (pointer-temporary))
   (word-temporary (pointer-temporary))
   (single-temporary (pointer-temporary))
   (double-temporary (pointer-temporary))
   (generic-temporary (pointer-temporary))))

(define-instruction ret (procedure-exit)
  ((pointer-temporary)
   (half-temporary)
   (word-temporary)
   (single-temporary)
   (double-temporary)
   (generic-temporary)))

(define-arithmetic-instruction add)
(define-arithmetic-instruction sub)
(define-arithmetic-instruction mul)
(define-arithmetic-instruction div)
(define-arithmetic-instruction rem)

(define-integer-instruction and)
(define-integer-instruction or)
(define-integer-instruction xor)
(define-integer-instruction not)
(define-integer-instruction sll)
(define-integer-instruction srl)
(define-integer-instruction sra)
(define-integer-instruction ror)
(define-integer-instruction rol)

(define-floating-point-instruction min)
(define-floating-point-instruction max)

(define-instruction trunc (conversion)
  ((half-temporary (word-temporary))))

(define-instruction sext (conversion)
  ((word-temporary (half-temporary))))

(define-round-instruction rtz)
(define-round-instruction rtn)

(define-instruction cvt (conversion)
  ((double-temporary (word-temporary))
   (double-temporary (half-temporary))
   (single-temporary (word-temporary))
   (single-temporary (half-temporary))
   (double-temporary (single-temporary))
   (single-temporary (double-temporary))))

(define-instruction offt (address-calculation)
  ((pointer-temporary (pointer-temporary))))

(define-instruction untag (conversion)
  ((pointer-temporary (generic-temporary))
   (half-temporary (generic-temporary))
   (single-temporary (generic-temporary))))

(define-instruction tag (conversion)
  ((generic-temporary (pointer-temporary half-temporary))
   (generic-temporary (half-temporary half-temporary))
   (generic-temporary (single-temporary single-temporary))))
