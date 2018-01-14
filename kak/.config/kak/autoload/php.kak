
hook global WinSetOption filetype=php %{
	evaluate-commands %{
    	php-set-phpunit-makecmd
    }
}
# Try to detect PHPUnit
define-command -hidden php-set-phpunit-makecmd %{
    %sh{
    	phpunit_cmd=""

    	command -v phpunit && phpunit_cmd="phpunit"
    	[ -f "vendor/bin/phpunit" ] && phpunit_cmd="vendor/bin/phpunit"

    	[ $phpunit_cmd ] && echo "set buffer makecmd ${phpunit_cmd}"
    }
}

declare-option -hidden str php_tmp_dir
declare-option -hidden completions php_reflect_completions

define-command php-reflect-complete %{
    %sh{
    	dir=$(mktemp -d "${TMPDIR:-/tmp}"/kak-php-ref.XXXXXXXX)
    	mkfifo ${dir}/fifo
    	printf %s\\n "set-option buffer php_tmp_dir ${dir}"
    	printf %s\\n "evaluate-commands -no-hooks write ${dir}/buf"
    }
    %sh{
    	localconfdir=${XDG_CONFIG_HOME:-${$HOME}/.config}/kak
    	dir=${kak_opt_php_tmp_dir}
    	(
			php -f "${localconfdir}/php_available_fns.php" "${dir}/buf"
    	) >/dev/null 2>&1 </dev/null &
    }
}
