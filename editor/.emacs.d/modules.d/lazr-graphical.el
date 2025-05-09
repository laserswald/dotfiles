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

(setf custom-theme-directory "~/.emacs.d/themes")

(let ((lazr-custom-theme nil))
  (defun lazr-switch-theme (theme)
    "Save and switch to the given theme."
    (if lazr-custom-theme
        (disable-theme lazr-custom-theme))
    (setf lazr-custom-theme theme)
    (load-theme lazr-custom-theme)))

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

(defvar lazr-fonts
  '("Victor Mono Nerd Font" "Fira Code Nerd Font"))

(defun lazr-setup-fonts (&rest fonts)
  "Find the first font in the list FONTS that exists on the system, and then set it as the default font."
  (let* ((font-size 16)
         (font-face (cl-find-if (lambda (f)
                                  (find-font (font-spec :name f
							:size font-size
							:weight 'normal
							:slant 'normal)))
                                fonts)))
    ;; Set the current frame's font and all future frames.
    (set-frame-font font-face t t)))

(defun lazr/setup-frame (frame)
  "Set up the FRAME after it has been created"
  (if (display-graphic-p)
      (progn ; Graphical frames
	;; Enable scrolling that allows for views unbound by character cells
	(pixel-scroll-mode)
	;; Enable the right-click menu.
	(context-menu-mode)
	(apply 'lazr-setup-fonts lazr-fonts)
	(set-frame-size frame 300 60)
	;; Apply my theme.
	(lazr-apply-theme))
    (progn
      ;; Terminal frames.
      (load-theme 'chameleon)
      (xterm-mouse-mode 1))))

;; Apply to the initial frame.
(lazr/setup-frame (selected-frame))

;; Apply to all future frames
(add-hook 'after-make-frame-functions 'lazr/setup-frame)

(provide 'lazr-graphical)
