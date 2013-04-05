(in-package :verrazano)

(defun standard-name-filter (name)
  (or (null name)
      (zerop (length name))
      (not (starts-with-dash-p name))))

(defun standard-export-filter (name)
  (or (null name)
      (zerop (length name))
      (not (starts-with-dash-p name))))

(deftype name-kind ()
  `(member :function :variable :type :enum :enum-value :struct :class :union :field :constant))

(defun %standard-name-transformer (input)
  (setf input (copy-seq input))
  (iter (for (pattern replacement)
          :on (standard-name-transformer-replacements-of *backend*)
          :by #'cddr)
        (setf input (cl-ppcre:regex-replace pattern input replacement)))
  (camel-case-to-hyphened (dashes-to-hyphens input)))

(defun standard-name-transformer (input kind)
  (declare (type name-kind kind))
  (case kind
    (:constant
     (concatenate 'string "+" (%standard-name-transformer input) "+"))
    (t
     (%standard-name-transformer input))))

(defun starts-with-dash-p (name)
  (equal (elt (string name) 0) #\_))

(defun dashes-to-hyphens (input)
  "Replaces _ with - except at the very beginning."
  (if (> (length input) 0)
      (substitute #\- #\_ input :start 1)
      input))

#+nil
(defun camel-case-to-hyphened (input)
  (if (> (length input) 0)
      (string-downcase
       (with-output-to-string (*standard-output*)
         (iter (with in-uppercase? = (upper-case-p (elt input 0)))
               (for run-length :upfrom 0)
               (for hyphen-distance :upfrom 0)
               (for char :in-vector input)
               (for previous-char :previous char :initially #\ )
               (let ((new-in-uppercase? (if (alpha-char-p char)
                                            (upper-case-p char)
                                            (if (alpha-char-p previous-char)
                                                (not in-uppercase?)
                                                in-uppercase?))))
                 (unless (eq in-uppercase? new-in-uppercase?)
                   ;;(break "~A ~A ~A ~A" previous-char char run-length hyphen-distance)
                   (when (and (alphanumericp char)
                              (alphanumericp previous-char)
                              (or (> run-length 1)
                                  (> hyphen-distance 1)))
                     (write-char #\-)
                     (setf hyphen-distance 0))
                   (setf run-length 0)
                   (setf in-uppercase? new-in-uppercase?)))
               (write-char char))))
      input))

;;; XMLMessage -> xml-message
;;; getXML -> get-xml
;;; cMessage -> c-message
(defun camel-case-to-hyphened (input)
  "Insert a hyphen before each subsequent uppercase, lowercase alphanumeric characters"
  (if (> (length input) 0)
      (string-downcase
       (with-output-to-string (*standard-output*)
         (bind (last-char)
           (flet ((local-write-char (char)
                    (unless (and last-char
                                 (char= #\- char)
                                 (char= #\- last-char))
                      (write-char char)
                      (setf last-char char))))
             (iter (for i :upfrom 0)
                   (for char :in-vector input)
                   (for p-char :previous char :initially #\ )
                   ;; transition from uppercase to lowercase
                   (when (and (> i 1)
                              (alpha-char-p p-char)
                              (alpha-char-p char)
                              (upper-case-p p-char)
                              (lower-case-p char))
                     (local-write-char #\-))
                   (unless (zerop i)
                     (local-write-char p-char))
                   ;; transition from alphanumeric to non-alphanumeric
                   ;; transition from lowercase to uppercase
                   (when (or (and (alpha-char-p p-char)
                                  (not (alpha-char-p char))
                                  (not (char= char #\_)))
                             (and (alpha-char-p p-char)
                                  (alpha-char-p char)
                                  (lower-case-p p-char)
                                  (upper-case-p char)))
                     (local-write-char #\-))
                   (finally (local-write-char char)))))))
      input))
