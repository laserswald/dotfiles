
(import (scheme base)
        (scheme file)
        (scheme write)
        (scheme process-context)
        (chibi process)
        (chibi filesystem)
        (chibi pathname))

;;;; Filesystem status updater, allowing other programs to see the current
;;;; status of the pomodoro cycle by just checking if a file exists or not.

;;; Where the filesystem status will go.
(define *status-dir*
  (string-append (get-environment-variable "TMPDIR")
                 "/pomo"))

;;; Create a file at the given path.
(define (touch path)
  (close-output-port (open-output-file path)))

;;; While we are running, make sure a file exists that shows where we currently
;;; are in the pomodoro set.
(define (update-status working?)

  ;;; Move to the other file.
  (define (switch-file from-file to-file)
    (when (file-exists? from-file)
          (delete-file from-file))
    (touch to-file))

  (let ((working-file (string-append *status-dir* "/wrk"))
        (break-file (string-append *status-dir* "/brk")))
    (unless (file-directory? *status-dir*)
      (create-directory* *status-dir*))
    (if working?
        (switch-file break-file working-file)
        (switch-file working-file break-file))))

;;; Destroy all the files in the status file directory.
(define (clean-status)
  (delete-file-hierarchy *status-dir*))

;;;; Enable playing a clock ticking background noise to remind you that you are
;;;; in a pomodoro right now.

(define *tick-sound*
  (string-append (get-environment-variable "XDG_CONFIG_HOME")
                 "/pomo/ticking.mp3"))

(define tick-pid #f)

(define (start-ticking)
  (display *tick-sound*)
  (newline)
  (call-with-process-io `(mpv -really-quiet -loop ,0 ,*tick-sound*)
    (lambda (pid stdin stdout stderr)
      (set! tick-pid pid))))

(define (stop-ticking)
  (if tick-pid
    (kill tick-pid signal/kill)
    (error "can't stop ticking, no PID for ticking program found")))

;;;; Use libcanberra and libnotify to send notifications to the user 

(define (play-sound what)
  (system "canberra-gtk-play" "-i" (symbol->string what)))

(define (alert message)
  (system "notify-send" "--urgency=critical" "pomodoro" message))

