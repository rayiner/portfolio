; read.lisp
; Read s-expressions from streams and apply reader macros

(in-package "VITALISP")

(defun assign-character-list (vec list type)
  (iter (for char in list)
	(setf (aref vec (char-code char)) type)))

(defun assign-character-range (vec range type)
  (iter (for i from (char-code (first range)) to (char-code (second range)))
	(setf (aref vec i) type)))

(defun default-syntax-table ()
  (let ((vec (make-array 128 :initial-element :unknown))
	(whitespace-chars '(#\Tab #\Newline #\Return #\Space))
	(lo-alpha-range '(#\a #\z))
	(hi-alpha-range '(#\A #\Z))
	(num-range '(#\0 #\9))
	(sign-chars '(#\! #\& #\* #\+ #\- #\/ #\< #\= #\> #\? #\^ #\_ #\~))
	(macro-chars '(#\" #\# #\$ #\% #\' #\( #\) #\, #\@ #\[ #\] #\\ #\` 
		       #\{ #\}))
	(conn-chars '(#\. #\:))
	(comment-chars '(#\;))
	(escape-chars '(#\|)))
    (assign-character-list vec whitespace-chars :whitespace)
    (assign-character-range vec lo-alpha-range :alphabetic)
    (assign-character-range vec hi-alpha-range :alphabetic)
    (assign-character-range vec num-range :numeric)
    (assign-character-list vec sign-chars :sign)
    (assign-character-list vec macro-chars :macro)
    (assign-character-list vec conn-chars :connective)
    (assign-character-list vec comment-chars :comment)
    (assign-character-list vec escape-chars :escape)
    vec))

(defun print-default-syntax-table ()
  (let ((vec (default-syntax-table)))
    (iter (for i from 0 below 128)
	  (format t "~A ~A ~A~%" i (code-char i) (aref vec i)))))

(defun default-macro-table ()
  (let ((vec (make-array 128 :initial-element #'raise-undefined-macro-error)))
    (assign-character-list vec '(#\#) #'do-dispatch-expr)
    (assign-character-list vec '(#\") #'read-string-or-escaped-symbol)
    (assign-character-list vec '(#\|) #'read-string-or-escaped-symbol)
    (assign-character-list vec '(#\') #'read-quote-expr)
    (assign-character-list vec '(#\.) #'read-prefix-period-expr)
    (assign-character-list vec '(#\() #'read-list-expr)
    (assign-character-list vec '(#\\) #'read-function-value-expr)
    (assign-character-list vec '(#\$) #'read-call-expr)
    (assign-character-list vec '(#\%) #'read-partial-call-expr)
    (assign-character-list vec '(#\) #\] #\}) #'raise-unmatched-error)
    vec))

(defun default-dispatch-table ()
  (let ((vec (make-array 128 
			 :initial-element #'raise-undefined-dispatch-error)))
    vec))

(defun default-connective-table ()
  (let ((vec (make-array 128
			 :initial-element #'raise-undefined-connective-error)))
    (assign-character-list vec '(#\:) #'build-colon-expr)
    (assign-character-list vec '(#\.) #'build-period-expr)
    vec))

(defun char-type (char table)
  (aref table (char-code char)))

(defun char-fun (char table)
  (aref table (char-code char)))

(defun char-partner (char)
  (ecase char
    (#\( #\))
    (#\) #\()
    (#\[ #\])
    (#\] #\[)
    (#\{ #\})
    (#\} #\{)))

(defun connective-token? (state tok)
  (and (characterp tok)
       (eq (char-type tok (reader-syntax-table state)) :connective)))

(defun macro-token? (state tok)
  (and (characterp tok)
       (eq (char-type tok (reader-syntax-table state)) :macro)))

(defun escape-token? (state tok)
  (and (characterp tok)
       (eq (char-type tok (reader-syntax-table state)) :escape)))

(defun atom-token? (state tok)
  (declare (ignore state))
  (not (characterp tok)))

(defun convert-integer (tok)
  (labels ((accumulate-integer (i ll place)
	     (if (= i ll)
		 (* place (- (char-code (elt tok i)) 48))
		 (+ (* place (- (char-code (elt tok i)) 48))
		    (accumulate-integer (- i 1) ll (* place 10))))))
    (let* ((ll (if (member (elt tok 0) '(#\+ #\-)) 1 0))
	   (sign (if (char= (elt tok 0) #\-) -1 1)))
      (* sign (accumulate-integer (- (length tok) 1) ll 1)))))

(defun integer-token? (tok)
  (and (or (digit-char-p (aref tok 0))
	   (> (length tok) 1))
       (not (iter (for char in-vector tok)
		  (unless (or (digit-char-p char)
			      (and (first-time-p)
				   (member char '(#\+ #\-))))
		    (leave t))))))

(defun convert-token (tok)
  (cond
    ((integer-token? tok) (convert-integer tok))
    ((string= tok "t") t)
    ((string= tok "nil") nil)
    (t (intern tok))))

(defun get-token-from-stream (stream syntax-table)
  (labels ((accumulate-token (char tok)
	     (let ((keep-going? (and char
				     (ecase (char-type char syntax-table)
				       ((:alphabetic :numeric :sign) t)
				       ((:macro :whitespace) nil)
				       (:connective
					(and (char= char #\.)
					     (integer-token? tok)))))))
	       (if keep-going?
		   (accumulate-token (read-char stream nil)
				     (append-char! tok char))
		   (progn
		     (unread-char char stream)
		     (convert-token tok)))))
	   (ignore-comment (char)
	     (when char
	       (unless (member char '(#\Newline #\Return))
		 (ignore-comment (read-char stream nil))))))
    (let ((next-char (peek-char t stream nil)))
      (when next-char
	(ecase (char-type next-char syntax-table)
	  ((:alphabetic :sign :numeric)
	   (accumulate-token (read-char stream nil) (new-empty-string)))
	  ((:macro :connective :escape) (read-char stream nil))
	  (:comment 
	   (ignore-comment (read-char stream nil))
	   (get-token-from-stream stream syntax-table))
	  (:whitespace
	   (read-char stream nil)
	   (get-token-from-stream stream syntax-table)))))))

(defclass reader-state ()
  ((stream :initarg :stream :reader reader-stream)
   (syntax-table :initarg :syntax-table :reader reader-syntax-table)
   (macro-table :initarg :macro-table :reader reader-macro-table)
   (dispatch-table :initarg :dispatch-table :reader reader-dispatch-table)
   (connective-table :initarg :connective-table :reader reader-connective-table)
   (next-token :initarg :next-token :accessor reader-next-token)))

(defun new-reader-state (stream syntax macro dispatch connective)
  (make-instance 'reader-state
		 :stream stream
		 :syntax-table syntax
		 :macro-table macro
		 :dispatch-table dispatch
		 :connective-table connective
		 :next-token nil))

(defun get-token (state)
  (let ((curr-token (if (reader-next-token state)
			(reader-next-token state)
			(get-token-from-stream (reader-stream state)
					       (reader-syntax-table state)))))
    (setf (reader-next-token state) nil)
    curr-token))

(defun peek-token (state)
  (if (reader-next-token state)
      (reader-next-token state)
      (setf (reader-next-token state)
	    (get-token-from-stream (reader-stream state)
				   (reader-syntax-table state)))))

(defun print-tokenized-string (str)
  (let ((state (new-reader-state (make-string-input-stream str)
				 (default-syntax-table)
				 (default-macro-table)
				 (default-dispatch-table)
				 (default-connective-table))))
    (labels ((print-next-token (tok)
	       (when tok
		 (format t "|~A| " tok)
		 (print-next-token (get-token state)))))
      (print-next-token (get-token state)))))

(defun raise-unmatched-error (state char)
  (declare (ignore state))
  (error (format nil "Unmatched ~A" (char-partner char))))

(defun raise-undefined-macro-error (state char)
  (declare (ignore state))
  (error (format nil "Undefined macro character ~A" char)))

(defun raise-undefined-dispatch-error (state char)
  (declare (ignore state))
  (error (format nil "Undefined dispatch character ~A" char)))

(defun raise-undefined-connective-error (state char)
  (declare (ignore state))
  (error (format nil "Undefined connective character ~A" char)))

(defun do-dispatch-expr (state tok)
  (declare (ignore tok))
  (let ((ntok (get-token state)))
    (funcall (char-fun ntok (reader-dispatch-table state)) state ntok)))

(defun read-string-or-escaped-symbol (state tok)
  (let ((stream (reader-stream state))
	(str (new-empty-string)))
    (labels ((accumulate-string (char str)
	       (unless char (error "Premature end of stream"))
	       (if (char= char tok)
		   (ecase tok
		     (#\" str)
		     (#\| (intern str)))
		   (accumulate-string (read-char stream nil)
				      (append-char! str char)))))
      (accumulate-string (read-char stream nil) str))))

(defun read-quote-expr (state tok)
  (declare (ignore tok))
  (list '|quote| (read-expr state)))

(defun read-prefix-period-expr (state tok)
  (declare (ignore tok))
  (list (read-expr state)))

(defun read-list-expr (state tok)
  (labels ((accumulate-list (ntok)
	     (cond
	       ((not ntok) (error "Premature end of stream"))
	       ((and (macro-token? state ntok)
		     (char= ntok (char-partner tok)))
	       (get-token state)
		nil)
	       (t (cons (read-expr state)
			(accumulate-list (peek-token state)))))))
    (accumulate-list (peek-token state))))

(defun read-function-value-expr (state tok)
  (declare (ignore tok))
  (list-prepend '|function-value| (read-expr state)))

(defun read-call-expr (state tok)
  (declare (ignore tok))
  (list-prepend '|call| (read-expr state)))

(defun read-partial-call-expr (state tok)
  (declare (ignore tok))
  (list-prepend '|partial-call| (read-expr state)))

(defun build-colon-expr (state tok rest)
  (list (build-conn-expr state tok (rest rest)) (cdar rest)))

(defun build-period-expr (state tok rest)
  (list (cdar rest) (build-conn-expr state tok (rest rest))))

(defun build-conn-expr (state tok rest)
  (if (not rest)
      tok
      (funcall (char-fun (caar rest) 
			 (reader-connective-table state)) 
	       state tok rest)))

(defun read-conn-expr (state)
  (let ((stack nil))
    (labels 
	((accumulate-list (tok)
	   (if (connective-token? state tok)
	       (progn
		 (get-token state)
		 (push (cons tok (read-exprp state)) stack)
		 (accumulate-list (peek-token state)))
	       stack)))
      (accumulate-list (peek-token state)))))

(defun read-demarc-expr (state tok)
  (funcall (char-fun tok (reader-macro-table state)) state tok))

(defun read-exprp (state)
  (let ((tok (get-token state)))
    (cond
      ((atom-token? state tok) tok)
      ((or (macro-token? state tok) 
	   (escape-token? state tok) 
	   (connective-token? state tok))
       (read-demarc-expr state tok))
      (t (error (format nil "Invalid syntax: ~A" tok))))))

(defun read-expr (state)
  (build-conn-expr state (read-exprp state) (read-conn-expr state)))

(defun read-all (stream)
  (let ((rs (new-reader-state stream
			      (default-syntax-table)
			      (default-macro-table)
			      (default-dispatch-table)
			      (default-connective-table))))
    (labels ((read-one-expr ()
	       (let ((expr (read-expr rs)))
		 (when expr (cons expr (read-one-expr))))))
      (read-one-expr))))

(defun read-string-all (str)
  (read-all (make-string-input-stream str)))

(defun vitalisp-read-file (fname)
  (with-open-file (filestream fname)
    (read-all filestream)))
