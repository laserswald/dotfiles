
hook global WinSetOption filetype=kak %{
    map buffer user s \
        -docstring "Source this kak file" \
        <esc>:source<space>%reg{%}<ret>
}
