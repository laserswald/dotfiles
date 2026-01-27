;;;; -*- lexical-binding: t -*-
(require 'lazr-package-setup)

(use-package which-key :ensure t
  :config (which-key-mode))

;;; Custom functions that should be bound to keys

(defun lazr/save-buffer ()
  "Write the buffer and add it to version control."
  (interactive)
  (save-buffer)
  (vc-next-action))

(defun lazr/reload-config ()
  "Reload my configuration."
  (interactive)
  (package-refresh-contents)
  (load user-init-file))

(defun lazr/open-config ()
  "Open my configuration directory."
  (interactive)
  (find-file "~/etc/editor/.emacs.d"))

(defun lazr/open-repl ()
  "Open a REPL session for the current filetype."
  (interactive)
  (let ((repl-window (split-window-below)))
    (select-window repl-window)
    (ielm)))

;;;
;;; Kakoune-like muliple cursors. It's finally happening.
;;;

;; (use-package multiple-cursors
;;  :ensure t
;;  :config
;;    (evil-define-key '(normal visual) evil-normal-state-map
;;      "c" 'mc/cursor))

;;;
;;; Roots of the leader mapping trees.
;;;

;; Go to ...
(general-define-key
 :states 'normal
 :prefix "g"

 ; Alternate file.
 "a" 'evil-switch-to-windows-last-buffer

 ; A buffer or recent file.
 "b" 'counsel-switch-buffer

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
 "C" 'lazr/open-config

 ; Projects
 "p" 'project-switch-project)


;;;
;;; Main leader.
;;;
;;; The "space" leader involves commands to the entire Emacs session.
;;;

(general-create-definer lazr/leader-map
  :states '(normal visual)
  :prefix "SPC")

(lazr/leader-map
  "C" 'comment-dwim
  "a" 'org-agenda
  "c" 'org-capture
  "s" 'multi-vterm-dedicated-toggle
  "t" 'lazr/switch-theme-bg
  "w" 'lazr/save-buffer
  "v" 'vc-prefix-map
  "=" 'lz/increase-font-size
  "-" 'lz/decrease-font-size)
  
;; Project-wide commands
(lazr/leader-map :infix "p"
  "f" 'project-find-file
  "g" 'project-search
  "G" 'project-replace
  "d" 'project-dired
  "v" 'project-vc-dir
  "s" 'project-shell
  "e" 'project-eshell
  "b" 'project-recompile
  "B" 'project-compile)

;; 'F'uzzy finding
(lazr/leader-map :infix "f"
  "c" 'counsel-cd
  "t" 'xref-find-apropos
  "f" 'counsel-find-file)

;;; 'O'rg mode
(lazr/leader-map :infix "o"
  "p" 'org-pomodoro)

;;;
;;; Local leader. This should act on the current file.
;;;

(general-create-definer lazr/local-leader-map
  :states '(normal visual)
  :prefix ",")

(lazr/local-leader-map
  "c" 'comment-line
  "C" 'comment-box
  ;;; "d" 'delete-buffer
  "b" 'recompile
  "B" 'compile
  "w" 'lazr/save-buffer
  "/" 'swiper
  "?" 'swiper-backward)

(lazr/local-leader-map :keymaps 'todotxt-mode-map
  "," 'todotxt-complete-toggle)

(provide 'lazr-keybindings)
