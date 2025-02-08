
(use-modules (ice-9 ftw)
             (ice-9 popen)
             (ice-9 rdelim)
             (ice-9 pretty-print)
             (srfi srfi-1))

(define (with-changed-directory directory thunk)
  (let ((current-directory (getcwd)))
    (dynamic-wind
     (lambda () (chdir directory))
     thunk
     (lambda () (chdir current-directory)))))

(define (command->line cmd)
  (let* ((port (open-input-pipe cmd))
         (str  (read-line port))) ; from (ice-9 rdelim)
      (close-pipe port)
      str))

(define (git-origin-uri directory)
  (with-changed-directory directory
    (lambda ()
      (command->line "git remote get-url origin"))))

(define (package-hash-signature directory)
  (with-changed-directory directory
    (lambda ()
      (command->line "guix hash -x --serializer=nar ."))))

(define (remove-prefix prefix s)
  (if (string-prefix? prefix s)
    (string-copy s (string-length prefix) (string-length s))
    s))

(define (remove-prefixes prefixes s)
  (fold remove-prefix s prefixes))

(define (remove-suffix suffix s)
  (if (string-suffix? suffix s)
    (string-copy s 0 (- (string-length s)
                        (string-length suffix)))
    s))

(define (remove-suffixes suffixes s)
  (fold remove-suffix s suffixes))

(define (directory->plugin-name directory-name)
  (string-append "kakoune-"
                 (remove-prefixes 
                  '("kak-" "kakoune-")
                  (remove-suffixes
                   '(".kak")
                   directory-name))))

(define (plugin-declaration directory-name)
  (let ((plugin-name (directory->plugin-name (basename directory-name)))
        (plugin-uri  (git-origin-uri directory-name))
        (hash-signature (package-hash-signature directory-name)))
    `(define ,(string->symbol plugin-name)
       (package
        (name ,plugin-name)
        (synopsis "")
        (description "")
        (license unlicense)
        (version "master")
        (home-page ,plugin-uri)
        (source (origin 
                 (method git-fetch)
                 (uri (git-reference 
                       (url ,plugin-uri)
                       (commit "master")))
                 (sha256
                  (base32 ,hash-signature))))
        (inputs (list kakoune))
        (build-system copy-build-system)
        (arguments
         (list
          #:install-plan '(("rc" "rc"))))))))

(define (files-in-dir dir)
  (scandir dir (lambda (fname) (not (string-prefix? "." fname)))))

(define (dump-plugins dir)
  (for-each (lambda (plugin)
              (pretty-print (plugin-declaration (string-append dir plugin)))
              (newline))
            (files-in-dir dir)))



