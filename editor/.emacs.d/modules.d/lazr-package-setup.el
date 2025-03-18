(require 'package)

;;;; Package setup.

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;;
;; Extensible Vi Layer.
;;

; Configure the Evil layer.
(use-package evil :ensure t

  :init
  (setf evil-want-integration t)
  (setf evil-want-keybinding  nil)
  (setf evil-undo-system      'undo-redo)

  :config

  ; Enable vi keybindings.
  (evil-mode 1)

  ; Use Emacs mode for vterms.
  (evil-set-initial-state 'vterm-mode 'emacs)

  ; Vim-vinegar replacement
  (define-key evil-normal-state-map (kbd "-")
    #'(lambda () (interactive) (find-file "."))))

; Provide a tree of undo-states. Needed by Evil.
(use-package undo-tree :ensure t)

; Extra keybindings for default Evil stuff.
(use-package evil-collection :ensure t
  :after evil

  :init
  (setf evil-collection-mode-list
        '(apropos dired eglot eldoc eshell vc-dir vc-git
                  magit
                  notmuch process-menu woman xref))

  :config
  (evil-collection-init))

(use-package general :ensure t
  :init
  (general-evil-setup t))

(provide 'lazr-package-setup)
