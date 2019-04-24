
;;; Code:

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


(use-package php-mode :ensure t)
(use-package phpunit :ensure t)
(use-package magit :ensure t)
(use-package undo-tree :ensure t)

(use-package smart-tabs-mode
  :ensure t
  :config
  (smart-tabs-insinuate 'c 'javascript)
  (add-hook 'php-mode-hook 'smart-tabs-mode-enable))

(use-package projectile :ensure t :config (projectile-mode))

(use-package helm
  :ensure t
  :config
  (setq projectile-completion-system 'helm))

(use-package helm-projectile
  :ensure t
  :after '(helm projectile)
  :config
  (helm-projectile-on))

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
  (evil-mode)

  :config
  (evil-set-initial-state 'dired-mode 'normal)
  ;; Hotsequences ;;
  
  ;; Vim-vinegar replacement
  (evil-define-key 'normal 'dired-mode-map "-" 'dired-jump)
  (define-key evil-normal-state-map (kbd "-")
    '(lambda ()
       (interactive)
       (find-file "."))))

;; I neeeeed my jk
(use-package evil-escape
    :ensure t
    :after evil
    :config
    (setq-default evil-escape-key-sequence "jk")
    (evil-escape-mode))

(use-package general :ensure t :config (general-evil-setup))
(use-package evil-ediff :after evil :ensure t)
(use-package evil-magit :after '(evil magit) :ensure t)
(use-package evil-surround :after evil :ensure t)
(use-package evil-collection :after evil :ensure t :config (evil-collection-init))
(use-package evil-tabs :after evil :ensure t :config (global-evil-tabs-mode t))
(use-package company :ensure t :config (global-company-mode))

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

;;; Keybindings.

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
		    "b" 'helm-buffers-list)                 ; buffer

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
      (enable-theme 'zenburn))
  (set-face-background 'default "background")
  (set-face-foreground 'font-lock-keyword-face "green")
  (set-face-foreground 'font-lock-comment-face "black")
  (set-face-foreground 'font-lock-variable-name-face "blue")
  (set-face-foreground 'elscreen-tab-control-face "blue"))

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

(provide 'init)
;;; init.el ends here
