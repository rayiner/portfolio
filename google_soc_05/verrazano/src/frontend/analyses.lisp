(in-package :verrazano)

(defun anonymous? (node)
  (if (typep node 'gccxml:node-with-name)
      (bind ((name (name-of node)))
        (or (null name)
            (string= name "")
            (starts-with-subseq "._" name)))
      nil))

(defun the-void-type? (node)
  (and (typep node 'gccxml:fundamentaltype)
       (string= (name-of node) "void")))

(defun artificial? (node)
  (slot-value node 'gccxml:artificial))

