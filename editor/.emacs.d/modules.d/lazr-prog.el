;;;; lazr-prog --- Programming language specific settings. -*- lexical-binding: t -*-

(require 'lazr-core "./lazr-core.el")
(require 'lazr-keybindings "./lazr-keybindings.el")

;;; Keyword lookup

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

;;
;; Python.
;;
(use-package elpy
  :config
  (elpy-enable))

; Make python available with Org-Babel.
(require 'ob-python)

;; Web technologies

; Enables web page template highlighting, including PHP
(use-package web-mode
  :init
  (setf web-mode-enable-engine-detection t
        web-mode-markup-indent-offset 2))

(use-package js-comint
  :init
  (setf js-comint-program-command "qjs"))

; PHP 

(use-package php-mode)
(use-package phpunit)

(with-eval-after-load 'eglot

  (add-to-list 'eglot-server-programs
               '(php-mode . ("phpactor" "language-server"))))

(lazr-local-leader-map :keymaps 'php-mode-map
  "ta" 'phpunit-current-project
  "tt" 'phpunit-current-test
  "tc" 'phpunit-current-class)

;;;
;;; Lisp family.
;;;

(defmacro lazr-define-lisp-keybinds (mode
                                     eval-defun
                                     eval-buffer
                                     open-repl)
  "Define Lisp keybindings in a consistent manner."
  `(lazr-local-leader-map :keymaps ,mode
     "e" ,eval-defun
     "E" ,eval-buffer
     "r" ,open-repl))

(defconst lz/lisps
  '(lisp emacs-lisp scheme racket clojure fennel arc)
  "Lisp variants that I am aware of and may possibly write code in")

(use-package parinfer-rust-mode
  :init
  (setq parinfer-rust-auto-download t))

(use-package rainbow-delimiters)

(dolist (lmh (mapcar (lambda (lisp-name)
                       (lz/symcat-soft lisp-name 'mode-hook))
                     lz/lisps))
  (when lmh
    (message "lazr-prog: installing lisp mode hook to %s" lmh)
    (add-hook lmh 'parinfer-rust-mode)
    (add-hook lmh 'rainbow-delimiters-mode)
    (add-hook lmh (lambda () (setf indent-tabs-mode nil)))))

;;
;; Emacs Lisp
;;

(lazr-define-lisp-keybinds 'emacs-lisp-mode-map
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

(lazr-define-lisp-keybinds 'lisp-mode-map
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

(lazr-define-lisp-keybinds 'scheme-mode-map
  'geiser-eval-definition
  'geiser-eval-buffer
  'geiser)

;; (add-hook 'scheme-mode-hook
;; 	  (lambda ()
;; 	    (setf evil-lookup-func lazr-scheme-lookup)))
		  

(require 'ob-scheme)

(use-package racket-mode)

;;;
;;; Clojure
;;;

(use-package clojure-mode)
(use-package cider)
; (require 'ob-clojure-eval-with-babashka)
(lazr-define-lisp-keybinds 'clojure-mode-map
  'cider-eval-defun-at-point
  'cider-eval-buffer
  'cider-jack-in-clj&cljs)

(evil-define-key 'normal clojure-mode-map "K" 'cider-doc)

;; Elixir (It's a Lisp, fite me)
(use-package elixir-mode)

;;;
;;; ML family.
;;;

(use-package haskell-mode)
(require 'ob-haskell)

(use-package rec-mode)

(provide 'lazr-prog)
