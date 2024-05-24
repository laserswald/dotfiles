;;;; lazr-core --- Core editor features -*- lexical-binding: t -*-

;;; Commentary:
;;;
;;; lazr-core adds fundamental packages that define how Ben uses Emacs.
;;; Currently this will load Evil and friends, along with automatic systems like
;;; spell checking, autocompletion, etc.

;;; Code:


;;;
;;; Core settings.
;;;

;; Show line numbers for every buffer. All of them. No exceptions.
(global-display-line-numbers-mode)

;; Save the current configuration of windows, buffers, etc.
(desktop-save-mode 1)

;;;
;;; Core packages.
;;;

(require 'lazr-package-setup)

;; Provide a tree of undo-states.
(use-package undo-tree
  :ensure t)

;; Provide a better interactive choice dialog than the normal Emacs one.
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))

(use-package company
  :ensure t
  :config (global-company-mode))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package ag
  :ensure t)

(use-package ripgrep
  :ensure t)

(use-package magit
  :ensure t)


(use-package treemacs-evil
  :ensure t
  :after evil treemacs)

(use-package treemacs-magit
  :ensure t
  :after treemacs magit
  :config)

(use-package dumb-jump :ensure t
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package password-store :ensure t)
;;; Evil configuration
(use-package evil
  :ensure t

  :init
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-undo-system 'undo-redo)

  :config
  (evil-mode 1)
  (evil-set-initial-state 'dired-mode 'normal)
  (evil-set-initial-state 'vterm-mode 'emacs)
  ;; Vim-vinegar replacement
  (define-key evil-normal-state-map (kbd "-")
    #'(lambda ()
        (interactive)
        (find-file "."))))

(use-package general
  :ensure t
  :config
  (general-evil-setup))

(use-package evil-collection
  :ensure t

  :after evil

  :init
  (setq evil-collection-mode-list '(dired magit process-menu))

  :config
  (evil-collection-init))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(provide 'lazr-core)

;;; lazr-core.el ends here
