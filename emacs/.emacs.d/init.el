;; lazr-config --- Lazr's config for Emacs.

;;;; Settings.

;; Clean up the GUI.
(tool-bar-mode -1)
(menu-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(add-to-list 'default-frame-alist
	     '(font . "Fira Code-9"))

;; Stop annoying me about stuff.
(setq inhibit-startup-message t
      vc-follow-symlinks t)

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

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

(use-package doom-modeline :ensure t
  :config (doom-modeline-mode 1))

(use-package all-the-icons
  :ensure t)

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

(use-package php-mode :ensure t)

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
  (setq org-archive-location (concat org-directory "/archive.org"))
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
  :after 'evil
  :ensure t)

(evil-collection-init)

(use-package evil-magit
  :after '(evil magit)
  :ensure t)

(evil-magit-init)

(use-package treemacs-evil
  :ensure t
  :after evil treemacs
  :config)

(use-package treemacs-projectile
  :ensure t
  :after treemacs projectile
  :config)

(use-package treemacs-magit
  :ensure t
  :after treemacs magit
  :config)

(use-package dumb-jump :ensure t
  :config
  (dumb-jump-mode))

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
		    "b" 'helm-buffers-list ; buffer
		    "B" 'helm-bookmarks ; Bookmark
		    "F" 'counsel-find-file
		    "f" 'projectile-find-file
		    "d" 'dumb-jump-go)

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

(lazr-local-leader-map :keymaps 'emacs-lisp-mode-map 
                       "eb" 'lazr-eval-buffer)

(lazr-local-leader-map :keymaps 'org-mode-map 
                       "t" 'org-todo)

(unless (display-graphic-p)
  (set-face-background 'default "background")
  (set-face-foreground 'font-lock-keyword-face "green")
  (set-face-foreground 'font-lock-comment-face "black")
  (set-face-foreground 'font-lock-variable-name-face "blue")
  (set-face-foreground 'elscreen-tab-control-face "blue"))

(provide 'init)
;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("1ed5c8b7478d505a358f578c00b58b430dde379b856fbcb60ed8d345fc95594e" "a83f05e5e2f2538376ea2bfdf9e3cd8b7f7593b16299238c1134c1529503fa88" "f9cae16fd084c64bf0a9de797ef9caedc9ff4d463dd0288c30a3f89ecf36ca7e" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" "845103fcb9b091b0958171653a4413ccfad35552bc39697d448941bcbe5a660d" default)))
 '(dumb-jump-mode t)
 '(package-selected-packages
   (quote
    (doom-themes persp-mode doom-modeline dumb-jump treemacs-magit treemacs-projectile treemacs-evil which-key editorconfig treemacs zenburn-theme xresources-theme web-mode use-package spaceline smart-tabs-mode smart-mode-line slime phpunit php-eldoc perspective org-pomodoro nord-theme monochrome-theme lsp-mode ivy helm-projectile gruvbox-theme general flycheck evil-tabs evil-surround evil-org evil-magit evil-escape evil-ediff evil-collection company ac-php)))
 '(persp-mode t nil (persp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
