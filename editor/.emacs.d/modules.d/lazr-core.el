;;; lazr-core.el --- Core editor features            -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Ben Davenport-Ray

;; Author: Ben Davenport-Ray <ben@polaris>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; lazr-core adds fundamental packages that define how Ben uses Emacs.
;; Currently this will load Evil and friends, along with automatic systems like
;; spell checking, autocompletion, etc.

;;; Code:

(require 'lazr-package-setup "./lazr-package-setup.el")
(require 'lazr-keybindings "./lazr-keybindings.el")

;;
;; Built-in Emacs packages
;;

(lz/message "Setting up Emacs built-in packages.")

;; Dired, the directory editor
(require 'dired-x)

(lazr/require-package 'dired-git-info)

(add-hook 'dired-mode-hook
          (lambda () (dired-omit-mode)))

;; When in Dired, use normal mode, since dired has pretty good keybindings already
(evil-set-initial-state 'dired-mode 'normal)
(evil-define-key 'normal dired-mode-map
  "-" 'dired-up-directory
  ")" 'dired-git-info-mode)
(put 'dired-find-alternate-file 'disabled nil)

;; Remote file editing using TRAMP
(setenv "TERM" "ansi")

;; Automatic insert mode.
(auto-insert-mode t)

;; Viewing manual pages using WOMAN
(setq woman-use-topic-at-point t)

(setq help-display-function-type t
      help-window-keep-selected t)

;; Proced
(when (boundp 'proced-available)
  (lz/message "Setting up Proced.")
  (setq proced-enable-color-flag t)
  (define-key proced-mode-map (kbd "/") isearch-forward))

;; Provide a better interactive choice dialog than the normal Emacs one.
(use-package ivy
  :config
  (ivy-mode 1))
(evil-define-key nil ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

;; Snippets management
(use-package yasnippet 
  :config
  (yas-global-mode 1))

;;; Searching and navigating.

;; Search quickly
(use-package ripgrep)

;; Use dumb jump if we don't have a smart enough code searcher
(use-package dumb-jump 
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

;; Interface to the `pass` password vault.
(use-package password-store)

;;
;; Communication tools.
;;

                                        ; Interface for high speed mail searcher
(use-package notmuch :ensure t
  :config
  (evil-set-initial-state '(notmuch-hello-mode
                            notmuch-search-mode
                            notmuch-tree-mode
                            notmuch-show-mode)
                          'emacs))

;; Search using Counsel
(use-package counsel-notmuch)

;;
;; Functions 
;;

(defun lz/symcat-soft (&rest symbols)
  "Get the symbol created by concatenating the SYMBOLS together with '-'."
  (intern-soft (mapconcat #'symbol-name symbols "-")))

(defun lz/sym-mode (sym)
  "Get the mode hook for the language SYM."
  (lz/symcat-soft sym 'mode))

(defun lz/choose-randomly (sequence)
  "Choose one item randomly out of the SEQUENCE."
  (if (zerop (length sequence))
      (error "No choices available")
    (elt sequence (random (length sequence)))))

;;
;; Core settings.
;;

(desktop-save-mode -1) ; Save the current configuration of windows, buffers, etc.

(provide 'lazr-core)
;;; lazr-core.el ends here
