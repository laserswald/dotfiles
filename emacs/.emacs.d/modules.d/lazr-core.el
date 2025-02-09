;;;; lazr-core --- Core editor features -*- lexical-binding: t -*-

;;; Commentary:
;;;
;;; lazr-core adds fundamental packages that define how Ben uses Emacs.
;;; Currently this will load Evil and friends, along with automatic systems like
;;; spell checking, autocompletion, etc.

;;; Code:

(require 'lazr-package-setup)

;;
;; Built-in Emacs packages
;;

; Directory editor
(use-package dired
  :config
  (add-hook 'dired-mode-hook
            (lambda () (dired-omit-mode))))

; Provide a better interactive choice dialog than the normal Emacs one.
(use-package ivy :ensure t
  :config
  (ivy-mode 1))

; Completion framework
(use-package company :ensure t
  :config
  (global-company-mode))

; On-the-fly checking.
(use-package flycheck :ensure t
  :config
  (global-flycheck-mode))

; Git integration.
(use-package magit :ensure t)

; Per-project configurations for indentation, etc.
(use-package editorconfig :ensure t
  :config
  (editorconfig-mode 1))

;; Searching and navigating.

; Search quickly
(use-package ripgrep :ensure t)

; Use dumb jump if we don't have a smart enough code searcher
(use-package dumb-jump :ensure t
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

; Interface to the `pass` password vault.
(use-package password-store :ensure t)

;;
;; Extensible Vi Layer.
;;

; Configure the Evil layer.
(use-package evil :ensure t

  :init
  (setq evil-want-integration t
	evil-want-keybinding  nil
	evil-undo-system      'undo-redo)

  :config

  ; Enable vi keybindings.
  (evil-mode 1)

  ; When in Dired, use normal mode, since dired has pretty good keybindings already
  (evil-set-initial-state 'dired-mode 'normal)

  ; Use Emacs mode for vterms.
  (evil-set-initial-state 'vterm-mode 'emacs)

  ; Vim-vinegar replacement
  (define-key evil-normal-state-map (kbd "-")
    #'(lambda () (find-file "."))))

; Provide a tree of undo-states. Needed by Evil.
(use-package undo-tree :ensure t)

; Extra keybindings for default Evil stuff.
(use-package evil-collection :ensure t
  :after evil
  :init
  (setq evil-collection-mode-list '(dired magit process-menu notmuch))
  :config
  (evil-collection-init))

;;
;; Communication tools.
;;

; Interface for high speed mail searcher
(use-package notmuch :ensure t)

; Search using Counsel
(use-package counsel-notmuch :ensure t)

;;
;; Core settings.
;;

; Save the current configuration of windows, buffers, etc.
(desktop-save-mode -1)

(provide 'lazr-core)
;;; lazr-core.el ends here
