#!/bin/sh
source ~/etc/bar/base.sh

battnum=$(acpi | cut -d "," -f2 | sed -e "s/%//" | sed -e "s/ //")
crit=10
low=25
med=50
hi=75

criticon=""
lowicon=""
medicon=""
hiicon=""

battcolor=$blue

if [[ $battnum -le $crit ]]; then 
    icon=$criticon
    battcolor=$red
elif [[ $battnum -le $low ]]; then
    icon=$lowicon
    battcolor=$yellow
elif [[ $battnum -le $med ]]; then
    icon=$medicon
    battcolor=$green
else
    icon=$hiicon
fi

test $(acpi | grep -q Discharging) || icon=""

show_icon $battcolor "$icon $battnum"

