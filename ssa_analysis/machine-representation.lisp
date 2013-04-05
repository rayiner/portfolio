; machine-representation.lisp
; Machine-specific code representation

(in-package "VITAMIN")

(defclass machine-temporary ()
  ((acount :accessor mtemp-acount)
   (in-intg? :accessor mtemp-in-intg?)
   (acolors :accessor mtemp-acolors)
   (reg :accessor mtemp-reg)))

(defclass machine-instruction () ())

(defclass machine-basic-block () ())

(defclass machine-procedure ()
  ((regs :accessor mproc-regs :initform (new-universe))
   (aregs :accessor mproc-aregs :initform (new-universe))
   (spill-count :accessor mproc-spill-count :initform -1)
   (spills :accessor mproc-spills :initform (new-universe))))
