
(define-library (lazr base)
  (export define-packages-service
          packages-service
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
    ;;; Extra service types and macros
    ;;;

    (define (packages-service name . packages)
      (unless (symbol? name)
              (error "packages-service: name must be a symbol, but got " name))
      (unless (and (list? packages)
                   (every package? packages))
              (error "packages-service: `packages` must be a list of packages, but got " name))
      (simple-service name home-profile-service-type packages))

    (define-syntax define-packages-service
      (syntax-rules ()
        ((_ name (packages ...))
         (define name (packages-service 'name packages ...)))))
    
   
    (define lazr-config-directory
      (string-append 
       (or (get-environment-variable "HOME")
           (string-append "/home/" (get-environment-variable "USER")))
       "/etc"))
   
    (define (lazr-config-file file-path)
      (string-append lazr-config-directory
                     "/"
                     file-path))
   
   ))

