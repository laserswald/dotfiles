;;; -*- lexical-binding: t -*-
;;; Code:

(require 'cl-lib)

(deftheme chameleon
  "Lazr's preferred terminal-based meta-theme. Each color means the same things
in all the possible themes.")

(defvar chameleon-selenized-black
  `((black .   "#252525") ; Background
    (red .     "#ed4a46") ; Keywords
    (green .   "#70b433") ; Strings
    (yellow .  "#dbb32d") ; Types
    (blue .    "#368aeb") ; Variables
    (magenta . "#eb6eb7") ; Metadata / modules / macros, etc
    (cyan .    "#3fc5b7") ; Functions
    (white .   "#b9b9b9") ; Everything else

    (brightblack .   "#3b3b3b") ; Comments
    (brightred .     "#ff5e56") ; "important" keywords
    (brightgreen .   "#83c746") ; String format codes, escape chars, etc
    (brightyellow .  "#efc541") ; User-defined types
    (brightblue .    "#4f9cfe") ; Variable definitions
    (brightmagenta . "#ff81ca") ; User-defined syntax / modules
    (brightcyan .    "#56d8c9") ; Function definitions
    (brightwhite .   "#dedede") ; Documentation

    (foreground . "#b9b9b9")
    (background . "#181818")))

(defvar chameleon-current-theme
  chameleon-selenized-black)

(defun chameleon-graphical-color (name)
  (cdr (assoc name chameleon-current-theme)))

(defun chameleon--build-face (foreground background &rest extras)
  `((((type graphic) (class color))
     (:foreground ,(if (equal 'default foreground)
                       (chameleon-graphical-color 'foreground)
                       (chameleon-graphical-color foreground))
      :background ,(if (equal 'default background)
                       (chameleon-graphical-color 'background)
                       (chameleon-graphical-color background))
      ,extras))
    (((class color) (min-colors 16))
     (:foreground ,(if (equal foreground 'default)
                       "unspecified"
                       (symbol-name foreground))
      :background ,(if (equal 'background 'default) "unspecified" (symbol-name background))
      ,extras))))

(custom-theme-set-faces 'chameleon
  `(default ,(chameleon--build-face 'foreground 'background))
  `(tab-bar ,(chameleon--build-face 'brightwhite 'brightblack))
  `(region ,(chameleon--build-face 'default 'brightblack))
  `(highlight ,(chameleon--build-face 'brightblack 'brightwhite))
  `(hl-line ,(chameleon--build-face 'brightblack 'background))
  `(fringe ,(chameleon--build-face 'brightblack 'brightwhite))
  `(line-number
    ,(chameleon--build-face 'brightblack 'black))
  `(cursor
    ,(chameleon--build-face 'black 'white))
  `(show-paren-match-face
    ,(chameleon--build-face 'brightmagenta 'black))
  `(isearch
    ,(chameleon--build-face 'brightmagenta 'black :bold t))

  `(vertical-border
    ,(chameleon--build-face 'brightblack 'black))

  `(mode-line
    ,(chameleon--build-face 'brightwhite 'brightblack :bold t))

  `(mode-line-inactive
    ,(chameleon--build-face 'white 'brightblack))

  `(mode-line-buffer-id
    ,(chameleon--build-face 'cyan 'brightblack))
  `(mode-line-highlight
    ,(chameleon--build-face 'red 'default :bold t))
  `(mode-line-emphasis
    ,(chameleon--build-face 'white 'brightblack))

  `(minibuffer-prompt
    ,(chameleon--build-face 'red 'default :bold t))

  ;; Font locking.

  ;; Comments and documentation.
  `(font-lock-comment-face
    ,(chameleon--build-face 'white 'default :italic t))
  `(font-lock-comment-delimiter-face
    ,(chameleon--build-face 'white 'default :italic t :bold t))
  `(font-lock-doc-face
    ,(chameleon--build-face 'white 'default :italic t))
  `(font-lock-doc-markup-face
    ,(chameleon--build-face 'cyan 'default :italic t))

  ;;; Code 

  `(font-lock-keyword-face
    ,(chameleon--build-face 'red 'default))

  `(font-lock-builtin-face
    ,(chameleon--build-face 'brightyellow 'default))

  `(font-lock-operator-face
    ,(chameleon--build-face 'yellow 'default))

  `(font-lock-function-name-face
    ,(chameleon--build-face 'brightblue 'default :bold t))

  `(font-lock-variable-name-face
    ,(chameleon--build-face 'blue 'default :bold t))
  `(font-lock-variable-use-face
    ,(chameleon--build-face 'blue 'default))

  `(font-lock-type-face
    ,(chameleon--build-face 'brightyellow 'default :bold t))
  `(font-lock-constant-face
    ,(chameleon--build-face 'brightred 'default))
  `(font-lock-preprocessor-face
    ,(chameleon--build-face 'magenta 'default))

  `(font-lock-string-face
    ,(chameleon--build-face 'green 'default))
  `(font-lock-escape-face
    ,(chameleon--build-face 'brightgreen 'default))

  `(font-lock-property-name-face
    ,(chameleon--build-face 'brightcyan 'default))
  `(font-lock-property-use-face
    ,(chameleon--build-face 'cyan 'default))

  ;;; Outlining and Org mode

  `(outline-1
    ,(chameleon--build-face 'magenta 'default))
  `(outline-2
    ,(chameleon--build-face 'blue 'default))
  `(outline-3
    ,(chameleon--build-face 'cyan 'default))
  `(outline-4
    ,(chameleon--build-face 'green 'default))
  `(outline-5
    ,(chameleon--build-face 'yellow 'default))
  `(outline-6
    ,(chameleon--build-face 'red 'default))
  `(outline-7
    ,(chameleon--build-face 'magenta 'default))
  `(outline-8
    ,(chameleon--build-face 'blue 'default))

  `(org-hide
    ,(chameleon--build-face 'black 'default)))

(provide-theme 'chameleon)
(enable-theme 'chameleon)
