
hook -group go-lsp-support global WinSetOption filetype=go %{
    try %{
	    ctags-disable-window

	    enable-lsp
	    echo -debug "go: enabled LSP for current file"

	    lazr-autodetect-lsp "gopls"
	    echo -debug "go: detected gopls, setting mappings..."
    }
}

hook -group gofmt global WinSetOption filetype=go %{
	set buffer formatcmd "gofmt"
	hook buffer BufWritePre * %{ format }
}
