
;;; Code:

(require 'cl-lib)

(deftheme chameleon
  "Lazr's preferred terminal-based theme.")



(let ((class '((class color))))
  (custom-theme-set-faces
   'chameleon

   ;; :bold :underline :foreground :background :

   ;; Fix some strangeness with faces in the terminal.
   `(default
     ((,class
       (:background "background"
        :foreground "foreground"))))

   `(tab-bar
     ((,class
       (:foreground "cyan"))))

   `(font-lock-comment-face
     ((,class
       (:foreground "white"
        :italic t))))
   `(font-lock-comment-delimiter-face
     ((,class
       (:foreground "white"
        :italic t))))
   `(font-lock-doc-face
     ((,class
       (:foreground "brightwhite"
        :italic t))))
   `(font-lock-doc-markup-face
     ((,class
       (:foreground "brightmagenta"
        :italic t))))
   `(font-lock-keyword-face
     ((,class
       (:foreground "red"))))
   `(font-lock-builtin-face
     ((,class
       (:foreground "brightyellow"))))
   `(font-lock-operator-face
     ((,class
       (:foreground "yellow"))))
   `(font-lock-function-name-face
     ((,class
       (:foreground "brightblue"))))
   `(font-lock-variable-name-face
     ((,class
       (:foreground "brightblue"))))
   `(font-lock-variable-use-face
     ((,class
       (:foreground "blue"))))
   `(font-lock-type-face
     ((,class
       (:foreground "brightyellow"))))
   `(font-lock-constant-face
     ((,class
       (:foreground "brightred"))))
   `(font-lock-preprocessor-face
     ((,class
       (:foreground "magenta"))))

   `(font-lock-string-face
     ((,class
       (:foreground "green"))))
   `(font-lock-escape-face
     ((,class
       (:foreground "brightgreen"))))

   `(font-lock-property-name-face
     ((,class
       (:foreground "brightcyan"))))
   `(font-lock-property-use-face
     ((,class
       (:foreground "cyan"))))

   ;;; Outlining and Org mode

   `(outline-1
     ((,class
       (:foreground "magenta"))))
   `(outline-2
     ((,class
       (:foreground "blue"))))
   `(outline-3
     ((,class
       (:foreground "cyan"))))
   `(outline-4
     ((,class
       (:foreground "green"))))
   `(outline-5
     ((,class
       (:foreground "yellow"))))
   `(outline-6
     ((,class
       (:foreground "red"))))
   `(outline-7
     ((,class
       (:foreground "magenta"))))
   `(outline-8
     ((,class
       (:foreground "blue"))))


   `(org-hide
     ((,class
       (:foreground "black"))))))
(provide-theme 'chameleon)

