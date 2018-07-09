
declare-option -docstring "File selection for :find function" str findcmd 'find -type f'

try %{
	add-highlighter global number_lines -relative -separator ' '

    def find -params 1 \
    	-shell-candidates '
        	${kak_opt_findcmd} >.kak_find_cache_tmp && mv .kak_find_cache_tmp .kak_find_cache &
        	PID=$!
    		if ! [ -e ".kak_find_cache" ]; then
				wait $PID
    		fi
    		cat ".kak_find_cache"
        	' \
     	%{edit %arg{1}}
}
