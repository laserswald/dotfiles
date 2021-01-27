
define-command split-vertical -params 0..1 %{
	try %{
	    tmux-terminal-vertical kak -c %val{session} -e %arg{1}
	} catch %{
	    tmux-terminal-vertical kak -c %val{session}
	}
}

define-command split-horizontal -params 0..1 %{
	try %{
	    tmux-terminal-horizontal kak -c %val{session} -e %arg{1}
	} catch %{
	    tmux-terminal-horizontal kak -c %val{session}
	}
}

### Tools client.

define-command set-tools-client %{
	rename-client tools
	set-option global toolsclient tools
}

define-command open-tools %{
	split-vertical set-tools-client
}

define-command close-tools %{
	evaluate-commands %sh{
		printf %s\\n "evaluate-commands -client %opt{toolsclient} quit"
	}
}

### Docs client.

define-command set-docs-client %{
	rename-client docs
	set-option global docsclient docs
}

define-command open-docs %{
	split-horizontal set-docs-client
}

define-command close-docs %{
	evaluate-commands %sh{
		printf %s\\n "evaluate-commands -client %opt{docsclient} quit"
	}
}

define-command cross-reference %{
	evaluate-commands -client %opt{docsclient} ctags-search %val{selection}
}

declare-user-mode splits

map -docstring "Open the tools client below this pane." \
    global splits t ': open-tools<ret>'

map -docstring "Close the current tools client." \
    global splits T ': close-tools<ret>'

map -docstring "Open the docs client to the right of this pane." \
    global splits d ': open-docs<ret>'

map -docstring "Close the current docs client." \
    global splits D ': close-docs<ret>'


hook global ClientCreate .* %{
	setup-jump-client
}

## Commands.
define-command -hidden setup-jump-client %{
	evaluate-commands %sh{
		if ! (echo "$kak_client_list" | grep -q 'jump') ; then
			printf %s\\n "rename-client jump"
		fi
		if ! [ "$kak_opt_jumpclient" ] ; then
			printf %s\\n "set-option global jumpclient jump"
		fi
	}
}

### Repl client.
