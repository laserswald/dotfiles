;;;; -*- lexical-binding: t -*-
;;;;
;;;; lazr/graphical.el - Graphics, UI, etc.


(require 'cl-lib)
(require 'lazr-package-setup)

(lz/message "Loading graphical.el")

;;
;; User interface components: turning things on and off to look nice
;;

;; Disable the toolbar.
(tool-bar-mode -1)

;; Disable the menu bar.
(menu-bar-mode -1)

;; If the scroll bar is available, disable it.
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Show line numbers for every buffer. All of them. No exceptions.
(global-display-line-numbers-mode)

;; Modeline.
(use-package doom-modeline
  :init (setf doom-modeline-height 32)
  :config (doom-modeline-mode 1))

;; Icons for the modeline.
(use-package nerd-icons :ensure t)

;; User interface for quickly browsing hierarchies in code and files.
(use-package treemacs :ensure t)

;; Use evil mode bindings for Treemacs.
(use-package treemacs-evil :ensure t
  :after evil treemacs)

;; Integrate Magit with Treemacs
(use-package treemacs-magit :ensure t
  :after treemacs magit
  :config)

;;;
;;; Themes
;;;

(use-package doom-themes)
(use-package modus-themes)
(use-package ef-themes)

(setf custom-theme-directory "~/.emacs.d/themes")

(let ((lazr/custom-theme nil))
  (defun lazr/switch-theme (theme)
    "Save and switch to the given theme."
    (if lazr/custom-theme
        (disable-theme lazr/custom-theme))
    (setf lazr/custom-theme theme)
    (load-theme lazr/custom-theme)))

(defvar lazr/theme-pair
  '(doom-tomorrow-day . doom-tomorrow-night)
  "A pair of light and dark themes for switching.")

(defvar lazr/theme-shade
  'light
  "The color theme to choose on startup.")

(defun lazr/apply-theme ()
  "Apply the theme shade."
  (interactive)
  (lazr/switch-theme
   (funcall
    (if (eq lazr/theme-shade 'light) #'car #'cdr)
    lazr/theme-pair)))

(defun lazr/switch-theme-bg ()
  "Switch theme shade from light to dark to light..."
  (interactive)
  (setf lazr/theme-shade
        (cond ((eq lazr/theme-shade 'light) 'dark)
              ((eq lazr/theme-shade 'dark)  'light)
              (t                            (error "Some SHIT happened"))))
  (lazr/apply-theme))

;;;
;;; Fonts
;;;

(defun lazr/set-font-all! (font)
  "Set the font for all frames at once."
  (dolist (frame (frame-list))
    (set-frame-font font nil t)))

(defvar lazr/fonts
  (list
   "Victor Mono Nerd Font"
   "CMUTypewriter NF"
   "Terminess Nerd Font"
   "Fira Code Nerd Font"
   "Fira Code"
   "Monospace"))

;; NOTE: floating points are point font (heh)
(defvar lazr/font-size 16.0)

(defun lz/increase-font-size ()
  (interactive)
  (setf lazr/font-size (+ 1.0 lazr/font-size)))

(defun lz/decrease-font-size ()
  (interactive)
  (setf lazr/font-size (- lazr/font-size 1.0)))

(defun lazr/available-font-families ()
  (cl-remove-if-not (lambda (f) (x-list-fonts f))
                    lazr/fonts))

(defun lazr/setup-fonts (&rest fonts)
  "Find the first font in the list FONTS that exists on the system, and then set it as the default font."
  (let ((font-family (car (lazr/available-font-families))))
    ;; Set the current frame's font and all future frames.
    (set-frame-font
     (font-spec :family font-family
                :weight 'medium
                :size lazr/font-size)
     t t)))

(defun lazr/on-font-preferences-change (symbol newval operation where)
  (lz/message "Setting new font preferences")
  (lazr/setup-fonts))

(add-variable-watcher 'lazr/fonts #'lazr/on-font-preferences-change)
(add-variable-watcher 'lazr/font-size #'lazr/on-font-preferences-change)

(defun lazr/setup-frame (frame)
  "Set up the FRAME after it has been created."

  (message "Frame being set up: " frame)

  ;; Enable the right-click menu.
  (context-menu-mode)

  (if (not (equal (framep frame) t))
      (progn ; Graphical frames

        (message "graphical frame being set up")
        ;; Enable scrolling that allows for views unbound by character cells
        (pixel-scroll-mode)

	(apply 'lazr/setup-fonts lazr/fonts)

        (set-frame-size frame 300 60)

        ;; Apply my theme.
	(lazr/apply-theme))

    (progn ; Terminal frames.
      (message "Terminal frame being set up")

      ;; Mouse stuff
      (xterm-mouse-mode 1)

      ;; Load my terminal theme
      (load-theme 'chameleon t t)
      )))

;; Apply to all future frames
(add-hook 'after-make-frame-functions 'lazr/setup-frame)

(provide 'lazr-graphical)
