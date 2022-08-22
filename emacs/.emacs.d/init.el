;; lazr-config --- Lazr's config for Emacs.

;;; Commentary:

;;;; Code:

(defvar lz/emacsd-root
  (file-name-directory load-file-name))

(defun lz/load (filename)
  "Load FILENAME directly from my Emacs root."
  (load (concat lz/emacsd-root filename)))

;; Stop annoying me about stuff.
(setq inhibit-startup-message t
      vc-follow-symlinks t
      custom-file "~/.emacs.d/custom.el")

(lz/load "package-setup.el")
(lz/load "core.el")
(lz/load "graphical.el")
(lz/load "shell.el")

(global-display-line-numbers-mode)

;;; Core packages.

(use-package undo-tree :ensure t)

(use-package smart-tabs-mode
  :ensure t
  :config
  (smart-tabs-insinuate 'c 'javascript)
  (add-hook 'php-mode-hook 'smart-tabs-mode-enable))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package persp-mode
  :ensure t)

(lz/load "languages.el")

(use-package smart-tabs-mode
  :ensure t
  :config
  (smart-tabs-insinuate 'c 'javascript)
  (add-hook 'php-mode-hook 'smart-tabs-mode-enable))

(use-package company
  :ensure t
  :config (global-company-mode))

(use-package projectile
  :ensure t

  :init
  (setq projectile-completion-system 'ivy)
  
  :config
  (projectile-mode))

(use-package magit :ensure t)

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package evil-org
  :ensure t

  :after evil org
	
  :init
  (setq org-agenda-files '("~/org"))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-archive-location (concat org-directory "/archive.org::"))
  (setq org-todo-keywords
	'((sequence "TODO" "|" "DONE" "WAIT")
	  (sequence "READY" "INPROGRESS" "REVIEW" "|" "COMPLETE")))

  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-pomodoro
  :ensure t
  :after org)

(use-package treemacs-evil
  :ensure t
  :after evil treemacs)

(use-package treemacs-projectile
  :ensure t
  :after treemacs projectile)

(use-package treemacs-magit
  :ensure t
  :after treemacs magit
  :config)

(use-package dumb-jump :ensure t
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(lz/load "keybindings.el")
(lz/load "custom.el")

(provide 'init)
;;; init.el ends here
