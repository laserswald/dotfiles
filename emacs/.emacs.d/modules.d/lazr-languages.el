;;;; lazr-languages --- Provide support for programming languages -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;;;
;;; Packages that are used by many languages.
;;;

;; Have the compilation buffer properly show ANSI color escape sequences.
;;
;; Stolen from (http://endlessparentheses.com/ansi-colors-in-the-compilation-buffer-output.html)

(require 'ansi-color)

(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))
(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

;;
;; Define commands that run reformatters on the current buffer.
;;
(use-package reformatter
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
         php-mode))

;;
;; Language server support.
;;

(use-package eglot
  :commands eglot-ensure
  :ensure t
  :hook (((c-mode
           go-mode
           rust-mode
           python-mode
           php-mode
          
           shell-script-mode) . eglot-ensure)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(web-mode . ("phpactor" "language-server")))
  (add-to-list 'eglot-server-programs
               '(php-mode . ("phpactor" "language-server"))))

;; Register LSP checks with flycheck.
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

;;;
;;; Algol family.
;;;

;;
;; C and C++ modes
;;
 
;; Go
(use-package go-mode :ensure t
  :config)

;; Rust
(use-package rust-mode :ensure t
  :config)

;; Shell scripts.

(use-package shell-script-mode
  :init
  (reformatter-define shell-script-format
    :program "shfmt"
    :args '("--simplify" "--case-indent" "--func-next-line" "-"))

  :hook
  '(shell-script-mode . shell-script-format-on-save-mode))
  
  
;; Python.

(use-package elpy :ensure t
  :config
  (elpy-enable))

;; Make python available with Org-Babel.
(require 'ob-python)

;;;; PHP and other Web shenanigans.

(use-package web-mode
  :ensure t
  :init
  (setf web-mode-enable-engine-detection t
        web-mode-markup-indent-offset 2))

(use-package php-mode
  :ensure t)

(use-package phpunit
  :ensure t)

;;;
;;; Lisp family.
;;;

(defun lazr-disable-tabs ()
  "Disable tabs in this mode."
  (setq indent-tabs-mode nil))

(dolist (lisp '(emacs-lisp-mode-hook
                scheme-mode-hook
                lisp-mode-hook
                clojure-mode-hook))
  (add-hook lisp 'lazr-disable-tabs))

(use-package parinfer-rust-mode
  :ensure t
  :init
  (setq parinfer-rust-auto-download t)
  :hook (emacs-lisp-mode scheme-mode common-lisp-mode clojure-mode))

;;
;; Emacs Lisp
;;

;;
;; Common Lisp
;;

;; Use the Superior Lisp Interaction Mode for Emacs
(use-package slime
  :ensure t
  :config
  (setf inferior-lisp-program "sbcl"))

;; Enable common lisp for org babel.
(require 'ob-lisp)

;;
;; Scheme
;;

;; Use the Geiser interaction mode for Scheme.
(use-package geiser
  :ensure t
  :mode (("\\.sld" . scheme-mode))
  :config
  (setq geiser-active-implementations '(guile gauche chez)))

(use-package geiser-chez :ensure t)
(use-package geiser-gauche :ensure t)

(use-package geiser-guile :ensure t
  :config
  ;; Add the Guix source code to the load path to hack
  (add-to-list 'geiser-guile-load-path
               "~/src/gnu/guix"))

(require 'ob-scheme)

;; Elixir (It's a Lisp, fite me)
(use-package elixir-mode :ensure t)

;;;
;;; ML family.
;;;

(use-package haskell-mode :ensure t)

(require 'ob-haskell)

;;;
;;; Data configuration languages.
;;;

(use-package yaml-mode :ensure t)
(use-package terraform-mode :ensure t)
(use-package nix-mode :ensure t)

;;;
;;; Template configuration languages.
;;;

(use-package poly-ansible
  :ensure t
  :config 
  (add-to-list 'auto-mode-alist '(".*\\.ya?ml\\.j2" . poly-ansible-mode)))
 
(use-package feature-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '(".*\\.feature" . feature-mode)))

(use-package dockerfile-mode :ensure t)

(use-package protobuf-mode :ensure t)

(use-package todotxt :ensure t)

(use-package emacs-guix :ensure t)

(provide 'lazr-languages)
