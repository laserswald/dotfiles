#!/bin/sh

stopping=""

stop_listening () {
    stopping=1
}

listen () {
    while true
    do
        if [ "$stopping" ]; then
            break
        fi
        line="$(tail -1 $fifo)"
        if [ "$line" != "" ]; then
            current="$line"
        fi
        echo "$current $(date)"
    done
}
