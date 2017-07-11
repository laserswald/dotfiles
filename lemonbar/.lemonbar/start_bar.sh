#!/bin/sh

font="Fira Mono:pixelsize=10"
symbolfont="Siji:pixelsize=10"

left=""
middle="time"
right="wifi batt"

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

bar_refresh &

while true
do
    line="$(tail -1 $PANEL_FIFO)"
    echo "$line" >> ~/panel.log
    if [ "$line" != "" ]
    then
        stat="$line "
    fi
    echo "$stat$(construct_items $left)%{c}$(construct_items $middle)%{r}$(construct_items $right)"
done \
     | lemonbar -f "$font" -f "$symbolfont"  \
     | while read ln; do eval "$ln"; done


