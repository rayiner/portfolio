; Error handling definitions

(in-package "VITAMIN")

(define-condition compiler-error (error)
  ((message :initarg :message :reader compiler-error-message)))

(define-condition internal-error (compiler-error)
  ((context :initarg :context :reader internal-error-context)))

(define-condition user-error (compiler-error)
  ((form :initarg :form :reader user-error-form)))

(defmacro assert-user (pred form message)
  `(unless ,pred
     (error 'user-error :form ,form :message ,message)))

(defmacro assert-internal (pred context message)
  `(unless ,pred
     (error 'internal-error :check ',pred :message ,message 
	    :context ,context)))

