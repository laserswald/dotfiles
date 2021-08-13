
hook global WinSetOption filetype=makefile %{
    remove-hooks buffer tabs-to-spaces
}
