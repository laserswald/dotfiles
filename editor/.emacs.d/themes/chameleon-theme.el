
;;; Code:

(require 'cl-lib)

(defvar chameleon-selenized-black
  `((:black .   "#181818") ; Background
    (:red .     "#ed4a46") ; Keywords
    (:green .   "#70b433") ; Strings
    (:yellow .  "#dbb32d") ; Types
    (:blue .    "#368aeb") ; Variables
    (:magenta . "#eb6eb7") ; Metadata / modules / macros, etc
    (:cyan .    "#3fc5b7") ; Functions
    (:white .   "#b9b9b9") ; Everything else

    (:bright-black .   "#252525") ; Comments
    (:bright-red .     "#ff5e56") ; "important" keywords
    (:bright-green .   "#83c746") ; String format codes, escape chars, etc
    (:bright-yellow .  "#efc541") ; User-defined types
    (:bright-blue .    "#4f9cfe") ; Variable definitions
    (:bright-magenta . "#ff81ca") ; User-defined syntax / modules
    (:bright-cyan .    "#56d8c9") ; Function definitions
    (:bright-white .   "#dedede") ; Documentation
    ))

(deftheme chameleon
  "Lazr's preferred terminal-based meta-theme. Each color means the same things
in all the possible themes.")

(defvar chameleon-current-theme
  chameleon-selenized-black)

(defvar chameleon-color-meanings
  `((:background . :black) ; Background
    (:keyword . :red) ; Keywords
    (:string . :green) ; Strings
    (:type . :yellow) ; Types
    (:variable . :blue) ; Variables
    (:metadata . :magenta) ; Metadata / modules / macros, etc
    (:function . :cyan) ; Functions
    (:foreground . :white) ; Everything else

    (:comment . :bright-black) ; Comments
    (:important-kw . :bright-red) ; "important" keywords
    (:string-hl . :bright-green) ; String format codes, escape chars, etc
    (:user-type . :bright-yellow) ; User-defined types
    (:user-variable . :bright-blue) ; Variable definitions
    (:user-meta . :bright-magenta) ; User-defined syntax / modules
    (:user-function . :bright-cyan) ; Function definitions
    (:documentation . :bright-white) ; Documentation
    ))

(defun chameleon-color (role)
  (assoc (assoc role chameleon-color-meanings)
         chameleon-current-theme))

(defun chameleon--build-face (graphical-color terminal-color)
  "Build a face depending on the cl"
  (if (window-system (selected-frame))
      `(:foreground ,graphical-color)
     `(:foreground ,terminal-color)))

(let* ((class '((class color)))
       (contrast "white")
       (brightcontrast "brightwhite")
       (similar "black")
       (brightsimilar "brightblack"))

  (custom-theme-set-faces
   'chameleon

   ;; :bold :underline :foreground :background :

   `(default
     ((,class)))

   `(tab-bar
     ((,class
       (:foreground ,brightsimilar
	:background ,brightcontrast))))

   `(region
     ((,class (:background ,brightsimilar))))
   `(highlight
     ((,class (:foreground ,brightcontrast
	       :background ,brightsimilar))))
   `(hl-line
     ((,class (:background ,brightsimilar))))
   `(fringe
     ((,class (:background ,brightcontrast
	       :foreground ,brightsimilar))))
   `(line-number
     ((,class (:background ,brightsimilar
	       :foreground ,contrast))))
   `(cursor
     ((,class (:background ,brightcontrast))))
   `(show-paren-match-face
     ((,class (:background "brightcyan"))))
   `(isearch
     ((,class (:bold t :foreground "brightmagenta" :background ,brightsimilar))))

   `(vertical-border
     ((,class (:background ,brightsimilar
	       :foreground ,similar))))
   `(mode-line
     ((,class (:box (:line-width 1 :color nil)
	       :bold t
	       :background ,brightsimilar
	       :foreground ,brightcontrast))))
   `(mode-line-inactive
     ((,class (:box (:line-width 1 :color nil :style pressed-button)
		    :background ,brightsimilar
		    :foreground ,contrast
		    :weight normal))))
   `(mode-line-buffer-id
     ((,class (:bold t :foreground "cyan" :background nil))))
   `(mode-line-highlight
     ((,class (:foreground "red" :box nil :weight bold))))
   `(mode-line-emphasis
     ((,class (:foreground ,contrast))))

   `(minibuffer-prompt
     ((,class (:bold t :foreground "red"))))

   ;; Font locking.

   ;; Comments and documentation.
   `(font-lock-comment-face
     ((,class
       (:foreground ,contrast :italic t))))
   `(font-lock-comment-delimiter-face
     ((,class
       (:foreground ,contrast :italic t))))
   `(font-lock-doc-face
     ((,class
       (:foreground ,contrast
		    :italic t))))
   `(font-lock-doc-markup-face
     ((,class
       (:foreground "brightmagenta"
		    :italic t))))

   ;; Code 
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
       (:foreground "brightblue"
	:bold t))))
   `(font-lock-variable-name-face
     ((,class
       (:foreground "blue"
	:bold t))))
   `(font-lock-variable-use-face
     ((,class
       (:foreground "blue"))))
   `(font-lock-type-face
     ((,class
       (:foreground "brightyellow"
	:bold t))))
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
