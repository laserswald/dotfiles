;;;; -*- geiser-scheme-implementation: guile -*-

(install-r7rs!)

(import
 (scheme base)
 (scheme process-context)
 (srfi 1)
 (ice-9 ftw)

 (gnu home)
 (gnu home services)
 (gnu home services shepherd)
 (gnu home services syncthing)
 (gnu home services shells)
 (gnu home services dotfiles)
 (guix gexp)
 (guix packages)
 (guix licenses)
 (guix git-download)
 (guix build-system copy)
 
 (gnu services)
 (gnu services configuration)
 
 (gnu packages admin)
 (gnu packages audio)
 (gnu packages autotools)
 (gnu packages base)
 (gnu packages cmake)
 (gnu packages emacs)
 (gnu packages emacs-xyz)
 (gnu packages fonts)
 (gnu packages gimp)
 (gnu packages gnome)
 (gnu packages gnome-xyz)
 (gnu packages guile)
 (gnu packages inkscape)
 (gnu packages kde)
 (gnu packages linux)
 (gnu packages mail)
 (gnu packages mpd)
 (gnu packages music)
 (gnu packages ncurses)
 (gnu packages package-management)
 (gnu packages password-utils)
 (gnu packages racket)
 (gnu packages scheme)
 (gnu packages shells)
 (gnu packages ssh)
 (gnu packages syndication)
 (gnu packages terminals)
 (gnu packages tmux)
 (gnu packages toys)
 (gnu packages video)
 (gnu packages web)
 (gnu packages wm)
 (gnu packages xdisorg)

 (lazr base)
 (lazr packages)
 (lazr executable-file)
 (lazr kakoune)
 (lazr kakoune-plugins)
 (lazr mail))


(include "term/config.scm")
(include "sh/config.scm")
(include "editor/config.scm")

;; Fix locale issue

(define lazr-glibc-locales
  (make-glibc-utf8-locales
   glibc
   #:locales (list "en_US" "es_US")
   #:name "glibc-united-states-locales"))

;;;
;;; Development tools.
;;;

(define-packages-service lazr-scheme-packages-service
  (gauche
   akku
   mit-scheme
   racket
   slib
   r7rs-small-texinfo))
  
(define lazr-development-services
  (append #;lazr-kakoune-services
          lazr-emacs-services
          (list lazr-scheme-packages-service)))

;;;
;;; Creative packages, mostly media editing, etc
;;;

(define-packages-service lazr-creative-packages-service
  (openshot audacity gimp inkscape krita))

(define lazr-creative-services
  (list lazr-creative-packages-service))

;;;
;;; My main home for workstations.
;;;


(define lazr-scripts-service
  (simple-service 'lazr-scripts-service
                  home-files-service-type
                  (list
                   (script "256colors" "bin/bin/")
                   (script "invaders" "bin/bin/")
                   
                   (script "skel" "bin/bin/")
                   (script "sync-etc" "bin/bin/")
                   (script "tidy-home" "bin/bin/")
                   (script "pass-remember" "bin/bin/")

                   (script "audioctl" "bin/bin/")
                   (script "bfg" "bin/bin/")
                   (script "patchdir" "bin/bin/")
                   (script "phptags" "bin/bin/")
                   (script "srcmv" "bin/bin/")
                   (script "surf-ddg" "bin/bin/")

                   (script "dj" "bin/bin/")
                   (script "favorite-terminal" "xorg/bin/")
                   (script "favorite-browser" "xorg/bin/")
                   (script "graphical-menu" "xorg/bin/"))))

(define lazr-media-services
  (services
   (packages-service 'lazr-media-packages
                     mpd
                     beets
                     ncmpcpp)
   (service home-dotfiles-service-type
            (home-dotfiles-configuration
             (layout 'stow)
             (directories (list lazr-config-directory))
             (packages (list "media"))))))

(define lazr-favorite-font "CMUTypewriter NF")

(define lazr-graphical-services
  (services
   (packages-service 'lazr-graphical-packages
                     bibata-cursor-theme
                     brightnessctl
                     dex
                     dunst
                     font-awesome
                     font-cmu-nerdfont
                     font-fira-code
                     font-fira-sans
                     font-latin-modern
                     kanshi
                     libnotify ;; For notify-send
                     playerctl
                     swaybg
                     swayidle
                     swaylock
                     )
   (service home-dotfiles-service-type
            (home-dotfiles-configuration
             (layout 'stow)
             (directories (list lazr-config-directory))
             (packages (list "wayland" "xorg"))))))

(define lazr-misc-services
  (list (service home-syncthing-service-type)
        (service home-dotfiles-service-type
                 (home-dotfiles-configuration
                  (layout 'stow)
                  (directories (list lazr-config-directory))
                  (packages (list "vc" "chat" "news" "core"))))
        lazr-scripts-service))

(define lazr-server-home
  (home-environment
   (packages
    (list lazr-glibc-locales jq grep ncurses procps password-store libiconv))
   (services (append lazr-shell-services
                     lazr-term-services
                     lazr-development-services))))

(define lazr-workstation-home 
  (home-environment
   (packages
    (list 
     jq
     grep
     ncurses
     procps
     password-store
     libiconv
     lazr-glibc-locales
     ))
   (services
    (append lazr-shell-services
	    lazr-term-services
            lazr-development-services
            ;; lazr-creative-services
            communications-services
            lazr-graphical-services
            lazr-media-services
            lazr-misc-services))))


(let ((host (gethostname)))
  (cond ((member host '("gargantua" "polaris" "betelgeuse"))
         lazr-workstation-home)
        ((member host '("sol" "andromeda" "baked" "vespa" "french-fry"))
         lazr-server-home)
        (else
         (error "Unknown hostname: " host))))

