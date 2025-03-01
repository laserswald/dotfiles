;;;; -*- geiser-scheme-implementation: guile -*-

(install-r7rs!)

(import
  (ice-9 ftw)

  (gnu home)
  (gnu home services)
  (gnu home services shepherd)
  (gnu home services syncthing)
  (gnu home services shells)
  (gnu home services dotfiles)

  (gnu services)
  (gnu services configuration)

  (gnu packages admin)
  (gnu packages audio)
  (gnu packages base)
  (gnu packages emacs)
  (gnu packages emacs-xyz)
  (gnu packages gimp)
  (gnu packages inkscape)
  (gnu packages kde)
  (gnu packages linux)
  (gnu packages mail)
  (gnu packages ncurses)
  (gnu packages package-management)
  (gnu packages password-utils)
  (gnu packages racket)
  (gnu packages scheme)
  (gnu packages shells)
  (gnu packages ssh)
  (gnu packages syndication)
  (gnu packages terminals)
  (gnu packages text-editors)
  (gnu packages tmux)
  (gnu packages toys)
  (gnu packages video)
  (gnu packages web)
  (gnu packages guile)

  (guix gexp)
  (guix packages)
  (guix licenses)
  (guix git-download)
  (guix build-system copy)

  (lazr base)
  (lazr packages)
  (lazr executable-file)
  (lazr kakoune)
  (lazr kakoune-plugins)
  (lazr shells))
  ;(lazr mail))

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

(define-packages-service lazr-emacs-packages-service
  (emacs emacs-guix))

(define (emacs-server-shepherd-service config)
  (list (shepherd-service
         (documentation "Emacs server.")
         (provision '(emacs-server))
         (start #~(make-forkexec-constructor
                   (list #$(file-append emacs "/bin/emacs") "--fg-daemon")))
         (stop #~(make-kill-destructor)))))

(define home-emacs-server-service-type
  (service-type
   (name 'home-emacs-server)
   (extensions (list (service-extension home-shepherd-service-type
                                        emacs-server-shepherd-service)))
   (default-value #f)
   (description "Run Emacs in server mode.")))

(define lazr-emacs-config-service
  (simple-service 'lazr-emacs-config-service
                  home-files-service-type
                  `((".emacs.d/init.el"
                     ,(local-file
                       (lazr-config-file "emacs/.emacs.d/init.el") "emacs-init-el"))
                    (".emacs.d/modules.d"
                     ,(local-file
                       (lazr-config-file "emacs/.emacs.d/modules.d") "emacs-modules-d" #:recursive? #t)))))
                     

(define lazr-emacs-services
  (list lazr-emacs-packages-service
        (service home-emacs-server-service-type)
        lazr-emacs-config-service))
  
(define lazr-development-services
  (append lazr-kakoune-services
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
                  `((".local/bin/invaders" ,(executable-file "bin/bin/invaders" "invaders"))
                    (".local/bin/favorite-terminal" ,(executable-file "xorg/bin/favorite-terminal" "favorite-terminal"))
                    (".local/bin/favorite-browser" ,(executable-file "xorg/bin/favorite-browser" "favorite-browser"))
                    (".local/bin/graphical-menu" ,(executable-file "xorg/bin/graphical-menu" "graphical-menu"))
                    (".local/bin/sync-etc" ,(executable-file "bin/bin/sync-etc" "sync-etc")))))

(define lazr-misc-services
  (list (service home-syncthing-service-type)
        (service home-dotfiles-service-type
                 (home-dotfiles-configuration
                  (layout 'stow)
                  (directories (list lazr-config-directory))
                  (packages (list "alacritty" "hypr"))))
        lazr-scripts-service))

(define lazr-workstation-home 
  (home-environment
   (packages
    (list jq grep ncurses procps password-store))
   (services
    (append lazr-shell-services
            lazr-development-services
            lazr-creative-services
            ;; communications-services
            lazr-misc-services))))

lazr-workstation-home

