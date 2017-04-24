(require 'package)
(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/"))
(package-initialize)

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

(require 'evil-escape)
(setq-default evil-escape-key-sequence "jk")
(evil-escape-mode)
