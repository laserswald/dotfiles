#!/bin/sh
while true; do 
    buffer="%{S1}"
    buffer="${buffer} $(~/dotfiles/bar/todo.sh)"
#    buffer="${buffer} %{r} $(~/dotfiles/bar/mcstatus.sh)"
    buffer="${buffer} %{r}$(~/dotfiles/bar/mpd.sh)"
    buffer="${buffer} $(~/dotfiles/bar/time.sh)"
    buffer="${buffer} %{S0}"
    buffer="${buffer} %{r}$(~/dotfiles/bar/inbox.sh)"
    buffer="${buffer} $(~/dotfiles/bar/pacman.sh)"
    buffer="${buffer} $(~/dotfiles/bar/vol.sh)"
    echo $buffer
    sleep 1
done
