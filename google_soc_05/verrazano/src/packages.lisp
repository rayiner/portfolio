(in-package :cl-user)

(defpackage :gccxml
  (:export
   ;; classes that are "extensions" to gccxml
   #:node
   #:definition
   #:node-with-name
   #:node-with-type
   #:node-with-members
   #:externable-node

   ;; gccxml classes
   #:gcc_xml
   #:namespace
   #:variable
   #:function
   #:argument
   #:ellipsis
   #:enumeration
   #:enumvalue
   #:struct
   #:class
   #:union
   #:typedef
   #:fundamentaltype
   #:pointertype
   #:offsettype
   #:arraytype
   #:functiontype
   #:cvqualifiedtype
   #:referencetype
   #:field
   #:constructor
   #:destructor
   #:converter
   #:file
   #:macro
   #:operatorfunction
   #:operatormethod
   #:base
   #:method

   ;; slots
   #:name
   #:name-of
   #:mangled
   #:mangled-of
   #:members
   #:members-of
   #:type
   #:type-of
   #:const
   #:const?
   #:init
   #:returns
   #:returns-of
   #:file
   #:file-of
   #:line
   #:line-of
   #:extern
   #:extern?
   #:context
   #:context-of
   #:body
   #:body-of
   #:arguments
   #:arguments-of
   #:raw-body
   #:raw-body-of
   #:artificial
   #:artificial?
   #:min
   #:min-of
   #:max
   #:max-of
   #:incomplete
   #:incomplete?
   #:bits
   #:bits-of
   #:offset
   #:offset-of
   ))

(defpackage :verrazano
  (:use :common-lisp :parse-number :iterate :alexandria :metabang-bind)
  (:export #:generate-binding
           #:make-configuration
           #:camel-case-to-hyphened
           #:dashes-to-hyphens
           #:standard-name-transformer)
  (:shadowing-import-from :gccxml
   #:type-of))

(defpackage :verrazano-user
  (:use
   :common-lisp
   :verrazano
   :iterate
   :alexandria
   :metabang-bind
   :cffi
   ))

(in-package :verrazano)

;; import all the accessors from gccxml into the verrazano package
(eval-when (:load-toplevel :compile-toplevel :execute)
  (do-symbols (symbol (find-package :gccxml))
    (bind ((symbol-name (symbol-name symbol)))
      (when (or (ends-with #\? symbol-name)
                (ends-with-subseq "-OF" symbol-name))
        (import symbol :verrazano)))))
