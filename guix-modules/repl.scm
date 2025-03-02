;;; Configuraton for the Guix repl for this repository

(use-modules (ice-9 readline)
	     (ice-9 colorized))

(activate-readline)
(activate-colorized)

(install-r7rs!)
