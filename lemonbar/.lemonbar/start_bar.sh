#!/bin/sh

font="-*-tamzen-medium-*-*-*-12-*-*-*-*-*-*-*"
symbolfont="-*-siji-*-*-*-*-*-*-*-*-*-*-*-*"

left="group todo"
middle="time"
right="pacman browser"

## Go through each panel component and execute it.
construct_items() {
    all=""
    for component in $@
    do
        cmpfile=$("$HOME/.lemonbar/components/${component}.sh")
        all="${all}${cmpfile}"
    done
    echo "$all"
}

bar_refresh () {
    while true
    do
        echo "" >> $PANEL_FIFO
        sleep 1
    done
}

## Handler for signals
on_kill() {
    pkill lemonbar
    exit 0
}

trap "on_kill" SIGTERM SIGKILL SIGHUP SIGQUIT

while true
do
    # line="$(tail -1 $PANEL_FIFO)"
    # echo "$line" >> ~/panel.log
    # if [ "$line" != "" ]
    # then
    #     stat="$line "
    # fi

    echo "$(construct_items $left)%{c}$(construct_items $middle)%{r}$(construct_items $right)"
done \
     | lemonbar -d -f $font -f $symbolfont -B `tcolor background` -F `tcolor foreground`\
     | while read ln; do eval "$ln"; done


