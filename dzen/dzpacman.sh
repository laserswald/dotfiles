#!/bin/sh
source ~/dotfiles/theme.sh

numupdates=$( pacman -Sy; pacman -Qu | wc -l )
if [ $numupdates -eq 0 ]; then 
    echo "^fg($blue)0 updates.^fg()"
elif [ $numupdates -eq 1 ]; then
    echo "^fg($yellow)1 update.^fg()"
else
    echo "^fg($yellow)$numupdates updates.^fg()"
fi

