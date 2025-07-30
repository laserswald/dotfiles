(define-library (lazr mail)
  (export communications-services)
  (import (scheme base)
          (guile)
	  (lazr base)
	  (gnu services)
	  (gnu home services dotfiles)
	  (gnu home services)
          (gnu packages mail)
          (guix gexp))
  (begin

    (define mail-directory
      (string-append (getenv "HOME") "/var/mail"))

    (define mail-account-dirs
      (map (lambda (x) (string-append mail-directory "/" x)) '("bdr" "lazr")))

    (define mail-storage-service
      (service home-activation-service-type
                #~(begin
                    (mkdir mail-directory)
                    (for-each mkdir mail-account-dirs))))

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
