; utility routines for the front-end

(in-package :verrazano)

(defun system-relative-pathname (system path)
  "Return a pathname relative to the given asdf system."
  (merge-pathnames path (asdf:component-pathname (asdf:find-system system))))

(defun execute-shell-command (command-string &key (output nil output-p) error-handler)
  ;; TODO instead of the appended >foo hack, use :output in
  ;; trivial-shell once it's implemented.
  (let ((actual-command (format nil "~A ~A"
                                command-string
                                (if output-p
                                    (concatenate 'string ">\"" output "\"")
                                    ""))))
    (format *debug-io* "$ ~A~%" actual-command)
    (multiple-value-bind (output error return-code)
        (trivial-shell:shell-command actual-command)
      (unless (zerop (length output))
        (format *debug-io* "; Standard output:~%~A" output))
      (unless (zerop (length error))
        (format *debug-io* "; Standard error:~%~A" error))
      (unless (zerop return-code)
        (format *debug-io* "; Return code: ~A~%" return-code)
        (if error-handler
            (funcall error-handler return-code)
            (cerror "Ignore" "Command ~S returned ~S" command-string return-code))))))

(defmacro do-fields-of-composite-type ((variable node) &body body)
  `(iter (for ,variable :in-sequence (members-of ,node))
         (unless (typep field 'gccxml:field)
           ;; this seems to be a gccxml bug: unnamed nested structs and unions appear among the fields, we just skip them.
           (next-iteration))
         ,@body))

(defmacro do-arguments-of-function ((variable function-node &key skip-ellipsis) &body body)
  `(iter (for ,variable :in-sequence (flexml:children-of ,function-node))
         ,@(when skip-ellipsis
             `((when (typep ,variable 'gccxml:ellipsis)
                 (next-iteration))))
         ,@body))

(defun bits-to-bytes (number)
  (declare (type integer number))
  (bind (((:values bytes remainder) (truncate number 8)))
    (assert (zerop remainder))
    bytes))

(defun unquote-string (str)
  (if (and
	  (eq (elt str 0) #\")
	  (eq (elt str (- (length str) 1)) #\"))
    (subseq str 1 (- (length str) 1))
    str))

(defun generate-unique-name (&optional (base "anonymous"))
  (concatenate 'string base (princ-to-string (incf *unique-name-counter*))))

;;; some anaphoric stuff
(defmacro if-bind (var test &body then/else)
  (assert (first then/else)
          (then/else)
          "IF-BIND missing THEN clause.")
  (destructuring-bind (then &optional else)
      then/else
    `(let ((,var ,test))
       (if ,var ,then ,else))))

(defmacro aif (test then &optional else)
  `(if-bind it ,test ,then ,else))

(defmacro when-bind (var test &body body)
  `(if-bind ,var ,test (progn ,@body)))

(defmacro awhen (test &body body)
  `(when-bind it ,test ,@body))

(defmacro prog1-bind (var ret &body body)
  `(let ((,var ,ret))
    ,@body
    ,var))

(defmacro aprog1 (ret &body body)
  `(prog1-bind it ,ret ,@body))
