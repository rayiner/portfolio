; Vistalisp emacs mode
; Based on scheme.el
; Original copyright notice for scheme.el appears below

;; Copyright (C) 1986, 1987, 1988, 1997, 1998, 2001, 2002, 2003, 2004, 2005,
;;   2006, 2007  Free Software Foundation, Inc.

;; Author: Bill Rozas <jinx@martigny.ai.mit.edu>
;; Adapted-by: Dave Love <d.love@dl.ac.uk>
;; Keywords: languages, lisp

;; This file is part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

(require 'lisp-mode)

(defvar vitalisp-mode-syntax-table
  (let ((st (make-syntax-table))
	(i 0))

    ;; Default is atom-constituent.
    (while (< i 256)
      (modify-syntax-entry i "_   " st)
      (setq i (1+ i)))

    ;; Word components.
    (setq i ?0)
    (while (<= i ?9)
      (modify-syntax-entry i "w   " st)
      (setq i (1+ i)))
    (setq i ?A)
    (while (<= i ?Z)
      (modify-syntax-entry i "w   " st)
      (setq i (1+ i)))
    (setq i ?a)
    (while (<= i ?z)
      (modify-syntax-entry i "w   " st)
      (setq i (1+ i)))

    ;; Whitespace
    (modify-syntax-entry ?\t "    " st)
    (modify-syntax-entry ?\n ">   " st)
    (modify-syntax-entry ?\f "    " st)
    (modify-syntax-entry ?\r "    " st)
    (modify-syntax-entry ?\s "    " st)

    ;; These characters are delimiters but otherwise undefined.
    ;; Brackets and braces balance for editing convenience.
    (modify-syntax-entry ?\[ "(]  " st)
    (modify-syntax-entry ?\] ")[  " st)
    (modify-syntax-entry ?{ "(}  " st)
    (modify-syntax-entry ?} "){  " st)
    (modify-syntax-entry ?\( "()  " st)
    (modify-syntax-entry ?\) ")(  " st)
    (modify-syntax-entry ?\| "\" 23bn" st)

    (modify-syntax-entry ?\: ".   " st)
    (modify-syntax-entry ?\. ".   " st)

    (modify-syntax-entry ?\; "<   " st)
    (modify-syntax-entry ?\" "\"   " st)
    (modify-syntax-entry ?' "'   " st)
    (modify-syntax-entry ?` "'   " st)

    ;; Special characters
    (modify-syntax-entry ?, "'   " st)
    (modify-syntax-entry ?@ "'   " st)
    (modify-syntax-entry ?# "'   " st)
    (modify-syntax-entry ?$ "'   " st)
    (modify-syntax-entry ?% "'   " st)
    (modify-syntax-entry ?\\ "'   " st)
    st))

(defvar vitalisp-mode-abbrev-table nil)
(define-abbrev-table 'vitalisp-mode-abbrev-table ())

(defun vitalisp-mode-variables ()
  (set-syntax-table vitalisp-mode-syntax-table)
  (setq local-abbrev-table vitalisp-mode-abbrev-table)
  (make-local-variable 'paragraph-start)
  (setq paragraph-start (concat "$\\|" page-delimiter))
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'paragraph-ignore-fill-prefix)
  (setq paragraph-ignore-fill-prefix t)
  (make-local-variable 'fill-paragraph-function)
  (setq fill-paragraph-function 'lisp-fill-paragraph)
  ;; Adaptive fill mode gets in the way of auto-fill,
  ;; and should make no difference for explicit fill
  ;; because lisp-fill-paragraph should do the job.
  (make-local-variable 'adaptive-fill-mode)
  (setq adaptive-fill-mode nil)
  (make-local-variable 'normal-auto-fill-function)
  (setq normal-auto-fill-function 'lisp-mode-auto-fill)
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'lisp-indent-line)
  (make-local-variable 'parse-sexp-ignore-comments)
  (setq parse-sexp-ignore-comments t)
  (make-local-variable 'comment-start)
  (setq comment-start ";")
  (set (make-local-variable 'comment-add) 1)
  (make-local-variable 'comment-start-skip)
  ;; Look within the line for a ; following an even number of backslashes
  ;; after either a non-backslash or the line beginning.
  (setq comment-start-skip "\\(\\(^\\|[^\\\\\n]\\)\\(\\\\\\\\\\)*\\);+[ \t]*")
  (set (make-local-variable 'font-lock-comment-start-skip) ";+ *")
  (make-local-variable 'comment-column)
  (setq comment-column 40)
  (make-local-variable 'parse-sexp-ignore-comments)
  (setq parse-sexp-ignore-comments t)
  (make-local-variable 'lisp-indent-function)
  (setq lisp-indent-function 'vitalisp-indent-function)
  (setq mode-line-process '("" vitalisp-mode-line-process))
  (set (make-local-variable 'font-lock-defaults)
       '((vitalisp-font-lock-keywords-2)
	 nil nil (("!&*+-/<=>?^_~" . "w"))
         beginning-of-defun
         (font-lock-mark-block-function . mark-defun)
         (font-lock-syntactic-face-function
	  . lisp-font-lock-syntactic-face-function)
         (parse-sexp-lookup-properties . t)
         (font-lock-extra-managed-props syntax-table)))
  (set (make-local-variable 'lisp-doc-string-elt-property)
       'vitalisp-doc-string-elt))

(defvar vitalisp-mode-line-process "")

(defvar vitalisp-mode-map
  (let ((smap (make-sparse-keymap))
	(map (make-sparse-keymap "Vitalisp")))
    (set-keymap-parent smap lisp-mode-shared-map)
    (define-key smap [menu-bar vitalisp] (cons "Vitalisp" map))
    (define-key map [uncomment-region]
      '("Uncomment Out Region" . (lambda (beg end)
                                   (interactive "r")
                                   (comment-region beg end '(4)))))
    (define-key map [comment-region] '("Comment Out Region" . comment-region))
    (define-key map [indent-region] '("Indent Region" . indent-region))
    (define-key map [indent-line] '("Indent Line" . lisp-indent-line))
    (put 'comment-region 'menu-enable 'mark-active)
    (put 'uncomment-region 'menu-enable 'mark-active)
    (put 'indent-region 'menu-enable 'mark-active)
    smap)
  "Keymap for Vitalisp mode.
All commands in `lisp-mode-shared-map' are inherited by this map.")

;;;###autoload
(defun vitalisp-mode ()
  "Major mode for editing Vitalisp code.
Editing commands are similar to those of `lisp-mode'."
  (interactive)
  (kill-all-local-variables)
  (use-local-map vitalisp-mode-map)
  (setq major-mode 'vitalisp-mode)
  (setq mode-name "Vitalisp")
  (vitalisp-mode-variables)
  (run-mode-hooks 'vitalisp-mode-hook))

(defgroup vitalisp nil
  "Editing Vitalisp code."
  :link '(custom-group-link :tag "Font Lock Faces group" font-lock-faces)
  :group 'lisp)

(defcustom vitalisp-mode-hook nil
  "Normal hook run when entering `vitalisp-mode'.
See `run-hooks'."
  :type 'hook
  :group 'vitalisp)

(defconst vitalisp-font-lock-keywords-1
  (eval-when-compile
    (list
     '("^(\\(fun\\|case\\|macro\\)\\s-+\\(\\sw+\\)"
       (1 font-lock-keyword-face)
       (2 font-lock-function-name-face nil t))
     '("^(\\(var\\|dyn-var\\|const\\)\\s-+\\(\\sw+\\)"
       (1 font-lock-keyword-face)
       (2 font-lock-variable-name-face nil t))
     '("^(\\(type\\)\\s-+\\(\\sw+\\)"
       (1 font-lock-keyword-face)
       (2 font-lock-type-face nil t))))
  "Subdued expressions to highlight in Vitalisp modes.")

(defconst vitalisp-font-lock-keywords-2
  (append vitalisp-font-lock-keywords-1
	  (eval-when-compile
	    (list
	     ;;
	     ;; Control structures.
	     (cons
	      (concat
	       "(" (regexp-opt
		    '("do" "if" "when" "unless" "cond" "match" 
		      "bind" "bind-par" "let" "let-par" "with" "with-val"
		      "loop") t)
	       "\\>") 1)
	     (cons (concat
		    "\\<" 
		    (regexp-opt '("&" "_" "?") t) 
		    "\\>") 1)
	     )))
  "Gaudy expressions to highlight in Vitalisp modes.")

(defvar vitalisp-font-lock-keywords vitalisp-font-lock-keywords-1
  "Default expressions to highlight in Vitalisp modes.")

(defvar calculate-lisp-indent-last-sexp)

(defun looking-at-symbol? ()
  (and (looking-at "\\(\\sw\\|\\s_\\)")
       (not (looking-at "[0-9]\\|\\(-[0-9]\\)"))
       (not (looking-at "\\(\\sw\\|\\s_\\)+\\s-*\\(:\\|\\.\\)"))))

(defun looking-at-lambda-literal? (state)
  (let ((point-save (point)))
    (goto-char (elt state 1))
    (backward-prefix-chars)
    (prog1 (looking-at "\\\\(")
      (goto-char point-save))))

(defun sexp-context (indent-point state)
  (let ((original-point (point))
	(done nil)
	(context nil))
    (goto-char (elt state 1))
    (while (not done)
      (let ((point-save (point)))
	(forward-char 1)
	(skip-syntax-forward " ")
	(push (and (looking-at-symbol?)
		   (intern (buffer-substring (point)
					     (progn (forward-sexp)
						    (point)))))
	      context)
	(goto-char point-save))
      (condition-case ()
	  (backward-up-list)
	(error (setq done t))))
    (goto-char original-point)
    (reverse context)))

(defun context-match (query context)
  (cond
   ((null query) t)
   ((null context) nil)
   ((and (atom (first query))
	 (not (eq (first query) t))
	 (not (eq (first query) (first context)))) nil)
   ((and (consp (first query))
	 (not (member (first context) (first query)))) nil)
   (t (context-match (rest query) (rest context)))))

(defun top-level-special-form? (context)
  (member (first context) '(do)))

(defun top-level-definition? (context)
  (= (length context) 1))

(defun lambda-literal? (context)
  (context-match '(nil fun-value) context))

(defun local-definition? (context)
  (context-match '((fun macro type) nil (bind bind-par)) context))

(defun vitalisp-indent-lambda-literal (state indent-point)
  (goto-char (elt state 1))
  (+ lisp-body-indent (current-column)))

;; Copied from lisp-indent-function, but with gets of
;; vitalisp-indent-{function,hook}.
(defun vitalisp-indent-function (indent-point state)
  (let ((normal-indent (current-column))
	(context (sexp-context indent-point state)))
    (goto-char (1+ (elt state 1)))
    (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
    (cond
     ((and (not (top-level-special-form? context))
	   (or (top-level-definition? context) (local-definition? context)))
      (lisp-indent-defform state indent-point))
     ((or (looking-at-lambda-literal? state) 
	  (lambda-literal? context))
      (vitalisp-indent-lambda-literal state indent-point))
     ((and (elt state 2) (not (looking-at-symbol?)))
      (if (not (> (save-excursion (forward-line 1) (point))
		  calculate-lisp-indent-last-sexp))
	  (progn (goto-char calculate-lisp-indent-last-sexp)
		 (beginning-of-line)
		 (parse-partial-sexp (point)
				     calculate-lisp-indent-last-sexp 0 t)))
      (backward-prefix-chars)
      (current-column))
     (t
      (let ((function (buffer-substring (point)
					(progn (forward-sexp 1) (point))))
	    method)
	(setq method (or (get (intern-soft function) 'vitalisp-indent-function)
			 (get (intern-soft function) 'vitalisp-indent-hook)))
	(cond ((integerp method)
	       (message "special")
	       (lisp-indent-specform method state
				     indent-point normal-indent))
	      (method
	       (funcall method state indent-point normal-indent))))))))

;; (put 'begin 'scheme-indent-function 0), say, causes begin to be indented
;; like defun if the first form is placed on the next line, otherwise
;; it is indented like any other form (i.e. forms line up under first).

(put 'do 'vitalisp-indent-function 0)
(put 'when 'vitalisp-indent-function 1)
(put 'unless 'vitalisp-indent-function 1)
(put 'match 'vitalisp-indent-function 1)
(put 'bind 'vitalisp-indent-function 1)
(put 'bind-par 'vitalisp-indent-function 1)
(put 'let 'vitalisp-indent-function 1)
(put 'let-par 'vitalisp-indent-function 1)
(put 'with 'vitalisp-indent-function 1)
(put 'with-val 'vitalisp-indent-function 1)
(put 'loop 'vitalisp-indent-function 1)

(provide 'vitalisp)
