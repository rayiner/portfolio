(in-package :verrazano)

(defclass cffi-backend (simple-backend)
  ((package-name
    :type symbol
    :initarg :package-name
    :accessor package-name-of)
   (package-nicknames
    :initform ()
    :initarg :package-nicknames
    :accessor package-nicknames-of)
   (exported-symbols
    :initform (make-hash-table :test #'equal)
    :accessor exported-symbols-of)
   (output-filename
    :initform nil
    :initarg :output-filename
    :accessor output-filename-of)
   (const-char-pointer-is-string
    :initform t
    :initarg :const-char-pointer-is-string
    :accessor const-char-pointer-is-string?))
  (:default-initargs
   :gccxml-node-types-to-output '(gccxml:struct gccxml:class gccxml:typedef gccxml:function gccxml:constructor gccxml:variable gccxml:macro)
    :filter-definitions-from-indirect-files t))

(defmethod initialize-instance :after ((self cffi-backend) &key)
  (unless (output-filename-of self)
    (setf (output-filename-of self)
          (merge-pathnames (working-directory-of self)
                           (concatenate 'string
                                        (string-downcase (package-name-of self))
                                        ".lisp"))))
  (setf (package-nicknames-of self) (ensure-list (package-nicknames-of self))))

(defmethod make-backend ((backend-specification (eql :cffi)) &rest initargs)
  (apply #'make-instance 'cffi-backend initargs))

(defun enqueue-for-export (name)
  (when (funcall (export-filter-of *backend*) name)
    (setf (gethash name (exported-symbols-of *backend*)) t))
  name)

;; a mapping from GCCXML type names to CFFI type names
(defparameter *gccxml-fundamental-type->cffi-type*
  '(("void" . :void)
    ("bool" . :char)
    ("char" . :char)
    ("wchar-t" . :int)
    ("unsigned char" . :unsigned-char)
    ("signed char" . :char)
    ("int" . :int)
    ("short int" . :short)
    ("short unsigned int" . :unsigned-short)
    ("long int" . :long)
    ("long long int" . :long-long)
    ("long long unsigned int" . :unsigned-long-long)
    ("unsigned int" . :unsigned-int)
    ("long unsigned int" . :unsigned-long)
    ("float" . :float)
    ("double" . :double)
    ;; these are not supported
    ;;("long double" . :long-double)
    ;;("complex long double" . "not_supported")
    ))
