
define-command phpactor-mode %{
	require-module phpactor
	enter-user-mode phpactor
}

provide-module phpactor %{

try %{ declare-user-mode phpactor }

#
# Mappings.
#

map global phpactor -docstring "Implement functions required by this class' interfaces" 'i' '<esc>: phpactor-implement-contracts<ret>'
map global phpactor -docstring "Add missing member variables from assignments" 'm' '<esc>: phpactor-add-missing-args<ret>'
map global phpactor -docstring "Complete constructor" 'C' '<esc>: phpactor-complete-constructor<ret>'
map global phpactor -docstring "Fix namespace and class name" 'n' '<esc>: phpactor-fix-namespace-class-name<ret>'
map global phpactor -docstring "Generate accessor function" 'a' '<esc>: phpactor-generate-accessor<ret>'

#
# Available refactoring commands.
# 

define-command phpactor-add-missing-args         %{ phpactor-transform 'add_missing_assignments' }
define-command phpactor-implement-contracts      %{ phpactor-transform 'implement_contracts' }
define-command phpactor-complete-constructor     %{ phpactor-transform 'complete_constructor' }
define-command phpactor-fix-namespace-class-name %{ phpactor-transform 'fix_namespace_class_name' }

define-command phpactor-context-menu %{
	evaluate-commands %sh{
		params=$(jq -nc --arg SOURCE "$(cat $kak_buffile)" --arg OFFSET $kak_cursor_byte_offset --arg PATH "$kak_buffile" '{"source": $SOURCE, "offset": $OFFSET, "current_path": $PATH}')
		printf "phpactor-rpc 'context_menu' '%s'\n" "$params" 
	}
}

define-command phpactor-generate-accessor %{
	phpactor-rpc-with-source-offset 'generate_accessor'
}

#
# Methods of talking to the Phpactor tool
#

define-command -hidden phpactor-rpc-with-source-offset -params 1 %{
	evaluate-commands %sh{
		tempfile=$(mktemp "$TMPDIR/kak-phpactor.XXXXXX")
        jq -nc \
            --arg ACTION "$1" \
			--arg SOURCE "$(cat $kak_buffile)" \
            --arg OFFSET $kak_cursor_byte_offset \
            --arg PATH $kak_buffile \
            '{"action": $ACTION, "parameters": {"source": $SOURCE, "offset": $OFFSET, "path": $PATH}}' |\
            phpactor rpc > $tempfile

        printf "phpactor-dispatch-action-from-file '%s'\n" "$tempfile"
	}
}

define-command -hidden phpactor-transform -params 1 %{
	echo "Transforming..."
	nop %sh{
		phpactor class:transform ${kak_bufname} --transform=$1
	}
	edit!
	echo "Done!"
}

define-command -hidden phpactor-rpc -params 0..2 %{
	evaluate-commands %sh{
		printf "echo -debug 'parameters : %s'\n" "$2"
        response=$(jq -n --arg ACTION "$1" --argjson PARAMETERS "$2" '{"action": $ACTION, "parameters": $PARAMETERS}' | phpactor rpc | jq -c .)
        printf "phpactor-dispatch-action '%s'\n" "$response"
	}
}

define-command -hidden phpactor-handle-input-callback -params 1..1 %{
    evaluate-commands %sh{
        handle_menu_input() {
            printf "menu "
            for

            printf "phpactor-send-callback-response "
        }

        response=$1
		callback_action=$(echo "$response" | jq -r '.parameters.callback.action')
		callback_params=$(echo "$response" | jq -c '.parameters.callback.parameters')
		printf "phpactor-rpc '%s' '%s'\n" $callback_action ""
    }
}

define-command -hidden phpactor-send-callback-response -params 2 %{

}

define-command -hidden phpactor-dispatch-action -params 1..1 %{
	evaluate-commands %sh{
		response=$1
		action=$(echo "$response" | jq -r '.action');
		case $action in
            "return")
                # not sure what to do here
			;;
            "return_choice")
                printf 'menu %s\n'
			;;
            'echo')
                printf "echo '%s'\n" "$(echo "$response" | jq -r '.parameters.message')"
			;;
            'error')
                printf "fail 'phpactor: $(echo "$response" | jq -r '.parameters.message')'\n"
			;;
            'collection')

			;;
            'open_file')
                printf 'edit! %s\n' `echo "$response" | jq -r '.parameters.path'`
			;;
            'close_file')
                printf 'delete-buffer! %s\n' `echo "$response" | jq '.parameters.path'`
			;;
            'file_references')

			;;
            'input_callback')
                printf "phpactor-handle-input-callback '%s'\n" "$response"
			;;
            'information')

			;;
            'replace_file_source')
                tempfile=$(mktemp "kak-phpactor.XXXXX")
                echo "$response" | jq -r '.parameters.source' > $tempfile
                # clear current buffer
                printf "execute-keys '%s'\n" '%d'
                # read in new file
                printf "execute-keys '%s'\n" "!cat $tempfile<ret>"
                # delete temporary file
                rm $tempfile
			;;
			*)
			    printf "fail 'phpactor-dispatch-action: unknown action %s'" $action
            ;;
		esac
	}
}

}
