;;;; lazr-core --- Core editor features -*- lexical-binding: t -*-

;;; Commentary:
;;;
;;; lazr-core adds fundamental packages that define how Ben uses Emacs.
;;; Currently this will load Evil and friends, along with automatic systems like
;;; spell checking, autocompletion, etc.

;;; Code:

(require 'lazr-package-setup "./lazr-package-setup.el")
(require 'lazr-keybindings "./lazr-keybindings.el")

;;
;; Built-in Emacs packages
;;

;; Directory editor
(use-package dired
  :after evil
  :config
  (add-hook 'dired-mode-hook
            (lambda () (dired-omit-mode)))
  (evil-define-key 'normal dired-mode-map "-" 'dired-up-directory)
  ;; When in Dired, use normal mode, since dired has pretty good keybindings already
  (evil-set-initial-state 'dired-mode 'normal)
  (put 'dired-find-alternate-file 'disabled nil))

;; Remote file editing
(use-package tramp
  :config
  (setenv "TERM" "ansi"))


;; Provide a better interactive choice dialog than the normal Emacs one.
(use-package ivy 
  :config
  (ivy-mode 1))

;; Snippets management
(use-package yasnippet 
  :config
  (yas-global-mode 1))

;;; Searching and navigating.

(use-package counsel 
  :config (ivy-mode 1))

;; Search quickly
(use-package ripgrep )

;; Use dumb jump if we don't have a smart enough code searcher
(use-package dumb-jump 
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

;; Interface to the `pass` password vault.
(use-package password-store )

;;
;; Communication tools.
;;

; Interface for high speed mail searcher
(use-package notmuch :ensure t
  :config
  (evil-set-initial-state '(notmuch-hello-mode
                            notmuch-search-mode
                            notmuch-tree-mode
                            notmuch-show-mode)
                          'emacs))

;; Search using Counsel
(use-package counsel-notmuch)

;;
;; Functions 
;;

(defun lz/symcat-soft (&rest symbols)
  "Get the symbol created by concatenating the SYMBOLS together with '-'."
  (intern-soft (mapconcat #'symbol-name symbols "-")))

(defun lz/sym-mode (sym)
  "Get the mode hook for the language SYM."
  (lz/symcat-soft sym 'mode))

(defun lz/choose-randomly (sequence)
  "Choose one item randomly out of the SEQUENCE."
  (if (zerop (length sequence))
    (error "No choices available")
    (elt sequence (random (length sequence)))))

;;
;; Core settings.
;;

(desktop-save-mode -1) ; Save the current configuration of windows, buffers, etc.

(provide 'lazr-core)

;;; lazr-core.el ends here
