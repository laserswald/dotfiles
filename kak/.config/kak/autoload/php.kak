
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

