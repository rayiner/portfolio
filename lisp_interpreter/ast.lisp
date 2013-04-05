; ast.lisp
; Routines for dealing with the AST

(in-package "VITALISP")

(defparameter *special-names* '(|quote| 
				|do| |if| |match|
				|bind| |bind-par|
				|function-value|
				|set!| |bound?|))

(defun literal? (it)
  (or (integerp it) (floatp it) (stringp it)))

(defun identifier? (it)
  (symbolp it))

(defun special-form? (it)
  (member (first it) *special-names*))

(defun decompose-function-definition (it)
  (values (second it) (third it) (cdddr it)))

(defun decompose-case-definition (it)
  (values (second it) (cddr it)))

(defun decompose-macro-definition (it)
  (decompose-function-definition it))

(defun decompose-variable-definition (it)
  (values (second it) (third it)))

(defun decompose-dynamic-variable-definition (it)
  (decompose-variable-definition it))

(defun decompose-constant-definition (it)
  (decompose-variable-definition it))

(defun decompose-type-definition (it)
  (values (second it) (cddr it)))

(defun decompose-call (it)
  (values (first it) (rest it)))

(defun decompose-lambda-list (it)
  (let* ((key-split (position '? it))
	 (rest-split (position '& it))
	 (req-end (or key-split rest-split (length it)))
	 (key-end (or rest-split (length it)))
	 (rest-end (length it)))
    (values (subseq it 0 req-end)
	    (rest (subseq it req-end key-end))
	    (rest (subseq it key-end rest-end)))))

(defun decompose-optional-variable (it)
  (if (consp it)
      (values (first it) (second it))
      (values it nil)))

(defun decompose-match-case (it)
  (values (butlast it) (first (last it))))

(defun decompose-data-constructor (it)
  (if (consp it)
      (values (first it) (rest it))
      (values it nil)))

(defun decompose-slot-pattern (it)
  (if (consp it)
      (values (first it) (second it))
      (values it nil)))

(defun decompose-if-form (it)
  (values (second it) (third it) (fourth it)))

(defun if-form-has-alternate? (it)
  (= (length it) 4))

(defun decompose-bind-form (it)
  (values (second it) (cddr it)))

(defun filter-bindings (bindings sym)
  (when bindings
    (if (eq (first (first bindings)) sym)
	(cons (first bindings) (filter-bindings (rest bindings) sym))
	(filter-bindings (rest bindings) sym))))

(defun decompose-bind-bindings (bindings)
  (values (filter-bindings bindings '|fun|) (filter-bindings bindings '|var|)))

(defun literal-lambda? (form)
  (listp (second form)))

(defun decompose-literal-lambda (form)
  (values (second form) (cddr form)))

(defun decompose-symbol-function-value-form (form)
  (second form))

(defun decompose-set!-form (form)
  (values (second form) (third form)))
