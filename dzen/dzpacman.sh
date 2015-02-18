#!/bin/sh
source ~/dotfiles/theme.sh
source ~/dotfiles/dzen/dzbase.sh
numupdates=$( pacman -Qu | wc -l )
color=$yellow
if [ $numupdates -eq 0 ]; then 
   color=$off
fi
show_item $color /home/ben/dotfiles/dzen/icons/pacman.xbm $numupdates
