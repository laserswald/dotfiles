
hook global WinSetOption filetype=yaml %{
	set-option window formatcmd "expand -t 4"
	hook window BufWritePre .* format-buffer
}

