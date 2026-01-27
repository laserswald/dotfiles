; -*- lexical-binding: t -*-
;; lazr-config --- Lazr's config for Emacs.

;;; Commentary:

;;;; Code:

(require 'cl-lib)

;;;
;;; Consistent logging of my emacs init
;;;

(defvar lz/messages-enabled nil
  "Should debug messages using lz/message be enabled?")

(defun lz/message (&rest rest)
  "Display a message containing REST but only when the flag lz/messages-enabled is set."
  (when lz/messages-enabled
    (apply #'message rest)))

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
      vc-follow-symlinks t)

;; Don't annoy me about the customizations file.
(setf custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

;; Move up here so themes can stop bugging me
(load custom-file 'noerr)

(require 'lazr-core)
(require 'lazr-graphical)
(require 'lazr-shell)
(require 'lazr-org)
(require 'lazr-prog)
(require 'lazr-languages)
(require 'lazr-project)
(require 'lazr-layout)
(require 'lazr-ai)

