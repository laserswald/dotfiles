;;;; -*- geiser-scheme-implementation: guile -*-

(use-modules (ice-9 ftw)

             (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (gnu services configuration)

             (gnu packages admin)
             (gnu packages audio)
             (gnu packages base)
             (gnu packages gimp)
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

(define lazr-development-services
  (append lazr-kakoune-services
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

(define lazr-workstation-home 
  (home-environment
   (packages
    (list jq grep ncurses procps openssh password-store))
   (services
    (append lazr-shell-services
            lazr-development-services
            lazr-creative-services
            lazr-communications-services))))

lazr-workstation-home
