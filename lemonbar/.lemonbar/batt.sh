#!/bin/sh
source ~/.lemonbar/base.sh

battnum=$(acpi | cut -d "," -f2 | sed -e "s/%//" | sed -e "s/ //")
crit=10
low=25
med=50
hi=75

criticon=""
lowicon=""
medicon=""
hiicon=""

battcolor=$(tcolor blue)

if [[ $battnum -le $crit ]]; then 
    icon=$criticon
    battcolor=$(tcolor red)
elif [[ $battnum -le $low ]]; then
    icon=$lowicon
    battcolor=$(tcolor yellow)
elif [[ $battnum -le $med ]]; then
    icon=$medicon
    battcolor=$(tcolor green)
else
    icon=$hiicon
fi

$(acpi | grep -q Charging) && icon=""

show_icon $battcolor "$icon $battnum%"

