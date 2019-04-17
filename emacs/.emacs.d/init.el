
;;;; Settings.

;;; Screw your tool and menu bars.
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t)

;;; For real, leave me alone about this.
(setq vc-follow-symlinks t)

(add-to-list 'default-frame-alist
	     '(font . "Fira Code-9"))

;;;; Package setup.
(require 'package)
(setq package-archives
           '(("melpa" . "https://melpa.org/packages/")
	    ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(use-package php-mode :ensure t)
(use-package phpunit :ensure t)
(use-package magit :ensure t)
(use-package undo-tree :ensure t)

(use-package smart-tabs-mode
  :ensure t
  :config
  (smart-tabs-insinuate 'php-mode 'c 'javascript))

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode))

(use-package helm
  :ensure t
  :config
  (setq projectile-completion-system 'helm))

(use-package helm-projectile
  :ensure t
  :after '(helm projectile)
  :config
  (helm-projectile-on))


;;; Evil configuration!
(use-package evil
  :ensure t

  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)

  :config

  ;; Window movement with C-hjkl
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

  ;; Hotsequences 

  (define-key evil-normal-state-map "gb" 'helm-buffers-list)
  (define-key evil-normal-state-map "ga" 'evil-switch-to-windows-last-buffer)
  (define-key evil-normal-state-map "gs" 'magit-status)

  (evil-define-key 'normal dired-mode-map "-" 'dired-up-directory)
  (evil-set-initial-state 'dired-mode 'normal)
  (define-key evil-normal-state-map (kbd "-")
    '(lambda ()
       (interactive)
       (find-file ".")))

  ;; I neeeeed my jk
  (use-package evil-escape
    :ensure t
    :config
    (setq-default evil-escape-key-sequence "jk")
    (evil-escape-mode))

  (evil-mode 1))

(use-package general
  :ensure t
  :config
  (setq general-default-keymaps 'evil-normal-state-map)
  (setq general-default-prefix "SPC")

  ;; Window manipulation
  (general-define-key :infix "w"
		      "j" 'split-window-vertically
		      "l" 'split-window-horizontally
		      "c" 'kill-buffer)

  (general-define-key "p" 'projectile-command-map))

(use-package evil-ediff
  :after evil
  :ensure t)

(use-package evil-magit
  :after evil
  :after magit
  :ensure t)

(use-package evil-surround
  :after evil
  :ensure t)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-tabs
  :after evil
  :ensure t
  :config
  (global-evil-tabs-mode t))

(use-package company
  :ensure t
  :config
  (global-company-mode))

(use-package evil-org
  :after org
  :ensure t
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; (load "lisp/xresources-theme/xresources-theme")

(use-package xresources-theme :ensure t)
(use-package monochrome-theme :ensure t)
(use-package nord-theme :ensure t)
(use-package zenburn-theme :ensure t)
(enable-theme 'zenburn)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#080808" "#d70000" "#67b11d" "#875f00" "#268bd2" "#af00df" "#00ffff" "#b2b2b2"])
 '(custom-safe-themes
   (quote
    ("39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569" "065efdd71e6d1502877fd5621b984cded01717930639ded0e569e1724d058af8" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (smart-tabs-mode helm-projectile phpunit phpunit\.el zenburn-theme evil-org evil-tabs nord-theme helm evil-collection evil-surround evil-ediff evil-magit ## magit php-mode general evil-leader evil-escape goto-last-change evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
