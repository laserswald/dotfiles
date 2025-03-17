hook global WinSetOption filetype=python %{
    set-option buffer indentwidth 4
    hook -group tabs-to-spaces buffer InsertChar \t %{
        try %{
            execute-keys -draft h %opt{indentwidth}@
        }
    }
}

hook -group python-lsp-support global WinSetOption filetype=python %{
    try %{
	    ctags-disable-window

	    enable-lsp
	    echo -debug "python: enabled LSP for current window"

	    lazr-autodetect-lsp "pylsp"
	    echo -debug "go: detected pylsp, setting mappings..."

		hook buffer BufWritePre .* %{ lsp-formatting }
    }
}
