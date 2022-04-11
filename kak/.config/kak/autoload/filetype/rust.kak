
hook global WinSetOption filetype=rust %{
	set-option buffer formatcmd rustfmt
}
