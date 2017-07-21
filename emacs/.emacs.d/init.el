(require 'package)

(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
	("gnu" . "https://elpa.gnu.org/packages")))
(package-initialize)

;;;
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package php-mode
  :ensure t)

(use-package magit
  :ensure t)

;;; Evil configuration!
(use-package evil
  :ensure t
  :config

  ;; Sane window movement. Basically the same as my Vim config, tbh
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

  (define-key evil-normal-state-map "gb"
    '(lambda ()
       (interactive)
       (list-buffers)))

  (evil-define-key 'normal dired-mode-map "-" 'dired-up-directory)
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
		      "l" 'split-window-horizontally))

(use-package monochrome-theme
  :ensure t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#080808" "#d70000" "#67b11d" "#875f00" "#268bd2" "#af00df" "#00ffff" "#b2b2b2"])
 '(custom-enabled-themes (quote (xresources)))
 '(custom-safe-themes
   (quote
    ("065efdd71e6d1502877fd5621b984cded01717930639ded0e569e1724d058af8" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (magit php-mode monochrome-theme general xresources-theme spacemacs-theme evil-leader evil-escape goto-last-change evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
