#!/bin/sh
while true; do
    buffer=""

    # buffer="${buffer} $(~/.lemonbar/inbox.sh)"
    buffer="${buffer} $(~/.lemonbar/batt.sh)"
    # buffer="${buffer} $(~/.lemonbar/pacman.sh)"
    # buffer="${buffer} $(~/.lemonbar/vol.sh)"
#    buffer="${buffer} %{r} $(~/.lemonbar/mcstatus.sh)"
    buffer="${buffer} $(~/.lemonbar/wifi.sh)"
    buffer="${buffer} $(~/.lemonbar/group.sh)"
#    buffer="${buffer} $(~/.lemonbar/mpd.sh)"
    # buffer="${buffer} $(~/.lemonbar/todo.sh)"
    buffer="${buffer} $(~/.lemonbar/time.sh)"
    echo $buffer
done
