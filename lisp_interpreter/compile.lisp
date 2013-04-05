; compile.lisp
; Compile Vitalisp source code to Vitamin bytecode

(in-package "VITALISP")

(defparameter *bc-builder* nil)

(defparameter *primitive-map* '((|apply| . apply)
				(|call| . funcall)
				(|eq?| . eq)
				(|equal?| . equal?)
				(|print| . print)
				(+ . numadd)
				(- . numsub)
				(* . nummul)
				(/ . numdiv)
				(< . numcmpl)
				(<= . numcmple)
				(> . numcmpg)
				(>= . numcmpge)
				(= . numcmpe)
				(/= . numcmpne)
				(|pow| . numpow)
				(|mod| . nummod)
				(|not| . not)))

(defparameter +closure-temp+ 0)

(defclass lexical-variable ()
  ((temp :initarg :temp :reader lv-temp)
   (home :initarg :home :reader lv-home)))

(defclass lexical-function ()
  ((name :initarg :name :reader lf-name)
   (temp :initarg :temp :reader lf-temp)
   (cvars :initarg :cvars :reader lf-cvars)))

(defun new-lexical-variable (temp home)
  (make-instance 'lexical-variable
		 :temp (if temp temp (generate-temporary *bc-builder*))
		 :home home))

(defun new-lexical-function (name cvars)
  (make-instance 'lexical-function
		 :name name
		 :temp (if cvars (generate-temporary *bc-builder*) nil)
		 :cvars cvars))

(defun primitive-call? (form)
  (assoc (first form) *primitive-map*))

(defun remove-defined-variables (vars env)
  (remove-if #'(lambda (var) (lookup-binding var :variable env)) vars))

(defun free-variables-in-named-lambda (it)
  (multiple-value-bind (name args body)
      (decompose-function-definition it)
    (declare (ignore name))
    (free-variables-in-lambda args body)))

(defun free-variables-in-unnamed-lambda (it)
  (multiple-value-bind (args body)
      (decompose-literal-lambda it)
    (free-variables-in-lambda args body)))

(defun free-variables-in-lambda (args body)
  (let* ((nenv (bind-in-environment* args 
				     (map-constant t args) 
				     :variable
				     (new-lexical-environment)))
	 (fvars (free-variables-in-body body nenv)))
    (remove-if #'null (remove-duplicates fvars))))

(defun free-variables-in-body (body env)
  (flat-map #'(lambda (it) (free-variables-in-form it env)) body))

(defun free-variables-in-form (it env)
  (cond
    ((literal? it) nil)
    ((identifier? it) (if (lookup-binding it :variable env) nil (list it)))
    ((special-form? it)
     (ecase (first it)
       (|quote| nil)
       (|do| (free-variables-in-body (rest it) env))
       (|if| (free-variables-in-if-form it env))
       (|bind| (free-variables-in-bind-form it env nil))
       (|bind-par| (free-variables-in-bind-form it env t))
       (|function-value| 
	(remove-defined-variables (free-variables-in-unnamed-lambda it) env))))
    (t (free-variables-in-body (rest it) env))))

(defun free-variables-in-if-form (it env)
  (multiple-value-bind (pred csq alt)
      (decompose-if-form it)
    (if (if-form-has-alternate? it)
	(append (free-variables-in-form pred env)
		(free-variables-in-form csq env)
		(free-variables-in-form alt env))
	(append (free-variables-in-form pred env)
		(free-variables-in-form csq env)))))

(defun free-variables-in-bind-form (it env par?)
  (multiple-value-bind (bind-results body-results)
      (walk-bind-form #'(lambda (binding) binding)
		      #'(lambda (binding env)
			  (let ((vars (free-variables-in-named-lambda binding)))
			    (values t (remove-defined-variables vars env))))
		      #'(lambda (binding env)
			  (multiple-value-bind (name form)
			      (decompose-variable-definition binding)
			    (declare (ignore name))
			    (values t (free-variables-in-form form env))))
		      #'free-variables-in-body
		      #'append
		      it
		      env
		      par?)
    (append bind-results body-results)))

(defun do-emit (ins &rest args)
  (apply #'emit-instruction *bc-builder* ins args))

(defun yield-value (value tail?)
  (if tail? (do-emit 'return 1 value) value))

(defun compile-source-file (file)
  (let ((*bc-builder* (make-instance 'bytecode-builder)))
    (compile-definitions (vitalisp-read-file file))
    (bb-elts *bc-builder*)))

(defun compile-definitions (items)
  (map nil
       #'(lambda (it)
	   (ecase (first it)
	     (|fun| (compile-function-definition it))))
       items))

(defun compile-function-definition (it)
  (multiple-value-bind (name args body)
      (decompose-function-definition it)
    (let* ((name (decorate-name (symbol-name name) :function))
	   (lf (new-lexical-function name nil))
	   (env (bind-in-environment name 
				     lf 
				     :function 
				     (new-lexical-environment))))
      (compile-lambda name args body nil lf env))))

(defun compile-lambda (name args body cvars lf env)
  (push-element *bc-builder* 'bytecode-procedure name)
  (when cvars (generate-temporary *bc-builder*))
  (let* ((env (build-lambda-variable-environment args lf env)))
    (compile-evaluable-body body lf env t))
  (pop-element *bc-builder*))

(defun build-lambda-variable-environment (args lf env)
  (bind-in-environment* args 
			(mapcar #'(lambda (arg)
				    (declare (ignore arg))
				    (new-lexical-variable nil lf))
				args)
			:variable
			env))

(defun compile-evaluable-body (it lf env tail?)
  (map nil #'(lambda (it) (compile-evaluable-form it lf env nil)) (butlast it))
  (compile-evaluable-form (first (last it)) lf env tail?))

(defun compile-evaluable-form (it lf env tail?)
  (cond
    ((literal? it) (compile-constant-reference it tail?))
    ((identifier? it) (compile-variable-reference it lf env tail?))
    ((special-form? it) (compile-special-form it lf env tail?))
    ((primitive-call? it) (compile-primitive-call-form it lf env tail?))
    (t (compile-function-call-form it lf env tail?))))

(defun compile-constant-reference (it tail?)
  (let ((const (generate-constant *bc-builder* it))
	(dest (generate-temporary *bc-builder*)))
    (do-emit 'cpconst dest const)
    (yield-value dest tail?)))

(defun compile-variable-reference (it lf env tail?)
  (let ((lv (lookup-binding it :variable env)))
    (unless lv (error (format nil "Unbound variable ~A in ~A" it (lf-name lf))))
    (let ((closure-ref? (not (eq (lv-home lv) lf))))
      (if (not closure-ref?)
	  (yield-value (lv-temp lv) tail?)
	  (let ((temp (generate-temporary *bc-builder*))
		(idx (position it (lf-cvars lf))))
	    (do-emit 'closureref temp +closure-temp+ idx)
	    (yield-value temp tail?))))))

(defun compile-special-form (it lf env tail?)
  (ecase (first it)
    (|do| (compile-do-form it lf env tail?))
    (|if| (compile-if-form it lf env tail?))
    (|bind| (compile-bind-form it lf env tail? nil))
    (|bind-par| (compile-bind-form it lf env tail? t))
    (|function-value| (compile-function-value-form it lf env tail?))))

(defun compile-do-form (it lf env tail?)
  (compile-evaluable-body (rest it) lf env tail?))

(defun compile-if-form (it lf env tail?)
  (multiple-value-bind (pred csq alt)
      (decompose-if-form it)
    (let* ((rtemp (generate-temporary *bc-builder*))
	   (alt-lab (generate-label *bc-builder*))
	   (fin-lab (generate-label *bc-builder*))
	   (pred-temp (compile-evaluable-form pred lf env nil)))
      (do-emit 'skipunless pred-temp alt-lab)
      (let ((csq-temp (compile-evaluable-form csq lf env tail?)))
	(unless tail? 
	  (do-emit 'cptemp rtemp csq-temp)
	  (do-emit 'skip fin-lab)))
      (emit-label *bc-builder* alt-lab)
      (if (if-form-has-alternate? it)
	  (let ((alt-temp (compile-evaluable-form alt lf env tail?)))
	    (unless tail? (do-emit 'cptemp rtemp alt-temp)))
	  (let ((undef-const (generate-constant *bc-builder* nil)))
	    (do-emit 'cpconst rtemp undef-const)
	    (when tail? (do-emit 'return 1 rtemp))))
      (unless tail? 
	(emit-label *bc-builder* fin-lab)
	rtemp))))

(defun compile-bind-form (it lf env tail? par?)
  (let ((lf-table (make-hash-table)))
    (multiple-value-bind (bind-results body-results)
	(walk-bind-form #'(lambda (binding)
			    (let ((lf (initialize-function-binding binding)))
			      (setf (gethash binding lf-table) lf)
			      lf))
			#'(lambda (binding env)
			    (let ((dlf (gethash binding lf-table)))
			      (compile-function-binding binding dlf lf env)))
			#'(lambda (binding env)
			    (compile-variable-binding binding lf env))
			#'(lambda (body env)
			    (compile-evaluable-body body lf env tail?))
			nil
			it
			env
			par?)
      (declare (ignore bind-results))
      body-results)))

(defun initialize-function-binding (binding)
  (multiple-value-bind (name args body)
      (decompose-function-definition binding)
    (let* ((uname (generate-unique-name *bc-builder* (symbol-name name)))
	   (name (decorate-name uname :function)))
      (new-lexical-function name (free-variables-in-lambda args body)))))

; these two are just different enough for it to not be worth combining them
(defun compile-function-binding (binding dlf lf env)
  (multiple-value-bind (name args body)
      (decompose-function-definition binding)
    (declare (ignore name))
    (let* ((name (lf-name dlf))
	   (ref (generate-reference *bc-builder* name))
	   (cvars (lf-cvars dlf))
	   (clos-count (length cvars))
	   (avs (mapcar #'(lambda (cvar)
			    (compile-variable-reference cvar lf env nil))
			cvars)))
      (compile-lambda name args body cvars dlf env)
      (when avs
	(do-emit 'closure (lf-temp dlf) ref clos-count)
	(emit-operands *bc-builder* avs)))))

(defun compile-variable-binding (binding lf env)
  (multiple-value-bind (name form)
      (decompose-variable-definition binding)
    (declare (ignore name))
    (new-lexical-variable (compile-evaluable-form form lf env nil) lf)))
 
(defun compile-function-value-form (it lf env tail?)
  (multiple-value-bind (args body)
      (decompose-literal-lambda it)
    (let* ((uname (generate-unique-name *bc-builder* "lambda"))
	   (name (decorate-name uname :function))
	   (ref (generate-reference *bc-builder* name))
	   (cvars (free-variables-in-lambda args body))
	   (dlf (new-lexical-function name cvars))
	   (clos-count (length cvars))
	   (avs (mapcar #'(lambda (cvar)
			    (compile-variable-reference cvar lf env nil))
			cvars))
	   (temp (generate-temporary *bc-builder*)))
      (compile-lambda name args body cvars dlf env)
      (do-emit 'closure temp ref clos-count)
      (when avs (emit-operands *bc-builder* avs))
      (yield-value temp tail?))))

(defun compile-primitive-call-form (it lf env tail?)
  (multiple-value-bind (fun args)
      (decompose-call it)
    (let ((rtemp (generate-temporary *bc-builder*))
	  (ins (cdr (assoc fun *primitive-map*)))
	  (cargs (compile-call-arguments args lf env)))
      (apply #'do-emit ins rtemp cargs)
      (yield-value rtemp tail?))))

(defun compile-call-arguments (args lf env)
  (mapcar #'(lambda (it) (compile-evaluable-form it lf env nil)) args))

(defun compile-function-call-form (it lf env tail?)
  (multiple-value-bind (fun args)
      (decompose-call it)
    (let* ((rtemp (generate-temporary *bc-builder*))
	   (tlf (lookup-binding fun :function env))
	   (ref (if tlf
		    (generate-reference *bc-builder* (lf-name tlf))
		    (generate-reference *bc-builder*
					(decorate-name (symbol-name fun)
						       :function))))
	   (cargs (compile-call-arguments args lf env))
	   (ctemp (and tlf (if (eq lf tlf) +closure-temp+ (lf-temp tlf))))
	   (ecargs (if (and tlf (lf-cvars tlf)) (cons ctemp cargs) cargs)))
      (if tail?
	  (apply #'do-emit 'tailcall ref (length ecargs) ecargs)
	  (progn (apply #'do-emit 'call rtemp ref (length ecargs) ecargs)
		 rtemp)))))
