#!/bin/sh
source ~/dotfiles/theme.sh

numupdates=$( pacman -Sy; pacman -Qu | wc -l )
color=$yellow
if [ $numupdates -eq 0 ]; then 
   color=$blue 
fi
printf "^fg($color)^i(/home/ben/dotfiles/dzen/sm4tik-icon-pack/xbm/pacman.xbm) $numupdates^fg()"
