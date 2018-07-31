# dvtm.kak
#
# Support for dvtm, the dynamic virtual terminal manager

define-command dvtm-focus -params ..1 -docstring "Focus the given client window. \
	If no window is given, focuses the current client" %{
	%sh{
       	if [ $# -eq 1 ]; then
            printf %s\\n "evaluate-commands -client '$1' focus"
        elif [ -n "${kak_client_env_DVTM_CMD_FIFO}" ]; then
    		echo "focus $kak_client_env_DVTM_WINDOW_ID" >$kak_client_env_DVTM_CMD_FIFO
        fi
	}
}

define-command dvtm-new %{
	%sh{
		echo "create 'kak -c ${kak_session}'" >$DVTM_CMD_FIFO
	}
}

evaluate-commands  %sh{
	if [ "$DVTM" ] && [ "$DVTM_CMD_FIFO" ]; then
		printf %s\\n "alias global focus dvtm-focus"
		printf %s\\n "alias global new dvtm-new"
	fi
}
