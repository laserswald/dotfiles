
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

