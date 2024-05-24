(custom-set-variables
 '(custom-safe-themes
   '("10e5d4cc0f67ed5cafac0f4252093d2119ee8b8cb449e7053273453c1a1eb7cc" "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19" "9013233028d9798f901e5e8efb31841c24c12444d3b6e92580080505d56fd392" "c5878086e65614424a84ad5c758b07e9edcf4c513e08a1c5b1533f313d1b17f1" "95bdf4c9c87618a377cd326794fd9d8fb3076ea3d5f4fe1f95a7d118e089ece2" "7964b513f8a2bb14803e717e0ac0123f100fb92160dcf4a467f530868ebaae3e" "ffafb0e9f63935183713b204c11d22225008559fa62133a69848835f4f4a758c" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69" "d6b934330450d9de1112cbb7617eaf929244d192c4ffb1b9e6b63ad574784aad" "c1638a7061fb86be5b4347c11ccf274354c5998d52e6d8386e997b862773d1d2" "e1f4f0158cd5a01a9d96f1f7cdcca8d6724d7d33267623cc433fe1c196848554" "b29ba9bfdb34d71ecf3322951425a73d825fb2c002434282d2e0e8c44fce8185" "4ade6b630ba8cbab10703b27fd05bb43aaf8a3e5ba8c2dc1ea4a2de5f8d45882" "c7a926ad0e1ca4272c90fce2e1ffa7760494083356f6bb6d72481b879afce1f2" "0f76f9e0af168197f4798aba5c5ef18e07c926f4e7676b95f2a13771355ce850" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" default))
 '(package-selected-packages
   '(org-modern org-modern-mode org-bullets kakoune todotxt xcscope wisp-mode which-key web-mode use-package undo-tree treemacs-projectile treemacs-magit treemacs-evil tree-sitter-langs terraform-mode smart-tabs-mode slime rust-mode ripgrep reformatter protobuf-mode poly-ansible phpunit php-mode persp-mode password-store parinfer-rust-mode org-roam org-pomodoro nix-mode multi-vterm modus-themes markdown-mode haskell-mode go-mode general geiser-mit geiser-guile geiser-gauche geiser-chicken geiser-chibi geiser-chez flycheck-eglot feature-mode evil-org evil-collection elpy elixir-mode ef-themes editorconfig dumb-jump doom-themes doom-modeline dockerfile-mode deft counsel auto-complete all-the-icons ag))
 '(safe-local-variable-values
   '((eval progn
           (require 'lisp-mode)
           (defun emacs27-lisp-fill-paragraph
               (&optional justify)
             (interactive "P")
             (or
              (fill-comment-paragraph justify)
              (let
                  ((paragraph-start
                    (concat paragraph-start "\\|\\s-*\\([(;\"]\\|\\s-:\\|`(\\|#'(\\)"))
                   (paragraph-separate
                    (concat paragraph-separate "\\|\\s-*\".*[,\\.]$"))
                   (fill-column
                    (if
                        (and
                         (integerp emacs-lisp-docstring-fill-column)
                         (derived-mode-p 'emacs-lisp-mode))
                        emacs-lisp-docstring-fill-column fill-column)))
                (fill-paragraph justify))
              t))
           (setq-local fill-paragraph-function #'emacs27-lisp-fill-paragraph))
     (eval modify-syntax-entry 43 "'")
     (eval modify-syntax-entry 36 "'")
     (eval modify-syntax-entry 126 "'")
     (geiser-repl-per-project-p . t)
     (eval with-eval-after-load 'yasnippet
           (let
               ((guix-yasnippets
                 (expand-file-name "etc/snippets/yas"
                                   (locate-dominating-file default-directory ".dir-locals.el"))))
             (unless
                 (member guix-yasnippets yas-snippet-dirs)
               (add-to-list 'yas-snippet-dirs guix-yasnippets)
               (yas-reload-all))))
     (eval setq-local guix-directory
           (locate-dominating-file default-directory ".dir-locals.el"))
     (eval add-to-list 'completion-ignored-extensions ".go")
     (engine . php))))
(custom-set-faces)
