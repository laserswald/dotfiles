
declare-option str clipboard-copy-cmd 
declare-option str clipboard-paste-cmd

evaluate-commands %sh{
	printf "%s\n" "set-option global clipboard-copy-cmd 'win32yank.exe -i --crlf'"
	printf "%s\n" "set-option global clipboard-paste-cmd 'win32yank.exe -o --lf'"
}

define-command \
    -hidden \
x11-from-clipboard-after %{
	execute-keys "<a-!> xclip -o -selection clipboard<ret>"
}

define-command \
    -hidden \
x11-from-clipboard %{
	execute-keys "! xclip -o -selection clipboard<ret>"
}

alias global system-to-clipboard win32-to-clipboard
alias global system-from-clipboard win32-from-clipboard

map -docstring "Paste from system clipboard" \
	global user p \
	"<esc>: x11-from-clipboard-after<ret>"

map -docstring "Paste before" \
	global user P \
	"<esc>: x11-from-clipboard<ret>"

