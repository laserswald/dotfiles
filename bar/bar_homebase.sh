#!/bin/sh
while true; do 
    buffer=""
    buffer="${buffer} %{S1}"
    buffer="${buffer} $(~/etc/bar/inbox.sh)"
    #buffer="${buffer} $(~/etc/bar/batt.sh)"
    buffer="${buffer} $(~/etc/bar/pacman.sh)"
    buffer="${buffer} $(~/etc/bar/vol.sh)"
    #buffer="${buffer} %{r} $(~/etc/bar/mcstatus.sh)"
    buffer="${buffer} %{c}"
    buffer="${buffer} $(~/etc/bar/todo.sh)"
    buffer="${buffer} %{r}"
    #buffer="${buffer} $(~/etc/bar/wifi.sh)"
    buffer="${buffer} $(~/etc/bar/mpd.sh)"
    buffer="${buffer} $(~/etc/bar/time.sh)"
    echo $buffer
    sleep 1
done
