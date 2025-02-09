
(deftheme chameleon
  "Lazr's preferred terminal-based theme.")

;; Fix some strangeness with faces in the terminal.
(set-face-background 'default "background")

(set-face-foreground 'font-lock-comment-face "brightblack")
(set-face-foreground 'font-lock-comment-delimiter-face "brightblack")
(set-face-foreground 'font-lock-doc-face "brightwhite")
(set-face-foreground 'font-lock-doc-markup-face "brightmagenta")

(set-face-foreground 'font-lock-keyword-face "red")
(set-face-foreground 'font-lock-builtin-face "brightyellow")
(set-face-foreground 'font-lock-operator-face "yellow")

(set-face-foreground 'font-lock-function-name-face "brightblue")
(set-face-foreground 'font-lock-variable-name-face "brightblue")
(set-face-foreground 'font-lock-variable-use-face "blue")
(set-face-foreground 'font-lock-type-face "brightyellow")
(set-face-foreground 'font-lock-constant-face "brightred")
(set-face-foreground 'font-lock-preprocessor-face "magenta")

(set-face-foreground 'font-lock-string-face "green")
(set-face-foreground 'font-lock-escape-face "brightgreen")

(set-face-foreground 'font-lock-property-name-face "brightcyan")
(set-face-foreground 'font-lock-property-use-face "cyan")

; (set-face-foreground 'elscreen-tab-control-face "blue")

(provide-theme chameleon)
