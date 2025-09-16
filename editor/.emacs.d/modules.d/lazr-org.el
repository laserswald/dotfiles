;;;; -*- lexical-binding: t; -*-

(require 'lazr-core)
(require 'lazr-keybindings)

(defvar lazr/org-directory "~/org"
  "Directory where my org mode files live.")

(defun lazr/org-file (file)
  "Get the path of the FILE in my org directory."
  (concat lazr/org-directory file))

(setf lazr/org-agenda-file (lazr/org-file "/agenda/main.org")
      lazr/org-journal-file (lazr/org-file "/journal.org"))

(use-package org

  :init
  (setf

   ;;
   ;; Set some variables to modify how Org buffers look
   ;;

   ;; Entities (timestamps, etc) should look nice
   org-pretty-entities t

   ;; Don't show the leading stars
   org-hide-leading-stars t

   ;; Don't show emphasis or bold markers
   org-hide-emphasis-markers t

   ;; Always indent headlines
   org-startup-indented t

   ;; Fold as much as possible so I don't get overwhelmed
   org-startup-folded t

   ;;
   ;; Refiling
   ;;

   ;; Use file paths when refiling
   org-refile-use-outline-path t

   ;; Allow me to select a destination in steps
   org-outline-path-complete-in-steps t
   
   org-default-notes-file lazr/org-agenda-file

   org-agenda-files (list (lazr/org-file "/agenda")
                          (lazr/org-file "/agenda/projects"))

   org-archive-location (concat lazr/org-directory "/archive.org::")

   org-capture-templates
   `(("t"
      "To-do item"
      entry
      (file ,lazr/org-agenda-file)
      "* TODO %?\n  %T\n  %a")

     ("e"
      "Calendar event"
      entry
      (file ,lazr/org-agenda-file)
      "* %?\n  %T\n  %i"
      :time-prompt t)

     ("j"
      "Journal entry"
      entry
      (file ,lazr/org-agenda-file)))

   org-todo-keywords
   `(;; Standard tasks
     (sequence "TODO" "|" "DONE" "CANCEL")
     ;; Software tickets
     (sequence "READY" "INPROGRESS" "REVIEW" "|" "COMPLETE")))

  :config
  (add-to-list 'org-modules 'org-habit))

(defvar lazr/org-refresh-agenda-time-seconds 30)
(defvar lazr/org-refresh-agenda-timer nil)

(defun lazr/org-refresh-agenda ()
  "Refreshes the org agenda buffer when idle."
  (when lazr/org-refresh-agenda-timer
    (cancel-timer lazr/org-refresh-agenda-timer))
  (save-window-excursion
    (save-excursion
      (dolist (buffer (buffer-list))
	(with-current-buffer buffer
	  (if (derived-mode-p 'org-agenda-mode)
	    (org-agenda-redo t))))))

  (setf lazr/org-refresh-agenda-timer
        (run-with-idle-timer
         (time-add (current-idle-time)
		   lazr/org-refresh-agenda-time-seconds)
         nil
         'lazr/org-refresh-agenda)))

;; Start the timer when we first load this file
(run-with-idle-timer lazr/org-refresh-agenda-time-seconds t #'lazr/org-refresh-agenda)

(use-package evil-org
  :after evil org

  :hook
  (org-mode . evil-org-mode)

  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  (add-hook 'org-mode-hook #'auto-revert-mode))

(use-package org-pomodoro
  :after org)

(use-package deft
  :config (setq deft-directory lazr/org-directory))

(use-package markdown-mode)

(use-package org-roam :after org)

(use-package org-modern
  :config (global-org-modern-mode))

(use-package org-caldav
  :after org)

;; Keybindings


(lazr/local-leader-map :keymaps 'org-mode-map
  "," 'org-ctrl-c-ctrl-c
  "." 'org-time-stamp
  "a" 'org-archive-subtree
  "c" 'org-capture
  "d" 'org-deadline
  "l" 'org-store-link
  "p" 'org-pomodoro
  "r" 'org-refile
  "s" 'org-schedule
  "t" 'org-todo
  )

;; For some reason, this is overridden somewhere.
;; Ensure that Tab can open/close outlines
(general-define-key :states 'normal :keymaps 'org-mode-map "<TAB>" 'org-cycle)


(defun lazr/org-after-todo-state-change (&optional state)
  "Play a silly sound when an org todo STATE (also could be given manually to test) has been set to one of the DONE states."
  (when (member (if (boundp 'org-state) org-state state)
		(list "DONE" "COMPLETE"))
    (message "Good job!")
    (start-process-shell-command
     "org-done-sound-effect" nil
     (concat "mpv " (lz/choose-randomly (directory-files "~/var/sound-effects/" t ".*\\.\\(mp3\\|ogg\\|wav\\)"))))))

(add-hook 'org-after-todo-state-change-hook
	  'lazr/org-after-todo-state-change)

;;;
;;; Setup for Dungeons and Dragons
;;; 

(require 'dnd "./dnd-mode/dnd-mode.el")

(setq dnd-srd-dir "~/org/fun/rpg/dnd/org-dnd-srd-main/"
      dnd-snippet-dir "./dnd-mode/snippets")

(lazr/local-leader-map :keymaps 'dnd-mode-map
  "r" 'rtd
  "E" 'dnd-eval-charsheet
  "s" 'dnd-select-session-target)

;;; Set up the Insidious Big Brother Database
;;;
;;; This is a contact list that is integrated within Emacs.

(use-package bbdb
  :init
  (setf bbdb-file "~/org/contacts.bbdb"))

;; Provide import and export via vCard for BBDB contacts.
(use-package bbdb-vcard)

;; Telegram support
(use-package telega :ensure t)

;; Legacy todo list format
(use-package todotxt :ensure t)

;; Mini-database used in my notes systems
(use-package rec-mode :ensure t)

(provide 'lazr-org)
