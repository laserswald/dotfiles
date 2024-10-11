
(define-module (lazr executable-file)
  #:use-module (guix gexp)
  #:use-module (guix store)
  #:use-module (guix monads)
  #:use-module (guix derivations)
  #:use-module (srfi srfi-9)
  #:use-module (ice-9 match)
  #:export (executable-file))

(define xdg-executable-home ".local/bin")

(define-record-type <executable-file>
  (%executable-file file name)
  executable-file?
  (file executable-file-file)
  (name executable-file-name))

(define (executable-file file name)
  (%executable-file file name))

(define-gexp-compiler (executable-file-compiler (file <executable-file>) system target)
  (match file
    (($ <executable-file> local-file-name name)
     (gexp->derivation name
                       #~(begin
                          (copy-file #$(local-file local-file-name) #$output)
                          (chmod #$output #o555))))))

