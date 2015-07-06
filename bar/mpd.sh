#!/bin/sh
. ~/dotfiles/bar/base.sh
np=$( mpc current )
color=$green
if [[ -z $np ]]; then
    np="---"
    color=$off
fi
show_item $color ~/dotfiles/dzen/icons/note.xbm "$np"
