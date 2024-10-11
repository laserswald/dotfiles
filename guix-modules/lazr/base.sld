
(define-library (lazr base)
  (export define-packages-service
          lazr-config-file
          lazr-config-directory)

  (import (scheme base)
          (scheme process-context)
          (gnu services)
          (gnu home services))
  
  (begin
    ;;;
    ;;; Extra service types and macros
    ;;;

    (define-syntax define-packages-service
      (syntax-rules ()
        ((_ name (packages ...))
         (define name
           (simple-service 'name
                           home-profile-service-type
                           (list packages ...))))))
   
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

