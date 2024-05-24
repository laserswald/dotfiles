(use-modules (srfi srfi-9))

(load "kakoune-plugins.scm")

(define-configuration kakoune-plugin-configuration
  (package
   (text-config '())
   "Package to use for the plugin.")

  (commands  
   (text-config '())
   "Extra Kakoune commands to evaluate after the plugin is loaded."))

(define (build-plugin-load-file dir)

  (define (enter? name stat result)
    ;; Ignore version control directories.
    (not (member (basename name) '(".git" ".svn" "CVS"))))
  
  (define (leaf name stat result)
    (if (string-suffix? ".kak" name)
      (string-append result "source \"" name "\"\n")
      result))

  (define (down name stat result) result)
  (define (up name stat result) result)
  (define (skip name stat result) result)
  (define (err name stat errno result) result)

  (file-system-fold enter? leaf down up skip err "" dir))                 

(define kakoune-plugin-loader-dir "kak/autoload/guix/")

(define (kakoune-plugin-xdg-configuration-files config)
  (let ((package (kakoune-plugin-configuration-package config)))
    `((,(string-append kakoune-plugin-loader-dir package ".kak")
       ,(mixed-text-file "kak-guix-plugin-loader"
                         (build-plugin-load-file package))))))

(define (kakoune-plugin-package config)
  (list (kakoune-plugin-configuration-package config)))

(define kakoune-plugin-service-type
  (service-type
   (name 'kakoune-plugin)
   (description "A plugin for the Kakoune text editor.")
   (default-value (kakoune-plugin-configuration))
   (extensions 
    (list (service-extension home-xdg-configuration-files-service-type
                             kakoune-plugin-xdg-configuration-files)
          (service-extension home-profile-service-type
                             kakoune-plugin-package)))))

(define-packages-service lazr-kakoune-packages-service
  (parinfer-rust
   sed 
   findutils

   kakoune-prelude
   kakoune-connect))

#|
(define-record-type <home-kakoune-configuration>
  (make-home-kakoune-configuration package scripts plugins)
  home-kakoune-configuration?
  (package home-kakoune-configuration-package)
  (scripts home-kakoune-configuration-scripts)
  (plugins home-kakoune-configuration-plugins))

(define home-kakoune-configuration)
|#

(define-configuration home-kakoune-configuration
  (package
   (package kakoune)
   "Package to use for Kakoune.")

  ;; Any scripts to install into the ~/.config/kak directory.
  #;(scripts
   (text-config '())
   "Scripts to install into the user's configuration directory.")
  
  (plugins
   (text-config '())
   "Plugins to add to the autoloader."))

(define (home-kakoune-xdg-configuration-files configuration)

  (define (directory? path)
    (eq? 'directory (stat:type (stat path))))

  (map (lambda (path)
         (list (string-append "kak/" name)
               (local-file (string-append "kak/.config/kak/" name)
                           #:recursive? (directory? (string-append "kak/.config/kak/" name)))))
       (home-kakoune-configuration-scripts configuration)))

(define (home-kakoune-packages configuration)
  (append (list (home-kakoune-configuration-package configuration))
          (map kakoune-plugin-package
               (home-kakoune-configuration-plugins configuration))))

;;;
;;; A Guix Home service for configuring the Kakoune text editor.
;;;
(define home-kakoune-service-type
  (service-type
   (name 'home-kakoune)
   (description
    "A service for configuring the Kakoune text editor.")
   (default-value (home-kakoune-configuration))
   (compose concatenate)
   (extend append)
   (extensions
    (list (service-extension home-xdg-configuration-files-service-type
                             home-kakoune-xdg-configuration-files)

          (service-extension home-profile-service-type
                             home-kakoune-packages)
          
          (service-extension kakoune-plugin-service-type
                             home-kakoune-plugins)))))

;;;
;;; Lazr's personal Kakoune configuration.
;;;
(define lazr-kakoune-config-service
  (service home-xdg-configuration-files-service-type
           (list (kak-script "kakrc")
                 (kak-script "commands.kak")
                 (kak-script "mappings.kak")
                 (kak-script "plugins.kak")
                 (kak-script "visual.kak")
                 (kak-script-dir "colors")
                 (kak-script-dir "snippets")

                 ;; Autoloads (have to be manually placed)
                 (kak-script "autoload/git.kak")
                 (kak-script "autoload/jumpjets.kak")
                 (kak-script "autoload/visibility-hl.kak")
                 (kak-script-dir "autoload/basic")
                 (kak-script-dir "autoload/filetype")
                 (kak-script-dir "autoload/lang")
                 (kak-script-dir "autoload/tools")
                 (kak-script-dir "autoload/windowing")

                 (list "kak/autoload/standard-libs" (file-append kakoune "/share/kak/autoload")))))
;;;
;;; The main Kakoune service list. Add here to enable things!
;;;
(define lazr-kakoune-services
  (list lazr-kakoune-packages-service
        (lazr-kakoune-config-service)
        (service kakoune-plugin-service-type
                 (kakoune-plugin-configuration 
                  (package kakoune-prelude)))))

