(in-package :verrazano)

(defun generate-binding (backend &key keep-temporary-files)
  "This is the primary entry point, given a CONFIGURATION generate a binding using BACKEND."
  (bind ((*backend* (make-backend backend))
         (*default-pathname-defaults* (working-directory-of *backend*))
         (*unique-name-counter* 0))
    (let ((c-file (temporary-filename-for "vzntemp.cpp"))
          (xml-file (temporary-filename-for "vzntemp.xml"))
          (macro-file (temporary-filename-for "vzntemp.mac")))
      (unwind-protect
           (progn
             (with-open-file (out c-file :direction :output :if-exists :supersede)
               (dolist (inc (input-files-of *backend*))
                 (format out "#include \"~A\"~%" inc))
               (format out "const int __verrazano_binding = 1;"))
             (run-gccxml c-file xml-file macro-file)
             (bind ((*parser* (parse-gccxml-output xml-file macro-file))
                    (root-node (flexml:root-of *parser*)))
               (process-gccxml-node *backend* root-node)
               #+nil(break)))
        (unless keep-temporary-files
          (dolist (file (temporary-files-of *backend*))
            (ignore-errors
              (delete-file file))))))))

(defun run-gccxml (c-file xml-file &optional macro-file)
  (ensure-gccxml-is-installed)
  (bind ((xml-command (format nil "~A ~A -fxml=\"~A\" \"~A\""
                              (gccxml-path-of *backend*)
                              (gccxml-flags-of *backend*)
                              (namestring xml-file)
                              (namestring c-file))))
    (execute-shell-command xml-command)
    (when macro-file
      (bind ((macro-command (format nil "~A ~A --preprocess -dDI \"~A\"" 
                                    (gccxml-path-of *backend*)
                                    (gccxml-flags-of *backend*)
                                    (namestring c-file))))
        (execute-shell-command macro-command :output (namestring macro-file))))))

(defun ensure-gccxml-is-installed ()
  (let ((install-path (truename (system-relative-pathname :verrazano "../"))))
    (restart-case
        (let ((installed (block check
                           (execute-shell-command
                            (format nil "~A --version" (gccxml-path-of *backend*))
                            :error-handler (lambda (&rest args)
                                             (declare (ignore args))
                                             (return-from check nil)))
                           t)))
          (unless installed
            (error "Seems like gccxml is not installed, or it's not in the path")))
     (checkout-gccxml ()
       :report (lambda (stream)
                 (format stream "Check out gccxml from CVS into ~Agccxml." install-path))
       (format t "Starting cvs checkout, this may take a while without any feedback...")
       (execute-shell-command
        (format nil "cd \"~A\"; cvs -z6 -d :pserver:anoncvs@www.gccxml.org:/cvsroot/GCC_XML co gccxml"
                install-path))))))
