
define-command zeal-search -override -params 0..1 %{
	nop %sh{
		if [ $# -eq 1 ]
		then
			zeal "$1" &
		else
			zeal "$kak_selection" &
		fi
	}
}

evaluate-commands %sh{
	if command -v zeal >/dev/null
	then
	    printf "%s\n" 'map global goto D ": zeal-search<ret>"'
	fi
}
