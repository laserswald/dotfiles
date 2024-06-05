;;;; -*- geiser-scheme-implementation: guile -*-

(use-modules (ice-9 ftw)

             (gnu home)
             (gnu home services)
             (gnu home services shepherd)
             (gnu home services syncthing)
             (gnu home services shells)
             (gnu services)
             (gnu services configuration)

             (gnu packages admin)
             (gnu packages audio)
             (gnu packages base)
             (gnu packages gimp)
             (gnu packages emacs)
             (gnu packages emacs-xyz)
             (gnu packages inkscape)
             (gnu packages kde)
             (gnu packages linux)
             (gnu packages ncurses)
             (gnu packages package-management)
             (gnu packages password-utils)
             (gnu packages scheme)
             (gnu packages shells)
             (gnu packages ssh)
             (gnu packages text-editors)
             (gnu packages tmux)
             (gnu packages toys)
             (gnu packages video)
             (gnu packages web)
             (gnu packages mail)

             (guix gexp)
             (guix packages)
             (guix licenses)
             (guix git-download)
             (guix build-system copy))

(define-syntax define-packages-service
  (syntax-rules ()
    ((_ name (packages ...))
     (define name
       (simple-service 'name
                       home-profile-service-type
                       (list packages ...))))))

;; Spread me out
(load "shells.scm")

;;;
;;; Development tools.
;;;

(load "kakoune.scm")

(define-packages-service lazr-scheme-packages-service
  (gauche akku mit-scheme))

(define-packages-service lazr-emacs-packages-service
  (emacs emacs-guix))

(define (emacs-server-shepherd-service config)
  (list (shepherd-service
         (documentation "Emacs server.")
         (provision '(emacs-server))
         (start #~(make-forkexec-constructor
                   (list #$(file-append emacs "/bin/emacs")
                         "--fg-daemon")))
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
                  `((".emacs.d/init.el" ,(local-file "emacs/.emacs.d/init.el" "emacs-init-el"))
                    (".emacs.d/custom.el" ,(local-file "emacs/.emacs.d/custom.el" "emacs-custom-el"))
                    (".emacs.d/modules.d" ,(local-file "emacs/.emacs.d/modules.d" "emacs-modules-d" #:recursive? #t)))))
                     

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
;;; Communications packages. 
;;;

(define-packages-service lazr-email-packages-service
  (neomutt notmuch isync))

(define lazr-neomutt-service
  (simple-service
   'lazr-neomutt-service
   home-files-service-type
   `((".mutt" ,(local-file "mutt/.mutt"
                           "mutt-dir"
                           #:recursive? #true)))))

(define lazr-mbsync-service
  (simple-service 'lazr-mbsync-service
                  home-files-service-type
                  `((".mbsyncrc" ,(local-file "mail/.mbsyncrc" "mbsyncrc")))))
                                              

(define lazr-communications-services
  (list lazr-email-packages-service
        lazr-mbsync-service
        lazr-neomutt-service))

;;;
;;; My main home for workstations.
;;;

(define lazr-misc-services
  (list (service home-syncthing-service-type)))

(define lazr-workstation-home 
  (home-environment
   (packages
    (list jq grep ncurses procps password-store))
   (services
    (append lazr-shell-services
            lazr-development-services
            lazr-creative-services
            lazr-communications-services
            lazr-misc-services))))

lazr-workstation-home
