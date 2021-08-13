
hook global WinSetOption filetype=(lisp|clojure|fennel) %{
    set-option buffer indentwidth 2
    set-option buffer tabstop 2
    rainbow-enable
    map -docstring "Send selection to repl window" buffer user s <esc>:send-text<ret>       
    map -docstring "Send current paragraph to repl window" buffer user S <esc><a-i>p:send-text<ret> 
}
