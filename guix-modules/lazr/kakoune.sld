
(define-library (lazr kakoune)
  (export kakoune-plugin-configuration
          kakoune-plugin-service-type
          lazr-kakoune-services)

  (import (scheme base)
          (guile)

          (gnu home)
          (gnu home services)
          (gnu packages base)
          (gnu packages text-editors)
          (gnu services)
          (gnu services configuration)

          (guix gexp)
          (guix packages)
          (guix licenses)

          (lazr base)
          (lazr executable-file)
          (lazr kakoune-plugins)
          (srfi 1)
          (ice-9 ftw))
  
  (begin
    ;;;
    ;;; Plugins.
    ;;;

    (define-maybe/no-serialization package)
    
    ;;;
    ;;; Configuration for a kakoune plugin.
    ;;;
    (define-configuration/no-serialization kakoune-plugin-configuration
      (package
       (maybe-package)
       "Package(s) to use for the plugin.")
    
      (commands  
       (text-config '())
       "Extra Kakoune commands to evaluate after the plugin is loaded."))
    
    (define (build-plugin-load-file plugin-package)
      (with-imported-modules '((ice-9 ftw))
        #~(begin
           (use-modules (ice-9 ftw))
    
           (letrec 
             ((enter?
               (lambda (name stat result)
                 ;; Ignore version control directories.
                 (not (member (basename name) '(".git" ".svn" "CVS")))))
              (leaf
               (lambda (name stat result)
                 (if (string-suffix? ".kak" name)
                     (string-append result "source \"" name "\"\n")
                     result)))
              (continue
               (lambda (name stat result) 
                 result))
              (err
               (lambda (name stat errno result)
                 result)))
               
             (file-system-fold enter? leaf continue continue continue err "" #$plugin-package)))))
    
    (define kakoune-plugin-loader-dir "kak/autoload/guix/")
    
    (define (kakoune-plugin-xdg-configuration-files config)
      (let ((package (kakoune-plugin-configuration-package config)))
        (if (maybe-value-set? package)
            `((,(string-append kakoune-plugin-loader-dir (package-name package) ".kak")
               ,(mixed-text-file (string-append (package-name package) "-plugin-loader")
                                 (build-plugin-load-file package))))
            '())))
    
    (define (kakoune-plugin-package config)
      (let ((package (kakoune-plugin-configuration-package config)))
        (if (maybe-value-set? package)
            (list package)
            (list))))
    
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
    
    ;;;
    ;;; Home configuration for Kakoune.
    ;;;
    
    (define-configuration home-kakoune-configuration
      (package
       (package kakoune)
       "Package to use for Kakoune.")
    
      ;; Any scripts to install into the ~/.config/kak directory.
      (scripts
       (text-config '())
       "Scripts to install into the user's configuration directory.")
      
      (plugins
       (text-config '())
       "Plugins to add to the autoloader."))
    
    (define (home-kakoune-xdg-configuration-files configuration)
    
      (define (directory? path)
        (eq? 'directory (stat:type (stat path))))
    
      (append (list (list "kak/autoload/standard-libs"
                          (file-append kakoune "/share/kak/autoload")))
              ;; Scripts
              (map (lambda (name)
                            (list (string-append "kak/" name)
                                  (local-file (string-append "kak/.config/kak/" name)
                                              #:recursive? (directory? (string-append "kak/.config/kak/" name)))))
                          (home-kakoune-configuration-scripts configuration))
    
              ;; plugins
              (append-map kakoune-plugin-xdg-configuration-files
                          (home-kakoune-configuration-plugins configuration))))
    
    (define (home-kakoune-packages configuration)
      (append (list (home-kakoune-configuration-package configuration))
              (map kakoune-plugin-configuration-package
                   (home-kakoune-configuration-plugins configuration))))
    
    (define (home-kakoune-plugins configuration)
      (home-kakoune-configuration-plugins configuration))
    
    (define (home-kakoune-configuration-extend configuration extensions)
      (fold 
       (lambda (configuration extension)
         (home-kakoune-configuration
          (package (or (home-kakoune-configuration-package extension)
                       (home-kakoune-configuration-package configuration)))
          (scripts (lset-union (home-kakoune-configuration-scripts extension)
                               (home-kakoune-configuration-scripts configuration)))
          (plugins (lset-union (home-kakoune-configuration-plugins extension)
                               (home-kakoune-configuration-plugins configuration)))))
       configuration
       extensions))
    
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
       (extend home-kakoune-configuration-extend)
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
      (service home-kakoune-service-type
               (home-kakoune-configuration
                (plugins
                 (list (kakoune-plugin-configuration (package kakoune-prelude))
                       (kakoune-plugin-configuration (package kakoune-connect))
                       (kakoune-plugin-configuration (package kakoune-powerline))
                       (kakoune-plugin-configuration (package kakoune-fzf))))
    
                (scripts
                 (list "kakrc"
                       "commands.kak"
                       "mappings.kak"
                       "plugins.kak"
                       "visual.kak"
                       "colors"
                       "snippets"
    
                       ;; Autoloads (have to be manually placed)
                       "autoload/git.kak"
                       "autoload/jumpjets.kak"
                       "autoload/visibility-hl.kak"
                       "autoload/basic"
                       "autoload/filetype"
                       "autoload/lang"
                       "autoload/tools"
                       "autoload/windowing")))))
    
    
    (define lazr-kakoune-packages-service
      (packages-service 'kakoune-extra-packages-service 
                        parinfer-rust 
                        sed 
                        findutils))
    
    (define lazr-kakoune-scripts-service 
      (simple-service
       'lazr-kakoune-scripts-service
       home-files-service-type
       `((".local/bin/kakp" ,(executable-file "kak/bin/kakp" "kakp"))
         (".local/bin/kak-jump" ,(executable-file "kak/bin/kak-jump" "kak-jump"))
         )))
    
    (define lazr-kakoune-services
      (list lazr-kakoune-packages-service
            lazr-kakoune-scripts-service
            lazr-kakoune-config-service))))
