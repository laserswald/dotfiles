
define-command -override php-select-function %{
	evaluate-commands %sh{
		visibility='(public\s+|private\s+|protected\s+)?'
		begin_regex="${visibility}function"

		wants_inner=(echo "$kak_object_flags" | grep -q 'inner')
		wants_begin=(echo "$kak_object_flags" | grep -q 'to_begin')
		wants_end=(echo "$kak_object_flags" | grep -q 'to_end')

		printf 'execute-keys %[<a-/>%s<ret>F\{M]\n' $begin_regex
	}
}

hook global WinSetOption filetype=php %{
   	set-option buffer indentwidth 0
   	set-option buffer aligntab true

    map -docstring "function" buffer object F %{<a-;>php-select-function<ret>}
    map -docstring "class" buffer object C %{<a-;>php-select-function<ret>}
}
