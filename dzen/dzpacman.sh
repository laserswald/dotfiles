#!/bin/sh
source ~/dotfiles/theme.sh
pacmancolor=$yellow
numupdates=$( pacman -Qu | wc -l )
color=$on
if [ $numupdates -eq 0 ]; then 
   color=$off
fi
printf "^fg($base04)^bg($color) ^i(/home/ben/dotfiles/dzen/icons/pacman.xbm) ^bg() $numupdates^fg()"
