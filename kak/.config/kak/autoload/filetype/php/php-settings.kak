
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
define-command -override -hidden php-set-phpunit-makecmd %{
    evaluate-commands %sh{
    	phpunit_cmd=""
    	command -v phpunit 2>&1 >/dev/null && phpunit_cmd=$(which 'phpunit')
    	[ -f "vendor/bin/phpunit" ] && phpunit_cmd="vendor/bin/phpunit"
    	[ "$phpunit_cmd" ] && echo "set buffer makecmd %{ $phpunit_cmd }"
    }
}
# hook global WinSetOption filetype=php %{ php-set-phpunit-makecmd }

hook global WinSetOption filetype=php %{
   	set-option buffer indentwidth 0
   	set-option buffer aligntab true

    map -docstring "function" buffer object F %{<a-;>php-select-function<ret>}
    map -docstring "class" buffer object C %{<a-;>php-select-function<ret>}
}
