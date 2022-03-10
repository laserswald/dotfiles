
declare-option bool c_fancy_hl_functions false

hook -group autocomplete global WinSetOption filetype=cpp %{ clang-enable-autocomplete }

hook -group c-tools global WinSetOption filetype=(c|cpp) %{
    clang-enable-autocomplete
    autotags-enable
    ctags-enable-autoinfo
    set buffer formatcmd %{astyle --style=1tbs}
    set buffer lintcmd %{cppcheck --template=gcc}
    require-module c-fancy-highlighting
}

provide-module c-fancy-highlighting %{
	require-module c

	# Highlight structures we access as a variable, gives us a better view of data flow
	add-highlighter shared/c/code/variable regex '\b(\w+)\b(->|\.)' 1:variable

	# Highlight CamelCase as a user-defined type, since this is relatively common
	add-highlighter shared/c/code/camel_case regex '\b[A-Z][a-zA-Z0-9_]+\b' 0:type

	# Highlight verbose struct types as also a user-defined type
	add-highlighter shared/c/code/verbose_struct regex 'struct\s+\b([a-zA-Z_][a-zA-Z0-9_]+)\b' 1:type

	# Highlight identifiers ending in underscore t as types as well
	add-highlighter shared/c/code/underscore_t_types regex '\b([a-zA-Z_][a-zA-Z0-9_]+_t)\b' 1:type

	# Highlight identifiers being called as function name, also highlights function declarations
	# (Added optional space inbetween function identifier name and the open parenthesis)
	add-highlighter shared/c/code/function_call regex '\b([a-zA-Z_][a-zA-Z0-9_]+)\b\(' 1:function

	# Highlight UPPER_SNAKE_CASE as a constant value
	add-highlighter shared/c/code/upper_snake regex '[A-Z][A-Z0-9_]+' 0:value

	# Highlight UPPER_SNAKE_CASE procedure calls as meta
	add-highlighter shared/c/code/upper_snake_call regex '([A-Z_]+)\s?\(' 1:meta

	# Highlight common stdlib functions as builtin after all the general highlighters
	add-highlighter shared/c/code/stdlibs_types regex '\b(FILE)\b' 0:type
	add-highlighter shared/c/code/stdlibs_fns regex '\b(malloc|free|calloc|realloc|fopen|fclose|getchar|fgets|fgetc|printf|fprintf)\b' 0:builtin

}
