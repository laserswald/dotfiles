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
        for buf in "$kak_buflist"
        do
            case $buf in
                "$kak_bufname") : ;; # current buffer, don't do anything  
                "\**\*") : ;; # UI buffer, don't do anything.
                *) printf "delete-buffer %s\n" $buf ;;
            esac
        done
    }
}

define-command \
    -hidden \
    -override \
    -docstring "Delete all other buffers except this one, don't ask to save them" \
delete-other-buffers-force %{
    evaluate-commands %sh{
        for buf in "$kak_buflist"
        do
            case $buf in
                "$kak_bufname") : ;; # current buffer, don't do anything  
                "\**\*") : ;; # UI buffer, don't do anything.
                *) printf "delete-buffer! %s\n" $buf ;;
            esac
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
    lsp-enable-window

    unmap window goto d '<esc>: lsp-definition<ret>'
    unmap window goto r '<esc>: lsp-references<ret>'
    unmap window goto y '<esc>: lsp-type-definition<ret>'

    lsp-auto-hover-enable
    lsp-diagnostic-lines-enable window
    lsp-auto-signature-help-enable
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

