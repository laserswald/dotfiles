(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/")
             '("marmalade" . "http://marmalade-repo.org/packages/")
             )
(package-initialize)

;;;
(defun require-package (pkg)
  (setq-default highlight-tabs t)
  "Installs a package."
  (unless (package-installed-p pkg)
    (unless (assoc pkg package-archive-contents)
      (package-refresh-contents))
    (package-install pkg)))

(require-package 'use-package)

(require-package 'evil-leader)

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader " ")
(evil-leader/set-key
  "w" 'save-buffer
  "wv" 'split-window-horizontally
  "ws" 'split-window-vertically)

(evil-leader/set-key-for-mode 'emacs-lisp-mode "b" 'eval-buffer)

(require 'evil)

(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(define-key evil-normal-state-map (kbd "-") '(lambda () (interactive) (find-file ".")))
(define-key evil-normal-state-map (kbd "-") '(lambda () (interactive) (find-file ".")))

(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t)
(evil-mode 1)

(require-package 'evil-escape)
(require 'evil-escape)
(setq-default evil-escape-key-sequence "jk")
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
    (xresources-theme spacemacs-theme evil-leader evil-escape goto-last-change evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
