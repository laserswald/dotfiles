# M4 macro processor

declare-option str m4_inferior_language "plain"

hook global BufCreate .*[.](m4) %{
    set-option buffer filetype m4
}

try %{
	remove-highlighter shared/m4
}

add-highlighter shared/m4 regions
add-highlighter shared/m4/default default-region group
add-highlighter shared/m4/do_not_list region "#" "$" fill comment

add-highlighter shared/m4/default/ regex '\b(divnum)\b' 1:value
add-highlighter shared/m4/default/ regex '\b(define|pushdef|defn)\b' 1:function
add-highlighter shared/m4/default/ regex '\b(undefine|popdef)\b' 1:type
add-highlighter shared/m4/default/ regex '\b(include|sinclude)\b' 1:meta
add-highlighter shared/m4/default/ regex '\b(ifdef|ifelse|shift)\b' 1:meta
add-highlighter shared/m4/default/ regex '\b(len|index|regexp|substr|translit|patsubst|format|incr|decr|divert|undivert)\b' 1:builtin
add-highlighter shared/m4/default/ regex '\$\d+' 0:variable

hook -group m4-highlight global WinSetOption filetype=m4 %[ add-highlighter window/m4 ref m4 ]
hook -group m4-highlight global WinSetOption filetype=(?!m4).* %[ remove-highlighter window/m4 ]
