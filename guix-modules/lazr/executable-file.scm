
(define-library (lazr executable-file)

  (import (scheme base)
	  (lazr base)
	  (guix gexp)
	  (guix store)
	  (guix monads)
	  (guix derivations)
	  (ice-9 match))

  (export
   executable-file
   script)

  (begin
    (define xdg-executable-home ".local/bin")

    ;; Directory to install scripts.
    (define script-install-dir ".local/bin/")

    (define-record-type <executable-file>
      (executable-file file name)
      executable-file?
      ;; The file to install.
      (file executable-file-file)
      ;; The name of the Guix derivation/entity to reference as
      (name executable-file-name))

    (define-gexp-compiler (executable-file-compiler (file <executable-file>) system target)
      (match file
	(($ <executable-file> local-file-name name)
	 (gexp->derivation name
			   #~(begin
                               (copy-file #$(local-file (lazr-config-file local-file-name)) #$output)
					  (chmod #$output #o555))))))))

    ;; Build a home-files-service specification for a script
    (define (script name where)
      (list (string-append script-install-dir name)
	    (executable-file
	     (string-append where name)
	     (string-append "lazr-scripts-" name))))
