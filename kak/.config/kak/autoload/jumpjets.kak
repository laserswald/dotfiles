
define-command tmux-terminal-full-top -params 1.. -shell-completion -override \
%{
    tmux-terminal-impl 'split-window -fbv -l 20' %arg{@}
}

define-command tmux-terminal-full-bottom -params 1.. -shell-completion -override \
%{
    tmux-terminal-impl 'split-window -fv -l 20' %arg{@}
}

define-command tmux-terminal-full-left -params 1.. -shell-completion -override \
%{
    tmux-terminal-impl 'split-window -fhb -l 20' %arg{@}
}

define-command tmux-terminal-full-right -params 1.. -shell-completion -override \
%{
    tmux-terminal-impl 'split-window -fh -l 20' %arg{@}
}

define-command \
	-override \
	-params 0..1 \
split-vertical %{
	new-jumpable-window tmux-terminal-vertical %arg{1}	    
}

define-command \
	-override \
	-params 0..1 \
split-horizontal %{
	new-jumpable-window tmux-terminal-horizontal %arg{1}
}

define-command \
	-override \
	-params 0..1 \
new-tab %{
	new-jumpable-window tmux-terminal-window %arg{1}	    
}

define-command \
	-override \
	-params 1.. \
    -hidden \
new-jumpable-window %{
	evaluate-commands %sh{
		cmd=$1
		shift

		startup="jump-to-last-enable"

		if [ "$@" ]; then
		    startup="$startup;$@"
		fi
        printf "%s %s\n" "$cmd" "$SHELL -c \"kak -c $kak_session -e \'$startup\'\""
	}
}


define-command \
	-override \
	-params 1.. \
    -hidden \
new-nonjumpable-window %{
	evaluate-commands %sh{
		cmd=$1
		shift

		if [ "$@" ]; then
	        printf "%s %s\n" "$cmd" "$SHELL -c \"kak -c $kak_session -e \'$@\'\""
	    else 
	        printf "%s %s\n" "$cmd" "$SHELL -c 'kak -c $kak_session'"
		fi
	}
}

alias global split split-horizontal
alias global vsplit split-vertical
alias global tnew new-tab

### Tools client.

define-command \
    -override \
set-tools-client %{
	rename-client tools
	set-option global toolsclient tools
}

define-command \
    -override \
open-tools %{
	new-nonjumpable-window tmux-terminal-full-bottom set-tools-client
}

define-command \
    -override \
close-tools %{
	evaluate-commands %sh{
		printf %s\\n "evaluate-commands -client %opt{toolsclient} quit"
	}
}

### Docs client.

define-command \
    -override \
set-docs-client %{
	rename-client docs
	set-option global docsclient docs
}

define-command \
    -override \
open-docs %{
	new-nonjumpable-window tmux-terminal-horizontal set-docs-client
}

define-command \
    -override \
close-docs %{
	evaluate-commands %sh{
		printf %s\\n "evaluate-commands -client %opt{docsclient} quit"
	}
}

define-command \
    -override \
cross-reference %{
	evaluate-commands -client %opt{docsclient} ctags-search %val{selection}
}

try %{ declare-user-mode splits }

map -docstring "Open the tools client below this pane." \
    global splits t ': open-tools<ret>'

map -docstring "Close the current tools client." \
    global splits T ': close-tools<ret>'

map -docstring "Open the docs client to the right of this pane." \
    global splits d ': open-docs<ret>'

map -docstring "Close the current docs client." \
    global splits D ': close-docs<ret>'

define-command \
    -override \
jump-to-last-enable %{
	hook -group jump-to-last buffer FocusIn .* %{
		set-option global jumpclient %val{client}
	}
}

define-command \
    -override \
jump-to-last-disable %{
	remove-hooks buffer jump-to-last 
}

hook global BufCreate '\*.*\*' jump-to-last-disable

### Repl client.
