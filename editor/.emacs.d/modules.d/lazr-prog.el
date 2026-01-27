;;;; lazr-prog --- Programming language specific settings. -*- lexical-binding: t -*-

(require 'lazr-core "./lazr-core.el")
(require 'lazr-package-setup "./lazr-package-setup.el")
(require 'lazr-keybindings "./lazr-keybindings.el")

;;; Interacting with a REPL or similar 

(defun lz/interactive-operation-p (x)
  "Returns T if X is an interactive operation"
  (memq x '(open-repl eval-defun eval-buffer)))

(defvar lz/interaction-functions
  (make-hash-table)
  "A nested hash map of SYMBOL -> SYMBOL -> FUNCTION that stores functions which interact with a
REPL session.
The first symbol is the main keymap of the filetype, the second is ")

(defun lz/interaction-function-register! (keymap-symbol operation function)
  (let ((keymap-hash (gethash keymap-symbol lz/interaction-functions (make-hash-table))))
    (puthash operation function keymap-hash)
    (puthash keymap-symbol keymap-hash lz/interaction-functions)))

(defun lz/interaction-function-ref (keymap-symbol operation)
  (let ((keymap-hash (gethash keymap-symbol lz/interaction-functions (make-hash-table))))
    (gethash operation keymap-hash nil)))

(defun lz/define-interactive-keybinds (keymap eval-defun eval-buffer open-repl)
  "Define Lisp keybindings in a consistent manner."

  (lz/interaction-function-register! keymap 'open-repl open-repl)
  (lz/interaction-function-register! keymap 'eval-defun eval-defun)
  (lz/interaction-function-register! keymap 'eval-buffer eval-buffer)

  (lazr/local-leader-map :keymaps keymap
    "e" eval-defun
    "E" eval-buffer
    "r" open-repl))

  

;;; Keyword/documentation lookup

(make-variable-buffer-local 'evil-lookup-func)

;;;
;;; Intelligent code completion and such using LSP and tree-sitter
;;;

; Completion framework
(lazr/require-package 'company)
(global-company-mode)

; On-the-fly checking.
(lazr/require-package 'flycheck)
(global-flycheck-mode)

;; Install the built-in Emacs language server client.
(lazr/ensure-package 'eglot)
(defvar lazr/lsp-enabled-modes
  '(c-mode-hook
    c++-mode-hook
    go-mode-hook
    rust-mode-hook
    python-mode-hook
    php-mode-hook
    shell-script-mode-hook))

;; Registers LSP checks with flycheck.
(lazr/ensure-package 'flycheck-eglot)
(add-hook 'eglot-connect-hook #'flycheck-eglot-mode)

;; Enable ultra-smart syntax awareness using Tree-Sitter.
(lazr/require-package 'tree-sitter)
(global-tree-sitter-mode)

;; Add as many tree-sitter languages as possible.

;;;
;;; Indentation and whitespace configuration.
;;;

(defconst lazr/tab-width 4
  "How many spaces a tab should be.")

(defun lazr/enable-tabs ()
  "Enable tab indentation for this mode."
  (evil-define-key 'insert prog-mode-map (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width lazr/tab-width))

(defun lazr/disable-tabs ()
  "Disable tabs in this mode."
  (setq indent-tabs-mode nil))
   
;; When writing program source code, if there is not already a system in place,
;; use the "indent with tabs and align with spaces" convention.
(add-hook 'prog-mode-hook 'lazr/enable-tabs)

;;;
;;; Algol family.
;;;

;;
;; C and C++ modes
;;

(setq c-default-style
      '((java-mode . "java")
        (other . "k&r")))

;; Cmake support

(setq cmake-project-default-build-dir-name "build/")

(lazr/ensure-package 'cmake-mode)
(lazr/ensure-package 'cmake-project)

(defun maybe-cmake-project-mode ()
  (if (or (file-exists-p "CMakeLists.txt")
          (file-exists-p (expand-file-name "CMakeLists.txt" (car (project-roots (project-current))))))
      (cmake-project-mode)))

(add-hook 'c-mode-hook 'maybe-cmake-project-mode)
(add-hook 'c++-mode-hook 'maybe-cmake-project-mode)
 
;;
;; Go
;;
(lazr/ensure-package 'go-mode)

;;
;; Rust
;;

(lazr/ensure-package 'rust-mode)

;;
;; Shell scripts.
;;

(reformatter-define shell-script-format
  :program "shfmt"
  :args '("--simplify" "--case-indent" "--func-next-line" "-"))
(add-hook 'shell-script-mode-hook #'shell-script-format-on-save-mode)
(evil-define-key 'normal shell-script-mode-map "K" 'woman)

;;
;; Perl and Raku
;;

(lazr/ensure-package 'raku-mode)
(lazr/require-package 'flycheck-raku)
(lz/define-interactive-keybinds 'raku-mode-map
  nil
  #'raku-send-buffer-to-repl
  #'run-raku)

;;
;; Python.
;;

(lazr/ensure-package 'elpy)
(add-hook 'python-mode-hook #'elpy-enable)

; Make python available with Org-Babel.
(require 'ob-python)

;;; Web technologies

; Enables web page template highlighting, including PHP
(use-package web-mode :ensure t 
  :init
  (setf web-mode-enable-engine-detection t
        web-mode-markup-indent-offset 2))

;;
;; JavaScript
;;

(lazr/ensure-package 'js2-mode)
(lazr/ensure-package 'js-comint)

(setf js-comint-program-command
      (or (executable-find "bun")
          (executable-find "node")
          (executable-find "qjs")))

(lz/define-interactive-keybinds 'js2-mode-map
                                #'js-comint-send-last-sexp
                                #'js-comint-send-buffer
                                #'js-comint-repl)

(require 'ob-js)

;;
;; PHP 
;;

(lazr/ensure-package 'php-mode)
(lazr/ensure-package 'phpunit)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(php-mode . ("phpactor" "language-server"))))

(lazr/local-leader-map :keymaps 'php-mode-map
  "ta" 'phpunit-current-project
  "tt" 'phpunit-current-test
  "tc" 'phpunit-current-class)

;;;
;;; Lisp family.
;;;


(defconst lz/lisps
  '(lisp emacs-lisp scheme racket clojure fennel arc)
  "Lisp variants that I am aware of and may possibly write code in")

(use-package parinfer-rust-mode :ensure t
  :init
  (setq parinfer-rust-auto-download t))

(use-package rainbow-delimiters)

(dolist (lmh (mapcar (lambda (lisp-name)
                       (lz/symcat-soft lisp-name 'mode-hook))
                     lz/lisps))
  (when lmh
    (lz/message "lazr/prog: installing lisp mode hook to %s" lmh)
    (add-hook lmh (lambda ()
                    (lazr/disable-tabs)
                    (parinfer-rust-mode)
                    (rainbow-delimiters-mode)))))

;;
;; Emacs Lisp
;;

(lz/define-interactive-keybinds 'emacs-lisp-mode-map
  'eval-defun
  'elisp-eval-region-or-buffer
  'ielm)

(evil-define-key 'normal emacs-lisp-mode-map "K" 'describe-symbol)
(evil-define-key 'normal ielm-map "K" 'describe-symbol)

;;
;; Common Lisp
;;

;; Use the Superior Lisp Interaction Mode for Emacs
(use-package slime
  :config
  (setf inferior-lisp-program "sbcl"))

(lz/define-interactive-keybinds 'lisp-mode-map
  'slime-eval-defun
  'slime-compile-and-load-file
  'slime)

;; Enable common lisp for org babel.
(require 'ob-lisp)

;;;
;;; Scheme
;;;

;; Use the Geiser interaction mode for Scheme.
(lazr/ensure-package 'geiser)
(lazr/ensure-package 'geiser-gauche)
(lazr/ensure-package 'geiser-guile)

(setq geiser-active-implementations '(guile gauche racket))

(add-to-list 'auto-mode-alist '("\\.sld" . scheme-mode))

(add-hook 'geiser-mode-hook (lambda ()
                             (add-to-list 'geiser-guile-load-path "~/src/gnu/guix")))

(lz/define-interactive-keybinds 'scheme-mode-map
  'geiser-eval-definition
  'geiser-eval-buffer
  'geiser)

;; (add-hook 'scheme-mode-hook
;;           (lambda ()
;;             (setf evil-lookup-func lazr/scheme-lookup)))
                  

(require 'ob-scheme)

(lazr/ensure-package 'racket-mode)

;;;
;;; Clojure
;;;

(use-package clojure-mode :ensure t)
(use-package cider :ensure t)
; (require 'ob-clojure-eval-with-babashka)

(lz/define-interactive-keybinds 'clojure-mode-map
  'cider-eval-defun-at-point
  'cider-eval-buffer
  'cider-jack-in-clj&cljs)

(evil-define-key 'normal clojure-mode-map "K" 'cider-doc)

;; Elixir (It's a Lisp, fite me)
(use-package elixir-mode :ensure t)

;;;
;;; ML family.
;;;

;; Standard ML
(lazr/require-package 'sml-mode)
(add-hook 'sml-mode-hook
          (lambda ()
            (lazr/disable-tabs)))

;; OCaml

;; Haskell
(use-package haskell-mode)
(require 'ob-haskell)

;;;
;;; Databases, configuration files, etc
;;;


;; Recutils mode
(lazr/require-package 'rec-mode)
(lazr/local-leader-map :keymaps 'rec-mode-map
  "n" 'rec-cmd-goto-next-rec
  "p" 'rec-cmd-goto-previous-rec
  "d" 'rec-cmd-show-descriptor
  "t" 'rec-find-type
  "SPC" 'rec-cmd-toggle-field-visibility
  "R" 'rec-edit-record
  "T" 'rec-edit-type
  "B" 'rec-edit-buffer)

(dolist (m lazr/lsp-enabled-modes)
  (add-hook m #'eglot-ensure))

(provide 'lazr-prog)
