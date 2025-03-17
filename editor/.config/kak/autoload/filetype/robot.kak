

hook global BufCreate .*[.](robot) %{
    set-option buffer filetype robot
}

hook global WinSetOption filetype=robot %{
	require-module robot
	add-highlighter window/ ref robot 
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window robot-.+ }
}

hook -group robot-highlight global WinSetOption filetype=(?!robot).* %{ remove-highlighter window/robot }

remove-highlighter shared/robot

add-highlighter shared/robot regions
add-highlighter shared/robot/data default-region group
add-highlighter shared/robot/line-comment region '#' '$' fill comment
add-highlighter shared/robot/data/header regex '\*\*\* \w+ \*\*\*' 0:type
add-highlighter shared/robot/data/builtins regex '\b(Suite|Test) (Setup|Teardown|Precondition|Postcondition)\b' 0:builtin
add-highlighter shared/robot/data/meta regex '\b(Library)\b' 0:meta
add-highlighter shared/robot/data/info regex '\b()\b' 0:keyword

