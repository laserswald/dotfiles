#!/bin/sh
while true; do 
    buffer="%{S1}"
    buffer="${buffer} na:$(~/dotfiles/bar/todo.sh)"
    buffer="${buffer} %{r} srv:$(~/dotfiles/bar/mcstatus.sh)"
    buffer="${buffer} mpd:$(~/dotfiles/bar/mpd.sh)"
    buffer="${buffer} $(~/dotfiles/bar/time.sh)"
    buffer="${buffer} %{S0}"
    buffer="${buffer} mail:$(~/dotfiles/bar/inbox.sh)"
    buffer="${buffer} pacman:$(~/dotfiles/bar/pacman.sh)"
    buffer="${buffer} volume:$(~/dotfiles/bar/vol.sh)"
    echo $buffer
    sleep 1
done
