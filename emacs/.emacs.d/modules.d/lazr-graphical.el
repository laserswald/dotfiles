;;;; -*- lexical-binding: t -*-
;;;;
;;;; lazr-graphical.el - Graphics, UI, etc.


(require 'cl-lib)
(require 'lazr-package-setup)

;;
;; User interface components: turning things on and off to look nice
;;

; Disable the toolbar.
(tool-bar-mode -1)

; Disable the menu bar.
(menu-bar-mode -1)

; If the scroll bar is available, disable it.
(when (boundp 'scroll-bar-mode) (scroll-bar-mode -1))

; Show line numbers for every buffer. All of them. No exceptions.
(global-display-line-numbers-mode)

;; Modeline.
(use-package doom-modeline :ensure t
  :init (setf doom-modeline-height 32)
  :config (doom-modeline-mode 1))

; Icons for the modeline.
(use-package all-the-icons :ensure t)

; User interface for quickly browsing hierarchies in code and files.
(use-package treemacs :ensure t)

; Use evil mode bindings for Treemacs.
(use-package treemacs-evil :ensure t
  :after evil treemacs)

; Integrate Magit with Treemacs
(use-package treemacs-magit :ensure t
  :after treemacs magit
  :config)

;;;
;;; Themes
;;;

(use-package doom-themes :ensure t)
(use-package modus-themes :ensure t)
(use-package ef-themes :ensure t)

(defun lazr-setup-graphical ()
  "Configure and enable modes and settings used during dedicated windows."

  ; Enable scrolling that allows for views unbound by character cells
  (pixel-scroll-mode)

  ; Enable the right-click menu.
  (context-menu-mode)

  (lazr-setup-fonts
   "Fira Code Nerd Font"
   "Victor Mono Nerd Font")

  ; Apply my theme.
  (lazr-apply-theme))

(defun lazr-setup-terminal ()
  "Set up Emacs for use within a terminal."

  (load-theme 'chameleon)

  (xterm-mouse-mode 1))

(setf custom-theme-directory "~/.emacs.d/themes")

(let ((lazr-custom-theme nil))
  (defun lazr-switch-theme (theme)
    "Save and switch to the given theme."
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
              (t                            (error "Some SHIT happened"))))
  (lazr-apply-theme))

;;;
;;; Fonts
;;;

(defun lazr-setup-fonts (&rest fonts)
  "Find the first font in the list FONTS that exists on the system, and then set it as the default font."
  (let ((font-size 16)
        (font-face (cl-find-if (lambda (f)
                                 (find-font (font-spec :name f)))
                               fonts)))

    (unless font-face
      (error "Could not find a font"))

    ;; Add to the settings that new frames will follow
    (add-to-list 'default-frame-alist
      `(font ,(concat font-face " " (number-to-string font-size))))

    ;; Set the current frame's font as well.
    (set-frame-font font-face t)))

(if (display-graphic-p)
    (lazr-setup-graphical)
  (lazr-setup-terminal))

(provide 'lazr-graphical)
