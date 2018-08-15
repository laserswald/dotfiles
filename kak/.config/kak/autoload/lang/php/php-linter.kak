
hook global WinSetOption filetype=php %{
    set buffer lintcmd %{~/.config/kak/kak_phplint}
    lint-enable
}
