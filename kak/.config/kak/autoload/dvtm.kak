# dvtm.kak
#
# Support for dvtm, the dynamic virtual terminal manager

hook global KakBegin .* %{
    %sh{
    	if [ -n "$DVTM" ] && [ -f "$DVTM_CTL_FIFO" ]; then
    		echo "alias global focus dvtm-focus"
    		echo "alias global new dvtm-new"
    	fi
    }
}

define-command dvtm-focus -allow-override -params ..1 -docstring "Focus the given client" %{
	%sh{
       	if [ $# -eq 1 ]; then
            printf %s\\n "evaluate-commands -client '$1' focus"
        elif [ -n "${kak_client_env_DVTM_CTL_FIFO}" ]; then
    		echo "focus $kak_client_env_DVTM_WINDOW_ID" >$kak_client_env_DVTM_CTL_FIFO
        fi
	}
}

define-command dvtm-new -allow-override %{
	%sh{
		echo "create 'kak -c ${kak_session}'" >$DVTM_CTL_FIFO
	}
}

