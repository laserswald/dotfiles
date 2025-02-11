; -*- lexical-binding: t -*-
;; lazr-config --- Lazr's config for Emacs.

;;; Commentary:

;;;; Code:


(require 'cl-lib)

(defvar lz/emacsd-root
  (file-name-directory load-file-name))

(let ((modules-dir (expand-file-name "./modules.d/" user-emacs-directory)))
  (when (file-directory-p modules-dir)
    (message "Adding modules directory to load path: " modules-dir)
    (add-to-list 'load-path modules-dir)))

(setf gc-cons-threshold 10000000
      byte-compile-warnings '(not obsolete)
      warning-suppress-log-types '((comp) (bytecomp))
      native-comp-async-report-warnings-errors 'silent)

;; Stop annoying me about stuff.
(setf inhibit-startup-message t
      vc-follow-symlinks t
      custom-file "~/.emacs.d/custom.el")

;; Move up here so themes can stop bugging me
(load custom-file)

(require 'lazr-core)

(require 'lazr-graphical)
(require 'lazr-shell)
(require 'lazr-org)
(require 'lazr-prog)
(require 'lazr-languages)
(require 'lazr-project)

