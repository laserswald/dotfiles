#!/bin/sh
. ~/.lemonbar/base.sh
numupdates=$( checkupdates | wc -l )
color=$(tcolor yellow)
if [ $numupdates -eq 0 ]; then 
    color=$(tcolor grey)
fi
show_icon_text $color "" $numupdates
