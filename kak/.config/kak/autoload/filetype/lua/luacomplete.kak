
declare-option str lua_complete_filename

declare-option completions lua_complete_completions

define-command lua-complete %{
    echo -debug "Completing..."
	%sh{
		filename=$(mktemp -t kak-temp.XXXXXXXXX)
		echo "set buffer lua_complete_filename '$filename'"
		echo "write '$filename'"
	}
    echo -debug "wrote buffer"

	%sh{ (

		luacomplete_filter () {
			tail -n +2 | sed 's/: /:/g' | sed 's/|/:/g' | while IFS= read line
			do
				nm=$(echo $line | cut -d: -f1)
				tp=$(echo $line | cut -d: -f2)
				args=$(echo $line | cut -d: -f3)

				menu_disp="$nm {type}$tp{default}"
				if [ $args ]; then
					menu_disp="$menu_disp($args)"
				fi

				printf ":%s|%s|%s" "$nm" "$tp" "$menu_disp"
			done
		}

		buffer="${kak_opt_lua_complete_filename}"
		raw_candidates=$(lua-complete client -f ${buffer} --cursor ${kak_cursor_byte_offset} -r ".;/usr/share/lua/5.1/")
		candidates=$(echo "$raw_candidates" | luacomplete_filter)
		echo "echo -debug %{Candidates: $candidates}" | kak -p $kak_session

		rm $buffer
		completions="${kak_cursor_line}.${kak_cursor_column}@$kak_timestamp$candidates"
		echo "set buffer=${kak_bufname} lua_complete_completions '$completions'" | kak -p ${kak_session}
	) > /dev/null 2>&1 < /dev/null &}

    echo -debug "Done"
}

define-command lua-enable-autocomplete %{
    # Start the daemon
    %sh{
    	( lua-complete server ) > /dev/null < /dev/null 2>&1 &
    }
    set-option buffer completers "option=lua_complete_completions:%opt{completers}"
	hook buffer -group lua-autocomplete InsertIdle .* %{
    	try %{
        	execute-keys -draft <a-h><a-k>(\.|:|\(|\[).\z<ret>
        	echo "completing..."
        	lua-complete
        }
    }

    alias buffer complete lua-complete
}

define-command lua-disable-autocomplete %{
    set-option buffer completers %sh{ printf %s\\n "${kak_opt_completers}" | sed "s/option=lua_complete_completions://g" }
    remove-hooks buffer lua-autocomplete
    unalias window complete lua-complete
}
