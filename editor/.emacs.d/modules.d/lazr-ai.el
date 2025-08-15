
(require 'lazr-core)

(use-package gptel
  :init

  ;; OpenRouter offers an OpenAI compatible API
  (setq gptel-backend
        (gptel-make-openai "OpenRouter"
          :host "openrouter.ai"
          :endpoint "/api/v1/chat/completions"
          :stream t
          :models '(openai/gpt-3.5-turbo
                    mistralai/mixtral-8x7b-instruct
                    meta-llama/codellama-34b-instruct
                    codellama/codellama-70b-instruct
                    google/palm-2-codechat-bison-32k
                    google/gemini-pro)))

  (gptel-make-openai "Llamafile"
    :stream t
    :protocol "http"
    :host "localhost:8080"
    :models '(deepseek-r1)))

(provide 'lazr-ai)
