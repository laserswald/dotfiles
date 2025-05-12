
(install-r7rs!)

(import (gnu home services mcron)
	(gnu home services)
	(gnu home)
	(gnu packages m4)
	(gnu packages guile-xyz)
	(guix gexp)
	(lazr base)
	(lazr executable-file))

(define lazr-term-services
  (services

   ;; Make sure Alacritty and dependent packages are installed.
   (packages-service 'lazr-alacritty-packages-service
		     alacritty m4 mcron)

   ;; Install the framework for the Alacritty terminal, with theming 
   (simple-service
    'lazr-alacritty-config-service
    home-files-service-type
    `((".config/alacritty/Makefile"
       ,(local-file (lazr-config-file "term/.config/alacritty/Makefile")
		    "lazr-alacritty-makefile"))

      (".config/alacritty/themes"
       ,(local-file (lazr-config-file "term/.config/alacritty/themes/")
		    "lazr-alacritty-themes"
		    #:recursive? #t))

      (".config/alacritty/alacritty.toml.m4"
       ,(local-file (lazr-config-file "term/.config/alacritty/alacritty.toml.m4")
		    "lazr-alacritty-main-config"))

      (".config/alacritty/theme.m4"
       ,(local-file (lazr-config-file "term/.config/alacritty/theme.m4")
		    "lazr-alacritty-theme-defns"))

      (".config/cron/alacritty-day-cycle.vixie"
       ,(local-file (lazr-config-file "term/.cron/alacritty-day-cycle.vixie")
		    "lazr-alacritty-day-cycle-job"))

      ,(script "alacritty-set-theme" "term/bin/")

      ))))
