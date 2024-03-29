
;;; Evil configuration
(use-package evil
  :ensure t

  :init
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-undo-system 'undo-redo)

  :config
  (evil-mode 1)
  (evil-set-initial-state 'dired-mode 'normal)
  (evil-set-initial-state 'vterm-mode 'emacs)
  ;; Vim-vinegar replacement
  (define-key evil-normal-state-map (kbd "-")
    #'(lambda ()
        (interactive)
        (find-file "."))))

(use-package general
  :ensure t
  :config
  (general-evil-setup))

(use-package evil-collection
  :ensure t

  :after evil

  :init
  (setq evil-collection-mode-list '(dired magit process-menu))

  :config
  (evil-collection-init))

