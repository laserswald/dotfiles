;;;; -*- lexical-binding: t -*-

(require 'lazr-core)
(require 'lazr-keybindings)

;; Window movement with C-hjkl
(general-define-key "C-h" 'evil-window-left
		    "C-j" 'evil-window-down
		    "C-k" 'evil-window-up
		    "C-l" 'evil-window-right)

(defvar lz/side-window-props
  '(window-parameters . ((no-delete-other-windows . t))))

(setf display-buffer-alist
      `(((derived-mode . comint-mode) display-buffer-in-side-window
         (side . bottom) (slot . 1) (preserve-size . (nil . t))
         ,lz/side-window-props)
        ("\\*Org Agenda\\*" display-buffer-in-side-window
         (side . right) (slot . 0) (preserve-size . (t . nil)))
        ("\\*\\(Metahelp\\|Help\\|Man.*\\|WoMan.*\\|info\\)\\*" display-buffer-in-side-window
         (side . right) (slot . 1) (preserve-size . (t . nil))
         ,lz/side-window-props)
        ("\\*compilation\\*" display-buffer-in-side-window
         (side . bottom) (slot . 0) (preserve-size . (nil . t))
         ,lz/side-window-props)
        ("\\*\\(?:grep\\|Completions\\|xref\\)\\*" display-buffer-in-side-window
         (side . bottom) (slot . 2) (preserve-size . (nil . t))
         ,lz/side-window-props)))

(provide 'lazr-layout)
