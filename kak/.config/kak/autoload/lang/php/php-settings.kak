
hook global WinSetOption filetype=php %{
   	set-option buffer indentwidth 0
   	set-option buffer aligntab true
   	lint-enable
   	lint
}

