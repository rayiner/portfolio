
(defsystem :verrazano
  :author "Rayiner Hashem"
  :depends-on (:cxml
               :metabang-bind
               :cffi
               :alexandria
               :iterate
               :trivial-shell
               :cl-ppcre
               :parse-number
               :closer-mop
               )
  :version "0.5"
  :components
  ((:module "src"
    :components ((:file "flexml") ;; TODO move it into a cxml plugin
                 (:static-file "generate-example-bindings.lisp")
                 (:file "packages")
                 (:module "frontend"
                  :depends-on ("packages" "flexml")
                  :serial t
                  :components ((:file "api")
                               (:file "utility")
                               (:file "parser")
                               (:file "analyses")
                               (:file "backend")
                               (:file "filters-and-transformers")
                               (:file "driver")))
                 (:module "cffi-backend"
                  :pathname "backends/cffi/"
                  :serial t
                  :components ((:file "cffi")
                               (:file "writers"))
                  :depends-on ("frontend"))))))
