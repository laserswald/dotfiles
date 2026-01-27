
(define-library (lazr kakoune-plugins)
  (export kakoune-prelude
          kakoune-connect
          kakoune-auto-pairs
          kakoune-fzf
          kakoune-kakboard
          kakoune-powerline)

  (import (scheme base)
          (guix gexp)
          (guix packages)
          (guix licenses)
          (guix git-download)
          (guix build-system copy)
          (gnu packages text-editors)
          (gnu packages terminals))
  
  (begin
   (define kakoune-prelude
     (package
      (name "kakoune-prelude")
      (synopsis "Tools for kakoune plugin authors")
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
   
   (define kakoune-connect
     (package
      (name "kakoune-connect")
      (synopsis "Connect Kakoune to external programs")
      (description "")
      (license unlicense)
      (version "master")
      (home-page "https://github.com/kakounedotcom/connect.kak")
      (source (origin 
               (method git-fetch)
               (uri (git-reference 
                     (url "https://github.com/kakounedotcom/connect.kak")
                     (commit "master")))
               (sha256
                (base32 "1svw64zk28sn271vjyzvq21zaln13vnx59rxnxah6adq8n5nkr4a"))))
      (inputs 
       (list kakoune kakoune-prelude))
      (build-system copy-build-system)
      (arguments
       (list
        #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-auto-pairs
     (package
       (name "kakoune-auto-pairs")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page
         "https://github.com/alexherbo2/auto-pairs.kak")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/alexherbo2/auto-pairs.kak")
                  (commit "master")))
           (sha256
             (base32
               "0ijj636pbnkkwy8nl3b865qc5y6l9y4796b0pks343gsyrzi547l"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-fzf
     (package
       (name "kakoune-fzf")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page
         "https://github.com/andreyorst/fzf.kak")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/andreyorst/fzf.kak")
                  (commit "master")))
           (sha256
             (base32
               "0q2gwf6il7dwj2bynwhcwh4cxa6mg7z9aiwdzfi98ki62qgb79z0"))))
       (inputs (list kakoune fzf))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-kakboard
     (package
       (name "kakoune-kakboard")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page "https://github.com/lePerdu/kakboard")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/lePerdu/kakboard")
                  (commit "master")))
           (sha256
             (base32
               "0g8q0rkdnzsfvlibjd1zfcapngfli5aa3qrgmkgdi24n9ad8wzvh"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-lsp
     (package
       (name "kakoune-lsp")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page "https://github.com/kak-lsp/kak-lsp")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/kak-lsp/kak-lsp")
                  (commit "master")))
           (sha256
             (base32
               "1lppvr85rgw71y67mms3hkh47bsm71z09d3fj97f719g7y4pmj51"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-rainbow
     (package
       (name "kakoune-rainbow")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page
         "https://github.com/jjk96/kakoune-rainbow")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/jjk96/kakoune-rainbow")
                  (commit "master")))
           (sha256
             (base32
               "1hx79mxrajnkxk2f1q38zydgjhf5fb3kwmwvrmjv861rqqpbm49f"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-snippet-collection
     (package
       (name "kakoune-snippet-collection")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page
         "https://github.com/andreyorst/kakoune-snippet-collection")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/andreyorst/kakoune-snippet-collection")
                  (commit "master")))
           (sha256
             (base32
               "0h3cc0aq5yv8c26jxmnfcg0pib01qbwxv1sb0dlq3zgwafpvbmjy"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-snippets
     (package
       (name "kakoune-snippets")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page
         "https://github.com/occivink/kakoune-snippets")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/occivink/kakoune-snippets")
                  (commit "master")))
           (sha256
             (base32
               "12q32ahxvmi82f8jlx24xpd61vlnqf14y78ahj1381rv61a386mv"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-wiki
     (package
       (name "kakoune-wiki")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page
         "https://github.com/TeddyDD/kakoune-wiki")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/TeddyDD/kakoune-wiki")
                  (commit "master")))
           (sha256
             (base32
               "18drshhhx8gqqf1kblpvij2x7y1a2yla4dv0h45sw7dpil82swky"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-rainbower
     (package
       (name "kakoune-rainbower")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page
         "https://github.com/crizan/kak-rainbower")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/crizan/kak-rainbower")
                  (commit "master")))
           (sha256
             (base32
               "0r1ipl6yjcv09qvqpilfhy19lyrp0v9b0n6rp46pcar71mgkag4c"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-powerline
     (package
       (name "kakoune-powerline")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page
         "https://github.com/andreyorst/powerline.kak")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/andreyorst/powerline.kak")
                  (commit "master")))
           (sha256
             (base32
               "1lshlnz5xrxzafxmb6w05g2i6nvi49aqyd8852k9l0lmzqryp7l2"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-rep
     (package
       (name "kakoune-rep")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page "https://github.com/eraserhd/rep")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/eraserhd/rep")
                  (commit "master")))
           (sha256
             (base32
               "1fsbldh25r5zv8g26xldv77fsppan93hxlli7p4a016d386lkhvk"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))
   
   (define kakoune-tagbar
     (package
       (name "kakoune-tagbar")
       (synopsis "")
       (description "")
       (license unlicense)
       (version "master")
       (home-page
         "https://github.com/andreyorst/tagbar.kak")
       (source
         (origin
           (method git-fetch)
           (uri (git-reference
                  (url "https://github.com/andreyorst/tagbar.kak")
                  (commit "master")))
           (sha256
             (base32
               "0h985x62dwjpcl0zxsns5f6pr67i3zghi7w19qziy0ibf72g54bh"))))
       (inputs (list kakoune))
       (build-system copy-build-system)
       (arguments (list #:install-plan #~'(("rc" "rc"))))))))
