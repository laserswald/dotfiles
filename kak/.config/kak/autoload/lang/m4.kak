# M4 macro processor

declare-option str m4_inferior_language "plain"

hook global BufCreate .*\.(m4) %{
    set-option buffer filetype m4
}

add-highlighter shared/m4 regions
add-highlighter shared/m4/default default-region
add-highlighter shared/m4/do_not_list region "dnl" "$" fill comment
add-highlighter shared/m4/quoted region "`" "'" fill string 
add-highlighter shared/m4/default/builtin_macros 

hook -group m4-highlight global WinSetOption filetype=m4 %[ add-highlighter window/m4 ref m4 ]
hook -group m4-highlight global WinSetOption filetype=(?!m4).* %[ remove-highlighter window/m4 ]
