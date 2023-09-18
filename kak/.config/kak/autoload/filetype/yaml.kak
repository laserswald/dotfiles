
hook global WinSetOption filetype=yaml %{
	set-option buffer lintcmd "yamllint --format parsable"
	set-option buffer indentwidth 2
	set-option buffer aligntab false
}

