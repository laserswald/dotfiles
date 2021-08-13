
define-command suspend-and-resume \
    -override \
    -params 1..2 \
    -docstring 'suspend-and-resume <cli command> [<kak command after resume>]: backgrounds current kakoune client and runs specified cli command.  Upon exit of command the optional kak command is executed. ' \
    %{ evaluate-commands %sh{

    # Note we are adding '&& fg' which resumes the kakoune client process after the cli command exits
    cli_cmd="$1 && fg"
    post_resume_cmd="$2"

    # automation is different platform to platform
    platform=$(uname -s)

    # Send the keys command
    if [ "$TMUX" ]; then
        automate_cmd="/usr/bin/sleep 0.01; tmux send-keys '$cli_cmd' Enter"
    else
        case $platform in
            Darwin) automate_cmd="sleep 0.01; osascript -e 'tell application \"System Events\" to keystroke \"$cli_cmd\\n\" '" ;;
            Linux) automate_cmd="/usr/bin/sleep 0.5; xdotool type '$cli_cmd'; xdotool key Return" ;;
        esac
    fi

    # Stop the client command
    case $platform in
        Darwin) kill_cmd="/bin/kill" ;;
        Linux) kill_cmd="/usr/bin/kill" ;;
    esac


    # Uses platforms automation to schedule the typing of our cli command
    nohup sh -c "$automate_cmd"  > /dev/null 2>&1 &
    # Send kakoune client to the background
    $kill_cmd -SIGTSTP $kak_client_pid

    # ...At this point the kakoune client is paused until the " && fg " gets run in the $automate_cmd

    # Upon resume, run the kak command is specified
    if [ ! -z "$post_resume_cmd" ]; then
        sleep 0.1
        echo "$post_resume_cmd"
    fi
}}

define-command for-each-line \
    -override \
    -docstring "for-each-line <command> <path to file>: run command with the value of each line in the file" \
    -params 2 \
    %{ evaluate-commands %sh{

    # Wait for file to be ready
    while [ ! -f "$2" ]; do
	    :
    done

    while read f; do
        printf "$1 $f\n"
    done < "$2"
}}

define-command toggle-ranger -override %{
    evaluate-commands %sh{
	    file="$TMPDIR/ranger-files-$kak_client_pid"
	    [ -f "$file" ] && rm $file
	    rangercmd="ranger --choosefiles=$file"
	    foreachcmd="for-each-line edit '$file'"
	    printf %s\\n "suspend-and-resume %{$rangercmd} %{$foreachcmd}"
	}
}

map global user r ': toggle-ranger<ret>' -docstring 'select files in ranger'
