
hook global WinSetOption filetype=yaml %{
	set-option buffer lintcmd "yamllint --format parsable"
}

