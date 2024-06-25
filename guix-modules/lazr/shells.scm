
(define-library (lazr shells)

  (export lazr-shell-services)

  (import (scheme base)
          (lazr base)
          (gnu services)
          (gnu home services)
          (gnu home services shells)
          (guix gexp))
  
  (begin

    ;;;
    ;;; Shells.
    ;;;

    (define lazr-posix-shell-service
      (service 
       home-files-service-type
       `((".shrc"         ,(local-file (lazr-config-file "sh/.shrc") "lazr-posix-shell-shrc"))
         (".sh.d"         ,(local-file (lazr-config-file "sh/.sh.d") "lazr-posix-shell-dir" #:recursive? #t))
         (".dircolors"    ,(local-file (lazr-config-file "sh/.dircolors") "lazr-posix-shell-dircolors"))
         (".local/lib/sh" ,(local-file (lazr-config-file "sh/.local/lib/sh") "lazr-posix-shell-lib" #:recursive? #t)))))

    (define lazr-posix-shell-profile-service 
      (service home-shell-profile-service-type
               (home-shell-profile-configuration
                (profile (list (local-file "sh/.profile" "lazr-posix-profile"))))))

    (define lazr-fish-service
      (service home-fish-service-type
               (home-fish-configuration)))

    (define lazr-zsh-service
      (service home-zsh-service-type
               (home-zsh-configuration
                (zshenv   (list (local-file (lazr-config-file "zsh/.zshenv") "lazr-zshenv")))
                (zprofile (list (local-file (lazr-config-file "zsh/.zprofile") "lazr-zprofile")))
                (zshrc    (list (local-file (lazr-config-file "zsh/.zshrc") "lazr-zshrc"))))))

    (define lazr-shell-services
      (list lazr-posix-shell-service
            ; lazr-posix-shell-profile-service
            lazr-fish-service
            lazr-zsh-service))))
