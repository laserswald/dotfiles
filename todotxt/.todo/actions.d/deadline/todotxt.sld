
(define-library (todotxt)

  (export read-tasks
          write-tasks
          task-add-kv-tag
          task-remove-kv-tag)

  (import (scheme small)
          (scheme list)
          (scheme show)
          (scheme generator)
          (scheme text))
  
  (begin
   (define *task-file*
    (string-append (or (get-environment-variable "TODO_DIR")
                       ".")
                   "/todo.txt"))

   (define (read-tasks)
     (with-input-from-file *task-file*
       (lambda ()
         (generator->list read-line))))

   (define (write-tasks task-list)
     (with-output-to-file *task-file*
       (lambda ()
         (display (textual->string (textual-join task-list "\n"))))))

   (define (task-add-kv-tag task key value)
     (string-append task " " key ":" value))

   (define (task-remove-kv-tag task key)
     (textual->string
      (textual-join 
       (remove (lambda (word)
                 (and (key-value-tag? word)
                      (textual=? (tag-key word) key)))
               (textual-split task " "))
       " ")))
   
   (define (tag? word)
     (or (project-tag? word)
         (context-tag? word)
         (key-value-tag? word)))
   
   (define (project-tag? word)
     (char=? #\+ (textual-ref word 0)))

   (define (context-tag? word)
     (char=? #\@ (textual-ref word 0)))
   
   (define (key-value-tag? word)
     (textual-contains word ":"))

   (define (tag-key tag)
     (subtextual tag 
                 0 
                 (textual-index tag (lambda (c)
                                      (char=? #\: c)))))))
                 
