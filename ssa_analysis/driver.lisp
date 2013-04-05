; driver.lisp
; Main compilation driver

(in-package "VITAMIN")

(defun compile-procedure (src)
  (let ((proc (convert-source src)))
    (convert-to-strict-form proc)
    proc))

(defun unssa-and-liveness (proc)
  (eliminate-phi-interferences proc)
  (convert-from-ssa-form proc)
  (note-all-analyses-invalid proc)
  (ensure-analyses-valid '(:intg) proc))

(defun compile-procedure-2 (src)
  (let ((proc (convert-source src)))
    (convert-to-strict-form proc)
    (allocate-registers proc)
    (print-register-assignments proc)
    (write-string-to-file (dotify-intg proc) "debug/intg.dot")))
