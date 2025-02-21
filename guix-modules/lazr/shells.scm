
(define-library (lazr shells)

  (export lazr-shell-services)

  (import (scheme base)
          (lazr base)
	  (lazr packages)
          (gnu services)
          (gnu packages shells)
          (gnu packages shellutils)
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

    (define lazr-zsh-services
      (services
       (packages-service 'lazr-zsh-packages-service
			 zsh-completions
			 zsh-syntax-highlighting
			 zsh-autosuggestions
			 oh-my-zsh)

       (service home-zsh-service-type
		(home-zsh-configuration
		 (zshenv   (list (local-file (lazr-config-file "zsh/.zshenv") "lazr-zshenv")))
		 (zprofile (list (local-file (lazr-config-file "zsh/.zprofile") "lazr-zprofile")))
		 (zshrc    (list (local-file (lazr-config-file "zsh/.zshrc") "lazr-zshrc")
				 (mixed-text-file "lazr-zshrc-postlude.zsh"
						  "source \"" zsh-autosuggestions "/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh\"\n"
						  "source \"" zsh-syntax-highlighting "/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\"\n"
						  "fpath=(" zsh-completions "/share/zsh/site-functions $fpath)"
						  )))))

       (simple-service 'lazr-zsh-config-service
		       home-files-service-type
		       `((".zsh"         ,(local-file (lazr-config-file "zsh/.zsh") "lazr-zsh-dir" #:recursive? #t))))))

    (define lazr-shell-services
      (services
       lazr-posix-shell-service
       lazr-zsh-services))))
