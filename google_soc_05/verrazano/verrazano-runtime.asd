
(asdf:defsystem :verrazano-runtime
  :author "Rayiner Hashem"
  :components
  ((:module "src"
    :components ((:module "runtime"
                  :components
                  ((:file "support"))))))
  :depends-on (:cffi))
