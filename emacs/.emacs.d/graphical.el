(require 'cl-lib)

(use-package all-the-icons :ensure t)
(use-package treemacs :ensure t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(setf custom-theme-directory "~/.emacs.d/themes")

(defvar lz/theme-pair (cons 'modus-operandi 'modus-vivendi)
  "A pair of light and dark themes for switching.")

(defvar lz/theme-shade 'dark)

(defun lz/apply-theme ()
  "Apply the theme shade."
  (load-theme
   (funcall
    (if (eq lz/theme-shade 'light) #'car #'cdr)
    lz/theme-pair)))

(defun lz/switch-theme-bg ()
  "Switch theme shade from light to dark to light..."
  (interactive)
  (setq lz/theme-shade
        (cond
         ((eq lz/theme-shade 'light) 'dark)
         ((eq lz/theme-shade 'dark)  'light)
         (t                          (error "Some SHIT happened"))))
  (lz/apply-theme))

;; Fonts

(defun font-candidate (&rest fonts)
  "Return the first font in FONTS that exists on the system."
  (cl-find-if (lambda (f)
	        (find-font (font-spec :name f)))
	      fonts))

(let ((font-size 16)
      (font-face (font-candidate "CMUTypewriter NF:style=Regular"
				 "FiraCode Nerd Font")))

  (add-to-list 'default-frame-alist
         (cons 'font (concat font-face ":size=" (number-to-string font-size))))
  (set-frame-font font-face t))

;; Themes

(use-package doom-themes :ensure t)
(use-package modus-themes :ensure t :config (lz/apply-theme))
(use-package ef-themes :ensure t)
(use-package doom-modeline :ensure t :config (doom-modeline-mode 1))

(unless (display-graphic-p)
  (set-face-background 'default "background")
  (set-face-foreground 'font-lock-keyword-face "green")
  (set-face-foreground 'font-lock-comment-face "black")
  (set-face-foreground 'font-lock-variable-name-face "blue")
  (set-face-foreground 'elscreen-tab-control-face "blue"))

