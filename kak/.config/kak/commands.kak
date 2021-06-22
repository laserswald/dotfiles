####
#### My custom commands.
####
#### Custom tools begin here and then usually get migrated into their own plugin.
####

###
### Buffer manipulation.
###

define-command \
    -docstring "Rename the current buffer." \
    -override \
    -params 1..1 \
rename-file %{
    nop %sh{
        mv "$kak_buffile" "$1"
    }
    delete-buffer!
    edit %arg{1}
}

define-command \
    -docstring "Delete all other buffers, saving them all first." \
    -override \
delete-other-buffers %{
    write-all
    evaluate-commands %sh{
        for buf in $kak_buflist
        do
            if ! [ "$buf" = "$kak_bufname" ] && ! echo $buf | egrep -q '\*[^*]+\*'
            then 
                printf "echo -debug 'delete-other-buffers: deleting %s'\n" $buf
                printf "delete-buffer %s\n" $buf
            fi
        done
    }
    echo "Extra buffers deleted."
}

define-command \
    -hidden \
    -override \
    -docstring "Delete all other buffers except this one, don't ask to save them" \
delete-other-buffers-force %{
    evaluate-commands %sh{
        for buf in $kak_buflist
        do
            if ! [ "$buf" = "$kak_bufname" ] && ! echo $buf | egrep -q '\*[^*]+\*'
            then 
                printf "echo -debug 'delete-other-buffers!: deleting %s'\n" $buf
                printf "delete-buffer! %s\n" $buf
            fi
        done
    }
}
alias global "delete-other-buffers!" delete-other-buffers-force

###
### Other stuff.
### 

define-command \
    -docstring "Enable language server integration for this window, along with my... special twists." \
    -override \
enable-lsp %{
    echo -debug "Enabling LSP..."
    lsp-enable-window

    debug options

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

define-command \
    -override \
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

define-command \
    -override \
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

define-command \
    -docstring "Make the current buffer executable." \
    -override \
buffer-make-executable %{
	nop %sh{ chmod +x "$kak_buffile" }
	echo "Made buffer executable."
}

define-command \
    -docstring "Enable using information from tags files for information and completion." \
    -override \
ctags-enable-window %{
	ctags-enable-autocomplete
	ctags-enable-autoinfo

	hook -group ctags window BufWritePost .* %{
		ctags-update-tags
	}
}

define-command \
    -docstring "Stop using ctags information or updating it in this window." \
    -override \
ctags-disable-window %{
	ctags-disable-autocomplete
	ctags-disable-autoinfo

	remove-hooks window ctags
}

