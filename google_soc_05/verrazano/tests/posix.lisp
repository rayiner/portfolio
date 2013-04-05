;; This is a string that we will test for, do not change it!
(require :asdf)

(asdf:operate 'asdf:load-op :cffi)

;;(cffi:load-foreign-library "libc.so")

(load (merge-pathnames "example-bindings/posix-cffi-bindings.lisp"
                       (asdf:component-pathname (asdf:find-system :verrazano))))

(defpackage :posix-test
  (:use :common-lisp :asdf))

(in-package :posix-test)

(defun test ()
  (let* ((target-string ";; This is a string that we will test for, do not change it!")
         (file (posix:open (namestring
                            (merge-pathnames "../testsuite/posix.lisp"
                                             (asdf:component-pathname (asdf:find-system :verrazano))))
                           posix:O_RDONLY))
         (buffer (make-array (length target-string) :element-type '(unsigned-byte 8))))
    (unwind-protect
         (cffi:with-pointer-to-vector-data (c-buffer buffer)
           (posix:read file c-buffer (length buffer))
           (string= (with-output-to-string (str)
                      (loop for char-code :across buffer
                            do (write-char (code-char char-code) str)))
                    target-string))
      (posix:close file))))

(if (test)
    (format t "Posix test was successful")
    (warn "Posix test was failed"))

(in-package :cl-user)
(quit)
