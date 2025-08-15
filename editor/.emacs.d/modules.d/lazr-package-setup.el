(require 'package)

;;;; Package setup.

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(defun lazr/require-package (name)
  (unless (package-installed-p name)
    (package-install name)))

(lazr/require-package 'use-package)

;;
;; Set up the most heinous of all Emacs packages
;;

(lazr/require-package 'undo-tree)       ; Provide a tree of undo-states. Needed by Evil.
(lazr/require-package 'evil)            ; Extensible Vi Layer
(lazr/require-package 'evil-collection) ; Extra bindings for different modes
(lazr/require-package 'general)         ; Better keybinding tools

(setf
 evil-want-integration t
 evil-want-keybinding  nil
 evil-undo-system      'undo-redo)

(setf
 evil-collection-mode-list
 '(apropos dired eglot eldoc eshell vc-dir vc-git magit notmuch process-menu woman xref))

(require 'evil)
(require 'evil-collection)
(require 'general)

; Use Emacs mode for vterms.
(evil-set-initial-state 'vterm-mode 'emacs)

; Vim-vinegar replacement
(define-key evil-normal-state-map
            (kbd "-")
            #'(lambda () (interactive) (find-file ".")))

; Enable vi keybindings.
(evil-mode 1)
(evil-collection-init)
(general-evil-setup t)

(provide 'lazr-package-setup)
