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
(lazr/require-package 'reformatter)

;;;
;;; Data storage and configuration languages.
;;;

;; Generic configuration files.
(lazr/require-package 'yaml-mode)
(lazr/require-package 'toml-mode)

;; Data exchange formats. 
(lazr/require-package 'json-mode)
(lazr/require-package 'protobuf-mode)

;; Unix system configuration modes.
(lazr/require-package 'ssh-config-mode)

(lazr/require-package 'systemd)
(add-to-list 'auto-mode-alist
             (cons (rx (one-or-more nonl)
                       "."
                       (or "container" "volume" "network"
                           "kube" "image" "build" "pod"))
                   'systemd-mode))

;; Infrastructure-as-code modes.
(lazr/require-package 'terraform-mode)
(lazr/require-package 'nix-mode)
(lazr/require-package 'dockerfile-mode)

;;;
;;; Template configuration languages.
;;;

(lazr/require-package 'poly-ansible)
(add-to-list 'auto-mode-alist '(".*\\.ya?ml\\.j2" . poly-ansible-mode))

(lazr/require-package 'feature-mode)
(add-to-list 'auto-mode-alist '(".*\\.feature" . feature-mode))

(provide 'lazr-languages)
