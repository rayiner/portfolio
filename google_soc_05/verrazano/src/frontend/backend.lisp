(in-package :verrazano)

(defclass backend ()
  ((gccxml-path
    :initform "gccxml"
    :initarg :gccxml-path
    :accessor gccxml-path-of)
   (gccxml-flags
    :initform ""
    :initarg :gccxml-flags
    :accessor gccxml-flags-of)
   (input-files
    :initform '()
    :initarg :input-files
    :accessor input-files-of)
   (temporary-directory
    :initform (make-pathname :directory "/tmp")
    :initarg :temporary-directory
    :accessor temporary-directory-of)
   (working-directory
    :initform *default-pathname-defaults*
    :initarg :working-directory
    :accessor working-directory-of)
   ;; the stuff below are used while the generation is running
   (temporary-files
    :initform (list)
    :accessor temporary-files-of)))

(defclass simple-backend (backend)
  ((definitions-to-output
    :initform (make-hash-table :test #'eq)
    :accessor definitions-to-output-of)
   (already-processed
    :initform (make-hash-table :test #'equal)
    :accessor already-processed-of)
   (currently-being-processed
    :initform (list)
    :accessor currently-being-processed-of)
   (gccxml-node-types-to-output
    :initarg :gccxml-node-types-to-output
    :accessor gccxml-node-types-to-output-of
    :documentation "List of gccxml node types that are to be considered for output")
   (filter-definitions-from-indirect-files
    :initform t
    :initarg :filter-definitions-from-indirect-files
    :accessor filter-definitions-from-indirect-files-p)
   (name-filter
    :initform 'standard-name-filter
    :type (or (function (string)) symbol)
    :initarg :name-filter
    :accessor name-filter-of
    :documentation "This predicate can filter out definitions from the output based on their name.")
   (node-filter
    :initform (lambda (node)
                (declare (ignore node))
                t)
    :type (or (function (gccxml:node)) symbol)
    :initarg :node-filter
    :accessor node-filter-of
    :documentation "This predicate can filter out gccxml nodes.")
   (export-filter
    :initform 'standard-export-filter
    :type (or (function (string)) symbol)
    :initarg :export-filter
    :accessor export-filter-of
    :documentation "This predicate can filter out symbols from the export list.")
   (name-transformer
    :initform 'standard-name-transformer
    :type (or (function (string symbol)) symbol)
    :initarg :name-transformer
    :accessor name-transformer-of)
   (standard-name-transformer-replacements
    :initform nil
    :initarg :standard-name-transformer-replacements
    :accessor standard-name-transformer-replacements-of)))

(defun transform-name (name kind)
  (funcall (name-transformer-of *backend*) name kind))

(defun temporary-filename-for (file-name)
  (aprog1
      (merge-pathnames (concatenate 'string
                                    (princ-to-string
                                     (mod (get-internal-run-time) 1000))
                                    file-name)
                       (temporary-directory-of *backend*))
    (push it (temporary-files-of *backend*))))

(defmethod process-gccxml-node (backend node)
  (values))

(defmethod process-gccxml-node :around ((backend simple-backend) node)
  (bind ((already-processed (already-processed-of backend)))
    (unless (gethash (list backend node) already-processed)
      (setf (gethash (list backend node) already-processed) t)
      (call-next-method))))

(defmethod process-gccxml-node ((backend simple-backend) (node gccxml:gcc_xml))
  (iter (for child :in-vector (flexml:children-of node))
        (when (or (not (filter-definitions-from-indirect-files-p backend))
                  (gethash (file-of child) (input-files-of *parser*)))
          (process-gccxml-node backend child))))

(defmethod process-gccxml-node :around ((backend simple-backend) (node gccxml:node-with-name))
  (bind ((name (gccxml:name-of node)))
    (when (funcall (name-filter-of backend) name)
      (call-next-method))))
