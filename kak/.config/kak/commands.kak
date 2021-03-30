
define-command -override cqllog-hl %~
	addhl buffer/start regex '([a-zA-Z]+): evaluating...' 1:bright-magenta,default
	addhl buffer/return regex '([a-zA-Z]+) (-->) ([^{\n]+)' 1:magenta,default 2:yellow,default 3:green,default
	addhl buffer/returnexpr regex '\(\d+\) ([a-zA-Z0-9 ]+) (-->) ([^{\n]+)' 1:cyan,default 2:yellow,default 3:green,default
	addhl buffer/expressionref regex '\(\d+\) ([a-zA-Z0-9 ]+):' 1:bright-cyan,default
	addhl buffer/true regex 'TRUE' 0:green,default
	addhl buffer/false regex 'FALSE' 0:red,default
	addhl buffer/null regex 'NULL' 0:bright-red,default
~

## Commands.

define-command -override \
git-merge-left %{
	# Search for the left marker, and delete just the marker.
	set-register slash '<{7}'
	execute-keys "<a-/><ret>xd"

	# Now select the center marker.
    set-register slash '={7}' 
	execute-keys "/<ret>"

    # Select to the right marker and delete.
	set-register slash '>{7}'
	execute-keys "?<ret><a-x>d"
}

define-command -override \
git-merge-right %{
	# Search backwards for the left marker. 
	set-register slash '<{7}'
	execute-keys "<a-/><ret>"

    # Select to the center marker and delete.
	set-register slash '={7}'
	execute-keys "?<ret><a-x>d"

    # Find the right marker and delete it.
	set-register slash '>{7}'
	execute-keys "/<ret>xd"
}

define-command -override -params 1..1 \
rename-file %{
	nop %sh{
        mv "$kak_buffile" "$1"
    }
    delete-buffer!
    edit %arg{1}
}

define-command -override \
enable-lsp %{
    echo -debug "Enabling LSP..."
    lsp-enable-window

    echo -debug "Removing LSP keybinds..."
    unmap window goto d '<esc>: lsp-definition<ret>'
    unmap window goto r '<esc>: lsp-references<ret>'
    unmap window goto y '<esc>: lsp-type-definition<ret>'

    echo -debug "Enabling LSP auto hover..."
    lsp-auto-hover-enable

    echo -debug "Enabling LSP diagnostic lines..."
    try %{ lsp-diagnostic-lines-enable window }

    echo -debug "Enabling LSP signature help..."
    lsp-auto-signature-help-enable

    echo -debug "LSP enabled."
}

