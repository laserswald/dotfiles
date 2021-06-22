
hook global WinSetOption filetype=php %{
    require-module php-objects
    require-module php-fancy-highlighting

    set-option buffer indentwidth 4
    set-option buffer aligntab false

    map -docstring "function" buffer object F %{<a-;>php-select-function<ret>}
    map -docstring "class" buffer object C %{<a-;>php-select-function<ret>}
    map -docstring "Apply a refactoring with Phpactor" buffer user R '<esc>: phpactor-mode<ret>'

    # set-option buffer lintcmd "kak_phplint"

    try %{ remove-hooks buffer tabs-to-spaces }
}

# hook -group php-lint global BufWritePost .*\.php %{
#     lint-buffer
# }

hook -group php-lsp-support global WinSetOption filetype=php %{
    try %{
	    ctags-disable-window

	    enable-lsp
	    echo -debug "php: enabled LSP for current file"

	    lazr-autodetect-lsp "intelephense"
	    echo -debug "php: detected intelephense, setting mappings..."
    }
}

define-command -override phpunit-this-file %{
    set-option buffer makecmd "vendor/bin/phpunit %reg{%}"
}

define-command -override -hidden php-set-phpunit-makecmd %{
    evaluate-commands %sh{
    	phpunit_cmd=""
    	command -v phpunit 2>&1 >/dev/null && phpunit_cmd=$(which 'phpunit')
    	[ -f "vendor/bin/phpunit" ] && phpunit_cmd="vendor/bin/phpunit"
    	[ "$phpunit_cmd" ] && echo "set buffer makecmd %{ $phpunit_cmd }"
    }
}

provide-module php-fancy-highlighting %{
    require-module php
    require-module visibility-faces

    add-highlighter shared/php/code/this regex '\$this' 0:value
    add-highlighter shared/php/code/function regex 'function (\w+)\(' 1:function
    add-highlighter shared/php/code/use_statement regex 'use ([a-zA-Z_][a-zA-Z0-9_]+\\)*([a-zA-Z_][a-zA-Z0-9_]+);' 1:module 2:type

    add-highlighter shared/php/code/public regex 'public' 0:Public
    add-highlighter shared/php/code/protected regex 'protected' 0:Protected
    add-highlighter shared/php/code/private regex 'private' 0:Private

    add-highlighter shared/php/code/builtins regex \b(array_change_key_case|array_chunk|array_column|array_combine|array_count_values|array_diff_assoc|array_diff_key|array_diff_uassoc|array_diff_ukey|array_diff|array_fill_keys|array_fill|array_filter|array_flip|array_intersect_assoc|array_intersect_key|array_intersect_uassoc|array_intersect_ukey|array_intersect|array_key_exists|array_key_first|array_key_last|array_keys|array_map|array_merge_recursive|array_merge|array_multisort|array_pad|array_pop|array_product|array_push|array_rand|array_reduce|array_replace_recursive|array_replace|array_reverse|array_search|array_shift|array_slice|array_splice|array_sum|array_udiff_assoc|array_udiff_uassoc|array_udiff|array_uintersect_assoc|array_uintersect_uassoc|array_uintersect|array_unique|array_unshift|array_values|array_walk_recursive|array_walk|arsort|asort|compact|count|current|each|end|extract|in_array|key_exists|key|krsort|ksort|list|natcasesort|natsort|next|pos|prev|range|reset|rsort|shuffle|sizeof|sort|uasort|uksort|usort)\b 1:builtin

    add-highlighter shared/php/code/modifiers regex \b(const|static|final|abstract)\b 1:attribute
    add-highlighter shared/php/code/modules regex \b(use|include|require|include_once|require_once|namespace)\b 1:meta
}


# PHP smart selections
# --------------------

provide-module php-objects %<
require-module php

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
>

