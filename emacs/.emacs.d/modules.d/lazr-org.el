(require 'lazr-keybindings)

(defvar lazr-org-directory
  "~/org")

(defun lazr-org-file (file)
  (concat lazr-org-directory file))

(setf lazr-org-agenda-file (lazr-org-file "/agenda/main.org")
      lazr-org-journal-file (lazr-org-file "/journal.org"))

(use-package org 

  :init
  (setq
   org-pretty-entities t
   org-hide-emphasis-markers t
   
   org-default-notes-file (concat lazr-org-directory "/index.org")

   org-agenda-files (list (lazr-org-file "/agenda")
                          (lazr-org-file "/agenda/projects"))

   org-archive-location (concat lazr-org-directory "/archive.org::")

   org-capture-templates
   `(("t" "To-do item" entry
      (file+datetree ,lazr-org-agenda-file)
      "* TODO %?\n  %T\n  %i\n  %a")

     ("e" "Calendar event" entry
      (file+datetree ,lazr-org-agenda-file)
      "* %?\n  %T\n  %i"
      :time-prompt t)

     ("j" "Journal entry" entry
      (file+olp+datetree ,lazr-org-agenda-file)))

   org-todo-keywords
    '((sequence "TODO" "NEXT" "|" "DONE" "WAIT" "CANCEL")
      (sequence "READY" "INPROGRESS" "REVIEW" "|" "COMPLETE")))

  :hook (org-mode . org-indent-mode)

  :config
  (add-to-list 'org-modules 'org-habit))


(use-package evil-org
  :ensure t

  :after evil org

  :hook
  (org-mode . evil-org-mode)

  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-pomodoro
  :ensure t
  :after org)

(use-package deft
  :ensure t
  :config
  (setq deft-directory lazr-org-directory))

(use-package markdown-mode
  :ensure t)

(use-package org-roam
  :ensure t)

(use-package org-modern
  :ensure t
  :config
  (global-org-modern-mode))

;; Keybindings

(lazr-local-leader-map :keymaps 'org-mode-map
  "." 'org-time-stamp
  "t" 'org-todo
  "c" 'org-ctrl-c-ctrl-c
  "l" 'org-store-link
  "p" 'org-insert)

(require 'dnd "./dnd-mode/dnd-mode.el")
(setq dnd-srd-dir "~/org/fun/rpg/dnd/org-dnd-srd-main/"
      dnd-snippet-dir "./dnd-mode/snippets")

(message "Loaded lazr-org.")

(provide 'lazr-org)
