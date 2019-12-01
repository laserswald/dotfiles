;;; lazr-config --- Lazr's config for Emacs.

;;;; Settings.

;; Clean up the GUI.
(tool-bar-mode -1)
(menu-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(add-to-list 'default-frame-alist
	     '(font . "Input Mono-9"))

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

(use-package lsp-mode :ensure t)

(use-package php-mode :ensure t)
(use-package ac-php :ensure t
  :config
  (add-hook 'php-mode-hook
	    '(lambda ()
	       (company-mode t)
	       (require 'company-php)
	       (ac-php-core-eldoc-setup)
	       (set (make-local-variable 'company-backends)
		    '((company-ac-php-backend company-dabbrev-code)
		      company-capf company-files)))))

(use-package php-eldoc
  :ensure t
  :config
  (php-eldoc-enable)
  (add-hook 'php-mode-hook 'php-mode-options))

(use-package phpunit :ensure t)

(use-package slime
  :ensure t
  :config
  (setf inferior-lisp-program "/usr/bin/sbcl"))

(use-package undo-tree :ensure t)
(use-package speedbar :ensure t)

(use-package smart-tabs-mode
  :ensure t
  :config
  (smart-tabs-insinuate 'c 'javascript)
  (add-hook 'php-mode-hook 'smart-tabs-mode-enable))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))

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

(use-package general :ensure t :config (general-evil-setup))

(use-package evil-collection
  :after 'evil
  :ensure t)

(evil-collection-init)

(use-package evil-magit
  :after '(evil magit)
  :ensure t)

(evil-magit-init)

;;; Keybindings.

(general-define-key :states 'normal "/" 'swiper)

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
		    "B" 'list-bookmarks ; Bookmark
		    "F" 'counsel-find-file
		    "f" 'projectile-find-file)


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
		 "a" 'magit-stage-file)

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

(if (display-graphic-p)
    (progn
      (use-package xresources-theme :ensure t)
      (use-package monochrome-theme :ensure t)
      (use-package nord-theme :ensure t)
      (use-package zenburn-theme :ensure t)
      (use-package gruvbox-theme :ensure t)
      (enable-theme 'gruvbox))
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
    ("585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739" "1195d71dfd46c43492993a528336ac7f8c7400b4c58338e5b40329d6cad655b6" "2b9dc43b786e36f68a9fd4b36dd050509a0e32fe3b0a803310661edb7402b8b6" default)))
 '(package-selected-packages
   (quote
    (lsp-mode slime zenburn-theme xresources-theme use-package smartparens smart-tabs-mode phpunit phoenix-dark-mono-theme nordless-theme nord-theme monochrome-theme lua-mode ivy helm-projectile haskell-mode gruvbox-theme general geiser flycheck evil-tabs evil-surround evil-org evil-matchit evil-magit evil-exchange evil-escape evil-ediff evil-collection company ac-php))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
