(require 'lazr-core)

; Git integration.
(use-package magit :ensure t)

; Per-project configurations for indentation, etc.
(use-package editorconfig :ensure t
  :config
  (editorconfig-mode 1))

(provide 'lazr-project)
