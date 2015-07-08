#!/bin/sh
. ~/dotfiles/bar/base.sh
volpercent=$( amixer sget Master | grep "Front Left:" | sed "s/.*\[\([0-9].*\)%\].*/\1/" )

show_item $magenta "" $volpercent
