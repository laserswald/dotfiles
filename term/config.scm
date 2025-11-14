(install-r7rs!)

(import (gnu home services mcron)
        (gnu home services)
        (gnu home)
        (gnu packages m4)
        (gnu packages guile-xyz)
        (guix gexp)
        (lazr base)
        (lazr executable-file))

(define lazr-tmux-services
  (services 
   (packages-service 'lazr-tmux-packages-service
                     tmux)
   (simple-service
    'lazr-tmux-config-service
    home-files-service-type
    `((".config/tmux/tmux.conf"
       ,(local-file (lazr-config-file "term/.config/tmux/tmux.conf")
                    "lazr-tmux-conf"))
      (".config/tmux/plugins"
       ,(local-file (lazr-config-file "term/.config/tmux/plugins/")
                    "lazr-tmux-plugins"
                    #:recursive? #t))))))


(define (foot-server-shepherd-service config)
  (let* ((log-file #~(string-append %user-log-dir "/foot-server.log")))
    (list (shepherd-service
           (documentation "Foot server.")
           (provision '(foot-server))
           (modules '((shepherd support)))
           (start #~(make-forkexec-constructor
                     (list #$(file-append foot "/bin/foot") "--server")
                     #:log-file #$log-file))
           (stop #~(make-systemd-destructor))))))

(define home-foot-server-service-type
  (service-type
   (name 'home-foot-server)
   (extensions
    (list (service-extension home-shepherd-service-type foot-server-shepherd-service)))
   (default-value #f)
   (description "Run a foot terminal server to share resources across terminals.")))

(define lazr-foot-services
  (services
   (simple-service
    'lazr-foot-config-service
    home-files-service-type
    `((".config/foot/foot.ini"
       ,(local-file (lazr-config-file "term/.config/foot/foot.ini")
                    "lazr-foot-conf"))
      (".config/foot/themes"
       ,(local-file (lazr-config-file "term/.config/foot/themes/")
                    "lazr-foot-themes"
                    #:recursive? #t))))
   (packages-service 'lazr-foot-packages-service foot)
   #;(service home-foot-server-service-type)))

(define lazr-alacritty-services
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

      ,(script "alacritty-set-theme" "term/bin/")))))

(define lazr-term-services
  (services lazr-tmux-services
            lazr-foot-services
            lazr-alacritty-services))

