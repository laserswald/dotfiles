
(defvar lazr-paths
  (list "/Users/bdavenport-ray/.cargo/bin"
	"/Users/bdavenport-ray/.config/composer/vendor/bin/"
	"/Users/bdavenport-ray/.local/bin"
	"/Users/bdavenport-ray/.luarocks/bin"
	"/Users/bdavenport-ray/bin"
	"/Users/bdavenport-ray/src/go/bin"
	"/bin"
	"/go/bin"
	"/sbin"
	"/usr/bin"
	"/usr/local/bin"
	"/usr/local/lib/ruby/gems/2.7.0/bin"
	"/usr/local/opt/ruby/bin"
	"/usr/sbin"))

(dolist (path lazr-paths)
  (add-to-list 'exec-path path))

(setq explicit-shell-file-name "/bin/zsh"
      shell-file-name "zsh"
      explicit-zsh-args '("--login" "--interactive"))

(defun zsh-shell-mode-setup ()
  "Set up Zsh when launched as an inferior shell."
  (setq-local comint-process-echoes t))

(add-hook 'shell-mode-hook #'zsh-shell-mode-setup)

(use-package vterm :ensure t)
(use-package multi-vterm :ensure t
  :config
  (add-hook 'vterm-mode-hook
	    (lambda ()
	      (setq-local evil-insert-state-cursor 'box)
	      (evil-insert-state)))
  (define-key vterm-mode-map [return]                      #'vterm-send-return)

  (setq vterm-keymap-exceptions nil)
  (evil-define-key 'insert vterm-mode-map (kbd "C-e")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-f")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-a")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-v")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-b")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-w")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-u")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-n")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-m")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-p")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-j")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-k")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-r")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-t")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-g")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-c")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-SPC")    #'vterm--self-insert)
  (evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
  (evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume))
