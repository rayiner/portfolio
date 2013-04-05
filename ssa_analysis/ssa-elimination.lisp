; ssa-elimination.lisp
; Convert the IR out of SSA form

(in-package "VITAMIN")

(defstruct candidate-resource-set
  set
  queue)

(defstruct delayed-copy
  ref
  bb
  pbb
  proc)

(defstruct unresolved-neighbor
  ref
  pbb)

(defun new-copy-target (source proc)
  (make-renamed-temporary source (incf (ftemp-rencount source)) proc))

(defun new-candidate-resource-set (universe)
  (make-candidate-resource-set :set (new-bit-set universe)
			       :queue (new-worklist)))

(defun new-delayed-copy (ref bb pbb proc)
  (make-delayed-copy :ref ref :bb bb :pbb pbb :proc proc))

(defun new-unresolved-neighbor (ref pbb)
  (make-unresolved-neighbor :ref ref :pbb pbb))

(defun insert-copy-after-phis (source target bb)
  (insert-instruction-after-fill (new-copy source target) bb))

(defun insert-copy-before-terminator (source target bb)
  (insert-instruction-before (new-copy source target)
			     (block-terminator bb)
			     bb))

(defun insert-copy-for-dest (ref bb proc)
  (let* ((def (list-ref-item ref))
	 (ndef (new-copy-target def proc)))
    (partition-from-element ndef (fproc-pccs proc))
    (insert-copy-after-phis ndef def bb)
    (list-ref-replace ref ndef)
    (bs-rem def (fblock-livein bb))
    (bs-add ndef (fblock-livein bb))
    (gra-add-edges-to-set-members ndef (fblock-livein bb) (fproc-intg proc))))

; this depends on critical edges being split, specifically the fact
; that the predecessor block corresponding to a resource can have 
; only a single successor
(defun insert-copy-for-source (ref bb srcbb proc)
  (let* ((src (list-ref-item ref))
	 (nsrc (new-copy-target src proc)))
    (partition-from-element nsrc (fproc-pccs proc))
    (insert-copy-before-terminator src nsrc srcbb)
    (list-ref-replace ref nsrc)
    (bs-rem src (fblock-liveout srcbb))
    (bs-add nsrc (fblock-liveout srcbb))
    (gra-add-edges-to-set-members nsrc 
				  (fblock-liveout srcbb) 
				  (fproc-intg proc))))

(defun queued-for-copy? (ref crs)
  (with-slots (set queue) crs
    (bs-member? (list-ref-item ref) set)))

(defun queue-delayed-copy (ref bb pbb proc crs)
  (with-slots (set queue) crs
    (unless (bs-member? (list-ref-item ref) set)
      (bs-add (list-ref-item ref) set)
      (queue-work (new-delayed-copy ref bb pbb proc) queue))))

(defun manifest-delayed-copies (crs)
  (iter (for copy in-wlist (candidate-resource-set-queue crs))
	(let ((ref (delayed-copy-ref copy))
	      (bb (delayed-copy-bb copy))
	      (pbb (delayed-copy-pbb copy))
	      (proc (delayed-copy-proc copy)))
	  (if pbb
	      (insert-copy-for-source ref bb pbb proc)
	      (insert-copy-for-dest ref bb proc)))))

(defun prepare-elimination-temporaries (proc)
  (iter (for temp in-univ (proc-names proc))
	(setf (ftemp-rencount temp) -1)
	(partition-from-element temp (fproc-pccs proc))))

(defun prepare-elimination-blocks (proc)
  (iter (for bb in-univ (proc-bbs proc))
	(move-fill-to-last-phi bb)))

(defun prepare-elimination-procedure (proc)
  (setf (fproc-pccs proc) (new-partition-set (proc-names proc))))

(defun queue-unresolved-neighbor (rj bbj ri nmap)
  (unless (gethash ri nmap) (setf (gethash ri nmap) (new-stretchy-vector)))
  (vector-push-unique (new-unresolved-neighbor rj bbj)
		      (gethash ri nmap) :key #'unresolved-neighbor-ref))

(defun congruence-class-independent? (x live proc)
  (bs-empty? (bs-and (find-partition-set x (fproc-pccs proc)) live)))

(defun maybe-break-interference (ri rj livei livej bbi bbj bb proc nmap crs)
  (let ((xi (list-ref-item ri))
	(xj (list-ref-item rj)))
    (when (and (not (in-same-partition? xi xj (fproc-pccs proc)))
	       (gra-edge-member? xi xj (fproc-intg proc)))
      (let ((xi-free? (congruence-class-independent? xj livei proc))
	    (xj-free? (congruence-class-independent? xi livej proc)))
	(cond
	  ((and xi-free? (not xj-free?))
	   (queue-delayed-copy ri bb bbi proc crs))
	  ((and xj-free? (not xi-free?))
	   (queue-delayed-copy rj bb bbj proc crs))
	  ((and (not xi-free?) (not xj-free?))
	   (queue-delayed-copy ri bb bbi proc crs)
	   (queue-delayed-copy rj bb bbj proc crs))
	  ((and xi-free? xj-free?)
	   (queue-unresolved-neighbor rj bbj ri nmap)
	   (queue-unresolved-neighbor ri bbi rj nmap)))))))

(defun break-resource-interferences (phi bb proc nmap crs)
  (iter (for def in-olist (ins-defs phi) with-ref defref)
	(iter (for use in-olist (ins-uses phi) with-ref useref)
	      (for puse in-vector (bb-preds bb))
	      (maybe-break-interference defref useref
					(fblock-livein bb)
					(fblock-liveout puse)
					nil puse bb proc nmap crs)))
  (iter (for usei in-olist (ins-uses phi) with-ref useiref)
	(for predi in-vector (bb-preds bb))
	(iter (for usej in-olist (ins-uses phi) with-ref usejref)
	      (for predj in-vector (bb-preds bb))
	      (maybe-break-interference useiref usejref
					(fblock-liveout predi)
					(fblock-liveout predj)
					predi predj bb proc nmap crs))))

(defun resolve-unresolved-neighbors (bb proc nmap crs)
  (let ((temps (new-stretchy-vector)))
    (iter (for (ri vec) in-hashtable nmap)
	  (vector-push-extend ri temps))
    (sort temps #'>= :key #'(lambda (ri) (length (gethash ri nmap))))
    (iter (for ri in-vector temps)
	  (unless (queued-for-copy? ri crs)
	    (iter (for rj in-vector (gethash ri nmap))
		  (unless (queued-for-copy? rj crs)
		    (queue-delayed-copy rj bb proc crs)))))))

; sreedhar's original algorithm is unclear in step 7.
; it obviously intends to show the phi congruence classes
; of all the phi resources being merged, but that's not what
; the pseudo-code actually does. in particular, it will leave
; things like:
; pcc(xi) = {x1 x2 x3}
; pcc(xj) = {x3 x4 x5}
; obviously, this should be:
; pcc(xi) = pcc(xj) = {x1 x2 x3 x4 x5}
(defun merge-phi-resources (phi proc)
  (iter (for use in-olist (ins-uses phi))
	(union-partitions (instruction-def phi) use (fproc-pccs proc))))

(defun eliminate-interferences-in-phi (phi bb proc)
  (let ((crs (new-candidate-resource-set (proc-names proc)))
	(nmap (make-hash-table)))
    (break-resource-interferences phi bb proc nmap crs)
    (resolve-unresolved-neighbors bb proc nmap crs)
    (manifest-delayed-copies crs)
    (merge-phi-resources phi proc)))

(defun eliminate-phi-interferences (proc)
  (ensure-analyses-valid '(:livein :liveout :intg) proc)
  (prepare-elimination-procedure proc)
  (prepare-elimination-blocks proc)
  (prepare-elimination-temporaries proc)
  (iter (for bb in-univ (proc-bbs proc))
	(iter (for phi in-olist bb pred #'phi?)
	      (eliminate-interferences-in-phi phi bb proc)))
  (note-all-analyses-invalid proc))

; we should use a smarter back-renaming policy once we incorporate
; more tracking of source-level information. in particular, if we
; have a pcc like {x1 x2 x3} derived from a source variable x, we
; should rename all the variables back to x. right now we do the
; dumb thing and basically pick one at random.
(defun name-for-congruence-class (pcc)
  (iter (for thing in-oset pcc)
	(leave thing)))

(defun remove-phi-instructions (proc)
  (iter (for bb in-univ (proc-bbs proc))
	(let ((del-queue (new-deletion-queue #'(lambda (ins)
						 (rem-instruction ins bb)))))
	  (iter (for ins in-olist (bb-insns bb) pred #'phi?)
		(queue-for-deletion ins del-queue))
	  (delete-queued-items del-queue))))

(defun convert-from-ssa-form (proc)
  (let ((rename-map (make-hash-table))
	(sets (collect-partition-sets (fproc-pccs proc))))
    (iter (for set in sets)
	  (let ((rep (name-for-congruence-class set)))
	    (iter (for name in-oset set)
		  (setf (gethash name rename-map) rep))))
    (iter (for bb in-univ (proc-bbs proc))
	  (iter (for ins in-olist (bb-insns bb) pred #'not-phi?)
		(iter (for def in-olist (ins-defs ins) with-ref ref)
		      (list-ref-replace ref (gethash def rename-map))
		(iter (for use in-olist (ins-uses ins)
			   pred #'temporary? with-ref ref)
		      (list-ref-replace ref (gethash use rename-map))))))
    (remove-phi-instructions proc)))

(defun verify-congruence-classes (proc)
  (let ((pset (new-partition-set (proc-names proc))))
    (iter (for temp in-univ (proc-names proc))
	  (partition-from-element temp pset))
    (iter (for bb in-univ (proc-bbs proc))
	  (iter (for ins in-olist (bb-insns bb) pred #'phi?)
		(iter (for use in-olist (ins-uses ins))
		      (union-partitions (instruction-def ins) use pset))))
    (iter (for temp in-univ (proc-names proc))
	  (unless (bs-equal? (find-partition-set temp (fproc-pccs proc))
			      (find-partition-set temp pset))
	    (format t "Invalid congruence-class ~A ~A~%"
		    (listify-thing (find-partition-set temp (fproc-pccs proc)))
		    (listify-thing (find-partition-set temp pset)))))))

(defun verify-congruence-classes-independent (proc)
  (iter (for temp in-univ (proc-names proc))
	(iter (for otemp in-oset (find-partition-set temp (fproc-pccs proc)))
	      (when (and (not (eql temp otemp))
			 (gra-edge-member? temp otemp (fproc-intg proc)))
		(format t "Interference between ~A and ~A~%"
			(temp-name temp) (temp-name otemp))))))
