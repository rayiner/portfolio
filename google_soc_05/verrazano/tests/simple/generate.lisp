(require 'asdf)
(asdf:operate 'asdf:load-op 'verrazano)

(verrazano:create-binding 
  (verrazano:setup-build "gccxml"
			 (make-pathname :device "/" :directory "/tmp"))
  "testsuite/simple/simple.binding"
  "testsuite/simple/simple-library.lisp"
  :cffi-backend
  t)
(quit)
