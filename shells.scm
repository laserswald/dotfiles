
;;;
;;; Shells.
;;;

(define lazr-posix-shell-service
  (service 
   home-files-service-type
   `((".shrc" ,(local-file "sh/.shrc" "lazr-posix-shell-shrc"))
     (".sh.d" ,(local-file "sh/.sh.d" "lazr-posix-shell-dir" #:recursive? #t))
     (".dircolors" ,(local-file "sh/.dircolors" "lazr-posix-shell-dircolors"))
     (".local/lib/sh" ,(local-file "sh/.local/lib/sh" "lazr-posix-shell-lib" #:recursive? #t)))))

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
            (zshenv   (list (local-file "zsh/.zshenv" "lazr-zshenv")))
            (zprofile (list (local-file "zsh/.zprofile" "lazr-zprofile")))
            (zshrc    (list (local-file "zsh/.zshrc" "lazr-zshrc"))))))

(define lazr-shell-services
  (list lazr-posix-shell-service
        ; lazr-posix-shell-profile-service
        lazr-fish-service
        lazr-zsh-service))
