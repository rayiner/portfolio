; utilities.lisp
; Small utility routines used by the rest of the program

(in-package "VITAMIN")

(defun prefixsym (pfx s1 &optional package)
  (let ((str (concatenate 'string pfx (symbol-name s1))))
    (if package
	(intern str package)
	(intern str))))

(defun suffixsym (s1 sfx &optional package)
  (let ((str (concatenate 'string (symbol-name s1) sfx)))
    (if package
	(intern str package)
	(intern str))))

(defun catsym (&rest elements)
  (let* ((seq (iter (for elem in elements)
		   (typecase elem
		     (symbol (collect (symbol-name elem)))
		     (string (collect elem)))))
	 (str (apply #'concatenate 'string seq)))
    (intern str)))

(defun bounded-by? (value lower upper)
  (and (>= value lower) (<= value upper)))

(defun signed-width (value)
  (cond
    ((bounded-by? value -128 127) 1)
    ((bounded-by? value -32768 32767) 2)
    ((bounded-by? value -2147483648 2147483647) 4)
    ((bounded-by? value -9223372036854775808 9223372036854775807) 8)
    (t nil)))

(defmacro to-fixpoint (&body body)
  (let ((chg (gensym)))
    `(let ((,chg t))
       (flet ((mark-changed () (setf ,chg t)))
	 (tagbody
	    header
	    (setf ,chg nil)
	    ,@body
	    (if ,chg (go header)))))))

(defun extend-vector-with-vector (source dest)
  (iter (for elt in-vector source)
	(vector-push-extend elt dest)))

(defun print-codevector (cv)
  (iter (for byte in-vector cv)
	(format t "~2,'0X " byte))
  (format t "~%"))

(defun load-file-into-vector (file)
  (with-open-file (stream file :direction :input
			  :element-type 'unsigned-byte)
    (let ((out (make-array (file-length stream))))
      (read-sequence out stream)
      out)))

(defun stringify-list (list)
  (with-output-to-string (str)
    (iter (for elt in list)
	  (format str "~A " elt))))

(defun to-string (thing)
  (format nil "~A" thing))

(defun vector-to-list (vec)
  (map 'list #'identity vec))

(defun first-element (seq)
  (elt seq 0))

(defun last-element (seq)
  (elt seq (- (length seq) 1)))

(defun seq-first (seq)
  (first-element seq))

(defun seq-rest (seq)
  (subseq seq 1))

(defun new-stretchy-vector ()
  (make-array 0 :fill-pointer t))

(defun vector-push-unique (thing vec &key key)
  (unless (find thing vec :key key)
    (vector-push-extend thing vec)))

(defun print-hash-table (table)
  (iter (for (key val) in-hashtable table)
	(format t "~A ~A~%" key val)))

(defun new-counter (start)
  #'(lambda ()
      (let ((old start))
	(incf start)
	old)))

(defun empty? (seq)
  (= 0 (length seq)))

(defun table-values-to-vector (table)
  (iter (for (key value) in-hashtable table)
	(collect value result-type vector)))

(defun table-keys-to-vector (table)
  (iter (for (key value) in-hashtable table)
	(collect key result-type vector)))

(defun find-all (elt seq &key key test)
  (let ((key-fun (if key key #'identity))
	(test-fun (if test test #'eql)))
    (remove-if-not #'(lambda (a)
		       (funcall test-fun elt (funcall key-fun a)))
		   seq)))

(defun write-string-to-file (string name)
  (with-open-file (file name :direction :output :if-exists :supersede)
    (format file "~A" string)))

(defmacro while-loop (pred &body body)
  (let ((loophead (gensym))
	(exit (gensym)))
    `(tagbody 
	,loophead
	(unless ,pred (go ,exit))
	,@body
	(go ,loophead)
	,exit)))

(defmacro until-loop (pred &body body)
  `(while-loop (not ,pred) ,@body))

(defun vector-push-at (item index vec)
  (vector-push-extend item vec)
  (iter (for i from (- (length vec) 1) downto (+ index 1))
	(setf (aref vec i) (aref vec (- i 1))))
  (setf (aref vec index) item)
  index)

(defun vector-pop-at (index vec)
  (let ((item (aref vec index)))
    (iter (for i from index below (- (length vec) 1))
	  (setf (aref vec i) (aref vec (+ i 1))))
    (vector-pop vec)
    item))

(defun slice-apply (func seq key)
  (unless (empty? seq)
    (apply func (map 'list key seq))))
