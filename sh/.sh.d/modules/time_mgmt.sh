# Time management module.

POMO_RECORD="$HOME/org/punchclock.txt"

clct (){
}

start_time() {
    echo "Started '$1' at $(date)" >> $POMO_RECORD
}

end_time() {
    echo "Finished '$1' at $(date)" >> $POMO_RECORD
}


pomo (){
    start_time
    sleep $((10))
    notify-send "Pomodoro" "Pomodoro done!"
    sleep $((2))
    notify-send "Pomodoro" "Breaktime's over."
}

