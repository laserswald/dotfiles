(require 'lazr-core)
(require 'lazr-keybindings)

;; Window movement with C-hjkl
(general-define-key "C-h" 'evil-window-left
		    "C-j" 'evil-window-down
		    "C-k" 'evil-window-up
		    "C-l" 'evil-window-right)

(provide 'lazr-layout)
