
(tool-bar-mode -1)
(menu-bar-mode -1)

(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
;; Fonts
(let ((font-size 12)
      (font-face "Fira Code Retina"))
  (add-to-list 'default-frame-alist
	       (cons 'font (concat font-face "-" (number-to-string font-size)))))

(setf custom-theme-directory "~/.emacs.d/themes")

(use-package doom-themes :ensure t :config (load-theme 'doom-tomorrow-night t))
(use-package doom-modeline :ensure t :config (doom-modeline-mode 1))
(use-package all-the-icons :ensure t)
(use-package treemacs :ensure t)

(unless (display-graphic-p)
  (set-face-background 'default "background")
  (set-face-foreground 'font-lock-keyword-face "green")
  (set-face-foreground 'font-lock-comment-face "black")
  (set-face-foreground 'font-lock-variable-name-face "blue")
  (set-face-foreground 'elscreen-tab-control-face "blue"))

(load-theme 'doom-gruvbox t)

