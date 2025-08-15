(require 'lazr-core)

; Git integration.
(use-package magit)

; Per-project configurations for indentation, etc.
(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package direnv :ensure t :config (direnv-mode))

(provide 'lazr-project)
