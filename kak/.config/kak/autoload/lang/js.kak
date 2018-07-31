
hook global WinSetOption filetype=javascript %{ %sh{
	if test $(which 'eslint'); then
		echo "set-option buffer format_cmd %{ eslint --format unix }"
	end
}}
