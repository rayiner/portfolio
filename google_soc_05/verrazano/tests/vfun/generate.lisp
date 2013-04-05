(in-package :cl-user)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :asdf))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:operate 'asdf:load-op :verrazano))

(in-package :verrazano-user)

(generate-binding
 (make-configuration :vfun-cffi-bindings
                     '("vfun.h")
                     :working-directory (verrazano::system-relative-pathname
                                         :verrazano "../testsuite/vfun/")
                     :gccxml-flags "-I.")
 :cffi)

(in-package :cl-user)
(quit)
