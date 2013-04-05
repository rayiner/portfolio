; source-form.lisp
; Contains routines for manipulating VIS programs in source form

(in-package "VITAMIN")

(defun reg-name? (name)
  (symbolp name))

(defun immediate? (val)
  (or (integerp val)
      (realp val)))

(defun label? (line)
  (symbolp line))

(defun statement-form? (line)
  (and (listp line)
       (notany #'listp line)))

(defun assignment-form? (line)
  (and (listp line)
       (= (length line) 2)
       (symbolp (first line))
       (listp (second line))))

(defun extract-operation (line)
  (cond
    ((assignment-form? line) (first (second line)))
    ((statement-form? line) (first line))))

(defun extract-operands (line)
  (cond
    ((assignment-form? line) (rest (second line)))
    ((statement-form? line) (rest line))))

(defun extract-br-label (line)
  (first (extract-operands line)))

(defun extract-brc-condition (line)
  (second line))

(defun extract-brc-operands (line)
  (subseq line 2 4))

(defun extract-brc-labels (line)
  (subseq line 4 6))

(defun extract-brt-condition (line)
  (second line))

(defun extract-brt-operands (line)
  (subseq line 2 3))

(defun extract-brt-labels (line)
  (subseq line 3 5))

(defun extract-bri-temporary (line)
  (second line))

(defun extract-bri-labels (line)
  (subseq line 2))

(defun extract-call-label (line)
  (first (extract-operands line)))

(defun extract-call-operands (line)
  (subseq (extract-operands line) 1))

(defun extract-result (line)
  (when (assignment-form? line)
    (first line)))

(defun extract-name-table (source)
  (first source))

(defun extract-entry-name (entry)
  (first entry))

(defun extract-entry-type (entry)
  (second entry))

(defun extract-body (source)
  (rest source))

(defun pretty-print-label (tag str)
  (format str "~A:" (string-downcase (symbol-name tag))))

(defun pretty-print-statement-form (line str)
  (format str "~A" (string-downcase (stringify-list line))))

(defun pretty-print-assignment-form (line str)
  (format str "~A <= ~A" (string-downcase (symbol-name (first line)))
	  (string-downcase (stringify-list (second line)))))

(defun pretty-print-source-line (line str)
  (cond
    ((label? line) (pretty-print-label line str))
    ((statement-form? line) (pretty-print-statement-form line str))
    ((assignment-form? line) (pretty-print-assignment-form line str))))

(defun pretty-print-source (src)
  (with-output-to-string (str)
    (iter (for line in (extract-body src))
	  (pretty-print-source-line line str)
	  (format str "~%"))))
