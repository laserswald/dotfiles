#
# Plugins.
#

try %{
    require-module fzf
    set-option global fzf_file_command "ag -l -f --hidden --one-device --ignore .git"
}

try %{
    require-module tagbar
    hook global WinSetOption filetype=tagbar %{
    	remove-highlighter window/wrap
    }
}

try %{
    require-module powerline
    powerline-format global 'git bufname filetype mode_info lsp line_column position client session'
    powerline-enable
}

# wiki-setup %sh{ echo "$HOME/org" }

# parinfer
hook global WinSetOption filetype=(clojure|lisp|scheme|racket) %{
    try %{
        parinfer-enable-window -indent
        auto-pairs-disable
    }
}

# set-option -add global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
# set-option global snippets_auto_expand false
# map global normal <tab> ": snippets-select-next-placeholders<ret>"

try %{
    require-module rainbower
    rainbower-compile
    set-option global rainbow_mode 0
}

## Language server protocol support.
try %{
    require-module lsp
    set-option global lsp_hover_anchor true
    set-option global lsp_hover_max_lines 10
}
