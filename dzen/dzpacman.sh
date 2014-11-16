#!/bin/sh
source ~/dotfiles/theme.sh
numupdates=$( pacman -Qu | wc -l )
color=$on
if [ $numupdates -eq 0 ]; then 
   color=$off
fi
printf "^fg($color)^i(/home/ben/dotfiles/dzen/icons/pacman.xbm) $numupdates^fg()"
