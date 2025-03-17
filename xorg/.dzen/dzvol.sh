#!/bin/sh
source ~/dotfiles/dzen/dzbase.sh
volpercent=$( amixer sget Master | grep "Front Left:" | sed "s/.*\[\([0-9].*\)%\].*/\1/" )

show_item $magenta /home/ben/dotfiles/dzen/icons/spkr_03.xbm $volpercent
