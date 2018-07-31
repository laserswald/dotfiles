
declare-option -hidden str php_tmp_dir
declare-option -hidden completions php_reflect_completions

define-command php-reflect-complete %{
    evaluate-commands %sh{
    	dir=$(mktemp -d "${TMPDIR:-/tmp}"/kak-php-ref.XXXXXXXX)
    	mkfifo ${dir}/fifo
    	printf %s\\n "set-option buffer php_tmp_dir ${dir}"
    	printf %s\\n "evaluate-commands -no-hooks write ${dir}/buf"
    	localconfdir=${XDG_CONFIG_HOME:-${$HOME}/.config}/kak/autoload/lang/php/
    	dir=${kak_opt_php_tmp_dir}
    	(	
    	    candidates=$(php -f "${localconfdir}/php_available_fns.php" "${dir}/buf")
            echo "set buffer=${kak_bufname} php_reflect_completions '$'"
    	) >/dev/null 2>&1 </dev/null &
    }
}

define-command php-enable-autocomplete %{

}
