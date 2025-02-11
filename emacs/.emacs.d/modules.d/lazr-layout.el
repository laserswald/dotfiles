(require 'lazr-core)
(require 'lazr-keybindings)

;; Window movement with C-hjkl
(general-define-key "C-h" 'evil-window-left
		    "C-j" 'evil-window-down
		    "C-k" 'evil-window-up
		    "C-l" 'evil-window-right)

(setf display-buffer-alist
      '(((derived-mode . comint-mode)
	 (display-buffer-reuse-mode-window display-buffer-at-bottom)
	 (window-height . 15))))

(provide 'lazr-layout)
