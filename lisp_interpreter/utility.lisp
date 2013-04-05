; utility.lisp
; Utility routines used by compiler

(in-package "VITALISP")

(defun prefixsym (pfx s1 &optional package)
  (let ((str (concatenate 'string pfx (symbol-name s1))))
    (if package
	(intern str package)
	(intern str))))

(defun catsym (s1 s2)
  (intern (concatenate 'string (symbol-name s1) (symbol-name s2))))

(defun catsym- (s1 s2)
  (intern (concatenate 'string (symbol-name s1) "-" (symbol-name s2))))

(defun bounded-by? (value lower upper)
  (and (>= value lower) (<= value upper)))

(defun signed-width (value)
  (cond
    ((bounded-by? value -128 127) 1)
    ((bounded-by? value -32768 32767) 2)
    ((bounded-by? value -2147483648 2147483647) 4)
    ((bounded-by? value -9223372036854775808 9223372036854775807) 8)
    (t nil)))

(defun unsigned-width (value)
  (cond
    ((bounded-by? value 0 255) 1)
    ((bounded-by? value 0 65535) 2)
    ((bounded-by? value 0 4294967295) 4)
    ((bounded-by? value 0 18446744073709551615) 8)
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

(defun store-vector-into-file (vec file)
  (with-open-file (stream file 
			  :direction :output
			  :if-exists :supersede
			  :element-type 'unsigned-byte)
    (write-sequence vec stream)))

(defun asciify-string (str)
  (map 'vector #'char-code str))

(defun new-empty-string ()
  (make-array 8 :fill-pointer 0 :element-type 'character))

(defun append-char (str char)
  (concatenate 'string str (make-array 1 :element-type 'character 
				       :initial-element char)))

(defun append-char! (str char)
  (vector-push-extend char str)
  str)

(defun read-file (file)
  (with-open-file (file-stream file)
    (let ((lst nil))
      (labels ((read-some ()
		 (let ((stuff (read file-stream nil nil)))
		   (push stuff lst)
		   (when stuff (read-some)))))
	(read-some))
      lst)))

(defun new-stretchy-vector ()
  (make-array 0 :adjustable t :fill-pointer t))

(defun vector-prepend (thing vec)
  (vector-push-extend thing vec)
  (iter (for i from (- (length vec) 1) downto 1)
	(setf (aref vec i) (aref vec (- i 1))))
  (setf (aref vec 0) thing))

(defun list-except (list item)
  (set-difference list (list item)))

(defun list-prepend (item list)
  (if (consp list)
      (cons item list)
      (list item list)))

(defun flat-map (fun list)
  (when list
    (let ((res (funcall fun (first list))))
      (if (consp res)
	  (append res (flat-map fun (rest list)))
	  (cons res (flat-map fun (rest list)))))))

(defun map-constant (const list)
  (mapcar #'(lambda (arg) (declare (ignore arg)) const) list))

