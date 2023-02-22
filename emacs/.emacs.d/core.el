
;;; Evil configuration
(use-package evil
  :ensure t

  :init
  (setq evil-want-integration t
	evil-want-keybinding nil)

  :config
  (evil-mode 1)
  (evil-set-initial-state 'dired-mode 'normal)
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
  (setq evil-collection-mode-list '(dired magit))

  :config
  (evil-collection-init))

