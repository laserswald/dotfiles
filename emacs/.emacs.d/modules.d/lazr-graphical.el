;;; -*- lexical-binding: t -*-

(require 'cl-lib)
(require 'lazr-package-setup)

(use-package all-the-icons :ensure t)

(use-package treemacs :ensure t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(setf custom-theme-directory "~/.emacs.d/themes")

(let ((lazr-custom-theme nil))
  (defun lazr-switch-theme (theme)
    (if lazr-custom-theme
        (disable-theme lazr-custom-theme))
    (setf lazr-custom-theme theme)
    (load-theme lazr-custom-theme t)))

(defvar lazr-theme-pair
  '(doom-solarized-light . doom-solarized-dark)
  "A pair of light and dark themes for switching.")

(defvar lazr-theme-shade
  'light
  "The color theme to choose on startup.")

(defun lazr-apply-theme ()
  "Apply the theme shade."
  (interactive)
  (lazr-switch-theme
   (funcall
    (if (eq lazr-theme-shade 'light) #'car #'cdr)
    lazr-theme-pair)))

(defun lazr-switch-theme-bg ()
  "Switch theme shade from light to dark to light..."
  (interactive)
  (setf lazr-theme-shade
        (cond ((eq lazr-theme-shade 'light) 'dark)
              ((eq lazr-theme-shade 'dark)  'light)
              (t                          (error "Some SHIT happened"))))
  (lazr-apply-theme))

;;;
;;; Fonts
;;;

(defun lazr-font-candidate (&rest fonts)
  "Return the first font in FONTS that exists on the system."
  (cl-find-if (lambda (f)
                (find-font (font-spec :name f)))
              fonts))

;; Automatically detect my favorite fonts, then set all the frames to use them.
(let ((font-size 16)
      (font-face (lazr-font-candidate "Iosevka Nerd Font"
                                      "FiraCode Nerd Font")))

  ;; Add to the settings that new frames will follow
  (add-to-list 'default-frame-alist
               (cons 'font (concat font-face "-" (number-to-string font-size)
                                   ":weight=medium")))

  ;; Set the current frame's font as well.
  (set-frame-font font-face t))

;; Themes

(use-package doom-themes :ensure t)
(use-package modus-themes :ensure t)
(use-package ef-themes :ensure t)
(use-package doom-modeline :ensure t
  :init (setf doom-modeline-height 32)
  :config (doom-modeline-mode 1))

(defun lazr-setup-graphical ()
  "Configure and enable modes and settings used during dedicated windows."

  ;; Enable scrolling that allows for views unbound by character cells
  (pixel-scroll-mode)

  ;; Enable the right-click menu.
  (context-menu-mode)

  (lazr-apply-theme))


(defun lazr-setup-terminal ()
  "Set up Emacs for use within a terminal."

  ;; Fix some strangeness with faces in the terminal.
  (set-face-background 'default "background")
  (set-face-foreground 'font-lock-keyword-face "green")
  (set-face-foreground 'font-lock-comment-face "black")
  (set-face-foreground 'font-lock-variable-name-face "blue")
  (set-face-foreground 'elscreen-tab-control-face "blue"))

(if (display-graphic-p)
    (lazr-setup-graphical)
  (lazr-setup-terminal))

(provide 'lazr-graphical)
