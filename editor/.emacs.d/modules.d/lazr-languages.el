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
(use-package reformatter)

;;;
;;; Data storage and configuration languages.
;;;

;; Generic configuration files.
(use-package json-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package toml-mode :ensure t)

;; Data exchange format descriptions.
(use-package protobuf-mode :ensure t)

;; Unix system configuration modes.
(use-package ssh-config-mode :ensure t)
(use-package systemd-mode
  :config
  (add-to-list 'auto-mode-alist
               (cons (rx (one-or-more nonl)
                         "."
                         (or "container" "volume" "network"
                             "kube" "image" "build" "pod"))
                     'systemd-mode)))

;; Infrastructure-as-code modes.
(use-package terraform-mode :ensure t)
(use-package nix-mode :ensure t)
(use-package dockerfile-mode :ensure t)

;;;
;;; Template configuration languages.
;;;

(use-package poly-ansible
 
  :config 
  (add-to-list 'auto-mode-alist '(".*\\.ya?ml\\.j2" . poly-ansible-mode)))
 
(use-package feature-mode
 
  :config
  (add-to-list 'auto-mode-alist '(".*\\.feature" . feature-mode)))

(provide 'lazr-languages)
