#!/bin/sh

wd=$(dirname $0)

fifo="$HOME/panel-fifo"

lemonfifo_periodic () {
    while true
    do
        if [ "$stopping" ]; then
            break
        fi
        echo "" >> "$fifo"
        sleep 1
    done
}

trap "lemonfifo_stop" SIGTERM

if [[ -e "$fifo" ]]; then
    rm "$fifo"
fi
mkfifo "$fifo"

$wd/listener.sh &

lemonfifo_periodic

