;;;;
;;;; Language support.
;;;;

(defvar lz/smart-language-hooks
  '(rust-mode-hook
    python-mode-hook
    go-mode-hook
    c-mode-hook
    shell-script-mode-hook))

(use-package eglot
  :commands eglot-ensure
  :ensure t
  :init
  (dolist (hook-mode lz/smart-language-hooks)
    (add-hook hook-mode #'eglot-ensure)))

(use-package flycheck-eglot :ensure t)

(use-package tree-sitter :ensure t
  :config
  (dolist (hook-mode lz/smart-language-hooks)
     (add-hook hook-mode #'tree-sitter-mode)))

(use-package tree-sitter-langs :ensure t
  :config
  (dolist (hook-mode lz/smart-language-hooks)
     (add-hook hook-mode #'tree-sitter-hl-mode)))

;; Stolen from (http://endlessparentheses.com/ansi-colors-in-the-compilation-buffer-output.html)
(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

(use-package reformatter :ensure t)

;;;
;;; Algol family.
;;;

;; C.
(setq c-default-style "bsd")

;; Go
(use-package go-mode :ensure t
  :config
  (tree-sitter-require 'go))

;; Rust
(use-package rust-mode :ensure t
  :config
  (tree-sitter-require 'rust))

;; Shell scripts.
(reformatter-define shell-script-format
  :program "shfmt"
  :args '("--simplify" "--case-indent" "--func-next-line" "-"))

(add-hook 'shell-script-mode-hook
          shell-script-format-on-save-mode)

;; Python.
(use-package elpy :ensure t
  :config
  (elpy-enable))

;;;
;;; Lisp family.
;;;

(use-package parinfer-rust-mode
  :ensure t
  :init
  (setf parinfer-rust-library "~/.emacs.d/parinfer-rust/libparinfer_rust.so")
  :hook (emacs-lisp-mode scheme-mode common-lisp-mode clojure-mode))

;; Common Lisp

(use-package slime
  :ensure t
  :config
  (setf inferior-lisp-program "/usr/bin/sbcl"))

;; Scheme
(use-package geiser :ensure t)
(use-package geiser-chez :ensure t)
(use-package geiser-chibi :ensure t)
(use-package geiser-gauche :ensure t)
(add-to-list 'auto-mode-alist '("\\.sld" . scheme-mode))

;; Elixir (It's a Lisp, fite me)
(use-package elixir-mode :ensure t)

;;;
;;; Data configuration languages.
;;;

(use-package yaml-mode :ensure t)
(use-package terraform-mode :ensure t)

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

;;;
;;; Prose and notes and such
;;;

(use-package org-roam :ensure t)

(use-package deft
  :ensure t
  :config
  (setq deft-directory "~/org/"))

(use-package markdown-mode :ensure t)

