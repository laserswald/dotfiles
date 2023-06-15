;;;;
;;;; Language support.
;;;;

;;; Meta packages.

;; Stolen from (http://endlessparentheses.com/ansi-colors-in-the-compilation-buffer-output.html)
(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

;; Go
(use-package go-mode :ensure t)

;; Rust
(use-package rust-mode :ensure t)

(use-package eglot
  :commands eglot-ensure
  :ensure t
  :init
  (dolist (hook-mode '(c-mode-hook
                       go-mode-hook
                       rust-mode-hook
                       python-mode-hook))
    (add-hook hook-mode #'eglot-ensure)))

(use-package flycheck-eglot :ensure t)

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
(use-package terraform-mode :ensure t)

;;; Template configuration languages.

(use-package poly-ansible
  :ensure t
  :config 
  (add-to-list 'auto-mode-alist '(".*\\.ya?ml\\.j2" . poly-ansible-mode)))
 
;;; Python.

(use-package deft
  :ensure t
  :config
  (setq deft-directory "~/org/"))

(use-package feature-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '(".*\\.feature" . feature-mode)))

(use-package dockerfile-mode
  :ensure t)
