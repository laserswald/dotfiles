;;;; Configuration for text editors.
(import
 (scheme base)
 (lazr base)
 (gnu packages emacs)
 (gnu packages emacs-xyz)
 (gnu packages text-editors))

;;; Configuration for the Emacs text editor.

(define-packages-service lazr-emacs-packages-service
  (emacs emacs-guix cmake libtool))

(define (emacs-server-shepherd-service config)
  (list (shepherd-service
         (documentation "Emacs server.")
         (provision '(emacs-server))
         (start #~(make-forkexec-constructor
                   (list #$(file-append emacs "/bin/emacs") "--fg-daemon")))
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
                  `((".emacs.d/init.el"
                     ,(local-file
                       (lazr-config-file "editor/.emacs.d/init.el")
                       "emacs-init-el"))
                    ("var/sound-effects"
                     ,(local-file
                       (lazr-config-file "editor/var/sound-effects")
                       "sound-effects"
                       #:recursive? #t))
                    (".emacs.d/modules.d"
                     ,(local-file
                       (lazr-config-file "editor/.emacs.d/modules.d")
                       "emacs-modules-d"
                       #:recursive? #t))
                    (".emacs.d/themes"
                     ,(local-file
                       (lazr-config-file "editor/.emacs.d/themes")
                       "emacs-themes"
                       #:recursive? #t)))))
                     

(define lazr-emacs-services
  (list lazr-emacs-packages-service
        (service home-emacs-server-service-type)
        lazr-emacs-config-service))
