# Snippet handler.

declare-option -hidden completions snippet_candidates 

define-command load-snippet -override -params 1 %{
	execute-keys "!cat ~/snip/" %arg{1} "<ret>"
}

