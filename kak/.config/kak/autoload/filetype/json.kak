
hook global WinSetOption filetype=json %{ %sh{
	if test $(which 'jq'); then
		echo "set-option buffer format_cmd %{ jq . }"
	end
}}

