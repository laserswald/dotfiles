
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
	hook buffer BufWritePre .* %{ format }
}

hook -group go-fancy-highlighting global WinSetOption filetype=go %{
	require-module go-fancy-highlighting
}

provide-module -override go-fancy-highlighting %{
	require-module go
	add-highlighter shared/go/code/ regex "\b(\w+)\(" 1:function
}

