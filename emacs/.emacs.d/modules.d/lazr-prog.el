;;;; lazr-prog --- Programming language specific settings. -*- lexical-binding: t -*-

(require 'lazr-core)

;;;
;;; Intelligent code completion and such using LSP and tree-sitter
;;;

; Completion framework
(use-package company :ensure t :config (global-company-mode))

; On-the-fly checking.
(use-package flycheck :ensure t :config (global-flycheck-mode))

;; Install the built-in Emacs language server client.
(use-package eglot :ensure t
  :commands eglot-ensure
  :hook (((c-mode
           go-mode
           rust-mode
           python-mode
           php-mode
           shell-script-mode) . eglot-ensure)))


;; Registers LSP checks with flycheck.
(use-package flycheck-eglot
  :ensure t)

;; Enable ultra-smart syntax awareness using Tree-Sitter.
(use-package tree-sitter
  :ensure t
  :config
  (global-tree-sitter-mode))

;; Add as many tree-sitter languages as possible.
(use-package tree-sitter-langs
  :ensure t)

;;
;; When writing program source code, if there is not already a system in place,
;; use the "indent with tabs and align with spaces" convention.
;;
(use-package smart-tabs-mode
  :ensure t
  :hook (cc-mode
         java-mode
         go-mode
         rust-mode
         javascript-mode
         php-mode
         lua-mode))

;;;
;;; Algol family.
;;;

;;
;; C and C++ modes
;;
 
;;
;; Go
;;
(use-package go-mode :ensure t)

;;
;; Rust
;;

(use-package rust-mode :ensure t)

;;
;; Shell scripts.
;;

(use-package shell-script-mode
  :init
  (reformatter-define shell-script-format
    :program "shfmt"
    :args '("--simplify" "--case-indent" "--func-next-line" "-"))

  :hook
  '(shell-script-mode . shell-script-format-on-save-mode))

;;
;; Python.
;;
(use-package elpy :ensure t
  :config
  (elpy-enable))

; Make python available with Org-Babel.
(require 'ob-python)

;; Web technologies

; Enables web page template highlighting, including PHP
(use-package web-mode :ensure t
  :init
  (setf web-mode-enable-engine-detection t
        web-mode-markup-indent-offset 2))

; PHP 


(use-package php-mode :ensure t)
(use-package phpunit :ensure t)

(with-eval-after-load 'eglot

  (add-to-list 'eglot-server-programs
               '(web-mode . ("phpactor" "language-server")))

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

(defun lz/symcat-soft (&rest symbols)
  "Get the symbol created by concatenating the SYMBOLS together with '-'."
  (intern-soft (mapconcat #'symbol-name symbols "-")))

(defvar lz/lisps
  '(lisp emacs-lisp scheme racket clojure))

(defun lz/sym-mode (sym)
  "Get the mode hook for the language SYM."
  (lz/symcat-soft sym 'mode))

(defun lazr-eval-buffer ()
  "Evaluate a buffer and say something about it."
  (interactive)
  (eval-buffer)
  (message "Evaluated."))


        
(use-package parinfer-rust-mode :ensure t
  :init (setq parinfer-rust-auto-download t)
  :hook (mapcar lz/sym-mode lz/lisps))

(use-package rainbow-delimiters :ensure t
  :hook (mapcar lz/sym-mode lz/lisps))

;;
;; Emacs Lisp
;;

(lazr-define-lisp-keybinds 'emacs-lisp-mode-map
  'eval-defun
  'lazr-eval-buffer
  'ielm)

;;
;; Common Lisp
;;

;; Use the Superior Lisp Interaction Mode for Emacs
(use-package slime :ensure t
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
  :ensure t
  :mode (("\\.sld" . scheme-mode))
  :config
  (setq geiser-active-implementations
        '(guile gauche racket)))

(use-package geiser-gauche :ensure t)
(use-package geiser-guile :ensure t
  :config
  ;; Add the Guix source code to the load path to hack
  (add-to-list 'geiser-guile-load-path
               "~/src/gnu/guix"))

(lazr-define-lisp-keybinds 'scheme-mode-map
  'geiser-eval-definition
  'geiser-eval-buffer
  'geiser)

(require 'ob-scheme)

(use-package racket-mode :ensure t)


;; Elixir (It's a Lisp, fite me)
(use-package elixir-mode :ensure t)

;;;
;;; ML family.
;;;

(use-package haskell-mode :ensure t)
(require 'ob-haskell)

(provide 'lazr-prog)
