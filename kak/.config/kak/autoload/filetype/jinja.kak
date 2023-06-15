
#
# Automatic detection of Jinja-templated files.
#

define-command -override jinja-enable %{
	require-module jinja
    add-highlighter window/jinja ref jinja
    hook -once -always window WinSetOption filetype=.* %{
	    remove-hooks window jinja-.
	    remove-highlighter window/jinja
    }
}

hook global -group jinja-terraform BufCreate ".*\.(tf|tfvars)\.(j2|jinja)" %{
	set-option buffer filetype "terraform"
	jinja-enable
}
