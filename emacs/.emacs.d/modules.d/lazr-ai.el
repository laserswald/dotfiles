
(require 'lazr-core)

(use-package gptel :ensure t
  :init
  (setq gptel-model 'deepseek-r1
	gptel-backend (gptel-make-ollama "Ollama"
			:host "localhost:11434"
			:stream t
			:models '(deepseek-r1))))

(defun llm-send-project ()
  (interactive)
  (message "Not ready yet."))

(provide 'lazr-ai)
