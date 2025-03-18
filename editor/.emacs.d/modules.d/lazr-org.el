;;;; -*- lexical-binding: t; -*-

(require 'lazr-core)
(require 'lazr-keybindings)

(defvar lazr-org-directory "~/org"
  "Directory where my org mode files live.")

(defun lazr-org-file (file)
  "Get the path of the FILE in my org directory."
  (concat lazr-org-directory file))

(setf lazr-org-agenda-file (lazr-org-file "/agenda/main.org")
      lazr-org-journal-file (lazr-org-file "/journal.org"))

(use-package org

  :init
  (setf

   ;;
   ;; Set some variables to modify how Org buffers look
   ;;

   ; Entities (timestamps, etc) should look nice
   org-pretty-entities t

   ; Don't show the leading stars
   org-hide-leading-stars t

   ; Don't show emphasis or bold markers
   org-hide-emphasis-markers t

   ; Always indent headlines
   org-startup-indented t

   ; Fold as much as possible so I don't get overwhelmed
   org-startup-folded t

   ;;
   ;; Refiling
   ;;

   ; Use file paths when refiling
   org-refile-use-outline-path t

   ; Allow me to select a destination in steps
   org-outline-path-complete-in-steps t
   

   org-default-notes-file (concat lazr-org-directory "/index.org")

   org-agenda-files (list (lazr-org-file "/agenda")
                          (lazr-org-file "/agenda/projects"))

   org-archive-location (concat lazr-org-directory "/archive.org::")

   org-capture-templates
   `(("t"
      "To-do item"
      entry
      (file+datetree ,lazr-org-agenda-file)
      "* TODO %?\n  %T\n  %i\n  %a")

     ("e"
      "Calendar event"
      entry
      (file+datetree ,lazr-org-agenda-file)
      "* %?\n  %T\n  %i"
      :time-prompt t)

     ("j"
      "Journal entry"
      entry
      (file+olp+datetree ,lazr-org-agenda-file)))

   org-todo-keywords
    '((sequence "TODO" "NEXT" "|" "DONE" "WAIT" "CANCEL")
      (sequence "READY" "INPROGRESS" "REVIEW" "|" "COMPLETE")))

  :config
  (add-to-list 'org-modules 'org-habit))

(defvar lazr-org-refresh-agenda-time-seconds 30)
(defvar lazr-org-refresh-agenda-timer nil)

(defun lazr-org-refresh-agenda ()
  "Refreshes the org agenda buffer when idle."
  (when lazr-org-refresh-agenda-timer
    (cancel-timer lazr-org-refresh-agenda-timer))
  (save-window-excursion
    (save-excursion
      (dolist (buffer (buffer-list))
	(with-current-buffer buffer
	  (if (derived-mode-p 'org-agenda-mode)
	    (org-agenda-redo t))))))

  (setf lazr-org-refresh-agenda-timer
        (run-with-idle-timer
         (time-add (current-idle-time)
		   lazr-org-refresh-agenda-time-seconds)
         nil
         'lazr-org-refresh-agenda)))

;; Start the timer when we first load this file
(run-with-idle-timer lazr-org-refresh-agenda-time-seconds t 'lazr-org-refresh-agenda)

(use-package evil-org :ensure t
  :after evil org

  :hook
  (org-mode . evil-org-mode)

  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-pomodoro :ensure t
  :after org)

(use-package deft :ensure t
  :config (setq deft-directory lazr-org-directory))

(use-package markdown-mode :ensure t)

(use-package org-roam :ensure t
  :after org)

(use-package org-modern :ensure t
  :config (global-org-modern-mode))

(use-package org-caldav :ensure t
  :after org)

;; Keybindings

(lazr-local-leader-map :keymaps 'org-mode-map
  "," 'org-ctrl-c-ctrl-c
  "." 'org-time-stamp
  "A" 'org-archive-all-old
  "a" 'org-archive-subtree
  "l" 'org-store-link
  "p" 'org-insert
  "r" 'org-refile
  "t" 'org-todo)

;; For some reason, this is overridden somewhere.
;; Ensure that Tab can open/close outlines
(general-define-key :states 'normal
                    :keymaps 'org-mode-map
  "<TAB>" 'org-cycle)

(defun lz/choose-randomly (sequence)
  "Choose one item randomly out of the SEQUENCE."
  (elt sequence (random (length sequence))))

;;
(defun lz/org-after-todo-state-change (&optional state)
  "Play a silly sound when a TODO state has been set to one of the DONE states."
  (when (member (if (boundp 'org-state) org-state state) (list "DONE" "COMPLETE"))
    (message "Good job!")
    (start-process-shell-command
     "org-done-sound-effect" nil
     (concat "mpv " (lz/choose-randomly (directory-files "~/var/sound-effects/" t ".*\.mp3"))))))

(add-hook 'org-after-todo-state-change-hook 'org-clock-out-if-current)
(add-hook 'org-after-todo-state-change-hook 'lz/org-after-todo-state-change)

;;;
;;; Setup for Dungeons and Dragons
;;; 

(require 'dnd "./dnd-mode/dnd-mode.el")

(setq dnd-srd-dir "~/org/fun/rpg/dnd/org-dnd-srd-main/"
      dnd-snippet-dir "./dnd-mode/snippets")

(lazr-local-leader-map :keymaps 'dnd-mode-map
  "r" 'rtd
  "E" 'dnd-eval-charsheet
  "s" 'dnd-select-session-target)

;;; Set up the Insidious Big Brother Database
;;;
;;; This is a contact list that is integrated within Emacs.

(use-package bbdb :ensure t
  :init
  (setf bbdb-file "~/org/contacts.bbdb"))

;; Provide import and export via vCard for BBDB contacts.
(use-package bbdb-vcard :ensure t)

(use-package telega :ensure t)

(provide 'lazr-org)
