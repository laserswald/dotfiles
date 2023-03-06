;;;;
;;;; Language support.
;;;;

;;; Meta packages.

(use-package lsp-mode :ensure t)
(use-package lsp-ivy :ensure t)
(use-package lsp-ui :ensure t)

;;;
;;; Algol family.
;;;

;; C
(add-hook 'c-mode-hook #'lsp)

;; C++
(add-hook 'c++-mode-hook #'lsp)

;; PHP
(add-hook 'php-mode-hook #'lsp)

;; Go
(use-package go-mode :ensure t)
(add-hook 'go-mode-hook #'lsp)

;; Rust
(use-package rust-mode :ensure t)
(add-hook 'rust-mode-hook #'lsp)

;;; Lisp family.

(use-package parinfer-rust-mode
  :ensure t
  :init
  (setf parinfer-rust-library "~/.emacs.d/parinfer-rust/libparinfer_rust.so")
  :hook (emacs-lisp-mode scheme-mode common-lisp-mode clojure-mode))

;; Common Lisp
(use-package slime
  :ensure 
  :config
  (setf inferior-lisp-program "/usr/bin/sbcl"))

;; Scheme

(use-package geiser :ensure t)
(use-package geiser-chez :ensure t)
(use-package geiser-chibi :ensure t)
(use-package geiser-gauche :ensure t)

(add-to-list 'auto-mode-alist '("\\.sld" . scheme-mode))

;;; Data configuration languages.

(use-package yaml-mode :ensure t)

;;; Template configuration languages.

(use-package poly-ansible
  :ensure t
  :config 
  (add-to-list 'auto-mode-alist '(".*\\.ya?ml\\.j2" . poly-ansible-mode)))
 
;;; Python.
(add-hook 'python-mode-hook #'lsp)

(use-package deft
  :ensure t
  :config
  (setq deft-directory "~/org/"))
