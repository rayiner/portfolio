; environment.lisp
; Routines for dealing with lexical environments

(in-package "VITALISP")

(defclass lexical-environment ()
  ((venv :initform nil :initarg :venv :reader le-venv)
   (fenv :initform nil :initarg :fenv :reader le-fenv)))

(defmethod print-object ((env lexical-environment) stream)
  (format stream "venv: ~A~%fenv: ~A" (le-venv env) (le-fenv env)))

(defun new-lexical-environment ()
  (make-instance 'lexical-environment))

(defun bind-in-environment (name thing ns env)
  (let ((nvenv (if (eq ns :variable) 
		   (acons name thing (le-venv env)) 
		   (le-venv env)))
	(nfenv (if (eq ns :function)
		   (acons name thing (le-fenv env))
		   (le-fenv env))))
    (make-instance 'lexical-environment :venv nvenv :fenv nfenv)))

(defun bind-in-environment* (names things ns env)
  (if (not names)
      env
      (bind-in-environment (first names)
			   (first things)
			   ns
			   (bind-in-environment* (rest names) 
						 (rest things) 
						 ns
						 env))))

(defun lookup-binding (name ns env)
  (let ((list (ecase ns (:variable (le-venv env)) (:function (le-fenv env)))))
    (cdr (assoc name list))))

(defun append-environment (env1 env2)
  (make-instance 'lexical-environment
		 :venv (append (le-venv env1) (le-venv env2))
		 :fenv (append (le-fenv env1) (le-fenv env2))))

(defun walk-bind-form (fun-init-fun 
		       fun-walk-fun 
		       var-walk-fun 
		       body-walk-fun 
		       combine-fun
		       form 
		       env
		       par?)
  (labels ((init-bindings (bindings)
	     (if (not bindings)
		 env
		 (let* ((binding (first bindings))
			(name (decompose-function-definition binding)))
		   (if (eq (first binding) '|fun|)
		       (bind-in-environment name
					    (funcall fun-init-fun binding)
					    :function
					    (init-bindings (rest bindings)))
		       (init-bindings (rest bindings))))))
	   (walk-binding (binding env)
	     (ecase (first binding)
	       (|fun| (funcall fun-walk-fun binding env))
	       (|var| (funcall var-walk-fun binding env))))
	   (walk-bindings (bindings nenv results)
	     (if (not bindings)
		 (values nenv results)
		 (multiple-value-bind (thing result)
		     (walk-binding (first bindings) (if par? env nenv))
		   (let* ((name (second (first bindings)))
			  (ns (ecase (first (first bindings))
				(|fun| :function)
				(|var| :variable)))
			  (inc-bound? (if (eq ns :function) nil t)))
		     (if inc-bound?
			 (walk-bindings (rest bindings)
					(bind-in-environment name thing ns nenv)
					(when combine-fun
					  (funcall combine-fun result results)))
			 (walk-bindings (rest bindings)
					nenv
					(when combine-fun
					  (funcall combine-fun
						   result
						   results)))))))))
    (multiple-value-bind (bindings body)
	(decompose-bind-form form)
      (let* ((init-env (init-bindings bindings)))
	(multiple-value-bind (body-env bind-results)
	    (walk-bindings bindings init-env nil)
	  (values bind-results (funcall body-walk-fun body body-env)))))))
