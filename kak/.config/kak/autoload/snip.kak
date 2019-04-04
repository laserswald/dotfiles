# Snippet handler.

declare-option -hidden snippet-candidates completions

define-command load-snippet -override -params 1 %{
	execute-keys "!cat ~/snip/" %arg{1} "<ret>"
}


