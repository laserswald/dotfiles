
;;;; PHP.

(use-package ac-php :ensure t
  :config
  (add-hook 'php-mode-hook
	    '(lambda ()
	       (company-mode t)
	       (require 'company-php)
	       (set (make-local-variable 'company-backends)
		    '((company-ac-php-backend company-dabbrev-code)
		      company-capf company-files)))))

(use-package phpunit :ensure t)
