
(define-library (lazr executable-file)

  (import (scheme base)
	  (lazr base)
	  (guix gexp)
	  (guix store)
	  (guix monads)
	  (guix derivations)
	  (ice-9 match))

  (export executable-file)

  (begin
    (define xdg-executable-home ".local/bin")

    (define-record-type <executable-file>
      (executable-file file name)
      executable-file?
      (file executable-file-file)
      (name executable-file-name))

    (define-gexp-compiler (executable-file-compiler (file <executable-file>) system target)
      (match file
	(($ <executable-file> local-file-name name)
	 (gexp->derivation name
			   #~(begin
                               (copy-file #$(local-file (lazr-config-file local-file-name)) #$output)
					  (chmod #$output #o555))))))))

