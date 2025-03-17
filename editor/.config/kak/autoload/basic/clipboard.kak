
declare-option str clipboard_copy_cmd 
declare-option str clipboard_paste_cmd

define-command -override clipboard-paste-before %{
	execute-keys "!%opt{clipboard_paste_cmd}<ret>"
}

define-command -override clipboard-paste-after %{
	execute-keys "<a-!>%opt{clipboard_paste_cmd}<ret>"
}

define-command -override clipboard-copy %{
	execute-keys "<a-|>%opt{clipboard_copy_cmd}<ret>"
}

define-command -override clipboard-enable-win32 %{
	set-option global clipboard_copy_cmd 'win32yank.exe -i --crlf'
    set-option global clipboard_paste_cmd 'win32yank.exe -o --lf'
}

define-command -override clipboard-enable-xorg %{
	set-option global clipboard_copy_cmd 'xclip -i -selection clipboard'
	set-option global clipboard_paste_cmd 'xclip -o -selection clipboard'
}

define-command -override clipboard-enable-macos %{
	set-option global clipboard_copy_cmd 'pbcopy'
	set-option global clipboard_paste_cmd 'pbpaste'
}

define-command -override clipboard-enable-wayland %{
	set-option global clipboard_copy_cmd 'wl-copy'
	set-option global clipboard_paste_cmd 'wl-paste'
}

map -docstring "Copy to system clipboard" \
	global user y \
	"<esc>: clipboard-copy<ret>"

map -docstring "Paste from system clipboard" \
	global user p \
	"<esc>: clipboard-paste-after<ret>"

map -docstring "Paste from system clipboard before cursor" \
	global user P \
	"<esc>: clipboard-paste-before<ret>"

evaluate-commands %sh{
	# Try to figure out what system we are working on
	if [ $WAYLAND_DISPLAY ]
	then
	    printf %s\\n "clipboard-enable-wayland"
	elif [ $DISPLAY ]
	    printf %s\\n "clipboard-enable-xorg"
	fi
}
