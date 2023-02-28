
(use-package counsel :ensure t :config (ivy-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;; Custom functions that should be bound to keys

(defun lazr-eval-buffer ()
  "Evaluate a buffer and say something about it."
  (interactive)
  (eval-buffer)
  (message "Evaluated."))

(defun lazr-save-buffer ()
  "Write the buffer and add it to version control"
  (interactive)
  (save-buffer)
  (magit-stage-file (buffer-file-name)))

(defun lazr-reload-config ()
  (interactive)
  (lz/load "core.el"))

;;;
;;; Roots of the leader mapping trees.
;;;

(general-create-definer lazr-leader-map
  :states 'normal
  :prefix "SPC")

(general-create-definer lazr-local-leader-map
  :states 'normal
  :prefix ",")

;; Window movement with C-hjkl
(general-define-key "C-h" 'evil-window-left
		    "C-j" 'evil-window-down
		    "C-k" 'evil-window-up
		    "C-l" 'evil-window-right)

;; Go to ...
(general-define-key :states 'normal :prefix "g"
 "a" 'evil-switch-to-windows-last-buffer ; alternate
 "b" 'ivy-switch-buffer ; buffer
 "B" 'counsel-bookmark ; Bookmark
 "d" 'xref-find-definitions
 "F" 'counsel-find-file
 "f" 'projectile-find-file
 "r" 'xref-find-references)

;;;
;;; Local leader.
;;;

(lazr-local-leader-map
  "w" 'lazr-save-buffer
  "c" 'comment-line
  "C" 'comment-box
  ;;; "d" 'delete-buffer
  "m" 'recompile
  "M" 'compile
  "R" 'lazr-reload-config)

;; Fuzzy finding
(lazr-local-leader-map :infix ","
  "b" 'counsel-buffer
  "c" 'counsel-cd
  "g" 'swiper
  "t" 'xref-find-apropos
  "f" 'counsel-find-file)

;; 'W'indow manipulation
(lazr-leader-map :infix "w"
  "c" 'kill-buffer
  "j" 'split-window-vertically
  "l" 'split-window-horizontally)

;;; 'P'roject tools
(lazr-leader-map "p" 'projectile-command-map)

;;; 'V'ersion control
(lazr-leader-map :infix "v"
  "s" 'magit-status
  "a" 'magit-stage-file
  "c" 'magit-commit)

;;; 'O'rg mode
(lazr-leader-map :infix "o"
  "l" 'org-store-link
  "a" 'org-agenda
  "c" 'org-capture
  "p" 'org-pomodoro)

;;; X for perspective mode because too many things start with P
(lazr-leader-map :infix "x"
  "x" 'persp-switch
  "p" 'persp-prev
  "n" 'persp-next)
  
;;; File type specific tools

;; PHP
(lazr-local-leader-map :keymaps 'php-mode-map
  "ta" 'phpunit-current-project
  "tt" 'phpunit-current-test
  "tc" 'phpunit-current-class)

;; Emacs Lisp
(lazr-local-leader-map :keymaps 'emacs-lisp-mode-map
  "eb" 'lazr-eval-buffer)

;; Org mode
(lazr-local-leader-map :keymaps 'org-mode-map "t" 'org-todo)

(general-nmap dired-mode-map "-" 'dired-up-directory)
