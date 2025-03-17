# Fennel language
#

hook global BufCreate .*[.](fnl) %{
    set-option buffer filetype fennel
}

hook global WinSetOption filetype=fennel %{
	require-module fennel
    set-option buffer extra_word_chars '_' '-'
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window fennel-.+ }
}

hook -group fennel-highlight global WinSetOption filetype=fennel %{
    add-highlighter window/fennel ref fennel
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/fennel }
}


provide-module fennel %{

add-highlighter shared/fennel regions
add-highlighter shared/fennel/code default-region group
add-highlighter shared/fennel/string region '"'   (?<!\\)(?:\\\\)*" fill string
add-highlighter shared/fennel/comment       region ';'  $                 fill comment

add-highlighter shared/fennel/code/keyword regex \b(and|break|do|else|elseif|end|for|fn|if|in|not|or|repeat|return|then|until|while|lambda|hashfn|partial|when|unless|var|tset|let|eval-compiler|set)\b 0:keyword
add-highlighter shared/fennel/code/value regex \b(false|nil|true|[0-9]+(:?\.[0-9])?(:?[eE]-?[0-9]+)?|0x[0-9a-fA-F])\b 0:value
add-highlighter shared/fennel/code/symbol regex \B:(?:[^\h()[\]{}]+) 0:string
add-highlighter shared/fennel/code/operator regex (\+|-|\*|/|%|\^|==?|~=|<=?|>=?|\.\.|#|=) 0:operator
add-highlighter shared/fennel/code/builtin regex \b(_G|_E)\b 0:builtin
add-highlighter shared/fennel/code/module regex \b(_G|_E)\b 0:module
add-highlighter shared/fennel/code/attribute regex \b(local)\b 0:attribute
add-highlighter shared/fennel/code/function_declaration regex (?:fn\h+)([a-zA-Z-_]+)\h+\[ 1:function

}
