;; Generate an SSH config file for a set of hosts.

(define (host name user)
  (list (cons 'name name)
        (cons 'user user)))

(define (host/static-ip name user static-ip)
  (cons (cons 'static-ip static-ip)
        (host name user)))

(define (host-name host)
  (symbol->string (cdr (assq 'name host))))

(define (host-user-name host) 
  (symbol->string (cdr (assq 'user host))))

(define (host-static-ip host)
  (cond ((assq 'static-ip host) => cdr)
        (else #f)))

(define (write-host-config host)

  (define (write-knock-matcher host domain)
    (display (string-append
              "Match Host " (host-name host) " exec \"nc -w 1 -z " (host-name host) domain " %p\" \n"
              "Hostname " (host-name host) domain "\n")))

  (write-knock-matcher host ".home.arpa")
  (write-knock-matcher host ".local")
  (write-knock-matcher host ".lazr.internal")
  (when (host-static-ip host)
    (display (string-append
              "Match Host " (host-name host) " exec \"nc -w 1 -z " (host-static-ip host) " %p\" \n"
              "Hostname " (host-static-ip host) "\n")))

  (display (string-append "Host " (host-name host)))
  (newline)
  (display (string-append "User " (host-user-name host)))
  (newline)

  (newline))

(define hosts
  (list (host 'polaris 'ben)
        (host 'betelgeuse 'ben)
        (host 'andromeda 'ben)
        (host/static-ip 'sol 'lazr "lazr.space")
        (host 'baked 'lazr)
        (host 'french-fry 'admin)
        (host 'gnocchi 'lazr)))

(for-each write-host-config hosts)
