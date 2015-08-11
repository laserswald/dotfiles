#!/bin/sh
. ~/etc/bar/base.sh
numupdates=$( checkupdates | wc -l )
color=$yellow
if [ $numupdates -eq 0 ]; then 
   color=$grey
fi
show_icon_text $color "" $numupdates
