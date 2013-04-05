; encode.lisp
; Encode in-memory representation of bytecode to on-disk representation

(in-package "VITALISP")

(defconstant +type-id-proc+ 0)
(defconstant +type-id-var+ 1)

(defconstant +type-tag-fixnum+ 0)
(defconstant +type-tag-closure+ 1)
(defconstant +type-tag-single-float+ 2)
(defconstant +type-tag-small-string+ 3)
(defconstant +type-tag-canonical-true+ 4)
(defconstant +type-tag-empty-list+ 5)

(defun emit-byte (b v)
  (vector-push-extend b v))

(defun emit-2b (w v)
  (emit-byte (logand #xFF w) v)
  (emit-byte (logand #xFF (ash w -8)) v))

(defun emit-4b (h v)
  (emit-byte (logand #xFF h) v)
  (emit-byte (logand #xFF (ash h -8)) v)
  (emit-byte (logand #xFF (ash h -16)) v)
  (emit-byte (logand #xFF (ash h -24)) v))

(defun emit-8b (w v)
  (emit-byte (logand #xFF w) v)
  (emit-byte (logand #xFF (ash w -8)) v)
  (emit-byte (logand #xFF (ash w -16)) v)
  (emit-byte (logand #xFF (ash w -24)) v)
  (emit-byte (logand #xFF (ash w -32)) v)
  (emit-byte (logand #xFF (ash w -40)) v)
  (emit-byte (logand #xFF (ash w -48)) v)
  (emit-byte (logand #xFF (ash w -56)) v))

(defun emit-Nb (n v)
  (labels ((emit-7b (n l)
	     (let ((nx (ash n -7)))
	       (if (> nx 0)
		   (progn (emit-byte (logior #x80 (logand #x7F n)) v)
			  (emit-7b nx (+ l 1)))
		   (progn (emit-byte (logand #x7F n) v) l)))))
    (emit-7b n 1)))

(defun emit-string (str v)
  (map nil #'(lambda (c) (emit-byte (char-code c) v)) str)
  (emit-byte 0 v))

(defun emit-byte-vector (bv v)
  (map nil #'(lambda (b) (emit-byte b v)) bv))

(defun emit-bytecode (elts file)
  (let ((out-vec (new-stretchy-vector)))
    (map nil #'(lambda (elt) (emit-element elt out-vec)) elts)
    (store-vector-into-file out-vec file)
    file))

; Format of element:
;   - Null-terminated ASCII string denoting name.
;   - 1 number denoting element type.
;   ... element-specific data ...
(defun emit-element (elt out-vec)
  (emit-string (be-name elt) out-vec)
  (typecase elt
    (bytecode-procedure (emit-procedure elt out-vec))))

; Format of procedure element:
;   - 1 number denoting length of constant vector in bytes.
;   - 1 number denoting length of reference vector in bytes.
;   - 1 number denoting length of code vector in bytes.
;   - 1 number denoting number of registers used by the bytecode.
;   ... constant vector ...
;      + each constant vector entry is a 64-bit literal constant.
;   ... reference vector ...
;      + each reference vector entry is a null-terminated string.
;   ... code vector ...
(defun emit-procedure (proc out-vec)
  (emit-Nb +type-id-proc+ out-vec)
  (let ((csv (encode-constant-vector (bp-const-vec proc)))
	(rv (encode-reference-vector (bp-ref-vec proc)))
	(cv (encode-code-vector (bp-code-vec proc))))
    (emit-Nb (length csv) out-vec)
    (emit-Nb (length rv) out-vec)
    (emit-Nb (length cv) out-vec)
    (emit-Nb (+ 1 (bp-temp-count proc)) out-vec)
    (emit-byte-vector csv out-vec)
    (emit-byte-vector rv out-vec)
    (emit-byte-vector cv out-vec)))

(defun encode-constant-vector (csv)
  (let ((temp-vec (new-stretchy-vector)))
    (map nil
	 #'(lambda (const)
	     (let ((obj (cond
			  ((integerp const) (encode-fixnum const))
			  ((stringp const) (encode-string const))
			  ((eq const t) (encode-true))
			  ((null const) (encode-nil)))))
	       (emit-8b obj temp-vec)))
	 csv)
    temp-vec))

(defun encode-fixnum (val)
  (+ (ash val 16) +type-tag-fixnum+))

(defun encode-string (str)
  (let ((len (min (length str) 5)))
    (labels ((encode-char (idx)
	       (if (= idx len) 
		   (+ (ash len 16) +type-tag-small-string+)
		   (+ (ash (char-code (aref str idx)) (* (+ idx 3) 8))
		      (encode-char (+ idx 1))))))
      (encode-char 0))))

(defun encode-true () +type-tag-canonical-true+)

(defun encode-nil () +type-tag-empty-list+)

(defun encode-reference-vector (rv)
  (let ((temp-vec (new-stretchy-vector)))
    (map nil
	 #'(lambda (ref)
	     (emit-string ref temp-vec))
	 rv)
    temp-vec))

(defun encode-code-vector (cv)
  (let ((temp-vec (new-stretchy-vector))
	(lab-table (make-hash-table)))
    (labels ((encode-num (idx disp)
	       (when (>= idx 0)
		 (let ((num (aref cv idx)))
		   (if (symbolp num)
		       (progn
			 (if (gethash num lab-table)
			     (emit-Nb (- disp (gethash num lab-table)) temp-vec)
			     (setf (gethash num lab-table) disp))
			 (encode-num (- idx 1) disp))
		       (encode-num (- idx 1)
				   (+ disp (emit-Nb num temp-vec))))))))
      (encode-num (- (length cv) 1) 0)
      (reverse temp-vec))))
