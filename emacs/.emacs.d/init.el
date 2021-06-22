;; lazr-config --- Lazr's config for Emacs.

;;; Commentary:

;;;; Code:

;; Clean up the GUI.

(tool-bar-mode -1)

(menu-bar-mode -1)

(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(global-display-line-numbers-mode)

;; Fonts.
(let ((font-size 13)
      (font-face "Fira Code NF"))
  (add-to-list 'default-frame-alist
	       (cons 'font (concat font-face "-" (number-to-string font-size)))))

;; Stop annoying me about stuff.
(setq inhibit-startup-message t
      vc-follow-symlinks t
      custom-file "~/.emacs.d/custom.el")

;;;; Package setup.
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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

;;; Fun-damental packages for look and feel, etc.

(use-package doom-themes :ensure t :config (load-theme 'doom-tomorrow-night t))
(use-package doom-modeline :ensure t :config (doom-modeline-mode 1))
(use-package all-the-icons :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :config)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package persp-mode
  :ensure t)

;;; Languages.

(use-package lsp-mode :ensure t
  :hook (php-mode . lsp)
  :commands lsp)

(use-package lsp-ivy :ensure t :commands lsp-ivy-workspace-symbol)

;;;; PHP.

(use-package ac-php :ensure t 
  :config
  (add-hook 'php-mode-hook
	    '(lambda ()
	       (company-mode t)
	       (require 'company-php)
	       (set (make-local-variable 'company-backends)
		    '((company-ac-php-backend company-dabbrev-code)
		      company-capf company-files)))))

(use-package phpunit :ensure t)

(use-package slime
  :ensure t
  :config
  (setf inferior-lisp-program "/usr/bin/sbcl"))

(use-package undo-tree :ensure t)

(use-package smart-tabs-mode
  :ensure t
  :config
  (smart-tabs-insinuate 'c 'javascript)
  (add-hook 'php-mode-hook 'smart-tabs-mode-enable))

(use-package counsel :ensure t :config (ivy-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package company :ensure t :config (global-company-mode))

(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-completion-system 'ivy))

(use-package magit :ensure t)

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

  

;;; Evil configuration!
(use-package evil
  :ensure t

  :init
  (setq evil-want-integration t
	evil-want-keybinding nil)

  :config
  (evil-mode 1)
  (evil-set-initial-state 'dired-mode 'normal)
  ;; Vim-vinegar replacement
  (define-key evil-normal-state-map (kbd "-")
    '(lambda ()
       (interactive)
       (find-file "."))))

(use-package evil-org
  :ensure t

  :after org
	
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

(use-package org-pomodoro :ensure t :after org)

(use-package general :ensure t :config (general-evil-setup))

(use-package evil-collection
  :after evil
  :ensure t

  :init 
  (setq evil-collection-mode-list '(dired))

  :config
  (evil-collection-init))

;; (use-package evil-magit
;;   :after '(evil magit)
;;   :ensure t
;;   :config (evil-magit-init))

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

;;; Keybindings.

(general-nmap dired-mode-map "-" 'dired-up-directory)

(general-create-definer lazr-leader-map
  :states 'normal
  :prefix "SPC")

(general-create-definer lazr-local-leader-map
  :states 'normal
  :prefix ",")

;; Window movement with C-hjkl
(general-define-key "C-h" 'evil-window-left
		    "C-j" 'evil-window-down
		    "C-k" 'evil-window-up
		    "C-l" 'evil-window-right)

;; Go to ...
(general-define-key :states 'normal :prefix "g"
		    "a" 'evil-switch-to-windows-last-buffer ; alternate
		    "b" 'ivy-switch-buffer ; buffer
		    "B" 'counsel-bookmark ; Bookmark
		    "F" 'counsel-find-file
		    "f" 'projectile-find-file
		    "d" 'xref-find-definitions)

(lazr-local-leader-map
  "w" 'save-buffer)

;; 'W'indow manipulation
(lazr-leader-map :infix "w"
  "c" 'kill-buffer
  "j" 'split-window-vertically
  "l" 'split-window-horizontally)

;;; 'P'roject tools
(lazr-leader-map "p" 'projectile-command-map)

;;; 'V'ersion control
(lazr-leader-map :infix "v"
  "s" 'magit-status
  "a" 'magit-stage-file
  "c" 'magit-commit)

;;; 'O'rg mode
(lazr-leader-map :infix "o"
  "l" 'org-store-link
  "a" 'org-agenda
  "c" 'org-capture
  "p" 'org-pomodoro)

;;; X for perspective mode because too many things start with P
(lazr-leader-map :infix "x"
  "x" 'persp-switch
  "p" 'persp-prev
  "n" 'persp-next)
  
;;; File type specific tools
(lazr-local-leader-map :keymaps 'php-mode-map
  "ta" 'phpunit-current-project
  "tt" 'phpunit-current-test
  "tc" 'phpunit-current-class)

(defun lazr-eval-buffer ()
  "Evaluate a buffer and say something about it."
  (interactive)
  (eval-buffer)
  (message "Evaluated."))

(lazr-local-leader-map :keymaps 'emacs-lisp-mode-map "eb" 'lazr-eval-buffer)
(lazr-local-leader-map :keymaps 'org-mode-map "t" 'org-todo)

(unless (display-graphic-p)
  (set-face-background 'default "background")
  (set-face-foreground 'font-lock-keyword-face "green")
  (set-face-foreground 'font-lock-comment-face "black")
  (set-face-foreground 'font-lock-variable-name-face "blue")
  (set-face-foreground 'elscreen-tab-control-face "blue"))

;;; Get the fuck rid of Custom. Just go.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(provide 'init)
;;; init.el ends here

