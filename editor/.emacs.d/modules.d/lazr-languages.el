;;;; lazr-languages --- Provide support for programming languages -*- lexical-binding: t; -*-

;;; Commentary:
;;; Packages that are used by many languages.

;;; Code:

(require 'ansi-color)

;; Have the compilation buffer properly show ANSI color escape sequences.
;;
;; Stolen from (http://endlessparentheses.com/ansi-colors-in-the-compilation-buffer-output.html)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region compilation-filter-start (point))))

; Add the colorization to the compilation filter.
(add-hook 'compilation-filter-hook #'endless/colorize-compilation)

;;
;; Define commands that run reformatters on the current buffer.
;;
(use-package reformatter
  :ensure t)

;;;
;;; Data storage and configuration languages.
;;;

(use-package yaml-mode :ensure t)
(use-package toml-mode :ensure t)

(use-package terraform-mode :ensure t)
(use-package nix-mode :ensure t)

(use-package todotxt :ensure t)
(use-package rec-mode :ensure t)

(use-package protobuf-mode :ensure t)
(use-package guix :ensure t)
(use-package dockerfile-mode :ensure t)

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

(provide 'lazr-languages)
