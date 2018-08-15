
hook -group autocomplete global WinSetOption filetype=cpp %{ clang-enable-autocomplete }

hook -group c-tools global WinSetOption filetype=c %{
    clang-enable-autocomplete
    autotags-enable
    ctags-enable-autoinfo
    set buffer formatcmd %{astyle --style=1tbs}
    set buffer lintcmd %{cppcheck --template=gcc}
}
