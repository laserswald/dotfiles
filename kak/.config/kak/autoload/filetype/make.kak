
hook global BufCreate .+Makefile[^/]* %{
	set-option buffer filetype makefile
}

hook global WinSetOption filetype=makefile %{
    remove-hooks buffer tabs-to-spaces
}
