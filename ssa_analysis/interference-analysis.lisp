; interference-analysis.lisp
; Construction of interference graphs

(in-package "VITAMIN")

; roygbiv
; red orange yellow green blue indigo violet brown

(defparameter *graphviz-colors* '(indianred orangered yellow green violet
				  cyan indigo blueviolet violetred
				  sandybrown saddlebrown gray64 orangered
				  yellow4 darkolivegreen cornflowerblue))

(defun initialize-interference-sets (proc)
  (setf (fproc-intg proc) (new-object-graph (proc-names proc))))

(defun maybe-note-interference (def temp ins intg)
  (unless (or (eql def temp)
	      (and (transfer? ins)
		   (eql def (source-of-copy ins))))
    (gra-add-edge def temp intg)))

(defun map-over-livenow-sets (func block)
  (let ((livenow (clone-bit-set (fblock-liveout block))))
    (iter (for ins in-olist (bb-insns block) way 'backward)
	  (funcall func ins livenow)
	  (iter (for def in-olist (ins-defs ins))
		(bs-rem def livenow))
	  (unless (phi? ins)
	    (iter (for use in-olist (ins-uses ins) pred #'temporary?)
		  (bs-add use livenow))))))

(defun prepare-interference-graph (intg proc)
  (iter (for bb in-univ (proc-bbs proc))
	(iter (for ins in-olist (bb-insns bb))
	      (iter (for def in-olist (ins-defs ins))
		    (gra-add-node def intg))
	      (iter (for use in-olist (ins-uses ins) pred #'temporary?)
		    (gra-add-node use intg)))))

(defun note-interferences-in-block (proc block)
  (let ((intg (fproc-intg proc)))
    (prepare-interference-graph intg proc)
    (map-over-livenow-sets #'(lambda (ins livenow)
			       (iter (for def in-olist (ins-defs ins))
				     (iter (for temp in-oset livenow)
					   (maybe-note-interference def temp
								    ins intg))))
			   block)))

(defun analyze-interference (proc)
  (ensure-analyses-valid '(:liveout :livein) proc)
  (initialize-interference-sets proc)
  (iter (for bb in-univ (proc-bbs proc))
	(note-interferences-in-block proc bb)))

(defun dotify-temp-name (temp)
  (substitute #\_ #\. (symbol-name (temp-name temp))))

(defun dotify-intg (proc)
  (ensure-analyses-valid '(:intg) proc)
  (format nil "graph INTG {~%~A }"
	  (let ((seen (new-object-graph (proc-names proc)))
		(intg (fproc-intg proc)))
	    (with-output-to-string (str)
	      (iter (for node in-gra-nodes intg)
		    (if (spilled-temporary? (mtemp-reg node))
			(format str "~A [color=white,style=filled];~%"
				(temp-name node))
			(format str "~A [color=~A,style=filled];~%"
				(temp-name node)
				(nth (universe-member-index (mtemp-reg node)
							    (mproc-regs proc))
				     *graphviz-colors*))))
	      (iter (for lname in-gra-nodes intg)
		    (iter (for rname in-gra-nodes intg)
			  (gra-add-node lname seen)
			  (gra-add-node rname seen)
			  (when (and (not (eq lname rname))
				     (not (gra-edge-member? lname rname seen))
				     (gra-edge-member? lname rname intg))
			    (gra-add-edge lname rname seen)
			    (format str "~A -- ~A;~%"
				    (dotify-temp-name lname)
				    (dotify-temp-name rname)))))))))

(defun stringify-instruction (ins)
  (pretty-print-source-line (unconvert-instruction ins) nil))

(defun stringify-livenow-set (livenow)
  (with-output-to-string (str)
    (iter (for temp in-oset livenow)
	  (format str "~A " (temp-name temp)))))

(defun stringify-livenow-block (bb str)
  (let ((list))
    (map-over-livenow-sets #'(lambda (ins livenow)
			       (push (list (stringify-instruction ins)
					   (stringify-livenow-set livenow))
				     list)) 
			   bb)
    (let ((max-line (apply #'max (mapcar #'(lambda (item)
					     (length (first item))) list))))
      (iter (for item in list)
	    (format str "~VA    | ~A~%" max-line
		    (first item) (second item))))))
	  
(defun stringify-livenow-sets (proc)
  (ensure-analyses-valid '(:intg) proc)
  (with-output-to-string (str)
    (iter (for bb in-univ (proc-bbs proc))
	  (format str "~A:~%" (bb-label bb))
	  (stringify-livenow-block bb str)
	  (format str "~%"))))

(register-demand-analysis #'analyze-interference '(:liveout :livein) '(:intg))
