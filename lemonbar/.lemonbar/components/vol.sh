#!/bin/sh
. ~/.lemonbar/base.sh
volpercent=$( amixer sget Master | grep "dB" | sed "s/.*\[\([0-9].*\)%\].*/\1/" )

show_icon_text $magenta "" $volpercent
