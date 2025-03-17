(define-library (lazr mail)
  (export communications-services)
  (import (scheme base)
	  (lazr base)
	  (gnu services)
	  (gnu home services dotfiles)
          (gnu packages mail))
  (begin

    (define mail-transfer-services
      (services
       (packages-service 'lazr-mail-transfer-pkgs-service
			 msmtp
			 isync)))

    (define mail-user-agent-services
      (services
       (packages-service 'lazr-mail-user-agent-packages-service
			 neomutt notmuch)))

    (define communications-services
      (services
       mail-transfer-services
       mail-user-agent-services
       (service home-dotfiles-service-type
		(home-dotfiles-configuration
		 (layout 'stow)
		 (directories (list lazr-config-directory))
		 (packages (list "mail"))))))
       )) 
