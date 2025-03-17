
hook global WinSetOption lintcmd=\w+ %{
	hook buffer BufWritePre . %{ lint-buffer }
}
