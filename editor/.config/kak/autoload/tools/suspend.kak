
define-command suspend-and-resume \
    -override \
    -params 1..2 \
    -docstring 'suspend-and-resume <cli command> [<kak command after resume>]: backgrounds current kakoune client and runs specified cli command.  Upon exit of command the optional kak command is executed. ' \
    %{ evaluate-commands %sh{

    # Note we are adding '&& fg' which resumes the kakoune client process after the cli command exits
    cli_cmd="$1;fg"
    post_resume_cmd="$2"

    # automation is different platform to platform
    platform=$(uname -s)

    # Send the keys command
    if [ "$TMUX" ]
    then
        automate_cmd="/usr/bin/sleep 1; tmux send-keys \"$cli_cmd\"; tmux send-keys Enter"
    else
        case $platform
        in
            Darwin) automate_cmd="sleep 0.01; osascript -e 'tell application \"System Events\" to keystroke \"$cli_cmd\\n\" '" ;;
            Linux)
			    if ! [ -z "$WAYLAND_DISPLAY" ]
			    then
				    printf %s\\n "echo -debug 'We are wayland'"
			        linux_type_cmd="wtype"
			        linux_ret="wtype -k Return"
			    else
				    printf %s\\n "echo -debug 'We are xorg'"
			        linux_type_cmd="xdotool type"
			        linux_ret="xdotool key Return"
			    fi
				automate_cmd="/usr/bin/sleep 0.5; $linux_type_cmd '$cli_cmd'; $linux_ret"
				;;
		esac
    fi

    # Stop the client command
    case $platform
    in
        Darwin) kill_cmd="/bin/kill" ;;
        Linux) kill_cmd="/usr/bin/kill" ;;
    esac

    # Uses platforms automation to schedule the typing of our cli command

    printf %s\\n "echo -debug Suspend command: %{$automate_cmd}"
    nohup sh -c "$automate_cmd" >/dev/null 2>&1 &

    # Send kakoune client to the background
    printf %s\\n "echo -debug stopping: %{$kak_client_pid}"
    kill -TSTP $kak_client_pid

    # ...At this point the kakoune client is paused until the " && fg " gets run in the $automate_cmd

    # Upon resume, run the kak command is specified
    printf %s\\n "echo -debug Resume command: %{$post_resume_cmd}"
    if ! [ -z "$post_resume_cmd" ]
    then
	    echo "$post_resume_cmd" > $kak_command_fifo
    fi
}}

define-command for-each-line \
    -override \
    -docstring "for-each-line <command> <path to file>: run command with the value of each line in the file" \
    -params 2 \
    %{ evaluate-commands %sh{

    # Wait for file to be ready
    while ! [ -f "$2" ]
    do
	    :
    done

    cat "$2" | while read f
    do
        printf %s\\n "echo -debug $1 %{$f}"
        printf %s\\n "$1 %{$f}"
    done
    # rm "$2"
}}

define-command toggle-ranger -override %{
    evaluate-commands %sh{
	    file="$TMPDIR/ranger-files-$kak_client_pid"
	    [ -f "$file" ] && rm $file

	    rangercmd="ranger --choosefiles=$file"
	    foreachcmd="for-each-line edit $file"

	    printf %s\\n "suspend-and-resume %{$rangercmd} %{$foreachcmd}"
	}
}

define-command \
	    -override \
toggle-nnn %{
    evaluate-commands %sh{
	    file="$TMPDIR/kak-nnn-$kak_client_pid"
	    [ -f "$file" ] && rm $file
	    # touch $file

	    # start_at_file=$kak_quoted_buffile
	    # if echo "$start_at_file" | grep -q '^\*'
	    # then
	    #     start_at_file=
	    # fi

	    fmcmd="nnn -oe -p $file"
	    foreachcmd="for-each-line edit $file"

	    printf %s\\n "suspend-and-resume %{$fmcmd} %{$foreachcmd}"
	}
}

# map global normal <minus> ': toggle-nnn<ret>' -docstring 'select files in ranger'
