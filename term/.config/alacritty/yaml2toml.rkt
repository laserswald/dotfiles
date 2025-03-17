#lang racket

(require racket/cmdline)
(require toml)
(require yaml)

(vector-for-each 
 (lambda (filename)
   (let* ([in (read-yaml* (open-input-file filename))
           out-filename (string-replace #rx"ya?ml$" filename "toml")
           out (open-output-file (out-filename))
           ]
 (current-command-line-arguments))
