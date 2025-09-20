;;;; sh/config.scm - Configuration for different command line shells.
;;;;


(import (scheme base)
        (lazr base)
	(lazr packages)
        (gnu services)
        (gnu packages shells)
        (gnu packages bash)
        (gnu packages shellutils)
        (gnu packages tmux)
        (gnu home services)
        (gnu home services shells)
        (guix gexp))


;;;
;;; Shells.
;;;

(define lazr-posix-shell-service
  (service 
   home-files-service-type
   `((".shrc"         ,(local-file (lazr-config-file "sh/.shrc") "lazr-posix-shell-shrc"))
     (".sh.d"         ,(local-file (lazr-config-file "sh/.sh.d") "lazr-posix-shell-dir" #:recursive? #t))
     (".dircolors"    ,(local-file (lazr-config-file "sh/.dircolors") "lazr-posix-shell-dircolors"))
     (".local/lib/sh/path.sh" ,(local-file (lazr-config-file "sh/.local/lib/sh/path.sh") "lazr-posix-shell-lib-path" #:recursive? #t))
     (".local/lib/sh/preferred_app.sh" ,(local-file (lazr-config-file "sh/.local/lib/sh/preferred_app.sh") "lazr-posix-shell-lib-preferred-app" #:recursive? #t))
     (".local/lib/sh/command_exists.sh" ,(local-file (lazr-config-file "sh/.local/lib/sh/command_exists.sh") "lazr-posix-shell-lib-command-exists" #:recursive? #t)))))

(define lazr-posix-shell-profile-service 
  (service home-shell-profile-service-type
           (home-shell-profile-configuration
            (profile (list (local-file "sh/.profile" "lazr-posix-profile"))))))

(define lazr-zsh-services
  (services
   (packages-service 'lazr-zsh-packages-service
		     zsh
		     zsh-completions
		     zsh-syntax-highlighting
		     zsh-autosuggestions
		     direnv
		     bash
		     tmux
		     oh-my-zsh)

   (service home-zsh-service-type
	    (home-zsh-configuration
	     (zshenv   (list (local-file (lazr-config-file "sh/.zshenv") "lazr-zshenv")))
	     (zprofile (list (local-file (lazr-config-file "sh/.zprofile") "lazr-zprofile")))
	     (zshrc    (list (local-file (lazr-config-file "sh/.zshrc") "lazr-zshrc")
			     (mixed-text-file "lazr-zshrc-postlude.zsh"
					      "source \"" zsh-autosuggestions "/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh\"\n"
					      "source \"" zsh-syntax-highlighting "/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\"\n"
					      "fpath=(" zsh-completions "/share/zsh/site-functions $fpath) \n"
					      "export ZSH=\"" oh-my-zsh "/share/zsh/oh-my-zsh\" \n"
					      "source $ZSH/oh-my-zsh.sh \n"
                                              "export GUIX_PROFILE=$HOME/.guix-profile\n"
                                              "source $GUIX_PROFILE/etc/profile\n"
					      )))))

   (simple-service
    'lazr-zsh-xdg-service
    home-xdg-configuration-files-service-type
    `(
      ("zsh/functions.zsh"         ,(local-file (lazr-config-file "sh/.config/zsh/functions.zsh") "lazr-zsh-functions" #:recursive? #t))
      ("zsh/aliases.zsh"         ,(local-file (lazr-config-file "sh/.config/zsh/aliases.zsh") "lazr-zsh-aliases" #:recursive? #t))
      ("zsh/plugins"         ,(local-file (lazr-config-file "sh/.config/zsh/plugins") "lazr-zsh-plugins-dir" #:recursive? #t))
      ("zsh/themes"         ,(local-file (lazr-config-file "sh/.config/zsh/themes") "lazr-zsh-themes-dir" #:recursive? #t))))))

(define lazr-shell-services
  (services
   lazr-posix-shell-service
   lazr-zsh-services))
