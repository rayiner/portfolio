; testsuite.lisp
; The testsuite for the program

(in-package "VITAMIN")

(defparameter *src1* '(((a :h) (b :h) (i :h) (j :h) (zero :h))
		       l1
		       (zero (:ldi 0))
		       (:brc :!= a zero l2 l6)
		       l2
		       (a (:ldi 0))
		       (:brc :!= b zero l3 l4)
		       l3
		       (b (:ldi 0))
		       (:br l5)
		       l4		       
		       (b (:add i j))
		       (:br l5)
		       l5
		       (i (:ldi 0))
		       (:br l7)
		       l6
		       (a (:add i j))
		       (:br l7)
		       l7
		       (:ret a)))

; liveout example from Cooper & Torczon, page 442
(defparameter *src2* '(((i :h) (a :h) (b :h) (c :h) (d :h) (y :h) (z :h)
			(one :h) (hundred :h))
		       b0
		       (i (:ldi 1))
		       (:br b1)
		       b1
		       (a (:ldi 2))
		       (c (:ldi 3))
		       (:brc :!= a c b2 b3)
		       b2
		       (b (:ldi 4))
		       (c (:ldi 5))
		       (d (:ldi 6))
		       (:br b7)
		       b3
		       (a (:ldi 7))
		       (d (:ldi 8))
		       (:brc :!= a d b4 b5)
		       b4
		       (d (:ldi 9))
		       (:br b6)
		       b5
		       (c (:ldi 10))
		       (:br b6)
		       b6
		       (b (:ldi 11))
		       (:br b7)
		       b7
		       (hundred (:ldi 100))
		       (one (:ldi 1))
		       (y (:add a b))
		       (z (:add c d))
		       (i (:add i one))
		       (:brc :> i hundred b1 b8)
		       b8
		       (:ret)))

; dominator example from Cooper & Torczon, page 461
(defparameter *src3* '(((a :h) (b :h))
		       b1
		       (:br b2)
		       b2
		       (:brc :!= a b b1 b3)
		       b3
		       (:br b2)
		       b4
		       (:brc :!= a b b2 b3)
		       b5
		       (:br b1)
		       b6
		       (:brc :!= a b b5 b4)))

(defparameter *src4* '(((a0 :h) (a1 :h) (a2 :h) (a3 :h) (max :h) (one :h))
		       b1
		       (a0 (:ldi 0))
		       (max (:ldi 10))
		       (one (:ldi 1))
		       (:br b2)
		       b2
		       (a1 (:phi a0 a2))
		       (a2 (:add a1 one))
		       (:brc :> a2 max b3 b2)
		       b3
		       (a3 (:phi a2 a0))
		       (:ret a3)))

(defparameter *src5* '(((a :g) (b :h) (th :h) (c :s) (ts :s))
		       b1
		       (:brt :=h a b2 b3)
		       b2
		       (th (:ldi 1))
		       (b (:untag a))
		       (b (:add b th))
		       (a (:tag b))
		       (:br b5)
		       b3
		       (:brt :=s a b4 b5)
		       b4
		       (ts (:ldi 0.0))
		       (c (:untag a))
		       (c (:add c ts))
		       (a (:tag c))
		       (:br b5)
		       b5
		       (:ret a)))
(defparameter *src6* '(((a :h) (b :h) (c :h) (d :h) (e :h))
		       entry
		       (a (:ldi 2))
		       (b (:ldi 3))
		       (c (:ldi 4))
		       (d (:ldi 5))
		       (e (:ldi 6))
		       (:brc :!= a b is_same not_same)
		       is_same
		       (b (:cp a))
		       (d (:cp a))
		       (e (:cp b))
		       (:br exit)
		       not_same
		       (e (:cp b))
		       (b (:cp d))
		       (:br exit)
		       exit
		       (a (:add e c))
		       (:ret a)))

; single-block loop
(defparameter *src7* '(((a :h) (b :h))
		       entry
		       (a (:ldi 0))
		       (b (:ldi 1))
		       (:br loop)
		       loop
		       (a (:add a b))
		       (:brc :!= a b loop exit)
		       exit
		       (:ret a)))

; liveness test
(defparameter *src8* '(((a :h) (b :h) (c :h))
		       entry
		       (a (:ldi 0))
		       (b (:ldi 1))
		       (c (:add a b))
		       (a (:add b c))
		       (b (:ldi 2))
		       (c (:ldi 3))
		       (a (:add a b))
		       (:br exit)
		       exit
		       (:ret)))

; sreedhar out-of-ssa example (Figure 3)
(defparameter *src9* '(((y :h) (x1 :h) (x2 :h) (x3 :h) (z :h) (a :h))
		       l1
		       (a (:ldi 0))
		       (y (:ldi 0))
		       (x1 (:ldi 0))
     		       (:brc :!= a a l3 l2)
		       l2
		       (:br l3)
		       l3
		       (x3 (:phi x1 y))
		       (z (:cp x3))
		       (:ret)))

; sreedhar out-of-ssa example (Figure 6)
(defparameter *src10* '(((x0 :h) (x1 :h) (x2 :h) (x3 :h) (a :h))
		       l3
		       (a (:ldi 0))
		       (x3 (:ldi 1))
		       (x1 (:ldi 2))
		       (:brc :!= a a l0 l4)
		       l4
		       (x2 (:ldi 3))
		       (:brc :!= a a l1 l2)
		       l1
		       (:br l0)
		       l2
		       (:br l0)
		       l0
		       (x0 (:phi x3 x1 x2))
		       (:ret)))

; sreedhar out-of-ssa example (Figure 7)
(defparameter *src11* '(((x :h) (y :h) (t :h))
			l1
			(t (:ldi 1))
			(x (:ldi 0))
			(:br l2)
			l2
			(y (:cp x))
			(x (:add x t))
			(:brc :!= t t l3 l2)
			l3
			(:ret y)))
		       
(defparameter *proc1* (compile-procedure *src1*))
(defparameter *proc2* (compile-procedure *src2*))
(defparameter *proc3* (convert-source *src3*))
(defparameter *proc4* (compile-procedure *src4*))
(defparameter *proc5* (compile-procedure *src5*))
(defparameter *proc6* (compile-procedure *src6*))
(defparameter *proc9* (convert-source *src9*))
(defparameter *proc10* (convert-source *src10*))
(defparameter *proc11* (compile-procedure *src11*))

(write-string-to-file (dotify-cfg *proc1*) "debug/cfg-src1.dot")
(write-string-to-file (dotify-cfg *proc2*) "debug/cfg-src2.dot")
(write-string-to-file (dotify-cfg *proc3*) "debug/cfg-src3.dot")
(write-string-to-file (dotify-cfg *proc4*) "debug/cfg-src4.dot")
(write-string-to-file (dotify-cfg *proc5*) "debug/cfg-src5.dot")
(write-string-to-file (dotify-cfg *proc6*) "debug/cfg-src6.dot")
(write-string-to-file (dotify-cfg *proc10*) "debug/cfg-src10.dot")
(write-string-to-file (dotify-cfg *proc11*) "debug/cfg-src11.dot")

(defun print-proc-rpo (proc)
  (let ((rpo (compute-cfg-rpo proc :backward)))
    (iter (for block in-vector rpo)
	  (format t "~A " (bb-label block)))))

(defun print-proc-uses (proc)
  (iter (for bb in-univ (proc-bbs proc))
	(iter (for ins in-olist (bb-insns bb))
	      (iter (for use in-olist (ins-uses ins) pred #'temporary?)
		    (format t "~A~%" (temp-name use))))))

(defun print-proc-defs (proc)
  (iter (for bb in-univ (proc-bbs proc))
	(iter (for ins in-olist (bb-insns bb))
	      (iter (for def in-olist (ins-defs ins))
		    (format t "~A~%" (temp-name def))))))

(defun build-random-table ()
  (let ((table (make-hash-table :size 100)))
    (iter (for i from 0 below 100)
	  (setf (gethash (random 10000000) table) (random 10000000)))
    table))

(defun benchmark-hash-lookup (table)
  (let ((sum 0))
    (iter (for i from 0 below 10000000)
	  (when (gethash i table) (incf sum)))
    sum))

(defun print-ss (ss)
  (format t "~A~%" (listify-thing ss)))

(defun test-sparse-sets ()
  (let ((universe (new-universe)))
    (iter (for i from 0 to 10)
	  (add-to-universe i universe))
    (let ((s1 (new-sparse-set universe))
	  (s2 (new-sparse-set universe)))
      (iter (for j from 0 below 7)
	    (ss-add j s1))
      (iter (for j from 3 below 10)
	    (ss-add j s2))
      (iter (for j in-sset s1)
	    (format t "~A " j))
      (format t "~%")
      (print-ss s1)
      (print-ss s2)
      (print-ss (ss-ior s1 s2))
      (print-ss (ss-and s1 s2))
      (print-ss (ss-ior* (list s1 s2) universe))
      (print-ss (ss-and* (list s1 s2) universe)))))

(defun sanity-check-livein-sets (proc)
  (ensure-analyses-valid '(:livein :liveout) proc)
  (iter (for bb in-univ (proc-bbs proc))
	(let ((psets (iter (for succ in-vector (bb-succs bb))
			   (collect (fblock-livein succ)))))
	  (let ((one (set-ior* psets (proc-bbs proc)))
		(two (fblock-liveout bb)))
	    (unless (set-equal? one two)
	      (format t "livein set for ~A inconsistent" (bb-label bb)))))))

(defun test-partition-sets ()
  (let* ((univ (new-universe))
	 (pset (new-partition-set univ)))
    (iter (for i from 1 to 5)
	  (add-to-universe i univ))
    (let* ((p1 (partition-from-element 1 pset))
	   (p2 (partition-from-element 2 pset))
	   (p3 (partition-from-element 3 pset))
	   (p4 (partition-from-element 4 pset))
	   (p5 (partition-from-element 5 pset)))
      (union-partitions p1 p2 pset)
      (union-partitions p1 p3 pset)
      (union-partitions p4 p5 pset)
      (format t "~A~%" 
	      (iter (for set in (collect-partition-sets pset))
		    (collect (listify-thing set)))))))

(defun test-pss-element-and ()
  (iter (for i in '(nil 1 2 t))
	(iter (for j in '(nil 1 2 t))
	      (format t "~A " (pss-element-and i j)))
	(format t "~%")))

(defun test-pss-element-ior ()
  (iter (for i in '(nil 1 2 t))
	(iter (for j in '(nil 1 2 t))
	      (format t "~A " (pss-element-ior i j)))
	(format t "~%")))

(defun test-pss-element-or ()
  (iter (for i in '(nil 1 2 t))
	(iter (for j in '(nil 1 2 t))
	      (format t "~A " (pss-element-or i j)))
	(format t "~%")))

(defun test-pss-set ()
  (let ((universe (new-universe)))
    (iter (for i from 0 below 10)
	  (add-to-universe i universe))
    (let ((ps1 (new-parallel-single-set universe))
	  (ps2 (new-parallel-single-set universe)))
      (pss-add 'a 3 ps1)
      (pss-add 'a 4 ps1)
      (pss-add 'b 4 ps2)
      (format t "~A~%" (listify-thing ps1))
      (format t "~A~%" (listify-thing ps2))
      (format t "~A~%" (listify-thing (pss-ior ps1 ps2)))
      (format t "~A~%" (listify-thing (pss-and ps1 ps2)))
      (format t "~A~%" (listify-thing (pss-and* (list ps1 ps2) universe))))))

(defun test-object-graph ()
  (let ((universe (new-universe)))
    (iter (for i from 0 below 10)
	  (add-to-universe i universe))
    (let ((gra (new-object-graph universe))
	  (list '((1 (2 4 7))
		  (4 (3 5))
		  (6 (2 7 9)))))
      (iter (for line in list)
	    (let ((base (first line))
		  (other (second line)))
	      (iter (for i in other)
		    (gra-add-edge base i gra))))
      (gra-rem-edge 4 5 gra)
      (format t "~A~%" (listify-thing gra)))))
