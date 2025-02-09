
(use-package counsel
  :ensure t
  :config (ivy-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;; Custom functions that should be bound to keys

(defun lazr-save-buffer ()
  "Write the buffer and add it to version control."
  (interactive)
  (save-buffer)
  (magit-stage-file (buffer-file-name)))

(defun lazr-reload-config ()
  "Reload my configuration."
  (interactive)
  (lz/load "core.el"))

(defun lazr-open-config ()
  "Open my configuration directory."
  (interactive)
  (find-file "~/etc/emacs/.emacs.d"))

(defun lazr-open-repl ()
  "Open a REPL session for the current filetype."
  (interactive)
  (let ((repl-window (split-window-below)))
    (select-window repl-window)
    (ielm)))

;;;
;;; Roots of the leader mapping trees.
;;;

;; Window movement with C-hjkl
(general-define-key "C-h" 'evil-window-left
		    "C-j" 'evil-window-down
		    "C-k" 'evil-window-up
		    "C-l" 'evil-window-right)

;; Go to ...
(general-define-key
 :states 'normal
 :prefix "g"

 ; Alternate file.
 "a" 'evil-switch-to-windows-last-buffer

 ; A buffer or recent file.
 "b" 'counsel-buffer-or-recentf

 ; Bookmark
 "B" 'counsel-bookmark

 ; File
 "F" 'counsel-find-file

 ; Project file
 "f" 'project-find-file

 ; Definition
 "d" 'xref-find-definitions

 ; References
 "r" 'xref-find-references

 ; Configuration.
 "C" 'lazr-open-config

 ; Projects
 "p" 'project-switch-project
 )

;;;
;;; Main leader.
;;;
;;; The "space" leader involves commands to the entire Emacs session.
;;;

(general-create-definer lazr-leader-map
  :states 'normal
  :prefix "SPC")

(lazr-leader-map
  "a" 'org-agenda
  "c" 'org-capture
  "R" 'lazr-reload-config
  "s" 'multi-vterm-dedicated-toggle
  "C" 'comment-dwim
  "w" 'lazr-save-buffer
  )

(lazr-leader-map :infix "p"
  "f" 'project-find-file
  "g" 'project-search
  "G" 'project-replace
  "d" 'project-dired
  "v" 'project-vc-dir
  "s" 'project-shell
  "e" 'project-eshell
  "c" 'project-compile
  )

;; 'F'uzzy finding
(lazr-leader-map :infix "f"
  "c" 'counsel-cd
  "t" 'xref-find-apropos
  "f" 'counsel-find-file)

;;; 'V'ersion control
(lazr-leader-map :infix "v"
  "s" 'magit-status
  "a" 'magit-stage-file
  "c" 'magit-commit)

;;; 'O'rg mode
(lazr-leader-map :infix "o"
  "p" 'org-pomodoro)

;;;
;;; Local leader. This should act on the current file.
;;;

(general-create-definer lazr-local-leader-map
  :states 'normal
  :prefix ",")

(lazr-local-leader-map
  "c" 'comment-line
  "C" 'comment-box
  ;;; "d" 'delete-buffer
  "m" 'recompile
  "M" 'compile
  "w" 'lazr-save-buffer
  "/" 'swiper
  "?" 'swiper-backward)
 
;;; File type specific tools

;; PHP
(lazr-local-leader-map :keymaps 'php-mode-map
  "ta" 'phpunit-current-project
  "tt" 'phpunit-current-test
  "tc" 'phpunit-current-class)

;;; Lisp and friends

(defmacro lazr-define-lisp-keybinds (mode
                                     eval-defun
                                     eval-buffer
                                     open-repl)
  "Define Lisp keybindings in a consistent manner."
  `(lazr-local-leader-map :keymaps ,mode
     "e" ,eval-defun
     "E" ,eval-buffer
     "r" ,open-repl))

(defun lazr-eval-buffer ()
  "Evaluate a buffer and say something about it."
  (interactive)
  (eval-buffer)
  (message "Evaluated."))

(lazr-define-lisp-keybinds 'lisp-interaction-mode-map
  'eval-defun
  'lazr-eval-buffer
  'ielm)

(lazr-define-lisp-keybinds 'emacs-lisp-mode-map
  'eval-defun
  'lazr-eval-buffer
  'ielm)

(lazr-define-lisp-keybinds 'scheme-mode-map
  'geiser-eval-definition
  'geiser-eval-buffer
  'geiser)

(lazr-define-lisp-keybinds 'lisp-mode-map
  'slime-eval-defun
  'slime-compile-and-load-file
  'slime)

(general-nmap dired-mode-map "-" 'dired-up-directory)

(lazr-local-leader-map :keymaps 'todotxt-mode-map
  "c" 'todotxt-complete-toggle)

(provide 'lazr-keybindings)
