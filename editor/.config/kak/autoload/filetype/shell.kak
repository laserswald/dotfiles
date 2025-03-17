# Shell script formatting and such.
hook global WinSetOption filetype=sh %{
    evaluate-commands %sh{
		if command -v shfmt >/dev/null; then
			echo "set-option buffer formatcmd %{shfmt --indent 4 --func-next-line --switch-case-indent}"
		fi

		if command -v shellcheck >/dev/null; then
			echo "set-option buffer lintcmd %{shellcheck --format=gcc --color=never}"
		fi
	}
}
