
(define-library (lazr packages)
  (export 
   python-llm)

  (import
   (scheme base)
   (guix packages)
   (guix build-system python))
  
  (begin 

    (define python-llm
      (package
       (name "python-llm")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page "https://github.com/kakounedotcom/prelude.kak")
       (source (origin 
                (method git-fetch)
                (uri (git-reference 
                      (url "https://github.com/kakounedotcom/prelude.kak")
                      (commit "master")))
                (sha256
                 (base32 "1pncr8azqvl2z9yvzhc68p1s9fld8cvak8yz88zgrp5ypx2cxl8c"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments
        (list
         #:install-plan #~'(("rc" "rc"))))))

   ))
