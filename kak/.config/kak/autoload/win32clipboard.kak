
define-command -hidden win32-to-clipboard %{
    execute-keys %{<a-|>win32yank.exe -i --crlf<ret>}
}

define-command -hidden win32-from-clipboard %{
    execute-keys %{!win32yank.exe -o --lf<ret>}
}

alias global system-to-clipboard win32-to-clipboard
alias global system-from-clipboard win32-from-clipboard
