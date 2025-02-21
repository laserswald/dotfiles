
(require 'lazr-core)

(use-package gptel :ensure t
  :init  
  (setq
   gptel-model 'deepseek-chat
   gptel-backend (gptel-make-openai "DeepSeek"
		   :host "api.deepseek.com"
		   :endpoint "/chat/completions"
		   :stream t
		   :models '(deepseek-chat deepseek-coder))))

(provide 'lazr-ai)
