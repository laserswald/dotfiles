;; lazr-config --- Lazr's config for Emacs.

;;; Commentary:

;;;; Code:

(setq gc-cons-threshold 10000000
      byte-compile-warnings '(not obsolete)
      warning-suppress-log-types '((comp) (bytecomp))
      native-comp-async-report-warnings-errors 'silent)

(require 'cl-lib)

(defvar lz/emacsd-root
  (file-name-directory load-file-name))

(defun lz/load (filename)
  "Load FILENAME directly from my Emacs root."
  (load (concat lz/emacsd-root filename)))

;; Stop annoying me about stuff.
(setq inhibit-startup-message t
      vc-follow-symlinks t
      custom-file "~/.emacs.d/custom.el")

;; Move up here so themes can stop bugging me
(lz/load "custom.el")

(lz/load "package-setup.el")
(lz/load "core.el")
(lz/load "graphical.el")
(lz/load "shell.el")

(global-display-line-numbers-mode)
(desktop-save-mode 1)

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

(use-package company
  :ensure t
  :config (global-company-mode))

(use-package projectile
  :ensure t

  :init
  (setq projectile-completion-system 'ivy)
  
  :config
  (projectile-mode))

(use-package ag :ensure t)
(use-package ripgrep :ensure t)

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

(use-package password-store :ensure t)


(eval-after-load 'tramp '(progn (setenv "SHELL" "/bin/bash")
				(setenv "TERM" "ansi")))

(lz/load "keybindings.el")

(defvar lz/theme-pair
  (cons 'modus-operandi 'modus-vivendi))

(defvar lz/theme-shade 'light)

(defun lz/apply-theme ()
  "Apply the theme shade"
  (load-theme
   (funcall
    (if (eq lz/theme-shade 'light) #'car #'cdr)
    lz/theme-pair)))

(defun lz/switch-theme-bg ()
  "Switch theme shade from light to dark to light..."
  (interactive)
  (setf lz/theme-shade
	(cond
	 ((eq lz/theme-shade 'light) 'dark)
	 ((eq lz/theme-shade 'dark)  'light)
	 (t
	  (error "Some SHIT happened"))))
  (lz/apply-theme))

(defvar lz/open-terminal-count 0)
(defun lz/open-terminal ()
  "Open a new terminal instance."
  (interactive)
  (term explicit-shell-file-name)
  (rename-buffer (format "*terminal-%d*" lz/open-terminal-count))
  (setq lz/open-terminal-count (+ lz/open-terminal-count 1)))

(provide 'init)
;;; init.el ends here
