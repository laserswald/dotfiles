;;; lazr-ai.el --- Configuration for AI integrations  -*- lexical-binding: t; -*-

;; Copyright (C) 2025 Ben Davenport-Ray

;; Author: Ben Davenport-Ray <me@lazr.space>
;; Keywords: ai

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This module installs and configures gptel, an LLM integration package,
;; for Emacs. We set up several LLM backends to choose from, from commercially
;; hosted models supplied through OpenRouter, to locally hosted LLMs using
;; either Llamafile or the Ollama frontend service.

;;; Code:

(require 'lazr-core)
(require 'lazr-keybindings)
(require 'password-store) ; for my openrouter password

;; Install gptel if we don't have it installed already.
(lazr/require-package 'gptel)

;;;
;;; Define some backends to supply model access to us.
;;;

(defconst lazr/openrouter-backend
  (gptel-make-openai "OpenRouter"
    :host "openrouter.ai"
    :key (lambda () (password-store-get "services/openrouter.ai/key"))
    :endpoint "/api/v1/chat/completions"
    :stream t
    :models '(mistralai/devstral-2512:free 
              google/gemini-2.5-flash))
  "An LLM backend that uses OpenRouter to dispatch between many hosted LLM services")

(defconst lazr/llamafile-backend
  (gptel-make-openai "Local"
    :stream t
    :protocol "http"
    :host "localhost:8080")
  "An LLM backend that uses a locally running Llamafile listening on port 8080.")

(defconst lazr/ollama-backend
  (gptel-make-ollama "Ollama"
    :stream t
    :host "localhost:11434"
    :models '(devstral
              gemma2))
  "An LLM backend that uses the Ollama local model service, listening at 11434.")

;;;
;;; Define some presets, a feature that bundles 
;;;

;; explain will ask the LLM to explain the current code.
(gptel-make-preset 'explain
  :system "Explain what this code does."
  :backend "Ollama"
  :model 'devstral)
  
;; Set the default backend to ollama.
(setq gptel-backend lazr/ollama-backend)

;;;
;;; Set up keybindings for sending data to the LLM for querying.
;;;

;; Global bindings for bringing up the chat interface, the menu for
;; modifying and sending a prompt, etc.
(lazr/leader-map :infix "l"
  "l" 'gptel
  "," 'gptel-menu
  "r" 'gptel-rewrite)

;; Add key mappings for the interactive chat mode.
(lazr/local-leader-map :keymaps 'gptel-mode-map
  "," 'gptel-send ; comma comma sends it
  "a" 'gptel-abort) ; cancel cancel cancel cancel

(provide 'lazr-ai)
;;; lazr-ai.el ends here

