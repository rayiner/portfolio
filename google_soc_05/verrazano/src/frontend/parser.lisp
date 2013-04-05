; parser for converting GCC-XML file into IR

(in-package :verrazano)

(defclass gccxml-parser (flexml:flexml-builder)
  ((macro-name->macro-node
    :initform (make-hash-table :test #'equal)
    :accessor macro-name->macro-node-of)
   (type->name->node
    :initform (make-hash-table :test #'eq)
    :accessor type->name->node-of)
   (id->file-node
    :initform (make-hash-table :test #'equal)
    :accessor id->file-node-of)
   (input-files
    :initform (make-hash-table :test #'eq)
    :accessor input-files-of)))

(defun make-gccxml-parser ()
  (make-instance 'gccxml-parser
                 :default-package "GCCXML"))

(defmethod sax:characters ((parser gccxml-parser) data)
  ;; ignore them
  )

(defmethod sax:start-element :around ((parser gccxml-parser) namespace-uri local-name qname attributes)
  (let ((node (call-next-method)))
    (when (typep node 'gccxml:file)
      (setf (gethash (slot-value node 'xml:id) (id->file-node-of parser))
            node))
    node))

(defmethod sax:end-element :around ((builder gccxml-parser) namespace-uri local-name qname)
  (bind ((result (call-next-method)))
    (awhen (and (typep result 'gccxml:node-with-name)
                (name-of result))
      (bind ((name->node (or (gethash (cl:type-of result) (type->name->node-of builder))
                             (setf (gethash (cl:type-of result) (type->name->node-of builder))
                                   (make-hash-table :test #'equal)))))
        (setf (gethash it name->node) result)))
    result))

(defmethod sax:end-document :after ((builder gccxml-parser))
  (map-gccxml-nodes
   (lambda (node)
     (when (typep node 'gccxml:file)
       (bind ((name (name-of node)))
         (when (member-if (lambda (included-file)
                            (ends-with-subseq included-file name))
                          (input-files-of *backend*))
           (setf (gethash node (input-files-of builder)) t)))))))

(defgeneric find-node-by-name (name type parser &key otherwise)
  (:method ((name string) (type symbol) (parser gccxml-parser) &key (otherwise :error))
    (awhen (gethash type (type->name->node-of parser))
      (maphash-values
       (lambda (node)
         (when (equal name (name-of node))
           (return-from find-node-by-name node)))
       it))
    (case otherwise
      (:error (error "No node was found with name ~S" name))
      (:warn (warn "No node was found with name ~S" name))
      (t (if (functionp otherwise)
             (funcall otherwise)
             otherwise)))))

(defclass gccxml:node (flexml:flexml-node)
  ((gccxml:file
    :initform nil
    :type flexml:cross-referenced-node
    :accessor gccxml:file-of)
   (gccxml:line
    :initform nil
    :type (or null integer)
    :accessor gccxml:line-of)
   (gccxml:context
    :initform nil
    :type flexml:cross-referenced-node
    :accessor gccxml:context-of)))

(defclass gccxml:node-with-name (gccxml:node)
  ((gccxml:name
    :initform nil
    :accessor gccxml:name-of)
   (gccxml:mangled
    :initform nil
    :accessor gccxml:mangled-of)))

(defclass gccxml:node-with-type (gccxml:node)
  ((gccxml:type
    :type flexml:cross-referenced-node
    :accessor gccxml:type-of)))

(defclass gccxml:node-with-members (gccxml:node)
  ((gccxml:members
    :initform #()
    :type flexml:cross-referenced-nodes
    :accessor gccxml:members-of)))

(defclass gccxml:definition (gccxml:node-with-name)
  ())

(defclass gccxml:externable-node (gccxml:definition)
  ((gccxml:extern
    :type boolean
    :accessor gccxml:extern?)))

(macrolet ((define (&body entries)
             `(progn
                ,@(iter (for entry :in entries)
                        (destructuring-bind (name &optional (supers '(gccxml:node)) &body slots)
                            (ensure-list entry)
                          (collect `(defclass ,name ,supers
                                      (,@slots))))))))
  (define
   gccxml:gcc_xml
   (gccxml:namespace (gccxml:node-with-name gccxml:node-with-type gccxml:node-with-members))
   (gccxml:variable (gccxml:externable-node gccxml:node-with-type))
   (gccxml:function (gccxml:externable-node)
    (gccxml:returns
     :type flexml:cross-referenced-node
     :accessor gccxml:returns-of))
   (gccxml:argument (gccxml:node-with-name gccxml:node-with-type))
   gccxml:ellipsis
   (gccxml:enumeration (gccxml:definition))
   (gccxml:enumvalue (gccxml:node-with-name))
   (gccxml:struct (gccxml:definition gccxml:node-with-members)
    (gccxml:incomplete
     :initform nil
     :type boolean
     :accessor gccxml:incomplete?))
   (gccxml:class (gccxml:definition gccxml:node-with-members)
    (gccxml:incomplete
     :initform nil
     :type boolean
     :accessor gccxml:incomplete?))
   (gccxml:union (gccxml:definition gccxml:node-with-members))
   (gccxml:typedef (gccxml:definition gccxml:node-with-type))
   (gccxml:fundamentaltype (gccxml:node-with-name))
   (gccxml:pointertype (gccxml:node-with-type))
   gccxml:offsettype
   (gccxml:arraytype (gccxml:node-with-type))
   (gccxml:functiontype (gccxml:definition)
    (gccxml:returns :type flexml:cross-referenced-node))
   (gccxml:cvqualifiedtype (gccxml:node-with-type)
    (gccxml:const :type boolean :accessor gccxml:const?))
   (gccxml:referencetype (gccxml:node-with-type))
   (gccxml:field (gccxml:node-with-name gccxml:node-with-type)
    (gccxml:bits
     :initform nil
     :type (or null integer)
     :accessor gccxml:bits-of)
    (gccxml:offset
     :type integer
     :accessor gccxml:offset-of))
   (gccxml:constructor (gccxml:node-with-name))
   gccxml:destructor
   gccxml:converter
   (gccxml:operatorfunction (gccxml:function))
   (gccxml:operatormethod (gccxml:function))
   gccxml:base
   (gccxml:method (gccxml:function))
   (gccxml:file (gccxml:node-with-name))
   (gccxml:macro (gccxml:definition)
    (gccxml:name
     :accessor gccxml:name-of)
    (gccxml:arguments
     :initform nil
     :accessor gccxml:arguments-of)
    (gccxml:body
     :accessor gccxml:body-of)
    (gccxml:raw-body
     :accessor gccxml:raw-body-of))))

;;; expansion of:
#+nil
(def print-object (gccxml:node-with-name :identity (null (name-of self)))
    (write-string (or (name-of self)
                      "<anonymous>")))

(defmethod print-object ((self gccxml:node-with-name) stream)
  (bind ((name (name-of self)))
    (print-unreadable-object (self stream :type t :identity (null name))
      (let ((*standard-output* stream))
        (handler-bind
            ((error (lambda (error)
                      (declare (ignore error))
                      (write-string "<<error printing object>>")
                      (return-from print-object))))
          (write-string (or (name-of self)
                            "<anonymous>")))))))

(defun parse-gccxml-output (gccxml-file &optional macros-file)
  (bind ((*parser* (make-gccxml-parser)))
    (cxml:parse gccxml-file *parser*)
    (when macros-file
      (parse-macro-definitions macros-file))
    *parser*))

(defun parse-macro-definitions (macros-file)
  (iter (with current-file = nil)
        (for line :in-file macros-file :using #'read-line)
        (for macro = (cl-ppcre:split " " line :limit 3))
        (for (operator name body) = macro)
        (flet ((fail ()
                 (warn "Failed to parse macro definition ~S" macro)
                 (next-iteration)))
          (when (starts-with #\# operator :test #'char=)
            (eswitch (operator :test #'equal)
              ("#"
               (setf body (bind ((*read-eval* nil))
                            (read-from-string body)))
               (unless (equal body "<command-line>")
                 (bind ((file-node (find-node-by-name body 'gccxml:file *parser*
                                                      :otherwise body)))
                   (setf body file-node)
                   (setf current-file file-node))))
              ("#define"
               (bind ((macro-registry (macro-name->macro-node-of *parser*))
                      (macro-node (make-instance 'gccxml:macro)))
                 (when-bind open-brace-index (position #\( name :test #'equal)
                   (unless (equal #\) (elt name (1- (length name))))
                     (fail))
                   (setf (arguments-of macro-node) (cl-ppcre:split ","
                                                                   (subseq name
                                                                           (1+ open-brace-index)
                                                                           (1- (length name)))))
                   (setf name (subseq name 0 open-brace-index)))
                 (setf (name-of macro-node) name)
                 (setf (file-of macro-node) current-file)
                 (setf (raw-body-of macro-node) body)
                 (bind ((old-definition (gethash name macro-registry)))
                   (when (and old-definition 
                              (not (equal (raw-body-of old-definition) body)))
                     (warn "Redefining macro ~S" name)))
                 (setf (gethash name macro-registry) macro-node)))
              ("#include"
               (values))
              ("#include_next"
               (values))
              ("#pragma"
               (values))
              ("#undef"
               (remhash name (macro-name->macro-node-of *parser*))
               (values)))))))

(defmethod body-of :around ((node gccxml:macro))
  (if (slot-boundp node 'gccxml:body)
      (call-next-method)
      (setf (body-of node) (block parsing
                             ;; be friendly for debugging and use a HANDLER-BIND to keep the call stack intact
                             (handler-bind
                                 ((serious-condition
                                   (lambda (error)
                                     (break "Macro parse error: ~A" error)
                                     (warn "Error while processing the body of the macro ~A: ~A"
                                           node error)
                                     (return-from parsing nil))))
                               (c-literal-to-lisp-literal (raw-body-of node)))))))

;;; KLUDGE this is something incredibly lame and only meant to be a temporary solution.
;;; it should be replaced by a simple c evaluator.
(defun c-literal-to-lisp-literal (str)
  (when (zerop (length str))
    (return-from c-literal-to-lisp-literal))
  (flet ((fail ()
           (error "Don't know how to process C literal ~S" str))
         (remove-trailing-size-specifiers (str)
           (iter (for length = (length str))
                 (for last-char = (elt str (1- length)))
                 (while (member last-char '(#\F #\L #\l #\u) :test #'char=))
                 (setf str (subseq str 0 (1- length))))
           str))
    (cond
      ((and (starts-with #\( str)
            (ends-with #\) str))
       (c-literal-to-lisp-literal (subseq str 1 (1- (length str)))))
      ((and (starts-with #\" str)
            (ends-with #\" str))
       (subseq str 1 (1- (length str))))
      ((search "<<" str)
       (bind ((pieces (cl-ppcre:split "<<" str)))
         (unless (= (length pieces) 2)
           (fail))
         (bind ((base (parse-integer (first pieces) :junk-allowed t))
                (power (parse-integer (second pieces) :junk-allowed t)))
           (unless (and base
                        power)
             (fail))
           (expt 2 power))))
      ((or (starts-with-subseq "0x" str)
           (starts-with-subseq "#x" str))
       (parse-number:parse-number (concatenate 'string "#x" (subseq (remove-trailing-size-specifiers str) 2 nil))))
      ((or (char= #\- (elt str 0))
           (digit-char-p (elt str 0)))
       (parse-number:parse-number (remove-trailing-size-specifiers str)))
      (t (values)))))

(defgeneric root-namespace-of (parser)
  (:method ((parser gccxml-parser))
    (bind ((name->namespace (gethash 'gccxml:namespace (type->name->node-of parser))))
      (aprog1
          (gethash "::" name->namespace)
        (unless it
          (error "No root namespace was found (a namespace node with the name \"::\")"))))))

(defun map-gccxml-nodes/depth-first (function)
  (%map-gccxml-nodes/depth-first (list (flexml:root-of *parser*)) function)
  (maphash (lambda (name macro)
             (declare (ignore name))
             (funcall function macro))
           (macro-name->macro-node-of *parser*)))

(defun %map-gccxml-nodes/depth-first (nodes function)
  (iter (for node :in-sequence nodes)
        (%map-gccxml-nodes/depth-first (flexml:children-of node) function)
        (funcall function node)))

(defun map-gccxml-nodes/breadth-first (function)
  (%map-gccxml-nodes/depth-first (list (flexml:root-of *parser*)) function)
  (maphash (lambda (name macro)
             (declare (ignore name))
             (funcall function macro))
           (macro-name->macro-node-of *parser*)))

(defun %map-gccxml-nodes/breadth-first (nodes function)
  (iter (for node :in-sequence nodes)
        (funcall function node))
  (iter (for node :in-sequence nodes)
        (%map-gccxml-nodes/depth-first node function)))

(defun map-gccxml-nodes (function)
  (map-gccxml-nodes/breadth-first function)
  (values))
