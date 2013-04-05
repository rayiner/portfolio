(defsystem "gc-log-analyzer"
	   :description "Analyzer for GC logs."
	   :version "0.0"
	   :author "Rayiner Hashem <rayiner@gmail.com>"
	   :license "Lisp LGPL"
	   :depends-on (:iterate)
	   :components ((:file "package")
	   	        (:file "analyzer-base"))
	   :serial t)
