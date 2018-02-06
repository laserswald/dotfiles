
hook global WinSetOption filetype=php %{
   	evaluate-commands %{ php-set-phpunit-makecmd }
   	set buffer indentwidth 0
   	hook buffer BufWritePost .* %{
       	ctags-update-tags
    }
}

hook global WinSetOption filetype=php %{
    set buffer lintcmd %{ ~/.config/kak/kak_phplint }
    hook buffer BufWritePost .* %{ lint }
    lint-enable
    lint
}

# Try to detect PHPUnit and set it as the makecmd
define-command -allow-override -hidden php-set-phpunit-makecmd %{
    evaluate-commands %sh{
    	phpunit_cmd=""
    	command -v phpunit 2>&1 >/dev/null && phpunit_cmd=$(which 'phpunit')
    	[ -f "vendor/bin/phpunit" ] && phpunit_cmd="vendor/bin/phpunit"
    	[ "$phpunit_cmd" ] && echo "set buffer makecmd %{ $phpunit_cmd }"
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
