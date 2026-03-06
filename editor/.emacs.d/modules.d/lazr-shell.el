;;;; lazr-shell: Using the Unix shell from Emacs.

(require 'lazr-package-setup)

(setq explicit-shell-file-name "bash"
      explicit-zsh-args '("--login" "--interactive"))

(use-package exec-path-from-shell 
  :config
  (exec-path-from-shell-initialize))

(defun lazr/zsh-shell-mode-setup ()
  "Set up Zsh when launched as an inferior shell."
  (setq-local comint-process-echoes t))

(add-hook 'shell-mode-hook
          #'lazr/zsh-shell-mode-setup)

(provide 'lazr-shell)
