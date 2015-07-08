#!/bin/sh
. ~/dotfiles/bar/base.sh
. ~/dotfiles/bar/base.sh
numupdates=$( pacman -Qu | wc -l )
color=$yellow
if [ $numupdates -eq 0 ]; then 
   color=$off
fi
show_item $color "" $numupdates
