;;;; lazr-prog --- Programming language specific settings. -*- lexical-binding: t -*-

(require 'lazr-core "./lazr-core.el")
(require 'lazr-keybindings "./lazr-keybindings.el")

;;; Interacting with a REPL or similar 

(defun lz/define-interactive-keybinds (keymap eval-defun eval-buffer open-repl)
  "Define Lisp keybindings in a consistent manner."

  (lazr/local-leader-map :keymaps keymap
    "e" eval-defun
    "E" eval-buffer
    "r" open-repl))

;;; Keyword/documentation lookup

(make-variable-buffer-local 'evil-lookup-func)
(evil-define-key 'normal ielm-map "K" 'describe-symbol)

;;;
;;; Intelligent code completion and such using LSP and tree-sitter
;;;

; Completion framework
(use-package company :config (global-company-mode))

; On-the-fly checking.
(use-package flycheck :config (global-flycheck-mode))

;; Install the built-in Emacs language server client.
(use-package eglot
  :commands eglot-ensure
  :hook (((c-mode
           go-mode
           rust-mode
           python-mode
           php-mode
           shell-script-mode) . eglot-ensure)))


;; Registers LSP checks with flycheck.
(use-package flycheck-eglot)

;; Enable ultra-smart syntax awareness using Tree-Sitter.
(use-package tree-sitter :config (global-tree-sitter-mode))

;; Add as many tree-sitter languages as possible.
(use-package tree-sitter-langs)

;;
;; When writing program source code, if there is not already a system in place,
;; use the "indent with tabs and align with spaces" convention.
;;

;;;
;;; Algol family.
;;;

;;
;; C and C++ modes
;;

(setf c-default-style
      '((cc-mode . "linux")
        (java-mode . "java")
        (other . "k&r")))
 
;;
;; Go
;;
(use-package go-mode)

;;
;; Rust
;;

(use-package rust-mode)

;;
;; Shell scripts.
;;

(use-package shell-script-mode
  :config
  (reformatter-define shell-script-format
    :program "shfmt"
    :args '("--simplify" "--case-indent" "--func-next-line" "-"))

  :hook
  '(shell-script-mode . shell-script-format-on-save-mode))

(evil-define-key 'normal ielm-map "K" 'describe-symbol)

;;
;; Python.
;;
(use-package elpy
  :config
  (elpy-enable))

; Make python available with Org-Babel.
(require 'ob-python)

;;; Web technologies

; Enables web page template highlighting, including PHP
(use-package web-mode :ensure t 
  :init
  (setf web-mode-enable-engine-detection t
        web-mode-markup-indent-offset 2))

;;
;; JavaScript
;;

(use-package js2-mode :ensure t)

(use-package js-comint :ensure t
  :init (setf js-comint-program-command "qjs"))

(lz/define-interactive-keybinds 'js2-mode-map
                                #'js-comint-send-last-sexp
                                #'js-comint-send-buffer
                                #'js-comint-repl)

(require 'ob-js)

;;
;; PHP 
;;

(use-package php-mode)
(use-package phpunit)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(php-mode . ("phpactor" "language-server"))))

(lazr/local-leader-map :keymaps 'php-mode-map
  "ta" 'phpunit-current-project
  "tt" 'phpunit-current-test
  "tc" 'phpunit-current-class)

;;;
;;; Lisp family.
;;;


(defconst lz/lisps
  '(lisp emacs-lisp scheme racket clojure fennel arc)
  "Lisp variants that I am aware of and may possibly write code in")

(use-package parinfer-rust-mode :ensure t
  :init
  (setq parinfer-rust-auto-download t))

(use-package rainbow-delimiters)

(dolist (lmh (mapcar (lambda (lisp-name)
                       (lz/symcat-soft lisp-name 'mode-hook))
                     lz/lisps))
  (when lmh
    (message "lazr/prog: installing lisp mode hook to %s" lmh)
    (add-hook lmh 'parinfer-rust-mode)
    (add-hook lmh 'rainbow-delimiters-mode)
    (add-hook lmh (lambda () (setf indent-tabs-mode nil)))))

;;
;; Emacs Lisp
;;

(lz/define-interactive-keybinds 'emacs-lisp-mode-map
  'eval-defun
  'eval-buffer
  'ielm)

(evil-define-key 'normal emacs-lisp-mode-map
  "K" 'describe-symbol)

;;
;; Common Lisp
;;

;; Use the Superior Lisp Interaction Mode for Emacs
(use-package slime
  :config
  (setf inferior-lisp-program "sbcl"))

(lz/define-interactive-keybinds 'lisp-mode-map
  'slime-eval-defun
  'slime-compile-and-load-file
  'slime)

;; Enable common lisp for org babel.
(require 'ob-lisp)

;;;
;;; Scheme
;;;


;; Use the Geiser interaction mode for Scheme.
(use-package geiser
  :mode (("\\.sld" . scheme-mode))
  :config
  (setq geiser-active-implementations
        '(guile gauche racket)))

(use-package geiser-gauche)
(use-package geiser-guile
  :config
  ;; Add the Guix source code to the load path to hack
  (add-to-list 'geiser-guile-load-path
               "~/src/gnu/guix"))

(lz/define-interactive-keybinds 'scheme-mode-map
  'geiser-eval-definition
  'geiser-eval-buffer
  'geiser)

;; (add-hook 'scheme-mode-hook
;; 	  (lambda ()
;; 	    (setf evil-lookup-func lazr/scheme-lookup)))
		  

(require 'ob-scheme)

(use-package racket-mode)

;;;
;;; Clojure
;;;

(use-package clojure-mode :ensure t)
(use-package cider :ensure t)
; (require 'ob-clojure-eval-with-babashka)

(lz/define-interactive-keybinds 'clojure-mode-map
  'cider-eval-defun-at-point
  'cider-eval-buffer
  'cider-jack-in-clj&cljs)

(evil-define-key 'normal clojure-mode-map "K" 'cider-doc)

;; Elixir (It's a Lisp, fite me)
(use-package elixir-mode :ensure t)

;;;
;;; ML family.
;;;

;; Standard ML
(use-package sml-mode :ensure t)

;; OCaml

;; Haskell
(use-package haskell-mode)
(require 'ob-haskell)

;;;
;;; Databases, configuration files, etc
;;;


;; Recutils mode
(use-package rec-mode)
(lazr/local-leader-map :keymaps 'rec-mode-map
  "n" 'rec-cmd-goto-next-rec
  "p" 'rec-cmd-goto-previous-rec
  "d" 'rec-cmd-show-descriptor
  "t" 'rec-find-type
  "SPC" 'rec-cmd-toggle-field-visibility
  "R" 'rec-edit-record
  "T" 'rec-edit-type
  "B" 'rec-edit-buffer)

(provide 'lazr-prog)
