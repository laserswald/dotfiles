
(define-library (lazr base)
  (export define-packages-service
          packages-service
	  services

	  configurable-location
          lazr-config-file
          lazr-config-directory)

  (import (scheme base)
          (srfi 1)
          (guile)
          (scheme process-context)
          (gnu services)
          (gnu home services)
          (guix packages))

  (begin

    ;;;
    ;;; Configuration and standard locations.
    ;;; 

    ;; Looks at the methods of configuration and chooses the first value it
    ;; sees.
    (define (configurable-location my-env-var std-env-var backup-loc)
      (or (get-environment-variable my-env-var)
	  (get-environment-variable std-env-var)
	  backup-loc))

    ;; Directory to find configuration files.
    (define lazr-config-directory
      (configurable-location
       "LAZR_CONFIG_DIR"
       "XDG_CONFIG_DIR"
       (string-append 
	(or (get-environment-variable "HOME")
	    (string-append "/home/" (get-environment-variable "USER")))
	"/etc")))

    ;; Quickly refer to a file in my configuration.
    (define (lazr-config-file file-path)
      (string-append lazr-config-directory "/" file-path))

    ;;;
    ;;; Extra service types and macros
    ;;;

    ;; Group of services, so I can organize them how I like 
    (define (services . services) (flatten services))

    ;;; Define a service that just installs a set of packages. 
    (define (packages-service name . packages)
      (unless (symbol? name)
        (error "packages-service: name must be a symbol, but got " name))
      (unless (and (list? packages)
                   (every package? packages))
        (error "packages-service: `packages` must be a list of packages, but got " name))
      (simple-service name home-profile-service-type packages))

    ;; Syntax to define a new service that installs a set of packages.
    (define-syntax define-packages-service
      (syntax-rules ()
        ((_ name (packages ...))
         (define name (packages-service 'name packages ...)))))

    ;;;
    ;;; Utilities
    ;;;

    ;; Flatten a list of lists into a single top level list
    (define (flatten list-of-lists)
      (cond ((null? list-of-lists)
	     '())
	    ((list? (car list-of-lists))
	     (append (flatten (car list-of-lists))
		     (flatten (cdr list-of-lists))))
	    (else
	     (cons (car list-of-lists)
		   (flatten (cdr list-of-lists))))))

    ))

