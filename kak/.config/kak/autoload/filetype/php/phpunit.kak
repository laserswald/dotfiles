
define-command -override -hidden php-set-phpunit-makecmd %{
    evaluate-commands %sh{
    	phpunit_cmd=""
    	command -v phpunit 2>&1 >/dev/null && phpunit_cmd=$(which 'phpunit')
    	[ -f "vendor/bin/phpunit" ] && phpunit_cmd="vendor/bin/phpunit"
    	[ "$phpunit_cmd" ] && echo "set buffer makecmd %{ $phpunit_cmd }"
    }
}
# hook global WinSetOption filetype=php %{ php-set-phpunit-makecmd }

