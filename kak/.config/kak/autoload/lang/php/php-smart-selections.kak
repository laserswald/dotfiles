# PHP smart selections
# --------------------

try %{
	remove-hooks php-objects
}

define-command -override php-select-function %<
	evaluate-commands %sh<
		for opt in $(echo "$kak_object_flags" | tr '|' ' '); do
		    case $opt in
		        inner) inner=1;;
		        to_begin) to_begin=1;;
		        to_end) to_end=1;;
		    esac
		done

		begin_regex='[ \t]?(public\s+|private\s+|protected\s+)?function'
		printf 'execute-keys <a-?>%s<ret>\n' "$begin_regex"

        if [ "$to_begin" -a "$to_end" ]; then
	        if [ "$inner" ]; then
				printf 'execute-keys f{m\n'
		    else
				printf 'execute-keys ";F{MJ"\n'
	        fi
        elif [ "$to_begin" ]; then
	        if [ "$inner" ]; then
				printf 'execute-keys F{\n'
	        fi
        elif [ "$to_end" ]; then
			printf 'execute-keys F{MJ\n'
        fi

        if [ "$inner" ]; then
            printf "execute-keys <a-X>\n"
        fi
    >
>

hook -group php-objects global WinSetOption filetype=php %{
	map -docstring "function" window object f '<a-;>php-select-function<ret>'
}
