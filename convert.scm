#! /usr/bin/env -S gosh -I /home/ben/src/scheme-requests-for-implementation/srfi-233 -mr7rs.user

(import (scheme base)
        (scheme process-context)
        (scheme file)
        (scheme write)
        (scheme show)
        (scheme generator)
        (scheme list)

        ; ini files
        (srfi 233)

        ; json
        (srfi 180)

        (srfi 78))

(define (make-toml-accumulator output-port)
  (make-ini-file-accumulator output-port " = " #\#))

(define (with-output-to-string thunk)
  (let ((output-string-port (open-output-string)))
    (parameterize ((current-output-port output-string-port))
      (thunk))
    (close-output-port output-string-port)
    (get-output-string output-string-port)))

(define (sexp->toml obj)
  (define (section? obj)
    (and (pair? obj)
         (symbol? (car obj))
         (pair? (cdr obj))))
  
  (define (entry? obj)
    (and (pair? obj)
         (symbol? (car obj))
         (string? (cdr obj))))

  (define (section-subname name subname)
    (if (eq? name '||) 
      subname
      (string->symbol (string-append (symbol->string name) "." (symbol->string subname)))))
  
  (define (process-items accumulator items section-name)
    (for-each (lambda (item)
                (cond 
                 ((section? item) (process-items 
                                   accumulator
                                   (cdr item)
                                   (section-subname section-name (car item))))
                 ((entry? item) 
                  (accumulator (list section-name (car item) (cdr item))))))
              items))
 
  (with-output-to-string
    (lambda ()
      (process-items (make-toml-accumulator (current-output-port))
                     obj
                     '||))))


(define (check-sexp->toml)
  (check (sexp->toml '((a . "5")
                       (b . "10")))
         => (string-append "a=5\n"
                           "b=10\n"))

  (check (sexp->toml '((section 
                        (a . "5")
                        (b . "10"))))
         => (string-append "[section]\n"
                           "a=5\n"
                           "b=10\n"))

  (check (sexp->toml '((section 
                        (subsection (a . "5")
                                    (b . "10")))))
         => (string-append "[section.subsection]\n"
                           "a=5\n"
                           "b=10\n")))

(define (run-tests!)
  (check-reset!)
  (check-sexp->toml)
  (check-report))

(define (main args)
  (display (sexp->toml (json-read (current-input-port)))))
